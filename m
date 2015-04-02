Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7DE01A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 22:26:03 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 2 Apr 2015 05:26:01 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4FD4B1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 05:17:09 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t32BPiQB33554512
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 04:25:44 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t32BPuMo029416
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 05:25:57 -0600
Message-ID: <551D2733.7040108@linux.vnet.ibm.com>
Date: Thu, 02 Apr 2015 16:55:39 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>, peterz@infradead.org
Subject: Re: [PATCH V2] clockevents: Fix cpu down race for hrtimer based
 broadcasting
References: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
 <20150402104226.GB21105@gmail.com>
In-Reply-To: <20150402104226.GB21105@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: nicolas.pitre@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2015 04:12 PM, Ingo Molnar wrote:
> 
> * Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> 
>> It was found when doing a hotplug stress test on POWER, that the machine
>> either hit softlockups or rcu_sched stall warnings.  The issue was
>> traced to commit 7cba160ad789a powernv/cpuidle: Redesign idle states
>> management, which exposed the cpu down race with hrtimer based broadcast
>> mode(Commit 5d1638acb9f6(tick: Introduce hrtimer based broadcast). This
>> is explained below.
>>
>> Assume CPU1 is the CPU which holds the hrtimer broadcasting duty before
>> it is taken down.
>>
>> CPU0					CPU1
>>
>> cpu_down()				take_cpu_down()
>> 					disable_interrupts()
>>
>> cpu_die()
>>
>>  while(CPU1 != CPU_DEAD) {
>>   msleep(100);
>>    switch_to_idle();
>>     stop_cpu_timer();
>>      schedule_broadcast();
>>  }
>>
>> tick_cleanup_cpu_dead()
>> 	take_over_broadcast()
>>
>> So after CPU1 disabled interrupts it cannot handle the broadcast hrtimer
>> anymore, so CPU0 will be stuck forever.
>>
>> Fix this by explicitly taking over broadcast duty before cpu_die().
>> This is a temporary workaround. What we really want is a callback in the
>> clockevent device which allows us to do that from the dying CPU by
>> pushing the hrtimer onto a different cpu. That might involve an IPI and
>> is definitely more complex than this immediate fix.
> 
> So why not use a suitable CPU_DOWN* notifier for this, instead of open 
> coding it all into a random place in the hotplug machinery?

This is because each of them is unsuitable for a reason:

1. CPU_DOWN_PREPARE stage allows for a fail. The cpu in question may not
successfully go down. So we may pull the hrtimer unnecessarily.

2. CPU_DYING notifiers are run on the cpu that is going down. So the
alternative would be to IPI an online cpu to take up the broadcast duty.

3. CPU_DEAD and CPU_POST_DEAD stages both have the drawback described in
the changelog.

I hope I got your question right.

Regards
Preeti U Murthy
> 
> Also, I improved the changelog (attached below), but decided against 
> applying it until these questions are cleared - please use that for 
> future versions of this patch.
> 
> Thanks,
> 
> 	Ingo
> 
> ===================>
> From 413fbf5193b330c5f478ef7aaeaaee08907a993e Mon Sep 17 00:00:00 2001
> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Date: Mon, 30 Mar 2015 14:59:19 +0530
> Subject: [PATCH] clockevents: Fix cpu_down() race for hrtimer based broadcasting
> 
> It was found when doing a hotplug stress test on POWER, that the
> machine either hit softlockups or rcu_sched stall warnings.  The
> issue was traced to commit:
> 
>   7cba160ad789 ("powernv/cpuidle: Redesign idle states management")
> 
> which exposed the cpu_down() race with hrtimer based broadcast mode:
> 
>   5d1638acb9f6 ("tick: Introduce hrtimer based broadcast")
> 
> The race is the following:
> 
> Assume CPU1 is the CPU which holds the hrtimer broadcasting duty
> before it is taken down.
> 
> 	CPU0					CPU1
> 
> 	cpu_down()				take_cpu_down()
> 						disable_interrupts()
> 
> 	cpu_die()
> 
> 	while (CPU1 != CPU_DEAD) {
> 		msleep(100);
> 		switch_to_idle();
> 		stop_cpu_timer();
> 		schedule_broadcast();
> 	}
> 
> 	tick_cleanup_cpu_dead()
> 		take_over_broadcast()
> 
> So after CPU1 disabled interrupts it cannot handle the broadcast
> hrtimer anymore, so CPU0 will be stuck forever.
> 
> Fix this by explicitly taking over broadcast duty before cpu_die().
> 
> This is a temporary workaround. What we really want is a callback
> in the clockevent device which allows us to do that from the dying
> CPU by pushing the hrtimer onto a different cpu. That might involve
> an IPI and is definitely more complex than this immediate fix.
> 
> Changelog was picked up from:
> 
>     https://lkml.org/lkml/2015/2/16/213
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Nicolas Pitre <nico@linaro.org>
> Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: mpe@ellerman.id.au
> Cc: nicolas.pitre@linaro.org
> Cc: peterz@infradead.org
> Cc: rjw@rjwysocki.net
> Fixes: http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
> 
