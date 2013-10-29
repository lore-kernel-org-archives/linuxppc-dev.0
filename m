Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B0F6A2C03A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:01:52 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 29 Oct 2013 16:31:48 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DB98F1258053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:32:24 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9TB1hva40042580
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:31:43 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9TB1jKB016539
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:31:46 +0530
Subject: [PATCH V7 2/7] pseries/cpuidle: Use cpuidle_register() for
 initialisation.
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 29 Oct 2013 16:31:29 +0530
Message-ID: <20131029110127.31547.9773.stgit@deepthi.in.ibm.com>
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

This patch replaces the cpuidle driver and devices initialisation
calls with a single generic cpuidle_register() call
and also includes minor refactoring of the code around it.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-ibm-power.c |   80 +++++------------------------------
 1 file changed, 12 insertions(+), 68 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-ibm-power.c b/drivers/cpuidle/cpuidle-ibm-power.c
index a166e38..faf8cc1 100644
--- a/drivers/cpuidle/cpuidle-ibm-power.c
+++ b/drivers/cpuidle/cpuidle-ibm-power.c
@@ -1,5 +1,5 @@
 /*
- *  processor_idle - idle state cpuidle driver.
+ *  cpuidle-ibm-power - idle state cpuidle driver.
  *  Adapted from drivers/idle/intel_idle.c and
  *  drivers/acpi/processor_idle.c
  *
@@ -28,7 +28,6 @@ struct cpuidle_driver pseries_idle_driver = {
 #define MAX_IDLE_STATE_COUNT	2
 
 static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
-static struct cpuidle_device __percpu *pseries_cpuidle_devices;
 static struct cpuidle_state *cpuidle_state_table;
 
 static inline void idle_loop_prolog(unsigned long *in_purr)
@@ -56,13 +55,12 @@ static int snooze_loop(struct cpuidle_device *dev,
 			int index)
 {
 	unsigned long in_purr;
-	int cpu = dev->cpu;
 
 	idle_loop_prolog(&in_purr);
 	local_irq_enable();
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
-	while ((!need_resched()) && cpu_online(cpu)) {
+	while (!need_resched()) {
 		ppc64_runlatch_off();
 		HMT_low();
 		HMT_very_low();
@@ -191,7 +189,7 @@ static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
 {
 	int hotcpu = (unsigned long)hcpu;
 	struct cpuidle_device *dev =
-			per_cpu_ptr(pseries_cpuidle_devices, hotcpu);
+			per_cpu(cpuidle_devices, hotcpu);
 
 	if (dev && cpuidle_get_driver()) {
 		switch (action) {
@@ -248,50 +246,6 @@ static int pseries_cpuidle_driver_init(void)
 	return 0;
 }
 
-/* pseries_idle_devices_uninit(void)
- * unregister cpuidle devices and de-allocate memory
- */
-static void pseries_idle_devices_uninit(void)
-{
-	int i;
-	struct cpuidle_device *dev;
-
-	for_each_possible_cpu(i) {
-		dev = per_cpu_ptr(pseries_cpuidle_devices, i);
-		cpuidle_unregister_device(dev);
-	}
-
-	free_percpu(pseries_cpuidle_devices);
-	return;
-}
-
-/* pseries_idle_devices_init()
- * allocate, initialize and register cpuidle device
- */
-static int pseries_idle_devices_init(void)
-{
-	int i;
-	struct cpuidle_driver *drv = &pseries_idle_driver;
-	struct cpuidle_device *dev;
-
-	pseries_cpuidle_devices = alloc_percpu(struct cpuidle_device);
-	if (pseries_cpuidle_devices == NULL)
-		return -ENOMEM;
-
-	for_each_possible_cpu(i) {
-		dev = per_cpu_ptr(pseries_cpuidle_devices, i);
-		dev->state_count = drv->state_count;
-		dev->cpu = i;
-		if (cpuidle_register_device(dev)) {
-			printk(KERN_DEBUG \
-				"cpuidle_register_device %d failed!\n", i);
-			return -EIO;
-		}
-	}
-
-	return 0;
-}
-
 /*
  * pseries_idle_probe()
  * Choose state table for shared versus dedicated partition
@@ -299,9 +253,6 @@ static int pseries_idle_devices_init(void)
 static int pseries_idle_probe(void)
 {
 
-	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
-		return -ENODEV;
-
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
@@ -310,10 +261,13 @@ static int pseries_idle_probe(void)
 		return -EPERM;
 	}
 
-	if (lppaca_shared_proc(get_lppaca()))
-		cpuidle_state_table = shared_states;
-	else
-		cpuidle_state_table = dedicated_states;
+	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
+		if (lppaca_shared_proc(get_lppaca()))
+			cpuidle_state_table = shared_states;
+		else
+			cpuidle_state_table = dedicated_states;
+	} else
+		return -ENODEV;
 
 	return 0;
 }
@@ -327,22 +281,14 @@ static int __init pseries_processor_idle_init(void)
 		return retval;
 
 	pseries_cpuidle_driver_init();
-	retval = cpuidle_register_driver(&pseries_idle_driver);
+	retval = cpuidle_register(&pseries_idle_driver, NULL);
 	if (retval) {
 		printk(KERN_DEBUG "Registration of pseries driver failed.\n");
 		return retval;
 	}
 
-	retval = pseries_idle_devices_init();
-	if (retval) {
-		pseries_idle_devices_uninit();
-		cpuidle_unregister_driver(&pseries_idle_driver);
-		return retval;
-	}
-
 	register_cpu_notifier(&setup_hotplug_notifier);
 	printk(KERN_DEBUG "pseries_idle_driver registered\n");
-
 	return 0;
 }
 
@@ -350,9 +296,7 @@ static void __exit pseries_processor_idle_exit(void)
 {
 
 	unregister_cpu_notifier(&setup_hotplug_notifier);
-	pseries_idle_devices_uninit();
-	cpuidle_unregister_driver(&pseries_idle_driver);
-
+	cpuidle_unregister(&pseries_idle_driver);
 	return;
 }
 
