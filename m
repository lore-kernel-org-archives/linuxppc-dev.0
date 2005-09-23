Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id EB815682F4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 13:13:26 +1000 (EST)
In-Reply-To: <2005922203.92drttvd27WS9dXk@cisco.com>
Date: Thu, 22 Sep 2005 20:03:35 -0700
Message-Id: <2005922203.UPGbNSgrHKasoXYq@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org
From: Roland Dreier <rolandd@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/4] [PPC32] Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add support for the AMCC PowerPC 440SPe SoC.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 arch/ppc/kernel/cputable.c          |   10 +++
 arch/ppc/platforms/4xx/Kconfig      |    8 ++
 arch/ppc/platforms/4xx/Makefile     |    1 
 arch/ppc/platforms/4xx/amcc440spe.c |  134 +++++++++++++++++++++++++++++++++++
 arch/ppc/platforms/4xx/amcc440spe.h |   64 +++++++++++++++++
 arch/ppc/syslib/Makefile            |    1 
 arch/ppc/syslib/ibm440sp_common.c   |    4 +
 arch/ppc/syslib/ppc4xx_pic.c        |   38 ++++++++++
 include/asm-ppc/ibm44x.h            |   42 ++++++++---
 9 files changed, 287 insertions(+), 15 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/amcc440spe.c
 create mode 100644 arch/ppc/platforms/4xx/amcc440spe.h

