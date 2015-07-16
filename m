Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 865771A0779
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 18:05:18 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 865701402A0
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 18:05:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 13:35:15 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4DA85E0073
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:39:00 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6G84iK241549988
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:46 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6G84gOT030709
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:43 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: joel@jms.id.au, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 6/6] cpufreq: powernv: Restore cpu frequency to policy->cur
 on unthrottling
Date: Thu, 16 Jul 2015 13:34:23 +0530
Message-Id: <1437033863-15864-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If frequency is throttled due to OCC reset then cpus will be in Psafe
frequency, so restore the frequency on all cpus to policy->cur when
OCCs are active again. And if frequency is throttled due to Pmax
capping then restore the frequency of all the cpus  in the chip on
unthrottling.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
No changes from v4

Changes from v3:
- Refer to the members of 'struct opal_occ_msg' in the patch.
  Replace 'reason' with 'omsg.throttle_status'

 drivers/cpufreq/powernv-cpufreq.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 90b4293..546e056 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -48,6 +48,7 @@ static struct chip {
 	bool throttled;
 	cpumask_t mask;
 	struct work_struct throttle;
+	bool restore;
 } *chips;
 
 static int nr_chips;
@@ -415,9 +416,29 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
+	unsigned int cpu;
+	cpumask_var_t mask;
 
 	smp_call_function_any(&chip->mask,
 			      powernv_cpufreq_throttle_check, NULL, 0);
+
+	if (!chip->restore)
+		return;
+
+	chip->restore = false;
+	cpumask_copy(mask, &chip->mask);
+	for_each_cpu_and(cpu, mask, cpu_online_mask) {
+		int index, tcpu;
+		struct cpufreq_policy policy;
+
+		cpufreq_get_policy(&policy, cpu);
+		cpufreq_frequency_table_target(&policy, policy.freq_table,
+					       policy.cur,
+					       CPUFREQ_RELATION_C, &index);
+		powernv_cpufreq_target_index(&policy, index);
+		for_each_cpu(tcpu, policy.cpus)
+			cpumask_clear_cpu(tcpu, mask);
+	}
 }
 
 static char throttle_reason[][30] = {
@@ -469,8 +490,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			throttled = false;
 			pr_info("OCC: Active\n");
 
-			for (i = 0; i < nr_chips; i++)
+			for (i = 0; i < nr_chips; i++) {
+				chips[i].restore = true;
 				schedule_work(&chips[i].throttle);
+			}
 
 			return 0;
 		}
@@ -487,8 +510,11 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			return 0;
 
 		for (i = 0; i < nr_chips; i++)
-			if (chips[i].id == omsg.chip)
+			if (chips[i].id == omsg.chip) {
+				if (!omsg.throttle_status)
+					chips[i].restore = true;
 				schedule_work(&chips[i].throttle);
+			}
 	}
 	return 0;
 }
@@ -542,6 +568,7 @@ static int init_chip_info(void)
 		chips[i].throttled = false;
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
+		chips[i].restore = false;
 	}
 
 	return 0;
-- 
1.9.3
