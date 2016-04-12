Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkvzr4VVLzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 04:07:52 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 12 Apr 2016 23:37:48 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3CI7i0T10486252
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 23:37:44 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3CI7hpR026122
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 23:37:44 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 2/2] cpufreq: powernv: Ramp-down global pstate slower than
 local-pstate
Date: Tue, 12 Apr 2016 23:36:26 +0530
Message-Id: <1460484386-28389-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
In-Reply-To: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch brings down global pstate at a slower rate than the local
pstate. As the frequency transition latency from pmin to pmax is
observed to be in few millisecond granurality. It takes a performance
penalty during sudden frequency rampup. Hence by holding global pstates
higher than local pstate makes the subsequent rampups faster.

A global per policy structure is maintained to keep track of the global
and local pstate changes. The global pstate is brought down using a
parabolic equation. The ramp down time to pmin is set to 6 seconds. To
make sure that the global pstates are dropped at regular interval , a
timer is queued for every 2 seconds, which eventually brings the pstate
down to local pstate.

Iozone results show fairly consistent performance boost.
YCSB on redis shows improved Max latencies in most cases.

Iozone write/rewite test were made with filesizes 200704Kb and 401408Kb with
different record sizes . The following table shows IOoperations/sec with and
without patch.

Iozone Results ( in op/sec) ( mean over 3 iterations )
------------------------------------
file size-	   		with     	without
recordsize-IOtype      		patch    	patch 		 % change
----------------------------------------------------------------------
200704-1-SeqWrite		1616532 	1615425 	0.06
200704-1-Rewrite		2423195  	2303130 	5.21
200704-2-SeqWrite		1628577 	1602620 	1.61
200704-2-Rewrite		2428264  	2312154 	5.02
200704-4-SeqWrite		1617605 	1617182 	0.02
200704-4-Rewrite		2430524  	2351238 	3.37
200704-8-SeqWrite		1629478 	1600436 	1.81
200704-8-Rewrite		2415308  	2298136 	5.09
200704-16-SeqWrite		1619632 	1618250 	0.08
200704-16-Rewrite		2396650 	2352591 	1.87
200704-32-SeqWrite		1632544 	1598083 	2.15
200704-32-Rewrite		2425119 	2329743 	4.09
200704-64-SeqWrite		1617812 	1617235 	0.03
200704-64-Rewrite		2402021 	2321080 	3.48
200704-128-SeqWrite		1631998 	1600256 	1.98
200704-128-Rewrite		2422389		2304954 	5.09
200704-256 SeqWrite		1617065		1616962 	0.00
200704-256-Rewrite		2432539 	2301980 	5.67
200704-512-SeqWrite		1632599 	1598656 	2.12
200704-512-Rewrite		2429270		2323676 	4.54
200704-1024-SeqWrite		1618758		1616156 	0.16
200704-1024-Rewrite		2431631		2315889 	4.99
401408-1-SeqWrite		1631479  	1608132 	1.45
401408-1-Rewrite		2501550  	2459409 	1.71
401408-2-SeqWrite		1617095 	1626069 	-0.55
401408-2-Rewrite		2507557  	2443621 	2.61
401408-4-SeqWrite		1629601 	1611869		1.10
401408-4-Rewrite		2505909  	2462098 	1.77
401408-8-SeqWrite  		1617110 	1626968 	-0.60
401408-8-Rewrite		2512244  	2456827 	2.25
401408-16-SeqWrite		1632609 	1609603 	1.42
401408-16-Rewrite		2500792 	2451405 	2.01
401408-32-SeqWrite		1619294 	1628167 	-0.54
401408-32-Rewrite		2510115		2451292 	2.39
401408-64-SeqWrite		1632709		1603746 	1.80
401408-64-Rewrite		2506692 	2433186 	3.02
401408-128-SeqWrite		1619284		1627461 	-0.50
401408-128-Rewrite		2518698 	2453361 	2.66
401408-256-SeqWrite		1634022 	1610681 	1.44
401408-256-Rewrite		2509987 	2446328 	2.60
401408-512-SeqWrite 		1617524 	1628016 	-0.64
401408-512-Rewrite		2504409 	2442899 	2.51
401408-1024-SeqWrite		1629812 	1611566 	1.13
401408-1024-Rewrite 		2507620		 2442968 	2.64

Tested with YCSB workloada over redis for 1 million records and 1 million
operation. Each test was carried out with target operations per second and
persistence disabled. 

