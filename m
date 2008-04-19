Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF80FDE548
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 01:56:48 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m3JFuisJ031190
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 10:56:44 -0500
Date: Sat, 19 Apr 2008 10:52:56 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [PPC] Remove mpc8272 ads board from arch/ppc
Message-ID: <Pine.LNX.4.64.0804191051420.20132@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have a board port in arch/powerpc so we dont need this one anymore.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Will push via git tree.  Removed defconfig diff to shorten patch.

 arch/ppc/8260_io/fcc_enet.c           |   19 +-
 arch/ppc/Kconfig                      |   19 +-
 arch/ppc/configs/ads8272_defconfig    |  930 ---------------------------------
 arch/ppc/platforms/Makefile           |    2 -
 arch/ppc/platforms/mpc8272ads_setup.c |  367 -------------
 arch/ppc/platforms/pq2ads.c           |   53 --
 arch/ppc/platforms/pq2ads.h           |   94 ----
 arch/ppc/platforms/pq2ads_pd.h        |   32 --
 arch/ppc/syslib/m8260_setup.c         |    6 -
 arch/ppc/syslib/m82xx_pci.c           |   38 --
 include/asm-ppc/mpc8260.h             |    4 -
 11 files changed, 2 insertions(+), 1562 deletions(-)
 delete mode 100644 arch/ppc/configs/ads8272_defconfig
 delete mode 100644 arch/ppc/platforms/mpc8272ads_setup.c
 delete mode 100644 arch/ppc/platforms/pq2ads.c
 delete mode 100644 arch/ppc/platforms/pq2ads.h
 delete mode 100644 arch/ppc/platforms/pq2ads_pd.h

diff --git a/arch/ppc/8260_io/fcc_enet.c b/arch/ppc/8260_io/fcc_enet.c
index bcc3aa9..d38b57e 100644
--- a/arch/ppc/8260_io/fcc_enet.c
+++ b/arch/ppc/8260_io/fcc_enet.c
@@ -165,9 +165,6 @@ static int fcc_enet_set_mac_address(struct net_device *dev, void *addr);
 #ifdef CONFIG_SBC82xx
 #define F1_RXCLK	9
 #define F1_TXCLK	10
-#elif defined(CONFIG_ADS8272)
-#define F1_RXCLK	11
-#define F1_TXCLK	10
 #else
 #define F1_RXCLK	12
 #define F1_TXCLK	11
@@ -175,13 +172,8 @@ static int fcc_enet_set_mac_address(struct net_device *dev, void *addr);

 /* FCC2 Clock Source Configuration.  There are board specific.
    Can only choose from CLK13-16 */
-#ifdef CONFIG_ADS8272
-#define F2_RXCLK	15
-#define F2_TXCLK	16
-#else
 #define F2_RXCLK	13
 #define F2_TXCLK	14
-#endif

 /* FCC3 Clock Source Configuration.  There are board specific.
    Can only choose from CLK13-16 */
@@ -289,10 +281,7 @@ static int fcc_enet_set_mac_address(struct net_device *dev, void *addr);
 /* TQM8260 has MDIO and MDCK on PC30 and PC31 respectively */
 #define PC_MDIO		((uint)0x00000002)
 #define PC_MDCK		((uint)0x00000001)
-#elif defined(CONFIG_ADS8272)
-#define PC_MDIO		((uint)0x00002000)
-#define PC_MDCK		((uint)0x00001000)
-#elif defined(CONFIG_EST8260) || defined(CONFIG_ADS8260) || defined(CONFIG_PQ2FADS)
+#elif defined(CONFIG_EST8260) || defined(CONFIG_ADS8260)
 #define PC_MDIO		((uint)0x00400000)
 #define PC_MDCK		((uint)0x00200000)
 #else
@@ -2118,11 +2107,6 @@ init_fcc_startup(fcc_info_t *fip, struct net_device *dev)
 		printk("Can't get FCC IRQ %d\n", fip->fc_interrupt);

 #ifdef	PHY_INTERRUPT
