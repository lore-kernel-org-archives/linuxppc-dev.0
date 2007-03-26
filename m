Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id EAC89DDEF2
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 17:12:58 +1000 (EST)
Received: from ubuntu (achn-4db4987d.pool.einsundeins.de [77.180.152.125])
	by post.webmailer.de (fruni mo50) (RZmta 5.4)
	with ESMTP id B0579bj2Q2Hnar for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Mar 2007 09:12:54 +0200 (MEST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] ppc: Add support for AMCC 440EPx and 440GRx PPC's
Date: Mon, 26 Mar 2007 09:13:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703260913.27946.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds initial support for the AMCC 440EPx/440GRx PPC's. It's in
preparation for adding support for the AMCC eval boards Sequoia (440EPx)
and Rainier (440GRx).

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit 7a62196fb100073aebe46487160da1aa0e9b3c9e
tree 20345010893b44457d5285b65781fd04cf744bae
parent f33bc55c472295966e520c9347822fdd8b1082cd
author Stefan Roese <sr@denx.de> Mon, 26 Mar 2007 08:58:33 +0200
committer Stefan Roese <sr@denx.de> Mon, 26 Mar 2007 08:58:33 +0200

 arch/powerpc/kernel/cputable.c     |   40 +++++
 arch/ppc/kernel/head_44x.S         |    2 
 arch/ppc/platforms/4xx/Kconfig     |   34 ++++
 arch/ppc/platforms/4xx/Makefile    |    4 
 arch/ppc/platforms/4xx/ppc440epx.c |  289 ++++++++++++++++++++++++++++++++++++
 arch/ppc/platforms/4xx/ppc440epx.h |   85 +++++++++++
 arch/ppc/syslib/Makefile           |    4 
 arch/ppc/syslib/ibm44x_common.c    |   24 +++
 arch/ppc/syslib/ibm44x_common.h    |    3 
 arch/ppc/syslib/ppc4xx_pic.c       |   30 ++++
 include/asm-ppc/ibm44x.h           |  120 +++++++++++++--
 include/asm-ppc/ibm4xx.h           |    4 
 include/asm-ppc/ibm_ocp.h          |    7 +
 13 files changed, 627 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e4006dc..e0587e8 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1179,6 +1179,46 @@ static struct cpu_spec cpu_specs[] = {
 		.dcache_bsize		= 32,
 		.platform		= "ppc440",
 	},
