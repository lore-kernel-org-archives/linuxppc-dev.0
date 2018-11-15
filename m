Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EDBC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 03:05:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A270D21582
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 03:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="JoBAOUhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A270D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wR704cX2zF3Zp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 14:05:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="JoBAOUhQ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wR4W2MQ9zF3KT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 14:02:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="JoBAOUhQ"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42wR4W0PNVz9s8F;
 Thu, 15 Nov 2018 14:02:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1542250971;
 bh=oGSBUCqFNUyiTXD5d3ZbsGuvWcSelWpyCupLUBwIw3k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=JoBAOUhQRjB7JKlrVkEaJiAcOlCEsGttHKdIe2Z9lmyIADCmx65Khk1BgPWqwfD9K
 XPIZJlji4CAEHFDDcfKbWBdnyI1tgK5K8oBytKo9X3Rw/Ystv82+4EKDdsl+BPesJl
 zMu/mglWSOMpcbej1inobAQA621gD2Wy3C4OB2JX0lxZeGI1ZvKuuS/Etib3g7mkH9
 r0GtUFkkO7YbNzPDt/qW4bTgDayC+MwiYojjS/Yw2ppQQErq5cAYEVKrNCLcfTasgC
 OPuMVJKa5QoakTJ//z5L7jUKHJPny9U+aAYEg0iuNIXx9U3PrJHFdL+Z7km+Hgi5mC
 LRme+a81VotYQ==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id 0247D2A164C; Thu, 15 Nov 2018 14:02:50 +1100 (AEDT)
Message-ID: <32a9990d0e2516bfada1bb0c21969d8bdc76cbff.camel@neuling.org>
Subject: Re: [RFC PATCH 13/14] powerpc/tm: Do not restore TM without SPRs
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 15 Nov 2018 14:02:50 +1100
In-Reply-To: <1541508028-31865-14-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <1541508028-31865-14-git-send-email-leitao@debian.org>
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
> Currently the signal context restore code enables the bit on the MSR
> register without restoring the TM SPRs, which can cause undesired side
> effects.
>=20
> This is not correct because if TM is enabled in MSR, it means the TM SPR
> registers are valid and updated, which is not correct here. In fact, the
> live registers may contain previous' thread SPRs.
>=20
> Functions check if the register values are valid or not through looking
> if the facility is enabled at MSR, as MSR[TM] set means that the TM SPRs
> are hot.
>=20
> When just enabling MSR[TM] without updating the live SPRs, this can cause=
 a
> crash, since current TM SPR from previous thread will be saved on the
> current thread, and might not have TEXASR[FS] set, for example.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/signal_64.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal=
_64.c
> index 487c3b6aa2e3..156b90e8ee78 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -478,8 +478,18 @@ static long restore_tm_sigcontexts(struct task_struc=
t
> *tsk,
>  	 * happened whilst in the signal handler and load_tm overflowed,
>  	 * disabling the TM bit. In either case we can end up with an illegal
>  	 * TM state leading to a TM Bad Thing when we return to userspace.
> +	 *
> +	 * Every time MSR_TM is enabled, mainly for the b) case, the TM SPRs
> +	 * must be restored in the live registers, since the live registers
> +	 * could contain garbage and later we want to read from live, since
> +	 * MSR_TM is enabled, and MSR[TM] is what is used to check if the
> +	 * TM SPRs live registers are valid or not.
>  	 */
> -	regs->msr |=3D MSR_TM;
> +	if ((regs->msr & MSR_TM) =3D=3D 0) {
> +		regs->msr |=3D MSR_TM;
> +		tm_enable();
> +		tm_restore_sprs(&tsk->thread);
> +	}

I'm wondering if we should put the save/restore TM registers in the early
entry/exit code too. We'd need to add the check on msr[tm]/load_tm.

Distributing the SPR save/restore throughout the kernel is just going to le=
ad us
to similar problems that we are having now with reclaim/recheckpoint.

Mikey


> =20
>  	/* pull in MSR LE from user context */
>  	regs->msr =3D (regs->msr & ~MSR_LE) | (msr & MSR_LE);
