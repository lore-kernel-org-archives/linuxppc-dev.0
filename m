Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com
 [IPv6:2a00:1450:400c:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BF3B1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 21:42:33 +1100 (AEDT)
Received: by wizk4 with SMTP id k4so10610049wiz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2015 03:42:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 2 Apr 2015 12:42:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] clockevents: Fix cpu down race for hrtimer based
 broadcasting
Message-ID: <20150402104226.GB21105@gmail.com>
References: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
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


* Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:

> It was found when doing a hotplug stress test on POWER, that the machine
> either hit softlockups or rcu_sched stall warnings.  The issue was
> traced to commit 7cba160ad789a powernv/cpuidle: Redesign idle states
> management, which exposed the cpu down race with hrtimer based broadcast
> mode(Commit 5d1638acb9f6(tick: Introduce hrtimer based broadcast). This
> is explained below.
> 
> Assume CPU1 is the CPU which holds the hrtimer broadcasting duty before
> it is taken down.
> 
> CPU0					CPU1
> 
> cpu_down()				take_cpu_down()
> 					disable_interrupts()
> 
> cpu_die()
> 
>  while(CPU1 != CPU_DEAD) {
>   msleep(100);
>    switch_to_idle();
>     stop_cpu_timer();
>      schedule_broadcast();
>  }
> 
> tick_cleanup_cpu_dead()
> 	take_over_broadcast()
> 
> So after CPU1 disabled interrupts it cannot handle the broadcast hrtimer
> anymore, so CPU0 will be stuck forever.
> 
> Fix this by explicitly taking over broadcast duty before cpu_die().
> This is a temporary workaround. What we really want is a callback in the
> clockevent device which allows us to do that from the dying CPU by
> pushing the hrtimer onto a different cpu. That might involve an IPI and
> is definitely more complex than this immediate fix.

So why not use a suitable CPU_DOWN* notifier for this, instead of open 
coding it all into a random place in the hotplug machinery?

Also, I improved the changelog (attached below), but decided against 
applying it until these questions are cleared - please use that for 
future versions of this patch.

Thanks,

	Ingo

===================>
>From 413fbf5193b330c5f478ef7aaeaaee08907a993e Mon Sep 17 00:00:00 2001
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 30 Mar 2015 14:59:19 +0530
Subject: [PATCH] clockevents: Fix cpu_down() race for hrtimer based broadcasting

It was found when doing a hotplug stress test on POWER, that the
machine either hit softlockups or rcu_sched stall warnings.  The
issue was traced to commit:

  7cba160ad789 ("powernv/cpuidle: Redesign idle states management")

which exposed the cpu_down() race with hrtimer based broadcast mode:

  5d1638acb9f6 ("tick: Introduce hrtimer based broadcast")

The race is the following:

Assume CPU1 is the CPU which holds the hrtimer broadcasting duty
before it is taken down.

	CPU0					CPU1

	cpu_down()				take_cpu_down()
						disable_interrupts()

	cpu_die()

	while (CPU1 != CPU_DEAD) {
		msleep(100);
		switch_to_idle();
		stop_cpu_timer();
		schedule_broadcast();
	}

	tick_cleanup_cpu_dead()
		take_over_broadcast()

So after CPU1 disabled interrupts it cannot handle the broadcast
hrtimer anymore, so CPU0 will be stuck forever.

Fix this by explicitly taking over broadcast duty before cpu_die().

This is a temporary workaround. What we really want is a callback
in the clockevent device which allows us to do that from the dying
CPU by pushing the hrtimer onto a different cpu. That might involve
an IPI and is definitely more complex than this immediate fix.

Changelog was picked up from:

    https://lkml.org/lkml/2015/2/16/213

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au
Cc: nicolas.pitre@linaro.org
Cc: peterz@infradead.org
Cc: rjw@rjwysocki.net
Fixes: http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
