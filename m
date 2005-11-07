Return-Path: <SRS0+b070d120c301b1432305+806+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1255E686B4
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2005 21:04:22 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 10:04:17 +0000
Message-Id: <1131357857.27347.28.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The probe at random I/O locations for 8250 serial ports makes my SMP G4
very unhappy. Theoretically it's supposed to catch the machine check and
recover, but that doesn't actually work very reliably -- the machine
often just locks up hard instead.

This makes ppc32 use the same code for locating 8250 serial ports in the
device tree as ppc64 already uses, and hence makes it refrain from
poking at non-existent ports.

This fairly much obsoletes include/asm-ppc/pc_serial.h -- other machines
with 8250 ports which are currently responsible for the mess in
include/asm-ppc/serial.h itself should be converted to a platform_device
of their own before they become supported in arch/powerpc.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -31,8 +31,6 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/unistd.h>
-#include <linux/serial.h>
-#include <linux/serial_8250.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -51,7 +49,6 @@
 #include <asm/system.h>
 #include <asm/rtas.h>
 #include <asm/iommu.h>
-#include <asm/serial.h>
 #include <asm/cache.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -713,187 +710,6 @@ void ppc64_terminate_msg(unsigned int sr
 	printk("[terminate]%04x %s\n", src, msg);
 }
 