-#ifdef CONFIG_ADS8272
-	if (request_irq(PHY_INTERRUPT, mii_link_interrupt, IRQF_SHARED,
-				"mii", dev) < 0)
-		printk(KERN_CRIT "Can't get MII IRQ %d\n", PHY_INTERRUPT);
-#else
 	/* Make IRQn edge triggered.  This does not work if PHY_INTERRUPT is
 	 * on Port C.
 	 */
@@ -2132,7 +2116,6 @@ init_fcc_startup(fcc_info_t *fip, struct net_device *dev)
 	if (request_irq(PHY_INTERRUPT, mii_link_interrupt, 0,
 							"mii", dev) < 0)
 		printk(KERN_CRIT "Can't get MII IRQ %d\n", PHY_INTERRUPT);
-#endif
 #endif	/* PHY_INTERRUPT */

 	/* Set GFMR to enable Ethernet operating mode.
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index abc877f..3fc45e2 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -666,9 +666,6 @@ config TQM8260
 	  End of Life: not yet :-)
 	  URL: <http://www.denx.de/PDF/TQM82xx_SPEC_Rev005.pdf>

-config ADS8272
-	bool "ADS8272"
-
 config PQ2FADS
 	bool "Freescale-PQ2FADS"
 	help
@@ -698,11 +695,6 @@ config EV64360
 	  platform.
 endchoice

-config PQ2ADS
-	bool
-	depends on ADS8272
-	default y
-
 config TQM8xxL
 	bool
 	depends on 8xx && (TQM823L || TQM850L || FPS850L || TQM855L || TQM860L)
@@ -725,15 +717,6 @@ config 8260
 	  this option means that you wish to build a kernel for a machine with
 	  an 8260 class CPU.

-config 8272
-	bool
-	depends on 6xx
-	default y if ADS8272
-	select 8260
-	help
-	  The MPC8272 CPM has a different internal dpram setup than other CPM2
-	  devices
-
 config CPM1
 	bool
 	depends on 8xx
@@ -1069,7 +1052,7 @@ config PCI_8260

 config 8260_PCI9
 	bool "Enable workaround for MPC826x erratum PCI 9"
-	depends on PCI_8260 && !ADS8272
+	depends on PCI_8260
 	default y

 choice
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
index 40f53fb..ef74a7b 100644
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -4,7 +4,6 @@

 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o
 obj-$(CONFIG_PREP_RESIDUAL)	+= residual.o
-obj-$(CONFIG_PQ2ADS)		+= pq2ads.o
 obj-$(CONFIG_TQM8260)		+= tqm8260_setup.o
 obj-$(CONFIG_CPCI690)		+= cpci690.o
 obj-$(CONFIG_EV64260)		+= ev64260.o
@@ -26,4 +25,3 @@ obj-$(CONFIG_LITE5200)		+= lite5200.o
 obj-$(CONFIG_EV64360)		+= ev64360.o
 obj-$(CONFIG_MPC86XADS)		+= mpc866ads_setup.o
 obj-$(CONFIG_MPC885ADS)		+= mpc885ads_setup.o
-obj-$(CONFIG_ADS8272)		+= mpc8272ads_setup.o
diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
deleted file mode 100644
index 47f4b38..0000000
--- a/arch/ppc/platforms/mpc8272ads_setup.c
+++ /dev/null
@@ -1,367 +0,0 @@
-/*
- * arch/ppc/platforms/mpc8272ads_setup.c
- *
- * MPC82xx Board-specific PlatformDevice descriptions
- *
- * 2005 (c) MontaVista Software, Inc.
- * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/ioport.h>
-#include <linux/fs_enet_pd.h>
-#include <linux/platform_device.h>
-#include <linux/phy.h>
-
-#include <asm/io.h>
-#include <asm/mpc8260.h>
-#include <asm/cpm2.h>
-#include <asm/immap_cpm2.h>
-#include <asm/irq.h>
-#include <asm/ppc_sys.h>
-#include <asm/ppcboot.h>
-#include <linux/fs_uart_pd.h>
-
-#include "pq2ads_pd.h"
-
-static void init_fcc1_ioports(struct fs_platform_info*);
-static void init_fcc2_ioports(struct fs_platform_info*);
-static void init_scc1_uart_ioports(struct fs_uart_platform_info*);
-static void init_scc4_uart_ioports(struct fs_uart_platform_info*);
-
-static struct fs_uart_platform_info mpc8272_uart_pdata[] = {
-	[fsid_scc1_uart] = {
-		.init_ioports 	= init_scc1_uart_ioports,
-		.fs_no		= fsid_scc1_uart,
-		.brg		= 1,
-		.tx_num_fifo	= 4,
-		.tx_buf_size	= 32,
-		.rx_num_fifo	= 4,
-		.rx_buf_size	= 32,
-	},
-	[fsid_scc4_uart] = {
-		.init_ioports 	= init_scc4_uart_ioports,
-		.fs_no		= fsid_scc4_uart,
-		.brg		= 4,
-		.tx_num_fifo	= 4,
-		.tx_buf_size	= 32,
-		.rx_num_fifo	= 4,
-		.rx_buf_size	= 32,
-	},
-};
-
-static struct fs_mii_bb_platform_info m82xx_mii_bb_pdata = {
-	.mdio_dat.bit	= 18,
-	.mdio_dir.bit	= 18,
-	.mdc_dat.bit	= 19,
-	.delay		= 1,
-};
-
-static struct fs_platform_info mpc82xx_enet_pdata[] = {
-	[fsid_fcc1] = {
-		.fs_no		= fsid_fcc1,
-		.cp_page	= CPM_CR_FCC1_PAGE,
-		.cp_block 	= CPM_CR_FCC1_SBLOCK,
-
-		.clk_trx 	= (PC_F1RXCLK | PC_F1TXCLK),
-		.clk_route	= CMX1_CLK_ROUTE,
-		.clk_mask	= CMX1_CLK_MASK,
-		.init_ioports 	= init_fcc1_ioports,
-
-		.mem_offset	= FCC1_MEM_OFFSET,
-
-		.rx_ring	= 32,
-		.tx_ring	= 32,
-		.rx_copybreak	= 240,
-		.use_napi	= 0,
-		.napi_weight	= 17,
-		.bus_id		= "0:00",
-	},
-	[fsid_fcc2] = {
-		.fs_no		= fsid_fcc2,
-		.cp_page	= CPM_CR_FCC2_PAGE,
-		.cp_block 	= CPM_CR_FCC2_SBLOCK,
-		.clk_trx 	= (PC_F2RXCLK | PC_F2TXCLK),
-		.clk_route	= CMX2_CLK_ROUTE,
-		.clk_mask	= CMX2_CLK_MASK,
-		.init_ioports	= init_fcc2_ioports,
-
-		.mem_offset	= FCC2_MEM_OFFSET,
-
-		.rx_ring	= 32,
-		.tx_ring	= 32,
-		.rx_copybreak	= 240,
-		.use_napi	= 0,
-		.napi_weight	= 17,
-		.bus_id		= "0:03",
-	},
-};
-
-static void init_fcc1_ioports(struct fs_platform_info* pdata)
-{
-	struct io_port *io;
-	u32 tempval;
-	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
-	u32 *bcsr = ioremap(BCSR_ADDR+4, sizeof(u32));
-
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
-	setbits32(&io->iop_ppara,PA1_DIRA0 | PA1_DIRA1);
-
-	/* Alter clocks */
-	tempval = PC_F1TXCLK|PC_F1RXCLK;
-
-	clrbits32(&io->iop_psorc, tempval);
-	clrbits32(&io->iop_pdirc, tempval);
-	setbits32(&io->iop_pparc, tempval);
-
-	clrbits32(&immap->im_cpmux.cmx_fcr, CMX1_CLK_MASK);
-	setbits32(&immap->im_cpmux.cmx_fcr, CMX1_CLK_ROUTE);
-	iounmap(bcsr);
-	iounmap(immap);
-}
-
-static void init_fcc2_ioports(struct fs_platform_info* pdata)
-{
-	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
-	u32 *bcsr = ioremap(BCSR_ADDR+12, sizeof(u32));
-
-	struct io_port *io;
-	u32 tempval;
-
-	immap = cpm2_immr;
-
-	io = &immap->im_ioport;
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
-	setbits32(&io->iop_pparb,PB2_DIRB0 | PB2_DIRB1);
-
-	tempval = PC_F2RXCLK|PC_F2TXCLK;
-
-	/* Alter clocks */
-	clrbits32(&io->iop_psorc,tempval);
-	clrbits32(&io->iop_pdirc,tempval);
-	setbits32(&io->iop_pparc,tempval);
-
-	clrbits32(&immap->im_cpmux.cmx_fcr, CMX2_CLK_MASK);
-	setbits32(&immap->im_cpmux.cmx_fcr, CMX2_CLK_ROUTE);
-
-	iounmap(bcsr);
-	iounmap(immap);
-}
-
-
-static void __init mpc8272ads_fixup_enet_pdata(struct platform_device *pdev,
-					      int idx)
-{
-	bd_t* bi = (void*)__res;
-	int fs_no = fsid_fcc1+pdev->id-1;
-
-	if(fs_no >= ARRAY_SIZE(mpc82xx_enet_pdata)) {
-		return;
-	}
-
-	mpc82xx_enet_pdata[fs_no].dpram_offset=
-			(u32)cpm2_immr->im_dprambase;
-	mpc82xx_enet_pdata[fs_no].fcc_regs_c =
-			(u32)cpm2_immr->im_fcc_c;
-	memcpy(&mpc82xx_enet_pdata[fs_no].macaddr,bi->bi_enetaddr,6);
-
-	/* prevent dup mac */
-	if(fs_no == fsid_fcc2)
-		mpc82xx_enet_pdata[fs_no].macaddr[5] ^= 1;
-
-	pdev->dev.platform_data = &mpc82xx_enet_pdata[fs_no];
-}
-
-static void mpc8272ads_fixup_uart_pdata(struct platform_device *pdev,
-					      int idx)
-{
-	bd_t *bd = (bd_t *) __res;
-	struct fs_uart_platform_info *pinfo;
-	int num = ARRAY_SIZE(mpc8272_uart_pdata);
-	int id = fs_uart_id_scc2fsid(idx);
-
-	/* no need to alter anything if console */
-	if ((id < num) && (!pdev->dev.platform_data)) {
-		pinfo = &mpc8272_uart_pdata[id];
-		pinfo->uart_clk = bd->bi_intfreq;
-		pdev->dev.platform_data = pinfo;
-	}
-}
-
-static void init_scc1_uart_ioports(struct fs_uart_platform_info* pdata)
-{
-	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
-
-        /* SCC1 is only on port D */
-	setbits32(&immap->im_ioport.iop_ppard,0x00000003);
-	clrbits32(&immap->im_ioport.iop_psord,0x00000001);
-	setbits32(&immap->im_ioport.iop_psord,0x00000002);
-	clrbits32(&immap->im_ioport.iop_pdird,0x00000001);
-	setbits32(&immap->im_ioport.iop_pdird,0x00000002);
-
-        /* Wire BRG1 to SCC1 */
-	clrbits32(&immap->im_cpmux.cmx_scr,0x00ffffff);
-
-	iounmap(immap);
-}
-
-static void init_scc4_uart_ioports(struct fs_uart_platform_info* pdata)
-{
-	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
-
-	setbits32(&immap->im_ioport.iop_ppard,0x00000600);
-	clrbits32(&immap->im_ioport.iop_psord,0x00000600);
-	clrbits32(&immap->im_ioport.iop_pdird,0x00000200);
-	setbits32(&immap->im_ioport.iop_pdird,0x00000400);
-
-        /* Wire BRG4 to SCC4 */
-	clrbits32(&immap->im_cpmux.cmx_scr,0x000000ff);
-	setbits32(&immap->im_cpmux.cmx_scr,0x0000001b);
-
-	iounmap(immap);
-}
-
-static void __init mpc8272ads_fixup_mdio_pdata(struct platform_device *pdev,
-					      int idx)
-{
-	m82xx_mii_bb_pdata.irq[0] = PHY_INTERRUPT;
-	m82xx_mii_bb_pdata.irq[1] = PHY_POLL;
-	m82xx_mii_bb_pdata.irq[2] = PHY_POLL;
-	m82xx_mii_bb_pdata.irq[3] = PHY_INTERRUPT;
-	m82xx_mii_bb_pdata.irq[31] = PHY_POLL;
-
-
-	m82xx_mii_bb_pdata.mdio_dat.offset =
-				(u32)&cpm2_immr->im_ioport.iop_pdatc;
-
-	m82xx_mii_bb_pdata.mdio_dir.offset =
-				(u32)&cpm2_immr->im_ioport.iop_pdirc;
-
-	m82xx_mii_bb_pdata.mdc_dat.offset =
-				(u32)&cpm2_immr->im_ioport.iop_pdatc;
-
-
-	pdev->dev.platform_data = &m82xx_mii_bb_pdata;
-}
-
-static int mpc8272ads_platform_notify(struct device *dev)
-{
-	static const struct platform_notify_dev_map dev_map[] = {
-		{
-			.bus_id = "fsl-cpm-fcc",
-			.rtn = mpc8272ads_fixup_enet_pdata,
-		},
-		{
-			.bus_id = "fsl-cpm-scc:uart",
-			.rtn = mpc8272ads_fixup_uart_pdata,
-		},
-		{
-			.bus_id = "fsl-bb-mdio",
-			.rtn = mpc8272ads_fixup_mdio_pdata,
-		},
-		{
-			.bus_id = NULL
-		}
-	};
-	platform_notify_map(dev_map,dev);
-
-	return 0;
-
-}
-
-int __init mpc8272ads_init(void)
-{
-	printk(KERN_NOTICE "mpc8272ads: Init\n");
-
-	platform_notify = mpc8272ads_platform_notify;
-
-	ppc_sys_device_initfunc();
-
-	ppc_sys_device_disable_all();
-	ppc_sys_device_enable(MPC82xx_CPM_FCC1);
-	ppc_sys_device_enable(MPC82xx_CPM_FCC2);
-
-	/* to be ready for console, let's attach pdata here */
-#ifdef CONFIG_SERIAL_CPM_SCC1
-	ppc_sys_device_setfunc(MPC82xx_CPM_SCC1, PPC_SYS_FUNC_UART);
-	ppc_sys_device_enable(MPC82xx_CPM_SCC1);
-
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC4
-	ppc_sys_device_setfunc(MPC82xx_CPM_SCC4, PPC_SYS_FUNC_UART);
-	ppc_sys_device_enable(MPC82xx_CPM_SCC4);
-#endif
-
-	ppc_sys_device_enable(MPC82xx_MDIO_BB);
-
-	return 0;
-}
-
-/*
-   To prevent confusion, console selection is gross:
-   by 0 assumed SCC1 and by 1 assumed SCC4
- */
-struct platform_device* early_uart_get_pdev(int index)
-{
-	bd_t *bd = (bd_t *) __res;
-	struct fs_uart_platform_info *pinfo;
-
-	struct platform_device* pdev = NULL;
-	if(index) { /*assume SCC4 here*/
-		pdev = &ppc_sys_platform_devices[MPC82xx_CPM_SCC4];
-		pinfo = &mpc8272_uart_pdata[fsid_scc4_uart];
-	} else { /*over SCC1*/
-		pdev = &ppc_sys_platform_devices[MPC82xx_CPM_SCC1];
-		pinfo = &mpc8272_uart_pdata[fsid_scc1_uart];
-	}
-
-	pinfo->uart_clk = bd->bi_intfreq;
-	pdev->dev.platform_data = pinfo;
-	ppc_sys_fixup_mem_resource(pdev, CPM_MAP_ADDR);
-	return NULL;
-}
-
-arch_initcall(mpc8272ads_init);
diff --git a/arch/ppc/platforms/pq2ads.c b/arch/ppc/platforms/pq2ads.c
deleted file mode 100644
index 7fc2e02..0000000
--- a/arch/ppc/platforms/pq2ads.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * PQ2ADS platform support
- *
- * Author: Kumar Gala <galak@kernel.crashing.org>
- * Derived from: est8260_setup.c by Allen Curtis
- *
- * Copyright 2004 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-
-#include <asm/io.h>
-#include <asm/mpc8260.h>
-#include <asm/cpm2.h>
-#include <asm/immap_cpm2.h>
-
-void __init
-m82xx_board_setup(void)
-{
-	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
-	u32 *bcsr = ioremap(BCSR_ADDR+4, sizeof(u32));
-
-	/* Enable the 2nd UART port */
-	clrbits32(bcsr, BCSR1_RS232_EN2);
-
-#ifdef CONFIG_SERIAL_CPM_SCC1
-	clrbits32((u32*)&immap->im_scc[0].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32*)&immap->im_scc[0].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC2
-	clrbits32((u32*)&immap->im_scc[1].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32*)&immap->im_scc[1].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC3
-	clrbits32((u32*)&immap->im_scc[2].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32*)&immap->im_scc[2].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC4
-	clrbits32((u32*)&immap->im_scc[3].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32*)&immap->im_scc[3].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
-
-	iounmap(bcsr);
-	iounmap(immap);
-}
diff --git a/arch/ppc/platforms/pq2ads.h b/arch/ppc/platforms/pq2ads.h
deleted file mode 100644
index 2b287f4..0000000
--- a/arch/ppc/platforms/pq2ads.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * A collection of structures, addresses, and values associated with
- * the Motorola MPC8260ADS/MPC8266ADS-PCI boards.
- * Copied from the RPX-Classic and SBS8260 stuff.
- *
- * Copyright (c) 2001 Dan Malek (dan@mvista.com)
- */
-#ifdef __KERNEL__
-#ifndef __MACH_ADS8260_DEFS
-#define __MACH_ADS8260_DEFS
-
-
-#include <asm/ppcboot.h>
-
-#if defined(CONFIG_ADS8272)
-#define BOARD_CHIP_NAME "8272"
-#endif
-
-/* Memory map is configured by the PROM startup.
- * We just map a few things we need.  The CSR is actually 4 byte-wide
- * registers that can be accessed as 8-, 16-, or 32-bit values.
- */
-#define CPM_MAP_ADDR		((uint)0xf0000000)
-#define BCSR_ADDR		((uint)0xf4500000)
-#define BCSR_SIZE		((uint)(32 * 1024))
-
-#define BOOTROM_RESTART_ADDR	((uint)0xff000104)
-
-/* For our show_cpuinfo hooks. */
-#define CPUINFO_VENDOR		"Motorola"
-#define CPUINFO_MACHINE		"PQ2 ADS PowerPC"
-
-/* The ADS8260 has 16, 32-bit wide control/status registers, accessed
- * only on word boundaries.
- * Not all are used (yet), or are interesting to us (yet).
- */
-
-/* Things of interest in the CSR.
-*/
-#define BCSR0_LED0		((uint)0x02000000)	/* 0 == on */
-#define BCSR0_LED1		((uint)0x01000000)	/* 0 == on */
-#define BCSR1_FETHIEN		((uint)0x08000000)	/* 0 == enable */
-#define BCSR1_FETH_RST		((uint)0x04000000)	/* 0 == reset */
-#define BCSR1_RS232_EN1		((uint)0x02000000)	/* 0 == enable */
-#define BCSR1_RS232_EN2		((uint)0x01000000)	/* 0 == enable */
-#define BCSR3_FETHIEN2		((uint)0x10000000)	/* 0 == enable */
-#define BCSR3_FETH2_RST 	((uint)0x80000000)	/* 0 == reset */
-
-#define PHY_INTERRUPT	SIU_INT_IRQ7
-
-#ifdef CONFIG_PCI
-/* PCI interrupt controller */
-#define PCI_INT_STAT_REG	0xF8200000
-#define PCI_INT_MASK_REG	0xF8200004
-#define PIRQA			(NR_CPM_INTS + 0)
-#define PIRQB			(NR_CPM_INTS + 1)
-#define PIRQC			(NR_CPM_INTS + 2)
-#define PIRQD			(NR_CPM_INTS + 3)
-
-/*
- * PCI memory map definitions for MPC8266ADS-PCI.
- *
- * processor view
- *	local address		PCI address		target
- *	0x80000000-0x9FFFFFFF	0x80000000-0x9FFFFFFF	PCI mem with prefetch
- *	0xA0000000-0xBFFFFFFF	0xA0000000-0xBFFFFFFF	PCI mem w/o prefetch
- *	0xF4000000-0xF7FFFFFF	0x00000000-0x03FFFFFF	PCI IO
- *
- * PCI master view
- *	local address		PCI address		target
- *	0x00000000-0x1FFFFFFF	0x00000000-0x1FFFFFFF	MPC8266 local memory
- */
-
-/* All the other PCI memory map definitions reside at syslib/m82xx_pci.h
-   Here we should redefine what is unique for this board */
-#define M82xx_PCI_SLAVE_MEM_LOCAL	0x00000000	/* Local base */
-#define M82xx_PCI_SLAVE_MEM_BUS		0x00000000	/* PCI base */
-#define M82xx_PCI_SLAVE_MEM_SIZE	0x10000000	/* 256 Mb */
-
-#define M82xx_PCI_SLAVE_SEC_WND_SIZE	~(0x40000000 - 1U)	/* 2 x 512Mb  */
-#define M82xx_PCI_SLAVE_SEC_WND_BASE	0x80000000		/* PCI Memory base */
-
-#if defined(CONFIG_ADS8272)
-#define PCI_INT_TO_SIU 	SIU_INT_IRQ2
-#elif defined(CONFIG_PQ2FADS)
-#define PCI_INT_TO_SIU 	SIU_INT_IRQ6
-#else
-#warning PCI Bridge will be without interrupts support
-#endif
-
-#endif /* CONFIG_PCI */
-
-#endif /* __MACH_ADS8260_DEFS */
-#endif /* __KERNEL__ */
diff --git a/arch/ppc/platforms/pq2ads_pd.h b/arch/ppc/platforms/pq2ads_pd.h
deleted file mode 100644
index 672483d..0000000
--- a/arch/ppc/platforms/pq2ads_pd.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef __PQ2ADS_PD_H
-#define __PQ2ADS_PD_H
-/*
- * arch/ppc/platforms/82xx/pq2ads_pd.h
- *
- * Some defines for MPC82xx board-specific PlatformDevice descriptions
- *
- * 2005 (c) MontaVista Software, Inc.
- * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/* FCC1 Clock Source Configuration.  These can be redefined in the board specific file.
-   Can only choose from CLK9-12 */
-
-#define F1_RXCLK	11
-#define F1_TXCLK	10
-
-/* FCC2 Clock Source Configuration.  These can be redefined in the board specific file.
-   Can only choose from CLK13-16 */
-#define F2_RXCLK	15
-#define F2_TXCLK	16
-
-/* FCC3 Clock Source Configuration.  These can be redefined in the board specific file.
-   Can only choose from CLK13-16 */
-#define F3_RXCLK	13
-#define F3_TXCLK	14
-
-#endif
diff --git a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
index 46588fa..b405837 100644
--- a/arch/ppc/syslib/m8260_setup.c
+++ b/arch/ppc/syslib/m8260_setup.c
@@ -175,12 +175,6 @@ m8260_init_IRQ(void)
 	 * in case the boot rom changed something on us.
 	 */
 	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
