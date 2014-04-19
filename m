Return-Path: <schivers@csc.com>
Received: from mail87.messagelabs.com (mail87.messagelabs.com [216.82.250.19])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A1E451400C6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Apr 2014 09:45:50 +1000 (EST)
Date: Sun, 20 Apr 2014 09:43:10 +1000
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: legacy_serial support MVME5100 UARTS with
 shifted registers
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20140419234310.DBC49E075A@canberra.localdomain>
From: schivers@csc.com (Stephen Chivers)
Cc: schivers@csc.com, linuxppc-dev@lists.ozlabs.org, cproctor@csc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support to legacy serial for
UARTS with shifted registers.

The MVME5100 Single Board Computer is a PowerPC platform
that has 16550 style UARTS with register addresses that are
16 bytes apart (shifted by 4).

Commit 	309257484cc1a592e8ac5fbdd8cd661be2b80bf8 
"powerpc: Cleanup udbg_16550 and add support for LPC PIO-only UARTs"
added support to udbg_16550 for shifted registers by adding a "stride"
parameter to the initialisation operations for Programmed IO and
Memory Mapped IO.

As a consequence it is now possible to use the services of legacy serial
to provide early serial console messages for the MVME5100.

An added benefit of this is that the serial console will always be
"ttyS0" irrespective of whether the computer is fitted with extra
PCI 8250 interface boards or not.

I have tested this patch using the four PowerPC platforms available to me:

	MVME5100 - shifted registers,
	SAM440EP - unshifted registers,
	MPC8349 - unshifted registers,
	MVME4100 - unshifted registers.

Signed-off-by: Stephen Chivers <schivers@csc.com>
---
 arch/powerpc/kernel/legacy_serial.c        |   21 +++++++++++++++------
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 40bd7bd..85fb16e 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -71,8 +71,9 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 				  phys_addr_t taddr, unsigned long irq,
 				  upf_t flags, int irq_check_parent)
 {
-	const __be32 *clk, *spd;
+	const __be32 *clk, *spd, *rs;
 	u32 clock = BASE_BAUD * 16;
+	u32 shift = 0;
 	int index;
 
 	/* get clock freq. if present */
@@ -83,6 +84,11 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 	/* get default speed if present */
 	spd = of_get_property(np, "current-speed", NULL);
 
+	/* get register shift if present */
+	rs = of_get_property(np, "reg-shift", NULL);
+	if (rs && *rs)
+		shift = be32_to_cpup(rs);
+
 	/* If we have a location index, then try to use it */
 	if (want_index >= 0 && want_index < MAX_LEGACY_SERIAL_PORTS)
 		index = want_index;
@@ -126,6 +132,7 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 	legacy_serial_ports[index].uartclk = clock;
 	legacy_serial_ports[index].irq = irq;
 	legacy_serial_ports[index].flags = flags;
+	legacy_serial_ports[index].regshift = shift;
 	legacy_serial_infos[index].taddr = taddr;
 	legacy_serial_infos[index].np = of_node_get(np);
 	legacy_serial_infos[index].clock = clock;
@@ -163,9 +170,8 @@ static int __init add_legacy_soc_port(struct device_node *np,
 	if (of_get_property(np, "clock-frequency", NULL) == NULL)
 		return -1;
 
-	/* if reg-shift or offset, don't try to use it */
-	if ((of_get_property(np, "reg-shift", NULL) != NULL) ||
-		(of_get_property(np, "reg-offset", NULL) != NULL))
+	/* if reg-offset don't try to use it */
+	if ((of_get_property(np, "reg-offset", NULL) != NULL))
 		return -1;
 
 	/* if rtas uses this device, don't try to use it as well */
@@ -315,17 +321,20 @@ static void __init setup_legacy_serial_console(int console)
 	struct legacy_serial_info *info = &legacy_serial_infos[console];
 	struct plat_serial8250_port *port = &legacy_serial_ports[console];
 	void __iomem *addr;
+	unsigned int stride;
+
+	stride = 1 << port->regshift;
 
 	/* Check if a translated MMIO address has been found */
 	if (info->taddr) {
 		addr = ioremap(info->taddr, 0x1000);
 		if (addr == NULL)
 			return;
-		udbg_uart_init_mmio(addr, 1);
+		udbg_uart_init_mmio(addr, stride);
 	} else {
 		/* Check if it's PIO and we support untranslated PIO */
 		if (port->iotype == UPIO_PORT && isa_io_special)
-			udbg_uart_init_pio(port->iobase, 1);
+			udbg_uart_init_pio(port->iobase, stride);
 		else
 			return;
 	}
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 2a7024d..a25f496 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -65,6 +65,7 @@ config MVME5100
 	select PPC_INDIRECT_PCI
 	select PPC_I8259
 	select PPC_NATIVE
+	select PPC_UDBG_16550
 	help
 	  This option enables support for the Motorola (now Emerson) MVME5100
 	  board.