4d773d76476fd1f577d1c7755c24d973fbfc1fe5
diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -972,6 +972,16 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 	},
+	{ /* 440SPe Rev. A */
+		.pvr_mask		= 0xff000fff,
+		.pvr_value		= 0x53000890,
+		.cpu_name		= "440SPe Rev. A",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
 #endif /* CONFIG_44x */
 #ifdef CONFIG_FSL_BOOKE
 	{ 	/* e200z5 */
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -124,9 +124,13 @@ config 440SP
 	depends on LUAN
 	default y
 
+config 440SPE
+	bool
+	default n
+
 config 440
 	bool
-	depends on 440GP || 440SP || 440EP
+	depends on 440GP || 440SP || 440SPE || 440EP
 	default y
 
 config 440A
@@ -168,7 +172,7 @@ config XILINX_OCP
 
 config IBM_EMAC4
 	bool
-	depends on 440GX || 440SP
+	depends on 440GX || 440SP || 440SPE
 	default y
 
 config BIOS_FIXUP
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_440EP)		+= ibm440ep.o
 obj-$(CONFIG_440GP)		+= ibm440gp.o
 obj-$(CONFIG_440GX)		+= ibm440gx.o
 obj-$(CONFIG_440SP)		+= ibm440sp.o
+obj-$(CONFIG_440SPE)		+= amcc440spe.o
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
 obj-$(CONFIG_VIRTEX_II_PRO)	+= virtex-ii_pro.o
diff --git a/arch/ppc/platforms/4xx/amcc440spe.c b/arch/ppc/platforms/4xx/amcc440spe.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/amcc440spe.c
@@ -0,0 +1,134 @@
+/*
+ * arch/ppc/platforms/4xx/amc440spe.c
+ *
+ * PPC440SPe I/O descriptions
+ *
+ * Roland Dreier <rolandd@cisco.com>
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2002-2005 MontaVista Software Inc.
+ *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003, 2004 Zultys Technologies
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <platforms/4xx/amcc440spe.h>
+#include <asm/ocp.h>
+
+static struct ocp_func_emac_data amc440spe_emac0_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx       = -1,           /* No ZMII */
+	.zmii_mux       = -1,           /* No ZMII */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 0,            /* MAL rx channel number */
+	.mal_tx_chan    = 0,            /* MAL tx channel number */
+	.wol_irq        = 61,  		/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+	.jumbo		= 1,		/* Jumbo frames supported */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data amc440spe_mal0_def = {
+	.num_tx_chans   = 1,    	/* Number of TX channels */
+	.num_rx_chans   = 1,    	/* Number of RX channels */
+	.txeob_irq	= 38,		/* TX End Of Buffer IRQ  */
+	.rxeob_irq	= 39,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 34,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 35,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 33,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data amc440spe_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data amc440spe_iic1_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000000ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= PPC440SPE_UART0_ADDR,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= PPC440SPE_UART1_ADDR,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= PPC440SPE_UART2_ADDR,
+	  .irq		= UART2_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 0,
+	  .paddr	= 0x00000001f0000400ULL,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &amc440spe_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 1,
+	  .paddr	= 0x00000001f0000500ULL,
+	  .irq		= 3,
+	  .pm		= IBM_CPM_IIC1,
+	  .additions	= &amc440spe_iic1_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 0,
+	  .paddr	= 0x00000001f0000700ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &amc440spe_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= 0x00000004f0000800ULL,
+	  .irq		= 60,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &amc440spe_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
diff --git a/arch/ppc/platforms/4xx/amcc440spe.h b/arch/ppc/platforms/4xx/amcc440spe.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/amcc440spe.h
@@ -0,0 +1,64 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440sp.h
+ *
+ * PPC440SP definitions
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Copyright 2004-2005 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __PPC_PLATFORMS_AMCC440SPE_H
+#define __PPC_PLATFORMS_AMCC440SPE_H
+
+#include <linux/config.h>
+
+#include <asm/ibm44x.h>
+
+/* UART */
+#define PPC440SPE_UART0_ADDR	0x00000004f0000200ULL
+#define PPC440SPE_UART1_ADDR	0x00000004f0000300ULL
+#define PPC440SPE_UART2_ADDR	0x00000004f0000600ULL
+#define UART0_INT		0
+#define UART1_INT		1
+#define UART2_INT		37
+
+/* Clock and Power Management */
+#define IBM_CPM_IIC0		0x80000000	/* IIC interface */
+#define IBM_CPM_IIC1		0x40000000	/* IIC interface */
+#define IBM_CPM_PCI		0x20000000	/* PCI bridge */
+#define IBM_CPM_CPU		    0x02000000	/* processor core */
+#define IBM_CPM_DMA		    0x01000000	/* DMA controller */
+#define IBM_CPM_BGO		    0x00800000	/* PLB to OPB bus arbiter */
+#define IBM_CPM_BGI		    0x00400000	/* OPB to PLB bridge */
+#define IBM_CPM_EBC		    0x00200000	/* External Bux Controller */
+#define IBM_CPM_EBM		    0x00100000	/* Ext Bus Master Interface */
+#define IBM_CPM_DMC		    0x00080000	/* SDRAM peripheral controller */
+#define IBM_CPM_PLB		    0x00040000	/* PLB bus arbiter */
+#define IBM_CPM_SRAM		0x00020000	/* SRAM memory controller */
+#define IBM_CPM_PPM		    0x00002000	/* PLB Performance Monitor */
+#define IBM_CPM_UIC1		0x00001000	/* Universal Interrupt Controller */
+#define IBM_CPM_GPIO0		0x00000800	/* General Purpose IO (??) */
+#define IBM_CPM_GPT		    0x00000400	/* General Purpose Timers  */
+#define IBM_CPM_UART0		0x00000200	/* serial port 0 */
+#define IBM_CPM_UART1		0x00000100	/* serial port 1 */
+#define IBM_CPM_UART2		0x00000100	/* serial port 1 */
+#define IBM_CPM_UIC0		0x00000080	/* Universal Interrupt Controller */
+#define IBM_CPM_TMRCLK		0x00000040	/* CPU timers */
+#define IBM_CPM_EMAC0  		0x00000020	/* EMAC 0     */
+
+#define DFLT_IBM4xx_PM		~(IBM_CPM_UIC | IBM_CPM_UIC1 | IBM_CPM_CPU \
+				| IBM_CPM_EBC | IBM_CPM_SRAM | IBM_CPM_BGO \
+				| IBM_CPM_EBM | IBM_CPM_PLB | IBM_CPM_OPB \
+				| IBM_CPM_TMRCLK | IBM_CPM_DMA | IBM_CPM_PCI \
+				| IBM_CPM_TAHOE0 | IBM_CPM_TAHOE1 \
+				| IBM_CPM_EMAC0 | IBM_CPM_EMAC1 \
+			  	| IBM_CPM_EMAC2 | IBM_CPM_EMAC3 )
+#endif /* __PPC_PLATFORMS_AMCC440SP_H */
+#endif /* __KERNEL__ */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_440EP)		+= ibm440gx_common.
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
 obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
+obj-$(CONFIG_440SPE)		+= ibm440gx_common.o ibm440sp_common.o
 ifeq ($(CONFIG_4xx),y)
 ifeq ($(CONFIG_VIRTEX_II_PRO),y)
 obj-$(CONFIG_40x)		+= xilinx_pic.o
diff --git a/arch/ppc/syslib/ibm440sp_common.c b/arch/ppc/syslib/ibm440sp_common.c
--- a/arch/ppc/syslib/ibm440sp_common.c
+++ b/arch/ppc/syslib/ibm440sp_common.c
@@ -1,7 +1,7 @@
 /*
  * arch/ppc/syslib/ibm440sp_common.c
  *
- * PPC440SP system library
+ * PPC440SP/PPC440SPe system library
  *
  * Matt Porter <mporter@kernel.crashing.org>
  * Copyright 2002-2005 MontaVista Software Inc.
@@ -35,7 +35,7 @@ unsigned long __init ibm440sp_find_end_o
 	u32 mem_size = 0;
 
 	/* Read two bank sizes and sum */
-	for (i=0; i<2; i++)
+	for (i=0; i< MQ0_NUM_BANKS; i++)
 		switch (mfdcr(DCRN_MQ0_BS0BAS + i) & MQ0_CONFIG_SIZE_MASK) {
 			case MQ0_CONFIG_SIZE_8M:
 				mem_size += PPC44x_MEM_SIZE_8M;
diff --git a/arch/ppc/syslib/ppc4xx_pic.c b/arch/ppc/syslib/ppc4xx_pic.c
--- a/arch/ppc/syslib/ppc4xx_pic.c
+++ b/arch/ppc/syslib/ppc4xx_pic.c
@@ -37,6 +37,7 @@ extern unsigned char ppc4xx_uic_ext_irq_
 #define IRQ_MASK_UICx(irq)		(1 << (31 - ((irq) & 0x1f)))
 #define IRQ_MASK_UIC1(irq)		IRQ_MASK_UICx(irq)
 #define IRQ_MASK_UIC2(irq)		IRQ_MASK_UICx(irq)
+#define IRQ_MASK_UIC3(irq)		IRQ_MASK_UICx(irq)
 
 #define UIC_HANDLERS(n)							\
 static void ppc4xx_uic##n##_enable(unsigned int irq)			\
@@ -87,7 +88,39 @@ static void ppc4xx_uic##n##_end(unsigned
 	.end 		= ppc4xx_uic##n##_end,				\
 }									\
 
-#if NR_UICS == 3
+#if NR_UICS == 4
+#define ACK_UIC0_PARENT
+#define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC);
+#define ACK_UIC2_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC2NC);
+#define ACK_UIC3_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC3NC);
+UIC_HANDLERS(0);
+UIC_HANDLERS(1);
+UIC_HANDLERS(2);
+UIC_HANDLERS(3);
+
+static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+{
+	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
+	if (uic0 & UIC0_UIC1NC)
+		return 64 - ffs(mfdcr(DCRN_UIC_MSR(UIC1)));
+	else if (uic0 & UIC0_UIC2NC)
+		return 96 - ffs(mfdcr(DCRN_UIC_MSR(UIC2)));
+	else if (uic0 & UIC0_UIC2NC)
+		return 128 - ffs(mfdcr(DCRN_UIC_MSR(UIC3)));
+	else
+		return uic0 ? 32 - ffs(uic0) : -1;
+}
+
+static void __init ppc4xx_pic_impl_init(void)
+{
+	/* Enable cascade interrupts in UIC0 */
+	/* Enable cascade interrupt in UIC0 */
+	ppc_cached_irq_mask[0] |= UIC0_UIC1NC | UIC0_UIC2NC | UIC0_UIC3NC;
+	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC | UIC0_UIC2NC | UIC0_UIC3NC);
+	mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[0]);
+}
+
+#elif NR_UICS == 3
 #define ACK_UIC0_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC0NC);
 #define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC1NC);
 #define ACK_UIC2_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC2NC);