-
-#if defined(CONFIG_PCI) && (defined(CONFIG_ADS8272) || defined(CONFIG_PQ2FADS))
- 	/* Initialize stuff for the 82xx CPLD IC and install demux  */
- 	pq2pci_init_irq();
-#endif
-
 }

 /*
diff --git a/arch/ppc/syslib/m82xx_pci.c b/arch/ppc/syslib/m82xx_pci.c
index fe860d5..657a1c2 100644
--- a/arch/ppc/syslib/m82xx_pci.c
+++ b/arch/ppc/syslib/m82xx_pci.c
@@ -150,14 +150,6 @@ pq2pci_init_irq(void)
 {
 	int irq;
 	volatile cpm2_map_t *immap = cpm2_immr;
-#if defined CONFIG_ADS8272
-	/* configure chip select for PCI interrupt controller */
-	immap->im_memctl.memc_br3 = PCI_INT_STAT_REG | 0x00001801;
-	immap->im_memctl.memc_or3 = 0xffff8010;
-#elif defined CONFIG_PQ2FADS
-	immap->im_memctl.memc_br8 = PCI_INT_STAT_REG | 0x00001801;
-	immap->im_memctl.memc_or8 = 0xffff8010;
-#endif
 	for (irq = NR_CPM_INTS; irq < NR_CPM_INTS + 4; irq++)
 		irq_desc[irq].chip = &pq2pci_ic;