Max-latency (in us)( mean over 5 iterations )
-----------------------------------------------------------
op/s	Operation	with patch	without patch	%change
------------------------------------------------------------
15000	Read		61480.6		50261.4		22.32
15000	cleanup		215.2		293.6		-26.70
15000	update		25666.2		25163.8		2.00

25000	Read		32626.2		89525.4		-63.56
25000	cleanup		292.2		263.0		11.10
25000	update		32293.4		90255.0		-64.22

35000	Read		34783.0		33119.0		5.02
35000	cleanup		321.2		395.8		-18.8
35000	update		36047.0		38747.8		-6.97

40000	Read		38562.2		42357.4		-8.96
40000	cleanup		371.8		384.6		-3.33
40000	update		27861.4		41547.8		-32.94

45000	Read		42271.0		88120.6		-52.03
45000	cleanup		263.6		383.0		-31.17
45000	update		29755.8		81359.0		-63.43

(test without target op/s)
47659	Read		83061.4		136440.6	-39.12
47659	cleanup		195.8		193.8		1.03
47659	update		73429.4		124971.8	-41.24

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 239 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 237 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index e2e2219..288fa10 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -36,12 +36,58 @@
 #include <asm/reg.h>
 #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
 #include <asm/opal.h>
+#include <linux/timer.h>
 
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
 #define PMSR_MAX(x)		((x >> 32) & 0xFF)
 
+/*
+ * Quadratic equation which gives the percentage rampdown for time elapsed in
+ * milliseconds. time can be between 0 and MAX_RAMP_DOWN_TIME ( milliseconds )
+ * This equation approximates to y = -4e-6 x^2
+ *
+ * At 0 seconds x=0000 ramp_down_percent=0
+ * At MAX_RAMP_DOWN_TIME x=5120 ramp_down_percent=100
+ */
+#define MAX_RAMP_DOWN_TIME				5120
+#define ramp_down_percent(time)		((time * time)>>18)
+
+/*Interval after which the timer is queued to bring down global pstate*/
+#define GPSTATE_TIMER_INTERVAL				2000
+/*
+ * global_pstate_info :
+ *	per policy data structure to maintain history of global pstates
+ *
+ * @highest_lpstate : the local pstate from which we are ramping down
+ * @elapsed_time : time in ms spent in ramping down from highest_lpstate
+ * @last_sampled_time : time from boot in ms when global pstates were last set
+ * @last_lpstate , last_gpstate : last set values for local and global pstates
+ * @timer : is used for ramping down if cpu goes idle for a long time with
+ *	global pstate held high
+ * @gpstate_lock : a spinlock to maintain synchronization between routines
+ *	called by the timer handler and governer's target_index calls
+ */
+struct global_pstate_info {
+	int highest_lpstate;
+	unsigned int elapsed_time;
+	unsigned int last_sampled_time;
+	int last_lpstate;
+	int last_gpstate;
+	spinlock_t gpstate_lock;
+	struct timer_list timer;
+};
+
+/*
+ * While resetting we don't want "timer" fields to be set to zero as we
+ * may lose track of timer and will not be able to cleanly remove it
+ */
+#define reset_gpstates(policy)   memset(policy->driver_data, 0,\
+					sizeof(struct global_pstate_info)-\
+					sizeof(struct timer_list)-\
+					sizeof(spinlock_t))
+
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled, occ_reset;
 
@@ -285,6 +331,7 @@ static inline void set_pmspr(unsigned long sprn, unsigned long val)
 struct powernv_smp_call_data {
 	unsigned int freq;
 	int pstate_id;
+	int gpstate_id;
 };
 
 /*
@@ -348,14 +395,17 @@ static void set_pstate(void *freq_data)
 	unsigned long val;
 	unsigned long pstate_ul =
 		((struct powernv_smp_call_data *) freq_data)->pstate_id;
+	unsigned long gpstate_ul =
+		((struct powernv_smp_call_data *) freq_data)->gpstate_id;
 
 	val = get_pmspr(SPRN_PMCR);
 	val = val & 0x0000FFFFFFFFFFFFULL;
 
 	pstate_ul = pstate_ul & 0xFF;
+	gpstate_ul = gpstate_ul & 0xFF;
 
 	/* Set both global(bits 56..63) and local(bits 48..55) PStates */
-	val = val | (pstate_ul << 56) | (pstate_ul << 48);
+	val = val | (gpstate_ul << 56) | (pstate_ul << 48);
 
 	pr_debug("Setting cpu %d pmcr to %016lX\n",
 			raw_smp_processor_id(), val);
