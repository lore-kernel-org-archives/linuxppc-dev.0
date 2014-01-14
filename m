Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 417C12C009A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 19:28:40 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 01:28:35 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 03B6819D8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 01:28:24 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0E8SYNe9371920
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 09:28:34 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0E8SXow006070
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 01:28:33 -0700
Message-ID: <52D4F464.5070707@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 13:55:08 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/menu: Fail cpuidle_idle_call() if no idle state
 is acceptable
References: <20140114060516.6109.14901.stgit@preeti.in.ibm.com>
 <52D4E07E.204@linux.vnet.ibm.com>
In-Reply-To: <52D4E07E.204@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: deepthi@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 tuukka.tikkanen@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Srivatsa,

On 01/14/2014 12:30 PM, Srivatsa S. Bhat wrote:
> On 01/14/2014 11:35 AM, Preeti U Murthy wrote:
>> On PowerPC, in a particular test scenario, all the cpu idle states were disabled.
>> Inspite of this it was observed that the idle state count of the shallowest
>> idle state, snooze, was increasing.
>>
>> This is because the governor returns the idle state index as 0 even in
>> scenarios when no idle state can be chosen. These scenarios could be when the
>> latency requirement is 0 or as mentioned above when the user wants to disable
>> certain cpu idle states at runtime. In the latter case, its possible that no
>> cpu idle state is valid because the suitable states were disabled
>> and the rest did not match the menu governor criteria to be chosen as the
>> next idle state.
>>
>> This patch adds the code to indicate that a valid cpu idle state could not be
>> chosen by the menu governor and reports back to arch so that it can take some
>> default action.
>>
> 
> That sounds fair enough. However, the "default" action of pseries idle loop
> (pseries_lpar_idle()) surprises me. It enters Cede, which is _deeper_ than doing
> a snooze! IOW, a user might "disable" cpuidle or set the PM_QOS_CPU_DMA_LATENCY
> to 0 hoping to prevent the CPUs from going to deep idle states, but then the
> machine would still end up going to Cede, even though that wont get reflected
> in the idle state counts. IMHO that scenario needs some thought as well...

Yes I did see this, but since the patch intends to only communicate
whether the cpuidle governor was successful in choosing an idle state on
its part, I wished to address the default action of pseries idle loop
separately. You are right we will need to understand the patch which
introduced this action. I will take a look at it.

> 
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> ---
>>
>>  drivers/cpuidle/cpuidle.c        |    6 +++++-
>>  drivers/cpuidle/governors/menu.c |    7 ++++---
>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index a55e68f..5bf06bb 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -131,8 +131,9 @@ int cpuidle_idle_call(void)
>>
>>  	/* ask the governor for the next state */
>>  	next_state = cpuidle_curr_governor->select(drv, dev);
>> +
>> +	dev->last_residency = 0;
>>  	if (need_resched()) {
>> -		dev->last_residency = 0;
>>  		/* give the governor an opportunity to reflect on the outcome */
>>  		if (cpuidle_curr_governor->reflect)
>>  			cpuidle_curr_governor->reflect(dev, next_state);
> 
> The comments on top of the .reflect() routines of the governors say that the
> second parameter is the index of the actual state entered. But after this patch,
> next_state can be negative, indicating an invalid index. So those comments need
> to be updated accordingly.

Right, I will take care of the comment in the next post.
> 
>> @@ -140,6 +141,9 @@ int cpuidle_idle_call(void)
>>  		return 0;
>>  	}
>>
>> +	if (next_state < 0)
>> +		return -EINVAL;
> 
> The exit path above (due to need_resched) returns with irqs enabled, but the new
> one you are adding (next_state < 0) returns with irqs disabled. This is correct,
> because in the latter case, "idle" is still in progress and the arch will choose
> a default handler to execute (unlike the former case where "idle" is over and
> hence its time to enable interrupts).

Correct.
> 
> IMHO it would be good to add comments around this code to explain this subtle
> difference. We can never be too careful with these things... ;-)

Ok, will do so.
> 
>> +
>>  	trace_cpu_idle_rcuidle(next_state, dev->cpu);
>>
>>  	broadcast = !!(drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP);
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index cf7f2f0..6921543 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -283,6 +283,7 @@ again:
>>   * menu_select - selects the next idle state to enter
>>   * @drv: cpuidle driver containing state data
>>   * @dev: the CPU
>> + * Returns -1 when no idle state is suitable
>>   */
>>  static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>>  {
>> @@ -292,17 +293,17 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>>  	int multiplier;
>>  	struct timespec t;
>>
>> -	if (data->needs_update) {
>> +	if (data->last_state_idx >= 0 && data->needs_update) {
>                ^^^^^
> Doesn't hurt, but actually unnecessary, since ->needs_update is set to 1
> only when index >= 0.

Right we do not need this check. I was assuming that needs_update would
be consistent with the index >= 0 only in the need_resched() case. But
needs_update will get unset each time the governor is invoked to be set
only if index >= 0 thereafter.

> 
>>  		menu_update(drv, dev);
>>  		data->needs_update = 0;
>>  	}
>>
>> -	data->last_state_idx = 0;
>> +	data->last_state_idx = -1;
>>  	data->exit_us = 0;
>>
>>  	/* Special case when user has set very strict latency requirement */
>>  	if (unlikely(latency_req == 0))
>> -		return 0;
>> +		return data->last_state_idx;
>>
>>  	/* determine the expected residency time, round up */
>>  	t = ktime_to_timespec(tick_nohz_get_sleep_length());
>>
> 
> What about the ladder governor? I know its not used that much in practice,
> but I think it would be good to update that as well, just to keep it
> consistent.

Yes this needs to be updated as well. But the ladder governor has a few
other details to take care of in addition to what is taken care of in
the menu governor by this patch. Hence I will be posting that separately.

Thanks

Regards
Preeti U Murthy
> 
> Regards,
> Srivatsa S. Bhat
> 
