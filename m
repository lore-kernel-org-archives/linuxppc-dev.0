Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 37FEE684C7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 14:20:43 +1000 (EST)
In-Reply-To: <200510112120.yAT5Bly2IvRrBVKp@cisco.com>
Date: Tue, 11 Oct 2005 21:20:30 -0700
Message-Id: <200510112120.42FGm7PG3M7nv7YB@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org
From: Roland Dreier <rolandd@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 3/4] [PPC32] Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add support for the AMCC PowerPC 440SPe SoC, including PCI Express
in root port mode.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 arch/ppc/kernel/cputable.c         |   10 +
 arch/ppc/platforms/4xx/Kconfig     |    8 -
 arch/ppc/platforms/4xx/Makefile    |    1 
 arch/ppc/platforms/4xx/ppc440spe.c |  155 +++++++++++++
 arch/ppc/platforms/4xx/ppc440spe.h |   66 +++++
 arch/ppc/syslib/Makefile           |    1 
 arch/ppc/syslib/ibm440sp_common.c  |    4 
 arch/ppc/syslib/ibm44x_common.c    |    2 
 arch/ppc/syslib/ppc440spe_pcie.c   |  442 ++++++++++++++++++++++++++++++++++++
 arch/ppc/syslib/ppc440spe_pcie.h   |  149 ++++++++++++
 arch/ppc/syslib/ppc4xx_pic.c       |   37 +++
 include/asm-ppc/ibm44x.h           |   55 +++-
 12 files changed, 911 insertions(+), 19 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/ppc440spe.c
 create mode 100644 arch/ppc/platforms/4xx/ppc440spe.h
 create mode 100644 arch/ppc/syslib/ppc440spe_pcie.c
 create mode 100644 arch/ppc/syslib/ppc440spe_pcie.h

applies-to: 4fd5412aaadbef40224cd63dbdcd102b2eb35309
88f12de483e4b44427ae5652206fccc19186946f
diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
index 546e1ea..9c6a188 100644
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
index 76f4476..108d5a7 100644
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
index 1dd6d7f..694accd 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_440EP)		+= ibm440ep.o
 obj-$(CONFIG_440GP)		+= ibm440gp.o
 obj-$(CONFIG_440GX)		+= ibm440gx.o
 obj-$(CONFIG_440SP)		+= ibm440sp.o
+obj-$(CONFIG_440SPE)		+= ppc440spe.o
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
 obj-$(CONFIG_VIRTEX_II_PRO)	+= virtex-ii_pro.o
diff --git a/arch/ppc/platforms/4xx/ppc440spe.c b/arch/ppc/platforms/4xx/ppc440spe.c
new file mode 100644
index 0000000..aadab0a
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ppc440spe.c
@@ -0,0 +1,155 @@
+/*
+ * arch/ppc/platforms/4xx/ppc440spe.c
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
+#include <platforms/4xx/ppc440spe.h>
+#include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
+
+static struct ocp_func_emac_data ppc440spe_emac0_def = {
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
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ppc440spe_mal0_def = {
+	.num_tx_chans   = 1,    	/* Number of TX channels */
+	.num_rx_chans   = 1,    	/* Number of RX channels */
+	.txeob_irq	= 38,		/* TX End Of Buffer IRQ  */
+	.rxeob_irq	= 39,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 34,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 35,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 33,		/* MAL System Error IRQ    */
+	.dcr_base	= DCRN_MAL_BASE /* MAL0_CFG DCR number */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data ppc440spe_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data ppc440spe_iic1_def = {
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
+	  .additions	= &ppc440spe_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 1,
+	  .paddr	= 0x00000001f0000500ULL,
+	  .irq		= 3,
+	  .pm		= IBM_CPM_IIC1,
+	  .additions	= &ppc440spe_iic1_def,
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
+	  .additions	= &ppc440spe_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= 0x00000004f0000800ULL,
+	  .irq		= 60,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ppc440spe_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity     = 0xffffffff,
+	  .triggering   = 0x010f0004,
+	  .ext_irq_mask = 0x00000000,
+	},
+	{ .polarity     = 0xffffffff,
+	  .triggering   = 0x001f8040,
+	  .ext_irq_mask = 0x00007c30,   /* IRQ6 - IRQ7, IRQ8 - IRQ12 */
+	},
+	{ .polarity     = 0xffffffff,
+	  .triggering   = 0x00000000,
+	  .ext_irq_mask = 0x000000fc,   /* IRQ0 - IRQ5 */
+	},
+	{ .polarity     = 0xffffffff,
+	  .triggering   = 0x00000000,
+	  .ext_irq_mask = 0x00000000,
+	},
+};
diff --git a/arch/ppc/platforms/4xx/ppc440spe.h b/arch/ppc/platforms/4xx/ppc440spe.h
new file mode 100644
index 0000000..2216846
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ppc440spe.h
@@ -0,0 +1,66 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440spe.h
+ *
+ * PPC440SPe definitions
+ *
+ * Roland Dreier <rolandd@cisco.com>
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2004-2005 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __PPC_PLATFORMS_PPC440SPE_H
+#define __PPC_PLATFORMS_PPC440SPE_H
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
+#endif /* __PPC_PLATFORMS_PPC440SP_H */
+#endif /* __KERNEL__ */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index b8d08f3..a060740 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_440EP)		+= ibm440gx_common.
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
 obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
