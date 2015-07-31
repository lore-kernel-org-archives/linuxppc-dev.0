Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0112.outbound.protection.outlook.com [207.46.100.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BD751A1CF2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 23:08:31 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <Jason.Jin@freescale.com>
Subject: [PATCH 4/4] powerpc: pm: support deep sleep feature on T104x
Date: Fri, 31 Jul 2015 20:53:06 +0800
Message-ID: <1438347186-8462-4-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
References: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T104x has deep sleep feature, which can switch off most parts of
the SoC when it is in deep sleep mode. This way, it becomes more
energy-efficient.

The DDR controller will also be powered off in deep sleep. Therefore,
the last stage (the latter part of fsl_dp_enter_low) will run without DDR
access. This piece of code and related TLBs are prefetched in advance.

Due to the different initialization code between 32-bit and 64-bit, they
have separate resume entry and precedure.

The feature supports 32-bit and 64-bit kernel mode.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/powerpc/include/asm/fsl_pm.h             |  14 +
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |  10 +
 arch/powerpc/kernel/head_64.S                 |   2 +-
 arch/powerpc/platforms/85xx/Makefile          |   1 +
 arch/powerpc/platforms/85xx/deepsleep.c       | 322 +++++++++++++++
 arch/powerpc/platforms/85xx/qoriq_pm.c        |  81 +++-
 arch/powerpc/platforms/85xx/t104x_deepsleep.S | 570 ++++++++++++++++++++++++++
 7 files changed, 997 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
 create mode 100644 arch/powerpc/platforms/85xx/t104x_deepsleep.S

diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm/fsl_pm.h
index 4b09f09..b44f484 100644
--- a/arch/powerpc/include/asm/fsl_pm.h
+++ b/arch/powerpc/include/asm/fsl_pm.h
@@ -12,6 +12,7 @@
 #define __PPC_FSL_PM_H
 #ifdef __KERNEL__
 
+#ifndef __ASSEMBLY__
 #define E500_PM_PH10	1
 #define E500_PM_PH15	2
 #define E500_PM_PH20	3
@@ -44,5 +45,18 @@ struct fsl_pm_ops {
 };
 
 extern const struct fsl_pm_ops *qoriq_pm_ops;
+
+extern int fsl_dp_iomap(void);
+extern void fsl_dp_iounmap(void);
+
+extern int fsl_enter_epu_deepsleep(void);
+extern void fsl_dp_enter_low(void __iomem *ccsr_base, void __iomem *dcsr_base,
+			     void __iomem *pld_base, int pld_flag);
+extern void fsl_booke_deep_sleep_resume(void);
+#endif	/* __ASSEMBLY__ */
+
+#define T1040QDS_TETRA_FLAG	1
+#define T104xRDB_CPLD_FLAG	2
+
 #endif /* __KERNEL__ */
 #endif /* __PPC_FSL_PM_H */
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index f22e7e4..32ec426f 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -170,6 +170,10 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@h
 	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@l
 	mtspr	SPRN_MAS2,r6
+#ifdef ENTRY_DEEPSLEEP_SETUP
+	LOAD_REG_IMMEDIATE(r8, MEMORY_START)
+	ori	r8,r8,(MAS3_SX|MAS3_SW|MAS3_SR)
+#endif
 	mtspr	SPRN_MAS3,r8
 	tlbwe
 
@@ -212,12 +216,18 @@ next_tlb_setup:
 	#error You need to specify the mapping or not use this at all.
 #endif
 
+#ifdef ENTRY_DEEPSLEEP_SETUP
+	LOAD_REG_ADDR(r6, 2f)
+	mfmsr	r7
+	rlwinm	r7,r7,0,~(MSR_IS|MSR_DS)
+#else
 	lis	r7,MSR_KERNEL@h
 	ori	r7,r7,MSR_KERNEL@l
 	bl	1f			/* Find our address */
 1:	mflr	r9
 	rlwimi	r6,r9,0,20,31
 	addi	r6,r6,(2f - 1b)
+#endif
 	mtspr	SPRN_SRR0,r6
 	mtspr	SPRN_SRR1,r7
 	rfi				/* start execution out of TLB1[0] entry */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index d48125d..b9eb02a 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -696,7 +696,7 @@ _GLOBAL(start_secondary_resume)
 /*
  * This subroutine clobbers r11 and r12
  */
-enable_64b_mode:
+_GLOBAL(enable_64b_mode)
 	mfmsr	r11			/* grab the current MSR */
 #ifdef CONFIG_PPC_BOOK3E
 	oris	r11,r11,0x8000		/* CM bit set, we'll set ICM later */
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 87fb847..a73d563 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_FSL_PMC)		  += mpc85xx_pm_ops.o
 obj-$(CONFIG_FSL_QORIQ_PM)	  += qoriq_pm.o sleep_fsm.o
+obj-$(CONFIG_FSL_QORIQ_PM)	  += deepsleep.o t104x_deepsleep.o
 
 obj-y += common.o
 
