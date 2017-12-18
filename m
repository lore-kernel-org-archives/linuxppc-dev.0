Return-Path: <huntbag@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0Tf36KvPzDrVJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 16:11:23 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBI59Upl007300
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 00:11:21 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ex69aj0hd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 00:11:21 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 05:11:18 -0000
Subject: Re: [PATCH] cpufreq: powernv: Add support of frequency domain
To: Viresh Kumar <viresh.kumar@linaro.org>, ego@linux.vnet.ibm.com
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
 <20171214044239.GU3322@vireshk-i7>
From: Abhishek <huntbag@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 10:41:12 +0530
MIME-Version: 1.0
In-Reply-To: <20171214044239.GU3322@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <93cc9d38-4fd8-d340-2263-108329b69b94@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/14/2017 10:12 AM, Viresh Kumar wrote:
> + Gautham,
>
> @Gautham: Can you please help reviewing this one ?
>
> On 13-12-17, 13:49, Abhishek Goel wrote:
>> @@ -693,6 +746,8 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>>   {
>>   	struct powernv_smp_call_data freq_data;
>>   	unsigned int cur_msec, gpstate_idx;
>> +	cpumask_t temp;
>> +	u32 cpu;
>>   	struct global_pstate_info *gpstates = policy->driver_data;
>>   
>>   	if (unlikely(rebooting) && new_index != get_nominal_index())
>> @@ -761,24 +816,48 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>>   	spin_unlock(&gpstates->gpstate_lock);
>>   
>>   	/*
>> -	 * Use smp_call_function to send IPI and execute the
>> -	 * mtspr on target CPU.  We could do that without IPI
>> -	 * if current CPU is within policy->cpus (core)
>> +	 * Use smp_call_function to send IPI and execute the mtspr on CPU.
>> +	 * This needs to be done on every core of the policy
> Why on each CPU ?
We need to do it in this way as the current implementation takes the max 
of the PMSR of the cores. Thus, when the frequency is required to be 
ramped up, it suffices to write to just the local PMSR, but when the 
frequency is to be ramped down, if we don't send the IPI it breaks the 
compatibility with P8.
>
>>   	 */
>> -	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
>> +	cpumask_copy(&temp, policy->cpus);
>> +
>> +	while (!cpumask_empty(&temp)) {
>> +		cpu = cpumask_first(&temp);
>> +		smp_call_function_any(cpu_sibling_mask(cpu),
>> +					set_pstate, &freq_data, 1);
>> +		cpumask_andnot(&temp, &temp, cpu_sibling_mask(cpu));
>> +	}
>> +
>>   	return 0;
>>   }
