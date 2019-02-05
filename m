Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B2C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:23:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A46E20821
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="L6KL7ohf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A46E20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v3dN70lmzDqNV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 23:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="L6KL7ohf"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v3R45s3SzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 23:14:24 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43v3Qz61Hwz9vBLw;
 Tue,  5 Feb 2019 13:14:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=L6KL7ohf; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id xoI7HPwVvl2o; Tue,  5 Feb 2019 13:14:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43v3Qz4Yqwz9vBLr;
 Tue,  5 Feb 2019 13:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549368859; bh=NQB/yoqKU/M2n2wkixP4YSkQ5E74ESrMq8bMJZMUvME=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=L6KL7ohfM/8l4typ/e0yF4o2EfsH5CbsEilPSrxn6gWJHsnnWwjw54OQmXZ48EH8i
 YWXIK1frdZVN5Tf1OkP9E2yUipixlNW/Ugm4WYtJazIjMKaHWc2q+ObXIu4YHPpGy0
 9amGlwxZ/FH8GeP420IKAIAIur2tBdTkQNQZ7CYg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DBCBF8B808;
 Tue,  5 Feb 2019 13:14:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BmOoSdSYLg3M; Tue,  5 Feb 2019 13:14:20 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 324268B7F3;
 Tue,  5 Feb 2019 13:14:20 +0100 (CET)
Subject: Re: [RFC/WIP] powerpc: Fix 32-bit handling of MSR_EE on exceptions
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <fe3a79e078c644d9c1379ef5f8c431d787b6d0c8.camel@kernel.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <752a67d0-f6fe-9755-a8fb-485962fcb9f5@c-s.fr>
Date: Tue, 5 Feb 2019 13:14:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <fe3a79e078c644d9c1379ef5f8c431d787b6d0c8.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Diana Craciun <diana.craciun@nxp.com>, Scott Wood <oss@buserror.net>,
 Nick Piggin <npiggin@au1.ibm.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 20/12/2018 à 06:40, Benjamin Herrenschmidt a écrit :
