Return-Path: <huntbag@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQ4Pv3SClzF0ZM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 19:30:43 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0M8TeYL106109
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 03:30:41 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fnc9g0qum-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 03:30:40 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Mon, 22 Jan 2018 08:30:38 -0000
Subject: Re: [PATCH v2] cpufreq: powernv: Add support of frequency domain
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20171220064214.9057-1-huntbag@linux.vnet.ibm.com>
 <20171220065028.GW19815@vireshk-i7>
From: Abhishek <huntbag@linux.vnet.ibm.com>
Date: Mon, 22 Jan 2018 14:00:32 +0530
MIME-Version: 1.0
In-Reply-To: <20171220065028.GW19815@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4f4552c9-c43d-1fbd-4ef5-6bed46a7a512@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/20/2017 12:20 PM, Viresh Kumar wrote:
> On 20-12-17, 12:12, Abhishek Goel wrote:
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index b6d7c4c..fd642bc 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -37,6 +37,7 @@
>>   #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
>>   #include <asm/opal.h>
>>   #include <linux/timer.h>
>> +#include <linux/hashtable.h>
>>   
>>   #define POWERNV_MAX_PSTATES	256
>>   #define PMSR_PSAFE_ENABLE	(1UL << 30)
>> @@ -130,6 +131,9 @@ static struct chip {
>>   static int nr_chips;
>>   static DEFINE_PER_CPU(struct chip *, chip_info);
>>   
>> +static u32 freq_domain_indicator;
>> +static u32 flag;
> I wouldn't name it as flag, its unreadable. Maybe its better to name
> it based on the quirk you are trying to workaround with ?
>
>> +
>>   /*
>>    * Note:
>>    * The set of pstates consists of contiguous integers.
>> @@ -194,6 +198,38 @@ static inline void reset_gpstates(struct cpufreq_policy *policy)
>>   	gpstates->last_gpstate_idx = 0;
>>   }
>>   
>> +#define SIZE NR_CPUS
>> +#define ORDER_FREQ_MAP ilog2(SIZE)
>> +
>> +static DEFINE_HASHTABLE(freq_domain_map, ORDER_FREQ_MAP);
>> +
>> +struct hashmap {
>> +	cpumask_t mask;
>> +	int chip_id;
>> +	u32 pir_key;
>> +	struct hlist_node hash_node;
>> +};
>> +
>> +static void insert(u32 key, int cpu)
>> +{
>> +	struct hashmap *data;
>> +
>> +	hash_for_each_possible(freq_domain_map, data, hash_node, key%SIZE) {
>> +		if (data->chip_id == cpu_to_chip_id(cpu) &&
>> +			data->pir_key == key) {
>> +			cpumask_set_cpu(cpu, &data->mask);
>> +			return;
>> +		}
>> +	}
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	hash_add(freq_domain_map, &data->hash_node, key%SIZE);
>> +	cpumask_set_cpu(cpu, &data->mask);
>> +	data->chip_id = cpu_to_chip_id(cpu);
>> +	data->pir_key = key;
>> +
>> +}
>> +
>>   /*
>>    * Initialize the freq table based on data obtained
>>    * from the firmware passed via device-tree
>> @@ -206,7 +242,9 @@ static int init_powernv_pstates(void)
>>   	u32 len_ids, len_freqs;
>>   	u32 pstate_min, pstate_max, pstate_nominal;
>>   	u32 pstate_turbo, pstate_ultra_turbo;
>> +	u32 key;
>>   
>> +	flag = 0;
> Isn't flag already 0 (global-uninitialized) ?
>
>>   	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
>>   	if (!power_mgt) {
>>   		pr_warn("power-mgt node not found\n");
>> @@ -229,6 +267,17 @@ static int init_powernv_pstates(void)
>>   		return -ENODEV;
>>   	}
>>   
>> +	if (of_device_is_compatible(power_mgt, "freq-domain-v1") &&
>> +		of_property_read_u32(power_mgt, "ibm,freq-domain-indicator",
>> +				 &freq_domain_indicator)) {
>> +		pr_warn("ibm,freq-domain-indicator not found\n");
>> +		freq_domain_indicator = 0;
> You shouldn't be required to set it to 0 here.
>
>> +	}
>> +
>> +	if (of_device_is_compatible(power_mgt, "P9-occ-quirk")) {
>> +		flag = 1;
>> +	}
> Remove {} and a better name like p9_occ_quirk would be good for flag.
> Also making it a bool may be better ?
>
>> +
>>   	if (of_property_read_u32(power_mgt, "ibm,pstate-ultra-turbo",
>>   				 &pstate_ultra_turbo)) {
>>   		powernv_pstate_info.wof_enabled = false;
>> @@ -249,6 +298,7 @@ static int init_powernv_pstates(void)
>>   next:
>>   	pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
>>   		pstate_nominal, pstate_max);
>> +	pr_info("frequency domain indicator %d", freq_domain_indicator);
>>   	pr_info("Workload Optimized Frequency is %s in the platform\n",
>>   		(powernv_pstate_info.wof_enabled) ? "enabled" : "disabled");
>>   
>> @@ -276,6 +326,15 @@ static int init_powernv_pstates(void)
>>   		return -ENODEV;
>>   	}
>>   
>> +	if (freq_domain_indicator) {
>> +		hash_init(freq_domain_map);
>> +		for_each_possible_cpu(i) {
>> +			key = ((u32) get_hard_smp_processor_id(i) &
>> +				freq_domain_indicator);
> Maybe break it like:
>
> 			key = (u32) get_hard_smp_processor_id(i);
>                          key &= freq_domain_indicator;
>
> to make it easily readable ?
>
>> +			insert(key, i);
>> +		}
>> +	}
>> +
>>   	powernv_pstate_info.nr_pstates = nr_pstates;
>>   	pr_debug("NR PStates %d\n", nr_pstates);
>>   	for (i = 0; i < nr_pstates; i++) {
>> @@ -693,6 +752,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>>   {
>>   	struct powernv_smp_call_data freq_data;
>>   	unsigned int cur_msec, gpstate_idx;
>> +
> :(
>
>>   	struct global_pstate_info *gpstates = policy->driver_data;
>>   
>>   	if (unlikely(rebooting) && new_index != get_nominal_index())
>> @@ -760,25 +820,55 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>>   
>>   	spin_unlock(&gpstates->gpstate_lock);
>>   
>> -	/*
>> -	 * Use smp_call_function to send IPI and execute the
>> -	 * mtspr on target CPU.  We could do that without IPI
>> -	 * if current CPU is within policy->cpus (core)
>> -	 */
>> -	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
>> +	if (flag) {
> Maybe add a comment over this on why you need to do things differently
> here, as it isn't obvious.
>
>> +		cpumask_t temp;
>> +		u32 cpu;
>> +
>> +	       /*
>> +		* Use smp_call_function to send IPI and execute the mtspr
>> +		* on CPU. This needs to be done on every core of the policy.
>> +		*/
>> +		cpumask_copy(&temp, policy->cpus);
>> +		while (!cpumask_empty(&temp)) {
>> +			cpu = cpumask_first(&temp);
>> +			smp_call_function_any(cpu_sibling_mask(cpu),
>> +					set_pstate, &freq_data, 1);
>> +			cpumask_andnot(&temp, &temp, cpu_sibling_mask(cpu));
>> +		}
>> +	} else {
>> +		smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>>   static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   {
>> -	int base, i, ret;
>> +	int ret;
>>   	struct kernfs_node *kn;
>>   	struct global_pstate_info *gpstates;
>>   
>> -	base = cpu_first_thread_sibling(policy->cpu);
>> +	if (!freq_domain_indicator) {
>> +		int base, i;
>>   
>> -	for (i = 0; i < threads_per_core; i++)
>> -		cpumask_set_cpu(base + i, policy->cpus);
>> +		base = cpu_first_thread_sibling(policy->cpu);
>> +		for (i = 0; i < threads_per_core; i++)
>> +			cpumask_set_cpu(base + i, policy->cpus);
>> +	} else {
>> +		u32 key;
>> +		struct hashmap *data;
>> +
>> +		key = ((u32) get_hard_smp_processor_id(policy->cpu) &
>> +				freq_domain_indicator);
>> +		hash_for_each_possible(freq_domain_map, data, hash_node,
>> +								 key%SIZE) {
>> +			if (data->chip_id == cpu_to_chip_id(policy->cpu) &&
>> +				data->pir_key == key) {
>> +				cpumask_copy(policy->cpus, &data->mask);
>> +				break;
>> +			}
>> +		}
>> +	}
>>   
>>   	kn = kernfs_find_and_get(policy->kobj.sd, throttle_attr_grp.name);
>>   	if (!kn) {
>> -- 
>> 2.9.3
Have posted the next version with the changes made as suggested. Also 
the skiboot patch required for the device tree changes made is posted 
here : http://patchwork.ozlabs.org/patch/862256/

-Abhishek
