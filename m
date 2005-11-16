Return-Path: <SRS0+ad27384f2800be9504ce+815+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 074896872D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2005 21:26:08 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17274.63508.501761.748278@cargo.ozlabs.ibm.com>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107165453.GA29111@lst.de>
	<1131382971.27347.79.camel@baythorne.infradead.org>
	<1132131116.28963.75.camel@baythorne.infradead.org>
	<17274.63508.501761.748278@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 10:25:55 +0000
Message-Id: <1132136755.21643.40.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-11-16 at 20:12 +1100, Paul Mackerras wrote:
> Yes, it works on newworld (at least it does on my G4 powerbook).  It
> should work on 32-bit CHRP with any luck, but for oldworld we'll have
> to generate a COFF file.

I'll try it on Pegasos some time tonight or tomorrow. AFAICT I'm going
to need the patch which started this thread, if I want any serial ports
on my Pegasos. The newly-created asm-powerpc/serial.h file is devoid of
serial port definitions.

Here it is again, with Tom's three criticisms addressed, deliberately
ignored, and addressed. In that order.

It no longer touches asm-ppc/serial.h, so doesn't break the legacy
zImage.

---
[PATCH] Fix 8250 probe on ppc32

There are no serial ports defined in the new asm-powerpc/serial.h, and
rightly so. The 64-bit setup code has a routine to look in the device
tree for them and register a platform_device for any we find there; this
patch steals that routine and makes it available on 32-bit machines
too...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- linux-2.6.14/drivers/serial/Makefile~	2005-11-07 22:17:27.000000000 -0500
+++ linux-2.6.14/drivers/serial/Makefile	2005-11-07 22:17:35.000000000 -0500
@@ -22,6 +22,7 @@ obj-$(CONFIG_SERIAL_8250_ACCENT) += 8250
 obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_HUB6) += 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_MCA) += 8250_mca.o
+obj-$(CONFIG_SERIAL_8250_OF) += 8250_of.o
 obj-$(CONFIG_SERIAL_8250_AU1X00) += 8250_au1x00.o
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
--- linux-2.6.13/drivers/serial/8250_of.c.sof	2005-10-20 13:19:07.000000000 +0100
+++ linux-2.6.13/drivers/serial/8250_of.c	2005-10-20 13:19:26.000000000 +0100
@@ -0,0 +1,206 @@
+/* 
+ * Search OpenFirmware device tree for 8250-compatible serial ports 
+ * 
+ * Moved from arch/powerpc/kernel/setup_64.c:
+ *
+ *	Copyright (C) 2001 PPC64, IBM Corp
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#undef DEBUG
+
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
+	pr_debug(" -> generic_find_legacy_serial_port()\n");
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
+			pr_debug("%s: no isa parent found\n", np->full_name);
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
+					pr_debug("Moved legacy port %d -> %d\n", index,
+					    old_serial_count);
+					serial_ports[old_serial_count++] =
+						serial_ports[index];
+				} else {
+					pr_debug("Replacing legacy port %d\n", index);
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
+		pr_debug("Added legacy port, index: %d, port: %x, irq: %d, clk: %d\n",
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
+			pr_debug("%s: no pci parent found\n", np->full_name);
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
+	pr_debug(" <- generic_find_legacy_serial_port()\n");
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
--- linux-2.6.13/drivers/serial/Kconfig.sof	2005-10-20 12:54:48.000000000 +0100
+++ linux-2.6.13/drivers/serial/Kconfig	2005-10-20 13:05:39.000000000 +0100
@@ -77,6 +77,11 @@ config SERIAL_8250_CS
 
 	  If unsure, say N.
 
+config SERIAL_8250_OF
+       bool
+       default y
+       depends on PPC_OF && SERIAL_8250 && PPC_MERGE
+
 config SERIAL_8250_ACPI
 	bool "8250/16550 device discovery via ACPI namespace"
 	default y if IA64
--- linux-2.6.13/arch/powerpc/kernel/setup_64.c.sof	2005-10-20 13:13:08.000000000 +0100
+++ linux-2.6.13/arch/powerpc/kernel/setup_64.c	2005-10-20 13:16:28.000000000 +0100
@@ -31,8 +31,6 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/unistd.h>
-#include <linux/serial.h>
-#include <linux/serial_8250.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -52,7 +50,6 @@
 #include <asm/system.h>
 #include <asm/rtas.h>
 #include <asm/iommu.h>
-#include <asm/serial.h>
 #include <asm/cache.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -1104,187 +1101,6 @@ void __init setup_default_decr(void)
 	lpaca->next_jiffy_update_tb = get_tb() + tb_ticks_per_jiffy;
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



-- 
dwmw2