-#ifndef CONFIG_PPC_ISERIES
-/*
- * This function can be used by platforms to "find" legacy serial ports.
- * It works for "serial" nodes under an "isa" node, and will try to
- * respect the "ibm,aix-loc" property if any. It works with up to 8
- * ports.
- */
-
-#define MAX_LEGACY_SERIAL_PORTS	8
-static struct plat_serial8250_port serial_ports[MAX_LEGACY_SERIAL_PORTS+1];
-static unsigned int old_serial_count;
-
-void __init generic_find_legacy_serial_ports(u64 *physport,
-		unsigned int *default_speed)
-{
-	struct device_node *np;
-	u32 *sizeprop;
-
-	struct isa_reg_property {
-		u32 space;
-		u32 address;
-		u32 size;
-	};
-	struct pci_reg_property {
-		struct pci_address addr;
-		u32 size_hi;
-		u32 size_lo;
-	};                                                                        
-
-	DBG(" -> generic_find_legacy_serial_port()\n");
-
-	*physport = 0;
-	if (default_speed)
-		*default_speed = 0;
-
-	np = of_find_node_by_path("/");
-	if (!np)
-		return;
-
-	/* First fill our array */
-	for (np = NULL; (np = of_find_node_by_type(np, "serial"));) {
-		struct device_node *isa, *pci;
-		struct isa_reg_property *reg;
-		unsigned long phys_size, addr_size, io_base;
-		u32 *rangesp;
-		u32 *interrupts, *clk, *spd;
-		char *typep;
-		int index, rlen, rentsize;
-
-		/* Ok, first check if it's under an "isa" parent */
-		isa = of_get_parent(np);
-		if (!isa || strcmp(isa->name, "isa")) {
-			DBG("%s: no isa parent found\n", np->full_name);
-			continue;
-		}
-		
-		/* Now look for an "ibm,aix-loc" property that gives us ordering
-		 * if any...
-		 */
-	 	typep = (char *)get_property(np, "ibm,aix-loc", NULL);
-
-		/* Get the ISA port number */
-		reg = (struct isa_reg_property *)get_property(np, "reg", NULL);	
-		if (reg == NULL)
-			goto next_port;
-		/* We assume the interrupt number isn't translated ... */
-		interrupts = (u32 *)get_property(np, "interrupts", NULL);
-		/* get clock freq. if present */
-		clk = (u32 *)get_property(np, "clock-frequency", NULL);
-		/* get default speed if present */
-		spd = (u32 *)get_property(np, "current-speed", NULL);
-		/* Default to locate at end of array */
-		index = old_serial_count; /* end of the array by default */
-
-		/* If we have a location index, then use it */
-		if (typep && *typep == 'S') {
-			index = simple_strtol(typep+1, NULL, 0) - 1;
-			/* if index is out of range, use end of array instead */
-			if (index >= MAX_LEGACY_SERIAL_PORTS)
-				index = old_serial_count;
-			/* if our index is still out of range, that mean that
-			 * array is full, we could scan for a free slot but that
-			 * make little sense to bother, just skip the port
-			 */
-			if (index >= MAX_LEGACY_SERIAL_PORTS)
-				goto next_port;
-			if (index >= old_serial_count)
-				old_serial_count = index + 1;
-			/* Check if there is a port who already claimed our slot */
-			if (serial_ports[index].iobase != 0) {
-				/* if we still have some room, move it, else override */
-				if (old_serial_count < MAX_LEGACY_SERIAL_PORTS) {
-					DBG("Moved legacy port %d -> %d\n", index,
-					    old_serial_count);
-					serial_ports[old_serial_count++] =
-						serial_ports[index];
-				} else {
-					DBG("Replacing legacy port %d\n", index);
-				}
-			}
-		}
-		if (index >= MAX_LEGACY_SERIAL_PORTS)
-			goto next_port;
-		if (index >= old_serial_count)
-			old_serial_count = index + 1;
-
-		/* Now fill the entry */
-		memset(&serial_ports[index], 0, sizeof(struct plat_serial8250_port));
-		serial_ports[index].uartclk = clk ? *clk : BASE_BAUD * 16;
-		serial_ports[index].iobase = reg->address;
-		serial_ports[index].irq = interrupts ? interrupts[0] : 0;
-		serial_ports[index].flags = ASYNC_BOOT_AUTOCONF;
-
-		DBG("Added legacy port, index: %d, port: %x, irq: %d, clk: %d\n",
-		    index,
-		    serial_ports[index].iobase,
-		    serial_ports[index].irq,
-		    serial_ports[index].uartclk);
-
-		/* Get phys address of IO reg for port 1 */
-		if (index != 0)
-			goto next_port;
-
-		pci = of_get_parent(isa);
-		if (!pci) {
-			DBG("%s: no pci parent found\n", np->full_name);
-			goto next_port;
-		}
-
-		rangesp = (u32 *)get_property(pci, "ranges", &rlen);
-		if (rangesp == NULL) {
-			of_node_put(pci);
-			goto next_port;
-		}
-		rlen /= 4;
-
-		/* we need the #size-cells of the PCI bridge node itself */
-		phys_size = 1;
-		sizeprop = (u32 *)get_property(pci, "#size-cells", NULL);
-		if (sizeprop != NULL)
-			phys_size = *sizeprop;
-		/* we need the parent #addr-cells */
-		addr_size = prom_n_addr_cells(pci);
-		rentsize = 3 + addr_size + phys_size;
-		io_base = 0;
-		for (;rlen >= rentsize; rlen -= rentsize,rangesp += rentsize) {
-			if (((rangesp[0] >> 24) & 0x3) != 1)
-				continue; /* not IO space */
-			io_base = rangesp[3];
-			if (addr_size == 2)
-				io_base = (io_base << 32) | rangesp[4];
-		}
-		if (io_base != 0) {
-			*physport = io_base + reg->address;
-			if (default_speed && spd)
-				*default_speed = *spd;
-		}
-		of_node_put(pci);
-	next_port:
-		of_node_put(isa);
-	}
-
-	DBG(" <- generic_find_legacy_serial_port()\n");
-}
-
-static struct platform_device serial_device = {
-	.name	= "serial8250",
-	.id	= PLAT8250_DEV_PLATFORM,
-	.dev	= {
-		.platform_data = serial_ports,
-	},
-};
-
-static int __init serial_dev_init(void)
-{
-	return platform_device_register(&serial_device);
-}
-arch_initcall(serial_dev_init);
-
-#endif /* CONFIG_PPC_ISERIES */
-
 int check_legacy_ioport(unsigned long base_port)
 {
 	if (ppc_md.check_legacy_ioport == NULL)
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -77,6 +77,11 @@ config SERIAL_8250_CS
 
 	  If unsure, say N.
 
+config SERIAL_8250_OF
+       bool
+       default y
+       depends on PPC_OF && SERIAL_8250
+
 config SERIAL_8250_ACPI
 	bool "8250/16550 device discovery via ACPI namespace"
 	default y if IA64
diff --git a/include/asm-ppc/pc_serial.h b/include/asm-ppc/pc_serial.h
--- a/include/asm-ppc/pc_serial.h
+++ b/include/asm-ppc/pc_serial.h
@@ -26,18 +26,4 @@
 #define RS_TABLE_SIZE  4
 #endif
 
-/* Standard COM flags (except for COM4, because of the 8514 problem) */
-#ifdef CONFIG_SERIAL_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
-#define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
-#else
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
-#define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
-#endif
-
-#define SERIAL_PORT_DFNS			\
-	/* UART CLK   PORT IRQ     FLAGS        */			\
-	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
-	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
-	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
-	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
+#define SERIAL_PORT_DFNS /* */
--- /dev/null	2005-10-08 11:44:47.528646500 +0100
+++ b/drivers/serial/8250_of.c	2005-11-07 09:51:22.000000000 +0000
@@ -0,0 +1,197 @@
+#include <linux/kernel.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/serial.h>
+#include <asm/prom.h>
+
+#if 0
+#define DBG(fmt...) printk(KERN_DEBUG fmt)
+#else
+#define DBG(fmt...) do { } while (0)
+#endif
+
+/*
+ * This function can be used by platforms to "find" legacy serial ports.
+ * It works for "serial" nodes under an "isa" node, and will try to
+ * respect the "ibm,aix-loc" property if any. It works with up to 8
+ * ports.
+ */
+
+#define MAX_LEGACY_SERIAL_PORTS	8
+static int ports_probed = 0;
+
+static struct plat_serial8250_port serial_ports[MAX_LEGACY_SERIAL_PORTS+1];
+static unsigned int old_serial_count;
+
+void __init generic_find_legacy_serial_ports(u64 *physport,
+		unsigned int *default_speed)
+{
+	struct device_node *np;
+	u32 *sizeprop;
+
+	struct isa_reg_property {
+		u32 space;
+		u32 address;
+		u32 size;
+	};
+
+	DBG(" -> generic_find_legacy_serial_port()\n");
+	ports_probed = 1;
+
+	*physport = 0;
+	if (default_speed)
+		*default_speed = 0;
+
+	np = of_find_node_by_path("/");
+	if (!np)
+		return;
+
+	/* First fill our array */
+	for (np = NULL; (np = of_find_node_by_type(np, "serial"));) {
+		struct device_node *isa, *pci;
+		struct isa_reg_property *reg;
+		unsigned long phys_size, addr_size;
+		u64 io_base;
+		u32 *rangesp;
+		u32 *interrupts, *clk, *spd;
+		char *typep;
+		int index, rlen, rentsize;
+
+		/* Ok, first check if it's under an "isa" parent */
+		isa = of_get_parent(np);
+		if (!isa || strcmp(isa->name, "isa")) {
+			DBG("%s: no isa parent found\n", np->full_name);
+			continue;
+		}
+
+		/* Now look for an "ibm,aix-loc" property that gives us ordering
+		 * if any...
+		 */
+	 	typep = (char *)get_property(np, "ibm,aix-loc", NULL);
+
+		/* Get the ISA port number */
+		reg = (struct isa_reg_property *)get_property(np, "reg", NULL);
+		if (reg == NULL)
+			goto next_port;
+		/* We assume the interrupt number isn't translated ... */
+		interrupts = (u32 *)get_property(np, "interrupts", NULL);
+		/* get clock freq. if present */
+		clk = (u32 *)get_property(np, "clock-frequency", NULL);
+		/* get default speed if present */
+		spd = (u32 *)get_property(np, "current-speed", NULL);
+		/* Default to locate at end of array */
+		index = old_serial_count; /* end of the array by default */
+
+		/* If we have a location index, then use it */
+		if (typep && *typep == 'S') {
+			index = simple_strtol(typep+1, NULL, 0) - 1;
+			/* if index is out of range, use end of array instead */
+			if (index >= MAX_LEGACY_SERIAL_PORTS)
+				index = old_serial_count;
+			/* if our index is still out of range, that mean that
+			 * array is full, we could scan for a free slot but that
+			 * make little sense to bother, just skip the port
+			 */
+			if (index >= MAX_LEGACY_SERIAL_PORTS)
+				goto next_port;
+			if (index >= old_serial_count)
+				old_serial_count = index + 1;
+			/* Check if there is a port who already claimed our slot */
+			if (serial_ports[index].iobase != 0) {
+				/* if we still have some room, move it, else override */
+				if (old_serial_count < MAX_LEGACY_SERIAL_PORTS) {
+					DBG("Moved legacy port %d -> %d\n", index,
+					    old_serial_count);
+					serial_ports[old_serial_count++] =
+						serial_ports[index];
+				} else {
+					DBG("Replacing legacy port %d\n", index);
+				}
+			}
+		}
+		if (index >= MAX_LEGACY_SERIAL_PORTS)
+			goto next_port;
+		if (index >= old_serial_count)
+			old_serial_count = index + 1;
+
+		/* Now fill the entry */
+		memset(&serial_ports[index], 0, sizeof(struct plat_serial8250_port));
+		serial_ports[index].uartclk = (clk && *clk) ? *clk : BASE_BAUD * 16;
+		serial_ports[index].iobase = reg->address;
+		serial_ports[index].irq = interrupts ? interrupts[0] : 0;
+		serial_ports[index].flags = ASYNC_BOOT_AUTOCONF;
+
+		DBG("Added legacy port, index: %d, port: %x, irq: %d, clk: %d\n",
+		    index,
+		    serial_ports[index].iobase,
+		    serial_ports[index].irq,
+		    serial_ports[index].uartclk);
+
+		/* Get phys address of IO reg for port 1 */
+		if (index != 0)
+			goto next_port;
+
+		pci = of_get_parent(isa);
+		if (!pci) {
+			DBG("%s: no pci parent found\n", np->full_name);
+			goto next_port;
+		}
+
+		rangesp = (u32 *)get_property(pci, "ranges", &rlen);
+		if (rangesp == NULL) {
+			of_node_put(pci);
+			goto next_port;
+		}
+		rlen /= 4;
+
+		/* we need the #size-cells of the PCI bridge node itself */
+		phys_size = 1;
+		sizeprop = (u32 *)get_property(pci, "#size-cells", NULL);
+		if (sizeprop != NULL)
+			phys_size = *sizeprop;
+		/* we need the parent #addr-cells */
+		addr_size = prom_n_addr_cells(pci);
+		rentsize = 3 + addr_size + phys_size;
+		io_base = 0;
+		for (;rlen >= rentsize; rlen -= rentsize,rangesp += rentsize) {
+			if (((rangesp[0] >> 24) & 0x3) != 1)
+				continue; /* not IO space */
+			io_base = rangesp[3];
+			if (addr_size == 2)
+				io_base = (io_base << 32) | rangesp[4];
+		}
+		if (io_base != 0) {
+			*physport = io_base + reg->address;
+			if (default_speed && spd)
+				*default_speed = *spd;
+		}
+		of_node_put(pci);
+	next_port:
+		of_node_put(isa);
+	}
+
+	DBG(" <- generic_find_legacy_serial_port()\n");
+}
+
+static struct platform_device serial_device = {
+	.name	= "serial8250",
+	.id	= PLAT8250_DEV_PLATFORM,
+	.dev	= {
+		.platform_data = serial_ports,
+	},
+};
+
+static int __init serial_dev_init(void)
+{
+	u64 phys;
+	unsigned int spd;
+
+	if (!ports_probed)
+		generic_find_legacy_serial_ports(&phys, &spd);
+	return platform_device_register(&serial_device);
+}
+arch_initcall(serial_dev_init);


-- 
dwmw2