@@ -169,6 +202,9 @@ static struct ppc4xx_uic_impl {
 	{ .decl = DECLARE_UIC(1), .base = UIC1 },
 #if NR_UICS > 2
 	{ .decl = DECLARE_UIC(2), .base = UIC2 },
+#if NR_UICS > 3
+	{ .decl = DECLARE_UIC(3), .base = UIC3 },
+#endif
 #endif
 #endif
 };
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -41,6 +41,9 @@
 #if defined(CONFIG_440SP)
 #define UART0_PHYS_ERPN		1
 #define UART0_PHYS_IO_BASE	0xf0000200
+#elif defined(CONFIG_440SPE)
+#define UART0_PHYS_ERPN		4
+#define UART0_PHYS_IO_BASE	0xf0000200
 #elif defined(CONFIG_440EP)
 #define UART0_PHYS_IO_BASE	0xe0000000
 #else
@@ -76,7 +79,7 @@
 /*
  * 36-bit trap ranges
  */
-#if defined(CONFIG_440SP)
+#if defined(CONFIG_440SP) || defined(CONFIG_440SPE)
 #define PPC44x_IO_LO		0xf0000000UL
 #define PPC44x_IO_HI		0xf0000fffUL
 #define PPC44x_PCI0CFG_LO	0x0ec00000UL
@@ -114,7 +117,7 @@
  */
 
 
