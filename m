Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 38C7A2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 15:05:59 +1000 (EST)
Message-ID: <1347944755.2386.43.camel@pasglop>
Subject: Re: [v5][PATCH 2/3] powerpc/kprobe: complete kprobe and migrate
 exception frame
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 18 Sep 2012 15:05:55 +1000
In-Reply-To: <1347875671-15838-2-git-send-email-tiejun.chen@windriver.com>
References: <1347875671-15838-1-git-send-email-tiejun.chen@windriver.com>
 <1347875671-15838-2-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-17 at 17:54 +0800, Tiejun Chen wrote:
> -#ifdef CONFIG_PREEMPT
>  	b	restore
>  
>  /* N.B. the only way to get here is from the beq following ret_from_except. */
>  resume_kernel:
> -	/* check current_thread_info->preempt_count */
> +	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
>  	CURRENT_THREAD_INFO(r9, r1)
> +	lwz	r8,TI_FLAGS(r9)
> +	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
> +	beq+	1f
> +
> +	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
> +
> +	lwz	r3,GPR1(r1)
> +	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
> +	mr	r4,r1			/* src:  current exception frame */
> +	li	r5,INT_FRAME_SIZE	/* size: INT_FRAME_SIZE */
> +	li	r6,0			/* start offset: 0 */
> +	mr	r1,r3			/* Reroute the trampoline frame to r1 */
> +
> +	/* Copy from the original to the trampoline. */
> +	li	r6,0

You just did that li r6,0 2 lines above :-) I'll fix it up manually
while applying.

> +	srwi	r5,r5,2
> +	mtctr	r5
> +2:	lwzx	r0,r6,r4
> +	stwx	r0,r6,r3
> +	addi	r6,r6,4
> +	bdnz	2b
> +
> +	/* Do real store operation to complete stwu */
> +	lwz	r5,GPR1(r1)
> +	stw	r8,0(r5)
> +
> +	/* Clear _TIF_EMULATE_STACK_STORE flag */
> +	lis	r11,_TIF_EMULATE_STACK_STORE@h
> +	addi	r5,r9,TI_FLAGS
> +0:	lwarx	r8,0,r5
> +	andc	r8,r8,r11
> +#ifdef CONFIG_IBM405_ERR77
> +	dcbt	0,r5
> +#endif
> +	stwcx.	r8,0,r5
> +	bne-	0b
> +1:
> +
> +#ifdef CONFIG_PREEMPT
> +	/* check current_thread_info->preempt_count */
>  	lwz	r0,TI_PREEMPT(r9)
>  	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
>  	bne	restore
> -	lwz	r0,TI_FLAGS(r9)
> -	andi.	r0,r0,_TIF_NEED_RESCHED
> +	andi.	r8,r8,_TIF_NEED_RESCHED
>  	beq+	restore
> +	lwz	r3,_MSR(r1)
>  	andi.	r0,r3,MSR_EE	/* interrupts off? */
>  	beq	restore		/* don't schedule if so */
>  #ifdef CONFIG_TRACE_IRQFLAGS
> @@ -864,8 +903,6 @@ resume_kernel:
>  	 */
>  	bl	trace_hardirqs_on
>  #endif
> -#else
> -resume_kernel:
>  #endif /* CONFIG_PREEMPT */
>  
>  	/* interrupts are hard-disabled at this point */
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index b40e0b4..bdd2dc1 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -593,6 +593,43 @@ _GLOBAL(ret_from_except_lite)
>  	b	.ret_from_except
>  
>  resume_kernel:
> +	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
> +	CURRENT_THREAD_INFO(r9, r1)
> +	ld	r8,TI_FLAGS(r9)
> +	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
> +	beq+	1f
> +
> +	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
> +
> +	lwz	r3,GPR1(r1)
> +	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
> +	mr	r4,r1			/* src:  current exception frame */
> +	li	r5,INT_FRAME_SIZE	/* size: INT_FRAME_SIZE */
> +	li	r6,0			/* start offset: 0 */
> +	mr	r1,r3			/* Reroute the trampoline frame to r1 */
> +
> +	/* Copy from the original to the trampoline. */
> +	li	r6,0
> +	srwi	r5,r5,3
> +	mtctr	r5
> +2:	ldx	r0,r6,r4
> +	stdx	r0,r6,r3
> +	addi	r6,r6,8
> +	bdnz	2b
> +
> +	/* Do real store operation to complete stwu */
> +	lwz	r5,GPR1(r1)
> +	std	r8,0(r5)
> +
> +	/* Clear _TIF_EMULATE_STACK_STORE flag */
> +	lis	r11,_TIF_EMULATE_STACK_STORE@h
> +	addi	r5,r9,TI_FLAGS
> +	ldarx	r4,0,r5
> +	andc	r4,r4,r11
> +	stdcx.	r4,0,r5
> +	bne-	0b
> +1:
> +
>  #ifdef CONFIG_PREEMPT
>  	/* Check if we need to preempt */
>  	andi.	r0,r4,_TIF_NEED_RESCHED