diff --git a/arch/powerpc/platforms/85xx/deepsleep.c b/arch/powerpc/platforms/85xx/deepsleep.c
new file mode 100644
index 0000000..5de904d
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/deepsleep.c
@@ -0,0 +1,322 @@
+/*
+ * Support deep sleep feature for T104x
+ *
+ * Copyright 2015 Freescale Semiconductor Inc.
+ *
+ * Author: Chenhui Zhao <chenhui.zhao@freescale.com>
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <sysdev/fsl_soc.h>
+#include <asm/machdep.h>
+#include <asm/fsl_pm.h>
+
+#include "sleep_fsm.h"
+
+#define SIZE_1MB	0x100000
+#define SIZE_2MB	0x200000
+
+#define CPC_CPCHDBCR0		0x10f00
+#define CPC_CPCHDBCR0_SPEC_DIS	0x08000000
+
+#define CCSR_SCFG_DPSLPCR	0xfc000
+#define CCSR_SCFG_DPSLPCR_WDRR_EN	0x1
+#define CCSR_SCFG_SPARECR2	0xfc504
+#define CCSR_SCFG_SPARECR3	0xfc508
+
+#define CCSR_GPIO1_GPDIR	0x130000
+#define CCSR_GPIO1_GPODR	0x130004
+#define CCSR_GPIO1_GPDAT	0x130008
+#define CCSR_GPIO1_GPDIR_29	0x4
+
+#define CCSR_LAW_BASE		0xC00
+#define DCFG_BRR	0xE4	/* boot release register */
+#define LCC_BSTRH	0x20	/* Boot space translation register high */
+#define LCC_BSTRL	0x24	/* Boot space translation register low */
+#define LCC_BSTAR	0x28	/* Boot space translation attribute register */
+#define RCPM_PCTBENR	0x1A0	/* Physical Core Timebase Enable Register */
+#define RCPM_BASE	0xE2000
+#define DCFG_BASE	0xE0000
+
+/* 128 bytes buffer for restoring data broke by DDR training initialization */
+#define DDR_BUF_SIZE	128
+static u8 ddr_buff[DDR_BUF_SIZE] __aligned(64);
+
+static void *dcsr_base, *ccsr_base, *pld_base;
+static int pld_flag;
+
+/* save LAW registers */
+struct fsl_law {
+	u32	lawbarh;	/* LAWn base address high */
+	u32	lawbarl;	/* LAWn base address low */
+	u32	lawar;		/* LAWn attributes */
+	u32	reserved;
+};
+
+struct fsl_law *saved_law;
+static u32 num_laws;
+
+/* for nonboot cpu */
+struct fsl_bstr {
+	u32	bstrh;
+	u32	bstrl;
+	u32	bstar;
+	u32 cpu_mask;
+};
+static struct fsl_bstr saved_bstr;
+
+int fsl_dp_iomap(void)
+{
+	struct device_node *np;
+	int ret = 0;
+	phys_addr_t ccsr_phy_addr, dcsr_phy_addr;
+
+	saved_law = NULL;
+	ccsr_base = NULL;
+	dcsr_base = NULL;
+	pld_base = NULL;
+
+	ccsr_phy_addr = get_immrbase();
+	if (ccsr_phy_addr == -1) {
+		pr_err("%s: Can't get the address of CCSR\n", __func__);
+		ret = -EINVAL;
+		goto ccsr_err;
+	}
+	ccsr_base = ioremap(ccsr_phy_addr, SIZE_2MB);
+	if (!ccsr_base) {
+		ret = -ENOMEM;
+		goto ccsr_err;
+	}
+
+	dcsr_phy_addr = get_dcsrbase();
+	if (dcsr_phy_addr == -1) {
+		pr_err("%s: Can't get the address of DCSR\n", __func__);
+		ret = -EINVAL;
+		goto dcsr_err;
+	}
+	dcsr_base = ioremap(dcsr_phy_addr, SIZE_1MB);
+	if (!dcsr_base) {
+		ret = -ENOMEM;
+		goto dcsr_err;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,tetra-fpga");
+	if (np) {
+		pld_flag = T1040QDS_TETRA_FLAG;
+	} else {
+		np = of_find_compatible_node(NULL, NULL, "fsl,deepsleep-cpld");
+		if (np) {
+			pld_flag = T104xRDB_CPLD_FLAG;
+		} else {
+			pr_err("%s: Can't find the FPGA/CPLD node\n",
+					__func__);
+			ret = -EINVAL;
+			goto pld_err;
+		}
+	}
+	pld_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,corenet-law");
+	if (!np) {
+		pr_err("%s: Can't find the node of \"law\"\n", __func__);
+		ret = -EINVAL;
+		goto alloc_err;
+	}
+	ret = of_property_read_u32(np, "fsl,num-laws", &num_laws);
+	if (ret) {
+		ret = -EINVAL;
+		goto alloc_err;
+	}
+
+	saved_law = kcalloc(num_laws, sizeof(struct fsl_law), GFP_KERNEL);
+	if (!saved_law) {
+		ret = -ENOMEM;
+		goto alloc_err;
+	}
+	of_node_put(np);
+
+	return 0;
+
+alloc_err:
+	iounmap(pld_base);
+	pld_base = NULL;
+pld_err:
+	iounmap(dcsr_base);
+	dcsr_base = NULL;
+dcsr_err:
+	iounmap(ccsr_base);
+	ccsr_base = NULL;
+ccsr_err:
+	return ret;
+}
+
+void fsl_dp_iounmap(void)
+{
+	if (dcsr_base) {
+		iounmap(dcsr_base);
+		dcsr_base = NULL;
+	}
+
+	if (ccsr_base) {
+		iounmap(ccsr_base);
+		ccsr_base = NULL;
+	}
+
+	if (pld_base) {
+		iounmap(pld_base);
+		pld_base = NULL;
+	}
+
+	kfree(saved_law);
+	saved_law = NULL;
+}
+
+static void fsl_dp_ddr_save(void *ccsr_base)
+{
+	u32 ddr_buff_addr;
+
+	/*
+	 * DDR training initialization will break 128 bytes at the beginning
+	 * of DDR, therefore, save them so that the bootloader will restore
+	 * them. Assume that DDR is mapped to the address space started with
+	 * CONFIG_PAGE_OFFSET.
+	 */
+	memcpy(ddr_buff, (void *)CONFIG_PAGE_OFFSET, DDR_BUF_SIZE);
+
+	/* assume ddr_buff is in the physical address space of 4GB */
+	ddr_buff_addr = (u32)(__pa(ddr_buff) & 0xffffffff);
+
+	/*
+	 * the bootloader will restore the first 128 bytes of DDR from
+	 * the location indicated by the register SPARECR3
+	 */
+	out_be32(ccsr_base + CCSR_SCFG_SPARECR3, ddr_buff_addr);
+}
+
+static void fsl_dp_mp_save(void *ccsr)
+{
+	 struct fsl_bstr *dst = &saved_bstr;
+
+	 dst->bstrh = in_be32(ccsr + LCC_BSTRH);
+	 dst->bstrl = in_be32(ccsr + LCC_BSTRL);
+	 dst->bstar = in_be32(ccsr + LCC_BSTAR);
+	 dst->cpu_mask = in_be32(ccsr + DCFG_BASE + DCFG_BRR);
+}
+
+static void fsl_dp_mp_restore(void *ccsr)
+{
+	 struct fsl_bstr *src = &saved_bstr;
+
+	 out_be32(ccsr + LCC_BSTRH, src->bstrh);
+	 out_be32(ccsr + LCC_BSTRL, src->bstrl);
+	 out_be32(ccsr + LCC_BSTAR, src->bstar);
+
+	 /* release the nonboot cpus */
+	 out_be32(ccsr + DCFG_BASE + DCFG_BRR, src->cpu_mask);
+
+	 /* enable the time base */
+	 out_be32(ccsr + RCPM_BASE + RCPM_PCTBENR, src->cpu_mask);
+	 /* read back to sync write */
+	 in_be32(ccsr + RCPM_BASE + RCPM_PCTBENR);
+}
+
+static void fsl_dp_law_save(void *ccsr)
+{
+	int i;
+	struct fsl_law *dst = saved_law;
+	struct fsl_law *src = (void *)(ccsr + CCSR_LAW_BASE);
+
+	for (i = 0; i < num_laws; i++) {
+		dst->lawbarh = in_be32(&src->lawbarh);
+		dst->lawbarl = in_be32(&src->lawbarl);
+		dst->lawar = in_be32(&src->lawar);
+		dst++;
+		src++;
+	}
+}
+
+static void fsl_dp_law_restore(void *ccsr)
+{
+	int i;
+	struct fsl_law *src = saved_law;
+	struct fsl_law *dst = (void *)(ccsr + CCSR_LAW_BASE);
+
+	for (i = 0; i < num_laws - 1; i++) {
+		out_be32(&dst->lawar, 0);
+		out_be32(&dst->lawbarl, src->lawbarl);
+		out_be32(&dst->lawbarh, src->lawbarh);
+		out_be32(&dst->lawar, src->lawar);
+
+		 /* Read back so that we sync the writes */
+		in_be32(&dst->lawar);
+		src++;
+		dst++;
+	}
+}
+
+static void fsl_dp_set_resume_pointer(void *ccsr_base)
+{
+	u32 resume_addr;
+
+	/* the bootloader will finally jump to this address to return kernel */
+#ifdef CONFIG_PPC32
+	resume_addr = (u32)(__pa(fsl_booke_deep_sleep_resume));
+#else
+	resume_addr = (u32)(__pa(*(u64 *)fsl_booke_deep_sleep_resume)
+			    & 0xffffffff);
+#endif
+
+	/* use the register SPARECR2 to save the resume address */
+	out_be32(ccsr_base + CCSR_SCFG_SPARECR2, resume_addr);
+}
+
+int fsl_enter_epu_deepsleep(void)
+{
+	fsl_dp_ddr_save(ccsr_base);
+
+	fsl_dp_set_resume_pointer(ccsr_base);
+
+	fsl_dp_mp_save(ccsr_base);
+	fsl_dp_law_save(ccsr_base);
+	/*  enable Warm Device Reset request. */
+	setbits32(ccsr_base + CCSR_SCFG_DPSLPCR, CCSR_SCFG_DPSLPCR_WDRR_EN);
+
+	/* set GPIO1_29 as an output pin (not open-drain), and output 0 */
+	clrbits32(ccsr_base + CCSR_GPIO1_GPDAT, CCSR_GPIO1_GPDIR_29);
+	clrbits32(ccsr_base + CCSR_GPIO1_GPODR, CCSR_GPIO1_GPDIR_29);
+	setbits32(ccsr_base + CCSR_GPIO1_GPDIR, CCSR_GPIO1_GPDIR_29);
+
+	/*
+	 * Disable CPC speculation to avoid deep sleep hang, especially
+	 * in secure boot mode. This bit will be cleared automatically
+	 * when resuming from deep sleep.
+	 */
+	setbits32(ccsr_base + CPC_CPCHDBCR0, CPC_CPCHDBCR0_SPEC_DIS);
+
+	fsl_epu_setup_default(dcsr_base + EPU_BLOCK_OFFSET);
+	fsl_npc_setup_default(dcsr_base + NPC_BLOCK_OFFSET);
+
+	out_be32(dcsr_base + RCPM_BLOCK_OFFSET + CSTTACR0, 0x00001001);
+	out_be32(dcsr_base + RCPM_BLOCK_OFFSET + CG1CR0, 0x00000001);
+
+	fsl_dp_enter_low(ccsr_base, dcsr_base, pld_base, pld_flag);
+
+	fsl_dp_law_restore(ccsr_base);
+	fsl_dp_mp_restore(ccsr_base);
+
+	/* disable Warm Device Reset request */
+	clrbits32(ccsr_base + CCSR_SCFG_DPSLPCR, CCSR_SCFG_DPSLPCR_WDRR_EN);
+
+	fsl_epu_clean_default(dcsr_base + EPU_BLOCK_OFFSET);
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/85xx/qoriq_pm.c b/arch/powerpc/platforms/85xx/qoriq_pm.c
index 27ec337..f65f6cf 100644
--- a/arch/powerpc/platforms/85xx/qoriq_pm.c
+++ b/arch/powerpc/platforms/85xx/qoriq_pm.c
@@ -17,17 +17,68 @@
 
 #include <asm/fsl_pm.h>
 
+static suspend_state_t cur_pm_state;
+
+/**
+ * fsl_set_power_except - set which IP block is not powerdown when sleep or
+ * deep sleep, such as MAC, USB, etc.
+ *
+ * @dev: a pointer to the struct device of the device with wakeup capability
+ * @on: if 1, do not power down; if 0, power down.
+ */
+static void fsl_set_power_except(struct device *dev, int on)
+{
+	u32 value[2];
+	int ret;
+
+	ret = of_property_read_u32_array(dev->of_node, "sleep", value, 2);
+	if (ret)
+		goto out;
+
+	/* get value[1], it is a bit mask */
+	qoriq_pm_ops->set_ip_power(on, &value[1]);
+
+	return;
+out:
+	dev_dbg(dev, "Can not set as wakeup sources\n");
+}
+
+static void qoriq_set_wakeup_source(struct device *dev, void *enable)
+{
+	if (!device_may_wakeup(dev))
+		return;
+
+	fsl_set_power_except(dev, *((int *)enable));
+}
+
 static int qoriq_suspend_enter(suspend_state_t state)
 {
 	int ret = 0;
+	int cpu;
 
 	switch (state) {
 	case PM_SUSPEND_STANDBY:
+
 		cur_cpu_spec->cpu_down_flush();
+
 		ret = qoriq_pm_ops->plat_enter_sleep();
+
+		break;
+
+	case PM_SUSPEND_MEM:
+
+		cpu = smp_processor_id();
+		qoriq_pm_ops->irq_mask(cpu);
+
+		ret = fsl_enter_epu_deepsleep();
+
+		qoriq_pm_ops->irq_unmask(cpu);
+
 		break;
+
 	default:
 		ret = -EINVAL;
+
 	}
 
 	return ret;
@@ -38,22 +89,48 @@ static int qoriq_suspend_valid(suspend_state_t state)
 	unsigned int pm_modes;
 
 	pm_modes = qoriq_pm_ops->get_pm_modes();
+	if (state == PM_SUSPEND_STANDBY && (pm_modes & FSL_PM_SLEEP))
+		return 1;
 
-	if ((state == PM_SUSPEND_STANDBY) && (pm_modes & FSL_PM_SLEEP))
+	if (state == PM_SUSPEND_MEM && (pm_modes & FSL_PM_DEEP_SLEEP))
 		return 1;
 
 	return 0;
 }
 
+static int qoriq_suspend_begin(suspend_state_t state)
+{
+	const int enable = 1;
+
+	cur_pm_state = state;
+	dpm_for_each_dev((void *)&enable, qoriq_set_wakeup_source);
+
+	if (cur_pm_state == PM_SUSPEND_MEM)
+		return fsl_dp_iomap();
+
+	return 0;
+}
+
+static void qoriq_suspend_end(void)
+{
+	const int enable = 0;
+
+	dpm_for_each_dev((void *)&enable, qoriq_set_wakeup_source);
+
+	if (cur_pm_state == PM_SUSPEND_MEM)
+		fsl_dp_iounmap();
+}
+
 static const struct platform_suspend_ops qoriq_suspend_ops = {
 	.valid = qoriq_suspend_valid,
 	.enter = qoriq_suspend_enter,
+	.begin = qoriq_suspend_begin,
+	.end = qoriq_suspend_end,
 };
 
 static int __init qoriq_suspend_init(void)
 {
 	suspend_set_ops(&qoriq_suspend_ops);
-
 	return 0;
 }
 arch_initcall(qoriq_suspend_init);
diff --git a/arch/powerpc/platforms/85xx/t104x_deepsleep.S b/arch/powerpc/platforms/85xx/t104x_deepsleep.S
new file mode 100644
index 0000000..773a9e4
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/t104x_deepsleep.S
@@ -0,0 +1,570 @@
+/*
+ * Enter and resume from deep sleep state
+ *
+ * Copyright 2015 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/reg.h>
+#include <asm/asm-offsets.h>
+#include <asm/fsl_pm.h>
+#include <asm/mmu.h>
+
+/*
+ * the number of bytes occupied by one register
+ * the value of 8 is compatible with both 32-bit and 64-bit registers
+ */
+#define STRIDE_SIZE		8
+
+/* GPR0 - GPR31 */
+#define BOOKE_GPR0_OFF		0x0000
+#define BOOKE_GPR_COUNT		32
+/* IVOR0 - IVOR42 */
+#define BOOKE_IVOR0_OFF	   (BOOKE_GPR0_OFF + BOOKE_GPR_COUNT * STRIDE_SIZE)
+#define BOOKE_IVOR_COUNT	43
+/* SPRG0 - SPRG9 */
+#define BOOKE_SPRG0_OFF	   (BOOKE_IVOR0_OFF + BOOKE_IVOR_COUNT * STRIDE_SIZE)
+#define BOOKE_SPRG_COUNT	10
+/* IVPR */
+#define BOOKE_IVPR_OFF	   (BOOKE_SPRG0_OFF + BOOKE_SPRG_COUNT * STRIDE_SIZE)
+
+#define BOOKE_LR_OFF		(BOOKE_IVPR_OFF + STRIDE_SIZE)
+#define BOOKE_MSR_OFF		(BOOKE_LR_OFF + STRIDE_SIZE)
+#define BOOKE_TBU_OFF		(BOOKE_MSR_OFF + STRIDE_SIZE)
+#define BOOKE_TBL_OFF		(BOOKE_TBU_OFF + STRIDE_SIZE)
+#define BOOKE_EPCR_OFF		(BOOKE_TBL_OFF + STRIDE_SIZE)
+#define BOOKE_HID0_OFF		(BOOKE_EPCR_OFF + STRIDE_SIZE)
+#define BOOKE_PIR_OFF		(BOOKE_HID0_OFF + STRIDE_SIZE)
+#define BOOKE_PID0_OFF		(BOOKE_PIR_OFF + STRIDE_SIZE)
+#define BOOKE_BUCSR_OFF		(BOOKE_PID0_OFF + STRIDE_SIZE)
+
+#define BUFFER_SIZE		(BOOKE_BUCSR_OFF + STRIDE_SIZE)
+
+#undef SAVE_GPR
+#define SAVE_GPR(gpr, offset) \
+	PPC_STL gpr, offset(r10)
+
+#define RESTORE_GPR(gpr, offset) \
+	PPC_LL gpr, offset(r10)
+
+#define SAVE_SPR(spr, offset) \
+	mfspr	r0, spr ;\
+	PPC_STL	r0, offset(r10)
+
+#define RESTORE_SPR(spr, offset) \
+	PPC_LL	r0, offset(r10) ;\
+	mtspr	spr, r0
+
+#define SAVE_ALL_GPR \
+	SAVE_GPR(r1, BOOKE_GPR0_OFF + STRIDE_SIZE * 1) ;\
+	SAVE_GPR(r2, BOOKE_GPR0_OFF + STRIDE_SIZE * 2) ;\
+	SAVE_GPR(r13, BOOKE_GPR0_OFF + STRIDE_SIZE * 13) ;\
+	SAVE_GPR(r14, BOOKE_GPR0_OFF + STRIDE_SIZE * 14) ;\
+	SAVE_GPR(r15, BOOKE_GPR0_OFF + STRIDE_SIZE * 15) ;\
+	SAVE_GPR(r16, BOOKE_GPR0_OFF + STRIDE_SIZE * 16) ;\
+	SAVE_GPR(r17, BOOKE_GPR0_OFF + STRIDE_SIZE * 17) ;\
+	SAVE_GPR(r18, BOOKE_GPR0_OFF + STRIDE_SIZE * 18) ;\
+	SAVE_GPR(r19, BOOKE_GPR0_OFF + STRIDE_SIZE * 19) ;\
+	SAVE_GPR(r20, BOOKE_GPR0_OFF + STRIDE_SIZE * 20) ;\
+	SAVE_GPR(r21, BOOKE_GPR0_OFF + STRIDE_SIZE * 21) ;\
+	SAVE_GPR(r22, BOOKE_GPR0_OFF + STRIDE_SIZE * 22) ;\
+	SAVE_GPR(r23, BOOKE_GPR0_OFF + STRIDE_SIZE * 23) ;\
+	SAVE_GPR(r24, BOOKE_GPR0_OFF + STRIDE_SIZE * 24) ;\
+	SAVE_GPR(r25, BOOKE_GPR0_OFF + STRIDE_SIZE * 25) ;\
+	SAVE_GPR(r26, BOOKE_GPR0_OFF + STRIDE_SIZE * 26) ;\
+	SAVE_GPR(r27, BOOKE_GPR0_OFF + STRIDE_SIZE * 27) ;\
+	SAVE_GPR(r28, BOOKE_GPR0_OFF + STRIDE_SIZE * 28) ;\
+	SAVE_GPR(r29, BOOKE_GPR0_OFF + STRIDE_SIZE * 29) ;\
+	SAVE_GPR(r30, BOOKE_GPR0_OFF + STRIDE_SIZE * 30) ;\
+	SAVE_GPR(r31, BOOKE_GPR0_OFF + STRIDE_SIZE * 31)
+
+#define RESTORE_ALL_GPR \
+	RESTORE_GPR(r1, BOOKE_GPR0_OFF + STRIDE_SIZE * 1) ;\
+	RESTORE_GPR(r2, BOOKE_GPR0_OFF + STRIDE_SIZE * 2) ;\
+	RESTORE_GPR(r13, BOOKE_GPR0_OFF + STRIDE_SIZE * 13) ;\
+	RESTORE_GPR(r14, BOOKE_GPR0_OFF + STRIDE_SIZE * 14) ;\
+	RESTORE_GPR(r15, BOOKE_GPR0_OFF + STRIDE_SIZE * 15) ;\
+	RESTORE_GPR(r16, BOOKE_GPR0_OFF + STRIDE_SIZE * 16) ;\
+	RESTORE_GPR(r17, BOOKE_GPR0_OFF + STRIDE_SIZE * 17) ;\
+	RESTORE_GPR(r18, BOOKE_GPR0_OFF + STRIDE_SIZE * 18) ;\
+	RESTORE_GPR(r19, BOOKE_GPR0_OFF + STRIDE_SIZE * 19) ;\
+	RESTORE_GPR(r20, BOOKE_GPR0_OFF + STRIDE_SIZE * 20) ;\
+	RESTORE_GPR(r21, BOOKE_GPR0_OFF + STRIDE_SIZE * 21) ;\
+	RESTORE_GPR(r22, BOOKE_GPR0_OFF + STRIDE_SIZE * 22) ;\
+	RESTORE_GPR(r23, BOOKE_GPR0_OFF + STRIDE_SIZE * 23) ;\
+	RESTORE_GPR(r24, BOOKE_GPR0_OFF + STRIDE_SIZE * 24) ;\
+	RESTORE_GPR(r25, BOOKE_GPR0_OFF + STRIDE_SIZE * 25) ;\
+	RESTORE_GPR(r26, BOOKE_GPR0_OFF + STRIDE_SIZE * 26) ;\
+	RESTORE_GPR(r27, BOOKE_GPR0_OFF + STRIDE_SIZE * 27) ;\
+	RESTORE_GPR(r28, BOOKE_GPR0_OFF + STRIDE_SIZE * 28) ;\
+	RESTORE_GPR(r29, BOOKE_GPR0_OFF + STRIDE_SIZE * 29) ;\
+	RESTORE_GPR(r30, BOOKE_GPR0_OFF + STRIDE_SIZE * 30) ;\
+	RESTORE_GPR(r31, BOOKE_GPR0_OFF + STRIDE_SIZE * 31)
+
+#define SAVE_ALL_SPRG \
+	SAVE_SPR(SPRN_SPRG0, BOOKE_SPRG0_OFF + STRIDE_SIZE * 0) ;\
+	SAVE_SPR(SPRN_SPRG1, BOOKE_SPRG0_OFF + STRIDE_SIZE * 1) ;\
+	SAVE_SPR(SPRN_SPRG2, BOOKE_SPRG0_OFF + STRIDE_SIZE * 2) ;\
+	SAVE_SPR(SPRN_SPRG3, BOOKE_SPRG0_OFF + STRIDE_SIZE * 3) ;\
+	SAVE_SPR(SPRN_SPRG4, BOOKE_SPRG0_OFF + STRIDE_SIZE * 4) ;\
+	SAVE_SPR(SPRN_SPRG5, BOOKE_SPRG0_OFF + STRIDE_SIZE * 5) ;\
+	SAVE_SPR(SPRN_SPRG6, BOOKE_SPRG0_OFF + STRIDE_SIZE * 6) ;\
+	SAVE_SPR(SPRN_SPRG7, BOOKE_SPRG0_OFF + STRIDE_SIZE * 7) ;\
+	SAVE_SPR(SPRN_SPRG8, BOOKE_SPRG0_OFF + STRIDE_SIZE * 8) ;\
+	SAVE_SPR(SPRN_SPRG9, BOOKE_SPRG0_OFF + STRIDE_SIZE * 9)
+
+#define RESTORE_ALL_SPRG \
+	RESTORE_SPR(SPRN_SPRG0, BOOKE_SPRG0_OFF + STRIDE_SIZE * 0) ;\
+	RESTORE_SPR(SPRN_SPRG1, BOOKE_SPRG0_OFF + STRIDE_SIZE * 1) ;\
+	RESTORE_SPR(SPRN_SPRG2, BOOKE_SPRG0_OFF + STRIDE_SIZE * 2) ;\
+	RESTORE_SPR(SPRN_SPRG3, BOOKE_SPRG0_OFF + STRIDE_SIZE * 3) ;\
+	RESTORE_SPR(SPRN_SPRG4, BOOKE_SPRG0_OFF + STRIDE_SIZE * 4) ;\
+	RESTORE_SPR(SPRN_SPRG5, BOOKE_SPRG0_OFF + STRIDE_SIZE * 5) ;\
+	RESTORE_SPR(SPRN_SPRG6, BOOKE_SPRG0_OFF + STRIDE_SIZE * 6) ;\
+	RESTORE_SPR(SPRN_SPRG7, BOOKE_SPRG0_OFF + STRIDE_SIZE * 7) ;\
+	RESTORE_SPR(SPRN_SPRG8, BOOKE_SPRG0_OFF + STRIDE_SIZE * 8) ;\
+	RESTORE_SPR(SPRN_SPRG9, BOOKE_SPRG0_OFF + STRIDE_SIZE * 9)
+
+#define SAVE_ALL_IVOR \
+	SAVE_SPR(SPRN_IVOR0, BOOKE_IVOR0_OFF + STRIDE_SIZE * 0) ;\
+	SAVE_SPR(SPRN_IVOR1, BOOKE_IVOR0_OFF + STRIDE_SIZE * 1) ;\
+	SAVE_SPR(SPRN_IVOR2, BOOKE_IVOR0_OFF + STRIDE_SIZE * 2) ;\
+	SAVE_SPR(SPRN_IVOR3, BOOKE_IVOR0_OFF + STRIDE_SIZE * 3) ;\
+	SAVE_SPR(SPRN_IVOR4, BOOKE_IVOR0_OFF + STRIDE_SIZE * 4) ;\
+	SAVE_SPR(SPRN_IVOR5, BOOKE_IVOR0_OFF + STRIDE_SIZE * 5) ;\
+	SAVE_SPR(SPRN_IVOR6, BOOKE_IVOR0_OFF + STRIDE_SIZE * 6) ;\
+	SAVE_SPR(SPRN_IVOR7, BOOKE_IVOR0_OFF + STRIDE_SIZE * 7) ;\
+	SAVE_SPR(SPRN_IVOR8, BOOKE_IVOR0_OFF + STRIDE_SIZE * 8) ;\
+	SAVE_SPR(SPRN_IVOR9, BOOKE_IVOR0_OFF + STRIDE_SIZE * 9) ;\
+	SAVE_SPR(SPRN_IVOR10, BOOKE_IVOR0_OFF + STRIDE_SIZE * 10) ;\
+	SAVE_SPR(SPRN_IVOR11, BOOKE_IVOR0_OFF + STRIDE_SIZE * 11) ;\
+	SAVE_SPR(SPRN_IVOR12, BOOKE_IVOR0_OFF + STRIDE_SIZE * 12) ;\
+	SAVE_SPR(SPRN_IVOR13, BOOKE_IVOR0_OFF + STRIDE_SIZE * 13) ;\
+	SAVE_SPR(SPRN_IVOR14, BOOKE_IVOR0_OFF + STRIDE_SIZE * 14) ;\
+	SAVE_SPR(SPRN_IVOR15, BOOKE_IVOR0_OFF + STRIDE_SIZE * 15) ;\
+	SAVE_SPR(SPRN_IVOR35, BOOKE_IVOR0_OFF + STRIDE_SIZE * 35) ;\
+	SAVE_SPR(SPRN_IVOR36, BOOKE_IVOR0_OFF + STRIDE_SIZE * 36) ;\
+	SAVE_SPR(SPRN_IVOR37, BOOKE_IVOR0_OFF + STRIDE_SIZE * 37) ;\
+	SAVE_SPR(SPRN_IVOR38, BOOKE_IVOR0_OFF + STRIDE_SIZE * 38) ;\
+	SAVE_SPR(SPRN_IVOR39, BOOKE_IVOR0_OFF + STRIDE_SIZE * 39) ;\
+	SAVE_SPR(SPRN_IVOR40, BOOKE_IVOR0_OFF + STRIDE_SIZE * 40) ;\
+	SAVE_SPR(SPRN_IVOR41, BOOKE_IVOR0_OFF + STRIDE_SIZE * 41)
+
+#define RESTORE_ALL_IVOR \
+	RESTORE_SPR(SPRN_IVOR0, BOOKE_IVOR0_OFF + STRIDE_SIZE * 0) ;\
+	RESTORE_SPR(SPRN_IVOR1, BOOKE_IVOR0_OFF + STRIDE_SIZE * 1) ;\
+	RESTORE_SPR(SPRN_IVOR2, BOOKE_IVOR0_OFF + STRIDE_SIZE * 2) ;\
+	RESTORE_SPR(SPRN_IVOR3, BOOKE_IVOR0_OFF + STRIDE_SIZE * 3) ;\
+	RESTORE_SPR(SPRN_IVOR4, BOOKE_IVOR0_OFF + STRIDE_SIZE * 4) ;\
+	RESTORE_SPR(SPRN_IVOR5, BOOKE_IVOR0_OFF + STRIDE_SIZE * 5) ;\
+	RESTORE_SPR(SPRN_IVOR6, BOOKE_IVOR0_OFF + STRIDE_SIZE * 6) ;\
+	RESTORE_SPR(SPRN_IVOR7, BOOKE_IVOR0_OFF + STRIDE_SIZE * 7) ;\
+	RESTORE_SPR(SPRN_IVOR8, BOOKE_IVOR0_OFF + STRIDE_SIZE * 8) ;\
+	RESTORE_SPR(SPRN_IVOR9, BOOKE_IVOR0_OFF + STRIDE_SIZE * 9) ;\
+	RESTORE_SPR(SPRN_IVOR10, BOOKE_IVOR0_OFF + STRIDE_SIZE * 10) ;\
+	RESTORE_SPR(SPRN_IVOR11, BOOKE_IVOR0_OFF + STRIDE_SIZE * 11) ;\
+	RESTORE_SPR(SPRN_IVOR12, BOOKE_IVOR0_OFF + STRIDE_SIZE * 12) ;\
+	RESTORE_SPR(SPRN_IVOR13, BOOKE_IVOR0_OFF + STRIDE_SIZE * 13) ;\
+	RESTORE_SPR(SPRN_IVOR14, BOOKE_IVOR0_OFF + STRIDE_SIZE * 14) ;\
+	RESTORE_SPR(SPRN_IVOR15, BOOKE_IVOR0_OFF + STRIDE_SIZE * 15) ;\
+	RESTORE_SPR(SPRN_IVOR35, BOOKE_IVOR0_OFF + STRIDE_SIZE * 35) ;\
+	RESTORE_SPR(SPRN_IVOR36, BOOKE_IVOR0_OFF + STRIDE_SIZE * 36) ;\
+	RESTORE_SPR(SPRN_IVOR37, BOOKE_IVOR0_OFF + STRIDE_SIZE * 37) ;\
+	RESTORE_SPR(SPRN_IVOR38, BOOKE_IVOR0_OFF + STRIDE_SIZE * 38) ;\
+	RESTORE_SPR(SPRN_IVOR39, BOOKE_IVOR0_OFF + STRIDE_SIZE * 39) ;\
+	RESTORE_SPR(SPRN_IVOR40, BOOKE_IVOR0_OFF + STRIDE_SIZE * 40) ;\
+	RESTORE_SPR(SPRN_IVOR41, BOOKE_IVOR0_OFF + STRIDE_SIZE * 41)
+
+/* reset time base to prevent from overflow */
+#define DELAY(count)		\
+	li	r3, count;	\
+	li	r4, 0;		\
+	mtspr	SPRN_TBWL, r4;	\
+101:	mfspr	r4, SPRN_TBRL;	\
+	cmpw	r4, r3;		\
+	blt	101b
+
+#define FSL_DIS_ALL_IRQ		\
+	mfmsr	r8;			\
+	rlwinm	r8, r8, 0, ~MSR_CE;	\
+	rlwinm	r8, r8, 0, ~MSR_ME;	\
+	rlwinm	r8, r8, 0, ~MSR_EE;	\
+	rlwinm	r8, r8, 0, ~MSR_DE;	\
+	mtmsr	r8;			\
+	isync
+
+	.section .data
+	.align	6
+regs_buffer:
+	.space BUFFER_SIZE
+
+	.section .text
+/*
+ * Save CPU registers
+ * r3 : the base address of the buffer which stores the values of registers
+ */
+e5500_cpu_state_save:
+	/* store the base address to r10 */
+	mr	r10, r3
+
+	SAVE_ALL_GPR
+	SAVE_ALL_SPRG
+	SAVE_ALL_IVOR
+
+	SAVE_SPR(SPRN_IVPR, BOOKE_IVPR_OFF)
+	SAVE_SPR(SPRN_PID0, BOOKE_PID0_OFF)
+	SAVE_SPR(SPRN_EPCR, BOOKE_EPCR_OFF)
+	SAVE_SPR(SPRN_HID0, BOOKE_HID0_OFF)
+	SAVE_SPR(SPRN_PIR, BOOKE_PIR_OFF)
+	SAVE_SPR(SPRN_BUCSR, BOOKE_BUCSR_OFF)
+1:
+	mfspr	r5, SPRN_TBRU
+	mfspr	r4, SPRN_TBRL
+	SAVE_GPR(r5, BOOKE_TBU_OFF)
+	SAVE_GPR(r4, BOOKE_TBL_OFF)
+	mfspr	r3, SPRN_TBRU
+	cmpw	r3, r5
+	bne	1b
+
+	blr
+
+/*
+ * Restore CPU registers
+ * r3 : the base address of the buffer which stores the values of registers
+ */
+e5500_cpu_state_restore:
+	/* store the base address to r10 */
+	mr	r10, r3
+
+	RESTORE_ALL_GPR
+	RESTORE_ALL_SPRG
+	RESTORE_ALL_IVOR
+
+	RESTORE_SPR(SPRN_IVPR, BOOKE_IVPR_OFF)
+	RESTORE_SPR(SPRN_PID0, BOOKE_PID0_OFF)
+	RESTORE_SPR(SPRN_EPCR, BOOKE_EPCR_OFF)
+	RESTORE_SPR(SPRN_HID0, BOOKE_HID0_OFF)
+	RESTORE_SPR(SPRN_PIR, BOOKE_PIR_OFF)
+	RESTORE_SPR(SPRN_BUCSR, BOOKE_BUCSR_OFF)
+
+	li	r0, 0
+	mtspr	SPRN_TBWL, r0
+	RESTORE_SPR(SPRN_TBWU, BOOKE_TBU_OFF)
+	RESTORE_SPR(SPRN_TBWL, BOOKE_TBL_OFF)
+
+	blr
+
+#define CPC_CPCCSR0		0x0
+#define CPC_CPCCSR0_CPCFL	0x800
+
+/*
+ * Flush the CPC cache.
+ * r3 : the base address of CPC
+ */
+flush_cpc_cache:
+	lwz	r6, CPC_CPCCSR0(r3)
+	ori	r6, r6, CPC_CPCCSR0_CPCFL
+	stw	r6, CPC_CPCCSR0(r3)
+	sync
+
+	/* Wait until completing the flush */
+1:	lwz	r6, CPC_CPCCSR0(r3)
+	andi.	r6, r6, CPC_CPCCSR0_CPCFL
+	bne	1b
+
+	blr
+
+/*
+ * the last stage to enter deep sleep
+ *
+ */
+	.align 6
+_GLOBAL(fsl_dp_enter_low)
+deepsleep_start:
+	LOAD_REG_ADDR(r9, buf_tmp)
+	/* save the return address and MSR */
+	mflr	r8
+	PPC_STL r8, 0(r9)
+	mfmsr	r8
+	PPC_STL r8, 8(r9)
+	mfspr	r8, SPRN_TCR
+	PPC_STL r8, 16(r9)
+	mfcr	r8
+	PPC_STL	r8, 24(r9)
+	li	r8, 0
+	mtspr	SPRN_TCR, r8
+
+	/* save the parameters */
+	PPC_STL	r3, 32(r9)
+	PPC_STL	r4, 40(r9)
+	PPC_STL	r5, 48(r9)
+	PPC_STL	r6, 56(r9)
+
+	LOAD_REG_ADDR(r3, regs_buffer)
+	bl	e5500_cpu_state_save
+
+	/* restore the parameters */
+	LOAD_REG_ADDR(r9, buf_tmp)
+	PPC_LL	r31, 32(r9)
+	PPC_LL	r30, 40(r9)
+	PPC_LL	r29, 48(r9)
+	PPC_LL	r28, 56(r9)
+
+	/* flush caches inside CPU */
+	LOAD_REG_ADDR(r3, cur_cpu_spec)
+	PPC_LL	r3, 0(r3)
+	PPC_LL	r3, CPU_DOWN_FLUSH(r3)
+	PPC_LCMPI  0, r3, 0
+	beq	6f
+#ifdef CONFIG_PPC64
+	PPC_LL	r3, 0(r3)
+#endif
+	mtctr	r3
+	bctrl
+6:
+	/* Flush the CPC cache */
+#define CPC_OFFSET	0x10000
+	mr	r3, r31
+	addis	r3, r3, CPC_OFFSET@h
+	bl	flush_cpc_cache
+
+	/* prefecth TLB */
+#define CCSR_GPIO1_GPDAT	0x130008
+#define CCSR_GPIO1_GPDAT_29	0x4
+	LOAD_REG_IMMEDIATE(r11, CCSR_GPIO1_GPDAT)
+	add	r11, r31, r11
+	lwz	r10, 0(r11)
+
+#define CCSR_RCPM_PCPH15SETR	0xe20b4
+#define CCSR_RCPM_PCPH15SETR_CORE0	0x1
+	LOAD_REG_IMMEDIATE(r12, CCSR_RCPM_PCPH15SETR)
+	add	r12, r31, r12
+	lwz	r10, 0(r12)
+
+#define CCSR_DDR_SDRAM_CFG_2	0x8114
+#define CCSR_DDR_SDRAM_CFG_2_FRC_SR	0x80000000
+	LOAD_REG_IMMEDIATE(r13, CCSR_DDR_SDRAM_CFG_2)
+	add	r13, r31, r13
+	lwz	r10, 0(r13)
+
+#define	DCSR_EPU_EPGCR		0x000
+#define DCSR_EPU_EPGCR_GCE	0x80000000
+	li	r14, DCSR_EPU_EPGCR
+	add	r14, r30, r14
+	lwz	r10, 0(r14)
+
+#define	DCSR_EPU_EPECR15	0x33C
+#define DCSR_EPU_EPECR15_IC0	0x80000000
+	li	r15, DCSR_EPU_EPECR15
+	add	r15, r30, r15
+	lwz	r10, 0(r15)
+
+#define CCSR_SCFG_QMIFRSTCR		0xfc40c
+#define CCSR_SCFG_QMIFRSTCR_QMIFRST	0x80000000
+	LOAD_REG_IMMEDIATE(r16, CCSR_SCFG_QMIFRSTCR)
+	add	r16, r31, r16
+	lwz	r10, 0(r16)
+
+/*
+ * There are two kind of register maps, one for T1040QDS and
+ * the other for T104xRDB.
+ */
+#define T104XRDB_CPLD_MISCCSR		0x17
+#define T104XRDB_CPLD_MISCCSR_SLEEPEN	0x40
+#define T1040QDS_QIXIS_PWR_CTL2		0x21
+#define T1040QDS_QIXIS_PWR_CTL2_PCTL	0x2
+	li	r3, T1040QDS_QIXIS_PWR_CTL2
+	PPC_LCMPI  0, r28, T1040QDS_TETRA_FLAG
+	beq	20f
+	li	r3, T104XRDB_CPLD_MISCCSR
+20:	add	r29, r29, r3
+	lbz	r10, 0(r29)
+	sync
+
+	LOAD_REG_ADDR(r8, deepsleep_start)
+	LOAD_REG_ADDR(r9, deepsleep_end)
+
+	/* prefecth code to cache so that executing code after disable DDR */
+1:	icbtls	2, 0, r8
+	addi	r8, r8, 64
+	cmpw	r8, r9
+	blt	1b
+	sync
+
+	FSL_DIS_ALL_IRQ
+
+	/*
+	 * Place DDR controller in self refresh mode.
+	 * From here on, can't access DDR any more.
+	 */
+	lwz	r10, 0(r13)
+	oris	r10, r10, CCSR_DDR_SDRAM_CFG_2_FRC_SR@h
+	stw	r10, 0(r13)
+	lwz	r10, 0(r13)
+	sync
+
+	DELAY(500)
+
+	/*
+	 * Enable deep sleep signals by write external CPLD/FPGA register.
+	 * The bootloader will disable them when wakeup from deep sleep.
+	 */
+	lbz	r10, 0(r29)
+	li	r3, T1040QDS_QIXIS_PWR_CTL2_PCTL
+	PPC_LCMPI  0, r28, T1040QDS_TETRA_FLAG
+	beq	22f
+	li	r3, T104XRDB_CPLD_MISCCSR_SLEEPEN
+22:	or	r10, r10, r3
+	stb	r10, 0(r29)
+	lbz	r10, 0(r29)
+	sync
+
+	/*
+	 * Set GPIO1_29 to lock the signal MCKE down during deep sleep.
+	 * The bootloader will clear it when wakeup.
+	 */
+	lwz	r10, 0(r11)
+	ori	r10, r10, CCSR_GPIO1_GPDAT_29
+	stw	r10, 0(r11)
+	lwz	r10, 0(r11)
+
+	DELAY(100)
+
+	/* Reset QMan system bus interface */
+	lwz	r10, 0(r16)
+	oris	r10, r10, CCSR_SCFG_QMIFRSTCR_QMIFRST@h
+	stw	r10, 0(r16)
+	lwz	r10, 0(r16)
+
+	/* Enable all EPU Counters */
+	li	r10, 0
+	oris	r10, r10, DCSR_EPU_EPGCR_GCE@h
+	stw	r10, 0(r14)
+	lwz	r10, 0(r14)
+
+	/* Enable SCU15 to trigger on RCPM Concentrator 0 */
+	lwz	r10, 0(r15)
+	oris	r10, r10, DCSR_EPU_EPECR15_IC0@h
+	stw	r10, 0(r15)
+	lwz	r10, 0(r15)
+
+	/* put Core0 in PH15 mode, trigger EPU FSM */
+	lwz	r10, 0(r12)
+	ori	r10, r10, CCSR_RCPM_PCPH15SETR_CORE0
+	stw	r10, 0(r12)
+2:
+	b 2b
+
+	/*
+	 * Leave some space to prevent prefeching instruction
+	 * beyond deepsleep_end. The space also can be used as heap.
+	 */
+buf_tmp:
+	.space 128
+	.align 6
+deepsleep_end:
+
+	.align 12
+#ifdef CONFIG_PPC32
+_GLOBAL(fsl_booke_deep_sleep_resume)
+	/* disable interrupts */
+	FSL_DIS_ALL_IRQ
+
+#define ENTRY_DEEPSLEEP_SETUP
+#define ENTRY_MAPPING_BOOT_SETUP
+#include <../../kernel/fsl_booke_entry_mapping.S>
+#undef ENTRY_DEEPSLEEP_SETUP
+#undef ENTRY_MAPPING_BOOT_SETUP
+
+	li	r3, 0
+	mfspr   r4, SPRN_PIR
+	bl	call_setup_cpu
+
+	/* Load each CAM entry */
+	LOAD_REG_ADDR(r3, tlbcam_index)
+	lwz	r3, 0(r3)
+	mtctr	r3
+	li	r9, 0
+3:	mr	r3, r9
+	bl	loadcam_entry
+	addi	r9, r9, 1
+	bdnz	3b
+
+	/* restore cpu registers */
+	LOAD_REG_ADDR(r3, regs_buffer)
+	bl	e5500_cpu_state_restore
+
+	/* restore return address */
+	LOAD_REG_ADDR(r3, buf_tmp)
+	lwz	r4, 16(r3)
+	mtspr	SPRN_TCR, r4
+	lwz	r4, 0(r3)
+	mtlr	r4
+	lwz	r4, 8(r3)
+	mtmsr	r4
+	lwz	r4, 24(r3)
+	mtcr	r4
+
+	blr
+
+#else /* CONFIG_PPC32 */
+
+_GLOBAL(fsl_booke_deep_sleep_resume)
+	/* disable interrupts */
+	FSL_DIS_ALL_IRQ
+
+	/* switch to 64-bit mode */
+	bl	.enable_64b_mode
+
+	/* set TOC pointer */
+	bl	.relative_toc
+
+	/* setup initial TLBs, switch to kernel space ... */
+	bl	.start_initialization_book3e
+
+	/* address space changed, set TOC pointer again */
+	bl	.relative_toc
+
+	/* call a cpu state restore handler */
+	LOAD_REG_ADDR(r23, cur_cpu_spec)
+	ld	r23,0(r23)
+	ld	r23,CPU_SPEC_RESTORE(r23)
+	cmpdi	0,r23,0
+	beq	1f
+	ld	r23,0(r23)
+	mtctr	r23
+	bctrl
+1:
+	LOAD_REG_ADDR(r3, regs_buffer)
+	bl	e5500_cpu_state_restore
+
+	/* Load each CAM entry */
+	LOAD_REG_ADDR(r3, tlbcam_index)
+	lwz	r3, 0(r3)
+	mtctr	r3
+	li	r0, 0
+3:	mr	r3, r0
+	bl	loadcam_entry
+	addi	r0, r0, 1
+	bdnz	3b
+
+	/* restore return address */
+	LOAD_REG_ADDR(r3, buf_tmp)
+	ld	r4, 16(r3)
+	mtspr	SPRN_TCR, r4
+	ld	r4, 0(r3)
+	mtlr	r4
+	ld	r4, 8(r3)
+	mtmsr	r4
+	ld	r4, 24(r3)
+	mtcr	r4
+
+	blr
+
+#endif /* CONFIG_PPC32 */
-- 
1.9.1
