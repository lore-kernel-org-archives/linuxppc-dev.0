Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89A871A072A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 21:51:29 +1100 (AEDT)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 2/4] powerpc/rcpm: add RCPM driver
Date: Thu, 26 Mar 2015 18:18:13 +0800
Message-ID: <1427365095-26396-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1427365095-26396-1-git-send-email-chenhui.zhao@freescale.com>
References: <1427365095-26396-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a RCPM (Run Control/Power Management) in Freescale QorIQ
series processors. The device performs tasks associated with device
run control and power management.

The driver implements some features: mask/unmask irq, enter/exit low
power states, freeze time base, etc.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 Documentation/devicetree/bindings/soc/fsl/rcpm.txt |  23 ++
 arch/powerpc/include/asm/fsl_guts.h                | 105 ++++++
 arch/powerpc/include/asm/fsl_pm.h                  |  49 +++
 arch/powerpc/platforms/85xx/Kconfig                |   1 +
 arch/powerpc/sysdev/Kconfig                        |   5 +
 arch/powerpc/sysdev/Makefile                       |   1 +
 arch/powerpc/sysdev/fsl_rcpm.c                     | 353 +++++++++++++++++++++
 7 files changed, 537 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/rcpm.txt
 create mode 100644 arch/powerpc/include/asm/fsl_pm.h
 create mode 100644 arch/powerpc/sysdev/fsl_rcpm.c

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
new file mode 100644
index 0000000..8c21b6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -0,0 +1,23 @@
+* Run Control and Power Management
+
+The RCPM performs all device-level tasks associated with device run control
+and power management.
+
+Required properites:
+  - reg : Offset and length of the register set of RCPM block.
+  - compatible : Specifies the compatibility list for the RCPM. The type
+    should be string, such as "fsl,qoriq-rcpm-1.0", "fsl,qoriq-rcpm-2.0".
+
+Example:
+The RCPM node for T4240:
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
+		reg = <0xe2000 0x1000>;
+	};
+
+The RCPM node for P4080:
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,qoriq-rcpm-1.0";
+		reg = <0xe2000 0x1000>;
+		#sleep-cells = <1>;
+	};
diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index 43b6bb1..96018ee 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -188,5 +188,110 @@ static inline void guts_set_pmuxcr_dma(struct ccsr_guts __iomem *guts,
 
 #endif
 
+struct ccsr_rcpm_v1 {
+	u8	res0000[4];
+	__be32	cdozsr;	    /* 0x0004 Core Doze Status Register */
+	u8	res0008[4];
+	__be32	cdozcr;	    /* 0x000c Core Doze Control Register */
+	u8	res0010[4];
+	__be32	cnapsr;	    /* 0x0014 Core Nap Status Register */
+	u8	res0018[4];
+	__be32	cnapcr;	    /* 0x001c Core Nap Control Register */
+	u8	res0020[4];
+	__be32	cdozpsr;    /* 0x0024 Core Doze Previous Status Register */
+	u8	res0028[4];
+	__be32	cnappsr;    /* 0x002c Core Nap Previous Status Register */
+	u8	res0030[4];
+	__be32	cwaitsr;    /* 0x0034 Core Wait Status Register */
+	u8	res0038[4];
+	__be32	cwdtdsr;    /* 0x003c Core Watchdog Detect Status Register */
+	__be32	powmgtcsr;  /* 0x0040 Power Management Control&Status Register */
+#define RCPM_POWMGTCSR_SLP	0x00020000
+	u8	res0044[12];
+	__be32	ippdexpcr;  /* 0x0050 IP Powerdown Exception Control Register */
+	u8	res0054[16];
+	__be32	cpmimr;	    /* 0x0064 Core PM IRQ Mask Register */
+	u8	res0068[4];
+	__be32	cpmcimr;    /* 0x006c Core PM Critical IRQ Mask Register */
+	u8	res0070[4];
+	__be32	cpmmcmr;    /* 0x0074 Core PM Machine Check Mask Register */
+	u8	res0078[4];
+	__be32	cpmnmimr;   /* 0x007c Core PM NMI Mask Register */
+	u8	res0080[4];
+	__be32	ctbenr;	    /* 0x0084 Core Time Base Enable Register */
+	u8	res0088[4];
+	__be32	ctbckselr;  /* 0x008c Core Time Base Clock Select Register */
+	u8	res0090[4];
+	__be32	ctbhltcr;   /* 0x0094 Core Time Base Halt Control Register */
+	u8	res0098[4];
+	__be32	cmcpmaskcr; /* 0x00a4 Core Machine Check Mask Register */
+};
+
+struct ccsr_rcpm_v2 {
+	u8	res_00[12];
+	__be32	tph10sr0;	/* Thread PH10 Status Register */
+	u8	res_10[12];
+	__be32	tph10setr0;	/* Thread PH10 Set Control Register */
+	u8	res_20[12];
+	__be32	tph10clrr0;	/* Thread PH10 Clear Control Register */
+	u8	res_30[12];
+	__be32	tph10psr0;	/* Thread PH10 Previous Status Register */
+	u8	res_40[12];
+	__be32	twaitsr0;	/* Thread Wait Status Register */
+	u8	res_50[96];
+	__be32	pcph15sr;	/* Physical Core PH15 Status Register */
+	__be32	pcph15setr;	/* Physical Core PH15 Set Control Register */
+	__be32	pcph15clrr;	/* Physical Core PH15 Clear Control Register */
+	__be32	pcph15psr;	/* Physical Core PH15 Prev Status Register */
+	u8	res_c0[16];
+	__be32	pcph20sr;	/* Physical Core PH20 Status Register */
+	__be32	pcph20setr;	/* Physical Core PH20 Set Control Register */
+	__be32	pcph20clrr;	/* Physical Core PH20 Clear Control Register */
+	__be32	pcph20psr;	/* Physical Core PH20 Prev Status Register */
+	__be32	pcpw20sr;	/* Physical Core PW20 Status Register */
+	u8	res_e0[12];
+	__be32	pcph30sr;	/* Physical Core PH30 Status Register */
+	__be32	pcph30setr;	/* Physical Core PH30 Set Control Register */
+	__be32	pcph30clrr;	/* Physical Core PH30 Clear Control Register */
+	__be32	pcph30psr;	/* Physical Core PH30 Prev Status Register */
+	u8	res_100[32];
+	__be32	ippwrgatecr;	/* IP Power Gating Control Register */
+	u8	res_124[12];
+	__be32	powmgtcsr;	/* Power Management Control & Status Reg */
+#define RCPM_POWMGTCSR_LPM20_RQ		0x00100000
+#define RCPM_POWMGTCSR_LPM20_ST		0x00000200
+#define RCPM_POWMGTCSR_P_LPM20_ST	0x00000100
+	u8	res_134[12];
+	__be32	ippdexpcr[4];	/* IP Powerdown Exception Control Reg */
+	u8	res_150[12];
+	__be32	tpmimr0;	/* Thread PM Interrupt Mask Reg */
+	u8	res_160[12];
+	__be32	tpmcimr0;	/* Thread PM Crit Interrupt Mask Reg */
+	u8	res_170[12];
+	__be32	tpmmcmr0;	/* Thread PM Machine Check Interrupt Mask Reg */
+	u8	res_180[12];
+	__be32	tpmnmimr0;	/* Thread PM NMI Mask Reg */
+	u8	res_190[12];
+	__be32	tmcpmaskcr0;	/* Thread Machine Check Mask Control Reg */
+	__be32	pctbenr;	/* Physical Core Time Base Enable Reg */
+	__be32	pctbclkselr;	/* Physical Core Time Base Clock Select */
+	__be32	tbclkdivr;	/* Time Base Clock Divider Register */
+	u8	res_1ac[4];
+	__be32	ttbhltcr[4];	/* Thread Time Base Halt Control Register */
+	__be32	clpcl10sr;	/* Cluster PCL10 Status Register */
+	__be32	clpcl10setr;	/* Cluster PCL30 Set Control Register */
+	__be32	clpcl10clrr;	/* Cluster PCL30 Clear Control Register */
+	__be32	clpcl10psr;	/* Cluster PCL30 Prev Status Register */
+	__be32	cddslpsetr;	/* Core Domain Deep Sleep Set Register */
+	__be32	cddslpclrr;	/* Core Domain Deep Sleep Clear Register */
+	__be32	cdpwroksetr;	/* Core Domain Power OK Set Register */
+	__be32	cdpwrokclrr;	/* Core Domain Power OK Clear Register */
+	__be32	cdpwrensr;	/* Core Domain Power Enable Status Register */
+	__be32	cddslsr;	/* Core Domain Deep Sleep Status Register */
+	u8	res_1e8[8];
+	__be32	dslpcntcr[8];	/* Deep Sleep Counter Cfg Register */
+	u8	res_300[3568];
+};
+
 #endif
 #endif
diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm/fsl_pm.h
new file mode 100644
index 0000000..bbe6089
--- /dev/null
+++ b/arch/powerpc/include/asm/fsl_pm.h
@@ -0,0 +1,49 @@
+/*
+ * Support Power Management
+ *
+ * Copyright 2014-2015 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __PPC_FSL_PM_H
+#define __PPC_FSL_PM_H
+#ifdef	__KERNEL__
+
+#define E500_PM_PH10	1
+#define E500_PM_PH15	2
+#define E500_PM_PH20	3
+#define E500_PM_PH30	4
+#define E500_PM_DOZE	E500_PM_PH10
+#define E500_PM_NAP	E500_PM_PH15
+
+#define PLAT_PM_SLEEP	20
+#define PLAT_PM_LPM20	30
+
+#define FSL_PM_SLEEP		(1 << 0)
+#define FSL_PM_DEEP_SLEEP	(1 << 1)
+
+struct fsl_pm_ops {
+	/* mask pending interrupts to the RCPM from MPIC */
+	void (*irq_mask)(int cpu);
+	/* unmask pending interrupts to the RCPM from MPIC */
+	void (*irq_unmask)(int cpu);
+	/* place the CPU in the specified state */
+	void (*cpu_enter_state)(int cpu, int state);
+	/* exit the CPU from the specified state */
+	void (*cpu_exit_state)(int cpu, int state);
+	/* place the platform in the sleep state */
+	int (*plat_enter_sleep)(void);
+	/* freeze the time base */
+	void (*freeze_time_base)(int freeze);
+	/* keep the power of IP blocks during sleep/deep sleep */
+	void (*set_ip_power)(int enable, u32 *mask);
+	/* get platform supported power management modes */
+	unsigned int (*get_pm_modes)(void);
+};
+
+extern const struct fsl_pm_ops *qoriq_pm_ops;
+#endif	/* __KERNEL__ */
+#endif  /* __PPC_FSL_PM_H */
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 2fb4b24..ae1b8a2 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -8,6 +8,7 @@ menuconfig FSL_SOC_BOOKE
 	select FSL_PCI if PCI
 	select SERIAL_8250_EXTENDED if SERIAL_8250
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
+	select FSL_CORENET_RCPM if PPC_E500MC
 	default y
 
 if FSL_SOC_BOOKE
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index a19332a..52dc165 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -40,3 +40,8 @@ config SCOM_DEBUGFS
 config GE_FPGA
 	bool
 	default n
