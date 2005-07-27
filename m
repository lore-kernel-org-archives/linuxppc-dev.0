Return-Path: <mporter@kernel.crashing.org>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id CA0FC67DBC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 03:48:24 +1000 (EST)
In-Reply-To: mporter@kernel.crashing.org
Date: Wed, 27 Jul 2005 10:34:22 -0700
Message-Id: <11224856623638@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: akpm@osdl.org
From: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][1/3] ppc32: add 440ep support
Reply-To: Matt Porter <mporter@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Add PPC440EP core support.  PPC440EP is a PPC440-based SoC with
a classic PPC FPU and another set of peripherals.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -61,6 +61,12 @@ zimageinitrd-$(CONFIG_IBM_OPENBIOS)	:=3D z
          end-$(CONFIG_EMBEDDEDBOOT)	:=3D embedded
         misc-$(CONFIG_EMBEDDEDBOOT)	:=3D misc-embedded.o
=20
+      zimage-$(CONFIG_BAMBOO)		:=3D zImage-TREE
+zimageinitrd-$(CONFIG_BAMBOO)		:=3D zImage.initrd-TREE
+         end-$(CONFIG_BAMBOO)		:=3D bamboo
+  entrypoint-$(CONFIG_BAMBOO)		:=3D 0x01000000
+     extra.o-$(CONFIG_BAMBOO)		:=3D pibs.o
+
       zimage-$(CONFIG_EBONY)		:=3D zImage-TREE
 zimageinitrd-$(CONFIG_EBONY)		:=3D zImage.initrd-TREE
          end-$(CONFIG_EBONY)		:=3D ebony
diff --git a/arch/ppc/boot/simple/pibs.c b/arch/ppc/boot/simple/pibs.c
--- a/arch/ppc/boot/simple/pibs.c
+++ b/arch/ppc/boot/simple/pibs.c
@@ -91,9 +91,11 @@ load_kernel(unsigned long load_addr, int
=20
 	mac64 =3D simple_strtoull((char *)PIBS_MAC_BASE, 0, 16);
 	memcpy(hold_residual->bi_enetaddr, (char *)&mac64+2, 6);
-#ifdef CONFIG_440GX
+#if defined(CONFIG_440GX) || defined(CONFIG_440EP)
 	mac64 =3D simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET), 0, 16);
 	memcpy(hold_residual->bi_enet1addr, (char *)&mac64+2, 6);
+#endif
+#ifdef CONFIG_440GX
 	mac64 =3D simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET*2), 0, 1=
6);
 	memcpy(hold_residual->bi_enet2addr, (char *)&mac64+2, 6);
 	mac64 =3D simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET*3), 0, 1=
