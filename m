Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0ACDDEFE3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:56 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1ZoOe027658
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:50 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZnK2001535
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:49 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1B8or007944
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:09 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id DF390AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:48 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1Zm9f015408
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:48 -0500
Date: Tue, 17 Jul 2007 20:35:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 37/61] cpm2: Rework 8272ads initialization,
	and eliminate init_fcc_ioports().
Message-ID: <20070718013548.GI15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mpc8272ads initialization is reworked to:

1. use cpm2_set_pin() and cpm2_clk_setup() instead of the hardcoded mess,
2. have a sane devtree binding for the BCSR,
3. set the BCSR bits needed for both ethernet ports to work,
4. support the early debug console, and
5. call of_platform_bus_probe(), for the forthcoming of-platform-ization
of the CPM drivers.

The init_fcc_ioports() call is no longer used.  CPM-based 85xx
is now broken until I can get a test machine, unless U-boot properly
sets up the I/O ports.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/82xx/mpc8272ads.c |  341 +++++++++---------------------
 arch/powerpc/sysdev/fsl_soc.c            |    3 -
 2 files changed, 105 insertions(+), 239 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc8272ads.c b/arch/powerpc/platforms/82xx/mpc8272ads.c
index 388b090..8187920 100644
--- a/arch/powerpc/platforms/82xx/mpc8272ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272ads.c
@@ -1,8 +1,10 @@
 /*
- * MPC8272ADS setup and early boot code plus other random bits.
+ * MPC8272ADS board support
  *
- * Author: Vitaly Bordug <vbordug@ru.mvista.com>
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ * Author: Scott Wood <scottwood@freescale.com>
  *
+ * Based on code by Vitaly Bordug <vbordug@ru.mvista.com>
  * Copyright (c) 2006 MontaVista Software, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -14,15 +16,11 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
-#include <linux/fs_uart_pd.h>
-#include <linux/fs_enet_pd.h>
 
 #include <asm/io.h>
-#include <asm/mpc8260.h>
 #include <asm/cpm2.h>
 #include <asm/udbg.h>
-#include <asm/i8259.h>
-#include <asm/prom.h>
+#include <asm/of_platform.h>
 #include <asm/machdep.h>
 #include <asm/time.h>
 
@@ -49,259 +47,108 @@ static void __init mpc8272ads_pic_init(void)
 	pq2ads_pci_init_irq();
 }
 
-static void init_fcc1_ioports(struct fs_platform_info *fpi)
-{
-	struct io_port *io;
-	u32 tempval;
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
-	struct device_node *np;
-	struct resource r;
-	u32 *bcsr;
-
-	np = of_find_node_by_type(NULL, "memory");
-	if (!np) {
-		printk(KERN_INFO "No memory node in device tree\n");
-		return;
-	}
-	if (of_address_to_resource(np, 1, &r)) {
-		printk(KERN_INFO "No memory reg property [1] in devicetree\n");
-		return;
-	}
-	of_node_put(np);
-	bcsr = ioremap(r.start + 4, sizeof(u32));
-	io = &immap->im_ioport;
-
-	/* Enable the PHY */
-	clrbits32(bcsr, BCSR1_FETHIEN);
-	setbits32(bcsr, BCSR1_FETH_RST);
-
-	/* FCC1 pins are on port A/C. */
-	/* Configure port A and C pins for FCC1 Ethernet. */
-
-	tempval = in_be32(&io->iop_pdira);
-	tempval &= ~PA1_DIRA0;
-	tempval |= PA1_DIRA1;
-	out_be32(&io->iop_pdira, tempval);
-
-	tempval = in_be32(&io->iop_psora);
-	tempval &= ~PA1_PSORA0;
-	tempval |= PA1_PSORA1;
-	out_be32(&io->iop_psora, tempval);
-
-	setbits32(&io->iop_ppara, PA1_DIRA0 | PA1_DIRA1);
+struct cpm_pin {
+	int port, pin, flags;
+};
 