+obj-$(CONFIG_440SPE)		+= ibm440gx_common.o ibm440sp_common.o ppc440spe_pcie.o
 ifeq ($(CONFIG_4xx),y)
 ifeq ($(CONFIG_VIRTEX_II_PRO),y)
 obj-$(CONFIG_40x)		+= xilinx_pic.o
diff --git a/arch/ppc/syslib/ibm440sp_common.c b/arch/ppc/syslib/ibm440sp_common.c
index 417d4cf..cdafda1 100644
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
diff --git a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
index 457e67e..18c29fd 100644
--- a/arch/ppc/syslib/ibm44x_common.c
+++ b/arch/ppc/syslib/ibm44x_common.c
@@ -181,7 +181,7 @@ void __init ibm44x_platform_init(void)
 /* Called from MachineCheckException */
 void platform_machine_check(struct pt_regs *regs)
 {
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP) || defined(CONFIG_440SPE)
     	printk("PLB0: BEAR=0x%08x%08x ACR=  0x%08x BESR= 0x%08x%08x\n",
 	       mfdcr(DCRN_PLB0_BEARH), mfdcr(DCRN_PLB0_BEARL),
 	       mfdcr(DCRN_PLB0_ACR), mfdcr(DCRN_PLB0_BESRH),
diff --git a/arch/ppc/syslib/ppc440spe_pcie.c b/arch/ppc/syslib/ppc440spe_pcie.c
new file mode 100644
index 0000000..38ba588
--- /dev/null
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
@@ -0,0 +1,442 @@
+/*
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
+ * Roland Dreier <rolandd@cisco.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include <asm/reg.h>
+#include <asm/io.h>
+#include <asm/ibm44x.h>
+
+#include "ppc440spe_pcie.h"
+
+static int
+pcie_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
+		     int len, u32 *val)
+{
+	struct pci_controller *hose = bus->sysdata;
+
+	if (PCI_SLOT(devfn) != 1)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	offset += devfn << 12;
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		*val = in_8(hose->cfg_data + offset);
+		break;
+	case 2:
+		*val = in_le16(hose->cfg_data + offset);
+		break;
+	default:
+		*val = in_le32(hose->cfg_data + offset);
+		break;
+	}
+
+	if (0) printk("%s: read %x(%d) @ %x\n", __func__, *val, len, offset);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int
+pcie_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
+		      int len, u32 val)
+{
+	struct pci_controller *hose = bus->sysdata;
+
+	if (PCI_SLOT(devfn) != 1)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	offset += devfn << 12;
+
+	switch (len) {
+	case 1:
+		out_8(hose->cfg_data + offset, val);
+		break;
+	case 2:
+		out_le16(hose->cfg_data + offset, val);
+		break;
+	default:
+		out_le32(hose->cfg_data + offset, val);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops pcie_pci_ops =
+{
+	.read  = pcie_read_config,
+	.write = pcie_write_config
+};
+
+enum {
+	PTYPE_ENDPOINT		= 0x0,
+	PTYPE_LEGACY_ENDPOINT	= 0x1,
+	PTYPE_ROOT_PORT		= 0x4,
+
+	LNKW_X1			= 0x1,
+	LNKW_X4			= 0x4,
+	LNKW_X8			= 0x8
+};
+
+static void check_error(void)
+{
+	u32 valPE0, valPE1, valPE2;
+	
+	/* SDR0_PEGPLLLCT1 reset */
+	if (!(valPE0 = SDR_READ(PESDR0_PLLLCT1) & 0x01000000)) {
+		printk(KERN_INFO "PCIE: SDR0_PEGPLLLCT1 reset error 0x%8x\n", valPE0);
+	}
+
+	valPE0 = SDR_READ(PESDR0_RCSSET);
+	valPE1 = SDR_READ(PESDR1_RCSSET);
+	valPE2 = SDR_READ(PESDR2_RCSSET);
+
+	/* SDR0_PExRCSSET rstgu */
+	if ( !(valPE0 & 0x01000000) ||
+	     !(valPE1 & 0x01000000) ||
+	     !(valPE2 & 0x01000000)) {
+		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstgu error\n");
+	}
+
+	/* SDR0_PExRCSSET rstdl */
+	if ( !(valPE0 & 0x00010000) ||
+	     !(valPE1 & 0x00010000) ||
+	     !(valPE2 & 0x00010000)) {
+		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstdl error\n");
+	}
+
+	/* SDR0_PExRCSSET rstpyn */
+	if ( (valPE0 & 0x00001000) ||
+	     (valPE1 & 0x00001000) ||
+	     (valPE2 & 0x00001000)) {
+		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstpyn error\n");
+	}
+
+	/* SDR0_PExRCSSET hldplb */
+	if ( (valPE0 & 0x10000000) ||
+	     (valPE1 & 0x10000000) ||
+	     (valPE2 & 0x10000000)) {
+		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET hldplb error\n");
+	}
+
+	/* SDR0_PExRCSSET rdy */
+	if ( (valPE0 & 0x00100000) ||
+	     (valPE1 & 0x00100000) ||
+	     (valPE2 & 0x00100000)) {
+		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rdy error\n");
+	}
+
+	/* SDR0_PExRCSSET shutdown */
+	if ( (valPE0 & 0x00000100) ||
+	     (valPE1 & 0x00000100) ||
+	     (valPE2 & 0x00000100)) {
+		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET shutdown error\n");
+	}
+}
+
+/*
+ * Initialize PCI Express core as described in User Manual section 27.12.1
+ */
+int ppc440spe_init_pcie(void)
+{
+	/* Set PLL clock receiver to LVPECL */
+	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) | 1 << 28);
+
+	check_error();
+
+	printk(KERN_INFO "PCIE initialization OK\n");
+
+	if (!(SDR_READ(PESDR0_PLLLCT2) & 0x10000))
+		printk(KERN_INFO "PESDR_PLLCT2 resistance calibration failed (0x%08x)\n",
+		       SDR_READ(PESDR0_PLLLCT2));
+
+	/* De-assert reset of PCIe PLL, wait for lock */
+	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) & ~(1 << 24));
+	udelay(3);
+
+	return 0;
+}
+
+int ppc440spe_init_pcie_rootport(int port)
+{
+	static int core_init;
+	void __iomem *utl_base;
+	u32 val = 0;
+	int i;
+
+	if (!core_init) {
+		++core_init;
+		i = ppc440spe_init_pcie();
+		if (i)
+			return i;
+	}
+
+	/*
+	 * Initialize various parts of the PCI Express core for our port:
+	 *
+	 * - Set as a root port and enable max width
+	 *   (PXIE0 -> X8, PCIE1 and PCIE2 -> X4).
+	 * - Set up UTL configuration.
+	 * - Increase SERDES drive strength to levels suggested by AMCC.
+	 * - De-assert RSTPYN, RSTDL and RSTGU.
+	 */
+	switch (port) {
+	case 0:
+		SDR_WRITE(PESDR0_DLPSET, PTYPE_ROOT_PORT << 20 | LNKW_X8 << 12);
+
+		SDR_WRITE(PESDR0_UTLSET1, 0x21222222);
+		SDR_WRITE(PESDR0_UTLSET2, 0x11000000);
+
+		SDR_WRITE(PESDR0_HSSL0SET1, 0x35000000);
+		SDR_WRITE(PESDR0_HSSL1SET1, 0x35000000);
+		SDR_WRITE(PESDR0_HSSL2SET1, 0x35000000);
+		SDR_WRITE(PESDR0_HSSL3SET1, 0x35000000);
+		SDR_WRITE(PESDR0_HSSL4SET1, 0x35000000);
+		SDR_WRITE(PESDR0_HSSL5SET1, 0x35000000);
+		SDR_WRITE(PESDR0_HSSL6SET1, 0x35000000);
+		SDR_WRITE(PESDR0_HSSL7SET1, 0x35000000);
+
+		SDR_WRITE(PESDR0_RCSSET,
+			  (SDR_READ(PESDR0_RCSSET) & ~(1 << 24 | 1 << 16)) | 1 << 12);
+		break;
+
+	case 1:
+		SDR_WRITE(PESDR1_DLPSET, PTYPE_ROOT_PORT << 20 | LNKW_X4 << 12);
+
+		SDR_WRITE(PESDR1_UTLSET1, 0x21222222);
+		SDR_WRITE(PESDR1_UTLSET2, 0x11000000);
+
+		SDR_WRITE(PESDR1_HSSL0SET1, 0x35000000);
+		SDR_WRITE(PESDR1_HSSL1SET1, 0x35000000);
+		SDR_WRITE(PESDR1_HSSL2SET1, 0x35000000);
+		SDR_WRITE(PESDR1_HSSL3SET1, 0x35000000);
+
+		SDR_WRITE(PESDR1_RCSSET,
+			  (SDR_READ(PESDR1_RCSSET) & ~(1 << 24 | 1 << 16)) | 1 << 12);
+		break;
+
+	case 2:
+		SDR_WRITE(PESDR2_DLPSET, PTYPE_ROOT_PORT << 20 | LNKW_X4 << 12);
+
+		SDR_WRITE(PESDR2_UTLSET1, 0x21222222);
+		SDR_WRITE(PESDR2_UTLSET2, 0x11000000);
+
+		SDR_WRITE(PESDR2_HSSL0SET1, 0x35000000);
+		SDR_WRITE(PESDR2_HSSL1SET1, 0x35000000);
+		SDR_WRITE(PESDR2_HSSL2SET1, 0x35000000);
+		SDR_WRITE(PESDR2_HSSL3SET1, 0x35000000);
+
+		SDR_WRITE(PESDR2_RCSSET,
+			  (SDR_READ(PESDR2_RCSSET) & ~(1 << 24 | 1 << 16)) | 1 << 12);
+		break;
+	}
+
+	mdelay(1000);
+
+	switch (port) {
+	case 0: val = SDR_READ(PESDR0_RCSSTS); break;
+	case 1: val = SDR_READ(PESDR1_RCSSTS); break;
+	case 2: val = SDR_READ(PESDR2_RCSSTS); break;
+	}
+
+	if (!(val & (1 << 20)))
+		printk(KERN_INFO "PCIE%d: PGRST inactive\n", port);
+	else
+		printk(KERN_WARNING "PGRST for PCIE%d failed %08x\n", port, val);
+	
+	switch (port) {
+	case 0: printk(KERN_INFO "PCIE0: LOOP %08x\n", SDR_READ(PESDR0_LOOP)); break;
+	case 1: printk(KERN_INFO "PCIE1: LOOP %08x\n", SDR_READ(PESDR1_LOOP)); break;
+	case 2: printk(KERN_INFO "PCIE2: LOOP %08x\n", SDR_READ(PESDR2_LOOP)); break;
+	}
+
+	/*
+	 * Map UTL registers at 0xc_1000_0n00
+	 */
+	switch (port) {
+	case 0:
+		mtdcr(DCRN_PEGPL_REGBAH(PCIE0), 0x0000000c);
+		mtdcr(DCRN_PEGPL_REGBAL(PCIE0), 0x10000000);
+		mtdcr(DCRN_PEGPL_REGMSK(PCIE0), 0x00007001);
+		mtdcr(DCRN_PEGPL_SPECIAL(PCIE0), 0x68782800);
+		break;
+
+	case 1:
+		mtdcr(DCRN_PEGPL_REGBAH(PCIE1), 0x0000000c);
+		mtdcr(DCRN_PEGPL_REGBAL(PCIE1), 0x10001000);
+		mtdcr(DCRN_PEGPL_REGMSK(PCIE1), 0x00007001);
+		mtdcr(DCRN_PEGPL_SPECIAL(PCIE1), 0x68782800);
+		break;
+
+	case 2:
+		mtdcr(DCRN_PEGPL_REGBAH(PCIE2), 0x0000000c);
+		mtdcr(DCRN_PEGPL_REGBAL(PCIE2), 0x10002000);
+		mtdcr(DCRN_PEGPL_REGMSK(PCIE2), 0x00007001);
+		mtdcr(DCRN_PEGPL_SPECIAL(PCIE2), 0x68782800);
+	}
+
+	utl_base = ioremap64(0xc10000000ull + 0x1000 * port, 0x100);
+
+	/*
+	 * Set buffer allocations and then assert VRB and TXE.
+	 */
+	out_be32(utl_base + PEUTL_OUTTR,   0x08000000);
+	out_be32(utl_base + PEUTL_INTR,    0x02000000);
+	out_be32(utl_base + PEUTL_OPDBSZ,  0x10000000);
+	out_be32(utl_base + PEUTL_PBBSZ,   0x53000000);
+	out_be32(utl_base + PEUTL_IPHBSZ,  0x08000000);
+	out_be32(utl_base + PEUTL_IPDBSZ,  0x10000000);
+	out_be32(utl_base + PEUTL_RCIRQEN, 0x00f00000);
+	out_be32(utl_base + PEUTL_PCTL,    0x80800066);
+
+	iounmap(utl_base);
+
+	/*
+	 * We map PCI Express configuration access into the 512MB regions
+	 *     PCIE0: 0xc_4000_0000
+	 *     PCIE1: 0xc_8000_0000
+	 *     PCIE2: 0xc_c000_0000
+	 */
+	switch (port) {
+	case 0:
+		mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000c);
+		mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x40000000);
+		mtdcr(DCRN_PEGPL_CFGMSK(PCIE0), 0xe0000001); /* 512MB region, valid */
+		break;
+
+	case 1:
+		mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000c);
+		mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x80000000);
+		mtdcr(DCRN_PEGPL_CFGMSK(PCIE1), 0xe0000001); /* 512MB region, valid */
+		break;
+
+	case 2:
+		mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000c);
+		mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0xc0000000);
+		mtdcr(DCRN_PEGPL_CFGMSK(PCIE2), 0xe0000001); /* 512MB region, valid */
+		break;
+	}
+
+	/*
+	 * Check for VC0 active and assert RDY.
+	 */
+	switch (port) {
+	case 0:
+		if (!(SDR_READ(PESDR0_RCSSTS) & (1 << 16)))
+			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		SDR_WRITE(PESDR0_RCSSET, SDR_READ(PESDR0_RCSSET) | 1 << 20);
+		break;
+	case 1:
+		if (!(SDR_READ(PESDR1_RCSSTS) & (1 << 16)))
+			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		SDR_WRITE(PESDR1_RCSSET, SDR_READ(PESDR1_RCSSET) | 1 << 20);
+		break;
+	case 2:
+		if (!(SDR_READ(PESDR2_RCSSTS) & (1 << 16)))
+			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		SDR_WRITE(PESDR2_RCSSET, SDR_READ(PESDR2_RCSSET) | 1 << 20);
+		break;
+	}
+
+#if 0
+	/* Dump all config regs */
+	for (i = 0x300; i <= 0x320; ++i)
+		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
+	for (i = 0x340; i <= 0x353; ++i)
+		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
+	for (i = 0x370; i <= 0x383; ++i)
+		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
+	for (i = 0x3a0; i <= 0x3a2; ++i)
+		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
+	for (i = 0x3c0; i <= 0x3c3; ++i)
+		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
+#endif
+
+	mdelay(100);
+
+	return 0;
+}
+
+void ppc440spe_setup_pcie(struct pci_controller *hose, int port)
+{
+	void __iomem *mbase;
+
+	/*
+	 * Map 16MB, which is enough for 4 bits of bus #
+	 */
+	hose->cfg_data = ioremap64(0xc40000000ull + port * 0x40000000,
+				   1 << 24);
+	hose->ops = &pcie_pci_ops;
+
+	/*
+	 * Set bus numbers on our root port
+	 */
+	mbase = ioremap64(0xc50000000ull + port * 0x40000000, 4096);
+	out_8(mbase + PCI_PRIMARY_BUS, 0);
+	out_8(mbase + PCI_SECONDARY_BUS, 0);
+
+	/*
+	 * Set up outbound translation to hose->mem_space from PLB
+	 * addresses at an offset of 0xd_0000_0000.  We set the low
+	 * bits of the mask to 11 to turn off splitting into 8
+	 * subregions and to enable the outbound translation.
+	 */
+	out_le32(mbase + PECFG_POM0LAH, 0);
+	out_le32(mbase + PECFG_POM0LAL, hose->mem_space.start);
+
+	switch (port) {
+	case 0:
+		mtdcr(DCRN_PEGPL_OMR1BAH(PCIE0),  0x0000000d);
+		mtdcr(DCRN_PEGPL_OMR1BAL(PCIE0),  hose->mem_space.start);
+		mtdcr(DCRN_PEGPL_OMR1MSKH(PCIE0), 0x7fffffff);
+		mtdcr(DCRN_PEGPL_OMR1MSKL(PCIE0),
+		      ~(hose->mem_space.end - hose->mem_space.start) | 3);
+		break;
+	case 1:
+		mtdcr(DCRN_PEGPL_OMR1BAH(PCIE1),  0x0000000d);
+		mtdcr(DCRN_PEGPL_OMR1BAL(PCIE1),  hose->mem_space.start);
+		mtdcr(DCRN_PEGPL_OMR1MSKH(PCIE1), 0x7fffffff);
+		mtdcr(DCRN_PEGPL_OMR1MSKL(PCIE1),
+		      ~(hose->mem_space.end - hose->mem_space.start) | 3);
+
+		break;
+	case 2:
+		mtdcr(DCRN_PEGPL_OMR1BAH(PCIE2),  0x0000000d);
+		mtdcr(DCRN_PEGPL_OMR1BAL(PCIE2),  hose->mem_space.start);
+		mtdcr(DCRN_PEGPL_OMR1MSKH(PCIE2), 0x7fffffff);
+		mtdcr(DCRN_PEGPL_OMR1MSKL(PCIE2),
+		      ~(hose->mem_space.end - hose->mem_space.start) | 3);
+		break;
+	}
+
+	/* Set up 16GB inbound memory window at 0 */
+	out_le32(mbase + PCI_BASE_ADDRESS_0, 0);
+	out_le32(mbase + PCI_BASE_ADDRESS_1, 0);
+	out_le32(mbase + PECFG_BAR0HMPA, 0x7fffffc);
+	out_le32(mbase + PECFG_BAR0LMPA, 0);
+	out_le32(mbase + PECFG_PIM0LAL, 0);
+	out_le32(mbase + PECFG_PIM0LAH, 0);
+	out_le32(mbase + PECFG_PIMEN, 0x1);
+
+	/* Enable I/O, Mem, and Busmaster cycles */
+	out_le16(mbase + PCI_COMMAND,
+		 in_le16(mbase + PCI_COMMAND) |
+		 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+
+	iounmap(mbase);
+}
diff --git a/arch/ppc/syslib/ppc440spe_pcie.h b/arch/ppc/syslib/ppc440spe_pcie.h
new file mode 100644
index 0000000..55b765a
--- /dev/null
+++ b/arch/ppc/syslib/ppc440spe_pcie.h
@@ -0,0 +1,149 @@
+/*
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
+ * Roland Dreier <rolandd@cisco.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __PPC_SYSLIB_PPC440SPE_PCIE_H
+#define __PPC_SYSLIB_PPC440SPE_PCIE_H
+
+#define DCRN_SDR0_CFGADDR	0x00e
+#define DCRN_SDR0_CFGDATA	0x00f
+
+#define DCRN_PCIE0_BASE		0x100
+#define DCRN_PCIE1_BASE		0x120
+#define DCRN_PCIE2_BASE		0x140
+#define PCIE0			DCRN_PCIE0_BASE
+#define PCIE1			DCRN_PCIE1_BASE
+#define PCIE2			DCRN_PCIE2_BASE
+
+#define DCRN_PEGPL_CFGBAH(base)		(base + 0x00)
+#define DCRN_PEGPL_CFGBAL(base)		(base + 0x01)
+#define DCRN_PEGPL_CFGMSK(base)		(base + 0x02)
+#define DCRN_PEGPL_MSGBAH(base)		(base + 0x03)
+#define DCRN_PEGPL_MSGBAL(base)		(base + 0x04)
+#define DCRN_PEGPL_MSGMSK(base)		(base + 0x05)
+#define DCRN_PEGPL_OMR1BAH(base)	(base + 0x06)
+#define DCRN_PEGPL_OMR1BAL(base)	(base + 0x07)
+#define DCRN_PEGPL_OMR1MSKH(base)	(base + 0x08)
+#define DCRN_PEGPL_OMR1MSKL(base)	(base + 0x09)
+#define DCRN_PEGPL_REGBAH(base)		(base + 0x12)
+#define DCRN_PEGPL_REGBAL(base)		(base + 0x13)
+#define DCRN_PEGPL_REGMSK(base)		(base + 0x14)
+#define DCRN_PEGPL_SPECIAL(base)	(base + 0x15)
+
+/*
+ * System DCRs (SDRs)
+ */
+#define PESDR0_PLLLCT1		0x03a0
+#define PESDR0_PLLLCT2		0x03a1
+#define PESDR0_PLLLCT3		0x03a2
+
+#define PESDR0_UTLSET1		0x0300
+#define PESDR0_UTLSET2		0x0301
+#define PESDR0_DLPSET		0x0302
+#define PESDR0_LOOP		0x0303
+#define PESDR0_RCSSET		0x0304
+#define PESDR0_RCSSTS		0x0305
+#define PESDR0_HSSL0SET1	0x0306
+#define PESDR0_HSSL0SET2	0x0307
+#define PESDR0_HSSL0STS		0x0308
+#define PESDR0_HSSL1SET1	0x0309
+#define PESDR0_HSSL1SET2	0x030a
+#define PESDR0_HSSL1STS		0x030b
+#define PESDR0_HSSL2SET1	0x030c
+#define PESDR0_HSSL2SET2	0x030d
+#define PESDR0_HSSL2STS		0x030e
+#define PESDR0_HSSL3SET1	0x030f
+#define PESDR0_HSSL3SET2	0x0310
+#define PESDR0_HSSL3STS		0x0311
+#define PESDR0_HSSL4SET1	0x0312
+#define PESDR0_HSSL4SET2	0x0313
+#define PESDR0_HSSL4STS		0x0314
+#define PESDR0_HSSL5SET1	0x0315
+#define PESDR0_HSSL5SET2	0x0316
+#define PESDR0_HSSL5STS		0x0317
+#define PESDR0_HSSL6SET1	0x0318
+#define PESDR0_HSSL6SET2	0x0319
+#define PESDR0_HSSL6STS		0x031a
+#define PESDR0_HSSL7SET1	0x031b
+#define PESDR0_HSSL7SET2	0x031c
+#define PESDR0_HSSL7STS		0x031d
+#define PESDR0_HSSCTLSET	0x031e
+#define PESDR0_LANE_ABCD	0x031f
+#define PESDR0_LANE_EFGH	0x0320
+
+#define PESDR1_UTLSET1		0x0340
+#define PESDR1_UTLSET2		0x0341
+#define PESDR1_DLPSET		0x0342
+#define PESDR1_LOOP		0x0343
+#define PESDR1_RCSSET		0x0344
+#define PESDR1_RCSSTS		0x0345
+#define PESDR1_HSSL0SET1	0x0346
+#define PESDR1_HSSL0SET2	0x0347
+#define PESDR1_HSSL0STS		0x0348
+#define PESDR1_HSSL1SET1	0x0349
+#define PESDR1_HSSL1SET2	0x034a
+#define PESDR1_HSSL1STS		0x034b
+#define PESDR1_HSSL2SET1	0x034c
+#define PESDR1_HSSL2SET2	0x034d
+#define PESDR1_HSSL2STS		0x034e
+#define PESDR1_HSSL3SET1	0x034f
+#define PESDR1_HSSL3SET2	0x0350
+#define PESDR1_HSSL3STS		0x0351
+#define PESDR1_HSSCTLSET	0x0352
+#define PESDR1_LANE_ABCD	0x0353
+
+#define PESDR2_UTLSET1		0x0370
+#define PESDR2_UTLSET2		0x0371
+#define PESDR2_DLPSET		0x0372
+#define PESDR2_LOOP		0x0373
+#define PESDR2_RCSSET		0x0374
+#define PESDR2_RCSSTS		0x0375
+#define PESDR2_HSSL0SET1	0x0376
+#define PESDR2_HSSL0SET2	0x0377
+#define PESDR2_HSSL0STS		0x0378
+#define PESDR2_HSSL1SET1	0x0379
+#define PESDR2_HSSL1SET2	0x037a
+#define PESDR2_HSSL1STS		0x037b
+#define PESDR2_HSSL2SET1	0x037c
+#define PESDR2_HSSL2SET2	0x037d
+#define PESDR2_HSSL2STS		0x037e
+#define PESDR2_HSSL3SET1	0x037f
+#define PESDR2_HSSL3SET2	0x0380
+#define PESDR2_HSSL3STS		0x0381
+#define PESDR2_HSSCTLSET	0x0382
+#define PESDR2_LANE_ABCD	0x0383
+
+/*
+ * UTL register offsets
+ */
+#define PEUTL_PBBSZ		0x20
+#define PEUTL_OPDBSZ		0x68
+#define PEUTL_IPHBSZ		0x70
+#define PEUTL_IPDBSZ		0x78
+#define PEUTL_OUTTR		0x90
+#define PEUTL_INTR		0x98
+#define PEUTL_PCTL		0xa0
+#define PEUTL_RCIRQEN		0xb8
+
+/*
+ * Config space register offsets
+ */
+#define PECFG_BAR0LMPA		0x210
+#define PECFG_BAR0HMPA		0x214
+#define PECFG_PIMEN		0x33c
+#define PECFG_PIM0LAL		0x340
+#define PECFG_PIM0LAH		0x344
+#define PECFG_POM0LAL		0x380
+#define PECFG_POM0LAH		0x384
+
+int ppc440spe_init_pcie(void);
+int ppc440spe_init_pcie_rootport(int port);
+void ppc440spe_setup_pcie(struct pci_controller *hose, int port);
+
+#endif /* __PPC_SYSLIB_PPC440SPE_PCIE_H */
diff --git a/arch/ppc/syslib/ppc4xx_pic.c b/arch/ppc/syslib/ppc4xx_pic.c
index 4008621..e3b68d0 100644
--- a/arch/ppc/syslib/ppc4xx_pic.c
+++ b/arch/ppc/syslib/ppc4xx_pic.c
@@ -37,6 +37,7 @@ extern unsigned char ppc4xx_uic_ext_irq_
 #define IRQ_MASK_UICx(irq)		(1 << (31 - ((irq) & 0x1f)))
 #define IRQ_MASK_UIC1(irq)		IRQ_MASK_UICx(irq)
 #define IRQ_MASK_UIC2(irq)		IRQ_MASK_UICx(irq)
+#define IRQ_MASK_UIC3(irq)		IRQ_MASK_UICx(irq)
 
 #define UIC_HANDLERS(n)							\
 static void ppc4xx_uic##n##_enable(unsigned int irq)			\
@@ -87,7 +88,38 @@ static void ppc4xx_uic##n##_end(unsigned
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
+	else if (uic0 & UIC0_UIC3NC)
+		return 128 - ffs(mfdcr(DCRN_UIC_MSR(UIC3)));
+	else
+		return uic0 ? 32 - ffs(uic0) : -1;
+}
+
+static void __init ppc4xx_pic_impl_init(void)
+{
+	/* Enable cascade interrupts in UIC0 */
+	ppc_cached_irq_mask[0] |= UIC0_UIC1NC | UIC0_UIC2NC | UIC0_UIC3NC;
+	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC | UIC0_UIC2NC | UIC0_UIC3NC);
+	mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[0]);
+}
+
+#elif NR_UICS == 3
 #define ACK_UIC0_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC0NC);
 #define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC1NC);
 #define ACK_UIC2_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC2NC);