-/* CPRs (440GX and 440SP) */
+/* CPRs (440GX and 440SP/440SPe) */
 #define DCRN_CPR_CONFIG_ADDR	0xc
 #define DCRN_CPR_CONFIG_DATA	0xd
 
@@ -135,7 +138,7 @@
 	mtdcr(DCRN_CPR_CONFIG_ADDR, offset); \
 	mtdcr(DCRN_CPR_CONFIG_DATA, data);})
 
-/* SDRs (440GX and 440SP) */
+/* SDRs (440GX and 440SP/440SPe) */
 #define DCRN_SDR_CONFIG_ADDR 	0xe
 #define DCRN_SDR_CONFIG_DATA	0xf
 #define DCRN_SDR_PFC0		0x4100
@@ -185,7 +188,7 @@
 	mtdcr(DCRN_SDR_CONFIG_ADDR, offset); \
 	mtdcr(DCRN_SDR_CONFIG_DATA,data);})
 
-/* DMA (excluding 440SP) */
+/* DMA (excluding 440SP/440SPe) */
 #define DCRN_DMA0_BASE		0x100
 #define DCRN_DMA1_BASE		0x108
 #define DCRN_DMA2_BASE		0x110
@@ -205,12 +208,20 @@
 /* UIC */
 #define DCRN_UIC0_BASE	0xc0
 #define DCRN_UIC1_BASE	0xd0
-#define DCRN_UIC2_BASE	0x210
-#define DCRN_UICB_BASE	0x200
 #define UIC0		DCRN_UIC0_BASE
 #define UIC1		DCRN_UIC1_BASE
+
+#ifdef CONFIG_440SPE
+#define DCRN_UIC2_BASE	0xe0
+#define DCRN_UIC3_BASE	0xf0
+#define UIC2		DCRN_UIC2_BASE
+#define UIC3		DCRN_UIC3_BASE
+#else
+#define DCRN_UIC2_BASE	0x210
+#define DCRN_UICB_BASE	0x200
 #define UIC2		DCRN_UIC2_BASE
 #define UICB		DCRN_UICB_BASE
+#endif
 
 #define DCRN_UIC_SR(base)       (base + 0x0)
 #define DCRN_UIC_ER(base)       (base + 0x2)
@@ -223,6 +234,12 @@
 
 #define UIC0_UIC1NC      	0x00000002
 
+#ifdef CONFIG_440SPE
+#define UIC0_UIC1NC      0x00000002
+#define UIC0_UIC2NC      0x00008000
+#define UIC0_UIC3NC      0x00200000
+#endif
+
 #define UICB_UIC0NC		0x40000000
 #define UICB_UIC1NC		0x10000000
 #define UICB_UIC2NC		0x04000000
@@ -412,9 +429,13 @@
 #define PPC44x_MEM_SIZE_1G		0x40000000
 #define PPC44x_MEM_SIZE_2G		0x80000000
 
-/* 440SP memory controller DCRs */
+/* 440SP/440SPe memory controller DCRs */
 #define DCRN_MQ0_BS0BAS			0x40
-#define DCRN_MQ0_BS1BAS			0x41
+#if defined(CONFIG_440SP)
+#define MQ0_NUM_BANKS			2
+#elif defined(CONFIG_440SPE)
+#define MQ0_NUM_BANKS			4
+#endif
 
 #define MQ0_CONFIG_SIZE_MASK		0x0000fff0
 #define MQ0_CONFIG_SIZE_8M		0x0000ffc0
@@ -426,8 +447,9 @@
 #define MQ0_CONFIG_SIZE_512M		0x0000f000
 #define MQ0_CONFIG_SIZE_1G		0x0000e000
 #define MQ0_CONFIG_SIZE_2G		0x0000c000
+#define MQ0_CONFIG_SIZE_4G		0x00008000
 
-/* Internal SRAM Controller 440GX/440SP */
+/* Internal SRAM Controller 440GX/440SP/440SPe */
 #define DCRN_SRAM0_BASE		0x000
 
 #define DCRN_SRAM0_SB0CR	(DCRN_SRAM0_BASE + 0x020)
@@ -451,7 +473,7 @@
 #define DCRN_SRAM0_DPC		(DCRN_SRAM0_BASE + 0x02a)
 #define  SRAM_DPC_ENABLE	0x80000000
 
-/* L2 Cache Controller 440GX/440SP */
+/* L2 Cache Controller 440GX/440SP/440SPe */
 #define DCRN_L2C0_CFG		0x030
 #define  L2C_CFG_L2M		0x80000000
 #define  L2C_CFG_ICU		0x40000000
