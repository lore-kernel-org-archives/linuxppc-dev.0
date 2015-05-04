Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0F351A0E2E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 19:00:33 +1000 (AEST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93E7B140295
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:33 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 4 May 2015 19:00:33 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 633E82BB0052
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:31 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4490NrB21561346
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 19:00:31 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t448xwtj023854
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 18:59:59 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] cpufreq: powernv: Restore cpu frequency to policy->cur
 on unthrottling
Date: Mon,  4 May 2015 14:24:12 +0530
Message-Id: <1430729652-14813-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
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
 drivers/cpufreq/powernv-cpufreq.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 0a59d5b..b2915bc 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -51,6 +51,7 @@ static struct chip {
 	bool throttled;
 	cpumask_t mask;
 	struct work_struct throttle;
+	bool restore;
 } *chips;
 
 static int nr_chips;
@@ -418,9 +419,29 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
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
@@ -473,8 +494,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			throttled = false;
 			pr_info("OCC: Active\n");
 
-			for (i = 0; i < nr_chips; i++)
+			for (i = 0; i < nr_chips; i++) {
+				chips[i].restore = true;
 				schedule_work(&chips[i].throttle);
+			}
 
 			return 0;
 		}
@@ -490,8 +513,11 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			return 0;
 
 		for (i = 0; i < nr_chips; i++)
-			if (chips[i].id == chip_id)
+			if (chips[i].id == chip_id) {
+				if (!reason)
+					chips[i].restore = true;
 				schedule_work(&chips[i].throttle);
+			}
 	}
 	return 0;
 }
@@ -545,6 +571,7 @@ static int init_chip_info(void)
 		chips[i].throttled = false;
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
+		chips[i].restore = false;
 	}
 
 	return 0;
-- 
1.9.3
