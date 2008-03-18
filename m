Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 54FE0DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 00:38:10 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] [POWERPC] Add PPC4xx L2-cache support (440GX & 460EX/GT)
Date: Tue, 18 Mar 2008 14:36:29 +0100
Message-Id: <1205847389-17771-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the 256k L2 cache found on some IBM/AMCC
4xx PPC's. It introduces a common 4xx SoC file (sysdev/ppc4xx_soc.c)
which currently "only" adds the L2 cache init code. Other common 4xx
stuff can be added later here.

The L2 cache handling code is just a copy of Eugene's code in arch/ppc
with small modifications.

Tested on AMCC Taishan 440GX and Canyonlands 460EX.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/Kconfig               |    3 +
 arch/powerpc/platforms/44x/Kconfig |    2 +
 arch/powerpc/sysdev/Makefile       |    1 +
 arch/powerpc/sysdev/ppc4xx_soc.c   |  174 ++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/dcr-regs.h     |   78 ++++++++++++++++
 5 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/ppc4xx_soc.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1189d8d..69d4738 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -490,6 +490,9 @@ config FSL_PCI
  	bool
 	select PPC_INDIRECT_PCI
 
+config 4xx_SOC
+	bool
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 83155fe..061ba3c 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -120,6 +120,7 @@ config 440GP
 
 config 440GX
 	bool
