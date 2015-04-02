Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31D301A09F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 22:44:39 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 2 Apr 2015 05:44:37 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 82A2B19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 05:35:40 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t32BiMvp40501286
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 04:44:22 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t32BiXOa000757
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 05:44:34 -0600
Message-ID: <551D2B9E.2060703@linux.vnet.ibm.com>
Date: Thu, 02 Apr 2015 17:14:30 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V2] clockevents: Fix cpu down race for hrtimer based
 broadcasting
References: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
 <20150402104226.GB21105@gmail.com> <551D2733.7040108@linux.vnet.ibm.com>
 <20150402113141.GB14370@gmail.com>
In-Reply-To: <20150402113141.GB14370@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: nicolas.pitre@linaro.org, peterz@infradead.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2015 05:01 PM, Ingo Molnar wrote:
> 
> * Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> 
>> On 04/02/2015 04:12 PM, Ingo Molnar wrote:
>>>
>>> * Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
>>>
>>>> It was found when doing a hotplug stress test on POWER, that the machine
>>>> either hit softlockups or rcu_sched stall warnings.  The issue was
>>>> traced to commit 7cba160ad789a powernv/cpuidle: Redesign idle states
>>>> management, which exposed the cpu down race with hrtimer based broadcast
>>>> mode(Commit 5d1638acb9f6(tick: Introduce hrtimer based broadcast). This
>>>> is explained below.
>>>>
>>>> Assume CPU1 is the CPU which holds the hrtimer broadcasting duty before
>>>> it is taken down.
>>>>
>>>> CPU0					CPU1
>>>>
>>>> cpu_down()				take_cpu_down()
>>>> 					disable_interrupts()
>>>>
>>>> cpu_die()
>>>>
>>>>  while(CPU1 != CPU_DEAD) {
>>>>   msleep(100);
>>>>    switch_to_idle();
>>>>     stop_cpu_timer();
>>>>      schedule_broadcast();
>>>>  }
>>>>
>>>> tick_cleanup_cpu_dead()
>>>> 	take_over_broadcast()
>>>>
>>>> So after CPU1 disabled interrupts it cannot handle the broadcast hrtimer
>>>> anymore, so CPU0 will be stuck forever.
>>>>
>>>> Fix this by explicitly taking over broadcast duty before cpu_die().
>>>> This is a temporary workaround. What we really want is a callback in the
>>>> clockevent device which allows us to do that from the dying CPU by
>>>> pushing the hrtimer onto a different cpu. That might involve an IPI and
>>>> is definitely more complex than this immediate fix.
>>>
>>> So why not use a suitable CPU_DOWN* notifier for this, instead of open 
>>> coding it all into a random place in the hotplug machinery?
>>
>> This is because each of them is unsuitable for a reason:
>>
>> 1. CPU_DOWN_PREPARE stage allows for a fail. The cpu in question may not
>> successfully go down. So we may pull the hrtimer unnecessarily.
> 
> Failure is really rare - and as long as things will continue to work 
> afterwards it's not a problem to pull the hrtimer to this CPU. Right?

We will need to move this function to the clockevents_notify() call
under CPU_DOWN_PREPARE. But I see that Tglx wanted to get rid of the
clockevents_notify() function because it is more of a multiplex call and
less of a notification mechanism and get rid of this function explicitly.

Regards
Preeti U Murthy
> 
> Thanks,
> 
> 	Ingo
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