+	{ /* 440EPx - with Security/Kasumi */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x200008D0,
+		.cpu_name		= "440EPx - with Security/Kasumi",
+		.cpu_features           = CPU_FTRS_44X,
+		.cpu_user_features      = COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.platform		= "ppc440",
+	},
+	{ /* 440EPx - without Security/Kasumi */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x200008D4,
+		.cpu_name		= "440EPx - no Security/Kasumi",
+		.cpu_features           = CPU_FTRS_44X,
+		.cpu_user_features      = COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.platform		= "ppc440",
+	},
+	{ /* 440GRx - with Security/Kasumi */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x200008D8,
+		.cpu_name		= "440GRx - with Security/Kasumi",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.platform		= "ppc440",
+	},
+	{ /* 440GRx - without Security/Kasumi */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x200008DC,
+		.cpu_name		= "440GRx - no Security/Kasumi",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.platform		= "ppc440",
+	},
 #endif /* CONFIG_44x */
 #ifdef CONFIG_FSL_BOOKE
 	{	/* e200z5 */
diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
index 7e44de5..17a6243 100644
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -227,7 +227,7 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
 
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
 	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
 	mfspr	r2,SPRN_CCR0
 	lis	r3,0xffef
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 705ae56..1d42ecc 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -98,6 +98,18 @@ config OCOTEA
 	help
 	  This option enables support for the IBM PPC440GX evaluation board.
 
+config RAINIER
+	bool "Rainier"
+	select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the AMCC PPC440GRx evaluation board.
+
+config SEQUOIA
+	bool "Sequoia"
+	select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the AMCC PPC440EPx evaluation board.
+
 config TAISHAN
 	bool "Taishan"
 	select WANT_EARLY_SERIAL
@@ -125,11 +137,22 @@ config 440EP
 	select PPC_FPU
 	default y
 
+config 440EPX
+	bool
+	depends on SEQUOIA
+	select PPC_FPU
+	default y
+
 config 440GP
 	bool
 	depends on EBONY
 	default y
 
+config 440GRX
+	bool
+	depends on RAINIER
+	default y
+
 config 440GX
 	bool
 	depends on OCOTEA || TAISHAN
@@ -152,7 +175,7 @@ config 440
 
 config 440A
 	bool
-	depends on 440GX
+	depends on 440GX || 440EPX || 440GRX
 	default y
 
 config IBM440EP_ERR42
@@ -179,12 +202,17 @@ config BOOKE
 
 config IBM_OCP
 	bool
-	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || TAISHAN || WALNUT
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || RAINIER || REDWOOD_5 || REDWOOD_6 || SEQUOIA || SYCAMORE || TAISHAN || WALNUT
 	default y
 
 config IBM_EMAC4
 	bool
-	depends on 440GX || 440SP || 440SPE
+	depends on 440EPX || 440GRX || 440GX || 440SP || 440SPE
+	default y
+
+config IBM_EMAC4V4
+	bool
+	depends on 440EPX || 440GRX
 	default y
 
 config BIOS_FIXUP
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index fa6610b..a91c604 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -9,8 +9,10 @@ obj-$(CONFIG_BUBINGA)		+= bubinga.o
 obj-$(CONFIG_LUAN)		+= luan.o
 obj-$(CONFIG_YUCCA)		+= yucca.o
 obj-$(CONFIG_OCOTEA)		+= ocotea.o
+obj-$(CONFIG_RAINIER)		+= sequoia.o
 obj-$(CONFIG_REDWOOD_5)		+= redwood5.o
 obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
+obj-$(CONFIG_SEQUOIA)		+= sequoia.o
 obj-$(CONFIG_SYCAMORE)		+= sycamore.o
 obj-$(CONFIG_TAISHAN)		+= taishan.o
 obj-$(CONFIG_WALNUT)		+= walnut.o
@@ -22,7 +24,9 @@ obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
 obj-$(CONFIG_NP405H)		+= ibmnp405h.o
 obj-$(CONFIG_REDWOOD_6)		+= ibmstbx25.o
 obj-$(CONFIG_440EP)		+= ibm440ep.o
+obj-$(CONFIG_440EPX)		+= ppc440epx.o
 obj-$(CONFIG_440GP)		+= ibm440gp.o
+obj-$(CONFIG_440GRX)		+= ppc440epx.o
 obj-$(CONFIG_440GX)		+= ibm440gx.o
 obj-$(CONFIG_440SP)		+= ibm440sp.o
 obj-$(CONFIG_440SPE)		+= ppc440spe.o
diff --git a/arch/ppc/platforms/4xx/ppc440epx.c b/arch/ppc/platforms/4xx/ppc440epx.c
new file mode 100644
index 0000000..35e6cd3
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ppc440epx.c
@@ -0,0 +1,289 @@
+/*
+ * arch/ppc/platforms/4xx/ppc440epx.c
+ *
+ * PPC440EPx I/O descriptions
+ *
+ * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004 MontaVista Software Inc.
+ * Copyright 2006 AMCC
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <platforms/4xx/ppc440epx.h>
+#include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
+
+static struct ocp_func_emac_data ppc440epx_emac0_def = {
+	.rgmii_idx	= 0,            /* RGMII device index */
+	.rgmii_mux	= 0,
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 0,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 0,            /* MAL rx channel number */
+	.mal_tx_chan    = 0,            /* MAL tx channel number */
+	.wol_irq        = 61,		/* WOL interrupt number - same as 440EP */
+	.mdio_idx       = -1,           /* No shared MDIO but always via ZMII bridge */
+	.tah_idx	= -1,           /* No TAH */
+	.txcoal_irq 	= 70,  		/* Interrupt coalescence TX IRQ */
+	.rxcoal_irq 	= 72,  		/* Interrupt coalescence RX IRQ */
+};
+
+static struct ocp_func_emac_data ppc440epx_emac1_def = {
+	.rgmii_idx	= 0,            /* RGMII */
+	.rgmii_mux	= 1,            /* RGMII */
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 1,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 1,            /* MAL rx channel number */
+	.mal_tx_chan    = 1,            /* MAL tx channel number */
+	.wol_irq        = 63,  		/* WOL interrupt number _- same as 440EP */
+	.mdio_idx       = -1,           /* no shared MDIO but always via ZMII bridge */
+	.tah_idx	= -1,           /* No TAH */
+	.txcoal_irq 	= 71,  		/* Interrupt coalescence TX IRQ */
+	.rxcoal_irq 	= 73,  		/* Interrupt coalescence RX IRQ */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ppc440epx_mal0_def = {
+	.num_tx_chans   = 2,  		/* Number of TX channels */
+	.num_rx_chans   = 2,    	/* Number of RX channels */
+	.txeob_irq	= 10,		/* TX End Of Buffer IRQ  - same as 440EP */
+	.rxeob_irq	= 11,		/* RX End Of Buffer IRQ  - same as 440EP*/
+	.txde_irq	= 33,		/* TX Descriptor Error IRQ - same as 440EP */
+	.rxde_irq	= 34,		/* RX Descriptor Error IRQ - same as 440EP*/
+	.serr_irq	= 32,		/* MAL System Error IRQ  - same as 440EP   */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data ppc440epx_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data ppc440epx_iic1_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0x1EF600000ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= PPC440EPX_UART0_ADDR,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= PPC440EPX_UART1_ADDR,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= PPC440EPX_UART2_ADDR,
+	  .irq		= UART2_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 3,
+	  .paddr	= PPC440EPX_UART3_ADDR,
+	  .irq		= UART3_INT,
+	  .pm		= IBM_CPM_UART3,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 0,
+	  .paddr	= 0x1EF600700ULL,
+	  .irq		= IIC0_INT,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ppc440epx_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 1,
+	  .paddr	= 0x1EF600800ULL,
+	  .irq		= IIC1_INT,
+	  .pm		= IBM_CPM_IIC1,
+	  .additions	= &ppc440epx_iic1_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 0,
+	  .paddr	= 0x1EF600B00ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 1,
+	  .paddr	= 0x1EF600C00ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ppc440epx_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= 0x1EF600E00ULL,
+	  .irq		= EMAC0_INT,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ppc440epx_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 1,
+	  .paddr	= 0x1EF600F00ULL,
+	  .irq		= EMAC1_INT,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ppc440epx_emac1_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_ZMII,
+	  .paddr	= 0x1EF600D00ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_RGMII,
+	  .paddr	= 0x1EF601000ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+/* 3 UIC */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity	= 0xffbff1ef,
+	  .triggering   = 0x00000800,
+	  .ext_irq_mask = 0x000000010,	/* IRQ4 */
+	},
+	{ .polarity	= 0xffffe7A5,
+	  .triggering	= 0x06000040,
+	  .ext_irq_mask = 0x0000380A,	/* IRQ7-IRQ8-IRQ9-IRQ0-IRQ1 */
+	},
+	{ .polarity	= 0x27ffffff,
+	  .triggering	= 0x03e00000,
+	  .ext_irq_mask = 0xd8000000,	/* IRQ5-IRQ6-IRQ2-IRQ3*/
+	},
+};
+
+static struct resource usb_gadget_resources[] = {
+	[0] = {
+		.start	= 0x0E0000100ULL,
+		.end 	= 0x0E000017FULL,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "usb_device_irq",
+		.start	= 20,
+		.end	= 20,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ohci_usb_resources[] = {
+	[0] = {
+		.start	= 0x0E0000400,
+		.end	= 0x0E00004FF,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 21,
+		.end	= 21,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ehci_usb_resources[] = {
+	[0] = {
+		.start	= 0x0E0000300,
+		.end	= 0x0E00003FF,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 26,
+		.end	= 26,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 dma_mask = 0xffffffffULL;
+
+static struct platform_device ohci_usb_device = {
+	.name		= "ppc-soc-ohci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ohci_usb_resources),
+	.resource	= ohci_usb_resources,
+	.dev		= {
+		.dma_mask = &dma_mask,
+		.coherent_dma_mask = 0xffffffffULL,
+	}
+};
+
+static struct platform_device usb_gadget_device = {
+	.name		= "musbhsfc_udc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(usb_gadget_resources),
+	.resource       = usb_gadget_resources,
+	.dev		= {
+		.dma_mask = &dma_mask,
+		.coherent_dma_mask = 0xffffffffULL,
+	}
+};
+
+static struct platform_device ehci_usb_device = {
+	.name		= "amcc-ehci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ehci_usb_resources),
+	.resource	= ehci_usb_resources,
+	.dev		= {
+		.dma_mask = &dma_mask,
+		.coherent_dma_mask = 0xffffffffULL,
+	}
+};
+
+static struct platform_device *ppc440epx_devs[] __initdata = {
+	&ohci_usb_device,
+	&ehci_usb_device,
+	&usb_gadget_device,
+};
+
+static int __init ppc440epx_platform_add_devices(void)
+{
+	return platform_add_devices(ppc440epx_devs, ARRAY_SIZE(ppc440epx_devs));
+}
+arch_initcall(ppc440epx_platform_add_devices);
diff --git a/arch/ppc/platforms/4xx/ppc440epx.h b/arch/ppc/platforms/4xx/ppc440epx.h
new file mode 100644
index 0000000..c882bd4
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ppc440epx.h
@@ -0,0 +1,85 @@
+/*
+ * arch/ppc/platforms/4xx/ppc440epx.h
+ *
+ * PPC440EPX definitions
+ *
+ * Copyright 2002 Roland Dreier
+ * Copyright 2004 MontaVista Software, Inc.
+ * Copyright 2006 AMCC.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __PPC_PLATFORMS_PPC440EPX_H
+#define __PPC_PLATFORMS_PPC440EPX_H
+
+#include <asm/ibm44x.h>
+
+/* Interrupt Assignements - used in OCP table definition */
+#define IIC0_INT			2
+#define IIC1_INT			7
+#define EMAC0_INT			24
+#define EMAC1_INT			25
+
+/* UART */
+#define PPC440EPX_UART0_ADDR		0x00000001EF600300ULL
+#define PPC440EPX_UART1_ADDR		0x00000001EF600400ULL
+#define PPC440EPX_UART2_ADDR		0x00000001EF600500ULL
+#define PPC440EPX_UART3_ADDR		0x00000001EF600600ULL
+#define UART0_INT			0
+#define UART1_INT			1
+#define UART2_INT			35
+#define UART3_INT			36
+
+/* IIC Bootstrap Registers */
+#define SDR0_CFGADDR		0x00E		/* System DCR Address Register */
+#define SDR0_CFGDATA		0x00F		/* System DCR Data Register */
+#define SDR0_SDSTP1		0x021		/* Serial Device Strap Register 1 */
+
+/* Clock and Power Management CPM0 */
+#define IBM_CPM_IIC0		0x80000000	/* IIC interface */
+#define IBM_CPM_IIC1		0x40000000	/* IIC interface */
+#define IBM_CPM_PCI		0x20000000	/* PCI bridge */
+#define IBM_CPM_USB1H		0x08000000	/* USB 1.1 Host */
+#define IBM_CPM_FPU		0x04000000	/* floating point unit */
+#define IBM_CPM_CPU		0x02000000	/* processor core */
+#define IBM_CPM_DMA		0x01000000	/* DMA controller */
+#define IBM_CPM_BGO		0x00800000	/* PLB3 to OPB bus arbiter */
+#define IBM_CPM_EBC		0x00200000	/* External Bus Controller */
+#define IBM_CPM_RGMII		0x00100000	/* Reduced Gigabit MII Bridge */
+#define IBM_CPM_DMC		0x00080000	/* SDRAM peripheral controller */
+#define IBM_CPM_PLB4		0x00040000	/* PLB4 bus arbiter */
+#define IBM_CPM_PLB4x3		0x00020000	/* PLB4 to PLB3 bridge controller */
+#define IBM_CPM_PLB3x4		0x00010000	/* PLB3 to PLB4 bridge controller */
+#define IBM_CPM_PLB3		0x00008000	/* PLB3 bus arbiter */
+#define IBM_CPM_NDFC 		0x00004000      /* NAND Flash Controller */
+#define IBM_CPM_UIC1		0x00001000	/* Universal Interrupt Controller */
+#define IBM_CPM_GPIO0		0x00000800	/* General Purpose IO (??) */
+#define IBM_CPM_GPT		0x00000400	/* General Purpose Timers  */
+#define IBM_CPM_UART0		0x00000200	/* serial port 0 */
+#define IBM_CPM_UART1		0x00000100	/* serial port 1 */
+#define IBM_CPM_UIC0		0x00000080	/* Universal Interrupt Controller */
+#define IBM_CPM_TMRCLK		0x00000040	/* CPU timers */
+#define IBM_CPM_EMAC0		0x00000020	/* ethernet port 0 */
+#define IBM_CPM_UART2		0x00000010	/* serial port 2 */
+#define IBM_CPM_UART3		0x00000008	/* serial port 3 */
+#define IBM_CPM_EMAC1		0x00000004	/* ethernet port 1 */
+#define IBM_CPM_P42OPB1		0x00000002	/* USB 2.0 Host*/
+#define IBM_CPM_OPB2P4		0x00000001	/* USB 2.0 Host */
+
+/* Clock and Power Management CPM1*/
+#define IBM_CPM_UIC2		0x80000000	/* Universal Interrupt Controller 2 */
+#define IBM_CPM_SRAM0		0x40000000	/* Internal SRAM Controller */
+#define IBM_CPM_MAL0		0x20000000	/* Memory Access Layer */
+#define IBM_CPM_USB2D0		0x10000000	/* USB2.0 Device */
+#define IBM_CPM_USB2H		0x08000000	/* USB 2.0 HOST */
+#define IBM_CPM_CRYP0		0x04000000	/* Security Engine */
+#define IBM_CPM_KASU0		0x02000000	/* Kasumi Engine */
+
+#endif /* __PPC_PLATFORMS_PPC440EPX_H */
+#endif /* __KERNEL__ */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 0991111..553417c 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -12,7 +12,9 @@ obj-$(CONFIG_PPC_OCP)		+= ocp.o
 obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
 obj-$(CONFIG_44x)		+= ibm44x_common.o
 obj-$(CONFIG_440EP)		+= ibm440gx_common.o
+obj-$(CONFIG_440EPX)		+= ibm440gx_common.o
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
+obj-$(CONFIG_440GRX)		+= ibm440gx_common.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
 obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
 obj-$(CONFIG_440SPE)		+= ibm440gx_common.o ibm440sp_common.o ppc440spe_pcie.o
@@ -65,8 +67,10 @@ obj-$(CONFIG_PRPMC750)		+= open_pic.o pci_auto.o \
 obj-$(CONFIG_HARRIER)		+= harrier.o
 obj-$(CONFIG_PRPMC800)		+= open_pic.o pci_auto.o
 obj-$(CONFIG_RADSTONE_PPC7D)	+= pci_auto.o
+obj-$(CONFIG_RAINIER)		+= pci_auto.o
 obj-$(CONFIG_SANDPOINT)		+= pci_auto.o todc_time.o
 obj-$(CONFIG_SBC82xx)		+= todc_time.o
+obj-$(CONFIG_SEQUOIA)		+= pci_auto.o
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o pci_auto.o \
 				   todc_time.o
 obj-$(CONFIG_TAISHAN)		+= pci_auto.o
diff --git a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
index 01f99b4..555d83c 100644
--- a/arch/ppc/syslib/ibm44x_common.c
+++ b/arch/ppc/syslib/ibm44x_common.c
@@ -221,6 +221,30 @@ void platform_machine_check(struct pt_regs *regs)
 	       mfdcr(DCRN_PLB1_BEARH), mfdcr(DCRN_PLB1_BEARL),
 	       mfdcr(DCRN_PLB1_ACR), mfdcr(DCRN_PLB1_BESRH),
 	       mfdcr(DCRN_PLB1_BESRL));
+#elif defined(CONFIG_440EPX)|| defined(CONFIG_440GRX)
+     	printk("OPB to PLB3: BSTAT= 0x%08x\n",
+	       mfdcr(DCRN_OPB2PLB30_BSTAT));
+	printk("PLB3 to PLB4: BEAR=0x%08x%08x BESR0=0x%08x BESR1=0x%08x\n",
+	       mfdcr(DCRN_P3P4BI0_BEARH), mfdcr(DCRN_P3P4BI0_BEARL),
+	       mfdcr(DCRN_P3P4BI0_BESR0), mfdcr(DCRN_P3P4BI0_BESR1));
+	printk("PLB4 to PLB3: BEAR=0x%08x%08x BESR0=0x%08x BESR1=0x%08x\n",
+	       mfdcr(DCRN_P4P3BO0_BEARH), mfdcr(DCRN_P4P3BO0_BEARL),
+	       mfdcr(DCRN_P4P3BO0_BESR0), mfdcr(DCRN_P4P3BO0_BESR1));
+	printk("PLB3 to OPB: BEAR=0x%08x BESR0=0x%08x BESR1=0x%08x\n",
+	       mfdcr(DCRN_PLB32OPB0_BEAR),
+	       mfdcr(DCRN_PLB32OPB0_BESR0), mfdcr(DCRN_PLB32OPB0_BESR1));
+	printk("PLB3 arbiter: BEAR=0x%08x ACR=0x%08x BESR=0x%08x\n",
+	       mfdcr(DCRN_PLB3A0_BEAR),
+	       mfdcr(DCRN_PLB3A0_ACR),  mfdcr(DCRN_PLB3A0_BESR));
+	printk("PLB4 to OPB1: BEAR=0x%08x%08x BESR0=0x%08x BESR1=0x%08x\n",
+	       mfdcr(DCRN_PLB42OPB1_BEARH), mfdcr(DCRN_PLB42OPB1_BEARL),
+	       mfdcr(DCRN_PLB42OPB1_BESR0), mfdcr(DCRN_PLB42OPB1_BESR1));
+	printk("PLB40 Arbiter: BEAR=0x%08x%08x ACR=0x%08x BESR0=0x%08x\n",
+	       mfdcr(DCRN_PLB4A0_BEARH), mfdcr(DCRN_PLB4A0_BEARL),
+	       mfdcr(DCRN_PLB4A0_ACR), mfdcr(DCRN_PLB4A0_BESR));
+	printk("PLB41 Arbiter: BEAR=0x%08x%08x ACR=0x%08x BESR0=0x%08x\n",
+	       mfdcr(DCRN_PLB4A1_BEARH), mfdcr(DCRN_PLB4A1_BEARL),
+	       mfdcr(DCRN_PLB4A1_ACR), mfdcr(DCRN_PLB4A1_BESR));
 #else
     	printk("PLB0: BEAR=0x%08x%08x ACR=  0x%08x BESR= 0x%08x\n",
 		mfdcr(DCRN_PLB0_BEARH), mfdcr(DCRN_PLB0_BEARL),
diff --git a/arch/ppc/syslib/ibm44x_common.h b/arch/ppc/syslib/ibm44x_common.h
index f179db8..5fb0e18 100644
--- a/arch/ppc/syslib/ibm44x_common.h
+++ b/arch/ppc/syslib/ibm44x_common.h
@@ -27,7 +27,8 @@ struct ibm44x_clocks {
 	unsigned int ebc;	/* PerClk */
 	unsigned int uart0;
 	unsigned int uart1;
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 	unsigned int uart2;
 	unsigned int uart3;
 #endif
diff --git a/arch/ppc/syslib/ppc4xx_pic.c b/arch/ppc/syslib/ppc4xx_pic.c
index ee0da4b..0e5b2aa 100644
--- a/arch/ppc/syslib/ppc4xx_pic.c
+++ b/arch/ppc/syslib/ppc4xx_pic.c
@@ -118,6 +118,35 @@ static void __init ppc4xx_pic_impl_init(void)
 }
 
 #elif NR_UICS == 3
+#if defined(CONFIG_440EPX)|| defined(CONFIG_440GRX)
+#define ACK_UIC0_PARENT
+#define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC);
+#define ACK_UIC2_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC2NC);
+UIC_HANDLERS(0);
+UIC_HANDLERS(1);
+UIC_HANDLERS(2);
+
+static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+{
+	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
+	if (uic0 & UIC0_UIC1NC)
+		return 64 - ffs(mfdcr(DCRN_UIC_MSR(UIC1)));
+	else if (uic0 & UIC0_UIC2NC)
+		return 96 - ffs(mfdcr(DCRN_UIC_MSR(UIC2)));
+	else
+		return uic0 ? 32 - ffs(uic0) : -1;
+}
+
+static void __init ppc4xx_pic_impl_init(void)
+{
+	/* Enable cascade interrupts in UIC0 */
+	ppc_cached_irq_mask[0] |= UIC0_UIC1NC | UIC0_UIC2NC;
+	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC | UIC0_UIC2NC );
+	mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[0]);
+}
+
+#else /* #if defined(CONFIG_440EPX)|| defined(CONFIG_440GRX) */
+
 #define ACK_UIC0_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC0NC);
 #define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC1NC);
 #define ACK_UIC2_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC2NC);
@@ -152,6 +181,7 @@ static void __init ppc4xx_pic_impl_init(void)
 	mtdcr(DCRN_UIC_ER(UICB), UICB_UIC0NC | UICB_UIC1NC | UICB_UIC2NC);
 }
 
+#endif /* #if defined(CONFIG_440EPX)|| defined(CONFIG_440GRX) */
 #elif NR_UICS == 2
 #define ACK_UIC0_PARENT
 #define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC);
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
index 7818b54..7906761 100644
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -43,8 +43,12 @@
 #elif defined(CONFIG_440SPE)
 #define UART0_PHYS_ERPN		4
 #define UART0_PHYS_IO_BASE	0xf0000200
-#elif defined(CONFIG_440EP)
-#define UART0_PHYS_IO_BASE	0xe0000000
+#elif defined(CONFIG_440EP) || defined(CONFIG_440GR) || \
+      defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+#define UART0_PHYS_IO_BASE	0xef600300
+#if defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+#define UART0_PHYS_ERPN		1
+#endif
 #else
 #define UART0_PHYS_ERPN		1
 #define UART0_PHYS_IO_BASE	0x40000200
@@ -73,6 +77,11 @@
 #define PPC44x_PCICFG_PAGE	0x0000000000000000ULL
 #define PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
 #define PPC44x_PCIMEM_PAGE	0x0000000000000000ULL
+#elif defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+#define PPC44x_IO_PAGE		0x0000000100000000ULL
+#define PPC44x_PCICFG_PAGE	0x0000000100000000ULL
+#define PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
+#define PPC44x_PCIMEM_PAGE	0x0000000100000000ULL
 #else
 #define	PPC44x_IO_PAGE		0x0000000100000000ULL
 #define	PPC44x_PCICFG_PAGE	0x0000000200000000ULL
@@ -101,6 +110,13 @@
 #define PPC44x_PCI0CFG_HI	0xeecfffffUL
 #define PPC44x_PCIMEM_LO	0xa0000000UL
 #define PPC44x_PCIMEM_HI	0xdfffffffUL
+#elif defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+#define PPC44x_IO_LO		0xe8000000UL
+#define PPC44x_IO_HI		0xffffffffUL
+#define PPC44x_PCI0CFG_LO	0xeec00000UL
+#define PPC44x_PCI0CFG_HI	0xeecfffffUL
+#define PPC44x_PCIMEM_LO	0x80000000UL
+#define PPC44x_PCIMEM_HI	0xbfffffffUL
 #else
 #define PPC44x_IO_LO		0x40000000UL
 #define PPC44x_IO_HI		0x40000fffUL
@@ -178,7 +194,8 @@
 #define DCRN_SDR_UART0		0x0120
 #define DCRN_SDR_UART1		0x0121
 
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define DCRN_SDR_UART2		0x0122
 #define DCRN_SDR_UART3		0x0123
 #define DCRN_SDR_CUST0		0x4000
@@ -201,7 +218,8 @@
 #define DCRNCAP_DMA_SG		1	/* have DMA scatter/gather capability */
 #define DCRN_MAL_BASE		0x180
 
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define DCRN_DMA2P40_BASE	0x300
 #define DCRN_DMA2P41_BASE	0x308
 #define DCRN_DMA2P42_BASE	0x310
@@ -215,17 +233,22 @@
 #define UIC0		DCRN_UIC0_BASE
 #define UIC1		DCRN_UIC1_BASE
 
-#ifdef CONFIG_440SPE
+#if defined(CONFIG_440SPE) || defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define DCRN_UIC2_BASE	0xe0
+#if defined(CONFIG_440SPE)
 #define DCRN_UIC3_BASE	0xf0
-#define UIC2		DCRN_UIC2_BASE
-#define UIC3		DCRN_UIC3_BASE
+#endif
 #else
 #define DCRN_UIC2_BASE	0x210
 #define DCRN_UICB_BASE	0x200
-#define UIC2		DCRN_UIC2_BASE
 #define UICB		DCRN_UICB_BASE
 #endif
+#ifdef DCRN_UIC2_BASE
+#define UIC2		DCRN_UIC2_BASE
+#endif
+#ifdef DCRN_UIC3_BASE
+#define UIC3		DCRN_UIC3_BASE
+#endif
 
 #define DCRN_UIC_SR(base)       (base + 0x0)
 #define DCRN_UIC_ER(base)       (base + 0x2)
@@ -238,10 +261,12 @@
 
 #define UIC0_UIC1NC      	0x00000002
 
-#ifdef CONFIG_440SPE
-#define UIC0_UIC1NC      0x00000002
-#define UIC0_UIC2NC      0x00200000
-#define UIC0_UIC3NC      0x00008000
+#if defined(CONFIG_440SPE)
+#define UIC0_UIC2NC		0x00200000
+#define UIC0_UIC3NC		0x00008000
+#endif
+#if defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+#define UIC0_UIC2NC		0x00000008
 #endif
 
 #define UICB_UIC0NC		0x40000000
@@ -339,6 +364,51 @@
 #define DCRN_PLB1_BESRH		0x08b		/* PLB Error Status */
 #define DCRN_PLB1_BEARL		0x08c		/* PLB Error Address Low */
 #define DCRN_PLB1_BEARH		0x08d		/* PLB Error Address High */
+#elif defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+/* EBC error Status */
+#define DCRN_EBC0_BEAR		0x020
+#define DCRN_EBC0_BESR0		0x021
+
+/* OPB to PLB3 Bridge  DCRs */
+#define DCRN_OPB2PLB30_BSTAT	0x0A9
+
+/* PLB3 to PLB4 bridge DCRs */
+#define DCRN_P3P4BI0_BESR0	0x030
+#define DCRN_P3P4BI0_BEARL	0x032
+#define DCRN_P3P4BI0_BEARH	0x033
+#define DCRN_P3P4BI0_BESR1	0x034
+
+/* PLB4 to PLB3 bridge DCRs */
+#define DCRN_P4P3BO0_BESR0	0x020
+#define DCRN_P4P3BO0_BEARL	0x022
+#define DCRN_P4P3BO0_BEARH	0x023
+#define DCRN_P4P3BO0_BESR1	0x024
+
+/* PLB3 to OPB  bridge DCRs */
+#define DCRN_PLB32OPB0_BEAR	0x092
+#define DCRN_PLB32OPB0_BESR0	0x090
+#define DCRN_PLB32OPB0_BESR1	0x094
+
+/* PLB3 Arbiter DCRs */
+#define DCRN_PLB3A0_ACR		0x077
+#define DCRN_PLB3A0_BEAR	0x076
+#define DCRN_PLB3A0_BESR	0x074
+
+/* PLB4 to OPB1 Bridge DCRs */
+#define DCRN_PLB42OPB1_BEARH	0x0203
+#define DCRN_PLB42OPB1_BEARL	0x0202
+#define DCRN_PLB42OPB1_BESR0	0x0200
+#define DCRN_PLB42OPB1_BESR1	0x0204
+
+/* PLB4 Arbiter DCRs */
+#define DCRN_PLB4A0_ACR		0x081
+#define DCRN_PLB4A0_BEARH	0x085
+#define DCRN_PLB4A0_BEARL	0x084
+#define DCRN_PLB4A0_BESR	0x082
+#define DCRN_PLB4A1_ACR		0x089
+#define DCRN_PLB4A1_BEARH	0x08D
+#define DCRN_PLB4A1_BEARL	0x08C
+#define DCRN_PLB4A1_BESR	0x08A
 #else
 /* 440GP/GX PLB Arbiter DCRs */
 #define DCRN_PLB0_REVID		0x082		/* PLB Arbiter Revision ID */
@@ -471,8 +541,12 @@
 #define MQ0_CONFIG_SIZE_2G		0x0000c000
 #define MQ0_CONFIG_SIZE_4G		0x00008000
 
-/* Internal SRAM Controller 440GX/440SP/440SPe */
+/* Internal SRAM Controller 440GX/440SP/440SPe/440EPx/440GRx */
+#if defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+#define DCRN_SRAM0_BASE		0x360
+#else
 #define DCRN_SRAM0_BASE		0x000
+#endif
 
 #define DCRN_SRAM0_SB0CR	(DCRN_SRAM0_BASE + 0x020)
 #define DCRN_SRAM0_SB1CR	(DCRN_SRAM0_BASE + 0x021)
@@ -658,8 +732,26 @@
 #define IIC_OWN			0x55
 #define IIC_CLOCK		50
 
+/*
+ * EMAC interrupt coalesing (only 440EPX/GRX for now)
+ */
+#if defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+#define MAX_COAL_FRAMES		0x1FF
+#define MAX_COAL_TIMER		0xFFFFFFFF
+
+#define	DCRN_SDR_ICSRTX0	0x4307
+#define	DCRN_SDR_ICSRRX0	0x4309
+#define DCRN_SDR_ICCRTX		0x430B
+#define DCRN_SDR_ICCRTX_INIT	0x00C01800
+#define	DCRN_SDR_ICCRRX		0x430C
+#define DCRN_SDR_ICCRRX_INIT	0x00C01800
+#define ICCR_FTHR_MASK		0xFF800000
+#define	DCRN_SDR_ICTRTX0	0x430D
+#define	DCRN_SDR_ICTRRX0	0x430F
+#endif
+
 #undef NR_UICS
-#if defined(CONFIG_440GX)
+#if defined(CONFIG_440GX) || defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define NR_UICS 3
 #elif defined(CONFIG_440SPE)
 #define NR_UICS 4
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index 92fd02d..6945d9b 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -109,6 +109,10 @@ void ppc4xx_init(unsigned long r3, unsigned long r4, unsigned long r5,
 #include <platforms/4xx/ocotea.h>
 #endif
 
+#if defined(CONFIG_SEQUOIA) || defined(CONFIG_RAINIER)
+#include <platforms/4xx/sequoia.h>
+#endif
+
 #if defined(CONFIG_TAISHAN)
 #include <platforms/4xx/taishan.h>
 #endif
diff --git a/include/asm-ppc/ibm_ocp.h b/include/asm-ppc/ibm_ocp.h
index ddce616..66d376b 100644
--- a/include/asm-ppc/ibm_ocp.h
+++ b/include/asm-ppc/ibm_ocp.h
@@ -28,6 +28,7 @@
 struct ocp_sys_info_data {
 	int	opb_bus_freq;	/* OPB Bus Frequency (Hz) */
 	int	ebc_bus_freq;	/* EBC Bus Frequency (Hz) */
+	int	plb_bus_freq;	/* PLB Bus Frequency (Hz) */
 };
 
 extern struct ocp_sys_info_data ocp_sys_info;
@@ -67,6 +68,8 @@ struct ocp_func_emac_data {
 	u8	mac_addr[6];	/* EMAC mac address */
 	u32	phy_map;	/* EMAC phy map */
 	u32	phy_feat_exc;	/* Excluded PHY features */
+	int 	txcoal_irq;	/* Interrupt coalescence TX IRQ  */
+	int 	rxcoal_irq;	/* Interrupt coalescence RX IRQ */
 };
 
 /* Sysfs support */
@@ -84,6 +87,8 @@ OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, tah_idx)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, phy_mode)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "0x%08x\n", emac, phy_map)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "0x%08x\n", emac, phy_feat_exc)\
+OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, txcoal_irq)	\
+OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, rxcoal_irq)	\
 									\
 void ocp_show_emac_data(struct device *dev)				\
 {									\
@@ -100,6 +105,8 @@ void ocp_show_emac_data(struct device *dev)				\
 	device_create_file(dev, &dev_attr_emac_phy_mode);		\
 	device_create_file(dev, &dev_attr_emac_phy_map);		\
 	device_create_file(dev, &dev_attr_emac_phy_feat_exc);		\
+	device_create_file(dev, &dev_attr_emac_txcoal_irq);		\
+	device_create_file(dev, &dev_attr_emac_rxcoal_irq);		\
 }
 
 /*
