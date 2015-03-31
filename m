Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
 [209.85.216.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03EA71A0BC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 14:11:09 +1100 (AEDT)
Received: by qcay5 with SMTP id y5so3879181qca.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 20:11:07 -0700 (PDT)
Date: Mon, 30 Mar 2015 23:11:03 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] clockevents: Fix cpu down race for hrtimer based
 broadcasting
In-Reply-To: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
Message-ID: <alpine.LFD.2.11.1503301930590.25806@knanqh.ubzr>
References: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 30 Mar 2015, Preeti U Murthy wrote:

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
> 
> Fixes:
> http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
> [Changelog drawn from: https://lkml.org/lkml/2015/2/16/213]

The lock-up I was experiencing with v1 of this patch is no longer 
reproducible with this one.

Tested-by: Nicolas Pitre <nico@linaro.org>

> ---
> Change from V1: https://lkml.org/lkml/2015/2/26/11
> 1. Decoupled this fix from the kernel/time cleanup patches. V1 had a fail
> related to the cleanup which needs to be fixed. But since this bug fix
> is independent of this and needs to go in quickly, the patch is being posted
> out separately to be merged.
> 
>  include/linux/tick.h         |   10 +++++++---
>  kernel/cpu.c                 |    2 ++
>  kernel/time/tick-broadcast.c |   19 +++++++++++--------
>  3 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 9c085dc..3069256 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -94,14 +94,18 @@ extern void tick_cancel_sched_timer(int cpu);
>  static inline void tick_cancel_sched_timer(int cpu) { }
>  # endif
>  
> -# ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +# if defined CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>  extern struct tick_device *tick_get_broadcast_device(void);
>  extern struct cpumask *tick_get_broadcast_mask(void);
>  
> -#  ifdef CONFIG_TICK_ONESHOT
> +#  if defined CONFIG_TICK_ONESHOT
>  extern struct cpumask *tick_get_broadcast_oneshot_mask(void);
> +extern void tick_takeover(int deadcpu);
> +# else
> +static inline void tick_takeover(int deadcpu) {}
>  #  endif
> -
> +# else
> +static inline void tick_takeover(int deadcpu) {}
>  # endif /* BROADCAST */
>  
>  # ifdef CONFIG_TICK_ONESHOT
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 1972b16..f9ca351 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -20,6 +20,7 @@
>  #include <linux/gfp.h>
>  #include <linux/suspend.h>
>  #include <linux/lockdep.h>
> +#include <linux/tick.h>
>  #include <trace/events/power.h>
>  
>  #include "smpboot.h"
> @@ -411,6 +412,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>  	while (!idle_cpu(cpu))
>  		cpu_relax();
>  
> +	tick_takeover(cpu);
>  	/* This actually kills the CPU. */
>  	__cpu_die(cpu);
>  
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 066f0ec..0fd6634 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -669,14 +669,19 @@ static void broadcast_shutdown_local(struct clock_event_device *bc,
>  	clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN);
>  }
>  
> -static void broadcast_move_bc(int deadcpu)
> +void tick_takeover(int deadcpu)
>  {
> -	struct clock_event_device *bc = tick_broadcast_device.evtdev;
> +	struct clock_event_device *bc;
> +	unsigned long flags;
>  
> -	if (!bc || !broadcast_needs_cpu(bc, deadcpu))
> -		return;
> -	/* This moves the broadcast assignment to this cpu */
> -	clockevents_program_event(bc, bc->next_event, 1);
> +	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
> +	bc = tick_broadcast_device.evtdev;
> +
> +	if (bc && broadcast_needs_cpu(bc, deadcpu)) {
> +		/* This moves the broadcast assignment to this cpu */
> +		clockevents_program_event(bc, bc->next_event, 1);
> +	}
> +	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
>  }
>  
>  /*
> @@ -913,8 +918,6 @@ void tick_shutdown_broadcast_oneshot(unsigned int *cpup)
>  	cpumask_clear_cpu(cpu, tick_broadcast_pending_mask);
>  	cpumask_clear_cpu(cpu, tick_broadcast_force_mask);
>  
> -	broadcast_move_bc(cpu);
> -
>  	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
>  }
>  
> 
> 
