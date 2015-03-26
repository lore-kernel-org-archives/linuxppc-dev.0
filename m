Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0114.outbound.protection.outlook.com [157.56.111.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90BD01A0144
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 21:51:19 +1100 (AEDT)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 4/4] powerpc/85xx: support sleep feature on QorIQ SoCs with
 RCPM
Date: Thu, 26 Mar 2015 18:18:15 +0800
Message-ID: <1427365095-26396-4-git-send-email-chenhui.zhao@freescale.com>
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

In sleep mode, the clocks of e500 cores and unused IP blocks is
turned off. The IP blocks which are allowed to wake up the processor
are still running.

The sleep mode is equal to the Standby state in Linux. Use the
command to enter sleep mode:
  echo standby > /sys/power/state

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/powerpc/Kconfig                   |  3 +-
 arch/powerpc/platforms/85xx/Kconfig    |  5 +++
 arch/powerpc/platforms/85xx/Makefile   |  1 +
 arch/powerpc/platforms/85xx/qoriq_pm.c | 59 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig    |  1 +
 5 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/qoriq_pm.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9846c83..162eb53 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -233,7 +233,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
+		   FSL_SOC_BOOKE || PPC_86xx || PPC_PSERIES \
 		   || 44x || 40x
 
 config PPC_DCR_NATIVE
@@ -747,7 +747,6 @@ config FSL_PCI
 
 config FSL_PMC
 	bool
-	default y
 	depends on SUSPEND && (PPC_85xx || PPC_86xx)
 	help
 	  Freescale MPC85xx/MPC86xx power management controller support
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index ae1b8a2..b7c762e 100644
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
index 1fe7fb9..65dfb60 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the PowerPC 85xx linux kernel.
 #
 obj-$(CONFIG_SMP) += smp.o
+obj-$(CONFIG_FSL_QORIQ_PM)	  += qoriq_pm.o
 
 obj-y += common.o
 
diff --git a/arch/powerpc/platforms/85xx/qoriq_pm.c b/arch/powerpc/platforms/85xx/qoriq_pm.c
new file mode 100644
index 0000000..7594f08
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/qoriq_pm.c
@@ -0,0 +1,59 @@
+/*
+ * Support Power Management feature
+ *
+ * Copyright 2014-2015 Freescale Semiconductor Inc.
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
+#include <linux/suspend.h>
+#include <linux/of_platform.h>
+
+#include <asm/fsl_pm.h>
+
+static int qoriq_suspend_enter(suspend_state_t state)
+{
+	int ret = 0;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		cur_cpu_spec->cpu_flush_caches();
+		ret = qoriq_pm_ops->plat_enter_sleep();
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
+	unsigned int pm_modes;
+
+	pm_modes = qoriq_pm_ops->get_pm_modes();
+
+	if ((state == PM_SUSPEND_STANDBY) && (pm_modes & FSL_PM_SLEEP))
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
+	suspend_set_ops(&qoriq_suspend_ops);
+
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
 
-- 
1.9.1
