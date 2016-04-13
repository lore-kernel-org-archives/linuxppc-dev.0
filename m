Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlWkz1mBNzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 03:58:51 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 14 Apr 2016 03:58:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DD7B12CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 03:58:43 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3DHwZBm33095696
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 03:58:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3DHwAF7001167
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 03:58:11 +1000
Subject: Re: [PATCH 2/2] cpufreq: powernv: Ramp-down global pstate slower than
 local-pstate
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460484386-28389-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160413050310.GE19433@vireshk-i7>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Message-ID: <570E889F.2010401@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2016 23:27:51 +0530
MIME-Version: 1.0
In-Reply-To: <20160413050310.GE19433@vireshk-i7>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Viresh ,

Thanks for reviewing in detail.
I will correct all comments related to coding standards in my next patch.

On 04/13/2016 10:33 AM, Viresh Kumar wrote:

> Comments mostly on the coding standards which you have *not* followed.
>
> Also, please run checkpatch --strict next time you send patches
> upstream.

Thanks for pointing out the --strict option, was not aware of that. I will
run checkpatch --strict on the next versions.

> On 12-04-16, 23:36, Akshay Adiga wrote:
> +
> +/*
> + * While resetting we don't want "timer" fields to be set to zero as we
> + * may lose track of timer and will not be able to cleanly remove it
> + */
> +#define reset_gpstates(policy)   memset(policy->driver_data, 0,\
> +					sizeof(struct global_pstate_info)-\
> +					sizeof(struct timer_list)-\
> +					sizeof(spinlock_t))
> That's super *ugly*. Why don't you create a simple routine which will
> set the 5 integer variables to 0 in a straight forward way ?

Yeh, will create a routine.

>> @@ -348,14 +395,17 @@ static void set_pstate(void *freq_data)
>>   	unsigned long val;
>>   	unsigned long pstate_ul =
>>   		((struct powernv_smp_call_data *) freq_data)->pstate_id;
>> +	unsigned long gpstate_ul =
>> +		((struct powernv_smp_call_data *) freq_data)->gpstate_id;
> Remove these unnecessary casts and do:
>
> struct powernv_smp_call_data *freq_data = data; //Name func arg as data
>
> And then use freq_data->*.

Ok. Will do that.

>> +/*
>> + * gpstate_timer_handler
>> + *
>> + * @data: pointer to cpufreq_policy on which timer was queued
>> + *
>> + * This handler brings down the global pstate closer to the local pstate
>> + * according quadratic equation. Queues a new timer if it is still not equal
>> + * to local pstate
>> + */
>> +void gpstate_timer_handler(unsigned long data)
>> +{
>> +	struct cpufreq_policy *policy = (struct cpufreq_policy *) data;
> no need to cast.

May be i need a cast here,  because data is unsigned long ( unlike other places where its void *).
On building without cast, it throws me a warning.

>> +	struct global_pstate_info *gpstates = (struct global_pstate_info *)
>> +	struct powernv_smp_call_data freq_data;
>> +	int ret;
>> +
>> +	ret = spin_trylock(&gpstates->gpstate_lock);
> no need of 'ret' for just this, simply do: if (!spin_trylock())...

Sure will do that.

> a
>> +	if (!ret)
>> +		return;
>> +
>> +	gpstates->last_sampled_time += time_diff;
>> +	gpstates->elapsed_time += time_diff;
>> +	freq_data.pstate_id = gpstates->last_lpstate;
>> +	if ((gpstates->last_gpstate == freq_data.pstate_id) ||
>> +			(gpstates->elapsed_time > MAX_RAMP_DOWN_TIME)) {
>> +		freq_data.gpstate_id = freq_data.pstate_id;
>> +		reset_gpstates(policy);
>> +		gpstates->highest_lpstate = freq_data.pstate_id;
>> +	} else {
>> +		freq_data.gpstate_id = calculate_global_pstate(
> You can't break a line after ( of a function call :)
>
> Let it go beyond 80 columns if it has to.

May be i will try to get it inside 80 columns with a temporary variable instead of
freq_data.gpstate_id.

>> +			gpstates->elapsed_time, gpstates->highest_lpstate,
>> +			freq_data.pstate_id);
>> +	}
>> +
>> +	/* If local pstate is equal to global pstate, rampdown is over
> Bad style again.
>
>> +	 * So timer is not required to be queued.
>> +	 */
>> +	if (freq_data.gpstate_id != freq_data.pstate_id)
>> +		ret = queue_gpstate_timer(gpstates);
> ret not used.

Should i make it void instead of returning int?, as i cannot do much even if it fails, except for notifying.

>> +gpstates_done:
>> +	gpstates->last_sampled_time = cur_msec;
>> +	gpstates->last_gpstate = freq_data.gpstate_id;
>> +	gpstates->last_lpstate = freq_data.pstate_id;
>> +
>>   	/*
>>   	 * Use smp_call_function to send IPI and execute the
>>   	 * mtspr on target CPU.  We could do that without IPI
>>   	 * if current CPU is within policy->cpus (core)
>>   	 */
>>   	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
>> +	spin_unlock_irqrestore(&gpstates->gpstate_lock, flags);
>> +	return 0;
>> +}
>>   
>> +static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> Add this after the init() routine.

Ok will do it.

>> +	policy->driver_data = gpstates;
>> +
>> +	/* initialize timer */
>> +	init_timer_deferrable(&gpstates->timer);
>> +	gpstates->timer.data = (unsigned long) policy;
>> +	gpstates->timer.function = gpstate_timer_handler;
>> +	gpstates->timer.expires = jiffies +
>> +				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
>> +
>> +	pr_info("Added global_pstate_info & timer for %d cpu\n", base);
>>   	return cpufreq_table_validate_and_show(policy, powernv_freqs);
> Who will free gpstates if this fails ?

Thanks for pointing out. Will fix in v2.

Regards
Akshay Adiga
