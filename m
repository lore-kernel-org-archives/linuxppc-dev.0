Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq0kt2cf2zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:55:50 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 19 Apr 2016 15:25:47 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3J9tgcC3932452
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 15:25:42 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3J9tftM016735
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 15:25:42 +0530
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Ramp-down global pstate slower
 than local-pstate
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <1460701739-31549-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460701739-31549-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160418101846.GB2322@vireshk-i7>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Message-ID: <5716009C.8050704@linux.vnet.ibm.com>
Date: Tue, 19 Apr 2016 15:25:40 +0530
MIME-Version: 1.0
In-Reply-To: <20160418101846.GB2322@vireshk-i7>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Viresh,

On 04/18/2016 03:48 PM, Viresh Kumar wrote:
> On 15-04-16, 11:58, Akshay Adiga wrote:
>>   static int powernv_cpufreq_reboot_notifier(struct notifier_block *nb,
>> -				unsigned long action, void *unused)
>> +					   unsigned long action, void *unused)
> Unrelated change.. better don't add such changes..

Posting out v3 with out this unrelated change.

>>   {
>>   	int cpu;
>>   	struct cpufreq_policy cpu_policy;
>> @@ -603,15 +843,18 @@ static struct notifier_block powernv_cpufreq_opal_nb = {
>>   static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>>   {
>>   	struct powernv_smp_call_data freq_data;
>> -
>> +	struct global_pstate_info *gpstates = policy->driver_data;
> You removed a blank line here and I feel the code looks better with
> that.
>
>>   	freq_data.pstate_id = powernv_pstate_info.min;
>> +	freq_data.gpstate_id = powernv_pstate_info.min;
>>   	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
>> +	del_timer_sync(&gpstates->timer);
>>   }
>>   
>>   static struct cpufreq_driver powernv_cpufreq_driver = {
>>   	.name		= "powernv-cpufreq",
>>   	.flags		= CPUFREQ_CONST_LOOPS,
>>   	.init		= powernv_cpufreq_cpu_init,
>> +	.exit		= powernv_cpufreq_cpu_exit,
>>   	.verify		= cpufreq_generic_frequency_table_verify,
>>   	.target_index	= powernv_cpufreq_target_index,
>>   	.get		= powernv_cpufreq_get,
> None of the above comments are mandatory for you to fix..
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
Thanks for Ack  :)
