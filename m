Return-Path: <shhuiw@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79D52B6FFC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2012 10:53:25 +1000 (EST)
Received: by obbup19 with SMTP id up19so6923158obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2012 17:53:22 -0700 (PDT)
Message-ID: <4FB05776.4010104@gmail.com>
Date: Mon, 14 May 2012 08:53:10 +0800
From: Wang Sheng-Hui <shhuiw@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/irq: Fix another case of lazy IRQ state getting
 out of sync
References: <20120511002354.GA8895@us.ibm.com>	
 <1336696621.3881.72.camel@pasglop> <1336702358.3881.77.camel@pasglop>
In-Reply-To: <1336702358.3881.77.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@au1.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2012年05月11日 10:12, Benjamin Herrenschmidt wrote:
> So we have another case of paca->irq_happened getting out of
> sync with the HW irq state. This can happen when a perfmon
> interrupt occurs while soft disabled, as it will return to a
> soft disabled but hard enabled context while leaving a stale
> PACA_IRQ_HARD_DIS flag set.
> 
> This patch fixes it, and also adds a test for the condition
> of those flags being out of sync in arch_local_irq_restore()
> when CONFIG_TRACE_IRQFLAGS is enabled.
> 
> This helps catching those gremlins faster (and so far I
> can't seem see any anymore, so that's good news).

This patch can work on my system.

Verified.

Thanks,

> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Please test ASAP as I need to send that to Linus today
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index f8a7a1a..293e283 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -588,23 +588,19 @@ _GLOBAL(ret_from_except_lite)
>  fast_exc_return_irq:
>  restore:
>  	/*
> -	 * This is the main kernel exit path, we first check if we
> -	 * have to change our interrupt state.
> +	 * This is the main kernel exit path. First we check if we
> +	 * are about to re-enable interrupts
>  	 */
>  	ld	r5,SOFTE(r1)
>  	lbz	r6,PACASOFTIRQEN(r13)
> -	cmpwi	cr1,r5,0
> -	cmpw	cr0,r5,r6
> -	beq	cr0,4f
> +	cmpwi	cr0,r5,0
> +	beq	restore_irq_off
>  
> -	/* We do, handle disable first, which is easy */
> -	bne	cr1,3f;
> - 	li	r0,0
> -	stb	r0,PACASOFTIRQEN(r13);
> -	TRACE_DISABLE_INTS
> -	b	4f
> +	/* We are enabling, were we already enabled ? Yes, just return */
> +	cmpwi	cr0,r6,1
> +	beq	cr0,do_restore
>  
> -3:	/*
> +	/*
>  	 * We are about to soft-enable interrupts (we are hard disabled
>  	 * at this point). We check if there's anything that needs to
>  	 * be replayed first.
> @@ -626,7 +622,7 @@ restore_no_replay:
>  	/*
>  	 * Final return path. BookE is handled in a different file
>  	 */
> -4:
> +do_restore:
>  #ifdef CONFIG_PPC_BOOK3E
>  	b	.exception_return_book3e
>  #else
> @@ -700,6 +696,25 @@ fast_exception_return:
>  #endif /* CONFIG_PPC_BOOK3E */
>  
>  	/*
> +	 * We are returning to a context with interrupts soft disabled.
> +	 *
> +	 * However, we may also about to hard enable, so we need to
> +	 * make sure that in this case, we also clear PACA_IRQ_HARD_DIS
> +	 * or that bit can get out of sync and bad things will happen
> +	 */
> +restore_irq_off:
> +	ld	r3,_MSR(r1)
> +	lbz	r7,PACAIRQHAPPENED(r13)
> +	andi.	r0,r3,MSR_EE
> +	beq	1f
> +	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
> +	stb	r7,PACAIRQHAPPENED(r13)
> +1:	li	r0,0
> +	stb	r0,PACASOFTIRQEN(r13);
> +	TRACE_DISABLE_INTS
> +	b	do_restore
> +
> +	/*
>  	 * Something did happen, check if a re-emit is needed
>  	 * (this also clears paca->irq_happened)
>  	 */
> @@ -748,6 +763,9 @@ restore_check_irq_replay:
>  #endif /* CONFIG_PPC_BOOK3E */
>  1:	b	.ret_from_except /* What else to do here ? */
>   
> +
> +
> +3:
>  do_work:
>  #ifdef CONFIG_PREEMPT
>  	andi.	r0,r3,MSR_PR	/* Returning to user mode? */
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 5ec1b23..fe8cf8e 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -229,6 +229,19 @@ notrace void arch_local_irq_restore(unsigned long en)
>  	 */
>  	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
>  		__hard_irq_disable();
> +#ifdef CONFIG_TRACE_IRQFLAG
> +	else {
> +		/*
> +		 * We should already be hard disabled here. We had bugs
> +		 * where that wasn't the case so let's dbl check it and
> +		 * warn if we are wrong. Only do that when IRQ tracing
> +		 * is enabled as mfmsr() can be costly.
> +		 */
> +		if (WARN_ON(mfmsr() & MSR_EE))
> +			__hard_irq_disable();
> +	}
> +#endif /* CONFIG_TRACE_IRQFLAG */
> +
>  	set_soft_enabled(0);
>  
>  	/*
> 
> 
