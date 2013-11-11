Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D50112C039E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:36:09 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Mon, 11 Nov 2013 15:36:08 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 32E932BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:36:05 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAB5IJpi4719036
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:18:20 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAB5a3Nt021596
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:36:04 +1100
Subject: [PATCH v8 5/7] POWER/cpuidle: Generic POWERPC-BOOK3S CPUIDLE driver
 supporting PSERIES.
To: benh@kernel.crashing.org, linux-pm@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Mon, 11 Nov 2013 11:05:47 +0530
Message-ID: <20131111053546.14797.61973.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131111053450.14797.75544.stgit@deepthi.in.ibm.com>
References: <20131111053450.14797.75544.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: b.zolnierkie@samsung.com, daniel.lezcano@linaro.org,
 dongsheng.wang@freescale.com, preeti@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch includes cleanup and refactoring of the
existing code to make the driver POWERPC-BOOK3S generic.
* Re-naming the functions from pseries to generic powerpc-book3s.
* Re-naming the backend driver from pseries_idle to
  powerpc_book3s_idle.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-powerpc-book3s.c |   32 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powerpc-book3s.c b/drivers/cpuidle/cpuidle-powerpc-book3s.c
index fe8ea0c..7b785ff 100644
--- a/drivers/cpuidle/cpuidle-powerpc-book3s.c
+++ b/drivers/cpuidle/cpuidle-powerpc-book3s.c
@@ -20,8 +20,8 @@
 #include <asm/runlatch.h>
 #include <asm/plpar_wrappers.h>
 
-struct cpuidle_driver pseries_idle_driver = {
-	.name             = "pseries_idle",
+struct cpuidle_driver powerpc_book3s_idle_driver = {
+	.name             = "powerpc_book3s_idle",
 	.owner            = THIS_MODULE,
 };
 
@@ -182,7 +182,7 @@ void update_smt_snooze_delay(int cpu, int residency)
 			drv->states[1].target_residency = residency;
 }
 
-static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
+static int powerpc_book3s_cpuidle_add_cpu_notifier(struct notifier_block *n,
 			unsigned long action, void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
@@ -213,16 +213,16 @@ static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
 }
 
 static struct notifier_block setup_hotplug_notifier = {
-	.notifier_call = pseries_cpuidle_add_cpu_notifier,
+	.notifier_call = powerpc_book3s_cpuidle_add_cpu_notifier,
 };
 
 /*
- * pseries_cpuidle_driver_init()
+ * powerpc_book3s_cpuidle_driver_init()
  */
-static int pseries_cpuidle_driver_init(void)
+static int powerpc_book3s_cpuidle_driver_init(void)
 {
 	int idle_state;
-	struct cpuidle_driver *drv = &pseries_idle_driver;
+	struct cpuidle_driver *drv = &powerpc_book3s_idle_driver;
 
 	drv->state_count = 0;
 	for (idle_state = 0; idle_state < max_idle_state; ++idle_state) {
@@ -241,10 +241,10 @@ static int pseries_cpuidle_driver_init(void)
 }
 
 /*
- * pseries_idle_probe()
+ * powerpc_book3s_idle_probe()
  * Choose state table for shared versus dedicated partition
  */
-static int pseries_idle_probe(void)
+static int powerpc_book3s_idle_probe(void)
 {
 
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
@@ -264,24 +264,24 @@ static int pseries_idle_probe(void)
 	return 0;
 }
 
-static int __init pseries_processor_idle_init(void)
+static int __init powerpc_book3s_processor_idle_init(void)
 {
 	int retval;
 
-	retval = pseries_idle_probe();
+	retval = powerpc_book3s_idle_probe();
 	if (retval)
 		return retval;
 
-	pseries_cpuidle_driver_init();
-	retval = cpuidle_register(&pseries_idle_driver, NULL);
+	powerpc_book3s_cpuidle_driver_init();
+	retval = cpuidle_register(&powerpc_book3s_idle_driver, NULL);
 	if (retval) {
-		printk(KERN_DEBUG "Registration of pseries driver failed.\n");
+		printk(KERN_DEBUG "Registration of powerpc_book3s_idle driver failed.\n");
 		return retval;
 	}
 
 	register_cpu_notifier(&setup_hotplug_notifier);
-	printk(KERN_DEBUG "pseries_idle_driver registered\n");
+	printk(KERN_DEBUG "powerpc_book3s_idle registered\n");
 	return 0;
 }
 
-device_initcall(pseries_processor_idle_init);
+device_initcall(powerpc_book3s_processor_idle_init);
