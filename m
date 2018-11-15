Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFD1C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 00:13:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D46A224E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 00:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="Ll3XGU9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D46A224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wMKK0nb9zF3Dq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:13:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="Ll3XGU9R";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wMGN2HxszF3J4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 11:11:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="Ll3XGU9R"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42wMGJ6Nfkz9s7T;
 Thu, 15 Nov 2018 11:11:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1542240664;
 bh=700VblJq2eN/MDFOaHnocxoRRkJU08Nmsg24K9xsaP4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=Ll3XGU9RUx0l3gtUf4B241aWbsPbADq3ygSmzonVd2zoT0B/X6puRQjQZGIuuei9J
 mzBpYXadL5mLsvVrxwcqztnBFdw0O8T++UeWQrorhKv2g/cekI5QgAA+cQPsdiKxzN
 9L7cDLP610nUSijAVF+zlZffQipIxZHsayNjPBfxE0Pqht8MVhqu5JML1ZKilifELc
 LiHRNjmSQInqdTLhTwspzKniy3xNpeT/UejGO3G+o3tOEYsQgHMOhgVljfofXEb3Q5
 jy17fEQhB6aq0sE2jjUHMTQDrAJAVBuVMU/JhaMSL9d37ch9vTd7HlPr6og2ULQu7r
 mDmpFvE3O7wqQ==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id D1DD22A2E5F; Thu, 15 Nov 2018 11:11:04 +1100 (AEDT)
Message-ID: <c46ccc2b5ef581ad802e55e5e61119f67d184fcc.camel@neuling.org>
Subject: Re: [RFC PATCH 03/14] powerpc/tm: Recheckpoint when exiting from
 kernel
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 15 Nov 2018 11:11:04 +1100
In-Reply-To: <1541508028-31865-4-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <1541508028-31865-4-git-send-email-leitao@debian.org>
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
> This is the only place we are going to recheckpoint now. Now the task
> needs to have TIF_RESTORE_TM flag set, which will get into
> restore_tm_state() at exception exit path, and execute the recheckpoint
> depending on the MSR.
>=20
> Every time a task is required to recheckpoint, or just have the TM SPRs
> restore, the TIF_RESTORE_TM flag should be set and the task MSR should
> properly be in a transactional state, which will be checked by
> restore_tm_state().
>=20
> After the facility registers are recheckpointed, they are clobbered with
> the values that were recheckpointed (and are now also in the checkpoint
> area).

Which facility registers? I don't understand this.

> If facility is enabled at MSR that is being returned to user space, then
> the facility registers need to be restored, otherwise userspace will see
> invalid values.
>=20
> This patch simplify the restore_tm_state() to just restore the facility
> registers that are enabled when returning to userspace, i.e. the MSR will
> be the same that will be put into SRR1, which will be the MSR after RFID.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/process.c | 38 ++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 4d5322cfad25..c7e758a42b8f 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1049,8 +1049,6 @@ static inline void __switch_to_tm(struct task_struc=
t
> *prev,
>   */
>  void restore_tm_state(struct pt_regs *regs)
>  {
> -	unsigned long msr_diff;
> -
>  	/*
>  	 * This is the only moment we should clear TIF_RESTORE_TM as
>  	 * it is here that ckpt_regs.msr and pt_regs.msr become the same
> @@ -1061,19 +1059,35 @@ void restore_tm_state(struct pt_regs *regs)
>  	if (!MSR_TM_ACTIVE(regs->msr))
>  		return;
> =20
> -	msr_diff =3D current->thread.ckpt_regs.msr & ~regs->msr;
> -	msr_diff &=3D MSR_FP | MSR_VEC | MSR_VSX;
> +	tm_enable();
> +	/* The only place we recheckpoint */
> +	tm_recheckpoint(&current->thread);
> =20
> -	/* Ensure that restore_math() will restore */
> -	if (msr_diff & MSR_FP)
> -		current->thread.load_fp =3D 1;
> +	/*
> +	 * Restore the facility registers that were clobbered during
> +	 * recheckpoint.
> +	 */
> +	if (regs->msr & MSR_FP) {
> +		/*
> +		 * Using load_fp_state() instead of restore_fp() because we
> +		 * want to force the restore, independent of
> +		 * tsk->thread.load_fp. Same for other cases below.
> +		 */
> +		load_fp_state(&current->thread.fp_state);
> +	}
>  #ifdef CONFIG_ALTIVEC
> -	if (cpu_has_feature(CPU_FTR_ALTIVEC) && msr_diff & MSR_VEC)
> -		current->thread.load_vec =3D 1;
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC) && regs->msr & MSR_VEC)
> +		load_vr_state(&current->thread.vr_state);
> +#endif
> +#ifdef CONFIG_VSX
> +	if (cpu_has_feature(CPU_FTR_VSX) && regs->msr & MSR_VSX) {
> +		/*
> +		 * If VSX is enabled, it is expected that VEC and FP are
> +		 * also enabled and already restored the full register set.
> +		 * Cause a warning if that is not the case.
> +		 */
> +		WARN_ON(!(regs->msr & MSR_VEC) || !(regs->msr & MSR_FP)); }
>  #endif
> -	restore_math(regs);
> -
> -	regs->msr |=3D msr_diff;
>  }
> =20
>  #else