@@ -169,6 +201,9 @@ static struct ppc4xx_uic_impl {
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
index 4ee1e33..b8a5fd9 100644
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
@@ -61,6 +64,11 @@
 #define	PPC44x_PCICFG_PAGE	0x0000000900000000ULL
 #define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
 #define	PPC44x_PCIMEM_PAGE	0x0000000a00000000ULL
+#elif defined(CONFIG_440SPE)
+#define	PPC44x_IO_PAGE		0x0000000400000000ULL
+#define	PPC44x_PCICFG_PAGE	0x0000000c00000000ULL
+#define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
+#define	PPC44x_PCIMEM_PAGE	0x0000000d00000000ULL
 #elif defined(CONFIG_440EP)
 #define PPC44x_IO_PAGE		0x0000000000000000ULL
 #define PPC44x_PCICFG_PAGE	0x0000000000000000ULL
@@ -76,7 +84,7 @@
 /*
  * 36-bit trap ranges
  */
-#if defined(CONFIG_440SP)
+#if defined(CONFIG_440SP) || defined(CONFIG_440SPE)
 #define PPC44x_IO_LO		0xf0000000UL
 #define PPC44x_IO_HI		0xf0000fffUL
 #define PPC44x_PCI0CFG_LO	0x0ec00000UL
@@ -114,7 +122,7 @@
  */
 
 
-/* CPRs (440GX and 440SP) */
+/* CPRs (440GX and 440SP/440SPe) */
 #define DCRN_CPR_CONFIG_ADDR	0xc
 #define DCRN_CPR_CONFIG_DATA	0xd
 
@@ -135,7 +143,7 @@
 	mtdcr(DCRN_CPR_CONFIG_ADDR, offset); \
 	mtdcr(DCRN_CPR_CONFIG_DATA, data);})
 
