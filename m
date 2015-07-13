Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EBD21A19B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 00:11:31 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5AB121402D7
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2015 00:11:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 14 Jul 2015 00:11:30 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 999652CE8040
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2015 00:11:27 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6DEBJIZ28311698
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2015 00:11:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6DEAtpf009912
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2015 00:10:55 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 6/6] cpufreq: powernv: Restore cpu frequency to policy->cur
 on unthrottling
Date: Mon, 13 Jul 2015 19:40:02 +0530
Message-Id: <1436796602-10228-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
---
Changes from v3:
- Refer to the members of 'struct opal_occ_msg' in the patch.
  Replace 'reason' with 'omsg.throttle_status'

 drivers/cpufreq/powernv-cpufreq.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index d6d7e68..824141a 100644
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
@@ -466,8 +487,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			throttled = false;
 			pr_info("OCC: Active\n");
 
-			for (i = 0; i < nr_chips; i++)
+			for (i = 0; i < nr_chips; i++) {
+				chips[i].restore = true;
 				schedule_work(&chips[i].throttle);
+			}
 
 			return 0;
 		}
@@ -484,8 +507,11 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
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
@@ -539,6 +565,7 @@ static int init_chip_info(void)
 		chips[i].throttled = false;
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
+		chips[i].restore = false;
 	}
 
 	return 0;
-- 
1.9.3
