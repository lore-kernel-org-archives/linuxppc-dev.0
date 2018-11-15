Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69901C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 00:11:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACFD22419
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 00:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="Iy01UbE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACFD22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wMGD5yz4zF3Q7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:11:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="Iy01UbE3";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wM9F4tNqzF3XP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 11:06:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="Iy01UbE3"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42wM9F38P0z9s8J;
 Thu, 15 Nov 2018 11:06:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1542240401;
 bh=GbsX9SsV/QQKzrvh5D76blnqd7RW1BUzpAtall+GsJ4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=Iy01UbE3DD4XJS8p/76ac9Qm6btNnTw59x8BQYLY+AWnnv3WiQ4PAEg+G+eUFTufU
 TbqauoOQ2KXbxXzXzJnrsGpoyQu//iGSzB3OIuz5nrM/CuKPglKkuK0vLFiGHaH07r
 RKQ/RhCeVNkf6f3vTo3AtRp9eRw0xCRzQY6tXysxp8Nx7sFiKvZb9KK/nkp2QRwi8O
 ONUXJR0V9g4Yd9wGy6/FOpTmIBzLG6Xa3YcsIOWlFxqypMVYq3zgKmyXbkSxZf50Ec
 nM6OP68fnNA9Niygf0GXZcViC2RiANLkv8sFEny+iACwr4D1Wj8cOZs13fFe+H5u0H
 F3BFrT3FrFpPw==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id 63F182A2E5F; Thu, 15 Nov 2018 11:06:41 +1100 (AEDT)
Message-ID: <d2494c7b5af49df8cee9aac603658fccdfa0585c.camel@neuling.org>
Subject: Re: [RFC PATCH 01/14] powerpc/tm: Reclaim transaction on kernel entry
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 15 Nov 2018 11:06:41 +1100
In-Reply-To: <1541508028-31865-2-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <1541508028-31865-2-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
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
Cc: Nicholas Piggin <npiggin@gmail.com>, gromero@linux.vnet.ibm.com,
 ldufour@linux.vnet.ibm.com, cyrilbur@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-11-06 at 10:40 -0200, Breno Leitao wrote:
> This patch creates a macro that will be invoked on all entrance to the
> kernel, so, in kernel space the transaction will be completely reclaimed
> and not suspended anymore.
>=20
> This patchset checks if we are coming from PR, if not, skip.=20

Remove the double negative here. ie

"This skips when coming from the OS". or "Only happens when coming from PR"

> This is useful
> when there is a irq_replay() being called after recheckpoint, when the IR=
Q
> is re-enable.=20

So we are talking about tm_recheckpoint on exit? On exit, we do:
   tm_recheckpoint -> irq_replay -> rfid?

Why not swap the order of the recheckpoint and the replay to avoid this pro=
blem?

> In this case, we do not want to re-reclaim and
> re-recheckpoint, thus, if not coming from PR, skip it completely.

Move double negatives... Try: "if coming from the OS, skip" or "only do it =
when
coming from userspace"

> This macro does not care about TM SPR also, it will only be saved and
> restore in the context switch code now on.
> This macro will return 0 or 1 in r3 register, to specify if a reclaim was
> executed or not.
>=20
> This patchset is based on initial work done by Cyril:
> https://patchwork.ozlabs.org/cover/875341/
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 46 ++++++++++++++++++++++++
>  arch/powerpc/kernel/entry_64.S           | 10 ++++++
>  arch/powerpc/kernel/exceptions-64s.S     | 12 +++++--
>  3 files changed, 66 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/incl=
ude/asm/exception-64s.h
> index 3b4767ed3ec5..931a74ba037b 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -36,6 +36,7 @@
>   */
>  #include <asm/head-64.h>
>  #include <asm/feature-fixups.h>
> +#include <asm/tm.h>
> =20
>  /* PACA save area offsets (exgen, exmc, etc) */
>  #define EX_R9		0
> @@ -677,10 +678,54 @@ BEGIN_FTR_SECTION				\
>  	beql	ppc64_runlatch_on_trampoline;	\
>  END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
> =20
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +
> +/*
> + * This macro will reclaim a transaction if called when coming from user=
space
> + * (MSR.PR =3D 1) and if the transaction state is active or suspended.
> + *
> + * Since we don't want to reclaim when coming from kernel, for instance =
after
> + * a trechkpt. or a IRQ replay, the live MSR is not useful and instead o=
f it the
> + * MSR from thread stack is used to check the MSR.PR bit.
> + * This macro has one argument which is the cause that will be used by t=
reclaim.
> + * and returns in r3 '1' if the reclaim happens or '0' if reclaim didn't
> + * happen, which is useful to know what registers were clobbered.
> + *
> + * NOTE: If addition registers are clobbered here, make sure the callee
> + * function restores them before proceeding.
> + */
> +#define TM_KERNEL_ENTRY(cause)						\
> +	ld      r3, _MSR(r1);						\
> +	andi.   r0, r3, MSR_PR;	/* Coming from userspace? */		\
> +	beq     1f;		/* Skip reclaim if MSR.PR !=3D 1 */	\
> +	rldicl. r0, r3, (64-MSR_TM_LG), 63; /* Is TM enabled? */	\
> +	beq     1f;		/* Skip reclaim if TM is off */		\
> +	rldicl. r0, r3, (64-MSR_TS_LG), 62;	/* Is active */		\
> +	beq     1f;		/* Skip reclaim if neither */		\
> +	/*								\
> +	 * If there is a transaction active or suspended, save the	\
> +	 * non-volatile GPRs if they are not already saved.		\
> +	 */								\
> +	bl      save_nvgprs;						\
> +	/*								\
> +	 * Soft disable the IRQs, otherwise it might cause a CPU hang.	\
> +	 */								\
> +	RECONCILE_IRQ_STATE(r10, r11);					\
> +	li      r3, cause;						\
> +	bl      tm_reclaim_current;					\

