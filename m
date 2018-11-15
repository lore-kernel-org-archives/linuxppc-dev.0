Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850F3C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:51:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5332086A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="RycMSEJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5332086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wQpt3ww6zF3Zq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 13:51:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="RycMSEJ/";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wQlt26bdzF21T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 13:48:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="RycMSEJ/"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42wQls6m3hz9s8F;
 Thu, 15 Nov 2018 13:48:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1542250105;
 bh=TJ9Hfbly5cvk/RtCmRcnLzwJntnbKyVq0qo2GqT8V2A=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=RycMSEJ/TLbOeay4ZNxKUyWRy4ShykBUGRWXorKomS4tjlGzz8xvTBylwEyiBr8/k
 BnlPh/VU1EKbu9fS82bRAwU/K3B8eySiDk/wMS7bTyCKOwnUd2m16CTOkNnyo80q2q
 tqRHiAsYB0b98E+gJ3iz0NzMuFsvfwOeM9RCBa+IGORgxBNbtaJiU6t5staGtBrbSy
 CrnDaBmT+RPNWM2nUe9NxaWXtBHIK0NXfr5wBU5bW8VHOxmrR0z4sSSvqyvVd+XvP3
 zL+l9MmG6YF7mbhil0a6BDMxviPqGpctlbhl5LyDoHMcPFH6biTFt2zZerdOj/B3q/
 V2yLCUjUCnPFA==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id E03C72A164D; Thu, 15 Nov 2018 13:48:25 +1100 (AEDT)
Message-ID: <9ac8e15969994d85e157dbd2a9df8651df0f9577.camel@neuling.org>
Subject: Re: [RFC PATCH 09/14] powerpc/tm: Warn if state is transactional
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 15 Nov 2018 13:48:25 +1100
In-Reply-To: <1541508028-31865-10-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <1541508028-31865-10-git-send-email-leitao@debian.org>
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
> Since every kernel entrance is calling TM_KERNEL_ENTRY, it is not
> expected to arrive at this point with a suspended transaction.
>=20
> If that is the case, cause a warning and reclaim the current thread in
> order to avoid a TM Bad Thing.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/process.c | 7 +++----
>  arch/powerpc/kernel/signal.c  | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 73872f751b33..849591bf0881 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1752,11 +1752,10 @@ void start_thread(struct pt_regs *regs, unsigned =
long
> start, unsigned long sp)
> =20
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	/*
> -	 * Clear any transactional state, we're exec()ing. The cause is
> -	 * not important as there will never be a recheckpoint so it's not
> -	 * user visible.
> +	 * It is a bug if the transaction was not reclaimed until this
> +	 * point. Warn us and try to workaround it calling tm_reclaim().
>  	 */
> -	if (MSR_TM_SUSPENDED(mfmsr()))
> +	if (WARN_ON(MSR_TM_SUSPENDED(mfmsr())))
>  		tm_reclaim_current(0);
>  #endif

Let's turn these into BUG_ON()

Mikey
=20
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index b3e8db376ecd..cbaccc2be0fb 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -203,7 +203,7 @@ unsigned long get_tm_stackpointer(struct task_struct =
*tsk)
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	BUG_ON(tsk !=3D current);
> =20
> -	if (MSR_TM_ACTIVE(tsk->thread.regs->msr)) {
> +	if (WARN_ON(MSR_TM_ACTIVE(mfmsr()))) {
>  		tm_reclaim_current(TM_CAUSE_SIGNAL);
>  		if (MSR_TM_TRANSACTIONAL(tsk->thread.regs->msr))
>  			return tsk->thread.ckpt_regs.gpr[1];
