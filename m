Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE64B1A0CA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 03:40:49 +1000 (AEST)
Received: by wgiu9 with SMTP id u9so135882486wgi.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 10:40:45 -0700 (PDT)
Message-ID: <5550E999.8080005@linaro.org>
Date: Mon, 11 May 2015 19:40:41 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <10239011.l6QLHlKIVm@vostro.rjw.lan> <3161640.llJtBoKCBr@vostro.rjw.lan>
 <8965830.CMQzZzsqm0@vostro.rjw.lan>
In-Reply-To: <8965830.CMQzZzsqm0@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: rlippert@google.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org,
 linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 Lina Iyer <lina.iyer@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2015 01:15 AM, Rafael J. Wysocki wrote:
> On Saturday, May 09, 2015 10:33:05 PM Rafael J. Wysocki wrote:
>> On Saturday, May 09, 2015 10:11:41 PM Rafael J. Wysocki wrote:
>>> On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
>>>> Hi Rafael,
>>>>
>>>> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
>>>
>>> [cut]
>>>
>>>>>>
>>>>>> +	/* Take note of the planned idle state. */
>>>>>> +	idle_set_state(smp_processor_id(), target_state);
>>>>>
>>>>> And I wouldn't do this either.
>>>>>
>>>>> The behavior here is pretty much as though the driver demoted the state chosen
>>>>> by the governor and we don't call idle_set_state() again in those cases.
>>>>
>>>> Why is this wrong?
>>>
>>> It is not "wrong", but incomplete, because demotions done by the cpuidle driver
>>> should also be taken into account in the same way.
>>>
>>> But I'm seeing that the recent patch of mine that made cpuidle_enter_state()
>>> call default_idle_call() was a mistake, because it might confuse find_idlest_cpu()
>>> significantly as to what state the CPU is in.  I'll drop that one for now.
>>
>> OK, done.
>>
>> So after I've dropped it I think we need to do three things:
>> (1) Move the idle_set_state() calls to cpuidle_enter_state().
>> (2) Make cpuidle_enter_state() call default_idle_call() again, but this time
>>      do that *before* it has called idle_set_state() for target_state.
>> (3) Introduce demotion as per my last patch.
>>
>> Let me cut patches for that.
>
> Done as per the above and the patches follow in replies to this messge.
>
> All on top of the current linux-next branch of the linux-pm.git tree.

IMO the resulting code is more and more confusing.

Except I miss something, the tick_broadcast_enter can fail only if the 
local timer of the current cpu is used as a broadcast timer (which is 
the case today for PPC only).

The correct fix would be to tie this local timer with the cpu power 
domain and disable the idle state powering down this domain like it was 
done for the renesas cpuidle driver.

IOW, the cpu power domain is in use (because of its local timer), so we 
shouldn't shut it down.

No ?

I am aware this is not easily fixable because the genpd framework is 
incomplete and has some restrictions but I believe it is worth to have a 
discussion. Add Kevin and Ulf in Cc.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
