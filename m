Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2B2B1A0CBC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 22:21:47 +1100 (AEDT)
Date: Tue, 20 Jan 2015 12:21:24 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] idle/tick-broadcast: Exit cpu idle poll loop when cleared
 from tick_broadcast_force_mask
In-Reply-To: <20150119052754.20256.54721.stgit@preeti.in.ibm.com>
Message-ID: <alpine.DEB.2.11.1501201216420.5526@nanos>
References: <20150119052754.20256.54721.stgit@preeti.in.ibm.com>
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

On Mon, 19 Jan 2015, Preeti U Murthy wrote:
> An idle cpu enters cpu_idle_poll() if it is set in the tick_broadcast_force_mask.
> This is so that it does not incur the overhead of entering idle states when it is expected
> to be woken up anytime then through a broadcast IPI. The condition that forces an exit out
> of the idle polling is the check on setting of the TIF_NEED_RESCHED flag for the idle thread.
> 
> When the broadcast IPI does arrive, it is not guarenteed that the handler sets the
> TIF_NEED_RESCHED flag. Hence although the cpu is cleared in the tick_broadcast_force_mask,
> it continues to loop in cpu_idle_poll unnecessarily wasting power. Hence exit the idle
> poll loop if the tick_broadcast_force_mask gets cleared and enter idle states.
> 
> Of course if the cpu has entered cpu_idle_poll() on being asked to poll explicitly,
> it continues to poll till it is asked to reschedule.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
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

You explain the tick_check_broadcast_expired() bit, but what about the
cpu_idle_force_poll part?

Thanks,

	tglx
