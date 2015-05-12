Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 924731A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 04:04:57 +1000 (AEST)
Received: by wicmc15 with SMTP id mc15so60239672wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 11:04:53 -0700 (PDT)
Message-ID: <555240C2.9010602@linaro.org>
Date: Tue, 12 May 2015 20:04:50 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <2602092.6h7ufczYGd@vostro.rjw.lan> <5551BCBF.2000806@linaro.org>
 <2919083.VPTOth98op@vostro.rjw.lan>
In-Reply-To: <2919083.VPTOth98op@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: rlippert@google.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org,
 peterz@infradead.org, linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/12/2015 03:23 PM, Rafael J. Wysocki wrote:
> On Tuesday, May 12, 2015 10:41:35 AM Daniel Lezcano wrote:
>> On 05/12/2015 01:31 AM, Rafael J. Wysocki wrote:
>>> On Monday, May 11, 2015 07:40:41 PM Daniel Lezcano wrote:
>>>> On 05/10/2015 01:15 AM, Rafael J. Wysocki wrote:
>>>>> On Saturday, May 09, 2015 10:33:05 PM Rafael J. Wysocki wrote:
>>>>>> On Saturday, May 09, 2015 10:11:41 PM Rafael J. Wysocki wrote:
>>>>>>> On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
>>>>>>>> Hi Rafael,
>>>>>>>>
>>>>>>>> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
>>>>>>>
>>>>>>> [cut]
>>>>>>>
>>>>>>>>>>
>>>>>>>>>> +	/* Take note of the planned idle state. */
>>>>>>>>>> +	idle_set_state(smp_processor_id(), target_state);
>>>>>>>>>
>>>>>>>>> And I wouldn't do this either.
>>>>>>>>>
>>>>>>>>> The behavior here is pretty much as though the driver demoted the state chosen
>>>>>>>>> by the governor and we don't call idle_set_state() again in those cases.
>>>>>>>>
>>>>>>>> Why is this wrong?
>>>>>>>
>>>>>>> It is not "wrong", but incomplete, because demotions done by the cpuidle driver
>>>>>>> should also be taken into account in the same way.
>>>>>>>
>>>>>>> But I'm seeing that the recent patch of mine that made cpuidle_enter_state()
>>>>>>> call default_idle_call() was a mistake, because it might confuse find_idlest_cpu()
>>>>>>> significantly as to what state the CPU is in.  I'll drop that one for now.
>>>>>>
>>>>>> OK, done.
>>>>>>
>>>>>> So after I've dropped it I think we need to do three things:
>>>>>> (1) Move the idle_set_state() calls to cpuidle_enter_state().
>>>>>> (2) Make cpuidle_enter_state() call default_idle_call() again, but this time
>>>>>>        do that *before* it has called idle_set_state() for target_state.
>>>>>> (3) Introduce demotion as per my last patch.
>>>>>>
>>>>>> Let me cut patches for that.
>>>>>
>>>>> Done as per the above and the patches follow in replies to this messge.
>>>>>
>>>>> All on top of the current linux-next branch of the linux-pm.git tree.
>>>>
>>>> IMO the resulting code is more and more confusing.
>>>
>>> Why is it confusing?
>>>
>>> What part of it is confusing?
>>>
>>> Patches [1-2/3] simply replace https://patchwork.kernel.org/patch/6326761/
>>> and I'm not sure why that would be confusing.
>>>
>>> Patch [3/3] simply causes cpuidle_enter_state() to pick up a more suitable
>>> state if tick_broadcast_enter() fails instead of returning an error code
>>> in that case.  What exactly is confusing in that?
>>>
>>>> Except I miss something, the tick_broadcast_enter can fail only if the
>>>> local timer of the current cpu is used as a broadcast timer (which is
>>>> the case today for PPC only).
>>>
>>> well, why does this matter?
>>>
>>>> The correct fix would be to tie this local timer with the cpu power
>>>> domain and disable the idle state powering down this domain like it was
>>>> done for the renesas cpuidle driver.
>>>>
>>>> IOW, the cpu power domain is in use (because of its local timer), so we
>>>> shouldn't shut it down.
>>>>
>>>> No ?
>>>
>>> Sorry, I'm not sure what you're talking about.
>>>
>>> The problem at hand is that tick_broadcast_enter() can fail and we need to
>>> handle that.  If we can prevent it from ever failing, that would be awesome,
>>> but quite honestly I don't see how to do that ATM.
>>
>> Ok, sorry. Let me clarify.
>>
>> You did a mechanism two years ago with pm_genpd_attach_cpuidle and
>> power_on/off. That disables a cpuidle state when a power domain is in use.
>>
>> The idea I was proposing is to reuse this approach.
>>
>> The logic is:
>>
>> "The local timer is in use, this idle state power downs this timer, then
>> disable it".
>
> I'm not sure it's about powering down.  Stopping rather (which may or may
> not involve powering down).
>
>> So it is when the broadcast timer is 'bound_on' a cpu, we disable the
>> idle states. That could be done via a loop looking for the TIMER_STOP
>> flag or via the power domain.
>>
>> Hence the cpuidle_select will never return a state which powers downs
>> the local cpu (because they are disabled) and tick_broadcast_enter can't
>> fail because it is never called.
>>
>> Does it make more sense ?
>
> Well, you've not explained what's confusing in the code after this series
> in the first place. :-)

It is not the series itself but the sum of the recent changes in this 
area makes the overall more and more difficult to maintain. But that's a 
personal opinion. Sounds like we are trying to catch the corner cases 
each time there is a change somewhere.

> Second, quite honestly, I don't see a connection to genpd here.

Probably I am not clear :)

The connection we have is the local timer and the cpuidle framework 
shutting it down. Why ? Because the local timer belongs to the cpu's 
power domain.

Using the genpd to describe this relation between an idle state and the 
devices impacted by via a power domain is, in my opinion, a nice 
abstraction and a good opportunity to integrate the different 
subsystems. Furthermore it is consistent with Kevin's investigation 
around the power domain and SoC idle.

Kevin ?

> What you seem to be saying is "maybe we can eliminate the need to check the
> return value of tick_broadcast_enter() in the idle loop if we proactively
> disable the TIMER_STOP idle states of a CPU when we start to use that CPU's
> timer as a broadcast one".

Well, not exactly. That's the consequence.

I meant, using any devices in a specific power domain makes impossible 
to shut it down.

The timer and the cpu belong to the same power domain, hence it should 
be impossible to reach an idle state where it is shut down.

The consequence is the tick_broadcast_enter *can't* fail by using this 
approach and we don't have to handle a corner case.

There are boards where some idle states are powering down the console 
because the power controller has larger power domain including cpu and 
console or i2c or dma. In order to handle this, there is some specific 
code in the cpuidle driver to check if the bus is in use.

IMO, we have exactly the same constraint here with the timer and we are 
handling it in another different way.

> So this seems to be about the timekeeping rather than power domains, because
> that's where the broadcast thing is done.

I disagree. It should be done via a common API (eg. pm_runtime_get/put).

> So the code setting up the CPU's
> timer for broadcast would pretty much need to pause cpuidle, go through the
> CPU's idle states and disable the TIMER_STOP ones.  And do the reverse when the
> timer is not going the be used for broadcast any more.  So question is whether
> or not this is actually really more straightforward than checking the return
> value of tick_broadcast_enter() in the idle loop after all.

I agree this is not straightforward and your changes are valid, even I 
think we can do something better by redesigning a bit.

But I guess I would have to provide a patchset for that ... :)

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
