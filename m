Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D3CD61007D6
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2011 12:04:17 +1100 (EST)
Message-ID: <1323911052.21839.64.camel@pasglop>
Subject: Re: [PATCH 1/1] ppc64: fix missing to check all bits of
 _TIF_USER_WORK_MASK in preempt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Thu, 15 Dec 2011 12:04:12 +1100
In-Reply-To: <1323681035-19350-1-git-send-email-tiejun.chen@windriver.com>
References: <1323681035-19350-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-12-12 at 17:10 +0800, Tiejun Chen wrote:

> -#else /* !CONFIG_PREEMPT */
>  	ld	r3,_MSR(r1)	/* Returning to user mode? */
>  	andi.	r3,r3,MSR_PR
> -	beq	restore		/* if not, just restore regs and return */
> +	bne	test_work_user
>  
> +	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
> +	li	r0,_TIF_USER_WORK_MASK

You meant _TIF_KERNEL_WORK_MASK ?

> +#ifdef CONFIG_PREEMPT
> +	ori	r0,r0,_TIF_NEED_RESCHED
> +#endif

No, include that in _TIF_KERNEL_WORK_MASK when CONFIG_PREEMPT, ie,
modify the definition of _TIF_KERNEL_WORK_MASK to include it

> +	ld	r4,TI_FLAGS(r9)
> +	and.	r0,r4,r0	/* check NEED_RESCHED and maybe _TIF_USER_WORK_MASK */

Comment is wrong after the above

> +	bne	do_kernel_work
> +	b	restore		/* if so, just restore regs and return */
> +
> +test_work_user:
>  	/* Check current_thread_info()->flags */
>  	clrrdi	r9,r1,THREAD_SHIFT
>  	ld	r4,TI_FLAGS(r9)

For better scheduling, couldn't you have preloaded the TIF flags, then
checked for PR ?

Looks like this (also replaces do_work)

IE.	ld	r3,_MSR(r1)
	clrrdi	r9,r1,THREAD_SHIFT
  	ld	r4,TI_FLAGS(r9)
 	andi.	r3,r3,MSR_PR
	bne	test_work_user
test_work_kernel:
 	andi.	r0,r4,_TIF_KERNEL_WORK_MASK
	beq+	restore
#ifdef CONFIG_PREEMPT
	/* Check if we need to preempt */
	andi.	r0,r4,_TIF_NEED_RESCHED
	beq+	2f
	lwz	r8,TI_PREEMPT(r9)
	cmpwi	cr1,r8,0
	ld	r0,SOFTE(r1)
	cmpdi	r0,0
	crandc	eq,cr1*4+eq,eq
	bne	1f
	/* ... copy comment about preempt here ... */
	li	r0,0
	stb	r0,PACASOFTIRQEN(r13)
	stb	r0,PACAHARDIRQEN(r13)
	TRACE_DISABLE_INTS
1:	bl	.preempt_schedule_irq

	/* preempt may have re-enabled and then disabled interrupts,
	 * so we may come here as soft-disabled & hard-enabled, but
	 * we really want hard disabled.
	 */ 
#ifdef CONFIG_PPC_BOOK3E
	wrteei	0
#else
	mfmsr	r10
	rldicl	r10,r10,48,1
	rotldi	r10,r10,16
	mtmsrd	r10,1
#endif
	li	r0,0
	stb	r0,PACAHARDIRQEN(r13)

	/* Re-check if we need to preempt again */
	clrrdi	r9,r1,THREAD_SHIFT
	ld	r4,TI_FLAGS(r9)
	andi.	r0,r4,_TIF_NEED_RESCHED
	bne	1b
2:
#endif /* CONFIG_PREEMPT */	
	andi.	r0,r4,_TIF_OUR_NEW_FLAG
	beq+	restore
	... handle our new flag here
	b	restore

test_work_user:
 	andi.	r0,r4,_TIF_USER_WORK_MASK
	beq+	restore
	/* ... move user_work here ... */

>  	andi.	r0,r4,_TIF_USER_WORK_MASK
> -	bne	do_work
> -#endif
> +	bne	do_user_work
>  
>  restore:
>  BEGIN_FW_FTR_SECTION
> @@ -693,10 +692,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
>  	b	.ret_from_except_lite		/* loop back and handle more */
>  #endif
>  
> -do_work:
> +do_kernel_work:
>  #ifdef CONFIG_PREEMPT
> -	andi.	r0,r3,MSR_PR	/* Returning to user mode? */
> -	bne	user_work
>  	/* Check that preempt_count() == 0 and interrupts are enabled */
>  	lwz	r8,TI_PREEMPT(r9)
>  	cmpwi	cr1,r8,0
> @@ -738,9 +735,9 @@ do_work:
>  	bne	1b
>  	b	restore
>  
> -user_work:
>  #endif /* CONFIG_PREEMPT */
>  
> +do_user_work:
>  	/* Enable interrupts */
>  #ifdef CONFIG_PPC_BOOK3E
>  	wrteei	1
