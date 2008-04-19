Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3EFDDDE6BA
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 01:57:41 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m3JFvbfD031247
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 10:57:38 -0500
Date: Sat, 19 Apr 2008 10:53:49 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [PPC] Remove mpc885ads and mpc86x ads boards from arch/ppc
Message-ID: <Pine.LNX.4.64.0804191052580.20132@blarg.am.freescale.net>
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

 arch/ppc/8xx_io/enet.c                |   23 --
 arch/ppc/Kconfig                      |   63 ----
 arch/ppc/configs/mpc86x_ads_defconfig |  633 ---------------------------------
 arch/ppc/configs/mpc885ads_defconfig  |  622 --------------------------------
 arch/ppc/platforms/Makefile           |    2 -
 arch/ppc/platforms/fads.h             |   25 --
 arch/ppc/platforms/mpc885ads.h        |   93 -----
 arch/ppc/platforms/mpc885ads_setup.c  |  476 -------------------------
 arch/ppc/syslib/m8xx_setup.c          |   10 -
 include/asm-ppc/mpc8xx.h              |    4 -
 10 files changed, 0 insertions(+), 1951 deletions(-)
 delete mode 100644 arch/ppc/configs/mpc86x_ads_defconfig
 delete mode 100644 arch/ppc/configs/mpc885ads_defconfig
 delete mode 100644 arch/ppc/platforms/mpc885ads.h
 delete mode 100644 arch/ppc/platforms/mpc885ads_setup.c

diff --git a/arch/ppc/8xx_io/enet.c b/arch/ppc/8xx_io/enet.c
index c6d047a..5899aea 100644
--- a/arch/ppc/8xx_io/enet.c
+++ b/arch/ppc/8xx_io/enet.c
@@ -946,29 +946,6 @@ static int __init scc_enet_init(void)
 	*((volatile uint *)BCSR1) &= ~BCSR1_ETHEN;
 #endif

-#ifdef CONFIG_MPC885ADS
-
-	/* Deassert PHY reset and enable the PHY.
-	 */
-	{
-		volatile uint __iomem *bcsr = ioremap(BCSR_ADDR, BCSR_SIZE);
-		uint tmp;
-
-		tmp = in_be32(bcsr + 1 /* BCSR1 */);
-		tmp |= BCSR1_ETHEN;
-		out_be32(bcsr + 1, tmp);
-		tmp = in_be32(bcsr + 4 /* BCSR4 */);
-		tmp |= BCSR4_ETH10_RST;
-		out_be32(bcsr + 4, tmp);
-		iounmap(bcsr);
-	}
-
-	/* On MPC885ADS SCC ethernet PHY defaults to the full duplex mode
-	 * upon reset. SCC is set to half duplex by default. So this
-	 * inconsistency should be better fixed by the software.
-	 */
-#endif
-
 	dev->base_addr = (unsigned long)ep;
 #if 0
 	dev->name = "CPM_ENET";
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 3fc45e2..0f1863e 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -372,22 +372,6 @@ config MPC8XXFADS
 	bool "FADS"
 	select FADS

-config MPC86XADS
-	bool "MPC86XADS"
-	help
-	  MPC86x Application Development System by Freescale Semiconductor.
-	  The MPC86xADS is meant to serve as a platform for s/w and h/w
-	  development around the MPC86X processor families.
-	select FADS
-
-config MPC885ADS
-	bool "MPC885ADS"
-	help
-	  Freescale Semiconductor MPC885 Application Development System (ADS).
-	  Also known as DUET.
-	  The MPC885ADS is meant to serve as a platform for s/w and h/w
-	  development around the MPC885 processor family.
-
 config TQM823L
 	bool "TQM823L"
 	help
@@ -479,53 +463,6 @@ config WINCEPT

 endchoice

