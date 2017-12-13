Return-Path: <huntbag@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxV3z5fTKzDrfk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 19:19:59 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBD8JL4W053747
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 03:19:56 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2etxh5wm54-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 03:19:56 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 08:19:53 -0000
From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Add support of frequency domain
Date: Wed, 13 Dec 2017 13:49:37 +0530
Message-Id: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frequency-domain indicates group of CPUs that would share same frequency.
It is detected using device-tree node "frequency-domain-indicator".
frequency-domain-indicator is a bitmask which will have different value
depending upon the generation of the processor.

CPUs of the same chip for which the result of a bitwise AND between
their PIR and the frequency-domain-indicator is the same share the same
frequency.

In this patch, we define hash-table indexed by the aforementioned
bitwise ANDed value to store the cpumask of the CPUs sharing the same
frequency domain. Further, the cpufreq policy will be created per
frequency-domain

So for POWER9, a cpufreq policy is created per quad while for POWER8 it
is created per core. Governor decides frequency for each policy but
multiple cores may come under same policy. In such case frequency needs
to be set on each core sharing that policy.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 95 +++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index b6d7c4c..9384110 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -37,6 +37,7 @@
 #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
 #include <asm/opal.h>
 #include <linux/timer.h>
+#include <linux/hashtable.h>
 
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
@@ -130,6 +131,8 @@ static struct chip {
 static int nr_chips;
 static DEFINE_PER_CPU(struct chip *, chip_info);
 
+static u32 freq_domain_indicator;
+
 /*
  * Note:
  * The set of pstates consists of contiguous integers.
@@ -194,6 +197,38 @@ static inline void reset_gpstates(struct cpufreq_policy *policy)
 	gpstates->last_gpstate_idx = 0;
 }
 
+#define SIZE NR_CPUS
+#define ORDER_FREQ_MAP ilog2(SIZE)
+
+static DEFINE_HASHTABLE(freq_domain_map, ORDER_FREQ_MAP);
+
+struct hashmap {
+	cpumask_t mask;
+	int chip_id;
+	u32 pir_key;
+	struct hlist_node hash_node;
+};
+
+static void insert(u32 key, int cpu)
+{
+	struct hashmap *data;
+
+	hash_for_each_possible(freq_domain_map, data, hash_node, key%SIZE) {
+		if (data->chip_id == cpu_to_chip_id(cpu) &&
+			data->pir_key == key) {
+			cpumask_set_cpu(cpu, &data->mask);
+			return;
+		}
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	hash_add(freq_domain_map, &data->hash_node, key%SIZE);
+	cpumask_set_cpu(cpu, &data->mask);
+	data->chip_id = cpu_to_chip_id(cpu);
+	data->pir_key = key;
+
+}
+
 /*
  * Initialize the freq table based on data obtained
  * from the firmware passed via device-tree
@@ -206,6 +241,7 @@ static int init_powernv_pstates(void)
 	u32 len_ids, len_freqs;
 	u32 pstate_min, pstate_max, pstate_nominal;
 	u32 pstate_turbo, pstate_ultra_turbo;
+	u32 key;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
@@ -229,6 +265,13 @@ static int init_powernv_pstates(void)
 		return -ENODEV;
 	}
 
+	if (of_device_is_compatible(power_mgt, "freq-domain-v1") &&
+		of_property_read_u32(power_mgt, "ibm,freq-domain-indicator",
+				 &freq_domain_indicator)) {
+		pr_warn("ibm,freq-domain-indicator not found\n");
+		freq_domain_indicator = 0;
+	}
+
 	if (of_property_read_u32(power_mgt, "ibm,pstate-ultra-turbo",
 				 &pstate_ultra_turbo)) {
 		powernv_pstate_info.wof_enabled = false;
@@ -249,6 +292,7 @@ static int init_powernv_pstates(void)
 next:
 	pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
 		pstate_nominal, pstate_max);
+	pr_info("frequency domain indicator %d", freq_domain_indicator);
 	pr_info("Workload Optimized Frequency is %s in the platform\n",
 		(powernv_pstate_info.wof_enabled) ? "enabled" : "disabled");
 
@@ -276,6 +320,15 @@ static int init_powernv_pstates(void)
 		return -ENODEV;
 	}
 
+	if (freq_domain_indicator) {
+		hash_init(freq_domain_map);
+		for_each_possible_cpu(i) {
+			key = ((u32) get_hard_smp_processor_id(i) &
+				freq_domain_indicator);
+			insert(key, i);
+		}
+	}
+
 	powernv_pstate_info.nr_pstates = nr_pstates;
 	pr_debug("NR PStates %d\n", nr_pstates);
 	for (i = 0; i < nr_pstates; i++) {
@@ -693,6 +746,8 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 {
 	struct powernv_smp_call_data freq_data;
 	unsigned int cur_msec, gpstate_idx;
+	cpumask_t temp;
+	u32 cpu;
 	struct global_pstate_info *gpstates = policy->driver_data;
 
 	if (unlikely(rebooting) && new_index != get_nominal_index())
@@ -761,24 +816,48 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	spin_unlock(&gpstates->gpstate_lock);
 
 	/*
-	 * Use smp_call_function to send IPI and execute the
-	 * mtspr on target CPU.  We could do that without IPI
-	 * if current CPU is within policy->cpus (core)
+	 * Use smp_call_function to send IPI and execute the mtspr on CPU.
+	 * This needs to be done on every core of the policy
 	 */
-	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
+	cpumask_copy(&temp, policy->cpus);
+
+	while (!cpumask_empty(&temp)) {
+		cpu = cpumask_first(&temp);
+		smp_call_function_any(cpu_sibling_mask(cpu),
+					set_pstate, &freq_data, 1);
+		cpumask_andnot(&temp, &temp, cpu_sibling_mask(cpu));
+	}
+
 	return 0;
 }
 
 static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	int base, i, ret;
+	int ret;
 	struct kernfs_node *kn;
 	struct global_pstate_info *gpstates;
 
-	base = cpu_first_thread_sibling(policy->cpu);
+	if (!freq_domain_indicator) {
+		int base, i;
 
-	for (i = 0; i < threads_per_core; i++)
-		cpumask_set_cpu(base + i, policy->cpus);
+		base = cpu_first_thread_sibling(policy->cpu);
+		for (i = 0; i < threads_per_core; i++)
+			cpumask_set_cpu(base + i, policy->cpus);
+	} else {
+		u32 key;
+		struct hashmap *data;
+
+		key = ((u32) get_hard_smp_processor_id(policy->cpu) &
+				freq_domain_indicator);
+		hash_for_each_possible(freq_domain_map, data, hash_node,
+								 key%SIZE) {
+			if (data->chip_id == cpu_to_chip_id(policy->cpu) &&
+				data->pir_key == key) {
+				cpumask_copy(policy->cpus, &data->mask);
+				break;
+			}
+		}
+	}
 
 	kn = kernfs_find_and_get(policy->kobj.sd, throttle_attr_grp.name);
 	if (!kn) {
-- 
2.9.3