@@ -425,6 +475,109 @@ next:
 }
 
 /*
+ * calcuate_global_pstate:
+ *
+ * @elapsed_time : elapsed time in milliseconds
+ * @local_pstate : new local pstate
+ * @highest_lpstate : pstate from which its ramping down
+ *
+ * Finds the appropriate global pstate based on the pstate from which its
+ * ramping down and the time elapsed in ramping down. It follows a quadratic
+ * equation which ensures that it reaches ramping down to pmin in 5sec.
+ */
+inline int calculate_global_pstate(unsigned int elapsed_time,
+		int highest_lpstate, int local_pstate)
+{
+	int pstate_diff;
+
+	/*
+	 * Using ramp_down_percent we get the percentage of rampdown
+	 * that we are expecting to be dropping. Difference between
+	 * highest_lpstate and powernv_pstate_info.min will give a absolute
+	 * number of how many pstates we will drop eventually by the end of
+	 * 5 seconds, then just scale it get the number pstates to be dropped.
+	 */
+	pstate_diff =  ((int)ramp_down_percent(elapsed_time) *
+			(highest_lpstate - powernv_pstate_info.min))/100;
+
+	/* Ensure that global pstate is >= to local pstate */
+	if (highest_lpstate - pstate_diff < local_pstate)
+		return local_pstate;
+	else
+		return (highest_lpstate - pstate_diff);
+}
+
+inline int queue_gpstate_timer(struct global_pstate_info *gpstates)
+{
+	unsigned int timer_interval;
+
+	/* Setting up timer to fire after GPSTATE_TIMER_INTERVAL ms, But
+	 * if it exceeds MAX_RAMP_DOWN_TIME ms for ramp down time.
+	 * Set timer such that it fires exactly at MAX_RAMP_DOWN_TIME
+	 * seconds of ramp down time.
+	 */
+	if ((gpstates->elapsed_time + GPSTATE_TIMER_INTERVAL)
+							 > MAX_RAMP_DOWN_TIME)
+		timer_interval = MAX_RAMP_DOWN_TIME - gpstates->elapsed_time;
+	else
+		timer_interval = GPSTATE_TIMER_INTERVAL;
+
+	return  mod_timer_pinned(&(gpstates->timer), jiffies +
+				msecs_to_jiffies(timer_interval));
+}
+/*
+ * gpstate_timer_handler
+ *
+ * @data: pointer to cpufreq_policy on which timer was queued
+ *
+ * This handler brings down the global pstate closer to the local pstate
+ * according quadratic equation. Queues a new timer if it is still not equal
+ * to local pstate
+ */
+void gpstate_timer_handler(unsigned long data)
+{
+	struct cpufreq_policy *policy = (struct cpufreq_policy *) data;
+	struct global_pstate_info *gpstates = (struct global_pstate_info *)
+							policy->driver_data;
+	unsigned int time_diff = jiffies_to_msecs(jiffies)
+					- gpstates->last_sampled_time;
+	struct powernv_smp_call_data freq_data;
+	int ret;
+
+	ret = spin_trylock(&gpstates->gpstate_lock);
+	if (!ret)
+		return;
+
+	gpstates->last_sampled_time += time_diff;
+	gpstates->elapsed_time += time_diff;
+	freq_data.pstate_id = gpstates->last_lpstate;
+	if ((gpstates->last_gpstate == freq_data.pstate_id) ||
+			(gpstates->elapsed_time > MAX_RAMP_DOWN_TIME)) {
+		freq_data.gpstate_id = freq_data.pstate_id;
+		reset_gpstates(policy);
+		gpstates->highest_lpstate = freq_data.pstate_id;
+	} else {
+		freq_data.gpstate_id = calculate_global_pstate(
+			gpstates->elapsed_time, gpstates->highest_lpstate,
+			freq_data.pstate_id);
+	}
+
+	/* If local pstate is equal to global pstate, rampdown is over
+	 * So timer is not required to be queued.
+	 */
+	if (freq_data.gpstate_id != freq_data.pstate_id)
+		ret = queue_gpstate_timer(gpstates);
+
+	gpstates->last_gpstate = freq_data.gpstate_id;
+	gpstates->last_lpstate = freq_data.pstate_id;
+
+	/* Timer may get migrated to a different cpu on cpu hot unplug */
+	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
+	spin_unlock(&gpstates->gpstate_lock);
+}
+
+
+/*
  * powernv_cpufreq_target_index: Sets the frequency corresponding to
  * the cpufreq table entry indexed by new_index on the cpus in the
  * mask policy->cpus
@@ -432,23 +585,88 @@ next:
 static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 					unsigned int new_index)
 {
+	int ret;
 	struct powernv_smp_call_data freq_data;
-
+	unsigned int cur_msec;
+	unsigned long flags;
+	struct global_pstate_info *gpstates = (struct global_pstate_info *)
+						policy->driver_data;
 	if (unlikely(rebooting) && new_index != get_nominal_index())
 		return 0;
 
 	if (!throttled)
 		powernv_cpufreq_throttle_check(NULL);
 
+	cur_msec = jiffies_to_msecs(get_jiffies_64());
+
+	/*spinlock taken*/
+	spin_lock_irqsave(&gpstates->gpstate_lock, flags);
 	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