-menu "Freescale Ethernet driver platform-specific options"
-	depends on FS_ENET
-
-	config MPC8xx_SECOND_ETH
-	bool "Second Ethernet channel"
-	depends on (MPC885ADS || MPC86XADS)
-	default y
-	help
-	  This enables support for second Ethernet on MPC885ADS and MPC86xADS boards.
-	  The latter will use SCC1, for 885ADS you can select it below.
-
-	choice
-		prompt "Second Ethernet channel"
-		depends on MPC8xx_SECOND_ETH
-		default MPC8xx_SECOND_ETH_FEC2
-
-		config MPC8xx_SECOND_ETH_FEC2
-		bool "FEC2"
-		depends on MPC885ADS
-		help
-		  Enable FEC2 to serve as 2-nd Ethernet channel. Note that SMC2
-		  (often 2-nd UART) will not work if this is enabled.
-
-		config MPC8xx_SECOND_ETH_SCC1
-		bool "SCC1"
-		depends on MPC86XADS
-		select MPC8xx_SCC_ENET_FIXED
-		help
-		  Enable SCC1 to serve as 2-nd Ethernet channel. Note that SMC1
-		  (often 1-nd UART) will not work if this is enabled.
-
-		config MPC8xx_SECOND_ETH_SCC3
-		bool "SCC3"
-		depends on MPC885ADS
-		help
-		  Enable SCC3 to serve as 2-nd Ethernet channel. Note that SMC1
-		  (often 1-nd UART) will not work if this is enabled.
-
-	endchoice
-
-	config MPC8xx_SCC_ENET_FIXED
-	depends on MPC8xx_SECOND_ETH_SCC
-	default n
-	bool "Use fixed MII-less mode for SCC Ethernet"
-
-endmenu
-
 choice
 	prompt "Machine Type"
 	depends on 6xx
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
index ef74a7b..6260231 100644
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -23,5 +23,3 @@ obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
 obj-$(CONFIG_LITE5200)		+= lite5200.o
 obj-$(CONFIG_EV64360)		+= ev64360.o
-obj-$(CONFIG_MPC86XADS)		+= mpc866ads_setup.o
-obj-$(CONFIG_MPC885ADS)		+= mpc885ads_setup.o
diff --git a/arch/ppc/platforms/fads.h b/arch/ppc/platforms/fads.h
index 2f9f0f6..5219366 100644
--- a/arch/ppc/platforms/fads.h
+++ b/arch/ppc/platforms/fads.h
@@ -22,29 +22,6 @@

 #include <asm/ppcboot.h>

-#if defined(CONFIG_MPC86XADS)
-
-#define BOARD_CHIP_NAME "MPC86X"
-
-/* U-Boot maps BCSR to 0xff080000 */
-#define BCSR_ADDR		((uint)0xff080000)
-
-/* MPC86XADS has one more CPLD and an additional BCSR.
- */
-#define CFG_PHYDEV_ADDR		((uint)0xff0a0000)
-#define BCSR5			((uint)(CFG_PHYDEV_ADDR + 0x300))
-
-#define BCSR5_T1_RST		0x10
-#define BCSR5_ATM155_RST	0x08
-#define BCSR5_ATM25_RST		0x04
-#define BCSR5_MII1_EN		0x02
-#define BCSR5_MII1_RST		0x01
-
-/* There is no PHY link change interrupt */
-#define PHY_INTERRUPT	(-1)
-
-#else /* FADS */
-
 /* Memory map is configured by the PROM startup.
  * I tried to follow the FADS manual, although the startup PROM
  * dictates this and we simply have to move some of the physical
@@ -55,8 +32,6 @@
 /* PHY link change interrupt */
 #define PHY_INTERRUPT	SIU_IRQ2

-#endif /* CONFIG_MPC86XADS */
-
 #define BCSR_SIZE		((uint)(64 * 1024))
 #define BCSR0			((uint)(BCSR_ADDR + 0x00))
 #define BCSR1			((uint)(BCSR_ADDR + 0x04))
