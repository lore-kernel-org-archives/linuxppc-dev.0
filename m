Return-Path: <Dongsheng.Wang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3DF641400B5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 12:26:39 +1000 (EST)
Received: from mail77-ch1 (localhost [127.0.0.1])	by mail77-ch1-R.bigfish.com
 (Postfix) with ESMTP id 6D472E01BE	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 14 Apr 2014 02:26:00 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 1/2] powerpc/mpc85xx: add two functions to get suspend state
 which is standby or mem
Date: Mon, 14 Apr 2014 10:24:09 +0800
Message-ID: <1397442250-14886-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 jason.jin@freescale.com, Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Add set_pm_suspend_state & pm_suspend_state functions to set/get suspend state.
When system going to sleep, devices can get the system suspend state(STANDBY/MEM)
through pm_suspend_state function and handle different situations.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index b564b5e..3853d43 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -8,6 +8,7 @@
 
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/suspend.h>
 
 #include <asm/qe.h>
 #include <sysdev/cpm2_pic.h>
@@ -47,6 +48,19 @@ int __init mpc85xx_common_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, mpc85xx_common_ids, NULL);
 }
+
+static suspend_state_t pm_state;
+
+void set_pm_suspend_state(suspend_state_t state)
+{
+	pm_state = state;
+}
+
+suspend_state_t pm_suspend_state(void)
+{
+	return pm_state;
+}
+
 #ifdef CONFIG_CPM2
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
index 8cf4aa0..0b34c00 100644
--- a/arch/powerpc/sysdev/fsl_pmc.c
+++ b/arch/powerpc/sysdev/fsl_pmc.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/fsl/fsl_pm.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -52,12 +53,20 @@ static int pmc_suspend_valid(suspend_state_t state)
 {
 	if (state != PM_SUSPEND_STANDBY)
 		return 0;
+
+	set_pm_suspend_state(state);
 	return 1;
 }
 
+static void pmc_suspend_end(void)
+{
+	set_pm_suspend_state(PM_SUSPEND_ON);
+}
+
 static const struct platform_suspend_ops pmc_suspend_ops = {
 	.valid = pmc_suspend_valid,
 	.enter = pmc_suspend_enter,
+	.end	= pmc_suspend_end,
 };
 
 static int pmc_probe(struct platform_device *ofdev)
@@ -68,6 +77,7 @@ static int pmc_probe(struct platform_device *ofdev)
 
 	pmc_dev = &ofdev->dev;
 	suspend_set_ops(&pmc_suspend_ops);
+	set_pm_suspend_state(PM_SUSPEND_ON);
 	return 0;
 }
 
diff --git a/include/linux/fsl/fsl_pm.h b/include/linux/fsl/fsl_pm.h
new file mode 100644
index 0000000..705ea52
--- /dev/null
+++ b/include/linux/fsl/fsl_pm.h
@@ -0,0 +1,25 @@
+/*
+ * include/linux/fsl/fsl_pm.h
+ *
+ * Definitions for any platform related flags or structures for Freescale
+ * Power Management.
+ *
+ * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
+ *
+ * Copyright 2014 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/suspend.h>
+
+#ifdef CONFIG_FSL_SOC_BOOKE
+extern void set_pm_suspend_state(suspend_state_t state);
+extern suspend_state_t pm_suspend_state(void);
+#else
+static inline void set_pm_suspend_state(suspend_state_t state) { }
+static inline suspend_state_t pm_suspend_state(void) { }
+#endif
-- 
1.8.5
