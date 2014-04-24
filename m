Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AEF4F140086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 16:14:29 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [PATCH v2 1/2] powerpc/pm: add api to get suspend state which is
 STANDBY or MEM
Date: Thu, 24 Apr 2014 14:11:48 +0800
Message-ID: <1398319908-30166-1-git-send-email-dongsheng.wang@freescale.com>
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

Add set_pm_suspend_state & pm_suspend_state functions to set/get
suspend state. When system going to sleep or deep sleep, devices
can get the system suspend state(STANDBY/MEM) through pm_suspend_state
function and to handle different situations.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v2*
Move pm api from fsl platform to powerpc general framework.

diff --git a/arch/powerpc/include/asm/pm.h b/arch/powerpc/include/asm/pm.h
new file mode 100644
index 0000000..00ddbf1
--- /dev/null
+++ b/arch/powerpc/include/asm/pm.h
@@ -0,0 +1,26 @@
+/*
+ * asm/pm.h
+ *
+ * Definitions for any platform related flags or structures for
+ * Power Management.
+ *
+ * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
+ *
+ * Copyright 2014 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef _POWERPC_PM_H_
+#define _POWERPC_PM_H_
+#ifdef __KERNEL__
+#include <linux/suspend.h>
+
+extern void set_pm_suspend_state(suspend_state_t state);
+extern suspend_state_t pm_suspend_state(void);
+
+#endif /* __KERNEL__ */
+#endif /* _POWERPC_PM_H_ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index fcc9a89..2060145 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -28,7 +28,7 @@ endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
-				   process.o systbl.o idle.o \
+				   process.o systbl.o idle.o pm.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o dma.o \
diff --git a/arch/powerpc/kernel/pm.c b/arch/powerpc/kernel/pm.c
new file mode 100644
index 0000000..23d3c94
--- /dev/null
+++ b/arch/powerpc/kernel/pm.c
@@ -0,0 +1,26 @@
+/*
+ * PowerPC General Power Management Implementation
+ *
+ * Copyright 2014 Freescale Semiconductor, Inc.
+ * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/suspend.h>
+#include <asm/pm.h>
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
diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
index 8cf4aa0..fd777ca 100644
--- a/arch/powerpc/sysdev/fsl_pmc.c
+++ b/arch/powerpc/sysdev/fsl_pmc.c
@@ -21,6 +21,8 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 
+#include <asm/pm.h>
+
 struct pmc_regs {
 	__be32 devdisr;
 	__be32 devdisr2;
@@ -52,12 +54,20 @@ static int pmc_suspend_valid(suspend_state_t state)
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
@@ -68,6 +78,7 @@ static int pmc_probe(struct platform_device *ofdev)
 
 	pmc_dev = &ofdev->dev;
 	suspend_set_ops(&pmc_suspend_ops);
+	set_pm_suspend_state(PM_SUSPEND_ON);
 	return 0;
 }
 
-- 
1.8.5