diff --git a/arch/ppc/platforms/mpc885ads.h b/arch/ppc/platforms/mpc885ads.h
deleted file mode 100644
index d3bbbb3..0000000
--- a/arch/ppc/platforms/mpc885ads.h
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * A collection of structures, addresses, and values associated with
- * the Freescale MPC885ADS board.
- * Copied from the FADS stuff.
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2005 (c) MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#ifdef __KERNEL__
-#ifndef __ASM_MPC885ADS_H__
-#define __ASM_MPC885ADS_H__
-
-
-#include <asm/ppcboot.h>
-
-/* U-Boot maps BCSR to 0xff080000 */
-#define BCSR_ADDR		((uint)0xff080000)
-#define BCSR_SIZE		((uint)32)
-#define BCSR0			((uint)(BCSR_ADDR + 0x00))
-#define BCSR1			((uint)(BCSR_ADDR + 0x04))
-#define BCSR2			((uint)(BCSR_ADDR + 0x08))
-#define BCSR3			((uint)(BCSR_ADDR + 0x0c))
-#define BCSR4			((uint)(BCSR_ADDR + 0x10))
-
-#define CFG_PHYDEV_ADDR		((uint)0xff0a0000)
-#define BCSR5			((uint)(CFG_PHYDEV_ADDR + 0x300))
-
-#define IMAP_ADDR		((uint)0xff000000)
-#define IMAP_SIZE		((uint)(64 * 1024))
-
-#define PCMCIA_MEM_ADDR		((uint)0xff020000)
-#define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
-
-/* Bits of interest in the BCSRs.
- */
-#define BCSR1_ETHEN		((uint)0x20000000)
-#define BCSR1_IRDAEN		((uint)0x10000000)
-#define BCSR1_RS232EN_1		((uint)0x01000000)
-#define BCSR1_PCCEN		((uint)0x00800000)
-#define BCSR1_PCCVCC0		((uint)0x00400000)
-#define BCSR1_PCCVPP0		((uint)0x00200000)
-#define BCSR1_PCCVPP1		((uint)0x00100000)
-#define BCSR1_PCCVPP_MASK	(BCSR1_PCCVPP0 | BCSR1_PCCVPP1)
-#define BCSR1_RS232EN_2		((uint)0x00040000)
-#define BCSR1_PCCVCC1		((uint)0x00010000)
-#define BCSR1_PCCVCC_MASK	(BCSR1_PCCVCC0 | BCSR1_PCCVCC1)
-
-#define BCSR4_ETH10_RST		((uint)0x80000000)	/* 10Base-T PHY reset*/
-#define BCSR4_USB_LO_SPD	((uint)0x04000000)
-#define BCSR4_USB_VCC		((uint)0x02000000)
-#define BCSR4_USB_FULL_SPD	((uint)0x00040000)
-#define BCSR4_USB_EN		((uint)0x00020000)
-
-#define BCSR5_MII2_EN		0x40
-#define BCSR5_MII2_RST		0x20
-#define BCSR5_T1_RST		0x10
-#define BCSR5_ATM155_RST	0x08
-#define BCSR5_ATM25_RST		0x04
-#define BCSR5_MII1_EN		0x02
-#define BCSR5_MII1_RST		0x01
-
-/* Interrupt level assignments */
-#define PHY_INTERRUPT	SIU_IRQ7	/* PHY link change interrupt */
-#define SIU_INT_FEC1	SIU_LEVEL1	/* FEC1 interrupt */
-#define SIU_INT_FEC2	SIU_LEVEL3	/* FEC2 interrupt */
-#define FEC_INTERRUPT	SIU_INT_FEC1	/* FEC interrupt */
-
-/* We don't use the 8259 */
-#define NR_8259_INTS	0
-
-/* CPM Ethernet through SCC3 */
-#define PA_ENET_RXD	((ushort)0x0040)
-#define PA_ENET_TXD	((ushort)0x0080)
-#define PE_ENET_TCLK	((uint)0x00004000)
-#define PE_ENET_RCLK	((uint)0x00008000)
-#define PE_ENET_TENA	((uint)0x00000010)
-#define PC_ENET_CLSN	((ushort)0x0400)
-#define PC_ENET_RENA	((ushort)0x0800)
-
-/* Control bits in the SICR to route TCLK (CLK5) and RCLK (CLK6) to
- * SCC3.  Also, make sure GR3 (bit 8) and SC3 (bit 9) are zero */
-#define SICR_ENET_MASK	((uint)0x00ff0000)
-#define SICR_ENET_CLKRT	((uint)0x002c0000)
-
-#define BOARD_CHIP_NAME "MPC885"
-
-#endif /* __ASM_MPC885ADS_H__ */
-#endif /* __KERNEL__ */
diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
deleted file mode 100644
index ba06cc0..0000000
--- a/arch/ppc/platforms/mpc885ads_setup.c
+++ /dev/null
@@ -1,476 +0,0 @@
-/*arch/ppc/platforms/mpc885ads_setup.c
- *
- * Platform setup for the Freescale mpc885ads board
- *
- * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * Copyright 2005 MontaVista Software Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <linux/ioport.h>
-#include <linux/device.h>
-
-#include <linux/fs_enet_pd.h>
-#include <linux/fs_uart_pd.h>
-#include <linux/mii.h>
-
-#include <asm/delay.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/page.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <asm/time.h>
-#include <asm/ppcboot.h>
-#include <asm/8xx_immap.h>
-#include <asm/cpm1.h>
-#include <asm/ppc_sys.h>
-
-extern unsigned char __res[];
-static void setup_smc1_ioports(struct fs_uart_platform_info*);
-static void setup_smc2_ioports(struct fs_uart_platform_info*);
-
-static struct fs_mii_fec_platform_info	mpc8xx_mdio_fec_pdata;
-static void setup_fec1_ioports(struct fs_platform_info*);
-static void setup_fec2_ioports(struct fs_platform_info*);
-static void setup_scc3_ioports(struct fs_platform_info*);
-
-static struct fs_uart_platform_info mpc885_uart_pdata[] = {
-	[fsid_smc1_uart] = {
-		.brg		= 1,
- 		.fs_no 		= fsid_smc1_uart,
- 		.init_ioports	= setup_smc1_ioports,
-		.tx_num_fifo	= 4,
-		.tx_buf_size	= 32,
-		.rx_num_fifo	= 4,
-		.rx_buf_size	= 32,
- 	},
- 	[fsid_smc2_uart] = {
- 		.brg		= 2,
- 		.fs_no 		= fsid_smc2_uart,
- 		.init_ioports	= setup_smc2_ioports,
-		.tx_num_fifo	= 4,
-		.tx_buf_size	= 32,
-		.rx_num_fifo	= 4,
-		.rx_buf_size	= 32,
- 	},
-};
-
-static struct fs_platform_info mpc8xx_enet_pdata[] = {
-	[fsid_fec1] = {
-	 .rx_ring = 128,
-	 .tx_ring = 16,
-	 .rx_copybreak = 240,
-
-	 .use_napi = 1,
-	 .napi_weight = 17,
-
-	 .init_ioports = setup_fec1_ioports,
-
-          .bus_id = "0:00",
-          .has_phy = 1,
-	 },
-	[fsid_fec2] = {
-	     .rx_ring = 128,
-	     .tx_ring = 16,
-	     .rx_copybreak = 240,
-
-	     .use_napi = 1,
-	     .napi_weight = 17,
-
-	     .init_ioports = setup_fec2_ioports,
-
- 	     .bus_id = "0:01",
- 	     .has_phy = 1,
-	     },
-	[fsid_scc3] = {
-		.rx_ring = 64,
-		.tx_ring = 8,
-		.rx_copybreak = 240,
-
-		.use_napi = 1,
-		.napi_weight = 17,
-
-		.init_ioports = setup_scc3_ioports,
-#ifdef CONFIG_FIXED_MII_10_FDX
-		.bus_id = "fixed@100:1",
-#else
-		.bus_id = "0:02",
- #endif
-	},
-};
-
-void __init board_init(void)
-{
-	cpm8xx_t *cp = cpmp;
- 	unsigned int *bcsr_io;
-
-#ifdef CONFIG_FS_ENET
-	immap_t *immap = (immap_t *) IMAP_ADDR;
-#endif
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-
-	if (bcsr_io == NULL) {
-		printk(KERN_CRIT "Could not remap BCSR\n");
-		return;
-	}
-#ifdef CONFIG_SERIAL_CPM_SMC1
-	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
-	clrbits32(bcsr_io, BCSR1_RS232EN_1);
-        cp->cp_smc[0].smc_smcm |= (SMCM_RX | SMCM_TX);
-        cp->cp_smc[0].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-#else
-	setbits32(bcsr_io,BCSR1_RS232EN_1);
-	cp->cp_smc[0].smc_smcmr = 0;
-	cp->cp_smc[0].smc_smce = 0;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SMC2
-	cp->cp_simode &= ~(0xe0000000 >> 1);
-	cp->cp_simode |= (0x20000000 >> 1);	/* brg2 */
-	clrbits32(bcsr_io,BCSR1_RS232EN_2);
-        cp->cp_smc[1].smc_smcm |= (SMCM_RX | SMCM_TX);
-        cp->cp_smc[1].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-#else
-	setbits32(bcsr_io,BCSR1_RS232EN_2);
-	cp->cp_smc[1].smc_smcmr = 0;
-	cp->cp_smc[1].smc_smce = 0;
-#endif
-	iounmap(bcsr_io);
-
-#ifdef CONFIG_FS_ENET
-	/* use MDC for MII (common) */
-	setbits16(&immap->im_ioport.iop_pdpar, 0x0080);
-	clrbits16(&immap->im_ioport.iop_pddir, 0x0080);
-	bcsr_io = ioremap(BCSR5, sizeof(unsigned long));
-	clrbits32(bcsr_io,BCSR5_MII1_EN);
-	clrbits32(bcsr_io,BCSR5_MII1_RST);
-#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
-	clrbits32(bcsr_io,BCSR5_MII2_EN);
-	clrbits32(bcsr_io,BCSR5_MII2_RST);
-#endif
-	iounmap(bcsr_io);
-#endif
-}
-
-static void setup_fec1_ioports(struct fs_platform_info* pdata)
-{
-	immap_t *immap = (immap_t *) IMAP_ADDR;
-
-	/* configure FEC1 pins  */
-	setbits16(&immap->im_ioport.iop_papar, 0xf830);
-	setbits16(&immap->im_ioport.iop_padir, 0x0830);
-	clrbits16(&immap->im_ioport.iop_padir, 0xf000);
-	setbits32(&immap->im_cpm.cp_pbpar, 0x00001001);
-
-	clrbits32(&immap->im_cpm.cp_pbdir, 0x00001001);
-	setbits16(&immap->im_ioport.iop_pcpar, 0x000c);
-	clrbits16(&immap->im_ioport.iop_pcdir, 0x000c);
-	setbits32(&immap->im_cpm.cp_pepar, 0x00000003);
-
-	setbits32(&immap->im_cpm.cp_pedir, 0x00000003);
-	clrbits32(&immap->im_cpm.cp_peso, 0x00000003);
-	clrbits32(&immap->im_cpm.cp_cptr, 0x00000100);
-}
-
-static void setup_fec2_ioports(struct fs_platform_info* pdata)
-{
-	immap_t *immap = (immap_t *) IMAP_ADDR;
-
-	/* configure FEC2 pins */
-	setbits32(&immap->im_cpm.cp_pepar, 0x0003fffc);
-	setbits32(&immap->im_cpm.cp_pedir, 0x0003fffc);
-	clrbits32(&immap->im_cpm.cp_peso, 0x000087fc);
-	setbits32(&immap->im_cpm.cp_peso, 0x00037800);
-	clrbits32(&immap->im_cpm.cp_cptr, 0x00000080);
-}
-
-static void setup_scc3_ioports(struct fs_platform_info* pdata)
-{
-	immap_t *immap = (immap_t *) IMAP_ADDR;
-	unsigned *bcsr_io;
-
-	bcsr_io = ioremap(BCSR_ADDR, BCSR_SIZE);
-
-	if (bcsr_io == NULL) {
-		printk(KERN_CRIT "Could not remap BCSR\n");
-		return;
-	}
-
-	/* Enable the PHY.
-	 */
-	clrbits32(bcsr_io+4, BCSR4_ETH10_RST);
-	udelay(1000);
-	setbits32(bcsr_io+4, BCSR4_ETH10_RST);
-	/* Configure port A pins for Txd and Rxd.
-	 */
-	setbits16(&immap->im_ioport.iop_papar, PA_ENET_RXD | PA_ENET_TXD);
-	clrbits16(&immap->im_ioport.iop_padir, PA_ENET_RXD | PA_ENET_TXD);
-
-	/* Configure port C pins to enable CLSN and RENA.
-	 */
-	clrbits16(&immap->im_ioport.iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
-	clrbits16(&immap->im_ioport.iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
-	setbits16(&immap->im_ioport.iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
-
-	/* Configure port E for TCLK and RCLK.
-	 */
-	setbits32(&immap->im_cpm.cp_pepar, PE_ENET_TCLK | PE_ENET_RCLK);
-	clrbits32(&immap->im_cpm.cp_pepar, PE_ENET_TENA);
-	clrbits32(&immap->im_cpm.cp_pedir,
-		  PE_ENET_TCLK | PE_ENET_RCLK | PE_ENET_TENA);
-	clrbits32(&immap->im_cpm.cp_peso, PE_ENET_TCLK | PE_ENET_RCLK);
-	setbits32(&immap->im_cpm.cp_peso, PE_ENET_TENA);
-
-	/* Configure Serial Interface clock routing.
-	 * First, clear all SCC bits to zero, then set the ones we want.
-	 */
-	clrbits32(&immap->im_cpm.cp_sicr, SICR_ENET_MASK);
-	setbits32(&immap->im_cpm.cp_sicr, SICR_ENET_CLKRT);
-
-	/* Disable Rx and Tx. SMC1 sshould be stopped if SCC3 eternet are used.
-	 */
-	immap->im_cpm.cp_smc[0].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	/* On the MPC885ADS SCC ethernet PHY is initialized in the full duplex mode
-	 * by H/W setting after reset. SCC ethernet controller support only half duplex.
-	 * This discrepancy of modes causes a lot of carrier lost errors.
-	 */
-
-	/* In the original SCC enet driver the following code is placed at
-	   the end of the initialization */
-	setbits32(&immap->im_cpm.cp_pepar, PE_ENET_TENA);
-	clrbits32(&immap->im_cpm.cp_pedir, PE_ENET_TENA);
-	setbits32(&immap->im_cpm.cp_peso, PE_ENET_TENA);
-
-	setbits32(bcsr_io+4, BCSR1_ETHEN);
-	iounmap(bcsr_io);
-}
-
-static int mac_count = 0;
-
-static void mpc885ads_fixup_enet_pdata(struct platform_device *pdev, int fs_no)
-{
- 	struct fs_platform_info *fpi;
-	bd_t *bd = (bd_t *) __res;
-	char *e;
-	int i;
-
-	if(fs_no >= ARRAY_SIZE(mpc8xx_enet_pdata)) {
-		printk(KERN_ERR"No network-suitable #%d device on bus", fs_no);
-		return;
-	}
-
-	fpi = &mpc8xx_enet_pdata[fs_no];
-
-	switch (fs_no) {
-	case fsid_fec1:
-		fpi->init_ioports = &setup_fec1_ioports;
-		break;
-	case fsid_fec2:
-		fpi->init_ioports = &setup_fec2_ioports;
-		break;
-	case fsid_scc3:
-		fpi->init_ioports = &setup_scc3_ioports;
-		break;
-	default:
-    	        printk(KERN_WARNING "Device %s is not supported!\n", pdev->name);
-	        return;
-	}
-
-	pdev->dev.platform_data = fpi;
-	fpi->fs_no = fs_no;
-
-	e = (unsigned char *)&bd->bi_enetaddr;
-	for (i = 0; i < 6; i++)
-		fpi->macaddr[i] = *e++;
-
-	fpi->macaddr[5] += mac_count++;
-
-}
-
-static void mpc885ads_fixup_fec_enet_pdata(struct platform_device *pdev,
-					   int idx)
-{
-	/* This is for FEC devices only */
-	if (!pdev || !pdev->name || (!strstr(pdev->name, "fsl-cpm-fec")))
-		return;
-	mpc885ads_fixup_enet_pdata(pdev, fsid_fec1 + pdev->id - 1);
-}
-
-static void __init mpc885ads_fixup_scc_enet_pdata(struct platform_device *pdev,
-						  int idx)
-{
-	/* This is for SCC devices only */
-	if (!pdev || !pdev->name || (!strstr(pdev->name, "fsl-cpm-scc")))
-		return;
-
-	mpc885ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
-}
-
-static void setup_smc1_ioports(struct fs_uart_platform_info* pdata)
-{
-        immap_t *immap = (immap_t *) IMAP_ADDR;
-        unsigned *bcsr_io;
-        unsigned int iobits = 0x000000c0;
-
-        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-
-        if (bcsr_io == NULL) {
-                printk(KERN_CRIT "Could not remap BCSR1\n");
-                return;
-        }
-        clrbits32(bcsr_io,BCSR1_RS232EN_1);
-        iounmap(bcsr_io);
-
-        setbits32(&immap->im_cpm.cp_pbpar, iobits);
-        clrbits32(&immap->im_cpm.cp_pbdir, iobits);
-        clrbits16(&immap->im_cpm.cp_pbodr, iobits);
-}
-
-static void setup_smc2_ioports(struct fs_uart_platform_info* pdata)
-{
-        immap_t *immap = (immap_t *) IMAP_ADDR;
-        unsigned *bcsr_io;
-        unsigned int iobits = 0x00000c00;
-
-        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-
-        if (bcsr_io == NULL) {
-                printk(KERN_CRIT "Could not remap BCSR1\n");
-                return;
-        }
-        clrbits32(bcsr_io,BCSR1_RS232EN_2);
-        iounmap(bcsr_io);
-
-#ifndef CONFIG_SERIAL_CPM_ALT_SMC2
-        setbits32(&immap->im_cpm.cp_pbpar, iobits);
-        clrbits32(&immap->im_cpm.cp_pbdir, iobits);
-        clrbits16(&immap->im_cpm.cp_pbodr, iobits);
-#else
-        setbits16(&immap->im_ioport.iop_papar, iobits);
-        clrbits16(&immap->im_ioport.iop_padir, iobits);
-        clrbits16(&immap->im_ioport.iop_paodr, iobits);
-#endif
-}
-
-static void __init mpc885ads_fixup_uart_pdata(struct platform_device *pdev,
-                                              int idx)
-{
-	bd_t *bd = (bd_t *) __res;
-	struct fs_uart_platform_info *pinfo;
-	int num = ARRAY_SIZE(mpc885_uart_pdata);
-
-	int id = fs_uart_id_smc2fsid(idx);
-
-	/* no need to alter anything if console */
-	if ((id < num) && (!pdev->dev.platform_data)) {
-		pinfo = &mpc885_uart_pdata[id];
-		pinfo->uart_clk = bd->bi_intfreq;
-		pdev->dev.platform_data = pinfo;
-	}
-}
-
-
-static int mpc885ads_platform_notify(struct device *dev)
-{
-
-	static const struct platform_notify_dev_map dev_map[] = {
-		{
-			.bus_id = "fsl-cpm-fec",
-			.rtn = mpc885ads_fixup_fec_enet_pdata,
-		},
-		{
-			.bus_id = "fsl-cpm-scc",
-			.rtn = mpc885ads_fixup_scc_enet_pdata,
-		},
-		{
-			.bus_id = "fsl-cpm-smc:uart",
-			.rtn = mpc885ads_fixup_uart_pdata
-		},
-		{
-			.bus_id = NULL
-		}
-	};
-
-	platform_notify_map(dev_map,dev);
-
-	return 0;
-}
-
-int __init mpc885ads_init(void)
-{
-	struct fs_mii_fec_platform_info* fmpi;
-	bd_t *bd = (bd_t *) __res;
-
-	printk(KERN_NOTICE "mpc885ads: Init\n");
-
-	platform_notify = mpc885ads_platform_notify;
-
-	ppc_sys_device_initfunc();
-	ppc_sys_device_disable_all();
-
-	ppc_sys_device_enable(MPC8xx_CPM_FEC1);
-
-	ppc_sys_device_enable(MPC8xx_MDIO_FEC);
-	fmpi = ppc_sys_platform_devices[MPC8xx_MDIO_FEC].dev.platform_data =
-		&mpc8xx_mdio_fec_pdata;
-
-	fmpi->mii_speed = ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1;
-
-	/* No PHY interrupt line here */
-	fmpi->irq[0xf] = SIU_IRQ7;
-
-#ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
-	ppc_sys_device_enable(MPC8xx_CPM_SCC3);
-
-#endif
-#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
-	ppc_sys_device_enable(MPC8xx_CPM_FEC2);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SMC1
-	ppc_sys_device_enable(MPC8xx_CPM_SMC1);
-	ppc_sys_device_setfunc(MPC8xx_CPM_SMC1, PPC_SYS_FUNC_UART);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SMC2
-	ppc_sys_device_enable(MPC8xx_CPM_SMC2);
-	ppc_sys_device_setfunc(MPC8xx_CPM_SMC2, PPC_SYS_FUNC_UART);
-#endif
-	return 0;
-}
-
-arch_initcall(mpc885ads_init);
-
-/*
-   To prevent confusion, console selection is gross:
-   by 0 assumed SMC1 and by 1 assumed SMC2
- */
-struct platform_device* early_uart_get_pdev(int index)
-{
-	bd_t *bd = (bd_t *) __res;
-	struct fs_uart_platform_info *pinfo;
-
-	struct platform_device* pdev = NULL;
-	if(index) { /*assume SMC2 here*/
-		pdev = &ppc_sys_platform_devices[MPC8xx_CPM_SMC2];
-		pinfo = &mpc885_uart_pdata[1];
-	} else { /*over SMC1*/
-		pdev = &ppc_sys_platform_devices[MPC8xx_CPM_SMC1];
-		pinfo = &mpc885_uart_pdata[0];
-	}
-
-	pinfo->uart_clk = bd->bi_intfreq;
-	pdev->dev.platform_data = pinfo;
-	ppc_sys_fixup_mem_resource(pdev, IMAP_ADDR);
-	return NULL;
-}
-
diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
index 9caf850..dcd08d4 100644
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -143,16 +143,6 @@ m8xx_setup_arch(void)
 #endif
 #endif

-#if defined (CONFIG_MPC86XADS) || defined (CONFIG_MPC885ADS)
-#if defined(CONFIG_MTD_PHYSMAP)
-       physmap_configure(binfo->bi_flashstart, binfo->bi_flashsize,
-                                               MPC8xxADS_BANK_WIDTH, NULL);
-#ifdef CONFIG_MTD_PARTITIONS
-       physmap_set_partitions(mpc8xxads_partitions, mpc8xxads_part_num);
-#endif /* CONFIG_MTD_PARTITIONS */
-#endif /* CONFIG_MTD_PHYSMAP */
-#endif
-
 	board_init();
 }

diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
index d3a2f2f..b9e3060 100644
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -63,10 +63,6 @@
 #include <platforms/lantec.h>
 #endif

-#if defined(CONFIG_MPC885ADS)
-#include <platforms/mpc885ads.h>
-#endif
-
 /* Currently, all 8xx boards that support a processor to PCI/ISA bridge
  * use the same memory map.
  */
-- 
1.5.4.1
