Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 3F930B7F1B
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 09:40:31 +1100 (EST)
Message-ID: <4AE89936.6080803@ru.mvista.com>
Date: Wed, 28 Oct 2009 22:19:18 +0300
From: Valentine <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/ppc64: Use preempt_schedule_irq instead of
	preempt_schedule
References: <20091019182858.GA10495@ru.mvista.com>	
	<1256601324.2076.49.camel@pasglop>
	<1256622077.11607.85.camel@pasglop>
In-Reply-To: <1256622077.11607.85.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> So I _think_ that the irqs on/off accounting for lockdep isn't quite
>> right. What do you think of this slightly modified version ? I've only
>> done a quick boot test on a G5 with lockdep enabled and a played a bit,
>> nothing shows up so far but it's definitely not conclusive.
>>
>> The main difference is that I call trace_hardirqs_off to "advertise"
>> the fact that we are soft-disabling (it could be a dup, but at this
>> stage this is no big deal, but it's not always, like in syscall return
>> the kernel thinks we have interrupts enabled and could thus get out
>> of sync without that).
>>
>> I also mark the PACA hard disable to reflect the MSR:EE state before
>> calling into preempt_schedule_irq().
> 
> Allright, second thought :-)
> 
> It's probably simpler to just keep hardirqs off. Code is smaller and
> simpler and the scheduler will re-enable them soon enough anyways.
> 
> This version of the patch also spaces the code a bit and adds comments
> which makes them (the code and the patch) more readable.
> 

This one seems to work fine on pasemi and another maple-compatible board.

> Cheers,
> Ben.
>  
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> [PATCH v3] powerpc/ppc64: Use preempt_schedule_irq instead of preempt_schedule
> 
> Based on an original patch by Valentine Barshak <vbarshak@ru.mvista.com>
> 
> Use preempt_schedule_irq to prevent infinite irq-entry and
> eventual stack overflow problems with fast-paced IRQ sources.
> 
> This kind of problems has been observed on the PASemi Electra IDE
> controller. We have to make sure we are soft-disabled before calling
> preempt_schedule_irq and hard disable interrupts after that
> to avoid unrecoverable exceptions.
> 
> This patch also moves the "clrrdi r9,r1,THREAD_SHIFT" out of
> the #ifdef CONFIG_PPC_BOOK3E scope, since r9 is clobbered
> and has to be restored in both cases.
> ---
>  arch/powerpc/kernel/entry_64.S |   41 ++++++++++++++++++++-------------------
>  1 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index f9fd54b..9763267 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -658,42 +658,43 @@ do_work:
>  	cmpdi	r0,0
>  	crandc	eq,cr1*4+eq,eq
>  	bne	restore
> -	/* here we are preempting the current task */
> -1:
> -#ifdef CONFIG_TRACE_IRQFLAGS
> -	bl	.trace_hardirqs_on
> -	/* Note: we just clobbered r10 which used to contain the previous
> -	 * MSR before the hard-disabling done by the caller of do_work.
> -	 * We don't have that value anymore, but it doesn't matter as
> -	 * we will hard-enable unconditionally, we can just reload the
> -	 * current MSR into r10
> +
> +	/* Here we are preempting the current task.
> +	 *
> +	 * Ensure interrupts are soft-disabled. We also properly mark
> +	 * the PACA to reflect the fact that they are hard-disabled
> +	 * and trace the change
>  	 */
> -	mfmsr	r10
> -#endif /* CONFIG_TRACE_IRQFLAGS */
> -	li	r0,1
> +	li	r0,0
>  	stb	r0,PACASOFTIRQEN(r13)
>  	stb	r0,PACAHARDIRQEN(r13)

I'm just not sure that we need to clear HARDIRQEN here, since we don't 
really hard-disable the the interrupts.

Thanks,
Val.

> +	TRACE_DISABLE_INTS
> +
> +	/* Call the scheduler with soft IRQs off */
> +1:	bl	.preempt_schedule_irq
> +
> +	/* Hard-disable interrupts again (and update PACA) */
>  #ifdef CONFIG_PPC_BOOK3E
> -	wrteei	1
> -	bl	.preempt_schedule
>  	wrteei	0
>  #else
> -	ori	r10,r10,MSR_EE
> -	mtmsrd	r10,1		/* reenable interrupts */
> -	bl	.preempt_schedule
>  	mfmsr	r10
> -	clrrdi	r9,r1,THREAD_SHIFT
> -	rldicl	r10,r10,48,1	/* disable interrupts again */
> +	rldicl	r10,r10,48,1
>  	rotldi	r10,r10,16
>  	mtmsrd	r10,1
>  #endif /* CONFIG_PPC_BOOK3E */
> +	li	r0,0
> +	stb	r0,PACAHARDIRQEN(r13)
> +
> +	/* Re-test flags and eventually loop */
> +	clrrdi	r9,r1,THREAD_SHIFT
>  	ld	r4,TI_FLAGS(r9)
>  	andi.	r0,r4,_TIF_NEED_RESCHED
>  	bne	1b
>  	b	restore
>  
>  user_work:
> -#endif
> +#endif /* CONFIG_PREEMPT */
> +
>  	/* Enable interrupts */
>  #ifdef CONFIG_PPC_BOOK3E
>  	wrteei	1