+
+config FSL_CORENET_RCPM
+	bool
+	help
+	  This option enables support for RCPM (Run Control/Power Management).
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f7cb2a1..8bbedfd 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o fsl_mpic_err.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
 obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
+obj-$(CONFIG_FSL_CORENET_RCPM)	+= fsl_rcpm.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
diff --git a/arch/powerpc/sysdev/fsl_rcpm.c b/arch/powerpc/sysdev/fsl_rcpm.c
new file mode 100644
index 0000000..e30f1bc
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_rcpm.c
@@ -0,0 +1,353 @@
+/*
+ * RCPM(Run Control/Power Management) support
+ *
+ * Copyright 2012-2015 Freescale Semiconductor Inc.
+ *
+ * Author: Chenhui Zhao <chenhui.zhao@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/of_address.h>
+#include <linux/export.h>
+
+#include <asm/io.h>
+#include <asm/fsl_guts.h>
+#include <asm/cputhreads.h>
+#include <asm/fsl_pm.h>
+
+#define RCPM_V1		1
+#define RCPM_V2		2
+
+const struct fsl_pm_ops *qoriq_pm_ops;
+
+static struct ccsr_rcpm_v1 __iomem *rcpm_v1_regs;
+static struct ccsr_rcpm_v2 __iomem *rcpm_v2_regs;
+static unsigned int fsl_supported_pm_modes;
+
+static void rcpm_v1_irq_mask(int cpu)
+{
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+	unsigned int mask = 1 << hw_cpu;
+
+	setbits32(&rcpm_v1_regs->cpmimr, mask);
+	setbits32(&rcpm_v1_regs->cpmcimr, mask);
+	setbits32(&rcpm_v1_regs->cpmmcmr, mask);
+	setbits32(&rcpm_v1_regs->cpmnmimr, mask);
+}
+
+static void rcpm_v2_irq_mask(int cpu)
+{
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+	unsigned int mask = 1 << hw_cpu;
+
+	setbits32(&rcpm_v2_regs->tpmimr0, mask);
+	setbits32(&rcpm_v2_regs->tpmcimr0, mask);
+	setbits32(&rcpm_v2_regs->tpmmcmr0, mask);
+	setbits32(&rcpm_v2_regs->tpmnmimr0, mask);
+}
+
+static void rcpm_v1_irq_unmask(int cpu)
+{
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+	unsigned int mask = 1 << hw_cpu;
+
+	clrbits32(&rcpm_v1_regs->cpmimr, mask);
+	clrbits32(&rcpm_v1_regs->cpmcimr, mask);
+	clrbits32(&rcpm_v1_regs->cpmmcmr, mask);
+	clrbits32(&rcpm_v1_regs->cpmnmimr, mask);
+}
+
+static void rcpm_v2_irq_unmask(int cpu)
+{
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+	unsigned int mask = 1 << hw_cpu;
+
+	clrbits32(&rcpm_v2_regs->tpmimr0, mask);
+	clrbits32(&rcpm_v2_regs->tpmcimr0, mask);
+	clrbits32(&rcpm_v2_regs->tpmmcmr0, mask);
+	clrbits32(&rcpm_v2_regs->tpmnmimr0, mask);
+}
+
+static void rcpm_v1_set_ip_power(int enable, u32 *mask)
+{
+	if (enable)
+		setbits32(&rcpm_v1_regs->ippdexpcr, *mask);
+	else
+		clrbits32(&rcpm_v1_regs->ippdexpcr, *mask);
+}
+
+static void rcpm_v2_set_ip_power(int enable, u32 *mask)
+{
+	if (enable)
+		setbits32(&rcpm_v2_regs->ippdexpcr[0], *mask);
+	else
+		clrbits32(&rcpm_v2_regs->ippdexpcr[0], *mask);
+}
+
+static void rcpm_v1_cpu_enter_state(int cpu, int state)
+{
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+	unsigned int mask = 1 << hw_cpu;
+
+	switch (state) {
+	case E500_PM_PH10:
+		setbits32(&rcpm_v1_regs->cdozcr, mask);
+		break;
+	case E500_PM_PH15:
+		setbits32(&rcpm_v1_regs->cnapcr, mask);
+		break;
+	default:
+		pr_err("%s: Unknown cpu PM state (%d)\n", __func__, state);
+		break;
+	}
+}
+
+static void rcpm_v2_cpu_enter_state(int cpu, int state)
+{
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+	u32 mask = 1 << cpu_core_index_of_thread(hw_cpu);
+
+	switch (state) {
+	case E500_PM_PH10:
+		/* one bit corresponds to one thread for PH10 of 6500 */
+		setbits32(&rcpm_v2_regs->tph10setr0, 1 << hw_cpu);
+		break;
+	case E500_PM_PH15:
+		setbits32(&rcpm_v2_regs->pcph15setr, mask);
+		break;
+	case E500_PM_PH20:
+		setbits32(&rcpm_v2_regs->pcph20setr, mask);
+		break;
+	case E500_PM_PH30:
+		setbits32(&rcpm_v2_regs->pcph30setr, mask);
+		break;
+	default:
+		pr_err("%s: Unknown cpu PM state (%d)\n", __func__, state);
+	}
+}
+
+static void rcpm_v1_cpu_exit_state(int cpu, int state)
+{
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+	unsigned int mask = 1 << hw_cpu;
+
+	switch (state) {
+	case E500_PM_PH10:
+		clrbits32(&rcpm_v1_regs->cdozcr, mask);
+		break;
+	case E500_PM_PH15:
+		clrbits32(&rcpm_v1_regs->cnapcr, mask);
+		break;
+	default:
+		pr_err("%s: Unknown cpu PM state (%d)\n", __func__, state);
+		break;
+	}
+}
+
+static void rcpm_v2_cpu_exit_state(int cpu, int state)
+{
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+	u32 mask = 1 << cpu_core_index_of_thread(hw_cpu);
+
+	switch (state) {
+	case E500_PM_PH10:
+		setbits32(&rcpm_v2_regs->tph10clrr0, 1 << hw_cpu);
+		break;
+	case E500_PM_PH15:
+		setbits32(&rcpm_v2_regs->pcph15clrr, mask);
+		break;
+	case E500_PM_PH20:
+		setbits32(&rcpm_v2_regs->pcph20clrr, mask);
+		break;
+	case E500_PM_PH30:
+		setbits32(&rcpm_v2_regs->pcph30clrr, mask);
+		break;
+	default:
+		pr_err("%s: Unknown cpu PM state (%d)\n", __func__, state);
+	}
+}
+
+static int rcpm_v1_plat_enter_state(int state)
+{
+	u32 *pmcsr_reg = &rcpm_v1_regs->powmgtcsr;
+	int ret = 0;
+	int result;
+
+	switch (state) {
+	case PLAT_PM_SLEEP:
+		setbits32(pmcsr_reg, RCPM_POWMGTCSR_SLP);
+
+		/* At this point, the device is in sleep mode. */
+
+		/* Upon resume, wait for RCPM_POWMGTCSR_SLP bit to be clear. */
+		result = spin_event_timeout(
+		  !(in_be32(pmcsr_reg) & RCPM_POWMGTCSR_SLP), 10000, 10);
+		if (!result) {
+			pr_err("%s: timeout waiting for SLP bit to be cleared\n",
+			       __func__);
+			ret = -ETIMEDOUT;
+		}
+		break;
+	default:
+		pr_err("%s: Unknown platform PM state (%d)\n",
+		       __func__, state);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int rcpm_v2_plat_enter_state(int state)
+{
+	u32 *pmcsr_reg = &rcpm_v2_regs->powmgtcsr;
+	int ret = 0;
+	int result;
+
+	switch (state) {
+	case PLAT_PM_LPM20:
+		/* clear previous LPM20 status */
+		setbits32(pmcsr_reg, RCPM_POWMGTCSR_P_LPM20_ST);
+		/* enter LPM20 status */
+		setbits32(pmcsr_reg, RCPM_POWMGTCSR_LPM20_RQ);
+
+		/* At this point, the device is in LPM20 status. */
+
+		/* resume ... */
+		result = spin_event_timeout(
+		  !(in_be32(pmcsr_reg) & RCPM_POWMGTCSR_LPM20_ST), 10000, 10);
+		if (!result) {
+			pr_err("%s: timeout waiting for LPM20 bit to be cleared\n",
+			       __func__);
+			ret = -ETIMEDOUT;
+		}
+		break;
+	default:
+		pr_err("%s: Unknown platform PM state (%d)\n",
+		       __func__, state);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int rcpm_v1_plat_enter_sleep(void)
+{
+	return rcpm_v1_plat_enter_state(PLAT_PM_SLEEP);
+}
+
+static int rcpm_v2_plat_enter_sleep(void)
+{
+	return rcpm_v2_plat_enter_state(PLAT_PM_LPM20);
+}
+
+static void rcpm_common_freeze_time_base(u32 *tben_reg, int freeze)
+{
+	static u32 mask;
+
+	if (freeze) {
+		mask = in_be32(tben_reg);
+		clrbits32(tben_reg, mask);
+	} else {
+		setbits32(tben_reg, mask);
+	}
+
+	/* read back to push the previous write */
+	in_be32(tben_reg);
+}
+
+static void rcpm_v1_freeze_time_base(int freeze)
+{
+	rcpm_common_freeze_time_base(&rcpm_v1_regs->ctbenr, freeze);
+}
+
+static void rcpm_v2_freeze_time_base(int freeze)
+{
+	rcpm_common_freeze_time_base(&rcpm_v2_regs->pctbenr, freeze);
+}
+
+static unsigned int rcpm_get_pm_modes(void)
+{
+	return fsl_supported_pm_modes;
+}
+
+static const struct fsl_pm_ops qoriq_rcpm_v1_ops = {
+	.irq_mask = rcpm_v1_irq_mask,
+	.irq_unmask = rcpm_v1_irq_unmask,
+	.cpu_enter_state = rcpm_v1_cpu_enter_state,
+	.cpu_exit_state = rcpm_v1_cpu_exit_state,
+	.plat_enter_sleep = rcpm_v1_plat_enter_sleep,
+	.set_ip_power = rcpm_v1_set_ip_power,
+	.freeze_time_base = rcpm_v1_freeze_time_base,
+	.get_pm_modes = rcpm_get_pm_modes,
+};
+
+static const struct fsl_pm_ops qoriq_rcpm_v2_ops = {
+	.irq_mask = rcpm_v2_irq_mask,
+	.irq_unmask = rcpm_v2_irq_unmask,
+	.cpu_enter_state = rcpm_v2_cpu_enter_state,
+	.cpu_exit_state = rcpm_v2_cpu_exit_state,
+	.plat_enter_sleep = rcpm_v2_plat_enter_sleep,
+	.set_ip_power = rcpm_v2_set_ip_power,
+	.freeze_time_base = rcpm_v2_freeze_time_base,
+	.get_pm_modes = rcpm_get_pm_modes,
+};
+
+static const struct of_device_id rcpm_matches[] = {
+	{
+		.compatible = "fsl,qoriq-rcpm-1.0",
+		.data = (void *)RCPM_V1,
+	},
+	{
+		.compatible = "fsl,qoriq-rcpm-2.0",
+		.data = (void *)RCPM_V2,
+	},
+	{},
+};
+
+int fsl_rcpm_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	void __iomem *base;
+
+	np = of_find_matching_node_and_match(NULL, rcpm_matches, &match);
+	if (!np) {
+		pr_err("%s: can't find the rcpm node.\n", __func__);
+		return -ENODEV;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s: of_iomap() error.\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* support sleep by default */
+	fsl_supported_pm_modes = FSL_PM_SLEEP;
+	of_node_put(np);
+
+	switch ((unsigned long)match->data) {
+	case RCPM_V1:
+		rcpm_v1_regs = base;
+		qoriq_pm_ops = &qoriq_rcpm_v1_ops;
+		break;
+
+	case RCPM_V2:
+		rcpm_v2_regs = base;
+		qoriq_pm_ops = &qoriq_rcpm_v2_ops;
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/* need to call this before SMP init */
+early_initcall(fsl_rcpm_init);
-- 
1.9.1
