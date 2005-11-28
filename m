Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 11:25:00 +1100
Message-Id: <1133137500.7768.150.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: More serial probing fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Serial port detection code at boot needs a few more fixes, especially
to deal with MMIO based ports. Here they are. An additional patch to
the serial core is needed for a boot-time MMIO port to not conflict
with 8250_pci.c, that patch is reviewed separately by Russell King.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-serialfix/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- linux-serialfix.orig/arch/powerpc/kernel/legacy_serial.c	2005-11-28 11:18:08.000000000 +1100
+++ linux-serialfix/arch/powerpc/kernel/legacy_serial.c	2005-11-28 11:24:20.000000000 +1100
@@ -38,12 +38,15 @@ static int __init add_legacy_port(struct
 				  int iotype, phys_addr_t base,
 				  phys_addr_t taddr, unsigned long irq)
 {
-	u32 *clk, *spd, clock;
+	u32 *clk, *spd, clock = 0;
 	int index;
 
 	/* get clock freq. if present */
 	clk = (u32 *)get_property(np, "clock-frequency", NULL);
-	clock = clk ? *clk : BASE_BAUD * 16;
+	if (clk)
+		clock = *clk;
+	if (clock == 0)
+		clock = BASE_BAUD * 16;
 
 	/* get default speed if present */
 	spd = (u32 *)get_property(np, "current-speed", NULL);
@@ -85,7 +88,7 @@ static int __init add_legacy_port(struct
 	if (iotype == UPIO_PORT)
 		legacy_serial_ports[index].iobase = base;
 	else
-		legacy_serial_ports[index].membase = (void __iomem *)base;
+		legacy_serial_ports[index].mapbase = base;
 	legacy_serial_ports[index].iotype = iotype;
 	legacy_serial_ports[index].uartclk = clock;
 	legacy_serial_ports[index].irq = irq;
@@ -145,17 +148,17 @@ static int __init add_legacy_pci_port(st
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
@@ -180,7 +183,23 @@ static int __init add_legacy_pci_port(st
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
+	if (device_is_compatible(np, "pci13a8,152") ||
+	    device_is_compatible(np, "pci13a8,154") ||
+	    device_is_compatible(np, "pci13a8,158")) {
+		addrp += 0x200 * lindex;
+		base += 0x200 * lindex;
+	} else {
+		addrp += 8 * lindex;
+		base += 8 * lindex;
 	}
 
 	/* Add port, irq will be dealt with later. We passed a translated
@@ -261,7 +280,6 @@ void __init find_legacy_serial_ports(voi
 	DBG("legacy_serial_console = %d\n", legacy_serial_console);
 
 	/* udbg is 64 bits only for now, that will change soon though ... */
-#ifdef CONFIG_PPC64
 	while (legacy_serial_console >= 0) {
 		struct legacy_serial_info *info =
 			&legacy_serial_infos[legacy_serial_console];
@@ -278,7 +296,6 @@ void __init find_legacy_serial_ports(voi
 		udbg_init_uart(addr, info->speed, info->clock);
 		break;
 	}
-#endif /* CONFIG_PPC64 */
 
 	DBG(" <- find_legacy_serial_port()\n");
 }
@@ -340,6 +357,15 @@ static void __init fixup_port_pio(int in
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
@@ -374,6 +400,8 @@ static int __init serial_dev_init(void)
 			fixup_port_irq(i, np, port);
 		if (port->iotype == UPIO_PORT)
 			fixup_port_pio(i, np, port);
+		if (port->iotype == UPIO_MEM)
+			fixup_port_mmio(i, np, port);
 	}
 
 	DBG("Registering platform serial ports\n");
