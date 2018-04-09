Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KP6h4BFKzDqyH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 18:46:36 +1000 (AEST)
Message-ID: <1523263589.11062.20.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: irq_work avoid immediate interrupt when
 raised with hard irqs enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 09 Apr 2018 18:46:29 +1000
In-Reply-To: <20180405143146.4285-1-npiggin@gmail.com>
References: <20180405143146.4285-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-04-06 at 00:31 +1000, Nicholas Piggin wrote:
> irq_work_raise should not schedule the hardware decrementer interrupt
> unless it is called from NMI context. Doing so often just results in an
> immediate masked decrementer interrupt:
> 
>    <...>-550    90d...    4us : update_curr_rt <-dequeue_task_rt
>    <...>-550    90d...    5us : dbs_update_util_handler <-update_curr_rt
>    <...>-550    90d...    6us : arch_irq_work_raise <-irq_work_queue
>    <...>-550    90d...    7us : soft_nmi_interrupt <-soft_nmi_common
>    <...>-550    90d...    7us : printk_nmi_enter <-soft_nmi_interrupt
>    <...>-550    90d.Z.    8us : rcu_nmi_enter <-soft_nmi_interrupt
>    <...>-550    90d.Z.    9us : rcu_nmi_exit <-soft_nmi_interrupt
>    <...>-550    90d...    9us : printk_nmi_exit <-soft_nmi_interrupt
>    <...>-550    90d...   10us : cpuacct_charge <-update_curr_rt
> 
> Set the decrementer pending in the irq_happened mask directly, rather
> than having the masked decrementer handler do it.

Setting the paca field needs hard irqs off... also preempt_disable
doesn't look necessary if IRQs are off.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/time.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index a32823dcd9a4..9d1cc183c974 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -510,6 +510,35 @@ static inline void clear_irq_work_pending(void)
>  		"i" (offsetof(struct paca_struct, irq_work_pending)));
>  }
>  
> +void arch_irq_work_raise(void)
> +{
> +	WARN_ON(!irqs_disabled());
> +
> +	preempt_disable();
> +	set_irq_work_pending_flag();
> +	/*
> +	 * Regular iterrupts will check pending irq_happened as they return,
> +	 * or process context when it next enables interrupts, so the
> +	 * decrementer can be scheduled there.
> +	 *
> +	 * NMI interrupts do not, so setting the decrementer hardware
> +	 * interrupt to fire ensures the work runs upon RI (if it's to a
> +	 * MSR[EE]=1 context). We do not want to do this in other contexts
> +	 * because if interrupts are hard enabled, the decrementer will
> +	 * fire immediately here and just go to the masked handler to be
> +	 * recorded in irq_happened.
> +	 *
> +	 * BookE does not support this yet, it must audit all NMI
> +	 * interrupt handlers call nmi_enter().
> +	 */
> +	if (IS_ENABLED(CONFIG_BOOKE) || in_nmi()) {
> +		set_dec(1);
> +	} else {
> +		local_paca->irq_happened |= PACA_IRQ_DEC;
> +	}
> +	preempt_enable();
> +}
> +
>  #else /* 32-bit */
>  
>  DEFINE_PER_CPU(u8, irq_work_pending);
> @@ -518,16 +547,18 @@ DEFINE_PER_CPU(u8, irq_work_pending);
>  #define test_irq_work_pending()		__this_cpu_read(irq_work_pending)
>  #define clear_irq_work_pending()	__this_cpu_write(irq_work_pending, 0)
>  
> -#endif /* 32 vs 64 bit */
> -
>  void arch_irq_work_raise(void)
>  {
> +	WARN_ON(!irqs_disabled());
> +
>  	preempt_disable();
>  	set_irq_work_pending_flag();
>  	set_dec(1);
>  	preempt_enable();
>  }
>  
> +#endif /* 32 vs 64 bit */
> +
>  #else  /* CONFIG_IRQ_WORK */
>  
>  #define test_irq_work_pending()	0