-/* SDRs (440GX and 440SP) */
+/* SDRs (440GX and 440SP/440SPe) */
 #define DCRN_SDR_CONFIG_ADDR 	0xe
 #define DCRN_SDR_CONFIG_DATA	0xf
 #define DCRN_SDR_PFC0		0x4100
@@ -185,7 +193,7 @@
 	mtdcr(DCRN_SDR_CONFIG_ADDR, offset); \
 	mtdcr(DCRN_SDR_CONFIG_DATA,data);})
 
-/* DMA (excluding 440SP) */
+/* DMA (excluding 440SP/440SPe) */
 #define DCRN_DMA0_BASE		0x100
 #define DCRN_DMA1_BASE		0x108
 #define DCRN_DMA2_BASE		0x110
@@ -205,12 +213,20 @@
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
@@ -223,6 +239,12 @@
 
 #define UIC0_UIC1NC      	0x00000002
 
+#ifdef CONFIG_440SPE
+#define UIC0_UIC1NC      0x00000002
+#define UIC0_UIC2NC      0x00200000
+#define UIC0_UIC3NC      0x00008000
+#endif
+
 #define UICB_UIC0NC		0x40000000
 #define UICB_UIC1NC		0x10000000
 #define UICB_UIC2NC		0x04000000
@@ -302,8 +324,8 @@
 #define MALOBISR_CH0		0x80000000	/* EOB channel 1 bit */
 #define MALOBISR_CH2		0x40000000	/* EOB channel 2 bit */
 
