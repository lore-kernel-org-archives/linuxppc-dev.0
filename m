Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 884562C0088
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 15:10:30 +1000 (EST)
Message-ID: <1347253812.2385.148.camel@pasglop>
Subject: Re: [RFC patch powerpc,trace] Avoid suspicious RCU usage reporting
 for some tracepoints
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Mon, 10 Sep 2012 15:10:12 +1000
In-Reply-To: <1347253133.2725.45.camel@ThinkPad-T420>
References: <1347253133.2725.45.camel@ThinkPad-T420>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-10 at 12:58 +0800, Li Zhong wrote:
> There are a few tracepoints in the interrupt code path, which is before
> irq_enter(), or after irq_exit(), like
> trace_irq_entry()/trace_irq_exit() in do_IRQ(),
> trace_timer_interrupt_entry()/trace_timer_interrupt_exit() in
> timer_interrupt(). 
> 
> If the interrupt is from idle(), and because tracepoint contains RCU
> read-side critical section, we could see following suspicious RCU usage
> reported:

 .../...

> This is because the RCU usage in interrupt context should be used in
> area marked by rcu_irq_enter()/rcu_irq_exit(), called in
> irq_enter()/irq_exit() respectively. 
> 
> Could we add a new tracepoint trace_***_rcuirq, like trace_***_rcuidle
> to avoid the report? like the code attached below.
> 
> Or could we just move these tracepoints inside the
> irq_enter()/irq_exit() area? (Seems not good for the timer_interrupt
> case). 

I'd say just move them in. Anton, any objection ?

> Thanks, Zhong
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/irq.c  |    4 ++--
>  arch/powerpc/kernel/time.c |    4 ++--
>  include/linux/tracepoint.h |   10 ++++++++++
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 1f017bb..f0ac4e7 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -489,7 +489,7 @@ void do_IRQ(struct pt_regs *regs)
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  	unsigned int irq;
>  
> -	trace_irq_entry(regs);
> +	trace_irq_entry_rcuirq(regs);
>  
>  	irq_enter();
>  
> @@ -514,7 +514,7 @@ void do_IRQ(struct pt_regs *regs)
>  	irq_exit();
>  	set_irq_regs(old_regs);
>  
> -	trace_irq_exit(regs);
> +	trace_irq_exit_rcuirq(regs);
>  }
>  
>  void __init init_IRQ(void)
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index e49e931..cbd6607 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -493,7 +493,7 @@ void timer_interrupt(struct pt_regs * regs)
>  	 */
>  	may_hard_irq_enable();
>  
> -	trace_timer_interrupt_entry(regs);
> +	trace_timer_interrupt_entry_rcuirq(regs);
>  
>  	__get_cpu_var(irq_stat).timer_irqs++;
>  
> @@ -532,7 +532,7 @@ void timer_interrupt(struct pt_regs * regs)
>  	irq_exit();
>  	set_irq_regs(old_regs);
>  
> -	trace_timer_interrupt_exit(regs);
> +	trace_timer_interrupt_exit_rcuirq(regs);
>  }
>  
>  /*
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 802de56..f7672d5 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -161,6 +161,16 @@ static inline void tracepoint_synchronize_unregister(void)
>  				rcu_idle_exit(),			\
>  				rcu_idle_enter());			\
>  	}								\
> +	static inline void trace_##name##_rcuirq(proto)			\
> +	{								\
> +		if (static_key_false(&__tracepoint_##name.key))		\
> +			__DO_TRACE(&__tracepoint_##name,		\
> +				TP_PROTO(data_proto),			\
> +				TP_ARGS(data_args),			\
> +				TP_CONDITION(cond),			\
> +				rcu_irq_enter(),			\
> +				rcu_irq_exit());			\
> +	}								\
>  	static inline int						\
>  	register_trace_##name(void (*probe)(data_proto), void *data)	\
>  	{								\
