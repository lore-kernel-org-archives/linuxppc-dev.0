Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9ECE2C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 16:33:42 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 3 Jul 2012 06:24:01 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q636X1hr36700254
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2012 16:33:01 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q636X1AE003220
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2012 16:33:01 +1000
Message-ID: <4FF29219.10608@linux.vnet.ibm.com>
Date: Tue, 03 Jul 2012 12:02:57 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] cpuidle: (POWER) Replace pseries_notify_cpuidle_add call
 with a notifier to fix lockdep problem in start_secondary
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpuidle: (POWER) Replace pseries_notify_cpuidle_add call with a notifier to fix lockdep problem in start_secondary

From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

Currently the call to pseries_notify_cpuidle_add(), that takes
action on the cpuidle front when a cpu is added/removed
is being made from smp_xics_setup_cpu().
This works fine when the cpus were hot added/removed once the
system is up but causes lockdep issues as
reported https://lkml.org/lkml/2012/5/17/2
during the time of boot.

During boot, on addition of each cpu,
resources were cleared and re-allocated each time, all in critical
section as part of start_secondary() which had interrupts disabled.
To resolve this issue, replacing the pseries_notify_cpuidle_add_cpu() call
with a hotplug notifier.  This would prevent cpuidle resources from being
released and allocated each time cpu is onlined during pseries bootup.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

---
This patch has in-corporated review comments
received on the earlier version posted.
	v1 ->  https://lkml.org/lkml/2012/5/18/174
This applies on 3.5-rc5
---
 arch/powerpc/include/asm/processor.h            |    2 -
 arch/powerpc/platforms/pseries/processor_idle.c |   35 ++++++++++++++++++++---
 arch/powerpc/platforms/pseries/smp.c            |    1 -
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 413a5ea..53b6dfa 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -389,10 +389,8 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 
 #ifdef CONFIG_PSERIES_IDLE
 extern void update_smt_snooze_delay(int snooze);
-extern int pseries_notify_cpuidle_add_cpu(int cpu);
 #else
 static inline void update_smt_snooze_delay(int snooze) {}
-static inline int pseries_notify_cpuidle_add_cpu(int cpu) { return 0; }
 #endif
 
 extern void flush_instruction_cache(void);
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index e61483e..da245c0 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -186,17 +186,40 @@ static struct cpuidle_state shared_states[MAX_IDLE_STATE_COUNT] = {
 		.enter = &shared_cede_loop },
 };
 
-int pseries_notify_cpuidle_add_cpu(int cpu)
+static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
+			unsigned long action, void *hcpu)
 {
+	int hotcpu = (unsigned long)hcpu;
 	struct cpuidle_device *dev =
-			per_cpu_ptr(pseries_cpuidle_devices, cpu);
+			per_cpu_ptr(pseries_cpuidle_devices, hotcpu);
+
 	if (dev && cpuidle_get_driver()) {
-		cpuidle_disable_device(dev);
-		cpuidle_enable_device(dev);
+		switch (action) {
+		case CPU_ONLINE:
+		case CPU_ONLINE_FROZEN:
+			cpuidle_pause_and_lock();
+			cpuidle_enable_device(dev);
+			cpuidle_resume_and_unlock();
+			break;
+
+		case CPU_DEAD:
+		case CPU_DEAD_FROZEN:
+			cpuidle_pause_and_lock();
+			cpuidle_disable_device(dev);
+			cpuidle_resume_and_unlock();
+			break;
+
+		default:
+			return NOTIFY_DONE;
+		}
 	}
-	return 0;
+	return NOTIFY_OK;
 }
 
+static struct notifier_block setup_hotplug_notifier = {
+	.notifier_call = pseries_cpuidle_add_cpu_notifier,
+};
+
 /*
  * pseries_cpuidle_driver_init()
  */
@@ -321,6 +344,7 @@ static int __init pseries_processor_idle_init(void)
 		return retval;
 	}
 
+	register_cpu_notifier(&setup_hotplug_notifier);
 	printk(KERN_DEBUG "pseries_idle_driver registered\n");
 
 	return 0;
@@ -329,6 +353,7 @@ static int __init pseries_processor_idle_init(void)
 static void __exit pseries_processor_idle_exit(void)
 {
 
+	unregister_cpu_notifier(&setup_hotplug_notifier);
 	pseries_idle_devices_uninit();
 	cpuidle_unregister_driver(&pseries_idle_driver);
 
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index e16bb8d..71706bc 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -147,7 +147,6 @@ static void __devinit smp_xics_setup_cpu(int cpu)
 	set_cpu_current_state(cpu, CPU_STATE_ONLINE);
 	set_default_offline_state(cpu);
 #endif
-	pseries_notify_cpuidle_add_cpu(cpu);
 }
 
 static int __devinit smp_pSeries_kick_cpu(int nr)
