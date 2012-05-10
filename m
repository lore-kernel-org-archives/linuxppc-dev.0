Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC93EB6FA9
 for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2012 14:00:48 +1000 (EST)
Message-ID: <1336622443.3881.43.camel@pasglop>
Subject: Re: [PATCH 1/1] ppc64: fix missing to check all bits of
 _TIF_USER_WORK_MASK in preempt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Thu, 10 May 2012 14:00:43 +1000
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

>  
> -#ifdef CONFIG_PREEMPT
> -	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
> -	li	r0,_TIF_NEED_RESCHED	/* bits to check */
> -	ld	r3,_MSR(r1)
> -	ld	r4,TI_FLAGS(r9)
> -	/* Move MSR_PR bit in r3 to _TIF_SIGPENDING position in r0 */
> -	rlwimi	r0,r3,32+TIF_SIGPENDING-MSR_PR_LG,_TIF_SIGPENDING
> -	and.	r0,r4,r0	/* check NEED_RESCHED and maybe SIGPENDING */
> -	bne	do_work
> -
> -#else /* !CONFIG_PREEMPT */
>  	ld	r3,_MSR(r1)	/* Returning to user mode? */
>  	andi.	r3,r3,MSR_PR
> -	beq	restore		/* if not, just restore regs and return */
> +	bne	test_work_user

Any reason to not use restore_user / resume_kernel like ppc32 ? It might
help whoever wants to look at that code in the future if we make both
sides a bit closer :-) Not a big deal and if you prefer like this I
don't have a firm objection
 
> +	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
> +	li	r0,_TIF_USER_WORK_MASK
> +#ifdef CONFIG_PREEMPT
> +	ori	r0,r0,_TIF_NEED_RESCHED
> +#endif

Why the above ? Doesn't _TIF_USER_WORK_MASK altready contain
TIF_NEED_RESCHED ? Also this is the kernel path, I'd rather just
define something along the lines of _TIF_KERNEL_WORK_MASK.

Then, you change the definition of it based on PREEMPT, ie:

#ifdef CONFIG_PREEMPT
#define _TIF_KERNEL_WORK_MASK	_TIF_NEED_RESCHED
#else
#define _TIF_KERNEL_WORK_MASK	0
#endif

Now, that does mean that you'll have a useless test without PREEMPT
here but ... it will stop being useless as soon as you port over
the stux emulation so it's fine as a placeholder.

> +	ld	r4,TI_FLAGS(r9)
> +	and.	r0,r4,r0	/* check NEED_RESCHED and maybe _TIF_USER_WORK_MASK */
> +	bne	do_kernel_work
> +	b	restore		/* if so, just restore regs and return */
> +
> +test_work_user:
>  	/* Check current_thread_info()->flags */
>  	clrrdi	r9,r1,THREAD_SHIFT
>  	ld	r4,TI_FLAGS(r9)
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
