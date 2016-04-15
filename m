Return-Path: <chenhui.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0097.outbound.protection.outlook.com [157.56.111.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmbPT0Fz7zDqTN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 21:47:24 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <oss@buserror.net>
CC: <jason.jin@nxp.com>, <chenhui.zhao@nxp.com>
Subject: [PATCH v2 1/5] powerpc/85xx: support sleep feature on QorIQ SoCs with
 RCPM
Date: Fri, 15 Apr 2016 19:13:13 +0800
Message-ID: <1460718797-21744-2-git-send-email-chenhui.zhao@nxp.com>
In-Reply-To: <1460718797-21744-1-git-send-email-chenhui.zhao@nxp.com>
References: <1460718797-21744-1-git-send-email-chenhui.zhao@nxp.com>
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

In sleep mode, the clocks of e500 cores and unused IP blocks is
turned off. The IP blocks which are allowed to wake up the processor
are still running.

The sleep mode is equal to the Standby state in Linux. Use the
command to enter sleep mode:
  echo standby > /sys/power/state

Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
---
 arch/powerpc/Kconfig                   |  3 +-
 arch/powerpc/include/asm/fsl_pm.h      |  2 +-
 arch/powerpc/platforms/85xx/Kconfig    |  5 +++
 arch/powerpc/platforms/85xx/Makefile   |  1 +
 arch/powerpc/platforms/85xx/qoriq_pm.c | 59 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig    |  1 +
 arch/powerpc/sysdev/fsl_rcpm.c         | 20 ++++--------
 7 files changed, 74 insertions(+), 17 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/qoriq_pm.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7cd32c0..e354533 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -238,7 +238,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
+		   FSL_SOC_BOOKE || PPC_86xx || PPC_PSERIES \
 		   || 44x || 40x
 
 config PPC_DCR_NATIVE
@@ -774,7 +774,6 @@ config FSL_PCI
 
 config FSL_PMC
 	bool
-	default y
 	depends on SUSPEND && (PPC_85xx || PPC_86xx)
 	help
 	  Freescale MPC85xx/MPC86xx power management controller support
diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm/fsl_pm.h
index 47df55e..e05049b 100644
--- a/arch/powerpc/include/asm/fsl_pm.h
+++ b/arch/powerpc/include/asm/fsl_pm.h
@@ -34,7 +34,7 @@ struct fsl_pm_ops {
 	void (*cpu_exit_state)(int cpu, int state);
 	void (*cpu_up_prepare)(int cpu);
 	void (*cpu_die)(int cpu);
-	int (*plat_enter_sleep)(void);
+	int (*plat_enter_sleep)(int state);
 	void (*freeze_time_base)(bool freeze);
 
 	/* keep the power of IP blocks during sleep/deep sleep */
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index e626461..dff2ea6 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -9,6 +9,8 @@ menuconfig FSL_SOC_BOOKE
 	select SERIAL_8250_EXTENDED if SERIAL_8250
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	select FSL_CORENET_RCPM if PPC_E500MC
+	select FSL_QORIQ_PM if SUSPEND && PPC_E500MC
+	select FSL_PMC if SUSPEND && !PPC_E500MC
 	default y
 
 if FSL_SOC_BOOKE
@@ -289,3 +291,6 @@ endif # FSL_SOC_BOOKE
 
 config TQM85xx
 	bool
+
+config FSL_QORIQ_PM
+	bool
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 7bc86da..fdae28b 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,6 +3,7 @@
 #
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_FSL_PMC)		  += mpc85xx_pm_ops.o
+obj-$(CONFIG_FSL_QORIQ_PM)	  += qoriq_pm.o
 
 obj-y += common.o
 
diff --git a/arch/powerpc/platforms/85xx/qoriq_pm.c b/arch/powerpc/platforms/85xx/qoriq_pm.c
new file mode 100644
index 0000000..8332e44
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/qoriq_pm.c
@@ -0,0 +1,59 @@
+/*
+ * Support Power Management feature
+ *
+ * Copyright 2016 NXP Semiconductors
+ *
+ * Author: Chenhui Zhao <chenhui.zhao@nxp.com>
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+#include <linux/of_platform.h>
+
+#include <asm/fsl_pm.h>
+
+static unsigned int pm_modes;
+
+static int qoriq_suspend_enter(suspend_state_t state)
+{
+	int ret = 0;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		ret = qoriq_pm_ops->plat_enter_sleep(FSL_PM_SLEEP);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int qoriq_suspend_valid(suspend_state_t state)
+{
+
+	if (state == PM_SUSPEND_STANDBY && (pm_modes & FSL_PM_SLEEP))
+		return 1;
+
+	return 0;
+}
+
+static const struct platform_suspend_ops qoriq_suspend_ops = {
+	.valid = qoriq_suspend_valid,
+	.enter = qoriq_suspend_enter,
+};
+
+static int __init qoriq_suspend_init(void)
+{
+	/* support sleep by default */
+	pm_modes |= FSL_PM_SLEEP;
+
+	suspend_set_ops(&qoriq_suspend_ops);
+	return 0;
+}
+arch_initcall(qoriq_suspend_init);
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 1afd1e4..09638e0 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -5,6 +5,7 @@ menuconfig PPC_86xx
 	select FSL_SOC
 	select ALTIVEC
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select FSL_PMC if SUSPEND
 	help
 	  The Freescale E600 SoCs have 74xx cores.
 
