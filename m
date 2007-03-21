Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4F4D6DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 01:50:54 +1100 (EST)
Received: from [192.168.12.21] (unknown [10.149.0.1])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id B07558814
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 18:50:51 +0400 (SAMT)
Message-ID: <4601461E.9010006@ru.mvista.com>
Date: Wed, 21 Mar 2007 17:50:06 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] PPC440EPx/440GRx Sequoia/Rainier board support.
References: <460034D0.5030503@ru.mvista.com> <200703211426.55297.sr@denx.de>
In-Reply-To: <200703211426.55297.sr@denx.de>
Content-Type: multipart/mixed; boundary="------------060908080904040202010908"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060908080904040202010908
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Add AMCC PPC440EPx/440GRx Sequoia/Rainier board support.

Signed-off-by: Stefan Roese <sr@denx.de>
Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

--------------060908080904040202010908
Content-Type: text/plain;
 name="ppc440epx_sequoia.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc440epx_sequoia.patch"

diff -ruN linux.orig/arch/powerpc/kernel/cputable.c linux/arch/powerpc/kernel/cputable.c
--- linux.orig/arch/powerpc/kernel/cputable.c	2007-03-16 18:03:20.000000000 +0300
+++ linux/arch/powerpc/kernel/cputable.c	2007-03-18 18:53:08.000000000 +0300
@@ -1179,6 +1179,46 @@
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
diff -ruN linux.orig/arch/ppc/kernel/head_44x.S linux/arch/ppc/kernel/head_44x.S
--- linux.orig/arch/ppc/kernel/head_44x.S	2007-03-16 18:03:23.000000000 +0300
+++ linux/arch/ppc/kernel/head_44x.S	2007-03-18 18:53:08.000000000 +0300
@@ -227,7 +227,7 @@
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
 
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
 	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
 	mfspr	r2,SPRN_CCR0
 	lis	r3,0xffef
diff -ruN linux.orig/arch/ppc/platforms/4xx/Kconfig linux/arch/ppc/platforms/4xx/Kconfig
--- linux.orig/arch/ppc/platforms/4xx/Kconfig	2007-03-16 18:03:23.000000000 +0300
+++ linux/arch/ppc/platforms/4xx/Kconfig	2007-03-18 18:53:08.000000000 +0300
@@ -104,6 +104,18 @@
 	help
 	  This option enables support for the AMCC PPC440GX evaluation board.
 
+config SEQUOIA
+	bool "Sequoia"
+	select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the AMCC PPC440EPx evaluation board.
+
+config RAINIER
+	bool "Rainier"
+	select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the AMCC PPC440GRx evaluation board.
+
 endchoice
 
 config EP405PC
@@ -125,6 +137,17 @@
 	select PPC_FPU
 	default y
 
+config 440EPX
+	bool
+	depends on SEQUOIA
+	select PPC_FPU
+	default y
+
+config 440GRX
+	bool
+	depends on RAINIER
+	default y
+
 config 440GP
 	bool
 	depends on EBONY
@@ -152,7 +175,7 @@
 
 config 440A
 	bool
-	depends on 440GX
+	depends on 440GX || 440EPX || 440GRX
 	default y
 
 config IBM440EP_ERR42
@@ -179,12 +202,17 @@
 
 config IBM_OCP
 	bool
-	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || TAISHAN || WALNUT
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || REDWOOD_5 || REDWOOD_6 || SEQUOIA || RAINIER || SYCAMORE || TAISHAN || WALNUT
 	default y
 
 config IBM_EMAC4
 	bool
-	depends on 440GX || 440SP || 440SPE
+	depends on 440GX || 440SP || 440SPE || 440EPX || 440GRX
+	default y
+
+config IBM_EMAC4V4
+	bool
+	depends on 440EPX || 440GRX
 	default y
 
 config BIOS_FIXUP
diff -ruN linux.orig/arch/ppc/platforms/4xx/Makefile linux/arch/ppc/platforms/4xx/Makefile
--- linux.orig/arch/ppc/platforms/4xx/Makefile	2007-03-16 18:03:23.000000000 +0300
+++ linux/arch/ppc/platforms/4xx/Makefile	2007-03-18 18:53:08.000000000 +0300
@@ -9,8 +9,10 @@
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
@@ -22,7 +24,9 @@
 obj-$(CONFIG_NP405H)		+= ibmnp405h.o
 obj-$(CONFIG_REDWOOD_6)		+= ibmstbx25.o
 obj-$(CONFIG_440EP)		+= ibm440ep.o
+obj-$(CONFIG_440EPX)		+= ppc440epx.o
 obj-$(CONFIG_440GP)		+= ibm440gp.o
+obj-$(CONFIG_440GRX)		+= ppc440epx.o
 obj-$(CONFIG_440GX)		+= ibm440gx.o
 obj-$(CONFIG_440SP)		+= ibm440sp.o
 obj-$(CONFIG_440SPE)		+= ppc440spe.o
