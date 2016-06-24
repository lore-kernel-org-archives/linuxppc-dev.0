Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbg6J6YBWzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 00:03:35 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5ODwv2S058054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 10:03:32 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23rskwrufy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 10:03:32 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Fri, 24 Jun 2016 19:33:29 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5F520125804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 19:36:03 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5OE2auH1769802
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 19:32:36 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5OE3HW5022883
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 19:33:19 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Replacing pstate_id with frequency table
 index
Date: Fri, 24 Jun 2016 19:33:07 +0530
Message-Id: <1466776987-19031-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refactoring code to use frequency table index instead of pstate_id.
This abstraction will make the code independent of the pstate values.

- No functional changes
- The highest frequency is at frequency table index 0 and the frequency
  decreases as the index increases.
- Macros get_index() and get_pstate() can be used for conversion between
  pstate_id and index.
- powernv_pstate_info now contains frequency table index to min, max and
  nominal frequency (instead of pstate_ids)

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 107 ++++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 46 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index b29c5c2..f6ce6f0 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -43,6 +43,7 @@
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
 #define PMSR_MAX(x)		((x >> 32) & 0xFF)
 
+
 #define MAX_RAMP_DOWN_TIME				5120
 /*
  * On an idle system we want the global pstate to ramp-down from max value to
@@ -124,20 +125,29 @@ static int nr_chips;
 static DEFINE_PER_CPU(struct chip *, chip_info);
 
 /*
- * Note: The set of pstates consists of contiguous integers, the
- * smallest of which is indicated by powernv_pstate_info.min, the
- * largest of which is indicated by powernv_pstate_info.max.
+ * Note: The set of pstates consists of contiguous integers,
+ *
+ * powernv_pstate_info stores the index of the frequency table
+ *  instead of pstate itself for each of the pstates referred
  *
  * The nominal pstate is the highest non-turbo pstate in this
  * platform. This is indicated by powernv_pstate_info.nominal.
  */
 static struct powernv_pstate_info {
-	int min;
-	int max;
-	int nominal;
-	int nr_pstates;
+	unsigned int min;
+	unsigned int max;
+	unsigned int nominal;
+	unsigned int nr_pstates;
 } powernv_pstate_info;
 
+/* Use following macros for conversions between pstate_id and index */
+static inline int get_pstate(unsigned int i) {
+	return powernv_freqs[i].driver_data;
+}
+static inline unsigned int get_index(int pstate) {
+	return abs(pstate - get_pstate(powernv_pstate_info.max));
+}
+
 static inline void reset_gpstates(struct cpufreq_policy *policy)
 {
 	struct global_pstate_info *gpstates = policy->driver_data;
@@ -208,23 +218,28 @@ static int init_powernv_pstates(void)
 		return -ENODEV;
 	}
 
+	powernv_pstate_info.nr_pstates = nr_pstates;
 	pr_debug("NR PStates %d\n", nr_pstates);
 	for (i = 0; i < nr_pstates; i++) {
 		u32 id = be32_to_cpu(pstate_ids[i]);
 		u32 freq = be32_to_cpu(pstate_freqs[i]);
 
-		pr_debug("PState id %d freq %d MHz\n", id, freq);
 		powernv_freqs[i].frequency = freq * 1000; /* kHz */
 		powernv_freqs[i].driver_data = id;
+
+		if (id == pstate_max)
+			powernv_pstate_info.max = i;
+		else if (id == pstate_nominal)
+			powernv_pstate_info.nominal = i;
+		else if (id == pstate_min)
+			powernv_pstate_info.min = i;
 	}
+
+	pr_info("pstate_info: min %d nominal %d max %d\n",
+		powernv_pstate_info.min, powernv_pstate_info.nominal,
+		powernv_pstate_info.max);
 	/* End of list marker entry */
 	powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
-
-	powernv_pstate_info.min = pstate_min;
-	powernv_pstate_info.max = pstate_max;
-	powernv_pstate_info.nominal = pstate_nominal;
-	powernv_pstate_info.nr_pstates = nr_pstates;
-
 	return 0;
 }
 
@@ -233,15 +248,15 @@ static unsigned int pstate_id_to_freq(int pstate_id)
 {
 	int i;
 
-	i = powernv_pstate_info.max - pstate_id;
+	i = get_index(pstate_id);
 	if (i >= powernv_pstate_info.nr_pstates || i < 0) {
 		pr_warn("PState id %d outside of PState table, "
 			"reporting nominal id %d instead\n",
 			pstate_id, powernv_pstate_info.nominal);
-		i = powernv_pstate_info.max - powernv_pstate_info.nominal;
+		i = powernv_pstate_info.nominal;
 	}
 
-	return powernv_freqs[i].frequency;
+	return get_pstate(i);
 }
 
 /*
@@ -252,7 +267,7 @@ static ssize_t cpuinfo_nominal_freq_show(struct cpufreq_policy *policy,
 					char *buf)
 {
 	return sprintf(buf, "%u\n",
-		pstate_id_to_freq(powernv_pstate_info.nominal));
+		get_pstate(powernv_pstate_info.nominal));
 }
 
 struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
@@ -426,7 +441,7 @@ static void set_pstate(void *data)
  */
 static inline unsigned int get_nominal_index(void)
 {
-	return powernv_pstate_info.max - powernv_pstate_info.nominal;
+	return powernv_pstate_info.nominal;
 }
 
 static void powernv_cpufreq_throttle_check(void *data)
@@ -434,20 +449,21 @@ static void powernv_cpufreq_throttle_check(void *data)
 	struct chip *chip;
 	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
