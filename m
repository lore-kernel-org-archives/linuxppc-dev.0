Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B11BC2C01C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:32:25 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 23:53:07 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9170E1258052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 00:02:10 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7RIXv4w30081074
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 00:03:58 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7RIWHBS029544
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 00:02:18 +0530
Subject: [PATCH V6 5/7] POWER/cpuidle: Generic POWER CPUIDLE driver
 supporting PSERIES.
To: linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 28 Aug 2013 00:01:39 +0530
Message-ID: <20130827183137.18579.74586.stgit@deepthi.in.ibm.com>
In-Reply-To: <20130827183016.18579.16595.stgit@deepthi.in.ibm.com>
References: <20130827183016.18579.16595.stgit@deepthi.in.ibm.com>
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
existing code to make the driver POWER generic.
* Re-naming the functions from pseries to generic power.
* Re-naming the backend driver from pseries_idle to
  ibm-power-idle.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-ibm-power.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-ibm-power.c b/drivers/cpuidle/cpuidle-ibm-power.c
index 14ebdb4..162deda 100644
--- a/drivers/cpuidle/cpuidle-ibm-power.c
+++ b/drivers/cpuidle/cpuidle-ibm-power.c
@@ -20,8 +20,8 @@
 #include <asm/runlatch.h>
 #include <asm/plpar_wrappers.h>
 
-struct cpuidle_driver pseries_idle_driver = {
-	.name             = "pseries_idle",
+struct cpuidle_driver power_idle_driver = {
+	.name             = "ibm_power_idle",
 	.owner            = THIS_MODULE,
 };
 
@@ -178,7 +178,7 @@ void update_smt_snooze_delay(int cpu, int residency)
 			drv->states[1].target_residency = residency;
 }
 
-static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
+static int power_cpuidle_add_cpu_notifier(struct notifier_block *n,
 			unsigned long action, void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
@@ -209,16 +209,16 @@ static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
 }
 
 static struct notifier_block setup_hotplug_notifier = {
-	.notifier_call = pseries_cpuidle_add_cpu_notifier,
+	.notifier_call = power_cpuidle_add_cpu_notifier,
 };
 
 /*
- * pseries_cpuidle_driver_init()
+ * power_cpuidle_driver_init()
  */
-static int pseries_cpuidle_driver_init(void)
+static int power_cpuidle_driver_init(void)
 {
 	int idle_state;
-	struct cpuidle_driver *drv = &pseries_idle_driver;
+	struct cpuidle_driver *drv = &power_idle_driver;
 
 	drv->state_count = 0;
 	for (idle_state = 0; idle_state < max_idle_state; ++idle_state) {
@@ -237,10 +237,10 @@ static int pseries_cpuidle_driver_init(void)
 }
 
 /*
- * pseries_idle_probe()
+ * power_idle_probe()
  * Choose state table for shared versus dedicated partition
  */
-static int pseries_idle_probe(void)
+static int power_idle_probe(void)
 {
 
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
@@ -260,24 +260,24 @@ static int pseries_idle_probe(void)
 	return 0;
 }
 
-static int __init pseries_processor_idle_init(void)
+static int __init power_processor_idle_init(void)
 {
 	int retval;
 
-	retval = pseries_idle_probe();
+	retval = power_idle_probe();
 	if (retval)
 		return retval;
 
-	pseries_cpuidle_driver_init();
-	retval = cpuidle_register(&pseries_idle_driver, NULL);
+	power_cpuidle_driver_init();
+	retval = cpuidle_register(&power_idle_driver, NULL);
 	if (retval) {
-		printk(KERN_DEBUG "Registration of pseries driver failed.\n");
+		printk(KERN_DEBUG "Registration of ibm_power_idle driver failed.\n");
 		return retval;
 	}
 
 	register_cpu_notifier(&setup_hotplug_notifier);
-	printk(KERN_DEBUG "pseries_idle_driver registered\n");
+	printk(KERN_DEBUG "ibm_power_idle registered\n");
 	return 0;
 }
 
-device_initcall(pseries_processor_idle_init);
+device_initcall(power_processor_idle_init);
