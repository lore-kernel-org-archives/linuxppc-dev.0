Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdDgB3w5LzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 23:20:52 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc: viresh.kumar@linaro.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: powernv: Add support of frequency domain
Date: Fri, 09 Feb 2018 13:19:04 +0100
Message-ID: <2235126.ZWAqWlELuo@aspire.rjw.lan>
In-Reply-To: <1516609054-13244-1-git-send-email-huntbag@linux.vnet.ibm.com>
References: <1516609054-13244-1-git-send-email-huntbag@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, January 22, 2018 9:17:34 AM CET Abhishek Goel wrote:
> Frequency-domain indicates group of CPUs that would share same frequency.
> It is detected using device-tree node "frequency-domain-indicator".
> frequency-domain-indicator is a bitmask which will have different value
> depending upon the generation of the processor.
> 
> CPUs of the same chip for which the result of a bitwise AND between
> their PIR and the frequency-domain-indicator is the same share the same
> frequency.
> 
> In this patch, we define hash-table indexed by the aforementioned
> bitwise ANDed value to store the cpumask of the CPUs sharing the same
> frequency domain. Further, the cpufreq policy will be created per
> frequency-domain
> 
> So for POWER9, a cpufreq policy is created per quad while for POWER8 it
> is created per core. Governor decides frequency for each policy but
> multiple cores may come under same policy. In such case frequency needs
> to be set on each core sharing that policy.
> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
> 
> Skiboot patch required for the corresponding device-tree changes have been
> posted here : http://patchwork.ozlabs.org/patch/862256/
> 
>  drivers/cpufreq/powernv-cpufreq.c | 104 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 95 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index b6d7c4c..aab23a4 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -37,6 +37,7 @@
>  #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
>  #include <asm/opal.h>
>  #include <linux/timer.h>
> +#include <linux/hashtable.h>
>  
>  #define POWERNV_MAX_PSTATES	256
>  #define PMSR_PSAFE_ENABLE	(1UL << 30)
> @@ -130,6 +131,9 @@ enum throttle_reason_type {
>  static int nr_chips;
>  static DEFINE_PER_CPU(struct chip *, chip_info);
>  
> +static u32 freq_domain_indicator;
> +static bool p9_occ_quirk;
> +
>  /*
>   * Note:
>   * The set of pstates consists of contiguous integers.
> @@ -194,6 +198,38 @@ static inline void reset_gpstates(struct cpufreq_policy *policy)
>  	gpstates->last_gpstate_idx = 0;
>  }
>  
> +#define SIZE NR_CPUS
> +#define ORDER_FREQ_MAP ilog2(SIZE)
> +
> +static DEFINE_HASHTABLE(freq_domain_map, ORDER_FREQ_MAP);
> +
> +struct hashmap {
> +	cpumask_t mask;
> +	int chip_id;
> +	u32 pir_key;
> +	struct hlist_node hash_node;
> +};
> +
> +static void insert(u32 key, int cpu)
> +{
> +	struct hashmap *data;
> +
> +	hash_for_each_possible(freq_domain_map, data, hash_node, key%SIZE) {
> +		if (data->chip_id == cpu_to_chip_id(cpu) &&
> +			data->pir_key == key) {
> +			cpumask_set_cpu(cpu, &data->mask);
> +			return;
> +		}
> +	}
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	hash_add(freq_domain_map, &data->hash_node, key%SIZE);
> +	cpumask_set_cpu(cpu, &data->mask);
> +	data->chip_id = cpu_to_chip_id(cpu);
> +	data->pir_key = key;
> +
> +}
> +
>  /*
>   * Initialize the freq table based on data obtained
>   * from the firmware passed via device-tree
> @@ -206,6 +242,7 @@ static int init_powernv_pstates(void)
>  	u32 len_ids, len_freqs;
>  	u32 pstate_min, pstate_max, pstate_nominal;
>  	u32 pstate_turbo, pstate_ultra_turbo;
> +	u32 key;
>  
>  	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
>  	if (!power_mgt) {
> @@ -246,9 +283,18 @@ static int init_powernv_pstates(void)
>  	else
>  		powernv_pstate_info.wof_enabled = true;
>  
> +	if (of_device_is_compatible(power_mgt, "freq-domain-v1") &&
> +		of_property_read_u32(power_mgt, "ibm,freq-domain-indicator",
> +				&freq_domain_indicator))
> +		pr_warn("ibm,freq-domain-indicator not found\n");
> +
> +        if (of_device_is_compatible(power_mgt, "p9-occ-quirk"))
> +		p9_occ_quirk = true;
> +
>  next:
>  	pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
>  		pstate_nominal, pstate_max);
> +	pr_info("frequency domain indicator %d", freq_domain_indicator);
>  	pr_info("Workload Optimized Frequency is %s in the platform\n",
>  		(powernv_pstate_info.wof_enabled) ? "enabled" : "disabled");
>  
> @@ -276,6 +322,15 @@ static int init_powernv_pstates(void)
>  		return -ENODEV;
>  	}
>  
> +	if (freq_domain_indicator) {
> +		hash_init(freq_domain_map);
> +		for_each_possible_cpu(i) {
> +			key = ((u32) get_hard_smp_processor_id(i) &
> +				freq_domain_indicator);
> +			insert(key, i);
> +		}
> +	}
> +
>  	powernv_pstate_info.nr_pstates = nr_pstates;
>  	pr_debug("NR PStates %d\n", nr_pstates);
>  	for (i = 0; i < nr_pstates; i++) {
> @@ -760,25 +815,56 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  
>  	spin_unlock(&gpstates->gpstate_lock);
>  
> -	/*
> -	 * Use smp_call_function to send IPI and execute the
> -	 * mtspr on target CPU.  We could do that without IPI
> -	 * if current CPU is within policy->cpus (core)
> +	/* The current DVFS implementation in firmware requires that to set a
> +	 * frequency in a quad, all cores of the quad need to set frequency in
> +	 * their respective PMCR's. Ideally setting frequency on any of the
> +	 * core of that quad should change frequency for the quad.
>  	 */
> -	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
> +	if (p9_occ_quirk) {
> +		cpumask_t temp;
> +		u32 cpu;
> +
> +		cpumask_copy(&temp, policy->cpus);
> +		while (!cpumask_empty(&temp)) {
> +			cpu = cpumask_first(&temp);
> +			smp_call_function_any(cpu_sibling_mask(cpu),
> +					set_pstate, &freq_data, 1);
> +			cpumask_andnot(&temp, &temp, cpu_sibling_mask(cpu));
> +		}
> +	} else {
> +		smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
> +	}
> +
>  	return 0;
>  }
>  
>  static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int base, i, ret;
> +	int ret;
>  	struct kernfs_node *kn;
>  	struct global_pstate_info *gpstates;
>  
> -	base = cpu_first_thread_sibling(policy->cpu);
> +	if (!freq_domain_indicator) {

IMO it would be more straightforward to write this conditional as

if (freq_domain_indicator) {
   do something
} else {
   do something else
}

> +		int base, i;
>  
> -	for (i = 0; i < threads_per_core; i++)
> -		cpumask_set_cpu(base + i, policy->cpus);
> +		base = cpu_first_thread_sibling(policy->cpu);
> +		for (i = 0; i < threads_per_core; i++)
> +			cpumask_set_cpu(base + i, policy->cpus);
> +	} else {
> +		u32 key;
> +		struct hashmap *data;
> +
> +		key = ((u32) get_hard_smp_processor_id(policy->cpu) &
> +				freq_domain_indicator);

The outer paren on the right-hand side is not necessary.

The explicit case to u32 isn't necessary as well AFAICS.

> +		hash_for_each_possible(freq_domain_map, data, hash_node,
> +								 key%SIZE) {
> +			if (data->chip_id == cpu_to_chip_id(policy->cpu) &&
> +				data->pir_key == key) {

You have slightly confusing indentation here, as the continuation of the
condition is at the same level as the statements in the conditional block.

> +				cpumask_copy(policy->cpus, &data->mask);
> +				break;
> +			}
> +		}
> +	}
>  
>  	kn = kernfs_find_and_get(policy->kobj.sd, throttle_attr_grp.name);
>  	if (!kn) {
> 

Overall, from cpufreq perspective, I don't see anything to complain about
here.

Thanks,
Rafael