diff -ruN linux.orig/arch/ppc/platforms/4xx/ppc440epx.c linux/arch/ppc/platforms/4xx/ppc440epx.c
--- linux.orig/arch/ppc/platforms/4xx/ppc440epx.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/arch/ppc/platforms/4xx/ppc440epx.c	2007-03-20 14:43:37.000000000 +0300
@@ -0,0 +1,284 @@
+/*
+ * arch/ppc/platforms/4xx/ppc440epx.c
+ *
+ * PPC440EPx I/O descriptions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004-2007 MontaVista Software Inc.
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
+/* TODO: include CONFIG_INTR_COALESCE */
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
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ppc440epx_mal0_def = {
+	.num_tx_chans   = 2,  		/* Number of TX channels */
+	.num_rx_chans   = 2,    	/* Number of RX channels */
+	.txeob_irq	= 10,		/* TX End Of Buffer IRQ  - same as 440EP */
+	.rxeob_irq	= 11,		/* RX End Of Buffer IRQ  - same as 440EP*/
+	.txde_irq	  = 33,		/* TX Descriptor Error IRQ - same as 440EP */
+	.rxde_irq	  = 34,		/* RX Descriptor Error IRQ - same as 440EP*/
+	.serr_irq	  = 32,		/* MAL System Error IRQ  - same as 440EP   */
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
+	.name		= "ppc-soc-ehci",
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
diff -ruN linux.orig/arch/ppc/platforms/4xx/ppc440epx.h linux/arch/ppc/platforms/4xx/ppc440epx.h
--- linux.orig/arch/ppc/platforms/4xx/ppc440epx.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/arch/ppc/platforms/4xx/ppc440epx.h	2007-03-20 14:42:10.000000000 +0300
@@ -0,0 +1,85 @@
+/*
+ * arch/ppc/platforms/4xx/ppc440epx.h
+ *
+ * PPC440EPX definitions
+ *
+ * Copyright 2002 Roland Dreier
+ * Copyright 2004-2007 MontaVista Software, Inc.
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
diff -ruN linux.orig/arch/ppc/platforms/4xx/sequoia.c linux/arch/ppc/platforms/4xx/sequoia.c
--- linux.orig/arch/ppc/platforms/4xx/sequoia.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/arch/ppc/platforms/4xx/sequoia.c	2007-03-20 14:41:08.000000000 +0300
@@ -0,0 +1,557 @@
+/*
+ * arch/ppc/platforms/4xx/sequoia.c
+ *
+ * Sequoia board specific routines
+ *
+ * Copyright 2006-2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * Based on bamboo.c from Wade Farnsworth <wfarnsworth@mvista.com>
+ *	Copyright 2004-2007 MontaVista Software Inc.
+ *	Copyright 2006 AMCC
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/initrd.h>
+#include <linux/irq.h>
+#include <linux/root_dev.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/ndfc.h>
+#include <linux/mtd/physmap.h>
+
+#include <asm/machdep.h>
+#include <asm/ocp.h>
+#include <asm/bootinfo.h>
+#include <asm/ppc4xx_pic.h>
+#include <asm/ppcboot.h>
+
+#include <syslib/gen550.h>
+#include <syslib/ibm440gx_common.h>
+
+#ifdef CONFIG_SEQUOIA
+#define BOARDNAME  "440EPx Sequoia"
+#else
+#define BOARDNAME  "440GRx Rainier"
+#endif
+
+extern bd_t __res;
+
+static struct ibm44x_clocks clocks __initdata;
+
+/*
+ * Sequoia external IRQ triggering/polarity settings
+ */
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index0 - IRQ4: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index1 - IRQ7: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index2 - IRQ8: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index3 - IRQ9: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index4 - IRQ0: Ethernet 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index5 - IRQ1: Ethernet 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index6 - IRQ5: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index7 - IRQ6: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index8 - IRQ2: PCI slots */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* Index9 - IRQ3: STTM alert */
+};
+
+/*
+ * NOR FLASH configuration (using mtd physmap driver)
+ */
+
+/* start will be added dynamically, end is always fixed */
+static struct resource sequoia_nor_resource = {
+		.end   = 0xffffffff,
+		.flags = IORESOURCE_MEM,
+};
+
+#define RW_PART0_OF	0
+#define RW_PART0_SZ	0x180000
+#define RW_PART1_SZ	0x280000
+/* Partition 2 will be autosized dynamically... */
+#define RW_PART3_SZ	0x40000
+#define RW_PART4_SZ	0x80000
+
+static struct mtd_partition sequoia_nor_parts[] = {
+	{
+		.name = "kernel",
+		.offset = 0,
+		.size = RW_PART0_SZ
+	},
+	{
+		.name = "root",
+		.offset = MTDPART_OFS_APPEND,
+		.size = RW_PART1_SZ,
+	},
+	{
+		.name = "user",
+		.offset = MTDPART_OFS_APPEND,
+/*		.size = RW_PART2_SZ */ /* will be adjusted dynamically */
+	},
+	{
+		.name = "env",
+		.offset = MTDPART_OFS_APPEND,
+		.size = RW_PART3_SZ,
+	},
+	{
+		.name = "u-boot",
+		.offset = MTDPART_OFS_APPEND,
+		.size = RW_PART4_SZ,
+	}
+};
+
+static struct physmap_flash_data sequoia_nor_data = {
+	.width		= 2,
+	.parts		= sequoia_nor_parts,
+	.nr_parts	= ARRAY_SIZE(sequoia_nor_parts),
+};
+
+static struct platform_device sequoia_nor_device = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev = {
+			.platform_data = &sequoia_nor_data,
+		},
+	.num_resources	= 1,
+	.resource	= &sequoia_nor_resource,
+};
+
+/*
+ * NAND FLASH configuration (using 440EP(x) NDFC)
+ */
+static struct resource sequoia_ndfc = {
+	.start = (u32)SEQUOIA_NAND_FLASH_REG_ADDR,
+	.end = (u32)SEQUOIA_NAND_FLASH_REG_ADDR + SEQUOIA_NAND_FLASH_REG_SIZE,
+	.flags = IORESOURCE_MEM,
+};
+
+/* TODO: add logic to detect booting from NAND (NAND on CS0) */
+#define CS_NAND_0	3	/* use chip select 3 for NAND device 0 */
+
+static struct mtd_partition sequoia_nand_parts[] = {
+        {
+                .name   = "content",
+                .offset = 0,
+                .size   = MTDPART_SIZ_FULL,
+        }
+};
+
+struct ndfc_controller_settings sequoia_ndfc_settings = {
+	.ccr_settings = (NDFC_CCR_BS(CS_NAND_0) |
+			 NDFC_CCR_ARAC1),
+	.ndfc_erpn = (SEQUOIA_NAND_FLASH_REG_ADDR) & ~0xffffffffull,
+};
+
+struct platform_nand_ctrl sequoia_nand_ctrl = {
+	.priv = &sequoia_ndfc_settings,
+};
+
+static struct platform_device sequoia_ndfc_device = {
+	.name = "ndfc-nand",
+	.id = 0,
+	.dev = {
+		.platform_data = &sequoia_nand_ctrl,
+	},
+	.num_resources = 1,
+	.resource = &sequoia_ndfc,
+};
+
+static struct ndfc_chip_settings sequoia_chip0_settings = {
+	.bank_settings = 0x80002222,
+};
+
+static struct nand_ecclayout nand_oob_16 = {
+	.eccbytes = 6,
+	.eccpos = {9, 10, 11, 13, 14, 15},
+	.oobfree = {
+		 {.offset = 8,
+		  . length = 8}}
+};
+
+static struct platform_nand_chip sequoia_nand_chip0 = {
+	.nr_chips = 1,
+	.chip_offset = CS_NAND_0,
+	.nr_partitions = ARRAY_SIZE(sequoia_nand_parts),
+	.partitions = sequoia_nand_parts,
+	.chip_delay = 50,
+	.ecclayout = &nand_oob_16,
+	.priv = &sequoia_chip0_settings,
+};
+
+static struct platform_device sequoia_nand_device = {
+	.name = "ndfc-chip",
+	.id = 0,
+	.num_resources = 1,
+	.resource = &sequoia_ndfc,
+	.dev = {
+		.platform_data = &sequoia_nand_chip0,
+		.parent = &sequoia_ndfc_device.dev,
+	}
+};
+
+static int sequoia_setup_flash(void)
+{
+	sequoia_nor_resource.start = __res.bi_flashstart;
+
+	/*
+	 * Adjust partition 2 to flash size
+	 */
+	sequoia_nor_parts[2].size = __res.bi_flashsize -
+		RW_PART0_SZ - RW_PART1_SZ - RW_PART3_SZ - RW_PART4_SZ;
+
+	platform_device_register(&sequoia_nor_device);
+
+	/* todo: add logic to detect booting from NAND (NAND on CS0) */
+
+	platform_device_register(&sequoia_ndfc_device);
+	platform_device_register(&sequoia_nand_device);
+
+	return 0;
+}
+arch_initcall(sequoia_setup_flash);
+
+/*
+ * get size of system memory from Board Info .
+ */
+unsigned long __init sequoia_find_end_of_memory(void)
+{
+	/* board info structure defined in /include/asm-ppc/ppcboot.h */
+	return  __res.bi_memsize;
+}
+
+static void __init sequoia_calibrate_decr(void)
+{
+	unsigned int freq;
+
+	if (mfspr(SPRN_CCR1) & CCR1_TCS)
+		freq = SEQUOIA_TMRCLK;
+	else
+		freq = clocks.cpu;
+
+	ibm44x_calibrate_decr(freq);
+
+}
+
+static int sequoia_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: AMCC\n");
+	seq_printf(m, "machine\t\t: PPC" BOARDNAME "\n");
+
+	return 0;
+}
+
+static inline int
+sequoia_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *	PCI IDSEL/INTPIN->INTLINE
+	 * 	   A   B   C   D
+	 */
+	{
+		{ 67, 67, 67, 67 },	/* IDSEL 10 - PCI Slot 1, ext. IRQ 2 */
+		{ 67, 67, 67, 67 },	/* IDSEL 11 - PCI Slot x, ext. IRQ 2 */
+		{ 67, 67, 67, 67 },	/* IDSEL 12 - PCI Slot 0, ext. IRQ 2 */
+	};
+
+	const long min_idsel = 10, max_idsel = 12, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+static void __init sequoia_set_emacdata(void)
+{
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+
+	/* Set mac_addr, phy mode and unsupported phy features for each EMAC */
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+	emacdata->phy_mode = PHY_MODE_RGMII;
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+	emacdata->phy_mode = PHY_MODE_RGMII;
+}
+
+static int sequoia_exclude_device(unsigned char bus, unsigned char devfn)
+{
+	return (bus == 0 && devfn == 0);
+}
+
+#define PCI_READW(offset) \
+        (readw((void *)((u32)pci_reg_base + offset)))
+
+#define PCI_WRITEW(value, offset) \
+	(writew(value, (void *)((u32)pci_reg_base + offset)))
+
+#define PCI_WRITEL(value, offset) \
+	(writel(value, (void *)((u32)pci_reg_base + offset)))
+
+#define PCI_CFG_OUT(offset, value) \
+	(out_le32 (pci_cfg_base + offset, value))
+
+#define PCI_CFG_IN(offset) \
+	(in_le32(pci_cfg_base + offset))
+
+static void __init sequoia_setup_pci(void)
+{
+	void *pci_reg_base;
+	void *pci_cfg_base;
+	unsigned long memory_size;
+
+	memory_size = ppc_md.find_end_of_memory();
+
+	pci_reg_base = ioremap64(SEQUOIA_PCIL0_BASE, SEQUOIA_PCIL0_SIZE);
+	pci_cfg_base = ioremap64(SEQUOIA_PCI_CFGREGS_BASE, 64);
+
+	PCI_CFG_OUT(SEQUOIA_PCI_CFGA_OFFSET, 0x80000000 | (PCI_COMMAND & 0xfc));
+	PCI_CFG_OUT(SEQUOIA_PCI_CFGD_OFFSET,
+		    (PCI_CFG_IN(SEQUOIA_PCI_CFGD_OFFSET) |
+		     PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER));
+
+	/* Disable region first */
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM0MA);
+
+	/* PLB starting addr: 0x0000000180000000 */
+	PCI_WRITEL(SEQUOIA_PCI_PHY_MEM_BASE, SEQUOIA_PCIL0_PMM0LA);
+
+	/* PCI start addr, 0x80000000 (PCI Address) */
+	PCI_WRITEL(SEQUOIA_PCI_MEM_BASE, SEQUOIA_PCIL0_PMM0PCILA);
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM0PCIHA);
+
+	/* Enable no pre-fetch, enable region */
+	PCI_WRITEL(((0xffffffff -
+		     (SEQUOIA_PCI_UPPER_MEM - SEQUOIA_PCI_MEM_BASE)) | 0x01),
+		   SEQUOIA_PCIL0_PMM0MA);
+
+	/* Disable region one */
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM1MA);
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM1LA);
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM1PCILA);
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM1PCIHA);
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM1MA);
+
+	/* Disable region two */
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM2MA);
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM2LA);
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM2PCILA);
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM2PCIHA);
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PMM2MA);
+
+	/* Now configure the PCI->PLB windows, we only use PTM1
+	 *
+	 * For Inbound flow, set the window size to all available memory
+	 * This is required because if size is smaller,
+	 * then Eth/PCI DD would fail as PCI card not able to access
+	 * the memory allocated by DD.
+	 */
+
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PTM1MS);	/* disabled region 1 */
+	PCI_WRITEL(0, SEQUOIA_PCIL0_PTM1LA);	/* begin of address map */
+
+	memory_size = 1 << fls(memory_size - 1);
+
+	/* Size low + Enabled */
+	PCI_WRITEL((0xffffffff - (memory_size - 1)) | 0x1, SEQUOIA_PCIL0_PTM1MS);
+
+	eieio();
+	iounmap(pci_reg_base);
+	iounmap(pci_cfg_base);
+}
+
+static void __init sequoia_setup_hose(void)
+{
+	unsigned int bar_response, bar;
+	struct pci_controller *hose;
+
+	sequoia_setup_pci();
+
+	hose = pcibios_alloc_controller();
+
+	if (!hose)
+		return;
+
+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+
+	hose->pci_mem_offset = SEQUOIA_PCI_MEM_OFFSET;
+
+	pci_init_resource(&hose->io_resource,
+			  SEQUOIA_PCI_LOWER_IO,
+			  SEQUOIA_PCI_UPPER_IO,
+			  IORESOURCE_IO,
+			  "PCI host bridge");
+
+	pci_init_resource(&hose->mem_resources[0],
+			  SEQUOIA_PCI_LOWER_MEM,
+			  SEQUOIA_PCI_UPPER_MEM,
+			  IORESOURCE_MEM,
+			  "PCI host bridge");
+
+	ppc_md.pci_exclude_device = sequoia_exclude_device;
+
+	hose->io_space.start = SEQUOIA_PCI_LOWER_IO;
+	hose->io_space.end = SEQUOIA_PCI_UPPER_IO;
+	hose->mem_space.start = SEQUOIA_PCI_LOWER_MEM;
+	hose->mem_space.end = SEQUOIA_PCI_UPPER_MEM;
+	isa_io_base =
+		(unsigned long)ioremap64(SEQUOIA_PCI_IO_BASE, SEQUOIA_PCI_IO_SIZE);
+	hose->io_base_virt = (void *)isa_io_base;
+
+	setup_indirect_pci(hose, SEQUOIA_PCI_CFGA_PLB32, SEQUOIA_PCI_CFGD_PLB32);
+	hose->set_cfg_type = 1;
+
+	/* Zero config bars */
+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
+		early_write_config_dword(hose, hose->first_busno,
+					 PCI_FUNC(hose->first_busno), bar,
+					 0x00000000);
+		early_read_config_dword(hose, hose->first_busno,
+					PCI_FUNC(hose->first_busno), bar,
+					&bar_response);
+	}
+
+	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = sequoia_map_irq;
+}
+
+static void __init sequoia_early_serial_map(void)
+{
+	struct uart_port port;
+
+	/* Setup ioremapped serial port access */
+	memset(&port, 0, sizeof(port));
+	port.membase = ioremap64(PPC440EPX_UART0_ADDR, 8);
+	port.irq = UART0_INT;
+	port.uartclk = clocks.uart0;
+	port.regshift = 0;
+	port.iotype = SERIAL_IO_MEM;
+	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup(&port) != 0)
+		printk("Early serial init of port 0 failed\n");
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(0, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EPX_UART1_ADDR, 8);
+	port.irq = UART1_INT;
+	port.uartclk = clocks.uart1;
+	port.line = 1;
+
+	if (early_serial_setup(&port) != 0)
+		printk("Early serial init of port 1 failed\n");
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(1, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EPX_UART2_ADDR, 8);
+	port.irq = UART2_INT;
+	port.uartclk = clocks.uart2;
+	port.line = 2;
+
+	if (early_serial_setup(&port) != 0)
+		printk("Early serial init of port 2 failed\n");
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(2, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EPX_UART3_ADDR, 8);
+	port.irq = UART3_INT;
+	port.uartclk = clocks.uart3;
+	port.line = 3;
+
+	if (early_serial_setup(&port) != 0)
+		printk("Early serial init of port 3 failed\n");
+}
+
+static void __init sequoia_setup_arch(void)
+{
+        /*
+         * Clear PLB4A0_ACR[WRP]
+	 * This is a workaround for 440EPx/440GRx MAL burst issue
+         */
+	mtdcr(DCRN_PLB4A0_ACR, mfdcr(DCRN_PLB4A0_ACR) & ~(0x80000000 >> 7));
+
+	sequoia_set_emacdata();
+
+	/* parm1 = sys clock is OK , parm 2 ser_clock to be checked */
+	ibm440gx_get_clocks(&clocks, 33000000, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+
+	/* init to some ~sane value until calibrate_delay() runs */
+        loops_per_jiffy = 50000000/HZ;
+
+	/* Setup PCI host bridge */
+	sequoia_setup_hose();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else {
+#ifdef CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+	}
+#endif
+
+	sequoia_early_serial_map();
+
+	/* Identify the system */
+	printk("AMCC PowerPC " BOARDNAME " Platform\n");
+}
+
+static void __init sequoia_init_irq(void)
+{
+	ppc4xx_pic_init();
+}
+
+void __init platform_init(unsigned long r3, unsigned long r4,
+			  unsigned long r5, unsigned long r6, unsigned long r7)
+{
+	ibm44x_platform_init(r3, r4, r5, r6, r7);
+
+	ppc_md.setup_arch = sequoia_setup_arch;
+	ppc_md.show_cpuinfo = sequoia_show_cpuinfo;
+	ppc_md.find_end_of_memory = sequoia_find_end_of_memory;
+	ppc_md.get_irq = NULL;		/* Set in ppc4xx_pic_init() */
+
+	ppc_md.calibrate_decr = sequoia_calibrate_decr;
+	ppc_md.time_init = NULL;
+	ppc_md.set_rtc_time = NULL;
+	ppc_md.get_rtc_time = NULL;
+
+	ppc_md.init_IRQ = sequoia_init_irq;
+
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = sequoia_early_serial_map;
+#endif
+}
diff -ruN linux.orig/arch/ppc/platforms/4xx/sequoia.h linux/arch/ppc/platforms/4xx/sequoia.h
--- linux.orig/arch/ppc/platforms/4xx/sequoia.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/arch/ppc/platforms/4xx/sequoia.h	2007-03-20 14:41:29.000000000 +0300
@@ -0,0 +1,117 @@
+/*
+ * arch/ppc/platforms/4xx/sequoia.h
+ *
+ * Sequoia board definitions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ * Copyright 2004-2007 MontaVista Software Inc.
+ * Copyright 2006 AMCC
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_SEQUOIA_H__
+#define __ASM_SEQUOIA_H__
+
+#include <platforms/4xx/ppc440epx.h>
+
+/* Default clock rate */
+#define SEQUOIA_TMRCLK     50000000
+#define SEQUOIA_SYSCLK     33333333
+
+/* Board Control and Status Registers */
+#define SEQUOIA_BCSR_BASE_ADDR	0x1c0000000ULL
+
+#ifndef __ASSEMBLY__
+struct sequoia_bcsr {
+	unsigned char board_id;		/* board revision */
+	unsigned char cpld_version;	/* CPLD version */
+	unsigned char user_dip_switch;	/* LEDs and user DIP switch */
+	unsigned char conf_dip_switch;	/* configuration DIP switch */
+	unsigned char tmrclk_control;	/* TMRCLK source and modifier */
+	unsigned char pci_and_status;	/* PCI speed 33/66 */
+	unsigned char reset_ctrl;	/* reset control */
+	unsigned char memory_ctrl;	/* FLASH, EEPROM write protect, STTM addr */
+	unsigned char eth_ctrl;		/* Ethernet PHY resets */
+	unsigned char usb_ctrl;		/* USB control */
+	unsigned char perf_timer0;	/* performance timer */
+	unsigned char perf_timer1;
+	unsigned char perf_timer2;
+	unsigned char perf_timer3;
+};
+#endif /* __ASSEMBLY__ */
+
+#define SEQUOIA_NAND_FLASH_REG_ADDR	0x1D0000000ULL
+#define SEQUOIA_NAND_FLASH_REG_SIZE	0x2000
+
+/*
+ * Serial port defines
+ */
+#define RS_TABLE_SIZE			4
+/* UART mappings used before early_serial_setup so should be coherent with U-Boot */
+#define UART0_IO_BASE			0xEF600300
+#define UART1_IO_BASE			0xEF600400
+#define UART2_IO_BASE			0xEF600500
+#define UART3_IO_BASE			0xEF600600
+
+#define BASE_BAUD			33177600/3/16
+
+#define STD_UART_OP(num)						\
+	{ 0, BASE_BAUD, 0, UART##num##_INT,				\
+			(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
+			iomem_base: (void*)UART##num##_IO_BASE,		\
+			io_type: SERIAL_IO_MEM},
+
+#define SERIAL_PORT_DFNS			\
+	STD_UART_OP(0)				\
+	STD_UART_OP(1)				\
+	STD_UART_OP(2)				\
+	STD_UART_OP(3)
+
+/* PCI support */
+#define SEQUOIA_PCI_CFGREGS_BASE	0x00000001eec00000ULL
+#define SEQUOIA_PCI_CFGA_PLB32		0xeec00000
+#define SEQUOIA_PCI_CFGD_PLB32		0xeec00004
+#define SEQUOIA_PCI_CFGA_OFFSET		0
+#define SEQUOIA_PCI_CFGD_OFFSET		0x4
+
+#define SEQUOIA_PCI_IO_BASE		0x00000001e8000000ULL
+#define SEQUOIA_PCI_IO_SIZE		0x00010000
+#define SEQUOIA_PCI_MEM_OFFSET	  	0x00000000
+#define SEQUOIA_PCI_PHY_MEM_BASE	0x000000080000000ULL
+/* PLB base address base as seen by the core, implemented on PLB3 */
+/* PLB base address as seen by the SOC : 0x000000180000000ULL    */
+
+#define SEQUOIA_PCI_LOWER_IO		0x00000000
+#define SEQUOIA_PCI_UPPER_IO		0x0000ffff
+#define SEQUOIA_PCI_LOWER_MEM		0x80000000
+#define SEQUOIA_PCI_UPPER_MEM		0x8fffffff	/* to be checked with AS & TR should be bfffffff */
+#define SEQUOIA_PCI_MEM_BASE		0x80000000
+
+#define SEQUOIA_PCIL0_BASE		0x00000001ef400000ULL
+#define SEQUOIA_PCIL0_SIZE		0x40
+
+#define SEQUOIA_PCIL0_PMM0LA		0x000
+#define SEQUOIA_PCIL0_PMM0MA		0x004
+#define SEQUOIA_PCIL0_PMM0PCILA		0x008
+#define SEQUOIA_PCIL0_PMM0PCIHA		0x00C
+#define SEQUOIA_PCIL0_PMM1LA		0x010
+#define SEQUOIA_PCIL0_PMM1MA		0x014
+#define SEQUOIA_PCIL0_PMM1PCILA		0x018
+#define SEQUOIA_PCIL0_PMM1PCIHA		0x01C
+#define SEQUOIA_PCIL0_PMM2LA		0x020
+#define SEQUOIA_PCIL0_PMM2MA		0x024
+#define SEQUOIA_PCIL0_PMM2PCILA		0x028
+#define SEQUOIA_PCIL0_PMM2PCIHA		0x02C
+#define SEQUOIA_PCIL0_PTM1MS		0x030
+#define SEQUOIA_PCIL0_PTM1LA		0x034
+#define SEQUOIA_PCIL0_PTM2MS		0x038
+#define SEQUOIA_PCIL0_PTM2LA		0x03C
+
+#endif                          /* __ASM_SEQUOIA_H__ */
+#endif                          /* __KERNEL__ */
diff -ruN linux.orig/arch/ppc/syslib/ibm440gx_common.c linux/arch/ppc/syslib/ibm440gx_common.c
--- linux.orig/arch/ppc/syslib/ibm440gx_common.c	2007-03-16 18:03:23.000000000 +0300
+++ linux/arch/ppc/syslib/ibm440gx_common.c	2007-03-18 18:53:08.000000000 +0300
@@ -31,7 +31,8 @@
 	u32 plld  = CPR_READ(DCRN_CPR_PLLD);
 	u32 uart0 = SDR_READ(DCRN_SDR_UART0);
 	u32 uart1 = SDR_READ(DCRN_SDR_UART1);
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 	u32 uart2 = SDR_READ(DCRN_SDR_UART2);
 	u32 uart3 = SDR_READ(DCRN_SDR_UART3);
 #endif
@@ -97,7 +98,8 @@
 		p->uart1 = ser_clk;
 	else
 		p->uart1 = p->plb / __fix_zero(uart1 & 0xff, 256);
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 	if (uart2 & 0x00800000)
 		p->uart2 = ser_clk;
 	else
diff -ruN linux.orig/arch/ppc/syslib/ibm44x_common.c linux/arch/ppc/syslib/ibm44x_common.c
--- linux.orig/arch/ppc/syslib/ibm44x_common.c	2007-03-16 18:03:23.000000000 +0300
+++ linux/arch/ppc/syslib/ibm44x_common.c	2007-03-18 18:53:08.000000000 +0300
@@ -221,6 +221,30 @@
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
diff -ruN linux.orig/arch/ppc/syslib/ibm44x_common.h linux/arch/ppc/syslib/ibm44x_common.h
--- linux.orig/arch/ppc/syslib/ibm44x_common.h	2007-03-16 18:03:23.000000000 +0300
+++ linux/arch/ppc/syslib/ibm44x_common.h	2007-03-18 18:53:08.000000000 +0300
@@ -27,7 +27,8 @@
 	unsigned int ebc;	/* PerClk */
 	unsigned int uart0;
 	unsigned int uart1;
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 	unsigned int uart2;
 	unsigned int uart3;
 #endif
diff -ruN linux.orig/arch/ppc/syslib/Makefile linux/arch/ppc/syslib/Makefile
--- linux.orig/arch/ppc/syslib/Makefile	2007-03-16 18:03:23.000000000 +0300
+++ linux/arch/ppc/syslib/Makefile	2007-03-18 18:53:08.000000000 +0300
@@ -12,7 +12,9 @@
 obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
 obj-$(CONFIG_44x)		+= ibm44x_common.o
 obj-$(CONFIG_440EP)		+= ibm440gx_common.o
+obj-$(CONFIG_440EPX)		+= ibm440gx_common.o
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
+obj-$(CONFIG_440GRX)		+= ibm440gx_common.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
 obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
 obj-$(CONFIG_440SPE)		+= ibm440gx_common.o ibm440sp_common.o ppc440spe_pcie.o
@@ -70,6 +72,8 @@
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o pci_auto.o \
 				   todc_time.o
 obj-$(CONFIG_TAISHAN)		+= pci_auto.o
+obj-$(CONFIG_SEQUOIA)		+= pci_auto.o
+obj-$(CONFIG_RAINIER)		+= pci_auto.o
 obj-$(CONFIG_8260)		+= m8260_setup.o pq2_devices.o pq2_sys.o \
 				   ppc_sys.o
 obj-$(CONFIG_PCI_8260)		+= m82xx_pci.o pci_auto.o
diff -ruN linux.orig/arch/ppc/syslib/ppc4xx_pic.c linux/arch/ppc/syslib/ppc4xx_pic.c
--- linux.orig/arch/ppc/syslib/ppc4xx_pic.c	2007-03-16 18:03:23.000000000 +0300
+++ linux/arch/ppc/syslib/ppc4xx_pic.c	2007-03-18 18:53:08.000000000 +0300
@@ -118,6 +118,34 @@
 }
 
 #elif NR_UICS == 3
+#if defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+#define ACK_UIC0_PARENT
+#define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC);
+#define ACK_UIC2_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC2NC);
+UIC_HANDLERS(0);
+UIC_HANDLERS(1);
+UIC_HANDLERS(2);
+
+static int ppc4xx_pic_get_irq(void)
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
+#else /* #if defined(CONFIG_440EPX) || defined(CONFIG_440GRX) */
 #define ACK_UIC0_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC0NC);
 #define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC1NC);
 #define ACK_UIC2_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC2NC);
@@ -151,6 +179,7 @@
 	mtdcr(DCRN_UIC_SR(UICB), 0xffffffff);
 	mtdcr(DCRN_UIC_ER(UICB), UICB_UIC0NC | UICB_UIC1NC | UICB_UIC2NC);
 }
+#endif /* #if defined(CONFIG_440EPX) || defined(CONFIG_440GRX) */
 
 #elif NR_UICS == 2
 #define ACK_UIC0_PARENT
diff -ruN linux.orig/include/asm-ppc/ibm44x.h linux/include/asm-ppc/ibm44x.h
--- linux.orig/include/asm-ppc/ibm44x.h	2007-03-16 18:04:16.000000000 +0300
+++ linux/include/asm-ppc/ibm44x.h	2007-03-20 15:32:48.000000000 +0300
@@ -43,8 +43,12 @@
 #elif defined(CONFIG_440SPE)
 #define UART0_PHYS_ERPN		4
 #define UART0_PHYS_IO_BASE	0xf0000200
-#elif defined(CONFIG_440EP)
+#elif defined(CONFIG_440EP) || \
+      defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define UART0_PHYS_IO_BASE	0xef600300
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
@@ -178,9 +194,11 @@
 #define DCRN_SDR_UART0		0x0120
 #define DCRN_SDR_UART1		0x0121
 
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define DCRN_SDR_UART2		0x0122
 #define DCRN_SDR_UART3		0x0123
+#define DCRN_SDR_USB0		0x0320
 #define DCRN_SDR_CUST0		0x4000
 #endif
 
@@ -201,7 +219,8 @@
 #define DCRNCAP_DMA_SG		1	/* have DMA scatter/gather capability */
 #define DCRN_MAL_BASE		0x180
 
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define DCRN_DMA2P40_BASE	0x300
 #define DCRN_DMA2P41_BASE	0x308
 #define DCRN_DMA2P42_BASE	0x310
@@ -215,11 +234,14 @@
 #define UIC0		DCRN_UIC0_BASE
 #define UIC1		DCRN_UIC1_BASE
 
-#ifdef CONFIG_440SPE
+#if defined(CONFIG_440SPE) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define DCRN_UIC2_BASE	0xe0
-#define DCRN_UIC3_BASE	0xf0
 #define UIC2		DCRN_UIC2_BASE
+#if defined(CONFIG_440SPE)
+#define DCRN_UIC3_BASE	0xf0
 #define UIC3		DCRN_UIC3_BASE
+#endif
 #else
 #define DCRN_UIC2_BASE	0x210
 #define DCRN_UICB_BASE	0x200
@@ -239,9 +261,12 @@
 #define UIC0_UIC1NC      	0x00000002
 
 #ifdef CONFIG_440SPE
-#define UIC0_UIC1NC      0x00000002
-#define UIC0_UIC2NC      0x00200000
-#define UIC0_UIC3NC      0x00008000
+#define UIC0_UIC2NC		0x00200000
+#define UIC0_UIC3NC		0x00008000
+#endif
+
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
@@ -659,7 +733,8 @@
 #define IIC_CLOCK		50
 
 #undef NR_UICS
-#if defined(CONFIG_440GX)
+#if defined(CONFIG_440GX) || \
+    defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define NR_UICS 3
 #elif defined(CONFIG_440SPE)
 #define NR_UICS 4
diff -ruN linux.orig/include/asm-ppc/ibm4xx.h linux/include/asm-ppc/ibm4xx.h
--- linux.orig/include/asm-ppc/ibm4xx.h	2007-03-16 18:04:16.000000000 +0300
+++ linux/include/asm-ppc/ibm4xx.h	2007-03-18 18:53:08.000000000 +0300
@@ -113,6 +113,10 @@
 #include <platforms/4xx/taishan.h>
 #endif
 
+#if defined(CONFIG_SEQUOIA) || defined(CONFIG_RAINIER)
+#include <platforms/4xx/sequoia.h>
+#endif
+
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_40x
 /*

--------------060908080904040202010908--
