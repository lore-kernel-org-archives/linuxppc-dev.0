Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75522C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 00:54:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A30208E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 00:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMlP+UGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A30208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wNDR3qBszF3H4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:54:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qMlP+UGA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qMlP+UGA"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wN9f5drbzF3TP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 11:52:06 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id x21-v6so5885318pln.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 16:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IGSyjdqNV6QtZjChqINPc4r76n5Mjc/xlAeaKdsi7fs=;
 b=qMlP+UGAgYUVGleBibco3Tn/0FUsDGwc2wMg7fxOebl03wmh927Rnhv1V6p1diAFKo
 8DhjQog2FdAFlXCyJxEKJxcxGNA9z+CwV9xib9KidHjwxbLorg5cJiHACQze/wSv8HAx
 zYXXkm9CAEJuEEEe+NLBvu9QkwqEQI8qxp3gyMXZ6VTh04nU2cYzgx/ar+ePzETeo9pt
 M8cSOSi1pM35rGjj8xLDVi0sfF4RUG/NSpJZ81XAi7HHiG4fMuZn5ALw6/5zi4/MaRMB
 vwq6UKE6SqT9IuuEnxZ0dhRpq8cz6jzC4gmKNzwlJv9nKKNbfMII2z6jfECWuaZ5qYbP
 ywLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IGSyjdqNV6QtZjChqINPc4r76n5Mjc/xlAeaKdsi7fs=;
 b=BKIqHTfI3h8zaNQOViZ/jFlQjtDVAEPKacuR2T5HkO/mSB2uMhgKiSIeLMIh7B8pN6
 0Eglz1dCOb0cA7ziyb3IEJJb83cUs+kuaYN+pZfg6ydntBT1jxvJ+vSbeqkBbNYYQUoh
 Y91AoGIbKPPC8naUhnuFF2rlXRalnUrz5is0tFs/Qgcdj32stAShgDJi9CVrVfFHf6yH
 B8g65N5CThG2f4GzZTpEij9gMVMFHxXV3qg33zHAqSLoRp938Bwx0Y7FZDxMxLuJucsd
 th6Wx0yh3TBHmZX0Eo/uXY5puCK/9IwwAbtVev+MpFErGMGHjCo6ABbEe/oCm6OJVNaK
 zyiA==
X-Gm-Message-State: AGRZ1gIk5L27W5I+pGJ1eNPqK3RQZvAxKkOvj5vQv0TtpRqABO6K1ChO
 V+6IxEuzmh7kKCZeZfE5h/c=
X-Google-Smtp-Source: AJdET5cpyfz18mU8nou9pjoR1p3aNb/rrOwUl8hzQvFRZwshzN1qAz6dOofY7LMjAwKYyasqT3FSmg==
X-Received: by 2002:a17:902:a58a:: with SMTP id
 az10mr4244901plb.151.1542243124508; 
 Wed, 14 Nov 2018 16:52:04 -0800 (PST)
Received: from roar.ozlabs.ibm.com
 (148.36.194.203.dial.dynamic.acc01-tull-pth.comindico.com.au.
 [203.194.36.148])
 by smtp.gmail.com with ESMTPSA id v12sm26228498pgg.41.2018.11.14.16.52.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 14 Nov 2018 16:52:03 -0800 (PST)
Date: Thu, 15 Nov 2018 10:51:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [RFC PATCH 01/14] powerpc/tm: Reclaim transaction on kernel entry
Message-ID: <20181115105157.7dd6673a@roar.ozlabs.ibm.com>
In-Reply-To: <1541508028-31865-2-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <1541508028-31865-2-git-send-email-leitao@debian.org>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: mikey@neuling.org, ldufour@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue,  6 Nov 2018 10:40:15 -0200
Breno Leitao <leitao@debian.org> wrote:

> This patch creates a macro that will be invoked on all entrance to the
> kernel, so, in kernel space the transaction will be completely reclaimed
> and not suspended anymore.

This doesn't get invoked on _all_ kernel entries, by the looks (SLB
miss or early machine check, for example). And of course we always
have to run _some_ MSR[PR]=0 code before it is reclaimed. So it is
important to document the rules for what code must not run with TM
suspended now, and why.

> 
> This patchset checks if we are coming from PR, if not, skip. This is useful
> when there is a irq_replay() being called after recheckpoint, when the IRQ
> is re-enable. In this case, we do not want to re-reclaim and
> re-recheckpoint, thus, if not coming from PR, skip it completely.

I really should learn a bit more about TM but I've been trying not to.
Seeing as I don't, I don't really understand this comment. Why don't
we want to reclaim?

> 
> This macro does not care about TM SPR also, it will only be saved and
> restore in the context switch code now on.
> 
> This macro will return 0 or 1 in r3 register, to specify if a reclaim was
> executed or not.

We want to be careful about efficiency here, so I think this macro
should be tightened up. A lot of code doesn't seem to care about the
return value for example, so you could have two macros, one which
cares about return, another which doesn't. Instead of setting value
via branches which you then use to test and branch again, macro could
accept branch labels to go to perhaps.

It would be good to move the TM reclaim path out of line and make the
common case a not taken branch. Don't know how feasible that will be.