+	select 4xx_SOC
 	select IBM_NEW_EMAC_EMAC4
 	select IBM_NEW_EMAC_RGMII
 	select IBM_NEW_EMAC_ZMII #test only
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 15f3e85..851a0be 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_IPIC)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
+obj-$(CONFIG_4xx_SOC)		+= ppc4xx_soc.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
diff --git a/arch/powerpc/sysdev/ppc4xx_soc.c b/arch/powerpc/sysdev/ppc4xx_soc.c
new file mode 100644
index 0000000..4847555
--- /dev/null
+++ b/arch/powerpc/sysdev/ppc4xx_soc.c
@@ -0,0 +1,174 @@
+/*
+ * IBM/AMCC PPC4xx SoC setup code
+ *
+ * Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * L2 cache routines cloned from arch/ppc/syslib/ibm440gx_common.c which is:
+ *   Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *   Copyright (c) 2003 - 2006 Zultys Technologies
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/dcr.h>
+#include <asm/dcr-regs.h>
+
+static u32 dcrbase;
+
+/*
+ * L2-cache
+ */
+
+/* Issue L2C diagnostic command */
+static inline u32 l2c_diag(u32 addr)
+{
+	mtdcr(dcrbase + DCRN_L2C0_ADDR, addr);
+	mtdcr(dcrbase + DCRN_L2C0_CMD, L2C_CMD_DIAG);
+	while (!(mfdcr(dcrbase + DCRN_L2C0_SR) & L2C_SR_CC))
+		;
+
+	return mfdcr(dcrbase + DCRN_L2C0_DATA);
+}
+
+static irqreturn_t l2c_error_handler(int irq, void *dev)
+{
+	u32 sr = mfdcr(dcrbase + DCRN_L2C0_SR);
+
+	if (sr & L2C_SR_CPE) {
+		/* Read cache trapped address */
+		u32 addr = l2c_diag(0x42000000);
+		printk(KERN_EMERG "L2C: Cache Parity Error, addr[16:26] = 0x%08x\n",
+		       addr);
+	}
+	if (sr & L2C_SR_TPE) {
+		/* Read tag trapped address */
+		u32 addr = l2c_diag(0x82000000) >> 16;
+		printk(KERN_EMERG "L2C: Tag Parity Error, addr[16:26] = 0x%08x\n",
+		       addr);
+	}
+
+	/* Clear parity errors */
+	if (sr & (L2C_SR_CPE | L2C_SR_TPE)){
+		mtdcr(dcrbase + DCRN_L2C0_ADDR, 0);
+		mtdcr(dcrbase + DCRN_L2C0_CMD, L2C_CMD_CCP | L2C_CMD_CTE);
+	} else {
+		printk(KERN_EMERG "L2C: LRU error\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int __init ppc4xx_l2c_probe(void)
+{
+	struct device_node *np = NULL;
+	u32 r;
+	unsigned long flags;
+	int irq;
+	const u32 *dcrreg;
+	u32 dcrbase_isram;
+	int len;
+
+	np = of_find_compatible_node(np, NULL, "ibm,l2-cache");
+	if (!np)
+		return 0;
+
+	/* Map DCRs */
+	dcrreg = of_get_property(np, "dcr-reg", &len);
+	if (!dcrreg || (len != 4*sizeof(u32))) {
+		printk(KERN_ERR "%s: Can't get DCR register base !",
+		       np->full_name);
+		return -ENODEV;
+	}
+	dcrbase_isram = dcrreg[0];
+	dcrbase = dcrreg[2];
+
+	/* Get and map irq number from device tree */
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq == NO_IRQ) {
+		printk(KERN_ERR "irq_of_parse_and_map failed\n");
+		return -ENODEV;
+	}
+
+	/* Install error handler */
+	if (request_irq(irq, l2c_error_handler, IRQF_DISABLED, "L2C", 0) < 0) {
+		printk(KERN_ERR "Cannot install L2C error handler"
+		       ", cache is not enabled\n");
+		return -ENODEV;
+	}
+
+	local_irq_save(flags);
+	asm volatile ("sync" ::: "memory");
+
+	/* Disable SRAM */
+	mtdcr(dcrbase_isram + DCRN_SRAM0_DPC,
+	      mfdcr(dcrbase_isram + DCRN_SRAM0_DPC) & ~SRAM_DPC_ENABLE);
+	mtdcr(dcrbase_isram + DCRN_SRAM0_SB0CR,
+	      mfdcr(dcrbase_isram + DCRN_SRAM0_SB0CR) & ~SRAM_SBCR_BU_MASK);
+	mtdcr(dcrbase_isram + DCRN_SRAM0_SB1CR,
+	      mfdcr(dcrbase_isram + DCRN_SRAM0_SB1CR) & ~SRAM_SBCR_BU_MASK);
+	mtdcr(dcrbase_isram + DCRN_SRAM0_SB2CR,
+	      mfdcr(dcrbase_isram + DCRN_SRAM0_SB2CR) & ~SRAM_SBCR_BU_MASK);
+	mtdcr(dcrbase_isram + DCRN_SRAM0_SB3CR,
+	      mfdcr(dcrbase_isram + DCRN_SRAM0_SB3CR) & ~SRAM_SBCR_BU_MASK);
+
+	/* Enable L2_MODE without ICU/DCU */
+	r = mfdcr(dcrbase + DCRN_L2C0_CFG) &
+		~(L2C_CFG_ICU | L2C_CFG_DCU | L2C_CFG_SS_MASK);
+	r |= L2C_CFG_L2M | L2C_CFG_SS_256;
+	mtdcr(dcrbase + DCRN_L2C0_CFG, r);
+
+	mtdcr(dcrbase + DCRN_L2C0_ADDR, 0);
+
+	/* Hardware Clear Command */
+	mtdcr(dcrbase + DCRN_L2C0_CMD, L2C_CMD_HCC);
+	while (!(mfdcr(dcrbase + DCRN_L2C0_SR) & L2C_SR_CC))
+		;
+
+	/* Clear Cache Parity and Tag Errors */
+	mtdcr(dcrbase + DCRN_L2C0_CMD, L2C_CMD_CCP | L2C_CMD_CTE);
+
+	/* Enable 64G snoop region starting at 0 */
+	r = mfdcr(dcrbase + DCRN_L2C0_SNP0) &
+		~(L2C_SNP_BA_MASK | L2C_SNP_SSR_MASK);
+	r |= L2C_SNP_SSR_32G | L2C_SNP_ESR;
+	mtdcr(dcrbase + DCRN_L2C0_SNP0, r);
+
+	r = mfdcr(dcrbase + DCRN_L2C0_SNP1) &
+		~(L2C_SNP_BA_MASK | L2C_SNP_SSR_MASK);
+	r |= 0x80000000 | L2C_SNP_SSR_32G | L2C_SNP_ESR;
+	mtdcr(dcrbase + DCRN_L2C0_SNP1, r);
+
+	asm volatile ("sync" ::: "memory");
+
+	/* Enable ICU/DCU ports */
+	r = mfdcr(dcrbase + DCRN_L2C0_CFG);
+	r &= ~(L2C_CFG_DCW_MASK | L2C_CFG_PMUX_MASK | L2C_CFG_PMIM
+	       | L2C_CFG_TPEI | L2C_CFG_CPEI | L2C_CFG_NAM | L2C_CFG_NBRM);
+	r |= L2C_CFG_ICU | L2C_CFG_DCU | L2C_CFG_TPC | L2C_CFG_CPC | L2C_CFG_FRAN
+		| L2C_CFG_CPIM | L2C_CFG_TPIM | L2C_CFG_LIM | L2C_CFG_SMCM;
+
+	/* Check for 460EX/GT special handling */
+	if (of_device_is_compatible(np, "ibm,l2-cache-460ex"))
+		r |= L2C_CFG_RDBW;
+
+	mtdcr(dcrbase + DCRN_L2C0_CFG, r);
+
+	asm volatile ("sync; isync" ::: "memory");
+	local_irq_restore(flags);
+
+	printk(KERN_INFO "256k L2-cache enabled\n");
+
+	return 0;
+}
+arch_initcall(ppc4xx_l2c_probe);
diff --git a/include/asm-powerpc/dcr-regs.h b/include/asm-powerpc/dcr-regs.h
index 9f1fb98..29b0ece 100644
--- a/include/asm-powerpc/dcr-regs.h
+++ b/include/asm-powerpc/dcr-regs.h
@@ -68,4 +68,82 @@
 #define SDR0_UART3		0x0123
 #define SDR0_CUST0		0x4000
 
+/*
+ * All those DCR register addresses are offsets from the base address
+ * for the SRAM0 controller (e.g. 0x20 on 440GX). The base address is
+ * excluded here and configured in the device tree.
+ */
+#define DCRN_SRAM0_SB0CR	0x00
+#define DCRN_SRAM0_SB1CR	0x01
+#define DCRN_SRAM0_SB2CR	0x02
+#define DCRN_SRAM0_SB3CR	0x03
+#define  SRAM_SBCR_BU_MASK	0x00000180
+#define  SRAM_SBCR_BS_64KB	0x00000800
+#define  SRAM_SBCR_BU_RO	0x00000080
+#define  SRAM_SBCR_BU_RW	0x00000180
+#define DCRN_SRAM0_BEAR		0x04
+#define DCRN_SRAM0_BESR0	0x05
+#define DCRN_SRAM0_BESR1	0x06
+#define DCRN_SRAM0_PMEG		0x07
+#define DCRN_SRAM0_CID		0x08
+#define DCRN_SRAM0_REVID	0x09
+#define DCRN_SRAM0_DPC		0x0a
+#define  SRAM_DPC_ENABLE	0x80000000
+
+/*
+ * All those DCR register addresses are offsets from the base address
+ * for the SRAM0 controller (e.g. 0x30 on 440GX). The base address is
+ * excluded here and configured in the device tree.
+ */
+#define DCRN_L2C0_CFG		0x00
+#define  L2C_CFG_L2M		0x80000000
+#define  L2C_CFG_ICU		0x40000000
+#define  L2C_CFG_DCU		0x20000000
+#define  L2C_CFG_DCW_MASK	0x1e000000
+#define  L2C_CFG_TPC		0x01000000
+#define  L2C_CFG_CPC		0x00800000
+#define  L2C_CFG_FRAN		0x00200000
+#define  L2C_CFG_SS_MASK	0x00180000
+#define  L2C_CFG_SS_256		0x00000000
+#define  L2C_CFG_CPIM		0x00040000
+#define  L2C_CFG_TPIM		0x00020000
+#define  L2C_CFG_LIM		0x00010000
+#define  L2C_CFG_PMUX_MASK	0x00007000
+#define  L2C_CFG_PMUX_SNP	0x00000000
+#define  L2C_CFG_PMUX_IF	0x00001000
+#define  L2C_CFG_PMUX_DF	0x00002000
+#define  L2C_CFG_PMUX_DS	0x00003000
+#define  L2C_CFG_PMIM		0x00000800
+#define  L2C_CFG_TPEI		0x00000400
+#define  L2C_CFG_CPEI		0x00000200
+#define  L2C_CFG_NAM		0x00000100
+#define  L2C_CFG_SMCM		0x00000080
+#define  L2C_CFG_NBRM		0x00000040
+#define  L2C_CFG_RDBW		0x00000008	/* only 460EX/GT */
+#define DCRN_L2C0_CMD		0x01
+#define  L2C_CMD_CLR		0x80000000
+#define  L2C_CMD_DIAG		0x40000000
+#define  L2C_CMD_INV		0x20000000
+#define  L2C_CMD_CCP		0x10000000
+#define  L2C_CMD_CTE		0x08000000
+#define  L2C_CMD_STRC		0x04000000
+#define  L2C_CMD_STPC		0x02000000
+#define  L2C_CMD_RPMC		0x01000000
+#define  L2C_CMD_HCC		0x00800000
+#define DCRN_L2C0_ADDR		0x02
+#define DCRN_L2C0_DATA		0x03
+#define DCRN_L2C0_SR		0x04
+#define  L2C_SR_CC		0x80000000
+#define  L2C_SR_CPE		0x40000000
+#define  L2C_SR_TPE		0x20000000
+#define  L2C_SR_LRU		0x10000000
+#define  L2C_SR_PCS		0x08000000
+#define DCRN_L2C0_REVID		0x05
+#define DCRN_L2C0_SNP0		0x06
+#define DCRN_L2C0_SNP1		0x07
+#define  L2C_SNP_BA_MASK	0xffff0000
+#define  L2C_SNP_SSR_MASK	0x0000f000
+#define  L2C_SNP_SSR_32G	0x0000f000
+#define  L2C_SNP_ESR		0x00000800
+
 #endif /* __DCR_REGS_H__ */
-- 
1.5.4.4