@@ -222,26 +214,6 @@ pq2ads_setup_pci(struct pci_controller *hose)
 	immap->im_memctl.memc_pcibr1  = M82xx_PCI_SEC_WND_BASE | PCIBR_ENABLE;
 #endif

-#if defined CONFIG_ADS8272
-	immap->im_siu_conf.siu_82xx.sc_siumcr =
-		(immap->im_siu_conf.siu_82xx.sc_siumcr &
-		~(SIUMCR_BBD | SIUMCR_ESE | SIUMCR_PBSE |
-		SIUMCR_CDIS | SIUMCR_DPPC11 | SIUMCR_L2CPC11 |
-		SIUMCR_LBPC11 | SIUMCR_APPC11 |
-		SIUMCR_CS10PC11 | SIUMCR_BCTLC11 | SIUMCR_MMR11)) |
-		SIUMCR_DPPC11 | SIUMCR_L2CPC01 | SIUMCR_LBPC00 |
-		SIUMCR_APPC10 | SIUMCR_CS10PC00 |
-		SIUMCR_BCTLC00 | SIUMCR_MMR11 ;
-
-#elif defined CONFIG_PQ2FADS
-	/*
-	 * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]),
-	 * and local bus for PCI (SIUMCR [LBPC]).
-	 */
-	immap->im_siu_conf.siu_82xx.sc_siumcr = (immap->im_siu_conf.siu_82xx.sc_siumcr &
-				~(SIUMCR_L2CPC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11 | SIUMCR_APPC11) |
-				SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 | SIUMCR_APPC10);
-#endif
 	/* Enable PCI  */
 	immap->im_pci.pci_gcr = cpu_to_le32(PCIGCR_PCI_BUS_EN);