Are we ready to call out to C at this point in the exception handlers?

> +	li      r3, 1;		/* Reclaim happened */			\
> +	b       2f;							\
> +1:	li      r3, 0;		/* Reclaim didn't happen */             \
> +2:
> +#else
> +#define TM_KERNEL_ENTRY(cause)
> +#endif
> +
>  #define EXCEPTION_COMMON(area, trap, label, hdlr, ret, additions) \
>         EXCEPTION_PROLOG_COMMON(trap, area);                    \
>         /* Volatile regs are potentially clobbered here */      \
>         additions;                                              \
> +       TM_KERNEL_ENTRY(TM_CAUSE_MISC);                                 \
>         addi    r3,r1,STACK_FRAME_OVERHEAD;                     \
>         bl      hdlr;                                           \
>         b       ret
> @@ -695,6 +740,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
>         EXCEPTION_PROLOG_COMMON_3(trap);                        \
>         /* Volatile regs are potentially clobbered here */      \
>         additions;                                              \
> +       TM_KERNEL_ENTRY(TM_CAUSE_MISC);                         \
>         addi    r3,r1,STACK_FRAME_OVERHEAD;                     \
>         bl      hdlr
> =20
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index 7b1693adff2a..17484ebda66c 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -131,6 +131,16 @@ BEGIN_FW_FTR_SECTION
>  END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE && CONFIG_PPC_SPLPAR */
> =20
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
>  	/*
>  	 * A syscall should always be called with interrupts enabled
>  	 * so we just unconditionally hard-enable here. When some kind
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/e=
xceptions-64s.S
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
> +	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
>  	RECONCILE_IRQ_STATE(r10, r11)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	bl	program_check_exception
> @@ -1650,7 +1653,9 @@ do_hash_page:
> =20
>  /* Here we have a page fault that hash_page can't handle. */
>  handle_page_fault:
> -11:	andis.  r0,r4,DSISR_DABRMATCH@h
> +11:	TM_KERNEL_ENTRY(TM_CAUSE_TLBI)
> +	ld      r4,_DSISR(r1)
> +	andis.  r0,r4,DSISR_DABRMATCH@h
>  	bne-    handle_dabr_fault
>  	ld	r4,_DAR(r1)
>  	ld	r5,_DSISR(r1)
> @@ -1681,6 +1686,8 @@ handle_dabr_fault:
>   */
>  13:	bl	save_nvgprs
>  	mr	r5,r3
> +	TM_KERNEL_ENTRY(TM_CAUSE_TLBI)
> +	REST_GPR(3,r1)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	ld	r4,_DAR(r1)
>  	bl	low_hash_fault
> @@ -1695,7 +1702,8 @@ handle_dabr_fault:
>   * the access, or panic if there isn't a handler.
>   */
>  77:	bl	save_nvgprs
> -	mr	r4,r3
> +	TM_KERNEL_ENTRY(TM_CAUSE_TLBI)
> +	ld      r4,_DAR(r1)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	li	r5,SIGSEGV
>  	bl	bad_page_fault
