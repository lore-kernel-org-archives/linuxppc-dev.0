Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DD1C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 00:08:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9861221471
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 00:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9861221471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PKH34YxgzF3Cf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 10:07:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PKCg12xlzF3F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 10:05:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42PKCg04P1z9s55;
 Tue,  2 Oct 2018 10:05:03 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id EB3B1EE78BF; Tue,  2 Oct 2018 10:05:02 +1000 (AEST)
Message-ID: <c913b7e56237531f0eb3647e1d55d5979cc95448.camel@neuling.org>
Subject: Re: [PATCH 2/2] powerpc/tm: Avoid SPR flush if TM is disabled
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 Oct 2018 10:05:02 +1000
In-Reply-To: <1538423270-17527-2-git-send-email-leitao@debian.org>
References: <1538423270-17527-1-git-send-email-leitao@debian.org>
 <1538423270-17527-2-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
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
Cc: gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-10-01 at 16:47 -0300, Breno Leitao wrote:
> There is a bug in the flush_tmregs_to_thread() function, where it forces
> TM SPRs to be saved to the thread even if the TM facility is disabled.
>=20
> This bug could be reproduced using a simple test case:
>=20
>   mtspr(SPRN_TEXASR, XX);
>   sleep until load_tm =3D=3D 0
>   cause a coredump
>   read SPRN_TEXASR in the coredump
>=20
> In this case, the coredump may contain an invalid SPR, because the
> current code is flushing live SPRs (Used by the last thread with TM
> active) into the current thread, overwriting the latest SPRs (which were
> valid).
>=20
> This patch checks if TM is enabled for current task before
> saving the SPRs, otherwise, the TM is lazily disabled and the thread
> value is already up-to-date and could be used directly, and saving is
> not required.

Acked-by: Michael Neuling <mikey@neuling.org>

Breno, can you send your selftest upstream that also?

Mikey

>=20
> Fixes: cd63f3cf1d5 ("powerpc/tm: Fix saving of TM SPRs in core dump")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 9667666eb18e..e0a2ee865032 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -138,7 +138,12 @@ static void flush_tmregs_to_thread(struct task_struc=
t
> *tsk)
> =20
>  	if (MSR_TM_SUSPENDED(mfmsr())) {
>  		tm_reclaim_current(TM_CAUSE_SIGNAL);
> -	} else {
> +	} else if (tm_enabled(tsk)) {
> +		/*
> +		 * Only flush TM SPRs to the thread if TM was enabled,
> +		 * otherwise (TM lazily disabled), the thread already
> +		 * contains the latest SPR value
> +		 */
>  		tm_enable();
>  		tm_save_sprs(&(tsk->thread));
>  	}