@@ -284,12 +256,6 @@ pq2ads_setup_pci(struct pci_controller *hose)
 	immap->im_pci.pci_pibar0 = cpu_to_le32(M82xx_PCI_SLAVE_MEM_BUS  >> PITA_ADDR_SHIFT);
 	immap->im_pci.pci_pitar0 = cpu_to_le32(M82xx_PCI_SLAVE_MEM_LOCAL>> PITA_ADDR_SHIFT);

-#if defined CONFIG_ADS8272
-	/* PCI int highest prio */
-	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x01236745;
-#elif defined CONFIG_PQ2FADS
-	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x03124567;
-#endif
 	/* park bus on PCI */
 	immap->im_siu_conf.siu_82xx.sc_ppc_acr = PPC_ACR_BUS_PARK_PCI;

@@ -320,10 +286,6 @@ void __init pq2_find_bridges(void)
 	hose->bus_offset = 0;
 	hose->last_busno = 0xff;

-#ifdef CONFIG_ADS8272
-	hose->set_cfg_type = 1;
-#endif
-
 	setup_m8260_indirect_pci(hose,
 				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_addr,
 				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_data);
diff --git a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
index 23579d4..402ba15 100644
--- a/include/asm-ppc/mpc8260.h
+++ b/include/asm-ppc/mpc8260.h
@@ -35,10 +35,6 @@
 #include <platforms/tqm8260.h>
 #endif

-#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
-#include <platforms/pq2ads.h>
-#endif
-
 #ifdef CONFIG_PCI_8260
 #include <syslib/m82xx_pci.h>
 #endif
-- 
1.5.4.1
