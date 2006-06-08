Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 784B567C42
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 08:04:29 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k58MLEDV000090
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 15:21:14 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k58M4QpA021649
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 17:04:27 -0500 (CDT)
Subject: [PATCH 6/10 v2] Add 8641 Register space and IRQ definitions.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149804025.23938.287.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 17:00:26 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Jeff Brown <Jeff.Brown@freescale.com>
Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>

---

 include/asm-powerpc/immap_86xx.h |  199 ++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/irq.h        |   88 +++++++++++++++++
 include/asm-powerpc/mpc86xx.h    |   47 +++++++++
 3 files changed, 334 insertions(+), 0 deletions(-)


diff --git a/include/asm-powerpc/immap_86xx.h b/include/asm-powerpc/immap_86xx.h
new file mode 100644
index 0000000..d905b66
--- /dev/null
+++ b/include/asm-powerpc/immap_86xx.h
@@ -0,0 +1,199 @@
+/*
+ * MPC86xx Internal Memory Map
+ *
+ * Author: Jeff Brown
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __ASM_POWERPC_IMMAP_86XX_H__
+#define __ASM_POWERPC_IMMAP_86XX_H__
+#ifdef __KERNEL__
+
+/* Eventually this should define all the IO block registers in 86xx */
+
+/* PCI Registers */
+typedef struct ccsr_pci {
+	uint	cfg_addr;	/* 0x.000 - PCI Configuration Address Register */
+	uint	cfg_data;	/* 0x.004 - PCI Configuration Data Register */
+	uint	int_ack;	/* 0x.008 - PCI Interrupt Acknowledge Register */
+	char	res1[3060];
+	uint	potar0;		/* 0x.c00 - PCI Outbound Transaction Address Register 0 */
+	uint	potear0;	/* 0x.c04 - PCI Outbound Translation Extended Address Register 0 */
+	uint	powbar0;	/* 0x.c08 - PCI Outbound Window Base Address Register 0 */
+	char	res2[4];
+	uint	powar0;		/* 0x.c10 - PCI Outbound Window Attributes Register 0 */
+	char	res3[12];
+	uint	potar1;		/* 0x.c20 - PCI Outbound Transaction Address Register 1 */
+	uint	potear1;	/* 0x.c24 - PCI Outbound Translation Extended Address Register 1 */
+	uint	powbar1;	/* 0x.c28 - PCI Outbound Window Base Address Register 1 */
+	char	res4[4];
+	uint	powar1;		/* 0x.c30 - PCI Outbound Window Attributes Register 1 */
+	char	res5[12];
+	uint	potar2;		/* 0x.c40 - PCI Outbound Transaction Address Register 2 */
+	uint	potear2;	/* 0x.c44 - PCI Outbound Translation Extended Address Register 2 */
+	uint	powbar2;	/* 0x.c48 - PCI Outbound Window Base Address Register 2 */
+	char	res6[4];
+	uint	powar2;		/* 0x.c50 - PCI Outbound Window Attributes Register 2 */
+	char	res7[12];
+	uint	potar3;		/* 0x.c60 - PCI Outbound Transaction Address Register 3 */
+	uint	potear3;	/* 0x.c64 - PCI Outbound Translation Extended Address Register 3 */
+	uint	powbar3;	/* 0x.c68 - PCI Outbound Window Base Address Register 3 */
+	char	res8[4];
+	uint	powar3;		/* 0x.c70 - PCI Outbound Window Attributes Register 3 */
+	char	res9[12];
+	uint	potar4;		/* 0x.c80 - PCI Outbound Transaction Address Register 4 */
+	uint	potear4;	/* 0x.c84 - PCI Outbound Translation Extended Address Register 4 */
+	uint	powbar4;	/* 0x.c88 - PCI Outbound Window Base Address Register 4 */
+	char	res10[4];
+	uint	powar4;		/* 0x.c90 - PCI Outbound Window Attributes Register 4 */
+	char	res11[268];
+	uint	pitar3;		/* 0x.da0 - PCI Inbound Translation Address Register 3  */
+	char	res12[4];
+	uint	piwbar3;	/* 0x.da8 - PCI Inbound Window Base Address Register 3 */
+	uint	piwbear3;	/* 0x.dac - PCI Inbound Window Base Extended Address Register 3 */
+	uint	piwar3;		/* 0x.db0 - PCI Inbound Window Attributes Register 3 */
+	char	res13[12];
+	uint	pitar2;		/* 0x.dc0 - PCI Inbound Translation Address Register 2  */
+	char	res14[4];
+	uint	piwbar2;	/* 0x.dc8 - PCI Inbound Window Base Address Register 2 */
+	uint	piwbear2;	/* 0x.dcc - PCI Inbound Window Base Extended Address Register 2 */
+	uint	piwar2;		/* 0x.dd0 - PCI Inbound Window Attributes Register 2 */
+	char	res15[12];
+	uint	pitar1;		/* 0x.de0 - PCI Inbound Translation Address Register 1  */
+	char	res16[4];
+	uint	piwbar1;	/* 0x.de8 - PCI Inbound Window Base Address Register 1 */
+	char	res17[4];
+	uint	piwar1;		/* 0x.df0 - PCI Inbound Window Attributes Register 1 */
+	char	res18[12];
+	uint	err_dr;		/* 0x.e00 - PCI Error Detect Register */
+	uint	err_cap_dr;	/* 0x.e04 - PCI Error Capture Disable Register */
+	uint	err_en;		/* 0x.e08 - PCI Error Enable Register */
+	uint	err_attrib;	/* 0x.e0c - PCI Error Attributes Capture Register */
+	uint	err_addr;	/* 0x.e10 - PCI Error Address Capture Register */
+	uint	err_ext_addr;	/* 0x.e14 - PCI Error Extended Address Capture Register */
+	uint	err_dl;		/* 0x.e18 - PCI Error Data Low Capture Register */
+	uint	err_dh;		/* 0x.e1c - PCI Error Data High Capture Register */
+	uint	gas_timr;	/* 0x.e20 - PCI Gasket Timer Register */
+	uint	pci_timr;	/* 0x.e24 - PCI Timer Register */
+	char	res19[472];
+} ccsr_pci_t;
+
+/* PCI Express Registers */
+typedef struct ccsr_pex {
+	uint    pex_config_addr;        /* 0x.000 - PCI Express Configuration Address Register */
+	uint    pex_config_data;        /* 0x.004 - PCI Express Configuration Data Register */
+	char    res1[4];
+	uint    pex_otb_cpl_tor;        /* 0x.00c - PCI Express Outbound completion timeout register */
+	uint    pex_conf_tor;           /* 0x.010 - PCI Express configuration timeout register */
+	char    res2[12];
+	uint    pex_pme_mes_dr;         /* 0x.020 - PCI Express PME and message detect register */
+	uint    pex_pme_mes_disr;       /* 0x.024 - PCI Express PME and message disable register */
+	uint    pex_pme_mes_ier;        /* 0x.028 - PCI Express PME and message interrupt enable register */
+	uint    pex_pmcr;               /* 0x.02c - PCI Express power management command register */
+	char    res3[3024];
+	uint    pexotar0;               /* 0x.c00 - PCI Express outbound translation address register 0 */
+	uint    pexotear0;              /* 0x.c04 - PCI Express outbound translation extended address register 0*/
+	char    res4[8];
+	uint    pexowar0;               /* 0x.c10 - PCI Express outbound window attributes register 0*/
+	char    res5[12];
+	uint    pexotar1;               /* 0x.c20 - PCI Express outbound translation address register 1 */
+	uint    pexotear1;              /* 0x.c24 - PCI Express outbound translation extended address register 1*/
+	uint    pexowbar1;              /* 0x.c28 - PCI Express outbound window base address register 1*/
+	char    res6[4];
+	uint    pexowar1;               /* 0x.c30 - PCI Express outbound window attributes register 1*/
+	char    res7[12];
+	uint    pexotar2;               /* 0x.c40 - PCI Express outbound translation address register 2 */
+	uint    pexotear2;              /* 0x.c44 - PCI Express outbound translation extended address register 2*/
+	uint    pexowbar2;              /* 0x.c48 - PCI Express outbound window base address register 2*/
+	char    res8[4];
+	uint    pexowar2;               /* 0x.c50 - PCI Express outbound window attributes register 2*/
+	char    res9[12];
+	uint    pexotar3;               /* 0x.c60 - PCI Express outbound translation address register 3 */
+	uint    pexotear3;              /* 0x.c64 - PCI Express outbound translation extended address register 3*/
+	uint    pexowbar3;              /* 0x.c68 - PCI Express outbound window base address register 3*/
+	char    res10[4];
+	uint    pexowar3;               /* 0x.c70 - PCI Express outbound window attributes register 3*/
+	char    res11[12];
+	uint    pexotar4;               /* 0x.c80 - PCI Express outbound translation address register 4 */
+	uint    pexotear4;              /* 0x.c84 - PCI Express outbound translation extended address register 4*/
+	uint    pexowbar4;              /* 0x.c88 - PCI Express outbound window base address register 4*/
+	char    res12[4];
+	uint    pexowar4;               /* 0x.c90 - PCI Express outbound window attributes register 4*/
+	char    res13[12];
+	char    res14[256];
+	uint    pexitar3;               /* 0x.da0 - PCI Express inbound translation address register 3 */
+	char    res15[4];
+	uint    pexiwbar3;              /* 0x.da8 - PCI Express inbound window base address register 3 */
+	uint    pexiwbear3;             /* 0x.dac - PCI Express inbound window base extended address register 3 */
+	uint    pexiwar3;               /* 0x.db0 - PCI Express inbound window attributes register 3 */
+	char    res16[12];
+	uint    pexitar2;               /* 0x.dc0 - PCI Express inbound translation address register 2 */
+	char    res17[4];
+	uint    pexiwbar2;              /* 0x.dc8 - PCI Express inbound window base address register 2 */
+	uint    pexiwbear2;             /* 0x.dcc - PCI Express inbound window base extended address register 2 */
+	uint    pexiwar2;               /* 0x.dd0 - PCI Express inbound window attributes register 2 */
+	char    res18[12];
+	uint    pexitar1;               /* 0x.de0 - PCI Express inbound translation address register 2 */
+	char    res19[4];
+	uint    pexiwbar1;              /* 0x.de8 - PCI Express inbound window base address register 2 */
+	uint    pexiwbear1;             /* 0x.dec - PCI Express inbound window base extended address register 2 */
+	uint    pexiwar1;               /* 0x.df0 - PCI Express inbound window attributes register 2 */
+	char    res20[12];
+	uint    pex_err_dr;             /* 0x.e00 - PCI Express error detect register */
+	char    res21[4];
+	uint    pex_err_en;             /* 0x.e08 - PCI Express error interrupt enable register */
+	char    res22[4];
+	uint    pex_err_disr;           /* 0x.e10 - PCI Express error disable register */
+	char    res23[12];
+	uint    pex_err_cap_stat;       /* 0x.e20 - PCI Express error capture status register */
+	char    res24[4];
+	uint    pex_err_cap_r0;         /* 0x.e28 - PCI Express error capture register 0 */
+	uint    pex_err_cap_r1;         /* 0x.e2c - PCI Express error capture register 0 */
+	uint    pex_err_cap_r2;         /* 0x.e30 - PCI Express error capture register 0 */
+	uint    pex_err_cap_r3;         /* 0x.e34 - PCI Express error capture register 0 */
+} ccsr_pex_t;
+
+/* Global Utility Registers */
+typedef struct ccsr_guts {
+	uint	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
+	uint	porbmsr;	/* 0x.0004 - POR Boot Mode Status Register */
+	uint	porimpscr;	/* 0x.0008 - POR I/O Impedance Status and Control Register */
+	uint	pordevsr;	/* 0x.000c - POR I/O Device Status Register */
+	uint	pordbgmsr;	/* 0x.0010 - POR Debug Mode Status Register */
+	char	res1[12];
+	uint	gpporcr;	/* 0x.0020 - General-Purpose POR Configuration Register */
+	char	res2[12];
+	uint	gpiocr;		/* 0x.0030 - GPIO Control Register */
+	char	res3[12];
+	uint	gpoutdr;	/* 0x.0040 - General-Purpose Output Data Register */
+	char	res4[12];
+	uint	gpindr;		/* 0x.0050 - General-Purpose Input Data Register */
+	char	res5[12];
+	uint	pmuxcr;		/* 0x.0060 - Alternate Function Signal Multiplex Control */
+	char	res6[12];
+	uint	devdisr;	/* 0x.0070 - Device Disable Control */
+	char	res7[12];
+	uint	powmgtcsr;	/* 0x.0080 - Power Management Status and Control Register */
+	char	res8[12];
+	uint	mcpsumr;	/* 0x.0090 - Machine Check Summary Register */
+	char	res9[12];
+	uint	pvr;		/* 0x.00a0 - Processor Version Register */
+	uint	svr;		/* 0x.00a4 - System Version Register */
+	char	res10[3416];
+	uint	clkocr;		/* 0x.0e00 - Clock Out Select Register */
+	char	res11[12];
+	uint	ddrdllcr;	/* 0x.0e10 - DDR DLL Control Register */
+	char	res12[12];
+	uint	lbcdllcr;	/* 0x.0e20 - LBC DLL Control Register */
+	char	res13[61916];
+} ccsr_guts_t;
+
+#endif /* __ASM_POWERPC_IMMAP_86XX_H__ */
+#endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 7bc6d73..997d2e8 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -348,6 +348,94 @@ #define	SIU_INT_PC2		((uint)0x3d+CPM_IRQ
 #define	SIU_INT_PC1		((uint)0x3e+CPM_IRQ_OFFSET)
 #define	SIU_INT_PC0		((uint)0x3f+CPM_IRQ_OFFSET)
 
