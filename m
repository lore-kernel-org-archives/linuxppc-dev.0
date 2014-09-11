Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0028C1A0127
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 20:14:32 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 11 Sep 2014 15:44:26 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6B15F394004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 15:44:22 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8BAGggQ61604008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 15:46:42 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8BAEK2L008824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 15:44:21 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: viresh.kumar@linaro.org, benh@kernel.crashing.org
Subject: [PATCH v3] cpufreq: powernv: Set the cpus to nominal frequency during
 reboot/kexec
Date: Thu, 11 Sep 2014 15:43:43 +0530
Message-Id: <1410430423-1246-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 David.Laight@ACULAB.COM, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 preeti@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch ensures the cpus to kexec/reboot at nominal frequency.
Nominal frequency is the highest cpu frequency on PowerPC at
which the cores can run without getting throttled.

If the host kernel had set the cpus to a low pstate and then it
kexecs/reboots to a cpufreq disabled kernel it would cause the target
kernel to perform poorly. It will also increase the boot up time of
the target kernel. So set the cpus to high pstate, in this case to
nominal frequency before rebooting to avoid such scenarios.

The reboot notifier will set the cpus to nominal frequncy.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Changes v2->v3:
We return EBUSY when cpufreq governor tries to change the frequency
after rebooting is set to true. This results in console being flushed
with error messages indicating failed attempts to change the
frequency. So instead of returning EBUSY we return 0 to stop the
governor from changing the frequency without alerting a failure to 
do the same on reboot, as this  is not an errorneaos condition.

Changes v1->v2:
Invoke .target() driver callback to set the cpus to nominal frequency
in reboot notifier, instead of calling cpufreq_suspend() as suggested
by Viresh Kumar.
Modified the commit message.

 drivers/cpufreq/powernv-cpufreq.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 379c083..f772a55 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -26,6 +26,7 @@
 #include <linux/cpufreq.h>
 #include <linux/smp.h>
 #include <linux/of.h>
+#include <linux/reboot.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -35,6 +36,7 @@
 #define POWERNV_MAX_PSTATES	256
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
+static bool rebooting;
 
 /*
  * Note: The set of pstates consists of contiguous integers, the
@@ -284,6 +286,15 @@ static void set_pstate(void *freq_data)
 }
 
 /*
+ * get_nominal_index: Returns the index corresponding to the nominal
+ * pstate in the cpufreq table
+ */
+static inline unsigned int get_nominal_index(void)
+{
+	return powernv_pstate_info.max - powernv_pstate_info.nominal;
+}
+
+/*
  * powernv_cpufreq_target_index: Sets the frequency corresponding to
  * the cpufreq table entry indexed by new_index on the cpus in the
  * mask policy->cpus
@@ -293,6 +304,9 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 {
 	struct powernv_smp_call_data freq_data;
 
+	if (unlikely(rebooting) && new_index != get_nominal_index())
+		return 0;
+
 	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
 	/*
@@ -317,6 +331,25 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, powernv_freqs);
 }
 
+static int powernv_cpufreq_reboot_notifier(struct notifier_block *nb,
+				unsigned long action, void *unused)
+{
+	int cpu;
+	struct cpufreq_policy cpu_policy;
+
+	rebooting = true;
+	for_each_online_cpu(cpu) {
+		cpufreq_get_policy(&cpu_policy, cpu);
+		powernv_cpufreq_target_index(&cpu_policy, get_nominal_index());
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block powernv_cpufreq_reboot_nb = {
+	.notifier_call = powernv_cpufreq_reboot_notifier,
+};
+
 static struct cpufreq_driver powernv_cpufreq_driver = {
 	.name		= "powernv-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
@@ -342,12 +375,14 @@ static int __init powernv_cpufreq_init(void)
 		return rc;
 	}
 
+	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	return cpufreq_register_driver(&powernv_cpufreq_driver);
 }
 module_init(powernv_cpufreq_init);
 
 static void __exit powernv_cpufreq_exit(void)
 {
+	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	cpufreq_unregister_driver(&powernv_cpufreq_driver);
 }
 module_exit(powernv_cpufreq_exit);
-- 
1.9.3
