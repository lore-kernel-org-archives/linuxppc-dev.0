Return-Path: <B10716@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 713B7B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 04:03:49 +1100 (EST)
Message-ID: <4F33FC65.40702@freescale.com>
Date: Thu, 9 Feb 2012 19:03:33 +0200
From: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: Rework lazy-interrupt handling
References: <1328761532.2903.53.camel@pasglop>
In-Reply-To: <1328761532.2903.53.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, Stuart Yoder <b08248@gmail.com>,
 Anton Blanchard <anton@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <pmac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Small comment inline.

On 02/09/2012 06:25 AM, Benjamin Herrenschmidt wrote:
>  From 0ace17ba6960a8788b1bda3770df254cbbc6a244 Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Date: Thu, 9 Feb 2012 15:25:04 +1100
> Subject: [PATCH] powerpc: Rework lazy-interrupt handling
>
> The current implementation of lazy interrupts handling has some
> issues that this tries to address.
>
> Except on iSeries, we don't do the various workarounds we need to
> do on re-enable when returning from an interrupt, which can do an
> implicit re-enable, and thus we may still lose or get delayed
> decrementer or doorbell interrupts.
>
> The current scheme also makes it much harder to handle the external
> "edge" interrupts provided by some BookE processors when using the
> EPR facility (External Proxy) and the Freescale Hypervisor.
>
> We also hard mask on decrementer interrupts which is sub-optimal.
>
> This is an attempt at fixing it all in one go by reworking the way
> we do the lazy interrupt disabling.
>
> The base idea is to replace the "hard_enabled" field with a
> "irq_happened" field in which we store a bit mask of what interrupt
> occurred while soft-disabled.
>
> When re-enabling, either via arch_local_irq_restore() or when returning
> from an interrupt, we can now decide what to do by testing bits in that
> field. We then implement re-emitting of the lost interrupts via either
> a re-use of the existing exception frame (exception exit case) or via
> the creation of a new one from assembly code (arch_local_irq_enable),
> without the need to trigger a fake one using set_dec() or similar.
>
> In addition, this adds a few refinements:
>
>   - We no longer  hard disable decrementer interrupts that occur
> while soft-disabled. We now simply bump the decrementer back to max
> (on BookS) or leave it stopped (on BookE) and continue with hard interrupts
> enabled, which means that we'll potentially get better sample quality from
> performance monitor interrupts.
>
>   - Timer, decrementer and doorbell interrupts now hard-enable
> shortly after removing the source of the interrupt, which means
> they no longer run entirely hard disabled. Again, this will improve
> perf sample quality.
>
>   - On Book3E 64-bit, we now make the performance monitor interrupt
> act as an NMI like Book3S (the necessary C code for that to work
> appear to already be present in the FSL perf code, notably calling
> nmi_enter instead of irq_enter).
>
> There are additional refinements that we can do on top of this patch:
>
>   - We could remove the ps3 workaround from arch_local_irq_enable(),
> I believe that it should no longer be necessary
>
>   - We could make "masked" decrementer interrupts act as NMIs when doing
> timer-based perf sampling to improve the sample quality.
>
>   - There are additional simplifications of the exception entry/exit path
> that I've spotted along the way, such as merging fast_exception_return
> with the normal code path.
>
> This patch needs a LOT more testing&  review than it had so far !!!
>
> Not-signed-off-by-yet: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> ---
>
> v2:
>
> - Add hard-enable to decrementer, timer and doorbells
> - Fix CR clobber in masked irq handling on BookE
> - Make embedded perf interrupt act as an NMI
> - Add a PACA_HAPPENED_EE_EDGE for use by FSL if they want
>    to retrigger an interrupt without preventing hard-enable
>
> Signed-off-by: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> ---
>   arch/powerpc/include/asm/exception-64s.h        |   21 ++-
>   arch/powerpc/include/asm/hw_irq.h               |   51 +++++-
>   arch/powerpc/include/asm/irqflags.h             |   13 +-
>   arch/powerpc/include/asm/paca.h                 |    2 +-
>   arch/powerpc/kernel/asm-offsets.c               |    2 +-
>   arch/powerpc/kernel/dbell.c                     |   12 ++
>   arch/powerpc/kernel/entry_64.S                  |   96 ++++++-----
>   arch/powerpc/kernel/exceptions-64e.S            |  210 ++++++++++++++++-------
>   arch/powerpc/kernel/exceptions-64s.S            |   90 ++++++----
>   arch/powerpc/kernel/head_64.S                   |    9 -
>   arch/powerpc/kernel/idle_book3e.S               |    8 +-
>   arch/powerpc/kernel/idle_power4.S               |   17 ++-
>   arch/powerpc/kernel/idle_power7.S               |   20 ++-
>   arch/powerpc/kernel/irq.c                       |  187 ++++++++++++++------
>   arch/powerpc/kernel/time.c                      |   15 ++-
>   arch/powerpc/platforms/iseries/Makefile         |    2 +-
>   arch/powerpc/platforms/iseries/exception.S      |   11 +-
>   arch/powerpc/platforms/iseries/misc.S           |   26 ---
>   arch/powerpc/platforms/pseries/processor_idle.c |   24 +++-
>   19 files changed, 540 insertions(+), 276 deletions(-)
>   delete mode 100644 arch/powerpc/platforms/iseries/misc.S
>