> Hi folks !
> 
> Why trying to figure out why we had occasionally lockdep barf about
> interrupt state on ppc32 (440 in my case but I could reproduce on e500
> as well using qemu), I realized that we are still doing something
> rather gothic and wrong on 32-bit which we stopped doing on 64-bit
> a while ago.
> 
> We have that thing where some handlers "copy" the EE value from the
> original stack frame into the new MSR before transferring to the
> handler.
> 
> Thus for a number of exceptions, we enter the handlers with interrupts
> enabled.
> 
> This is rather fishy, some of the stuff that handlers might do early
> on such as irq_enter/exit or user_exit, context tracking, etc... should
> be run with interrupts off afaik.
> 
> Generally our handlers know when to re-enable interrupts if needed
> (though some of the FSL specific SPE ones don't).
> 
> The problem we were having is that we assumed these interrupts would
> return with interrupts enabled. However that isn't the case.
> 
> Instead, this changes things so that we always enter exception handlers
> with interrupts *off* with the notable exception of syscalls which are
> special (and get a fast path).
> 
> Currently, the patch only changes BookE (440 and E5xx tested in qemu),
> the same recipe needs to be applied to 6xx, 8xx and 40x.
> 
> Also I'm not sure whether we need to create a stack frame around some
> of the calls to trace_hardirqs_* in asm. ppc64 does it, due to problems
> with the irqsoff tracer, but I haven't managed to reproduce those
> issues. We need to look into it a bit more.
> 
> I'll work more on this in the next few days, comments appreciated.
> 
> Not-signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---
>   arch/powerpc/kernel/entry_32.S       | 113 ++++++++++++++++++++++-------------
>   arch/powerpc/kernel/head_44x.S       |   9 +--
>   arch/powerpc/kernel/head_booke.h     |  34 ++++-------
>   arch/powerpc/kernel/head_fsl_booke.S |  28 ++++-----
>   arch/powerpc/kernel/traps.c          |   8 +++
>   5 files changed, 111 insertions(+), 81 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 3841d74..39b4cb5 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -34,6 +34,9 @@
>   #include <asm/ftrace.h>
>   #include <asm/ptrace.h>
>   #include <asm/export.h>
> +#include <asm/feature-fixups.h>
> +#include <asm/barrier.h>
> +#include <asm/bug.h>
>   
>   /*
>    * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
> @@ -205,20 +208,46 @@ transfer_to_handler_cont:
>   	mflr	r9
>   	lwz	r11,0(r9)		/* virtual address of handler */
>   	lwz	r9,4(r9)		/* where to go when done */
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
> +	mtspr	SPRN_NRI, r0
> +#endif
> +
>   #ifdef CONFIG_TRACE_IRQFLAGS
> +	/*
> +	 * When tracing IRQ state (lockdep) we enable the MMU before we call
> +	 * the IRQ tracing functions as they might access vmalloc space or
> +	 * perform IOs for console output.
> +	 *
> +	 * To speed up the syscall path where interrupts stay on, let's check
> +	 * first if we are changing the MSR value at all.
> +	 */
> +	lwz	r12,_MSR(r1)

This one cannot work. MMU is not reenabled yet, so r1 cannot be used. 
And r11 now has the virt address of handler, so can't be used either.

Christophe

> +	xor	r0,r10,r12
> +	andi.	r0,r0,MSR_EE
> +	bne	1f
> +
> +	/* MSR isn't changing, just transition directly */
> +	lwz	r0,GPR0(r1)
> +	mtspr	SPRN_SRR0,r11
> +	mtspr	SPRN_SRR1,r10
> +	mtlr	r9
> +	SYNC
> +	RFI
> +
> +1:	/* MSR is changing, re-enable MMU so we can notify lockdep. We need to
> +	 * keep interrupts disabled at this point otherwise we might risk
> +	 * taking an interrupt before we tell lockdep they are enabled.
> +	 */
>   	lis	r12,reenable_mmu@h
>   	ori	r12,r12,reenable_mmu@l
> +	lis	r0,MSR_KERNEL@h
> +	ori	r0,r0,MSR_KERNEL@l
>   	mtspr	SPRN_SRR0,r12
> -	mtspr	SPRN_SRR1,r10
> +	mtspr	SPRN_SRR1,r0
>   	SYNC
>   	RFI
> -reenable_mmu:				/* re-enable mmu so we can */
> -	mfmsr	r10
> -	lwz	r12,_MSR(r1)
> -	xor	r10,r10,r12
> -	andi.	r10,r10,MSR_EE		/* Did EE change? */
> -	beq	1f
>   
> +reenable_mmu:
>   	/*
>   	 * The trace_hardirqs_off will use CALLER_ADDR0 and CALLER_ADDR1.
>   	 * If from user mode there is only one stack frame on the stack, and
> @@ -239,8 +268,29 @@ reenable_mmu:				/* re-enable mmu so we can */
>   	stw	r3,16(r1)
>   	stw	r4,20(r1)
>   	stw	r5,24(r1)
> -	bl	trace_hardirqs_off
> -	lwz	r5,24(r1)
> +
> +	/* Are we enabling or disabling interrupts ? */
> +	andi.	r0,r10,MSR_EE
> +	beq	1f
> +
> +	/* If we are enabling interrupt, this is a syscall. They shouldn't
> +	 * happen while interrupts are disabled, so let's do a warning here.
> +	 */
> +0:	trap
> +	EMIT_BUG_ENTRY 0b,__FILE__,__LINE__, BUGFLAG_WARNING
> +	bl	trace_hardirqs_on
> +
> +	/* Now enable for real */
> +	mfmsr	r10
> +	ori	r10,r10,MSR_EE
> +	mtmsr	r10
> +	b	2f
> +
> +	/* If we are disabling interrupts (normal case), simply log it with
> +	 * lockdep
> +	 */
> +1:	bl	trace_hardirqs_off
> +2:	lwz	r5,24(r1)
>   	lwz	r4,20(r1)
>   	lwz	r3,16(r1)
>   	lwz	r11,12(r1)
> @@ -250,7 +300,7 @@ reenable_mmu:				/* re-enable mmu so we can */
>   	lwz	r6,GPR6(r1)
>   	lwz	r7,GPR7(r1)
>   	lwz	r8,GPR8(r1)
> -1:	mtctr	r11
> +	mtctr	r11
>   	mtlr	r9
>   	bctr				/* jump to handler */
>   #else /* CONFIG_TRACE_IRQFLAGS */
> @@ -312,31 +362,19 @@ _GLOBAL(DoSyscall)
>   	lwz	r11,_CCR(r1)	/* Clear SO bit in CR */
>   	rlwinm	r11,r11,0,4,2
>   	stw	r11,_CCR(r1)
> +
>   #ifdef CONFIG_TRACE_IRQFLAGS
> -	/* Return from syscalls can (and generally will) hard enable
> -	 * interrupts. You aren't supposed to call a syscall with
> -	 * interrupts disabled in the first place. However, to ensure
> -	 * that we get it right vs. lockdep if it happens, we force
> -	 * that hard enable here with appropriate tracing if we see
> -	 * that we have been called with interrupts off
> -	 */
> +	/* Make sure interrupts are enabled */
>   	mfmsr	r11
>   	andi.	r12,r11,MSR_EE
>   	bne+	1f
> -	/* We came in with interrupts disabled, we enable them now */
> -	bl	trace_hardirqs_on
> -	mfmsr	r11
> -	lwz	r0,GPR0(r1)
> -	lwz	r3,GPR3(r1)
> -	lwz	r4,GPR4(r1)
> -	ori	r11,r11,MSR_EE
> -	lwz	r5,GPR5(r1)
> -	lwz	r6,GPR6(r1)
> -	lwz	r7,GPR7(r1)
> -	lwz	r8,GPR8(r1)
> -	mtmsr	r11
> +	/* We came in with interrupts disabled, we WARN and mark them enabled
> +	 * for lockdep now */
> +0:	trap
> +	EMIT_BUG_ENTRY 0b,__FILE__,__LINE__, BUGFLAG_WARNING
>   1:
>   #endif /* CONFIG_TRACE_IRQFLAGS */
> +
>   	CURRENT_THREAD_INFO(r10, r1)
>   	lwz	r11,TI_FLAGS(r10)
>   	andi.	r11,r11,_TIF_SYSCALL_DOTRACE
> @@ -375,8 +413,7 @@ syscall_exit_cont:
>   	lwz	r8,_MSR(r1)
>   #ifdef CONFIG_TRACE_IRQFLAGS
>   	/* If we are going to return from the syscall with interrupts
> -	 * off, we trace that here. It shouldn't happen though but we
> -	 * want to catch the bugger if it does right ?
> +	 * off, we trace that here. It shouldn't normally happen.
>   	 */
>   	andi.	r10,r8,MSR_EE
>   	bne+	1f
> @@ -881,13 +918,6 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
>   	 * off in this assembly code while peeking at TI_FLAGS() and such. However
>   	 * we need to inform it if the exception turned interrupts off, and we
>   	 * are about to trun them back on.
> -	 *
> -	 * The problem here sadly is that we don't know whether the exceptions was
> -	 * one that turned interrupts off or not. So we always tell lockdep about
> -	 * turning them on here when we go back to wherever we came from with EE
> -	 * on, even if that may meen some redudant calls being tracked. Maybe later
> -	 * we could encode what the exception did somewhere or test the exception
> -	 * type in the pt_regs but that sounds overkill
>   	 */
>   	andi.	r10,r9,MSR_EE
>   	beq	1f
> @@ -1175,9 +1205,10 @@ do_work:			/* r10 contains MSR_KERNEL here */
>   	beq	do_user_signal
>   
>   do_resched:			/* r10 contains MSR_KERNEL here */
> -	/* Note: We don't need to inform lockdep that we are enabling
> -	 * interrupts here. As far as it knows, they are already enabled
> -	 */
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	bl	trace_hardirqs_on
> +	mfmsr	r10
> +#endif
>   	ori	r10,r10,MSR_EE
>   	SYNC
>   	MTMSRD(r10)		/* hard-enable interrupts */
> diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
> index 37e4a7c..891a048 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -40,6 +40,7 @@
>   #include <asm/ptrace.h>
>   #include <asm/synch.h>
>   #include <asm/export.h>
> +
>   #include "head_booke.h"
>   
>   
> @@ -277,16 +278,16 @@ interrupt_base:
>   	FP_UNAVAILABLE_EXCEPTION
>   #else
>   	EXCEPTION(0x2010, BOOKE_INTERRUPT_FP_UNAVAIL, \
> -		  FloatingPointUnavailable, unknown_exception, EXC_XFER_EE)
> +		  FloatingPointUnavailable, unknown_exception, EXC_XFER_STD)
>   #endif
>   	/* System Call Interrupt */
>   	START_EXCEPTION(SystemCall)
>   	NORMAL_EXCEPTION_PROLOG(BOOKE_INTERRUPT_SYSCALL)
> -	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
> +	EXC_XFER_SYS(0x0c00, DoSyscall)
>   
>   	/* Auxiliary Processor Unavailable Interrupt */
>   	EXCEPTION(0x2020, BOOKE_INTERRUPT_AP_UNAVAIL, \
> -		  AuxillaryProcessorUnavailable, unknown_exception, EXC_XFER_EE)
> +		  AuxillaryProcessorUnavailable, unknown_exception, EXC_XFER_STD)
>   
>   	/* Decrementer Interrupt */
>   	DECREMENTER_EXCEPTION
> @@ -294,7 +295,7 @@ interrupt_base:
>   	/* Fixed Internal Timer Interrupt */
>   	/* TODO: Add FIT support */
>   	EXCEPTION(0x1010, BOOKE_INTERRUPT_FIT, FixedIntervalTimer, \
> -		  unknown_exception, EXC_XFER_EE)
> +		  unknown_exception, EXC_XFER_STD)
>   
>   	/* Watchdog Timer Interrupt */
>   	/* TODO: Add watchdog support */
> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
> index a620203..46be533 100644
> --- a/arch/powerpc/kernel/head_booke.h
> +++ b/arch/powerpc/kernel/head_booke.h
> @@ -210,8 +210,7 @@
>   	CRITICAL_EXCEPTION_PROLOG(intno);				\
>   	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
>   	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
> -			  NOCOPY, crit_transfer_to_handler, \
> -			  ret_from_crit_exc)
> +			  crit_transfer_to_handler, ret_from_crit_exc)
>   
>   #define MCHECK_EXCEPTION(n, label, hdlr)			\
>   	START_EXCEPTION(label);					\
> @@ -220,36 +219,27 @@
>   	stw	r5,_ESR(r11);					\
>   	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
>   	EXC_XFER_TEMPLATE(hdlr, n+4, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
> -			  NOCOPY, mcheck_transfer_to_handler,   \
> -			  ret_from_mcheck_exc)
> +			  mcheck_transfer_to_handler, ret_from_mcheck_exc)
>   
> -#define EXC_XFER_TEMPLATE(hdlr, trap, msr, copyee, tfer, ret)	\
> +#define EXC_XFER_TEMPLATE(hdlr, trap, msr, tfer, ret)	\
>   	li	r10,trap;					\
>   	stw	r10,_TRAP(r11);					\
>   	lis	r10,msr@h;					\
>   	ori	r10,r10,msr@l;					\
> -	copyee(r10, r9);					\
>   	bl	tfer;		 				\
>   	.long	hdlr;						\
>   	.long	ret
>   
> -#define COPY_EE(d, s)		rlwimi d,s,0,16,16
> -#define NOCOPY(d, s)
> -
>   #define EXC_XFER_STD(n, hdlr)		\
> -	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, NOCOPY, transfer_to_handler_full, \
> +	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, transfer_to_handler_full, \
>   			  ret_from_except_full)
>   
> -#define EXC_XFER_LITE(n, hdlr)		\
> -	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
> +#define EXC_XFER_SYS(n, hdlr)						\
> +	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL | MSR_EE, transfer_to_handler, \
>   			  ret_from_except)
>   
> -#define EXC_XFER_EE(n, hdlr)		\
> -	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE, transfer_to_handler_full, \
> -			  ret_from_except_full)
> -
> -#define EXC_XFER_EE_LITE(n, hdlr)	\
> -	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, COPY_EE, transfer_to_handler, \
> +#define EXC_XFER_LITE(n, hdlr)		\
> +	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, transfer_to_handler, \
>   			  ret_from_except)
>   
>   /* Check for a single step debug exception while in an exception
> @@ -316,7 +306,7 @@
>   	/* continue normal handling for a debug exception... */		      \
>   2:	mfspr	r4,SPRN_DBSR;						      \
>   	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
> -	EXC_XFER_TEMPLATE(DebugException, 0x2008, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, debug_transfer_to_handler, ret_from_debug_exc)
> +	EXC_XFER_TEMPLATE(DebugException, 0x2008, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), debug_transfer_to_handler, ret_from_debug_exc)
>   
>   #define DEBUG_CRIT_EXCEPTION						      \
>   	START_EXCEPTION(DebugCrit);					      \
> @@ -369,7 +359,7 @@
>   	/* continue normal handling for a critical exception... */	      \
>   2:	mfspr	r4,SPRN_DBSR;						      \
>   	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
> -	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
> +	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), crit_transfer_to_handler, ret_from_crit_exc)
>   
>   #define DATA_STORAGE_EXCEPTION						      \
>   	START_EXCEPTION(DataStorage)					      \
> @@ -394,7 +384,7 @@
>   	mfspr   r4,SPRN_DEAR;           /* Grab the DEAR and save it */	      \
>   	stw     r4,_DEAR(r11);						      \
>   	addi    r3,r1,STACK_FRAME_OVERHEAD;				      \
> -	EXC_XFER_EE(0x0600, alignment_exception)
> +	EXC_XFER_STD(0x0600, alignment_exception)
>   
>   #define PROGRAM_EXCEPTION						      \
>   	START_EXCEPTION(Program)					      \
> @@ -419,7 +409,7 @@
>   	bl	load_up_fpu;		/* if from user, just load it up */   \
>   	b	fast_exception_return;					      \
>   1:	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
> -	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
> +	EXC_XFER_STD(0x800, kernel_fp_unavailable_exception)
>   
>   #ifndef __ASSEMBLY__
>   struct exception_regs {
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index bf4c602..556cffb 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -385,7 +385,7 @@ interrupt_base:
>   	EXC_XFER_LITE(0x0300, handle_page_fault)
>   1:
>   	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	EXC_XFER_EE_LITE(0x0300, CacheLockingException)
> +	EXC_XFER_LITE(0x0300, CacheLockingException)
>   
>   	/* Instruction Storage Interrupt */
>   	INSTRUCTION_STORAGE_EXCEPTION
> @@ -406,21 +406,21 @@ interrupt_base:
>   #ifdef CONFIG_E200
>   	/* E200 treats 'normal' floating point instructions as FP Unavail exception */
>   	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, \
> -		  program_check_exception, EXC_XFER_EE)
> +		  program_check_exception, EXC_XFER_STD)
>   #else
>   	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, \
> -		  unknown_exception, EXC_XFER_EE)
> +		  unknown_exception, EXC_XFER_STD)
>   #endif
>   #endif
>   
>   	/* System Call Interrupt */
>   	START_EXCEPTION(SystemCall)
>   	NORMAL_EXCEPTION_PROLOG(SYSCALL)
> -	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
> +	EXC_XFER_SYS(0x0c00, DoSyscall)
>   
>   	/* Auxiliary Processor Unavailable Interrupt */
>   	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
> -		  unknown_exception, EXC_XFER_EE)
> +		  unknown_exception, EXC_XFER_STD)
>   
>   	/* Decrementer Interrupt */
>   	DECREMENTER_EXCEPTION
> @@ -428,7 +428,7 @@ interrupt_base:
>   	/* Fixed Internal Timer Interrupt */
>   	/* TODO: Add FIT support */
>   	EXCEPTION(0x3100, FIT, FixedIntervalTimer, \
> -		  unknown_exception, EXC_XFER_EE)
> +		  unknown_exception, EXC_XFER_STD)
>   
>   	/* Watchdog Timer Interrupt */
>   #ifdef CONFIG_BOOKE_WDT
> @@ -623,25 +623,25 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>   	bl	load_up_spe
>   	b	fast_exception_return
>   1:	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	EXC_XFER_EE_LITE(0x2010, KernelSPE)
> +	EXC_XFER_LITE(0x2010, KernelSPE)
>   #elif defined(CONFIG_SPE_POSSIBLE)
>   	EXCEPTION(0x2020, SPE_UNAVAIL, SPEUnavailable, \
> -		  unknown_exception, EXC_XFER_EE)
> +		  unknown_exception, EXC_XFER_STD)
>   #endif /* CONFIG_SPE_POSSIBLE */
>   
>   	/* SPE Floating Point Data */
>   #ifdef CONFIG_SPE
>   	EXCEPTION(0x2030, SPE_FP_DATA, SPEFloatingPointData,
> -		  SPEFloatingPointException, EXC_XFER_EE)
> +		  SPEFloatingPointException, EXC_XFER_STD)
>   
>   	/* SPE Floating Point Round */
>   	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
> -		  SPEFloatingPointRoundException, EXC_XFER_EE)
> +		  SPEFloatingPointRoundException, EXC_XFER_STD)
>   #elif defined(CONFIG_SPE_POSSIBLE)
>   	EXCEPTION(0x2040, SPE_FP_DATA, SPEFloatingPointData,
> -		  unknown_exception, EXC_XFER_EE)
> +		  unknown_exception, EXC_XFER_STD)
>   	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
> -		  unknown_exception, EXC_XFER_EE)
> +		  unknown_exception, EXC_XFER_STD)
>   #endif /* CONFIG_SPE_POSSIBLE */
>   
>   
> @@ -664,10 +664,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>   			   unknown_exception)
>   
>   	/* Hypercall */
> -	EXCEPTION(0, HV_SYSCALL, Hypercall, unknown_exception, EXC_XFER_EE)
> +	EXCEPTION(0, HV_SYSCALL, Hypercall, unknown_exception, EXC_XFER_STD)
>   
>   	/* Embedded Hypervisor Privilege */
> -	EXCEPTION(0, HV_PRIV, Ehvpriv, unknown_exception, EXC_XFER_EE)
> +	EXCEPTION(0, HV_PRIV, Ehvpriv, unknown_exception, EXC_XFER_STD)
>   
>   interrupt_end:
>   
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 023a462..5ee0b90 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1858,6 +1858,10 @@ void SPEFloatingPointException(struct pt_regs *regs)
>   	int code = 0;
>   	int err;
>   
> +	/* We restore the interrupt state now */
> +	if (!arch_irq_disabled_regs(regs))
> +		local_irq_enable();
> +
>   	flush_spe_to_thread(current);
>   
>   	spefscr = current->thread.spefscr;
> @@ -1903,6 +1907,10 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
>   	extern int speround_handler(struct pt_regs *regs);
>   	int err;
>   
> +	/* We restore the interrupt state now */
> +	if (!arch_irq_disabled_regs(regs))
> +		local_irq_enable();
> +
>   	preempt_disable();
>   	if (regs->msr & MSR_SPE)
>   		giveup_spe(current);
> 
