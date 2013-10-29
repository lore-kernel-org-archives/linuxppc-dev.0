Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6580F2C03A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:02:13 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 29 Oct 2013 16:32:10 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 61A381258051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:32:46 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9TB23ej28770342
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:32:03 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9TB25Xg011982
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:32:06 +0530
Subject: [PATCH V7 5/7] POWER/cpuidle: Generic POWER CPUIDLE driver
 supporting PSERIES.
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 29 Oct 2013 16:31:49 +0530
Message-ID: <20131029110148.31547.8944.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, scottwood@freescale.com,
 linux-pm@lists.linux-foundation.org
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
index e81c207..5b92242 100644
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
 
@@ -182,7 +182,7 @@ void update_smt_snooze_delay(int cpu, int residency)
 			drv->states[1].target_residency = residency;
 }
 
-static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
+static int power_cpuidle_add_cpu_notifier(struct notifier_block *n,
 			unsigned long action, void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
@@ -213,16 +213,16 @@ static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
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
@@ -241,10 +241,10 @@ static int pseries_cpuidle_driver_init(void)
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
@@ -264,24 +264,24 @@ static int pseries_idle_probe(void)
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
