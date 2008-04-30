Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2983DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 07:55:06 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
Content-Type: text/plain
Date: Thu, 01 May 2008 07:54:55 +1000
Message-Id: <1209592495.18023.246.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-30 at 04:27 -0500, Kumar Gala wrote:
> * Cleanup the code a bit my allocating an INT_FRAME on our exception
>   stack there by make references go from GPR11-INT_FRAME_SIZE(r8) to
>   just GPR(r8)
            ^^ 11 ?

> * simplify {lvl}_transfer_to_handler code by moving the copying of the
>   temp registers we use if we come from user space into the PROLOG
> * If the exception came from kernel mode copy thread_info flags,
>   preempt, and task pointer from the process thread_info.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> I'm not sure if the copying of TI_FLAGS, TI_PREEMPT, and TI_TASK
> are really needed.  I'm a bit concerned what to do if we get a
> CriticalInput while in kernel mode and the handler causes a reschedule.

Well, reschedule or signal, either way, you can't handle them on the way
out. Maybe an option there is to set the flag in the normal kernel
stack's thread info and trigger an interrupt asap via the PIT so things
get handled ?

> 
> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
> index d647e05..78baec5 100644
> --- a/arch/powerpc/kernel/head_booke.h
> +++ b/arch/powerpc/kernel/head_booke.h
> @@ -78,12 +78,12 @@
>  	slwi	r8,r8,2;				\
>  	addis	r8,r8,level##_STACK_TOP@ha;		\
>  	lwz	r8,level##_STACK_TOP@l(r8);		\
> -	addi	r8,r8,THREAD_SIZE;
> +	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE;
>  #else
>  #define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
>  	lis	r8,level##_STACK_TOP@ha;		\
>  	lwz	r8,level##_STACK_TOP@l(r8);		\
> -	addi	r8,r8,THREAD_SIZE;
> +	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE;
>  #endif

Nothing specific to your patch, but those level##_STACK_TOP seem to
be pretty badly named if you end up -adding- THREAD_SIZE to actually
get to the stack's top. Do they really contain the stack top or do
they in fact contain the stack base/bottom ?

>  /*
> @@ -97,22 +97,35 @@
>  #define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0, exc_level_srr1) \
>  	mtspr	exc_level##_SPRG,r8;					     \
>  	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);/* r8 points to the exc_level stack*/ \
> -	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
> -	stw	r11,GPR11-INT_FRAME_SIZE(r8);				     \
> +	stw	r9,GPR9(r8);		/* save various registers	   */\
> +	stw	r10,GPR10(r8);						     \
> +	stw	r11,GPR11(r8);						     \
> +	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
> +	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
> +	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc exception frm */\

So you do the above whether it will actually be needed or not right ?
 
>  	mfcr	r10;			/* save CR in r10 for now	   */\
> -	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
> -	andi.	r11,r11,MSR_PR;						     \
> -	mr	r11,r8;							     \
> -	mfspr	r8,exc_level##_SPRG;					     \
> +	mfspr	r9,exc_level_srr1;	/* check whether user or kernel    */\
> +	andi.	r9,r9,MSR_PR;						     \
>  	beq	1f;							     \
>  	/* COMING FROM USER MODE */					     \
> -	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
> -	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
> -	addi	r11,r11,THREAD_SIZE;					     \
> -1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
> +	lwz	r9,GPR9(r8);		/* copy regs from exception stack  */\
> +	stw	r9,GPR9(r11);						     \
> +	lwz	r9,GPR10(r8);						     \
> +	stw	r9,GPR10(r11);						     \
> +	lwz	r9,GPR11(r8);						     \
> +	stw	r9,GPR11(r11);						     \
> +	b	2f;							     \

Are we concerned with performances here or not ? Because using the same
reg all along isn't the best ... 

> +	/* COMING FROM PRIV MODE */					     \
> +1:	lwz	r9,TI_FLAGS-THREAD_SIZE(r11);				     \
> +	stw	r9,TI_FLAGS-THREAD_SIZE(r8);				     \
> +	lwz	r9,TI_PREEMPT-THREAD_SIZE(r11);				     \
> +	stw	r9,TI_PREEMPT-THREAD_SIZE(r8);				     \
> +	lwz	r9,TI_TASK-THREAD_SIZE(r11);				     \
> +	stw	r9,TI_TASK-THREAD_SIZE(r8);				     \
> +	mr	r11,r8;							     \

Don't you want to also stick in HARDIRQ_OFFSET in preempt_count or
leave that to C code ? Also, you might want at one point to tell
lockdep about IRQs being disabled in case they were enabled when
you took the exception. (Do that after you've saved enough
stuff of crouse)

Ben.