diff --git a/arch/powerpc/sysdev/fsl_rcpm.c b/arch/powerpc/sysdev/fsl_rcpm.c
index 9259a94..e5447ac 100644
--- a/arch/powerpc/sysdev/fsl_rcpm.c
+++ b/arch/powerpc/sysdev/fsl_rcpm.c
@@ -218,14 +218,15 @@ static void rcpm_v2_cpu_up_prepare(int cpu)
 	rcpm_v2_irq_unmask(cpu);
 }
 
-static int rcpm_v1_plat_enter_state(int state)
+static int rcpm_v1_plat_enter_sleep(int state)
 {
 	u32 *pmcsr_reg = &rcpm_v1_regs->powmgtcsr;
 	int ret = 0;
 	int result;
 
 	switch (state) {
-	case PLAT_PM_SLEEP:
+	case FSL_PM_SLEEP:
+		cur_cpu_spec->cpu_down_flush();
 		setbits32(pmcsr_reg, RCPM_POWMGTCSR_SLP);
 
 		/* Upon resume, wait for RCPM_POWMGTCSR_SLP bit to be clear. */
@@ -244,14 +245,15 @@ static int rcpm_v1_plat_enter_state(int state)
 	return ret;
 }
 
-static int rcpm_v2_plat_enter_state(int state)
+static int rcpm_v2_plat_enter_sleep(int state)
 {
 	u32 *pmcsr_reg = &rcpm_v2_regs->powmgtcsr;
 	int ret = 0;
 	int result;
 
 	switch (state) {
-	case PLAT_PM_LPM20:
+	case FSL_PM_SLEEP:
+		cur_cpu_spec->cpu_down_flush();
 		/* clear previous LPM20 status */
 		setbits32(pmcsr_reg, RCPM_POWMGTCSR_P_LPM20_ST);
 		/* enter LPM20 status */
@@ -275,16 +277,6 @@ static int rcpm_v2_plat_enter_state(int state)
 	return ret;
 }
 
-static int rcpm_v1_plat_enter_sleep(void)
-{
-	return rcpm_v1_plat_enter_state(PLAT_PM_SLEEP);
-}
-
-static int rcpm_v2_plat_enter_sleep(void)
-{
-	return rcpm_v2_plat_enter_state(PLAT_PM_LPM20);
-}
-
 static void rcpm_common_freeze_time_base(u32 *tben_reg, int freeze)
 {
 	static u32 mask;
-- 
1.9.1
