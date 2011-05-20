Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3290CB7196
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 08:33:07 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/book3e-64: reraise doorbell when masked by
	soft-irq-disable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110520190047.GB7058@schlenkerla.am.freescale.net>
References: <20110520190047.GB7058@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 21 May 2011 08:32:58 +1000
Message-ID: <1305930778.7481.197.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-20 at 14:00 -0500, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/kernel/exceptions-64e.S |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)

You can probably remove the doorbell re-check when enabling interrupts
now, can't you ?

Cheers,
Ben.

> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index b60f49e..87ca569 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -123,6 +123,12 @@
>  	std	r14,PACA_EXMC+EX_R14(r13);				    \
>  	std	r15,PACA_EXMC+EX_R15(r13)
>  
> +#define PROLOG_ADDITION_DOORBELL_GEN					    \
> +	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
> +	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
> +	beq	masked_doorbell_book3e;
> +
> +
>  /* Core exception code for all exceptions except TLB misses.
>   * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
>   */
> @@ -466,7 +472,13 @@ kernel_dbg_exc:
>  	MASKABLE_EXCEPTION(0x260, perfmon, .performance_monitor_exception, ACK_NONE)
>  
>  /* Doorbell interrupt */
> -	MASKABLE_EXCEPTION(0x2070, doorbell, .doorbell_exception, ACK_NONE)
> +	START_EXCEPTION(doorbell)
> +	NORMAL_EXCEPTION_PROLOG(0x2070, PROLOG_ADDITION_DOORBELL)
> +	EXCEPTION_COMMON(0x2070, PACA_EXGEN, INTS_DISABLE_ALL)
> +	CHECK_NAPPING()
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	.doorbell_exception
> +	b	.ret_from_except_lite;
>  
>  /* Doorbell critical Interrupt */
>  	START_EXCEPTION(doorbell_crit);
> @@ -521,8 +533,16 @@ kernel_dbg_exc:
>   * An interrupt came in while soft-disabled; clear EE in SRR1,
>   * clear paca->hard_enabled and return.
>   */
> +masked_doorbell_book3e:
> +	mtcr	r10
> +	/* Resend the doorbell to fire again when ints enabled */
> +	mfspr	r10,SPRN_PIR
> +	PPC_MSGSND(r10)
> +	b	masked_interrupt_book3e_common
> +
>  masked_interrupt_book3e:
>  	mtcr	r10
> +masked_interrupt_book3e_common:
>  	stb	r11,PACAHARDIRQEN(r13)
>  	mfspr	r10,SPRN_SRR1
>  	rldicl	r11,r10,48,1		/* clear MSR_EE */
