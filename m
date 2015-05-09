Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF0331A0E01
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 15:49:27 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 8 May 2015 23:49:25 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8436938C8041
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 01:49:22 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t495nMRf61669512
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 May 2015 05:49:22 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t495nLnf004141
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 May 2015 01:49:22 -0400
Message-ID: <554D9FDC.6090608@linux.vnet.ibm.com>
Date: Sat, 09 May 2015 11:19:16 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3] cpuidle: Handle tick_broadcast_enter() failure
 gracefully
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <8680371.ymYIEaFYPT@vostro.rjw.lan>
In-Reply-To: <8680371.ymYIEaFYPT@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Cc: rlippert@google.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 peterz@infradead.org, linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rafael,

On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
>> +/*
>> + * find_tick_valid_state - select a state where tick does not stop
>> + * @dev: cpuidle device for this cpu
>> + * @drv: cpuidle driver for this cpu
>> + */
>> +static int find_tick_valid_state(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv)
>> +{
>> +	int i, ret = -1;
>> +
>> +	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
>> +		struct cpuidle_state *s = &drv->states[i];
>> +		struct cpuidle_state_usage *su = &dev->states_usage[i];
>> +
>> +		/*
>> +		 * We do not explicitly check for latency requirement
>> +		 * since it is safe to assume that only shallower idle
>> +		 * states will have the CPUIDLE_FLAG_TIMER_STOP bit
>> +		 * cleared and they will invariably meet the latency
>> +		 * requirement.
>> +		 */
>> +		if (s->disabled || su->disable ||
>> +			(s->flags & CPUIDLE_FLAG_TIMER_STOP))
>> +			continue;
>> +
>> +		ret = i;
>> +	}
>> +	return ret;
>> +}
>> +
>>  /**
>>   * cpuidle_enter_state - enter the state and update stats
>>   * @dev: cpuidle device for this cpu
>> @@ -168,10 +199,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>>  	 * CPU as a broadcast timer, this call may fail if it is not available.
>>  	 */
>>  	if (broadcast && tick_broadcast_enter()) {
>> -		default_idle_call();
>> -		return -EBUSY;
>> +		index = find_tick_valid_state(dev, drv);
> 
> Well, the new state needs to be deeper than the old one or you may violate the
> governor's choice and this doesn't guarantee that.

The comment above in find_tick_valid_state() explains why we are bound
to choose a shallow idle state. I think its safe to assume that any
state deeper than this one, would have the CPUIDLE_FLAG_TIMER_STOP flag
set and hence would be skipped.

Your patch relies on the assumption that the idle states are arranged in
the increasing order of exit_latency/in the order of shallow to deep.
This is not guaranteed, is it?

> 
> Also I don't quite see a reason to duplicate the find_deepest_state() functionality
> here.

Agreed. We could club them like in your patch.

> 
>> +		if (index < 0) {
>> +			default_idle_call();
>> +			return -EBUSY;
>> +		}
>> +		target_state = &drv->states[index];
>>  	}
>>  
>> +	/* Take note of the planned idle state. */
>> +	idle_set_state(smp_processor_id(), target_state);
> 
> And I wouldn't do this either.
> 
> The behavior here is pretty much as though the driver demoted the state chosen
> by the governor and we don't call idle_set_state() again in those cases.

Why is this wrong? The idea here is to set the idle state of the
runqueue to the one that it is more likely to enter into. Its is true
that the state has been demoted, but I don't see any code that requires
rq->idle_state to be a only a governor chosen state or nothing at all.

This is a more important chunk of this patch because it allows us to
track the idle states of the broadcast CPU. Else the system idle time is
bound to be higher than the residency time in different idle states of
all the CPUs. This shows up starkly as an anomaly if we are profiling
cpuidle state entry/exit.

> 
>> +
>>  	trace_cpu_idle_rcuidle(index, dev->cpu);
>>  	time_start = ktime_get();
> 
> Overall, something like the patch below (untested) should work I suppose?

With the exception of the above two points,yes this should work.
> 
> ---
>  drivers/cpuidle/cpuidle.c |   21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -73,17 +73,19 @@ int cpuidle_play_dead(void)
>  }
> 
>  static int find_deepest_state(struct cpuidle_driver *drv,
> -			      struct cpuidle_device *dev, bool freeze)
> +			      struct cpuidle_device *dev, bool freeze,
> +			      int limit, unsigned int flags_to_avoid)
>  {
>  	unsigned int latency_req = 0;
>  	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
> 
> -	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
> +	for (i = CPUIDLE_DRIVER_STATE_START; i < limit; i++) {
>  		struct cpuidle_state *s = &drv->states[i];
>  		struct cpuidle_state_usage *su = &dev->states_usage[i];
> 
>  		if (s->disabled || su->disable || s->exit_latency <= latency_req
> -		    || (freeze && !s->enter_freeze))
> +		    || (freeze && !s->enter_freeze)
> +		    || (s->flags & flags_to_avoid))
>  			continue;
> 
>  		latency_req = s->exit_latency;
> @@ -100,7 +102,7 @@ static int find_deepest_state(struct cpu
>  int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  			       struct cpuidle_device *dev)
>  {
> -	return find_deepest_state(drv, dev, false);
> +	return find_deepest_state(drv, dev, false, drv->state_count, 0);
>  }
> 
>  static void enter_freeze_proper(struct cpuidle_driver *drv,
> @@ -139,7 +141,7 @@ int cpuidle_enter_freeze(struct cpuidle_
>  	 * that interrupts won't be enabled when it exits and allows the tick to
>  	 * be frozen safely.
>  	 */
> -	index = find_deepest_state(drv, dev, true);
> +	index = find_deepest_state(drv, dev, true, drv->state_count, 0);
>  	if (index >= 0)
>  		enter_freeze_proper(drv, dev, index);
> 
> @@ -168,8 +170,13 @@ int cpuidle_enter_state(struct cpuidle_d
>  	 * CPU as a broadcast timer, this call may fail if it is not available.
>  	 */
>  	if (broadcast && tick_broadcast_enter()) {
> -		default_idle_call();
> -		return -EBUSY;
> +		index = find_deepest_state(drv, dev, false, index,
> +					   CPUIDLE_FLAG_TIMER_STOP);
> +		if (index < 0) {
> +			default_idle_call();
> +			return -EBUSY;
> +		}
> +		target_state = &drv->states[index];
>  	}
> 
>  	trace_cpu_idle_rcuidle(index, dev->cpu);

Regards
Preeti U Murthy
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
