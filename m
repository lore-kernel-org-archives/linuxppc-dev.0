Return-Path: <B10716@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9C94DB70FF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2011 01:28:53 +1100 (EST)
Message-ID: <4E8F0C60.5020003@freescale.com>
Date: Fri, 7 Oct 2011 17:27:44 +0300
From: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
To: <benh@kernel.crashing.org>
Subject: Re: [linuxppc-dev] powerpc/64e: External Proxy interrupt support
References: <20110802194449.GA26318@schlenkerla.am.freescale.net>
In-Reply-To: <20110802194449.GA26318@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry about this. Please disregard.

---
Best Regards, Laurentiu

On 10/7/2011 5:15 PM, Laurentiu Tudor wrote:
> From: Scott Wood<scottwood@freescale.com>
>
> Adds support for External Proxy (a.k.a. CoreInt) interrupts on 64-bit
> kernels.  External Proxy combines interrupt delivery and
> acknowledgement, so simply returning from the interrupt without EOI
> or other action will not result in the interrupt being reasserted.
>
> When an external interrupt is deferred in this manner (whether
> external proxy is used or not), we set a flag in the PACA.  When we
> re-enable interrupts, either explicitly or as part of an exception
> return, we check the flag and branch to the interrupt exception
> vector as if hardware had delivered the interrupt.
>
> Another approach I considered was to use doorbells to replay the
> interrupt.  There are some problems with this:
>   - The timing of the actual delivery of the doorbell is undefined.
>     This means we can't be sure in an architected way that the
>     doorbell will happen before interrupts are again soft-disabled, at
>     which point (barring interrupt-controller specific actions such as
>     raising CTPR) we could take a higher priority interrupt and
>     overwrite the saved EPR.
>   - Doorbells have a lower priority than true external interrupt. This
>     means you could have a lower priority interrupt appear to preempt
>     a higher prio interrupt, once the higher priority interrupt
>     enables EE and the doorbell comes in.
>
> Signed-off-by: Scott Wood<scottwood@freescale.com>
>
> ---
> We need this patch to have reliable interrupts in hypervisor
> scenarios.
>
> arch/powerpc/include/asm/irq.h         |    2 +
>   arch/powerpc/include/asm/paca.h        |    4 ++
>   arch/powerpc/kernel/asm-offsets.c      |    3 +
>   arch/powerpc/kernel/entry_64.S         |    4 ++
>   arch/powerpc/kernel/exceptions-64e.S   |   94 +++++++++++++++++++++++++++-----
>   arch/powerpc/kernel/irq.c              |   11 ++++
>   arch/powerpc/platforms/85xx/p5020_ds.c |    5 --
>   7 files changed, 103 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
> index c57a28e..c0a45e7 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -332,5 +332,7 @@ extern void do_IRQ(struct pt_regs *regs);
>
>   int irq_choose_cpu(const struct cpumask *mask);
>
> +void deliver_pending_irq(void);
> +
>   #endif /* _ASM_IRQ_H */
>   #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index c1f65f5..e5af3e3 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -134,6 +134,10 @@ struct paca_struct {
>   	u8 hard_enabled;		/* set if irqs are enabled in MSR */
>   	u8 io_sync;			/* writel() needs spin_unlock sync */
>   	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
> +#ifdef CONFIG_PPC_BOOK3E
> +	/* an irq is pending while soft-disabled */
> +	u8 irq_pending;
> +#endif
>
>   	/* Stuff for accurate time accounting */
>   	u64 user_time;			/* accumulated usermode TB ticks */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index c98144f..5082ee7 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -206,6 +206,9 @@ int main(void)
>   	DEFINE(SVCPU_SLB, offsetof(struct kvmppc_book3s_shadow_vcpu, slb));
>   	DEFINE(SVCPU_SLB_MAX, offsetof(struct kvmppc_book3s_shadow_vcpu, slb_max));
>   #endif
> +#ifdef CONFIG_PPC_BOOK3E
> +	DEFINE(PACA_IRQ_PENDING, offsetof(struct paca_struct, irq_pending));
> +#endif
>   #endif /* CONFIG_PPC64 */
>
>   	/* RTAS */
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index d834425..c1d8eea 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -596,6 +596,9 @@ _GLOBAL(ret_from_except_lite)
>   restore:
>   BEGIN_FW_FTR_SECTION
>   	ld	r5,SOFTE(r1)
> +#ifdef CONFIG_PPC_BOOK3E
> +	lbz	r6,PACA_IRQ_PENDING(r13)
> +#endif
>   FW_FTR_SECTION_ELSE
>   	b	.Liseries_check_pending_irqs
>   ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_ISERIES)
> @@ -608,6 +611,7 @@ ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_ISERIES)
>   	stb	r4,PACAHARDIRQEN(r13)
>
>   #ifdef CONFIG_PPC_BOOK3E
> +	/* consumes r3-r6 */
>   	b	.exception_return_book3e
>   #else
>   	ld	r4,_CTR(r1)
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 429983c..9886be9 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -2,6 +2,7 @@
>    *  Boot code and exception vectors for Book3E processors
>    *
>    *  Copyright (C) 2007 Ben. Herrenschmidt (benh@kernel.crashing.org), IBM Corp.
> + *  Copyright 2011 Freescale Semiconductor, Inc.
>    *
>    *  This program is free software; you can redistribute it and/or
>    *  modify it under the terms of the GNU General Public License
> @@ -125,6 +126,10 @@
>   	cmpwi	cr0,r11,0;		/* yes ->  go out of line */	    \
>   	beq	masked_doorbell_book3e
>
> +#define PROLOG_ADDITION_EXTIRQ_GEN					    \
> +	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
> +	cmpwi	cr0,r11,0;		/* yes ->  go out of line */	    \
> +	beq	masked_extirq_book3e
>
>   /* Core exception code for all exceptions except TLB misses.
>    * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
> @@ -325,7 +330,13 @@ interrupt_end_book3e:
>   	b	storage_fault_common
>
>   /* External Input Interrupt */
> -	MASKABLE_EXCEPTION(0x500, external_input, .do_IRQ, ACK_NONE)
> +	START_EXCEPTION(external_input)
> +	NORMAL_EXCEPTION_PROLOG(0x500, PROLOG_ADDITION_EXTIRQ)
> +	EXCEPTION_COMMON(0x500, PACA_EXGEN, INTS_DISABLE_ALL)
> +	CHECK_NAPPING()
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	.do_IRQ
> +	b	.ret_from_except_lite
>
>   /* Alignment */
>   	START_EXCEPTION(alignment);
> @@ -557,6 +568,12 @@ kernel_dbg_exc:
>    * An interrupt came in while soft-disabled; clear EE in SRR1,
>    * clear paca->hard_enabled and return.
>    */
> +masked_extirq_book3e:
> +	mtcr	r10
> +	li	r10,1
> +	stb	r10,PACA_IRQ_PENDING(r13)
> +	b	masked_interrupt_book3e_common
> +
>   masked_doorbell_book3e:
>   	mtcr	r10
>   	/* Resend the doorbell to fire again when ints enabled */
> @@ -618,20 +635,8 @@ alignment_more:
>   	bl	.alignment_exception
>   	b	.ret_from_except
>
> -/*
> - * We branch here from entry_64.S for the last stage of the exception
> - * return code path. MSR:EE is expected to be off at that point
> - */
> -_GLOBAL(exception_return_book3e)
> -	b	1f
> -
> -/* This is the return from load_up_fpu fast path which could do with
> - * less GPR restores in fact, but for now we have a single return path
> - */
> -	.globl fast_exception_return
> -fast_exception_return:
> -	wrteei	0
> -1:	mr	r0,r13
> +.macro exception_restore
> +	mr	r0,r13
>   	ld	r10,_MSR(r1)
>   	REST_4GPRS(2, r1)
>   	andi.	r6,r10,MSR_PR
> @@ -667,8 +672,67 @@ fast_exception_return:
>   	ld	r10,PACA_EXGEN+EX_R10(r13)
>   	ld	r11,PACA_EXGEN+EX_R11(r13)
>   	mfspr	r13,SPRN_SPRG_GEN_SCRATCH
> +.endm
> +
> +/*
> + * We branch here from entry_64.S for the last stage of the exception
> + * return code path. MSR:EE is expected to be off at that point
> + * r3 = MSR for return context
> + * r4 = hard irq-enable status for return context
> + * r5 = soft irq-enable status for return context
> + * r6 = irq pending flag
> + */
> +_GLOBAL(exception_return_book3e)
> +	cmpwi	r6,0
> +	beq	common_exception_return
> +
> +/*
> + * There's an interrupt pending.  If we're returning to a context that
> + * is soft-irq-enabled, we need to deliver the interrupt now.
> + *
> + * We should never get here with soft IRQs enabled but hard IRQs disabled,
> + * but just to be sure, check that too.
> + */
> +	cmpwi	r5,0
> +	beq	common_exception_return
> +	cmpwi	r4,0
> +	beq	common_exception_return
> +
> +	lis	r5,(MSR_CE | MSR_ME | MSR_DE)@h
> +	li	r4,0
> +	ori	r5,r5,(MSR_CE | MSR_ME | MSR_DE)@l
> +	stb	r4,PACA_IRQ_PENDING(r13)
> +	and	r5,r5,r3
> +	oris	r5,r5,MSR_CM@h
> +	mtmsr	r5
> +
> +	exception_restore
> +	b	exc_external_input_book3e
> +
> +/* This is the return from load_up_fpu fast path which could do with
> + * less GPR restores in fact, but for now we have a single return path
> + */
> +	.globl fast_exception_return
> +fast_exception_return:
> +	wrteei	0
> +common_exception_return:
> +	exception_restore
>   	rfi
>
> +/* Called from arch_local_irq_restore() prior to hard-enabling interrupts */
> +_GLOBAL(deliver_pending_irq)
> +	mflr	r3
> +	mfmsr	r4
> +	lis	r5,(MSR_CM | MSR_CE | MSR_ME | MSR_DE)@h
> +	ori	r5,r5,(MSR_CM | MSR_CE | MSR_ME | MSR_DE)@l
> +	and	r5,r5,r4
> +	ori	r4,r4,MSR_EE
> +
> +	mtspr	SPRN_SRR0,r3
> +	mtspr	SPRN_SRR1,r4
> +	mtmsr	r5
> +	b	exc_external_input_book3e
> +
>   /*
>    * Trampolines used when spotting a bad kernel stack pointer in
>    * the exception entry code.
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index d281fb6..44a23d0 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -184,6 +184,17 @@ notrace void arch_local_irq_restore(unsigned long en)
>   		lv1_get_version_info(&tmp);
>   	}
>
> +#ifdef CONFIG_PPC_BOOK3E
> +	/*
> +	 * If there's a pending IRQ, deliver it now.  Interrupts
> +	 * will be hard-enabled on return.
> +	 */
> +	if (get_paca()->irq_pending) {
> +		get_paca()->irq_pending = 0;
> +		deliver_pending_irq();
> +	}
> +#endif
> +
>   	__hard_irq_enable();
>   }
>   EXPORT_SYMBOL(arch_local_irq_restore);
> diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
> index e8cba50..87e7d29 100644
> --- a/arch/powerpc/platforms/85xx/p5020_ds.c
> +++ b/arch/powerpc/platforms/85xx/p5020_ds.c
> @@ -76,12 +76,7 @@ define_machine(p5020_ds) {
>   #ifdef CONFIG_PCI
>   	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
>   #endif
> -/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
> -#ifdef CONFIG_PPC64
> -	.get_irq		= mpic_get_irq,
> -#else
>   	.get_irq		= mpic_get_coreint_irq,
> -#endif
>   	.restart		= fsl_rstcr_restart,
>   	.calibrate_decr		= generic_calibrate_decr,
>   	.progress		= udbg_progress,
> _______________________________________________
> linuxppc-dev mailing list
> linuxppc-dev@linux.freescale.net
> http://linux.freescale.net/mailman/listinfo/linuxppc-dev
