Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 11:21:59 +1100
Message-Id: <1133223720.7768.239.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: More serial probe fixes (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes the new serial probe code with some PCI MMIO UARTs, and fixes
CHRP build with ARCH=powerpc.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/legacy_serial.c	2005-11-29 11:02:28.000000000 +1100
+++ linux-work/arch/powerpc/kernel/legacy_serial.c	2005-11-29 11:21:52.000000000 +1100
@@ -38,15 +38,13 @@ static int __init add_legacy_port(struct
 				  int iotype, phys_addr_t base,
 				  phys_addr_t taddr, unsigned long irq)
 {
-	u32 *clk, *spd, clock;
+	u32 *clk, *spd, clock = BASE_BAUD * 16;
 	int index;
 
 	/* get clock freq. if present */
 	clk = (u32 *)get_property(np, "clock-frequency", NULL);
 	if (clk && *clk)
 		clock = *clk;
-	else
-		clock = BASE_BAUD * 16;
 
 	/* get default speed if present */
 	spd = (u32 *)get_property(np, "current-speed", NULL);
@@ -88,7 +86,7 @@ static int __init add_legacy_port(struct
 	if (iotype == UPIO_PORT)
 		legacy_serial_ports[index].iobase = base;
 	else
-		legacy_serial_ports[index].membase = (void __iomem *)base;
+		legacy_serial_ports[index].mapbase = base;
 	legacy_serial_ports[index].iotype = iotype;
 	legacy_serial_ports[index].uartclk = clock;
 	legacy_serial_ports[index].irq = irq;
@@ -148,17 +146,17 @@ static int __init add_legacy_pci_port(st
 {
 	phys_addr_t addr, base;
 	u32 *addrp;
-	int iotype, index = -1;
+	int iotype, index = -1, lindex = 0;
 
-#if 0
 	/* We only support ports that have a clock frequency properly
 	 * encoded in the device-tree (that is have an fcode). Anything
 	 * else can't be used that early and will be normally probed by
-	 * the generic 8250_pci driver later on.
+	 * the generic 8250_pci driver later on. The reason is that 8250
+	 * compatible UARTs on PCI need all sort of quirks (port offsets
+	 * etc...) that this code doesn't know about
 	 */
 	if (get_property(np, "clock-frequency", NULL) == NULL)
 		return -1;
-#endif
 
 	/* Get the PCI address. Assume BAR 0 */
 	addrp = of_get_pci_address(pci_dev, 0, NULL);
@@ -183,7 +181,23 @@ static int __init add_legacy_pci_port(st
 	if (np != pci_dev) {
 		u32 *reg = (u32 *)get_property(np, "reg", NULL);
 		if (reg && (*reg < 4))
-			index = legacy_serial_count + *reg;
+			index = lindex = *reg;
+	}
+
+	/* Local index means it's the Nth port in the PCI chip. Unfortunately
+	 * the offset to add here is device specific. We know about those
+	 * EXAR ports and we default to the most common case. If your UART
+	 * doesn't work for these settings, you'll have to add your own special
+	 * cases here
+	 */
+	if (device_is_compatible(pci_dev, "pci13a8,152") ||
+	    device_is_compatible(pci_dev, "pci13a8,154") ||
+	    device_is_compatible(pci_dev, "pci13a8,158")) {
+		addr += 0x200 * lindex;
+		base += 0x200 * lindex;
+	} else {
+		addr += 8 * lindex;
+		base += 8 * lindex;
 	}
 
 	/* Add port, irq will be dealt with later. We passed a translated
@@ -264,7 +278,6 @@ void __init find_legacy_serial_ports(voi
 	DBG("legacy_serial_console = %d\n", legacy_serial_console);
 
 	/* udbg is 64 bits only for now, that will change soon though ... */
-#ifdef CONFIG_PPC64
 	while (legacy_serial_console >= 0) {
 		struct legacy_serial_info *info =
 			&legacy_serial_infos[legacy_serial_console];
@@ -281,7 +294,6 @@ void __init find_legacy_serial_ports(voi
 		udbg_init_uart(addr, info->speed, info->clock);
 		break;
 	}
-#endif /* CONFIG_PPC64 */
 
 	DBG(" <- find_legacy_serial_port()\n");
 }
@@ -343,6 +355,15 @@ static void __init fixup_port_pio(int in
 	}
 }
 
+static void __init fixup_port_mmio(int index,
+				   struct device_node *np,
+				   struct plat_serial8250_port *port)
+{
+	DBG("fixup_port_mmio(%d)\n", index);
+
+	port->membase = ioremap(port->mapbase, 0x100);
+}
+
 /*
  * This is called as an arch initcall, hopefully before the PCI bus is
  * probed and/or the 8250 driver loaded since we need to register our
@@ -377,6 +398,8 @@ static int __init serial_dev_init(void)
 			fixup_port_irq(i, np, port);
 		if (port->iotype == UPIO_PORT)
 			fixup_port_pio(i, np, port);
+		if (port->iotype == UPIO_MEM)
+			fixup_port_mmio(i, np, port);
 	}
 
 	DBG("Registering platform serial ports\n");
Index: linux-work/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/chrp/setup.c	2005-11-24 17:18:42.000000000 +1100
+++ linux-work/arch/powerpc/platforms/chrp/setup.c	2005-11-29 11:26:01.000000000 +1100
@@ -49,7 +49,6 @@
 #include <asm/hydra.h>
 #include <asm/sections.h>
 #include <asm/time.h>
-#include <asm/btext.h>
 #include <asm/i8259.h>
 #include <asm/mpic.h>
 #include <asm/rtas.h>
@@ -58,7 +57,6 @@
 #include "chrp.h"
 
 void rtas_indicator_progress(char *, unsigned short);
-void btext_progress(char *, unsigned short);
 
 int _chrp_type;
 EXPORT_SYMBOL(_chrp_type);
@@ -264,11 +262,6 @@ void __init chrp_setup_arch(void)
 		ppc_md.set_rtc_time	= rtas_set_rtc_time;
 	}
 
-#ifdef CONFIG_BOOTX_TEXT
-	if (ppc_md.progress == NULL && boot_text_mapped)
-		ppc_md.progress = btext_progress;
-#endif
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* this is fine for chrp */
 	initrd_below_start_ok = 1;
@@ -522,12 +515,3 @@ void __init chrp_init(void)
 	smp_ops = &chrp_smp_ops;
 #endif /* CONFIG_SMP */
 }
-
-#ifdef CONFIG_BOOTX_TEXT
-void
-btext_progress(char *s, unsigned short hex)
-{
-	btext_drawstring(s);
-	btext_drawstring("\n");
-}
-#endif /* CONFIG_BOOTX_TEXT */