-	int pmsr_pmax;
+	int pmsr_pmax, pmsr_pmax_idx;
 
 	pmsr = get_pmspr(SPRN_PMSR);
 	chip = this_cpu_read(chip_info);
 
 	/* Check for Pmax Capping */
 	pmsr_pmax = (s8)PMSR_MAX(pmsr);
-	if (pmsr_pmax != powernv_pstate_info.max) {
+	pmsr_pmax_idx = get_index(pmsr_pmax);
+	if (pmsr_pmax_idx != powernv_pstate_info.max) {
 		if (chip->throttled)
 			goto next;
 		chip->throttled = true;
-		if (pmsr_pmax < powernv_pstate_info.nominal) {
-			pr_warn_once("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
-				     cpu, chip->id, pmsr_pmax,
+		if (pmsr_pmax_idx > powernv_pstate_info.nominal) {
+			pr_warn_once("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d > %d)\n",
+				     cpu, chip->id, pmsr_pmax_idx,
 				     powernv_pstate_info.nominal);
 			chip->throttle_sub_turbo++;
 		} else {
@@ -505,13 +521,13 @@ static inline int calc_global_pstate(unsigned int elapsed_time,
 	 * 5 seconds, then just scale it get the number pstates to be dropped.
 	 */
 	pstate_diff =  ((int)ramp_down_percent(elapsed_time) *
-			(highest_lpstate - powernv_pstate_info.min)) / 100;
+			(powernv_pstate_info.min - highest_lpstate)) / 100;
 
 	/* Ensure that global pstate is >= to local pstate */
-	if (highest_lpstate - pstate_diff < local_pstate)
+	if (highest_lpstate + pstate_diff >= local_pstate)
 		return local_pstate;
 	else
-		return highest_lpstate - pstate_diff;
+		return highest_lpstate + pstate_diff;
 }
 
 static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
@@ -582,7 +598,6 @@ void gpstate_timer_handler(unsigned long data)
 	gpstates->last_lpstate = freq_data.pstate_id;
 
 	spin_unlock(&gpstates->gpstate_lock);
-
 	/* Timer may get migrated to a different cpu on cpu hot unplug */
 	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
 }
@@ -596,7 +611,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 					unsigned int new_index)
 {
 	struct powernv_smp_call_data freq_data;
-	unsigned int cur_msec, gpstate_id;
+	unsigned int cur_msec, gpstate_idx;
 	struct global_pstate_info *gpstates = policy->driver_data;
 
 	if (unlikely(rebooting) && new_index != get_nominal_index())
@@ -608,15 +623,15 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	cur_msec = jiffies_to_msecs(get_jiffies_64());
 
 	spin_lock(&gpstates->gpstate_lock);
-	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
+	freq_data.pstate_id = get_pstate(new_index);
 
 	if (!gpstates->last_sampled_time) {
-		gpstate_id = freq_data.pstate_id;
-		gpstates->highest_lpstate = freq_data.pstate_id;
+		gpstate_idx = new_index;
+		gpstates->highest_lpstate = new_index;
 		goto gpstates_done;
 	}
 
-	if (gpstates->last_gpstate > freq_data.pstate_id) {
+	if (gpstates->last_gpstate < new_index) {
 		gpstates->elapsed_time += cur_msec -
 						 gpstates->last_sampled_time;
 
@@ -627,34 +642,34 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 		 */
 		if (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME) {
 			reset_gpstates(policy);
-			gpstates->highest_lpstate = freq_data.pstate_id;
-			gpstate_id = freq_data.pstate_id;
+			gpstates->highest_lpstate = new_index;
+			gpstate_idx = new_index;
 		} else {
 		/* Elaspsed_time is less than 5 seconds, continue to rampdown */
-			gpstate_id = calc_global_pstate(gpstates->elapsed_time,
-							gpstates->highest_lpstate,
-							freq_data.pstate_id);
+			gpstate_idx = calc_global_pstate(gpstates->elapsed_time,
+							 gpstates->highest_lpstate,
+							 new_index);
 		}
 	} else {
 		reset_gpstates(policy);
-		gpstates->highest_lpstate = freq_data.pstate_id;
-		gpstate_id = freq_data.pstate_id;
+		gpstates->highest_lpstate = new_index;
+		gpstate_idx = new_index;
 	}
 
 	/*
 	 * If local pstate is equal to global pstate, rampdown is over
 	 * So timer is not required to be queued.
 	 */
-	if (gpstate_id != freq_data.pstate_id)
+	if (gpstate_idx != new_index)
 		queue_gpstate_timer(gpstates);
 	else
 		del_timer_sync(&gpstates->timer);
 
 gpstates_done:
-	freq_data.gpstate_id = gpstate_id;
+	freq_data.gpstate_id = get_pstate(gpstate_idx);
 	gpstates->last_sampled_time = cur_msec;
-	gpstates->last_gpstate = freq_data.gpstate_id;
-	gpstates->last_lpstate = freq_data.pstate_id;
+	gpstates->last_gpstate = gpstate_idx;
+	gpstates->last_lpstate = new_index;
 
 	spin_unlock(&gpstates->gpstate_lock);
 
@@ -847,8 +862,8 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 	struct powernv_smp_call_data freq_data;
 	struct global_pstate_info *gpstates = policy->driver_data;
 
-	freq_data.pstate_id = powernv_pstate_info.min;
-	freq_data.gpstate_id = powernv_pstate_info.min;
+	freq_data.pstate_id = get_pstate(powernv_pstate_info.min);
+	freq_data.gpstate_id = get_pstate(powernv_pstate_info.min);
 	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
 	del_timer_sync(&gpstates->timer);
 }
-- 
2.7.0
