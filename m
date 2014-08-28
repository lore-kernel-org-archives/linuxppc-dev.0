Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2DC71A0788
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 00:07:26 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 28 Aug 2014 19:37:22 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 62F56125804D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Aug 2014 19:37:38 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7SE7ers57540762
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Aug 2014 19:37:41 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7SE7GAe008755
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Aug 2014 19:37:16 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: viresh.kumar@linaro.org, benh@kernel.crashing.org
Subject: [PATCH v2] cpufreq: powernv: Set the cpus to nominal frequency during
 reboot/kexec
Date: Thu, 28 Aug 2014 19:36:56 +0530
Message-Id: <1409234816-10802-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, preeti@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
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

Changes v1->v2:
Invoke .target() driver callback to set the cpus to nominal frequency
in reboot notifier, instead of calling cpufreq_suspend() as suggested
by Viresh Kumar.
Modified the commit message.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 379c083..ba27c49 100644
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
+		return -EBUSY;
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
