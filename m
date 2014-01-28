Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B79582C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:10:04 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 04:10:02 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 1C2166E8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 06:09:55 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SB9xRf66846828
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 11:09:59 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SB9wvI026745
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 06:09:59 -0500
Message-ID: <52E78F35.2090106@linux.vnet.ibm.com>
Date: Tue, 28 Jan 2014 16:36:29 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] cpuidle/governors: Fix logic in selection of idle
 states
References: <20140117043351.21531.14192.stgit@preeti.in.ibm.com>
 <52DF815D.50104@linaro.org> <52E0F9ED.2010506@linux.vnet.ibm.com>
 <52E22D8A.5000305@linaro.org> <52E23EA0.7010803@linux.vnet.ibm.com>
 <52E76E6F.4000101@linaro.org>
In-Reply-To: <52E76E6F.4000101@linaro.org>
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

Hi Daniel,

On 01/28/2014 02:16 PM, Daniel Lezcano wrote:
> On 01/24/2014 11:21 AM, Preeti U Murthy wrote:
>> On 01/24/2014 02:38 PM, Daniel Lezcano wrote:
>>> On 01/23/2014 12:15 PM, Preeti U Murthy wrote:
>>>> Hi Daniel,
>>>>
>>>> Thank you for the review.
> 
> [ ... ]
> 
>>>> ---
>>>>    drivers/cpuidle/cpuidle.c          |   15 +++++
>>>>    drivers/cpuidle/governors/ladder.c |  101
>>>> ++++++++++++++++++++++++++----------
>>>>    drivers/cpuidle/governors/menu.c   |    7 +-
>>>>    3 files changed, 90 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>>> index a55e68f..19d17e8 100644
>>>> --- a/drivers/cpuidle/cpuidle.c
>>>> +++ b/drivers/cpuidle/cpuidle.c
>>>> @@ -131,8 +131,9 @@ int cpuidle_idle_call(void)
>>>>
>>>>        /* ask the governor for the next state */
>>>>        next_state = cpuidle_curr_governor->select(drv, dev);
>>>> +
>>>> +    dev->last_residency = 0;
>>>>        if (need_resched()) {
>>>
>>> What about if (need_resched() || next_state < 0) ?
>>
>> Hmm.. I feel we need to distinguish between the need_resched() scenario
>> and the scenario when no idle state was suitable through the trace
>> points at-least.
> 
> Well, I don't think so as soon as we don't care about the return value
> of cpuidle_idle_call in both cases.
> 
> The traces are following a specific format. That is if the state is -1
> (PWR_EVENT_EXIT), it means exiting the current idle state.
> 
> The idlestat tool [1] is using this traces to open - close transitions.
> 
> IMO, if the cpu is not entering idle, it should just exit without any
> idle traces.

Yes I see your point here.
> 
> This portion of code is a bit confusing because it is introduced by the
> menu governor updates post-poned when entering the next idle state (not
> exiting the current idle state with good reasons).

I am sorry but I don't understand this part. Which is the portion of the
code you refer to here? Also can you please elaborate on the above
statement?

Thanks

Regards
Preeti U Murthy
> 
>   -- Daniel
> 
> [1] http://git.linaro.org/power/idlestat.git
> 
>> This could help while debugging when we could find situations where
>> there are no tasks to run, yet the cpu is not entering any idle state.
>> The traces could help clearly point that no idle state was thought
>> suitable by the governor. Of course there are many other means to find
>> this out, but this seems rather straightforward. Hence having the
>> condition next_state < 0 between trace_cpu_idle*() would be apt IMHO.
>>
>> Regards
>> Preeti U Murthy
>>
>>>
>>>> -        dev->last_residency = 0;
>>>>            /* give the governor an opportunity to reflect on the
>>>> outcome */
>>>>            if (cpuidle_curr_governor->reflect)
>>>>                cpuidle_curr_governor->reflect(dev, next_state);
>>>> @@ -141,6 +142,16 @@ int cpuidle_idle_call(void)
>>>>        }
>>>>
>>>>        trace_cpu_idle_rcuidle(next_state, dev->cpu);
>>>> +    /*
>>>> +     * NOTE: The return code should still be success, since the
>>>> verdict of
>>>> +     * this call is "do not enter any idle state". It is not a failed
>>>> call
>>>> +     * due to errors.
>>>> +     */
>>>> +    if (next_state < 0) {
>>>> +        entered_state = next_state;
>>>> +        local_irq_enable();
>>>> +        goto out;
>>>> +    }
>>>>
>>>>        broadcast = !!(drv->states[next_state].flags &
>>>> CPUIDLE_FLAG_TIMER_STOP);
>>>>
>>>> @@ -156,7 +167,7 @@ int cpuidle_idle_call(void)
>>>>        if (broadcast)
>>>>            clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
>>>> &dev->cpu);
>>>>
>>>> -    trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>>>> +out:    trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>>>>
>>>>        /* give the governor an opportunity to reflect on the outcome */
>>>>        if (cpuidle_curr_governor->reflect)
>>
> 
> 
