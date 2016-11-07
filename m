Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC4013FwDzDvHV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 18:32:17 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA77SoFK116460
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 02:32:14 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26j8nn113h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 02:32:14 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 17:32:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2DA783578056
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 18:32:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA77W8wa4456712
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 18:32:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA77W7Kg006159
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 18:32:08 +1100
Subject: Re: [PATCH 1/2] cpufreq: powernv: Adding fast_switch for schedutil
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20161104063322.GA3414@vireshk-i7>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Date: Mon, 7 Nov 2016 13:02:04 +0530
MIME-Version: 1.0
In-Reply-To: <20161104063322.GA3414@vireshk-i7>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d2bbacea-3401-01ab-0933-f9ed628df502@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Viresh for taking a look at it.

I will make the mentioned changes in the next version of the patch.


Regards

Akshay Adiga


On 11/04/2016 12:03 PM, Viresh Kumar wrote:
> On 04-11-16, 10:57, Akshay Adiga wrote:
>> Adding fast_switch which does light weight operation to
>> set the desired pstate.
>>
>> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
>> ---
>>   drivers/cpufreq/powernv-cpufreq.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index d3ffde8..09a0496 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -752,9 +752,12 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   	spin_lock_init(&gpstates->gpstate_lock);
>>   	ret = cpufreq_table_validate_and_show(policy, powernv_freqs);
>>   
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>   		kfree(policy->driver_data);
>> +		return ret;
>> +	}
>>   
>> +	policy->fast_switch_possible = true;
>>   	return ret;
>>   }
>>   
>> @@ -897,6 +900,22 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>>   	del_timer_sync(&gpstates->timer);
>>   }
>>   
>> +static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
>> +					unsigned int target_freq)
>> +{
>> +	int index;
>> +	struct powernv_smp_call_data freq_data;
>> +
>> +	index = cpufreq_table_find_index_dl(policy, target_freq);
>> +	if (index < 0 || index >= powernv_pstate_info.nr_pstates)
>> +		return CPUFREQ_ENTRY_INVALID;
> I don't think such a check is required at all. It wouldn't happen without a BUG
> in kernel.
>> +	freq_data.pstate_id = powernv_freqs[index].driver_data;
>> +	freq_data.gpstate_id = powernv_freqs[index].driver_data;
>> +	set_pstate(&freq_data);
>> +
>> +	return powernv_freqs[index].frequency;
>> +}
>> +
>>   static struct cpufreq_driver powernv_cpufreq_driver = {
>>   	.name		= "powernv-cpufreq",
>>   	.flags		= CPUFREQ_CONST_LOOPS,
>> @@ -904,6 +923,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>>   	.exit		= powernv_cpufreq_cpu_exit,
>>   	.verify		= cpufreq_generic_frequency_table_verify,
>>   	.target_index	= powernv_cpufreq_target_index,
>> +	.fast_switch	= powernv_fast_switch,
>>   	.get		= powernv_cpufreq_get,
>>   	.stop_cpu	= powernv_cpufreq_stop_cpu,
>>   	.attr		= powernv_cpu_freq_attr,
>> -- 
>> 2.7.4
