Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B84C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 23:33:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C24720851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 23:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="kmHnPeSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C24720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zQBf2Fx1zF3Vb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 10:33:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="kmHnPeSL";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zQ7g00m7zF20f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 10:30:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="kmHnPeSL"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42zQ7d6DXMz9s55;
 Tue, 20 Nov 2018 10:30:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1542670254;
 bh=3uhwcyUNlvPSVxexJiZwsG6OXK/gCPDHz9/Xg24tY1s=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=kmHnPeSLrvnYB5xtMaVwK3Ui6DoEW8g/Ls3gbJRlmrGdekKMYA39asJAiXP40zXR7
 +C78gSwMAWvxESabBsSyjnUSHd1heJl7ZaHgsIKW+7fD5/u0Mnm8UvtT8gixTRVUym
 7YOeKDN+H9FjcQe53tgIwhOevUIpq/bYAcTYUMKK5X2Yq+RR7uBe8Aui56DiNDLUR2
 pZL8GffYiiX3eEi1a/LZjyzE1snOngvFtm8qjsATp5TPRGf8AZf9VQAlDRETwB7vyE
 NfZQg68ecG/1ukORYBfbXc2s3U0iy5MCEMmQlvYtyPP6tAG3mZ1Vkuz67ws1pRGv71
 o81IeUC2hLdXw==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id 2F6B92A0C34; Tue, 20 Nov 2018 10:30:53 +1100 (AEDT)
Message-ID: <9cdf12d1eaa5350e130d3cfb15ecb060323b6788.camel@neuling.org>
Subject: Re: [PATCH] powerpc/tm: Set MSR[TS] just prior to recheckpoint
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 20 Nov 2018 10:30:52 +1100
In-Reply-To: <1542631494-10344-1-git-send-email-leitao@debian.org>
References: <1542631494-10344-1-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
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
Cc: Gustavo Romero <gromero@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-11-19 at 10:44 -0200, Breno Leitao wrote:
> On a signal handler return, the user could set a context with MSR[TS] bit=
s
> set, and these bits would be copied to task regs->msr.
>=20
> At restore_tm_sigcontexts(), after current task regs->msr[TS] bits are se=
t,
> several __get_user() are called and then a recheckpoint is executed.

Do we have the same problem on the entry side?  There are a bunch of
copy_from_user() before we do a tm_reclaim() (ie when still transactional).=
 Is
there some chance of the same problem there?

> This is a problem since a page fault (in kernel space) could happen when
> calling __get_user(). If it happens, the process MSR[TS] bits were
> already set, but recheckpoint was not executed, and SPRs are still invali=
d.
>=20
> The page fault can cause the current process to be de-scheduled, with
> MSR[TS] active and without tm_recheckpoint() being called.  More
> importantly, without TEXAR[FS] bit set also.

This patch is great and should go in ASAP=20

> Since TEXASR might not have the FS bit set, and when the process is
> scheduled back, it will try to reclaim, which will be aborted because of
> the CPU is not in the suspended state, and, then, recheckpoint. This
> recheckpoint will restore thread->texasr into TEXASR SPR, which might be
> zero, hitting a BUG_ON().
>=20
> 	[ 2181.457997] kernel BUG at arch/powerpc/kernel/tm.S:446!

Can you put more of the backtrace here?  Can be useful for people searching=
 for
a similar problem.

> This patch simply delays the MSR[TS] set, so, if there is any page fault =
in
> the __get_user() section, it does not have regs->msr[TS] set, since the T=
M
> structures are still invalid, thus avoiding doing TM operations for
> in-kernel exceptions and possible process reschedule.

Can you put a comment in the code what says after the MSR[TS] setting, ther=
e can
be no get/put_user before the recheckpoint?=20

Also, it looks like the 32bit signals case is safe, but please add a commen=
t in
there too.

> With this patch, the MSR[TS] will only be set just before recheckpointing
> and setting TEXASR[FS] =3D 1, thus avoiding an interrupt with TM register=
s in
> invalid state.
>=20
> It is not possible to move tm_recheckpoint to happen earlier, because it =
is
> required to get the checkpointed registers from userspace, with
> __get_user(), thus, the only way to avoid this undesired behavior is
> delaying the MSR[TS] set, as done in this patch.
>=20
> Fixes: 87b4e5393af7 ("powerpc/tm: Fix return of active 64bit signals")
> Cc: stable@vger.kernel.org (v3.9+)
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/signal_64.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal=
_64.c
> index 83d51bf586c7..15b153bdd826 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -467,20 +467,6 @@ static long restore_tm_sigcontexts(struct task_struc=
t *tsk,
>  	if (MSR_TM_RESV(msr))
>  		return -EINVAL;
> =20
> -	/* pull in MSR TS bits from user context */
> -	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
> -
> -	/*
> -	 * Ensure that TM is enabled in regs->msr before we leave the signal
> -	 * handler. It could be the case that (a) user disabled the TM bit
> -	 * through the manipulation of the MSR bits in uc_mcontext or (b) the
> -	 * TM bit was disabled because a sufficient number of context switches
> -	 * happened whilst in the signal handler and load_tm overflowed,
> -	 * disabling the TM bit. In either case we can end up with an illegal
> -	 * TM state leading to a TM Bad Thing when we return to userspace.
> -	 */
> -	regs->msr |=3D MSR_TM;
> -
>  	/* pull in MSR LE from user context */
>  	regs->msr =3D (regs->msr & ~MSR_LE) | (msr & MSR_LE);
> =20
> @@ -572,6 +558,21 @@ static long restore_tm_sigcontexts(struct task_struc=
t *tsk,
>  	tm_enable();
>  	/* Make sure the transaction is marked as failed */
>  	tsk->thread.tm_texasr |=3D TEXASR_FS;
> +
> +	/* pull in MSR TS bits from user context */
> +	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
> +
> +	/*
> +	 * Ensure that TM is enabled in regs->msr before we leave the signal
> +	 * handler. It could be the case that (a) user disabled the TM bit
> +	 * through the manipulation of ararararthe MSR bits in uc_mcontext or (=
b) the
> +	 * TM bit was disabled because a sufficient number of context switches
> +	 * happened whilst in the signal handler and load_tm overflowed,
> +	 * disabling the TM bit. In either case we can end up with an illegal
> +	 * TM state leading to a TM Bad Thing when we return to userspace.
> +	 */
> +	regs->msr |=3D MSR_TM;
> +
>  	/* This loads the checkpointed FP/VEC state, if used */
>  	tm_recheckpoint(&tsk->thread);
> =20