[snip]

> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 429983c..7fa4096 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -21,6 +21,7 @@
>   #include<asm/exception-64e.h>
>   #include<asm/bug.h>
>   #include<asm/irqflags.h>
> +#include<asm/hw_irq.h>
>   #include<asm/ptrace.h>
>   #include<asm/ppc-opcode.h>
>   #include<asm/mmu.h>
> @@ -77,59 +78,55 @@
>   #define SPRN_MC_SRR1	SPRN_MCSRR1
>
>   #define NORMAL_EXCEPTION_PROLOG(n, addition)				    \
> -	EXCEPTION_PROLOG(n, GEN, addition##_GEN)
> +	EXCEPTION_PROLOG(n, GEN, addition##_GEN(n))
>
>   #define CRIT_EXCEPTION_PROLOG(n, addition)				    \
> -	EXCEPTION_PROLOG(n, CRIT, addition##_CRIT)
> +	EXCEPTION_PROLOG(n, CRIT, addition##_CRIT(n))
>
>   #define DBG_EXCEPTION_PROLOG(n, addition)				    \
> -	EXCEPTION_PROLOG(n, DBG, addition##_DBG)
> +	EXCEPTION_PROLOG(n, DBG, addition##_DBG(n))
>
>   #define MC_EXCEPTION_PROLOG(n, addition)				    \
> -	EXCEPTION_PROLOG(n, MC, addition##_MC)
> +	EXCEPTION_PROLOG(n, MC, addition##_MC(n))
>
>
>   /* Variants of the "addition" argument for the prolog
>    */
> -#define PROLOG_ADDITION_NONE_GEN
> -#define PROLOG_ADDITION_NONE_CRIT
> -#define PROLOG_ADDITION_NONE_DBG
> -#define PROLOG_ADDITION_NONE_MC
> +#define PROLOG_ADDITION_NONE_GEN(n)
> +#define PROLOG_ADDITION_NONE_CRIT(n)
> +#define PROLOG_ADDITION_NONE_DBG(n)
> +#define PROLOG_ADDITION_NONE_MC(n)
>
> -#define PROLOG_ADDITION_MASKABLE_GEN					    \
> +#define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
>   	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
>   	cmpwi	cr0,r11,0;		/* yes ->  go out of line */	    \
> -	beq	masked_interrupt_book3e;
> +	beq	masked_interrupt_book3e_##n;
>
> -#define PROLOG_ADDITION_2REGS_GEN					    \
> +#define PROLOG_ADDITION_2REGS_GEN(n)					    \
>   	std	r14,PACA_EXGEN+EX_R14(r13);				    \
>   	std	r15,PACA_EXGEN+EX_R15(r13)
>
> -#define PROLOG_ADDITION_1REG_GEN					    \
> +#define PROLOG_ADDITION_1REG_GEN(n)					    \
>   	std	r14,PACA_EXGEN+EX_R14(r13);
>
> -#define PROLOG_ADDITION_2REGS_CRIT					    \
> +#define PROLOG_ADDITION_2REGS_CRIT(n)					    \
>   	std	r14,PACA_EXCRIT+EX_R14(r13);				    \
>   	std	r15,PACA_EXCRIT+EX_R15(r13)
>
> -#define PROLOG_ADDITION_2REGS_DBG					    \
> +#define PROLOG_ADDITION_2REGS_DBG(n)					    \
>   	std	r14,PACA_EXDBG+EX_R14(r13);				    \
>   	std	r15,PACA_EXDBG+EX_R15(r13)
>
> -#define PROLOG_ADDITION_2REGS_MC					    \
> +#define PROLOG_ADDITION_2REGS_MC(n)					    \
>   	std	r14,PACA_EXMC+EX_R14(r13);				    \
>   	std	r15,PACA_EXMC+EX_R15(r13)
>
> -#define PROLOG_ADDITION_DOORBELL_GEN					    \
> -	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
> -	cmpwi	cr0,r11,0;		/* yes ->  go out of line */	    \
> -	beq	masked_doorbell_book3e
> -
>
>   /* Core exception code for all exceptions except TLB misses.
>    * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
>    */
>   #define EXCEPTION_COMMON(n, excf, ints)					    \
> +exc_##n##_common:							    \
>   	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
>   	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
>   	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe */    \
> @@ -167,19 +164,25 @@
>   	std	r0,RESULT(r1);		/* clear regs->result */	    \
>   	ints;
>
> -/* Variants for the "ints" argument */
> -#define INTS_KEEP
> -#define INTS_DISABLE_SOFT						    \
> +/* Variants for the "ints" argument. We know r0 is 0 on entry */
> +#define INTS_KEEP							    \
>   	stb	r0,PACASOFTIRQEN(r13);	/* mark interrupts soft-disabled */ \
>   	TRACE_DISABLE_INTS;
> -#define INTS_DISABLE_HARD						    \
> -	stb	r0,PACAHARDIRQEN(r13); /* and hard disabled */
> -#define INTS_DISABLE_ALL						    \
> -	INTS_DISABLE_SOFT						    \
> -	INTS_DISABLE_HARD
> -
> -/* This is called by exceptions that used INTS_KEEP (that is did not clear
> - * neither soft nor hard IRQ indicators in the PACA. This will restore MSR:EE
> +
> +/* This second version is meant for exceptions that don't immediately
> + * hard-enable. We set a bit in paca->irq_happened to ensure that
> + * a subsequent call to arch_local_irq_restore() will properly
> + * hard-enable and avoid the fast-path
> + */
> +#define INTS_DISABLE							    \
> +	stb	r0,PACASOFTIRQEN(r13);	/* mark interrupts soft-disabled */ \
> +	lbz	r0,PACAIRQHAPPENED(r13);				    \
> +	ori	r0,r0,PACA_HAPPENED;					    \
> +	stb	r0,PACAIRQHAPPENED(r13);				    \
> +	TRACE_DISABLE_INTS;
> +
> +/* This is called by exceptions that used INTS_KEEP (that is did
> + * not set hard IRQ indicators in the PACA). This will restore MSR:EE
>    * to it's previous value
>    *
>    * XXX In the long run, we may want to open-code it in order to separate the
> @@ -238,7 +241,7 @@ exc_##n##_bad_stack:							    \
>   #define MASKABLE_EXCEPTION(trapnum, label, hdlr, ack)			\
>   	START_EXCEPTION(label);						\
>   	NORMAL_EXCEPTION_PROLOG(trapnum, PROLOG_ADDITION_MASKABLE)	\
> -	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE_ALL)		\
> +	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE)		\
>   	ack(r8);							\
>   	CHECK_NAPPING();						\
>   	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
> @@ -289,7 +292,7 @@ interrupt_end_book3e:
>   /* Critical Input Interrupt */
>   	START_EXCEPTION(critical_input);
>   	CRIT_EXCEPTION_PROLOG(0x100, PROLOG_ADDITION_NONE)
> -//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE_ALL)
> +//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE)
>   //	bl	special_reg_save_crit
>   //	CHECK_NAPPING();
>   //	addi	r3,r1,STACK_FRAME_OVERHEAD
> @@ -300,7 +303,7 @@ interrupt_end_book3e:
>   /* Machine Check Interrupt */
>   	START_EXCEPTION(machine_check);
>   	CRIT_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
> -//	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE_ALL)
> +//	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE)
>   //	bl	special_reg_save_mc
>   //	addi	r3,r1,STACK_FRAME_OVERHEAD
>   //	CHECK_NAPPING();
> @@ -339,7 +342,7 @@ interrupt_end_book3e:
>   	START_EXCEPTION(program);
>   	NORMAL_EXCEPTION_PROLOG(0x700, PROLOG_ADDITION_1REG)
>   	mfspr	r14,SPRN_ESR
> -	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE_SOFT)
> +	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_KEEP)
>   	std	r14,_DSISR(r1)
>   	addi	r3,r1,STACK_FRAME_OVERHEAD
>   	ld	r14,PACA_EXGEN+EX_R14(r13)
> @@ -372,7 +375,7 @@ interrupt_end_book3e:
>   /* Watchdog Timer Interrupt */
>   	START_EXCEPTION(watchdog);
>   	CRIT_EXCEPTION_PROLOG(0x9f0, PROLOG_ADDITION_NONE)
> -//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE_ALL)
> +//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE)
>   //	bl	special_reg_save_crit
>   //	CHECK_NAPPING();
>   //	addi	r3,r1,STACK_FRAME_OVERHEAD
> @@ -450,7 +453,7 @@ interrupt_end_book3e:
>   	mfspr	r15,SPRN_SPRG_CRIT_SCRATCH
>   	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
>   	mfspr	r14,SPRN_DBSR
> -	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE_ALL)
> +	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE)
>   	std	r14,_DSISR(r1)
>   	addi	r3,r1,STACK_FRAME_OVERHEAD
>   	mr	r4,r14
> @@ -515,7 +518,7 @@ kernel_dbg_exc:
>   	mfspr	r15,SPRN_SPRG_DBG_SCRATCH
>   	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
>   	mfspr	r14,SPRN_DBSR
> -	EXCEPTION_COMMON(0xd00, PACA_EXDBG, INTS_DISABLE_ALL)
> +	EXCEPTION_COMMON(0xd08, PACA_EXDBG, INTS_DISABLE)
>   	std	r14,_DSISR(r1)
>   	addi	r3,r1,STACK_FRAME_OVERHEAD
>   	mr	r4,r14
> @@ -525,21 +528,22 @@ kernel_dbg_exc:
>   	bl	.DebugException
>   	b	.ret_from_except
>
> -	MASKABLE_EXCEPTION(0x260, perfmon, .performance_monitor_exception, ACK_NONE)
> +	START_EXCEPTION(perfmon);
> +	NORMAL_EXCEPTION_PROLOG(0x260, PROLOG_ADDITION_NONE)
> +	EXCEPTION_COMMON(0x260, PACA_EXGEN, INTS_DISABLE)
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	ld	r14,PACA_EXGEN+EX_R14(r13)
> +	bl	.save_nvgprs
> +	bl	.performance_monitor_exception
> +	b	.ret_from_except
>
>   /* Doorbell interrupt */
> -	START_EXCEPTION(doorbell)
> -	NORMAL_EXCEPTION_PROLOG(0x2070, PROLOG_ADDITION_DOORBELL)
> -	EXCEPTION_COMMON(0x2070, PACA_EXGEN, INTS_DISABLE_ALL)
> -	CHECK_NAPPING()
> -	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	bl	.doorbell_exception
> -	b	.ret_from_except_lite
> +	MASKABLE_EXCEPTION(0x280, doorbell, .doorbell_exception, ACK_NONE)
>
>   /* Doorbell critical Interrupt */
>   	START_EXCEPTION(doorbell_crit);
> -	CRIT_EXCEPTION_PROLOG(0x2080, PROLOG_ADDITION_NONE)
> -//	EXCEPTION_COMMON(0x2080, PACA_EXCRIT, INTS_DISABLE_ALL)
> +	CRIT_EXCEPTION_PROLOG(0x2a0, PROLOG_ADDITION_NONE)
> +//	EXCEPTION_COMMON(0x280, PACA_EXCRIT, INTS_DISABLE)
>   //	bl	special_reg_save_crit
>   //	CHECK_NAPPING();
>   //	addi	r3,r1,STACK_FRAME_OVERHEAD
> @@ -547,38 +551,116 @@ kernel_dbg_exc:
>   //	b	ret_from_crit_except
>   	b	.
>
> +/* Guest Doorbell */
>   	MASKABLE_EXCEPTION(0x2c0, guest_doorbell, .unknown_exception, ACK_NONE)
> -	MASKABLE_EXCEPTION(0x2e0, guest_doorbell_crit, .unknown_exception, ACK_NONE)
> -	MASKABLE_EXCEPTION(0x310, hypercall, .unknown_exception, ACK_NONE)
> -	MASKABLE_EXCEPTION(0x320, ehpriv, .unknown_exception, ACK_NONE)
> +
> +/* Guest Doorbell critical Interrupt */
> +	START_EXCEPTION(guest_doorbell_crit);
> +	CRIT_EXCEPTION_PROLOG(0x2e0, PROLOG_ADDITION_NONE)
> +//	EXCEPTION_COMMON(0x2e0, PACA_EXCRIT, INTS_DISABLE)
> +//	bl	special_reg_save_crit
> +//	CHECK_NAPPING();
> +//	addi	r3,r1,STACK_FRAME_OVERHEAD
> +//	bl	.guest_doorbell_critical_exception
> +//	b	ret_from_crit_except
> +	b	.
> +
> +/* Hypervisor call */
> +	START_EXCEPTION(hypercall);
> +	NORMAL_EXCEPTION_PROLOG(0x310, PROLOG_ADDITION_NONE)
> +	EXCEPTION_COMMON(0x310, PACA_EXGEN, INTS_KEEP)
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	.save_nvgprs
> +	INTS_RESTORE_HARD
> +	bl	.unknown_exception
> +	b	.ret_from_except
> +
> +/* Embedded Hypervisor priviledged  */
> +	START_EXCEPTION(ehpriv);
> +	NORMAL_EXCEPTION_PROLOG(0x320, PROLOG_ADDITION_NONE)
> +	EXCEPTION_COMMON(0x320, PACA_EXGEN, INTS_KEEP)
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	.save_nvgprs
> +	INTS_RESTORE_HARD
> +	bl	.unknown_exception
> +	b	.ret_from_except
>
>
>   /*
> - * An interrupt came in while soft-disabled; clear EE in SRR1,
> - * clear paca->hard_enabled and return.
> + * An interrupt came in while soft-disabled; We mark paca->irq_happened
> + * accordingly and if the interrupt is level sensitive, we hard disable
>    */
> -masked_doorbell_book3e:
> -	mtcr	r10
> -	/* Resend the doorbell to fire again when ints enabled */
> -	mfspr	r10,SPRN_PIR
> -	PPC_MSGSND(r10)
> -	b	masked_interrupt_book3e_common
>
> -masked_interrupt_book3e:
> +masked_interrupt_book3e_0x500:
> +	li	r11,PACA_HAPPENED_EE
> +	b	masked_interrupt_book3e_full_mask
> +
> +masked_interrupt_book3e_0x900:
> +	ACK_DEC(r11);
> +	li	r11,PACA_HAPPENED_DEC
> +	b	masked_interrupt_book3e_no_mask
> +masked_interrupt_book3e_0x980:
> +	ACK_FIT(r11);
> +	li	r11,PACA_HAPPENED_DEC
> +	b	masked_interrupt_book3e_no_mask
> +masked_interrupt_book3e_0x280:
> +masked_interrupt_book3e_0x2c0:
> +	li	r11,PACA_HAPPENED_DBELL
> +	b	masked_interrupt_book3e_no_mask
> +
> +masked_interrupt_book3e_no_mask:
> +	mtcr	r10
> +	lbz	r10,PACAIRQHAPPENED(r13)
> +	ori	r10,r10,r11

Shouldn't this be an 'or'?

> +	stb	r10,PACAIRQHAPPENED(r13)
> +	b	1f
> +masked_interrupt_book3e_full_mask:
>   	mtcr	r10
> -masked_interrupt_book3e_common:
> -	stb	r11,PACAHARDIRQEN(r13)
> +	lbz	r10,PACAIRQHAPPENED(r13)
> +	ori	r10,r10,r11

Same comment.

> +	stb	r10,PACAIRQHAPPENED(r13)
>   	mfspr	r10,SPRN_SRR1
>   	rldicl	r11,r10,48,1		/* clear MSR_EE */
>   	rotldi	r10,r11,16
>   	mtspr	SPRN_SRR1,r10
> -	ld	r10,PACA_EXGEN+EX_R10(r13);	/* restore registers */
> +1:	ld	r10,PACA_EXGEN+EX_R10(r13);
>   	ld	r11,PACA_EXGEN+EX_R11(r13);
>   	mfspr	r13,SPRN_SPRG_GEN_SCRATCH;
>   	rfi
>   	b	.
>
>   /*
> + * Called from arch_local_irq_enable when an interrupt needs
> + * to be resent. r3 contains either 0x500,0x900,0x260 or 0x280
> + * to indicate the kind of interrupt. MSR:EE is already off.
> + * We generate a stackframe like if a real interrupt had happened.
> + *
> + * Note: While MSR:EE is off, we need to make sure that _MSR
> + * in the generated frame has EE set to 1 or the exception
> + * handler will not properly re-enable them.
> + */
> +_GLOBAL(__reemit_interrupt)
> +	/* We are going to jump to the exception common code which
> +	 * will retrieve various register values from the PACA which
> +	 * we don't give a damn about.
> +	 */
> +	mflr	r10
> +	mfmsr	r11
> +	mfcr	r4;
> +	mtspr	SPRN_SPRG_GEN_SCRATCH,r13;
> +	std	r1,PACA_EXGEN+EX_R1(r13);
> +	stw	r4,PACA_EXGEN+EX_CR(r13);
> +	ori	r11,r11,MSR_EE
> +	subi	r1,r1,INT_FRAME_SIZE;
> +	cmpwi	cr0,r3,0x500
> +	beq	exc_0x500_common
> +	cmpwi	cr0,r3,0x900
> +	beq+	exc_0x900_common
> +	cmpwi	cr0,r3,0x280
> +	beq+	exc_0x280_common
> +	blr
> +
> +/*
>    * This is called from 0x300 and 0x400 handlers after the prologs with
>    * r14 and r15 containing the fault address and error code, with the
>    * original values stashed away in the PACA
> @@ -680,6 +762,8 @@ BAD_STACK_TRAMPOLINE(0x000)
>   BAD_STACK_TRAMPOLINE(0x100)
>   BAD_STACK_TRAMPOLINE(0x200)
>   BAD_STACK_TRAMPOLINE(0x260)
> +BAD_STACK_TRAMPOLINE(0x280)
> +BAD_STACK_TRAMPOLINE(0x2a0)
>   BAD_STACK_TRAMPOLINE(0x2c0)
>   BAD_STACK_TRAMPOLINE(0x2e0)
>   BAD_STACK_TRAMPOLINE(0x300)

---
Best Regards, Laurentiu