> 
> This patchset is based on initial work done by Cyril:
> https://patchwork.ozlabs.org/cover/875341/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 46 ++++++++++++++++++++++++
>  arch/powerpc/kernel/entry_64.S           | 10 ++++++
>  arch/powerpc/kernel/exceptions-64s.S     | 12 +++++--
>  3 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 3b4767ed3ec5..931a74ba037b 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -36,6 +36,7 @@
>   */
>  #include <asm/head-64.h>
>  #include <asm/feature-fixups.h>
> +#include <asm/tm.h>
>  
>  /* PACA save area offsets (exgen, exmc, etc) */
>  #define EX_R9		0
> @@ -677,10 +678,54 @@ BEGIN_FTR_SECTION				\
>  	beql	ppc64_runlatch_on_trampoline;	\
>  END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
>  
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +
> +/*
> + * This macro will reclaim a transaction if called when coming from userspace
> + * (MSR.PR = 1) and if the transaction state is active or suspended.
> + *
> + * Since we don't want to reclaim when coming from kernel, for instance after
> + * a trechkpt. or a IRQ replay, the live MSR is not useful and instead of it the
> + * MSR from thread stack is used to check the MSR.PR bit.
> + * This macro has one argument which is the cause that will be used by treclaim.
> + * and returns in r3 '1' if the reclaim happens or '0' if reclaim didn't
> + * happen, which is useful to know what registers were clobbered.
> + *
> + * NOTE: If addition registers are clobbered here, make sure the callee
> + * function restores them before proceeding.
> + */
> +#define TM_KERNEL_ENTRY(cause)						\
> +	ld      r3, _MSR(r1);						\
> +	andi.   r0, r3, MSR_PR;	/* Coming from userspace? */		\
> +	beq     1f;		/* Skip reclaim if MSR.PR != 1 */	\

I wonder if this can be put with the other userspace entry code?
Maybe it's too difficult.

> +	rldicl. r0, r3, (64-MSR_TM_LG), 63; /* Is TM enabled? */	\
> +	beq     1f;		/* Skip reclaim if TM is off */		\
> +	rldicl. r0, r3, (64-MSR_TS_LG), 62;	/* Is active */		\
> +	beq     1f;		/* Skip reclaim if neither */		\

Can this be merged into a single test?

And/or can these branches be rearranged so the one most likely to
go to skip happens first? (I assume TM being active is less likely
than being enabled).

> +	/*								\
> +	 * If there is a transaction active or suspended, save the	\
> +	 * non-volatile GPRs if they are not already saved.		\
> +	 */								\
> +	bl      save_nvgprs;						\
> +	/*								\
> +	 * Soft disable the IRQs, otherwise it might cause a CPU hang.	\
> +	 */								\
> +	RECONCILE_IRQ_STATE(r10, r11);					\

How might this cause a CPU hang? IRQ state must be reconciled before
enabling MSR[EE] and also before doing any local_irq_disable, etc. But
if we do neither of those things, it should be okay to run C code
without this.

Other option may be to always call this macro after irq state is
reconciled, although that may not work depending on what your rules
are for reclaiming a txn. Maybe two versions of the macro though.

> +	li      r3, cause;						\
> +	bl      tm_reclaim_current;					\
> +	li      r3, 1;		/* Reclaim happened */			\
> +	b       2f;							\
> +1:	li      r3, 0;		/* Reclaim didn't happen */		\
> +2:
> +#else
> +#define TM_KERNEL_ENTRY(cause)
> +#endif
> +
>  #define EXCEPTION_COMMON(area, trap, label, hdlr, ret, additions) \
>  	EXCEPTION_PROLOG_COMMON(trap, area);			\
>  	/* Volatile regs are potentially clobbered here */	\
>  	additions;						\
> +	TM_KERNEL_ENTRY(TM_CAUSE_MISC);					\
>  	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
>  	bl	hdlr;						\
>  	b	ret
> @@ -695,6 +740,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
>  	EXCEPTION_PROLOG_COMMON_3(trap);			\
>  	/* Volatile regs are potentially clobbered here */	\
>  	additions;						\
> +	TM_KERNEL_ENTRY(TM_CAUSE_MISC);				\
>  	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
>  	bl	hdlr
>  
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 7b1693adff2a..17484ebda66c 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -131,6 +131,16 @@ BEGIN_FW_FTR_SECTION
>  END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE && CONFIG_PPC_SPLPAR */
>  
> +#if CONFIG_PPC_TRANSACTIONAL_MEM
> +	TM_KERNEL_ENTRY(TM_CAUSE_SYSCALL)
> +	cmpdi	r3, 0x1
> +	bne	44f
> +	/* Restore from r4 to r12 */
> +	REST_8GPRS(4,r1)
> +44:	/* treclaim was not called, just restore r3 and r0 */
> +	REST_GPR(3, r1)
> +	REST_GPR(0, r1)
> +#endif

AFAIKS this is the only place the return value is used? Unless future
patches use it more.

The comments are not all that helpful. It would be good to add a bit
more explanation. Are these REST_ purely to restore the registers we
clobbered in the process of testing and reclaiming?

Normally the caller passes in registers to the macros which use them
for testing things like this, then it's a bit easier to see what's
going on.

>  	/*
>  	 * A syscall should always be called with interrupts enabled
>  	 * so we just unconditionally hard-enable here. When some kind
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 89d32bb79d5e..5c685a46202d 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -717,6 +717,7 @@ EXC_COMMON_BEGIN(alignment_common)
>  	std	r3,_DAR(r1)
>  	std	r4,_DSISR(r1)
>  	bl	save_nvgprs
> +	TM_KERNEL_ENTRY(TM_CAUSE_ALIGNMENT)
>  	RECONCILE_IRQ_STATE(r10, r11)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	bl	alignment_exception
> @@ -751,6 +752,8 @@ EXC_COMMON_BEGIN(program_check_common)
>  	b 3f				/* Jump into the macro !!	*/
>  1:	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
>  	bl	save_nvgprs
> +	ld      r3, _MSR(r1)

        ^^^ not required

> +	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
>  	RECONCILE_IRQ_STATE(r10, r11)

See these could all be a much smaller macro which does not do the
return value, does not reconcile, does not save nvgprs, etc.

Thanks,
Nick
