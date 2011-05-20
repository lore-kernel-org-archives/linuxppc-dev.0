Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA6B0B71C8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 17:51:41 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p4K7pEjm008653
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 17:51:14 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4K7pCDS1228828
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 17:51:14 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4K7pc2T003411
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 17:51:38 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/pmac: Update via-pmu to new syscore_ops
Date: Fri, 20 May 2011 17:51:14 +1000
Message-Id: <1305877875-23157-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This was left as a sysdev, breaking the build

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/via-pmu.c |   56 +++++++++---------------------------------
 1 files changed, 12 insertions(+), 44 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 8b021eb..6cccd60 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -40,7 +40,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/freezer.h>
 #include <linux/syscalls.h>
 #include <linux/suspend.h>
@@ -2527,12 +2527,9 @@ void pmu_blink(int n)
 #if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 int pmu_sys_suspended;
 
-static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
+static int pmu_syscore_suspend(void)
 {
-	if (state.event != PM_EVENT_SUSPEND || pmu_sys_suspended)
-		return 0;
-
-	/* Suspend PMU event interrupts */\
+	/* Suspend PMU event interrupts */
 	pmu_suspend();
 	pmu_sys_suspended = 1;
 
@@ -2544,12 +2541,12 @@ static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 	return 0;
 }
 
-static int pmu_sys_resume(struct sys_device *sysdev)
+static void pmu_syscore_resume(void)
 {
 	struct adb_request req;
 
 	if (!pmu_sys_suspended)
-		return 0;
+		return;
 
 	/* Tell PMU we are ready */
 	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
@@ -2562,50 +2559,21 @@ static int pmu_sys_resume(struct sys_device *sysdev)
 	/* Resume PMU event interrupts */
 	pmu_resume();
 	pmu_sys_suspended = 0;
-
-	return 0;
 }
 
-#endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
-
-static struct sysdev_class pmu_sysclass = {
-	.name = "pmu",
-};
-
-static struct sys_device device_pmu = {
-	.cls		= &pmu_sysclass,
-};
-
-static struct sysdev_driver driver_pmu = {
-#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
-	.suspend	= &pmu_sys_suspend,
-	.resume		= &pmu_sys_resume,
-#endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
+static struct syscore_ops pmu_syscore_ops = {
+	.suspend = pmu_syscore_suspend,
+	.resume = pmu_syscore_resume,
 };
 
-static int __init init_pmu_sysfs(void)
+static int pmu_syscore_register(void)
 {
-	int rc;
+	register_syscore_ops(&pmu_syscore_ops);
 
-	rc = sysdev_class_register(&pmu_sysclass);
-	if (rc) {
-		printk(KERN_ERR "Failed registering PMU sys class\n");
-		return -ENODEV;
-	}
-	rc = sysdev_register(&device_pmu);
-	if (rc) {
-		printk(KERN_ERR "Failed registering PMU sys device\n");
-		return -ENODEV;
-	}
-	rc = sysdev_driver_register(&pmu_sysclass, &driver_pmu);
-	if (rc) {
-		printk(KERN_ERR "Failed registering PMU sys driver\n");
-		return -ENODEV;
-	}
 	return 0;
 }
-
-subsys_initcall(init_pmu_sysfs);
+subsys_initcall(pmu_syscore_register);
+#endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
 
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_queue_request);
-- 
1.7.1