-#if defined(CONFIG_440SP)
-/* 440SP PLB Arbiter DCRs */
+#if defined(CONFIG_440SP) || defined(CONFIG_440SPE)
+/* 440SP/440SPe PLB Arbiter DCRs */
 #define DCRN_PLB_REVID	       0x080		/* PLB Revision ID */
 #define DCRN_PLB_CCR	       0x088		/* PLB Crossbar Control */
 
@@ -430,9 +452,13 @@
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
@@ -444,8 +470,9 @@
 #define MQ0_CONFIG_SIZE_512M		0x0000f000
 #define MQ0_CONFIG_SIZE_1G		0x0000e000
 #define MQ0_CONFIG_SIZE_2G		0x0000c000
+#define MQ0_CONFIG_SIZE_4G		0x00008000
 
-/* Internal SRAM Controller 440GX/440SP */
+/* Internal SRAM Controller 440GX/440SP/440SPe */
 #define DCRN_SRAM0_BASE		0x000
 
 #define DCRN_SRAM0_SB0CR	(DCRN_SRAM0_BASE + 0x020)
@@ -469,7 +496,7 @@
 #define DCRN_SRAM0_DPC		(DCRN_SRAM0_BASE + 0x02a)
 #define  SRAM_DPC_ENABLE	0x80000000
 
-/* L2 Cache Controller 440GX/440SP */
+/* L2 Cache Controller 440GX/440SP/440SPe */
 #define DCRN_L2C0_CFG		0x030
 #define  L2C_CFG_L2M		0x80000000
 #define  L2C_CFG_ICU		0x40000000
@@ -633,8 +660,10 @@
 #define IIC_CLOCK		50
 
 #undef NR_UICS
-#ifdef CONFIG_440GX
+#if defined(CONFIG_440GX)
 #define NR_UICS 3
+#elif defined(CONFIG_440SPE)
+#define NR_UICS 4
 #else
 #define NR_UICS 2
 #endif
---
0.99.8.GIT
