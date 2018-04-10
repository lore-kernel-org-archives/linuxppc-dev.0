Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KzfR2lpSzDqws
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 17:42:38 +1000 (AEST)
Date: Tue, 10 Apr 2018 09:42:29 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Piggin <npiggin@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Occasionally losing the tick_sched_timer
In-Reply-To: <20180410121618.4fffffcc@roar.ozlabs.ibm.com>
Message-ID: <alpine.DEB.2.21.1804100923430.2058@nanos.tec.linutronix.de>
References: <20180410121618.4fffffcc@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nick,

On Tue, 10 Apr 2018, Nicholas Piggin wrote:
> We are seeing rare hard lockup watchdog timeouts, a CPU seems to have no
> more timers scheduled, despite hard and soft lockup watchdogs should have
> their heart beat timers and probably many others.
>
> The reproducer we have is running a KVM workload. The lockup is in the
> host kernel, quite rare but we may be able to slowly test things.
> 
> I have a sysrq+q snippet. CPU3 is the stuck one, you can see its tick has
> stopped for a long time and no hrtimer active. Included CPU4 for what the
> other CPUs look like.
> 
> Thomas do you have any ideas on what we might look for, or if we can add
> some BUG_ON()s to catch this at its source?

Not really. Tracing might be a more efficient tool that random BUG_ONs.

> - CPU3 is sitting in its cpuidle loop (polling idle with all other idle
>   states disabled).
> 
> - `taskset -c 3 ls` basically revived the CPU and got timers running again.

Which is not surprising because that kicks the CPU out of idle and starts
the tick timer again.

Does this restart the watchdog timers as well?

> cpu: 3
>  clock 0:
>   .base:       00000000df30f5ab
>   .index:      0
>   .resolution: 1 nsecs
>   .get_time:   ktime_get
>   .offset:     0 nsecs
> active timers:

So in theory the soft lockup watchdog hrtimer should be queued here.

>   .expires_next   : 9223372036854775807 nsecs
>   .hres_active    : 1
>   .nr_events      : 1446533
>   .nr_retries     : 1434
>   .nr_hangs       : 0
>   .max_hang_time  : 0
>   .nohz_mode      : 2
>   .last_tick      : 17763120000000 nsecs
>   .tick_stopped   : 1
>   .idle_jiffies   : 4296713609
>   .idle_calls     : 2573133
>   .idle_sleeps    : 1957794

>   .idle_waketime  : 59550238131639 nsecs
>   .idle_sleeptime : 17504617295679 nsecs
>   .iowait_sleeptime: 719978688 nsecs
>   .last_jiffies   : 4296713608

So this was the last time when the CPU came out of idle:

>   .idle_exittime  : 17763110009176 nsecs

Here it went back into idle:

>   .idle_entrytime : 17763129999625 nsecs

And this was the next timer wheel timer due for expiry:

>   .next_timer     : 17763130000000
>   .idle_expires   : 17763130000000 nsecs

which makes no sense whatsoever, but this might be stale information. Can't
tell.

> cpu: 4
>  clock 0:
>   .base:       0000000007d8226b
>   .index:      0
>   .resolution: 1 nsecs
>   .get_time:   ktime_get
>   .offset:     0 nsecs
> active timers: #0: <00000000a73e543a>, tick_sched_timer, S:01
>  	 	 # expires at 59552950000000-59552950000000 nsecs [in 2685654802 to 2685654802 nsecs]

The tick timer is scheduled because the next timer wheel timer is due at
59552950000000, which might be the hard watchdog timer

>  		 #1: <000000009b4a3b88>, hrtimer_wakeup, S:01
>		 # expires at 59602585423025-59602642458243 nsecs [in 52321077827 to 52378113045 nsecs]

That might be the soft lockup hrtimer.

I'd try to gather more information about the chain of events via tracing
and stop the tracer once the lockup detector hits.

Thanks,

	tglx