+	/*First time call */
+	if (!gpstates->last_sampled_time) {
+		freq_data.gpstate_id = freq_data.pstate_id;
+		gpstates->highest_lpstate = freq_data.pstate_id;
+		goto gpstates_done;
+	}
+
+	/*Ramp down*/
+	if (gpstates->last_gpstate > freq_data.pstate_id) {
+		gpstates->elapsed_time += cur_msec -
+					gpstates->last_sampled_time;
+		/* If its has been ramping down for more than 5seconds
+		 * we should be reseting all global pstate related data.
+		 * Set it equal to local pstate to start fresh.
+		 */
+		if (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME) {
+			freq_data.gpstate_id = freq_data.pstate_id;
+			reset_gpstates(policy);
+			gpstates->highest_lpstate = freq_data.pstate_id;
+			freq_data.gpstate_id = freq_data.pstate_id;
+		} else {
+		/* elaspsed_time is less than 5 seconds, continue to rampdown*/
+			freq_data.gpstate_id = calculate_global_pstate(
+			gpstates->elapsed_time,
+			gpstates->highest_lpstate, freq_data.pstate_id);
+
+		}
+
+	} else {
+		/*Ramp up*/
+		reset_gpstates(policy);
+		gpstates->highest_lpstate = freq_data.pstate_id;
+		freq_data.gpstate_id = freq_data.pstate_id;
+	}
+
+	/* If local pstate is equal to global pstate, rampdown is over
+	 * So timer is not required to be queued.
+	 */
+	if (freq_data.gpstate_id != freq_data.pstate_id)
+		ret = queue_gpstate_timer(gpstates);
+gpstates_done:
+	gpstates->last_sampled_time = cur_msec;
+	gpstates->last_gpstate = freq_data.gpstate_id;
+	gpstates->last_lpstate = freq_data.pstate_id;
+
 	/*
 	 * Use smp_call_function to send IPI and execute the
 	 * mtspr on target CPU.  We could do that without IPI
 	 * if current CPU is within policy->cpus (core)
 	 */
 	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
+	spin_unlock_irqrestore(&gpstates->gpstate_lock, flags);
+	return 0;
+}
 
+static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	int base;
+	struct global_pstate_info *gpstates = (struct global_pstate_info *)
+						policy->driver_data;
+	base = cpu_first_thread_sibling(policy->cpu);
+	del_timer_sync(&gpstates->timer);
+	kfree(policy->driver_data);
+	pr_info("freed driver_data cpu %d\n", base);
 	return 0;
 }
 
@@ -456,6 +674,7 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	int base, i;
 	struct kernfs_node *kn;
+	struct global_pstate_info *gpstates;
 
 	base = cpu_first_thread_sibling(policy->cpu);
 
@@ -475,6 +694,21 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	} else {
 		kernfs_put(kn);
 	}
+	gpstates =  kzalloc(sizeof(struct global_pstate_info), GFP_KERNEL);
+	if (!gpstates) {
+		pr_err("Could not allocate global_pstate_info\n");
+		return -ENOMEM;
+	}
+	policy->driver_data = gpstates;
+
+	/* initialize timer */
+	init_timer_deferrable(&gpstates->timer);
+	gpstates->timer.data = (unsigned long) policy;
+	gpstates->timer.function = gpstate_timer_handler;
+	gpstates->timer.expires = jiffies +
+				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
+
+	pr_info("Added global_pstate_info & timer for %d cpu\n", base);
 	return cpufreq_table_validate_and_show(policy, powernv_freqs);
 }
 
@@ -612,6 +846,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 	.name		= "powernv-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= powernv_cpufreq_cpu_init,
+	.exit		= powernv_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= powernv_cpufreq_target_index,
 	.get		= powernv_cpufreq_get,
-- 
2.5.5