-	/* Alter clocks */
-	tempval = PC_CLK(fpi->clk_tx - 8) | PC_CLK(fpi->clk_rx - 8);
+static struct cpm_pin mpc8272ads_pins[] = {
+	/* SCC1 */
+	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* SCC4 */
+	{3, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC1 */
+	{0, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 18, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 19, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 20, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 26, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 27, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 28, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 30, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 31, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{2, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC2 */
+	{1, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 20, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 25, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 26, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 27, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{1, 30, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+};
 
-	clrbits32(&io->iop_psorc, tempval);
-	clrbits32(&io->iop_pdirc, tempval);
-	setbits32(&io->iop_pparc, tempval);
+static void __init init_ioports(void)
+{
+	int i;
 
-	cpm2_clk_setup(CPM_CLK_FCC1, fpi->clk_rx, CPM_CLK_RX);
-	cpm2_clk_setup(CPM_CLK_FCC1, fpi->clk_tx, CPM_CLK_TX);
+	for (i = 0; i < ARRAY_SIZE(mpc8272ads_pins); i++) {
+		struct cpm_pin *pin = &mpc8272ads_pins[i];
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
+	}
 
-	iounmap(bcsr);
-	iounmap(immap);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC4, CPM_BRG4, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC4, CPM_BRG4, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK15, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK16, CPM_CLK_TX);
 }
 
-static void init_fcc2_ioports(struct fs_platform_info *fpi)
+static void __init mpc8272ads_setup_arch(void)
 {
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
 	struct device_node *np;
-	struct resource r;
 	u32 *bcsr;
 
-	struct io_port *io;
-	u32 tempval;
-
-	np = of_find_node_by_type(NULL, "memory");
-	if (!np) {
-		printk(KERN_INFO "No memory node in device tree\n");
-		return;
-	}
-	if (of_address_to_resource(np, 1, &r)) {
-		printk(KERN_INFO "No memory reg property [1] in devicetree\n");
-		return;
-	}
-	of_node_put(np);
-	io = &immap->im_ioport;
-	bcsr = ioremap(r.start + 12, sizeof(u32));
-
-	/* Enable the PHY */
-	clrbits32(bcsr, BCSR3_FETHIEN2);
-	setbits32(bcsr, BCSR3_FETH2_RST);
-
-	/* FCC2 are port B/C. */
-	/* Configure port A and C pins for FCC2 Ethernet. */
-
-	tempval = in_be32(&io->iop_pdirb);
-	tempval &= ~PB2_DIRB0;
-	tempval |= PB2_DIRB1;
-	out_be32(&io->iop_pdirb, tempval);
-
-	tempval = in_be32(&io->iop_psorb);
-	tempval &= ~PB2_PSORB0;
-	tempval |= PB2_PSORB1;
-	out_be32(&io->iop_psorb, tempval);
-
-	setbits32(&io->iop_pparb, PB2_DIRB0 | PB2_DIRB1);
-
-	tempval = PC_CLK(fpi->clk_tx - 8) | PC_CLK(fpi->clk_rx - 8);
-
-	/* Alter clocks */
-	clrbits32(&io->iop_psorc, tempval);
-	clrbits32(&io->iop_pdirc, tempval);
-	setbits32(&io->iop_pparc, tempval);
-
-	cpm2_clk_setup(CPM_CLK_FCC2, fpi->clk_rx, CPM_CLK_RX);
-	cpm2_clk_setup(CPM_CLK_FCC2, fpi->clk_tx, CPM_CLK_TX);
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8272ads_setup_arch()", 0);
 
-	iounmap(bcsr);
-	iounmap(immap);
-}
+	cpm2_reset();
 
-void init_fcc_ioports(struct fs_platform_info *fpi)
-{
-	int fcc_no = fs_get_fcc_index(fpi->fs_no);
-
-	switch (fcc_no) {
-	case 0:
-		init_fcc1_ioports(fpi);
-		break;
-	case 1:
-		init_fcc2_ioports(fpi);
-		break;
-	default:
-		printk(KERN_ERR "init_fcc_ioports: invalid FCC number\n");
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc8272ads-bcsr");
+	if (!np) {
+		printk(KERN_ERR "No bcsr in device tree\n");
 		return;
 	}
-}
 
-static void init_scc1_uart_ioports(struct fs_uart_platform_info *data)
-{
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
-
-	/* SCC1 is only on port D */
-	setbits32(&immap->im_ioport.iop_ppard, 0x00000003);
-	clrbits32(&immap->im_ioport.iop_psord, 0x00000001);
-	setbits32(&immap->im_ioport.iop_psord, 0x00000002);
-	clrbits32(&immap->im_ioport.iop_pdird, 0x00000001);
-	setbits32(&immap->im_ioport.iop_pdird, 0x00000002);
-
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 - data->clk_tx)));
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038 << (4 - data->clk_rx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_tx - 1) << (4 - data->clk_tx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_rx - 1) << (4 - data->clk_rx)));
-
-	iounmap(immap);
-}
-
-static void init_scc4_uart_ioports(struct fs_uart_platform_info *data)
-{
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
-
-	setbits32(&immap->im_ioport.iop_ppard, 0x00000600);
-	clrbits32(&immap->im_ioport.iop_psord, 0x00000600);
-	clrbits32(&immap->im_ioport.iop_pdird, 0x00000200);
-	setbits32(&immap->im_ioport.iop_pdird, 0x00000400);
-
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 - data->clk_tx)));
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038 << (4 - data->clk_rx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_tx - 1) << (4 - data->clk_tx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_rx - 1) << (4 - data->clk_rx)));
-
-	iounmap(immap);
-}
-
-void init_scc_ioports(struct fs_uart_platform_info *data)
-{
-	int scc_no = fs_get_scc_index(data->fs_no);
-
-	switch (scc_no) {
-	case 0:
-		init_scc1_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	case 3:
-		init_scc4_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	default:
-		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
+	bcsr = of_iomap(np, 0);
+	if (!bcsr) {
+		printk(KERN_INFO "Cannot map BCSR registers\n");
 		return;
 	}
-}
 
-void __init mpc8272ads_board_setup(void)
-{
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
-	struct device_node *np;
-	struct resource r;
-	u32 *bcsr;
-
-	np = of_find_node_by_type(NULL, "memory");
-	if (!np) {
-		printk(KERN_INFO "No memory node in device tree\n");
-		return;
-	}
-	if (of_address_to_resource(np, 1, &r)) {
-		printk(KERN_INFO "No memory reg property [1] in devicetree\n");
-		return;
-	}
 	of_node_put(np);
-	bcsr = ioremap(r.start + 4, sizeof(u32));
-	/* Enable the 2nd UART port */
-	clrbits32(bcsr, BCSR1_RS232_EN2);
-
-#ifdef CONFIG_SERIAL_CPM_SCC1
-	clrbits32((u32 *) & immap->im_scc[0].scc_sccm,
-		  UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32 *) & immap->im_scc[0].scc_gsmrl,
-		  SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC2
-	clrbits32((u32 *) & immap->im_scc[1].scc_sccm,
-		  UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32 *) & immap->im_scc[1].scc_gsmrl,
-		  SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
 
-#ifdef CONFIG_SERIAL_CPM_SCC3
-	clrbits32((u32 *) & immap->im_scc[2].scc_sccm,
-		  UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32 *) & immap->im_scc[2].scc_gsmrl,
-		  SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
+	clrbits32(&bcsr[1], BCSR1_RS232_EN1 | BCSR1_RS232_EN2 | BCSR1_FETHIEN);
+	setbits32(&bcsr[1], BCSR1_FETH_RST);
 
-#ifdef CONFIG_SERIAL_CPM_SCC4
-	clrbits32((u32 *) & immap->im_scc[3].scc_sccm,
-		  UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32 *) & immap->im_scc[3].scc_gsmrl,
-		  SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
+	clrbits32(&bcsr[3], BCSR3_FETHIEN2);
+	setbits32(&bcsr[3], BCSR3_FETH2_RST);
 
 	iounmap(bcsr);
-	iounmap(immap);
-}
-
-
-/*
- * Setup the architecture
- */
-static void __init mpc8272ads_setup_arch(void)
-{
-	if (ppc_md.progress)
-		ppc_md.progress("mpc8272ads_setup_arch()", 0);
-	cpm2_reset();
-
-	/* Map I/O region to a 256MB BAT */
 
-	mpc8272ads_board_setup();
+	init_ioports();
 
 	pq2_init_pci();
 
@@ -309,6 +156,23 @@ static void __init mpc8272ads_setup_arch(void)
 		ppc_md.progress("mpc8272ads_setup_arch(), finish", 0);
 }
 
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "cpm", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc8272ads))
+		return 0;
+
+	/* Publish the QE devices */
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	return 0;
+}
+device_initcall(declare_of_platform_devices);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
@@ -329,4 +193,9 @@ define_machine(mpc8272ads)
 	.calibrate_decr = generic_calibrate_decr,
 	.restart = pq2_restart,
 	.halt = pq2_halt,
+	.progress = udbg_progress,
 };
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+u32 __iomem *cpm_udbg_txdesc = (u32 __iomem *)0xf0000808;
+#endif
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ff70d62..cee671f 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -588,8 +588,6 @@ arch_initcall(fsl_usb_of_init);
 
 #ifdef CONFIG_CPM2
 
-extern void init_scc_ioports(struct fs_uart_platform_info*);
-
 static const char fcc_regs[] = "fcc_regs";
 static const char fcc_regs_c[] = "fcc_regs_c";
 static const char fcc_pram[] = "fcc_pram";
@@ -700,7 +698,6 @@ static int __init fs_enet_of_init(void)
 			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%x:%02x",
 							(u32)res.start, fs_enet_data.phy_addr);
 			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
-			fs_enet_data.init_ioports = init_fcc_ioports;
 
 			mdio_bb_prop = of_get_property(phy, "bitbang", NULL);
 			if (mdio_bb_prop) {
-- 
1.5.0.3