+#elif defined(CONFIG_PPC_86xx)
+#include <asm/mpc86xx.h>
+
+#define NR_EPIC_INTS 48
+#ifndef NR_8259_INTS
+#define NR_8259_INTS 16 /*ULI 1575 can route 12 interrupts */
+#endif
+#define NUM_8259_INTERRUPTS NR_8259_INTS
+
+#ifndef I8259_OFFSET
+#define I8259_OFFSET 0
+#endif
+
+#define NR_IRQS 256
+
+/* Internal IRQs on MPC86xx OpenPIC */
+
+#ifndef MPC86xx_OPENPIC_IRQ_OFFSET
+#define MPC86xx_OPENPIC_IRQ_OFFSET NR_8259_INTS
+#endif
+
+/* The 48 internal sources */
+#define MPC86xx_IRQ_NULL        ( 0 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_MCM         ( 1 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_DDR         ( 2 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_LBC         ( 3 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_DMA0        ( 4 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_DMA1        ( 5 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_DMA2        ( 6 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_DMA3        ( 7 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_PEX1        ( 8 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_PEX2        ( 9 + MPC86xx_OPENPIC_IRQ_OFFSET)
+
+/* no 10,11 */
+#define MPC86xx_IRQ_UART2       (12 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC1_TX    (13 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC1_RX    (14 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC3_TX    (15 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC3_RX    (16 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC3_ERROR (17 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC1_ERROR (18 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC2_TX    (19 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC2_RX    (20 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC4_TX    (21 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC4_RX    (22 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC4_ERROR (23 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_TSEC2_ERROR (24 + MPC86xx_OPENPIC_IRQ_OFFSET)
+/* no 25 */
+#define MPC86xx_IRQ_UART1       (26 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_IIC         (27 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_PERFMON       (28 + MPC86xx_OPENPIC_IRQ_OFFSET)
+/* no 29,30,31 */
+#define MPC86xx_IRQ_SRIO_ERROR    (32 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_SRIO_OUT_BELL (33 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_SRIO_IN_BELL  (34 + MPC86xx_OPENPIC_IRQ_OFFSET)
+/* no 35,36 */
+#define MPC86xx_IRQ_SRIO_OUT_MSG1 (37 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_SRIO_IN_MSG1  (38 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_SRIO_OUT_MSG2 (39 + MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_SRIO_IN_MSG2  (40 + MPC86xx_OPENPIC_IRQ_OFFSET)
+
+/* The 12 external interrupt lines */
+#define MPC86xx_IRQ_EXT_BASE	48
+#define MPC86xx_IRQ_EXT0	(0 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT1	(1 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT2	(2 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT3	(3 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT4	(4 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT5	(5 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT6	(6 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT7	(7 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT8	(8 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT9	(9 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT10	(10 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+#define MPC86xx_IRQ_EXT11	(11 + MPC86xx_IRQ_EXT_BASE \
+		+ MPC86xx_OPENPIC_IRQ_OFFSET)
+
 #else /* CONFIG_40x + CONFIG_8xx */
 /*
  * this is the # irq's for all ppc arch's (pmac/chrp/prep)
diff --git a/include/asm-powerpc/mpc86xx.h b/include/asm-powerpc/mpc86xx.h
new file mode 100644
index 0000000..d0a6718
--- /dev/null
+++ b/include/asm-powerpc/mpc86xx.h
@@ -0,0 +1,47 @@
+/*
+ * MPC86xx definitions
+ *
+ * Author: Jeff Brown
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_POWERPC_MPC86xx_H__
+#define __ASM_POWERPC_MPC86xx_H__
+
+#include <linux/config.h>
+#include <asm/mmu.h>
+
+#ifdef CONFIG_PPC_86xx
+
+#ifdef CONFIG_MPC8641_HPCN
+#include <platforms/86xx/mpc8641_hpcn.h>
+#endif
+
+#define _IO_BASE        isa_io_base
+#define _ISA_MEM_BASE   isa_mem_base
+#ifdef CONFIG_PCI
+#define PCI_DRAM_OFFSET pci_dram_offset
+#else
+#define PCI_DRAM_OFFSET 0
+#endif
+
+#define CPU0_BOOT_RELEASE 0x01000000
+#define CPU1_BOOT_RELEASE 0x02000000
+#define CPU_ALL_RELEASED (CPU0_BOOT_RELEASE | CPU1_BOOT_RELEASE)
+#define MCM_PORT_CONFIG_OFFSET 0x1010
+
+/* Offset from CCSRBAR */
+#define MPC86xx_OPENPIC_OFFSET	(0x40000)
+#define MPC86xx_MCM_OFFSET      (0x00000)
+#define MPC86xx_MCM_SIZE        (0x02000)
+
+#endif /* CONFIG_PPC_86xx */
+#endif /* __ASM_POWERPC_MPC86xx_H__ */
+#endif /* __KERNEL__ */
