Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTMQ805nQzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 03:55:11 +1100 (AEDT)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qTMQ70s9Sz9s0k
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2016 03:55:10 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 21 Mar 2016 22:25:06 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2LGsW0w3604908
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2016 22:24:33 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2LMNiGf031969
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2016 03:53:45 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
 rjw@rjwysocki.net, pc@us.ibm.com, shreyas@linux.vnet.ibm.com,
 anton@samba.org, mikey@neuling.org, shilpa.bhat@linux.vnet.ibm.com
Subject: [PATCH RESEND] cpufreq: powernv: Define per_cpu chip pointer to
 optimize hot-path
Date: Mon, 21 Mar 2016 22:24:52 +0530
Message-Id: <1458579292-27424-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Neuling <mikey@neuling.org>

"96c4726f01cd cpufreq: powernv: Remove cpu_to_chip_id() from hot-path"
introduced 'core_to_chip_map' array to cache the chip-id of all cores.
Replace this with per_cpu variable that stores the pointer to the
chip-array. This removes the linear lookup and provides a neater and
simpler solution.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
- Included S-o-b and ACK tags
- Added the commit id to the commit log

 drivers/cpufreq/powernv-cpufreq.c | 50 +++++++++++++--------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 50bf120..a00bcc2 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -44,7 +44,6 @@
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled, occ_reset;
-static unsigned int *core_to_chip_map;
 
 static const char * const throttle_reason[] = {
 	"No throttling",
@@ -65,6 +64,7 @@ static struct chip {
 } *chips;
 
 static int nr_chips;
+static DEFINE_PER_CPU(struct chip *, chip_info);
 
 /*
  * Note: The set of pstates consists of contiguous integers, the
@@ -324,34 +324,31 @@ static inline unsigned int get_nominal_index(void)
 
 static void powernv_cpufreq_throttle_check(void *data)
 {
+	struct chip *chip;
 	unsigned int cpu = smp_processor_id();
-	unsigned int chip_id = core_to_chip_map[cpu_core_index_of_thread(cpu)];
 	unsigned long pmsr;
-	int pmsr_pmax, i;
+	int pmsr_pmax;
 
 	pmsr = get_pmspr(SPRN_PMSR);
-
-	for (i = 0; i < nr_chips; i++)
-		if (chips[i].id == chip_id)
-			break;
+	chip = this_cpu_read(chip_info);
 
 	/* Check for Pmax Capping */
 	pmsr_pmax = (s8)PMSR_MAX(pmsr);
 	if (pmsr_pmax != powernv_pstate_info.max) {
-		if (chips[i].throttled)
+		if (chip->throttled)
 			goto next;
-		chips[i].throttled = true;
+		chip->throttled = true;
 		if (pmsr_pmax < powernv_pstate_info.nominal)
 			pr_warn_once("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
-				     cpu, chips[i].id, pmsr_pmax,
+				     cpu, chip->id, pmsr_pmax,
 				     powernv_pstate_info.nominal);
-		trace_powernv_throttle(chips[i].id,
-				      throttle_reason[chips[i].throttle_reason],
+		trace_powernv_throttle(chip->id,
+				      throttle_reason[chip->throttle_reason],
 				      pmsr_pmax);
-	} else if (chips[i].throttled) {
-		chips[i].throttled = false;
-		trace_powernv_throttle(chips[i].id,
-				      throttle_reason[chips[i].throttle_reason],
+	} else if (chip->throttled) {
+		chip->throttled = false;
+		trace_powernv_throttle(chip->id,
+				      throttle_reason[chip->throttle_reason],
 				      pmsr_pmax);
 	}
 
@@ -558,47 +555,34 @@ static int init_chip_info(void)
 	unsigned int chip[256];
 	unsigned int cpu, i;
 	unsigned int prev_chip_id = UINT_MAX;
-	cpumask_t cpu_mask;
-	int ret = -ENOMEM;
-
-	core_to_chip_map = kcalloc(cpu_nr_cores(), sizeof(unsigned int),
-				   GFP_KERNEL);
-	if (!core_to_chip_map)
-		goto out;
 
-	cpumask_copy(&cpu_mask, cpu_possible_mask);
-	for_each_cpu(cpu, &cpu_mask) {
+	for_each_possible_cpu(cpu) {
 		unsigned int id = cpu_to_chip_id(cpu);
 
 		if (prev_chip_id != id) {
 			prev_chip_id = id;
 			chip[nr_chips++] = id;
 		}
-		core_to_chip_map[cpu_core_index_of_thread(cpu)] = id;
-		cpumask_andnot(&cpu_mask, &cpu_mask, cpu_sibling_mask(cpu));
 	}
 
 	chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
 	if (!chips)
-		goto free_chip_map;
+		return -ENOMEM;
 
 	for (i = 0; i < nr_chips; i++) {
 		chips[i].id = chip[i];
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
+		for_each_cpu(cpu, &chips[i].mask)
+			per_cpu(chip_info, cpu) =  &chips[i];
 	}
 
 	return 0;
-free_chip_map:
-	kfree(core_to_chip_map);
-out:
-	return ret;
 }
 
 static inline void clean_chip_info(void)
 {
 	kfree(chips);
-	kfree(core_to_chip_map);
 }
 
 static inline void unregister_all_notifiers(void)
-- 
1.9.3
