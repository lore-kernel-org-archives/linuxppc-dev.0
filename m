Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75CDF1A0C41
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 08:01:22 +1100 (AEDT)
Date: Thu, 22 Jan 2015 22:00:57 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] cpuidle: Add missing checks to the exit condition of
 cpu_idle_poll()
In-Reply-To: <20150121105655.15279.59626.stgit@preeti.in.ibm.com>
Message-ID: <alpine.DEB.2.11.1501222200460.5526@nanos>
References: <20150121105655.15279.59626.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Jan 2015, Preeti U Murthy wrote:

> cpu_idle_poll() is entered into when either the cpu_idle_force_poll is set or
> tick_check_broadcast_expired() returns true. The exit condition from
> cpu_idle_poll() is tif_need_resched().
> 
> However this does not take into account scenarios where cpu_idle_force_poll
> changes or tick_check_broadcast_expired() returns false, without setting
> the resched flag. So a cpu will be caught in cpu_idle_poll() needlessly,
> thereby wasting power. Add an explicit check on cpu_idle_force_poll and
> tick_check_broadcast_expired() to the exit condition of cpu_idle_poll()
> to avoid this.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
> Changes from V1: Modified the Changelog
> 
>  kernel/sched/idle.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index c47fce7..aaf1c1d 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -47,7 +47,8 @@ static inline int cpu_idle_poll(void)
>  	rcu_idle_enter();
>  	trace_cpu_idle_rcuidle(0, smp_processor_id());
>  	local_irq_enable();
> -	while (!tif_need_resched())
> +	while (!tif_need_resched() &&
> +		(cpu_idle_force_poll || tick_check_broadcast_expired()))
>  		cpu_relax();
>  	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
>  	rcu_idle_exit();
> 
> 
