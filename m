Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5B3C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 00:08:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420AD21582
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 00:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="FiuVBaqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420AD21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wMCR667JzF2Hk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:08:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="FiuVBaqH";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wM8p1NTTzF3Ht
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 11:06:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="FiuVBaqH"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42wM8n5sj7z9s8F;
 Thu, 15 Nov 2018 11:06:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1542240377;
 bh=saOFrDaSdDzG1mIjdRzCG/Ox/cmJ9eKoDHGM9vZF/u0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=FiuVBaqHxGjEFbwfTBIzmbQKascz1ld/FOwWEc7ZoKBghIGuKQNag2grDfMW3JN5Q
 cMjpSlJSbT5f2wHw390hGOiyHcJcVVAeDw7GXePfjZaDP0XT1556MhwMeKovJsAoW0
 JOkdvou6ebX/kLYDXVse2K8xJVtrI3waYrtlrJjq6jt9ooIiNO57X6hM1fv/g7m56Z
 Z2FH5axB9xPMC+xU1OsmLuE/n1n9p6r9dLNB1qYV83sRUvyoGGO22iBmFZ+npzDtQ5
 yR72eDYRlmaAf/B2eYxywzLVMkOFeMr+V/ytI/VJq0YNdRcWItQuRGf+uN8ZG/1vTa
 pPP5YND6eGS2A==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id C18B42A2E5F; Thu, 15 Nov 2018 11:06:17 +1100 (AEDT)
Message-ID: <e8b8384b8a46e9bd9e8d9f38ae06ba3423c59d24.camel@neuling.org>
Subject: Re: [RFC PATCH 02/14] powerpc/tm: Reclaim on unavailable exception
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 15 Nov 2018 11:06:17 +1100
In-Reply-To: <1541508028-31865-3-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <1541508028-31865-3-git-send-email-leitao@debian.org>
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
Cc: ldufour@linux.vnet.ibm.com, cyrilbur@gmail.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-11-06 at 10:40 -0200, Breno Leitao wrote:
> If there is a FP/VEC/Altivec touch inside a transaction and the facility =
is
> disabled, then a facility unavailable exception is raised and ends up
> calling {fp,vec,vsx}_unavailable_tm, which was reclaiming and
> recheckpointing.
>=20
> This is not required anymore, since the checkpointed state was reclaimed =
in
> the exception entrance, and it will be recheckpointed by restore_tm_state
> later.
>=20
> Adding a WARN_ON() warning if we hit the _unavailable_tm() in suspended
> mode, i.e, the reclaim was not executed somehow in the trap entrance, and
> this is a bug.

The "why" above is good and the important part of the commit but,=20

Can you also add what you're doing?  The above would suggest you're just
removing some things but you're actually adding the TM_KERNEL_ENTRY() macro=
 too.

Mikey

>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/include/asm/exception-64s.h |  4 ++++
>  arch/powerpc/kernel/exceptions-64s.S     |  3 +++
>  arch/powerpc/kernel/traps.c              | 22 ++++------------------
>  3 files changed, 11 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/exception-64s.h
> b/arch/powerpc/include/asm/exception-64s.h
> index 931a74ba037b..80f01d5683c3 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -711,6 +711,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
>  	 * Soft disable the IRQs, otherwise it might cause a CPU hang.	\
>  	 */								\
>  	RECONCILE_IRQ_STATE(r10, r11);					\
> +	/*								\
> +	 * Although this cause will be set initially, it might be	\
> +	 * updated later, once the exception is better understood	\
> +	 */								\
>  	li      r3, cause;						\
>  	bl      tm_reclaim_current;					\
>  	li      r3, 1;		/* Reclaim happened */			\
> diff --git a/arch/powerpc/kernel/exceptions-64s.S
> b/arch/powerpc/kernel/exceptions-64s.S
> index 5c685a46202d..47e05b09eed6 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -786,6 +786,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  2:	/* User process was in a transaction */
>  	bl	save_nvgprs
> +	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
>  	RECONCILE_IRQ_STATE(r10, r11)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	bl	fp_unavailable_tm
> @@ -1128,6 +1129,7 @@ BEGIN_FTR_SECTION
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  2:	/* User process was in a transaction */
>  	bl	save_nvgprs
> +	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
>  	RECONCILE_IRQ_STATE(r10, r11)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	bl	altivec_unavailable_tm
> @@ -1164,6 +1166,7 @@ BEGIN_FTR_SECTION
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  2:	/* User process was in a transaction */
>  	bl	save_nvgprs
> +	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
>  	RECONCILE_IRQ_STATE(r10, r11)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	bl	vsx_unavailable_tm
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 9a86572db1ef..e74b735e974c 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1742,23 +1742,10 @@ void fp_unavailable_tm(struct pt_regs *regs)
>           * transaction, and probably retry but now with FP enabled.  So =
the
>           * checkpointed FP registers need to be loaded.
>  	 */
> -	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
> -
> -	/*
> -	 * Reclaim initially saved out bogus (lazy) FPRs to ckfp_state, and
> -	 * then it was overwrite by the thr->fp_state by tm_reclaim_thread().
> -	 *
> -	 * At this point, ck{fp,vr}_state contains the exact values we want to
> -	 * recheckpoint.
> -	 */
> +	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
> =20
>  	/* Enable FP for the task: */
>  	current->thread.load_fp =3D 1;
> -
> -	/*
> -	 * Recheckpoint all the checkpointed ckpt, ck{fp, vr}_state registers.
> -	 */
> -	tm_recheckpoint(&current->thread);
>  }
> =20
>  void altivec_unavailable_tm(struct pt_regs *regs)
> @@ -1770,10 +1757,10 @@ void altivec_unavailable_tm(struct pt_regs *regs)
>  	TM_DEBUG("Vector Unavailable trap whilst transactional at 0x%lx,"
>  		 "MSR=3D%lx\n",
>  		 regs->nip, regs->msr);
> -	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
> +	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
>  	current->thread.load_vec =3D 1;
> -	tm_recheckpoint(&current->thread);
>  	current->thread.used_vr =3D 1;
> +
>  }
> =20
>  void vsx_unavailable_tm(struct pt_regs *regs)
> @@ -1792,12 +1779,11 @@ void vsx_unavailable_tm(struct pt_regs *regs)
>  	current->thread.used_vsr =3D 1;
> =20
>  	/* This reclaims FP and/or VR regs if they're already enabled */
> -	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
> +	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
> =20
>  	current->thread.load_vec =3D 1;
>  	current->thread.load_fp =3D 1;
> =20
> -	tm_recheckpoint(&current->thread);
>  }
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> =20