6);
diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -852,6 +852,26 @@ struct cpu_spec	cpu_specs[] =3D {
=20
 #endif /* CONFIG_40x */
 #ifdef CONFIG_44x
+	{
+		.pvr_mask		=3D 0xf0000fff,
+		.pvr_value		=3D 0x40000850,
+		.cpu_name		=3D "440EP Rev. A",
+		.cpu_features		=3D CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	=3D COMMON_PPC, /* 440EP has an FPU */
+		.icache_bsize		=3D 32,
+		.dcache_bsize		=3D 32,
+	},
+	{
+		.pvr_mask		=3D 0xf0000fff,
+		.pvr_value		=3D 0x400008d3,
+		.cpu_name		=3D "440EP Rev. B",
+		.cpu_features		=3D CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	=3D COMMON_PPC, /* 440EP has an FPU */
+		.icache_bsize		=3D 32,
+		.dcache_bsize		=3D 32,
+	},
 	{ 	/* 440GP Rev. B */
 		.pvr_mask		=3D 0xf0000fff,
 		.pvr_value		=3D 0x40000440,
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -215,6 +215,7 @@ syscall_dotrace_cont:
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
 	addi	r9,r1,STACK_FRAME_OVERHEAD
+	PPC440EP_ERR42
 	blrl			/* Call handler */
 	.globl	ret_from_syscall
 ret_from_syscall:
diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -190,7 +190,9 @@ skpinv:	addi	r4,r4,1				/* Increment */
=20
 	/* xlat fields */
 	lis	r4,UART0_PHYS_IO_BASE@h		/* RPN depends on SoC */
+#ifndef CONFIG_440EP
 	ori	r4,r4,0x0001		/* ERPN is 1 for second 4GB page */
+#endif
=20
 	/* attrib fields */
 	li	r5,0
@@ -228,6 +230,16 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
=20
+#ifdef CONFIG_440EP
+	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
+	mfspr	r2,SPRN_CCR0
+	lis	r3,0xffef
+	ori	r3,r3,0xffff
+	and	r2,r2,r3
+	mtspr	SPRN_CCR0,r2
+	isync
+#endif
+
 	/*
 	 * This is where the main kernel code starts.
 	 */
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -1145,6 +1145,7 @@ _GLOBAL(kernel_thread)
 	stwu	r0,-16(r1)
 	mtlr	r30		/* fn addr in lr */
 	mr	r3,r31		/* load arg and call fn */
+	PPC440EP_ERR42
 	blrl
 	li	r0,__NR_exit	/* exit if function returns */
 	li	r3,0
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -68,6 +68,11 @@ choice
 	depends on 44x
 	default EBONY
=20
+config BAMBOO
+	bool "Bamboo"
+	help
+	  This option enables support for the IBM PPC440EP evaluation board.
+
 config EBONY
 	bool "Ebony"
 	help
@@ -98,6 +103,12 @@ config NP405H
 	depends on ASH
 	default y
=20
+config 440EP
+	bool
+	depends on BAMBOO
+	select PPC_FPU
+	default y
+
 config 440GP
 	bool
 	depends on EBONY
@@ -115,7 +126,7 @@ config 440SP
=20
 config 440
 	bool
-	depends on 440GP || 440SP
+	depends on 440GP || 440SP || 440EP
 	default y
=20
 config 440A
@@ -123,6 +134,11 @@ config 440A
 	depends on 440GX
 	default y
=20
+config IBM440EP_ERR42
+	bool
+	depends on 440EP
+	default y
+
 # All 405-based cores up until the 405GPR and 405EP have this errata.
 config IBM405_ERR77
 	bool
@@ -142,7 +158,7 @@ config BOOKE
=20
 config IBM_OCP
 	bool
-	depends on ASH || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA =
|| REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN =
|| OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
=20
 config XILINX_OCP
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makef=
ile
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the PowerPC 4xx linux kernel.
=20
 obj-$(CONFIG_ASH)		+=3D ash.o
+obj-$(CONFIG_BAMBOO)		+=3D bamboo.o
 obj-$(CONFIG_CPCI405)		+=3D cpci405.o
 obj-$(CONFIG_EBONY)		+=3D ebony.o
 obj-$(CONFIG_EP405)		+=3D ep405.o
@@ -19,6 +20,7 @@ obj-$(CONFIG_405GP)		+=3D ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+=3D ibmstb4.o
 obj-$(CONFIG_NP405H)		+=3D ibmnp405h.o
 obj-$(CONFIG_REDWOOD_6)		+=3D ibmstbx25.o
+obj-$(CONFIG_440EP)		+=3D ibm440ep.o
 obj-$(CONFIG_440GP)		+=3D ibm440gp.o
 obj-$(CONFIG_440GX)		+=3D ibm440gx.o
 obj-$(CONFIG_440SP)		+=3D ibm440sp.o
diff --git a/arch/ppc/platforms/4xx/ibm440ep.c b/arch/ppc/platforms/4xx/ibm=
440ep.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ibm440ep.c
@@ -0,0 +1,220 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440ep.c
+ *
+ * PPC440EP I/O descriptions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <platforms/4xx/ibm440ep.h>
+#include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
+
+static struct ocp_func_emac_data ibm440ep_emac0_def =3D {
+	.rgmii_idx	=3D -1,           /* No RGMII */
+	.rgmii_mux	=3D -1,           /* No RGMII */
+	.zmii_idx       =3D 0,            /* ZMII device index */
+	.zmii_mux       =3D 0,            /* ZMII input of this EMAC */
+	.mal_idx        =3D 0,            /* MAL device index */
+	.mal_rx_chan    =3D 0,            /* MAL rx channel number */
+	.mal_tx_chan    =3D 0,            /* MAL tx channel number */
+	.wol_irq        =3D 61,		/* WOL interrupt number */
+	.mdio_idx       =3D -1,           /* No shared MDIO */
+	.tah_idx	=3D -1,           /* No TAH */
+};
+
+static struct ocp_func_emac_data ibm440ep_emac1_def =3D {
+	.rgmii_idx	=3D -1,           /* No RGMII */
+	.rgmii_mux	=3D -1,           /* No RGMII */
+	.zmii_idx       =3D 0,            /* ZMII device index */
+	.zmii_mux       =3D 1,            /* ZMII input of this EMAC */
+	.mal_idx        =3D 0,            /* MAL device index */
+	.mal_rx_chan    =3D 1,            /* MAL rx channel number */
+	.mal_tx_chan    =3D 2,            /* MAL tx channel number */
+	.wol_irq        =3D 63,  		/* WOL interrupt number */
+	.mdio_idx       =3D -1,           /* No shared MDIO */
+	.tah_idx	=3D -1,           /* No TAH */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ibm440ep_mal0_def =3D {
+	.num_tx_chans   =3D 4,  		/* Number of TX channels */
+	.num_rx_chans   =3D 2,    	/* Number of RX channels */
+	.txeob_irq	=3D 10,		/* TX End Of Buffer IRQ  */
+	.rxeob_irq	=3D 11,		/* RX End Of Buffer IRQ  */
+	.txde_irq	=3D 33,		/* TX Descriptor Error IRQ */
+	.rxde_irq	=3D 34,		/* RX Descriptor Error IRQ */
+	.serr_irq	=3D 32,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data ibm440ep_iic0_def =3D {
+	.fast_mode	=3D 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data ibm440ep_iic1_def =3D {
+	.fast_mode	=3D 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] =3D {
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_OPB,
+	  .index	=3D 0,
+	  .paddr	=3D 0x0EF600000ULL,
+	  .irq		=3D OCP_IRQ_NA,
+	  .pm		=3D OCP_CPM_NA,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_16550,
+	  .index	=3D 0,
+	  .paddr	=3D PPC440EP_UART0_ADDR,
+	  .irq		=3D UART0_INT,
+	  .pm		=3D IBM_CPM_UART0,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_16550,
+	  .index	=3D 1,
+	  .paddr	=3D PPC440EP_UART1_ADDR,
+	  .irq		=3D UART1_INT,
+	  .pm		=3D IBM_CPM_UART1,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_16550,
+	  .index	=3D 2,
+	  .paddr	=3D PPC440EP_UART2_ADDR,
+	  .irq		=3D UART2_INT,
+	  .pm		=3D IBM_CPM_UART2,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_16550,
+	  .index	=3D 3,
+	  .paddr	=3D PPC440EP_UART3_ADDR,
+	  .irq		=3D UART3_INT,
+	  .pm		=3D IBM_CPM_UART3,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_IIC,
+	  .index	=3D 0,
+	  .paddr	=3D 0x0EF600700ULL,
+	  .irq		=3D 2,
+	  .pm		=3D IBM_CPM_IIC0,
+	  .additions	=3D &ibm440ep_iic0_def,
+	  .show		=3D &ocp_show_iic_data
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_IIC,
+	  .index	=3D 1,
+	  .paddr	=3D 0x0EF600800ULL,
+	  .irq		=3D 7,
+	  .pm		=3D IBM_CPM_IIC1,
+	  .additions	=3D &ibm440ep_iic1_def,
+	  .show		=3D &ocp_show_iic_data
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_GPIO,
+	  .index	=3D 0,
+	  .paddr	=3D 0x0EF600B00ULL,
+	  .irq		=3D OCP_IRQ_NA,
+	  .pm		=3D IBM_CPM_GPIO0,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_GPIO,
+	  .index	=3D 1,
+	  .paddr	=3D 0x0EF600C00ULL,
+	  .irq		=3D OCP_IRQ_NA,
+	  .pm		=3D OCP_CPM_NA,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_MAL,
+	  .paddr	=3D OCP_PADDR_NA,
+	  .irq		=3D OCP_IRQ_NA,
+	  .pm		=3D OCP_CPM_NA,
+	  .additions	=3D &ibm440ep_mal0_def,
+	  .show		=3D &ocp_show_mal_data,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_EMAC,
+	  .index	=3D 0,
+	  .paddr	=3D 0x0EF600E00ULL,
+	  .irq		=3D 60,
+	  .pm		=3D OCP_CPM_NA,
+	  .additions	=3D &ibm440ep_emac0_def,
+	  .show		=3D &ocp_show_emac_data,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_EMAC,
+	  .index	=3D 1,
+	  .paddr	=3D 0x0EF600F00ULL,
+	  .irq		=3D 62,
+	  .pm		=3D OCP_CPM_NA,
+	  .additions	=3D &ibm440ep_emac1_def,
+	  .show		=3D &ocp_show_emac_data,
+	},
+	{ .vendor	=3D OCP_VENDOR_IBM,
+	  .function	=3D OCP_FUNC_ZMII,
+	  .paddr	=3D 0x0EF600D00ULL,
+	  .irq		=3D OCP_IRQ_NA,
+	  .pm		=3D OCP_CPM_NA,
+	},
+	{ .vendor	=3D OCP_VENDOR_INVALID
+	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata =3D {
+	{ .polarity	=3D 0xffbffe03,
+	  .triggering   =3D 0xfffffe00,
+	  .ext_irq_mask =3D 0x000001fc,	/* IRQ0 - IRQ6 */
+	},
+	{ .polarity	=3D 0xffffc6ef,
+	  .triggering	=3D 0xffffc7ff,
+	  .ext_irq_mask =3D 0x00003800,	/* IRQ7 - IRQ9 */
+	},
+};
+
+static struct resource usb_gadget_resources[] =3D {
+	[0] =3D {
+		.start	=3D 0x050000100ULL,
+		.end 	=3D 0x05000017FULL,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	[1] =3D {
+		.start	=3D 55,
+		.end	=3D 55,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static u64 dma_mask =3D 0xffffffffULL;
+
+static struct platform_device usb_gadget_device =3D {
+	.name		=3D "musbhsfc",
+	.id		=3D 0,
+	.num_resources	=3D ARRAY_SIZE(usb_gadget_resources),
+	.resource       =3D usb_gadget_resources,
+	.dev		=3D {
+		.dma_mask =3D &dma_mask,
+		.coherent_dma_mask =3D 0xffffffffULL,
+	}
+};
+
+static struct platform_device *ibm440ep_devs[] __initdata =3D {
+	&usb_gadget_device,
+};
+
+static int __init
+ibm440ep_platform_add_devices(void)
+{
+	return platform_add_devices(ibm440ep_devs, ARRAY_SIZE(ibm440ep_devs));
+}
+arch_initcall(ibm440ep_platform_add_devices);
+
diff --git a/arch/ppc/platforms/4xx/ibm440ep.h b/arch/ppc/platforms/4xx/ibm=
440ep.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ibm440ep.h
@@ -0,0 +1,76 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440ep.h
+ *
+ * PPC440EP definitions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ * Copyright 2002 Roland Dreier
+ * Copyright 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __PPC_PLATFORMS_IBM440EP_H
+#define __PPC_PLATFORMS_IBM440EP_H
+
+#include <linux/config.h>
+#include <asm/ibm44x.h>
+
+/* UART */
+#define PPC440EP_UART0_ADDR		0x0EF600300
+#define PPC440EP_UART1_ADDR		0x0EF600400
+#define PPC440EP_UART2_ADDR		0x0EF600500
+#define PPC440EP_UART3_ADDR		0x0EF600600
+#define UART0_INT			0
+#define UART1_INT			1
+#define UART2_INT			3
+#define UART3_INT			4
+
+/* Clock and Power Management */
+#define IBM_CPM_IIC0		0x80000000	/* IIC interface */
+#define IBM_CPM_IIC1		0x40000000	/* IIC interface */
+#define IBM_CPM_PCI		0x20000000	/* PCI bridge */
+#define IBM_CPM_USB1H		0x08000000	/* USB 1.1 Host */
+#define IBM_CPM_FPU		0x04000000	/* floating point unit */
+#define IBM_CPM_CPU		0x02000000	/* processor core */
+#define IBM_CPM_DMA		0x01000000	/* DMA controller */
+#define IBM_CPM_BGO		0x00800000	/* PLB to OPB bus arbiter */
+#define IBM_CPM_BGI		0x00400000	/* OPB to PLB bridge */
+#define IBM_CPM_EBC		0x00200000	/* External Bus Controller */
+#define IBM_CPM_EBM		0x00100000	/* Ext Bus Master Interface */
+#define IBM_CPM_DMC		0x00080000	/* SDRAM peripheral controller */
+#define IBM_CPM_PLB4		0x00040000	/* PLB4 bus arbiter */
+#define IBM_CPM_PLB4x3		0x00020000	/* PLB4 to PLB3 bridge controller */
+#define IBM_CPM_PLB3x4		0x00010000	/* PLB3 to PLB4 bridge controller */
+#define IBM_CPM_PLB3		0x00008000	/* PLB3 bus arbiter */
+#define IBM_CPM_PPM		0x00002000	/* PLB Performance Monitor */
+#define IBM_CPM_UIC1		0x00001000	/* Universal Interrupt Controller */
+#define IBM_CPM_GPIO0		0x00000800	/* General Purpose IO (??) */
+#define IBM_CPM_GPT		0x00000400	/* General Purpose Timers  */
+#define IBM_CPM_UART0		0x00000200	/* serial port 0 */
+#define IBM_CPM_UART1		0x00000100	/* serial port 1 */
+#define IBM_CPM_UIC0		0x00000080	/* Universal Interrupt Controller */
+#define IBM_CPM_TMRCLK		0x00000040	/* CPU timers */
+#define IBM_CPM_EMAC0		0x00000020	/* ethernet port 0 */
+#define IBM_CPM_EMAC1		0x00000010	/* ethernet port 1 */
+#define IBM_CPM_UART2		0x00000008	/* serial port 2 */
+#define IBM_CPM_UART3		0x00000004	/* serial port 3 */
+#define IBM_CPM_USB2D		0x00000002	/* USB 2.0 Device */
+#define IBM_CPM_USB2H		0x00000001	/* USB 2.0 Host */
+
+#define DFLT_IBM4xx_PM		~(IBM_CPM_UIC0 | IBM_CPM_UIC1 | IBM_CPM_CPU \
+				| IBM_CPM_EBC | IBM_CPM_BGO | IBM_CPM_FPU \
+				| IBM_CPM_EBM | IBM_CPM_PLB4 | IBM_CPM_3x4 \
+				| IBM_CPM_PLB3 | IBM_CPM_PLB4x3 \
+				| IBM_CPM_EMAC0 | IBM_CPM_TMRCLK \
+				| IBM_CPM_DMA | IBM_CPM_PCI | IBM_CPM_EMAC1)
+
+
+#endif /* __PPC_PLATFORMS_IBM440EP_H */
+#endif /* __KERNEL__ */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_PPCBUG_NVRAM)	+=3D prep_nvram
 obj-$(CONFIG_PPC_OCP)		+=3D ocp.o
 obj-$(CONFIG_IBM_OCP)		+=3D ibm_ocp.o
 obj-$(CONFIG_44x)		+=3D ibm44x_common.o
+obj-$(CONFIG_440EP)		+=3D ibm440gx_common.o
 obj-$(CONFIG_440GP)		+=3D ibm440gp_common.o
 obj-$(CONFIG_440GX)		+=3D ibm440gx_common.o
 obj-$(CONFIG_440SP)		+=3D ibm440gx_common.o ibm440sp_common.o
@@ -44,6 +45,7 @@ obj-$(CONFIG_PPC_CHRP)		+=3D open_pic.o in
 obj-$(CONFIG_PPC_PREP)		+=3D open_pic.o indirect_pci.o i8259.o todc_time.o
 obj-$(CONFIG_ADIR)		+=3D i8259.o indirect_pci.o pci_auto.o \
 					todc_time.o
+obj-$(CONFIG_BAMBOO)		+=3D indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_CPCI690)		+=3D todc_time.o pci_auto.o
 obj-$(CONFIG_EBONY)		+=3D indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_EV64260)		+=3D todc_time.o pci_auto.o
diff --git a/arch/ppc/syslib/ibm440gx_common.c b/arch/ppc/syslib/ibm440gx_c=
ommon.c
--- a/arch/ppc/syslib/ibm440gx_common.c
+++ b/arch/ppc/syslib/ibm440gx_common.c
@@ -34,6 +34,10 @@ void __init ibm440gx_get_clocks(struct i
 	u32 plld  =3D CPR_READ(DCRN_CPR_PLLD);
 	u32 uart0 =3D SDR_READ(DCRN_SDR_UART0);
 	u32 uart1 =3D SDR_READ(DCRN_SDR_UART1);
+#ifdef CONFIG_440EP
+	u32 uart2 =3D SDR_READ(DCRN_SDR_UART2);
+	u32 uart3 =3D SDR_READ(DCRN_SDR_UART3);
+#endif
=20
 	/* Dividers */
 	u32 fbdv   =3D __fix_zero((plld >> 24) & 0x1f, 32);
@@ -96,6 +100,17 @@ bypass:
 		p->uart1 =3D ser_clk;
 	else
 		p->uart1 =3D p->plb / __fix_zero(uart1 & 0xff, 256);
+#ifdef CONFIG_440EP
+	if (uart2 & 0x00800000)
+		p->uart2 =3D ser_clk;
+	else
+		p->uart2 =3D p->plb / __fix_zero(uart2 & 0xff, 256);
+=09
+	if (uart3 & 0x00800000)
+		p->uart3 =3D ser_clk;
+	else
+		p->uart3 =3D p->plb / __fix_zero(uart3 & 0xff, 256);
+#endif
 }
=20
 /* Issue L2C diagnostic command */
diff --git a/arch/ppc/syslib/ibm44x_common.h b/arch/ppc/syslib/ibm44x_commo=
n.h
--- a/arch/ppc/syslib/ibm44x_common.h
+++ b/arch/ppc/syslib/ibm44x_common.h
@@ -29,6 +29,10 @@ struct ibm44x_clocks {
 	unsigned int ebc;	/* PerClk */
 	unsigned int uart0;
 	unsigned int uart1;
+#ifdef CONFIG_440EP
+	unsigned int uart2;
+	unsigned int uart3;
+#endif
 };
=20
 /* common 44x platform init */
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -35,8 +35,10 @@
 #define PPC44x_LOW_SLOT		63
=20
 /* LS 32-bits of UART0 physical address location for early serial text deb=
ug */
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP)
 #define UART0_PHYS_IO_BASE	0xf0000200
+#elif defined(CONFIG_440EP)
+#define UART0_PHYS_IO_BASE	0xe0000000
 #else
 #define UART0_PHYS_IO_BASE	0x40000200
 #endif
@@ -49,11 +51,16 @@
 /*
  * Standard 4GB "page" definitions
  */
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP)
 #define	PPC44x_IO_PAGE		0x0000000100000000ULL
 #define	PPC44x_PCICFG_PAGE	0x0000000900000000ULL
 #define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
 #define	PPC44x_PCIMEM_PAGE	0x0000000a00000000ULL
+#elif defined(CONFIG_440EP)
+#define PPC44x_IO_PAGE		0x0000000000000000ULL
+#define PPC44x_PCICFG_PAGE	0x0000000000000000ULL
+#define PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
+#define PPC44x_PCIMEM_PAGE	0x0000000000000000ULL
 #else
 #define	PPC44x_IO_PAGE		0x0000000100000000ULL
 #define	PPC44x_PCICFG_PAGE	0x0000000200000000ULL
@@ -64,7 +71,7 @@
 /*
  * 36-bit trap ranges
  */
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP)
 #define PPC44x_IO_LO		0xf0000000UL
 #define PPC44x_IO_HI		0xf0000fffUL
 #define PPC44x_PCI0CFG_LO	0x0ec00000UL
@@ -75,6 +82,13 @@
 #define PPC44x_PCI2CFG_HI	0x2ec00007UL
 #define PPC44x_PCIMEM_LO	0x80000000UL
 #define PPC44x_PCIMEM_HI	0xdfffffffUL
+#elif defined(CONFIG_440EP)
+#define PPC44x_IO_LO		0xef500000UL
+#define PPC44x_IO_HI		0xefffffffUL
+#define PPC44x_PCI0CFG_LO	0xeec00000UL
+#define PPC44x_PCI0CFG_HI	0xeecfffffUL
+#define PPC44x_PCIMEM_LO	0xa0000000UL
+#define PPC44x_PCIMEM_HI	0xdfffffffUL
 #else
 #define PPC44x_IO_LO		0x40000000UL
 #define PPC44x_IO_HI		0x40000fffUL
@@ -152,6 +166,12 @@
 #define DCRN_SDR_UART0		0x0120
 #define DCRN_SDR_UART1		0x0121
=20
+#ifdef CONFIG_440EP
+#define DCRN_SDR_UART2		0x0122
+#define DCRN_SDR_UART3		0x0123
+#define DCRN_SDR_CUST0		0x4000
+#endif
+
 /* SDR read/write helper macros */
 #define SDR_READ(offset) ({\
 	mtdcr(DCRN_SDR_CONFIG_ADDR, offset); \
@@ -169,6 +189,14 @@
 #define DCRNCAP_DMA_SG		1	/* have DMA scatter/gather capability */
 #define DCRN_MAL_BASE		0x180
=20
+#ifdef CONFIG_440EP
+#define DCRN_DMA2P40_BASE	0x300
+#define DCRN_DMA2P41_BASE	0x308
+#define DCRN_DMA2P42_BASE	0x310
+#define DCRN_DMA2P43_BASE	0x318
+#define DCRN_DMA2P4SR_BASE	0x320
+#endif
+
 /* UIC */
 #define DCRN_UIC0_BASE	0xc0
 #define DCRN_UIC1_BASE	0xd0
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -97,6 +97,10 @@ void ppc4xx_init(unsigned long r3, unsig
=20
 #elif CONFIG_44x
=20
+#if defined(CONFIG_BAMBOO)
+#include <platforms/4xx/bamboo.h>
+#endif
+
 #if defined(CONFIG_EBONY)
 #include <platforms/4xx/ebony.h>
 #endif
diff --git a/include/asm-ppc/ppc_asm.h b/include/asm-ppc/ppc_asm.h
--- a/include/asm-ppc/ppc_asm.h
+++ b/include/asm-ppc/ppc_asm.h
@@ -186,6 +186,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define PPC405_ERR77_SYNC
 #endif
=20
+#ifdef CONFIG_IBM440EP_ERR42
+#define PPC440EP_ERR42 isync
+#else
+#define PPC440EP_ERR42
+#endif
+
 /* The boring bits... */
=20
 /* Condition Register Bit Fields */
