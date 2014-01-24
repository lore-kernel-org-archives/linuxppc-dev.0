Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0BEE82C0098
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 21:24:59 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 24 Jan 2014 03:24:56 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6205F3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 03:24:54 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0O8MRH112059052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 09:22:27 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0OAOrlF023753
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 03:24:53 -0700
Message-ID: <52E23EA0.7010803@linux.vnet.ibm.com>
Date: Fri, 24 Jan 2014 15:51:20 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] cpuidle/governors: Fix logic in selection of idle
 states
References: <20140117043351.21531.14192.stgit@preeti.in.ibm.com>
 <52DF815D.50104@linaro.org> <52E0F9ED.2010506@linux.vnet.ibm.com>
 <52E22D8A.5000305@linaro.org>
In-Reply-To: <52E22D8A.5000305@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, tuukka.tikkanen@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/24/2014 02:38 PM, Daniel Lezcano wrote:
> On 01/23/2014 12:15 PM, Preeti U Murthy wrote:
>> Hi Daniel,
>>
>> Thank you for the review.
>>
>> On 01/22/2014 01:59 PM, Daniel Lezcano wrote:
>>> On 01/17/2014 05:33 AM, Preeti U Murthy wrote:
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>>> index a55e68f..831b664 100644
>>>> --- a/drivers/cpuidle/cpuidle.c
>>>> +++ b/drivers/cpuidle/cpuidle.c
>>>> @@ -131,8 +131,9 @@ int cpuidle_idle_call(void)
>>>>
>>>>        /* ask the governor for the next state */
>>>>        next_state = cpuidle_curr_governor->select(drv, dev);
>>>> +
>>>> +    dev->last_residency = 0;
>>>>        if (need_resched()) {
>>>> -        dev->last_residency = 0;
>>>
>>> Why do you need to do this change ? ^^^^^
>>
>> So as to keep the last_residency consistent with the case that this patch
>> addresses: where no idle state could be selected due to strict latency
>> requirements or disabled states and hence the cpu exits without entering
>> idle. Else it would contain the stale value from the previous idle state
>> entry.
>>
>> But coming to think of it dev->last_residency is not used when the last
>> entered idle state index is -1.
>>
>> So I have reverted this change as well in the revised patch below along
>> with mentioning the reason in the last paragraph of the changelog.
>>
>>>
>>>>            /* give the governor an opportunity to reflect on the
>>>> outcome */
>>>>            if (cpuidle_curr_governor->reflect)
>>>>                cpuidle_curr_governor->reflect(dev, next_state);
>>>> @@ -140,6 +141,18 @@ int cpuidle_idle_call(void)
>>>>            return 0;
>>>>        }
>>>>
>>>> +    /* Unlike in the need_resched() case, we return here because the
>>>> +     * governor did not find a suitable idle state. However idle is
>>>> still
>>>> +     * in progress as we are not asked to reschedule. Hence we return
>>>> +     * without enabling interrupts.
>>>
>>> That will lead to a WARN.
>>>
>>>> +     * NOTE: The return code should still be success, since the
>>>> verdict of this
>>>> +     * call is "do not enter any idle state" and not a failed call
>>>> due to
>>>> +     * errors.
>>>> +     */
>>>> +    if (next_state < 0)
>>>> +        return 0;
>>>> +
>>>
>>> Returning from here breaks the symmetry of the trace.
>>
>> I have addressed the above concerns in the patch found below.
>> Does the rest of the patch look sound?
>>
>> Regards
>> Preeti U Murthy
>>
>> ----------------------------------------------------------------------
>>
>> cpuidle/governors: Fix logic in selection of idle states
>>
>> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>
>> The cpuidle governors today are not handling scenarios where no idle
>> state
>> can be chosen. Such scenarios coud arise if the user has disabled all the
>> idle states at runtime or the latency requirement from the cpus is
>> very strict.
>>
>> The menu governor returns 0th index of the idle state table when no other
>> idle state is suitable. This is even when the idle state corresponding
>> to this
>> index is disabled or the latency requirement is strict and the
>> exit_latency
>> of the lowest idle state is also not acceptable. Hence this patch
>> fixes this logic in the menu governor by defaulting to an idle state
>> index
>> of -1 unless any other state is suitable.
>>
>> The ladder governor needs a few more fixes in addition to that
>> required in the
>> menu governor. When the ladder governor decides to demote the idle
>> state of a
>> CPU, it does not check if the lower idle states are enabled. Add this
>> logic
>> in addition to the logic where it chooses an index of -1 if it can
>> neither
>> promote or demote the idle state of a cpu nor can it choose the
>> current idle
>> state.
>>
>> The cpuidle_idle_call() will return back if the governor decides upon not
>> entering any idle state. However it cannot return an error code
>> because all
>> archs have the logic today that if the call to cpuidle_idle_call()
>> fails, it
>> means that the cpuidle driver failed to *function*; for instance due to
>> errors during registration. As a result they end up deciding upon a
>> default idle state on their own, which could very well be a deep idle
>> state.
>> This is incorrect in cases where no idle state is suitable.
>>
>> Besides for the scenario that this patch is addressing, the call actually
>> succeeds. Its just that no idle state is thought to be suitable by the
>> governors.
>> Under such a circumstance return success code without entering any idle
>> state.
>>
>> The consequence of this patch additionally  on the menu governor is
>> that as
>> long as a valid idle state cannot be chosen, the cpuidle statistics
>> that this
>> governor uses to predict the next idle state remain untouched from the
>> last
>> valid idle state. This is because an idle state is not even being
>> predicted
>> in this path, hence there is no point correcting the prediction either.
>>
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>
>> Changes from V1:https://lkml.org/lkml/2014/1/14/26
>>
>> 1. Change the return code to success from -EINVAL due to the reason
>> mentioned
>> in the changelog.
>> 2. Add logic that the patch is addressing in the ladder governor as well.
>> 3. Added relevant comments and removed redundant logic as suggested in
>> the
>> above thread.
>> ---
>>   drivers/cpuidle/cpuidle.c          |   15 +++++
>>   drivers/cpuidle/governors/ladder.c |  101
>> ++++++++++++++++++++++++++----------
>>   drivers/cpuidle/governors/menu.c   |    7 +-
>>   3 files changed, 90 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index a55e68f..19d17e8 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -131,8 +131,9 @@ int cpuidle_idle_call(void)
>>
>>       /* ask the governor for the next state */
>>       next_state = cpuidle_curr_governor->select(drv, dev);
>> +
>> +    dev->last_residency = 0;
>>       if (need_resched()) {
> 
> What about if (need_resched() || next_state < 0) ?

Hmm.. I feel we need to distinguish between the need_resched() scenario
and the scenario when no idle state was suitable through the trace
points at-least.

This could help while debugging when we could find situations where
there are no tasks to run, yet the cpu is not entering any idle state.
The traces could help clearly point that no idle state was thought
suitable by the governor. Of course there are many other means to find
this out, but this seems rather straightforward. Hence having the
condition next_state < 0 between trace_cpu_idle*() would be apt IMHO.

Regards
Preeti U Murthy

> 
>> -        dev->last_residency = 0;
>>           /* give the governor an opportunity to reflect on the
>> outcome */
>>           if (cpuidle_curr_governor->reflect)
>>               cpuidle_curr_governor->reflect(dev, next_state);
>> @@ -141,6 +142,16 @@ int cpuidle_idle_call(void)
>>       }
>>
>>       trace_cpu_idle_rcuidle(next_state, dev->cpu);
>> +    /*
>> +     * NOTE: The return code should still be success, since the
>> verdict of
>> +     * this call is "do not enter any idle state". It is not a failed
>> call
>> +     * due to errors.
>> +     */
>> +    if (next_state < 0) {
>> +        entered_state = next_state;
>> +        local_irq_enable();
>> +        goto out;
>> +    }
>>
>>       broadcast = !!(drv->states[next_state].flags &
>> CPUIDLE_FLAG_TIMER_STOP);
>>
>> @@ -156,7 +167,7 @@ int cpuidle_idle_call(void)
>>       if (broadcast)
>>           clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
>>
>> -    trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>> +out:    trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>>
>>       /* give the governor an opportunity to reflect on the outcome */
>>       if (cpuidle_curr_governor->reflect)
