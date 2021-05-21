Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B5BC47076
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 17:43:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81A061353
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 17:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81A061353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fmv8Q39ykz3brx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 May 2021 03:43:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fmv834Nrxz2xyC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 May 2021 03:42:39 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4Fmv7t405xzBBKd;
 Fri, 21 May 2021 19:42:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sGQ2atNXMHyd; Fri, 21 May 2021 19:42:34 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Fmv7t2td7zBBKC;
 Fri, 21 May 2021 19:42:34 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 828B3427; Fri, 21 May 2021 19:46:56 +0200 (CEST)
Received: from 37-169-24-72.coucou-networks.fr
 (37-169-24-72.coucou-networks.fr [37.169.24.72]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Fri, 21 May 2021 19:46:56 +0200
Date: Fri, 21 May 2021 19:46:56 +0200
Message-ID: <20210521194656.Horde.hiP1EHfMBv05hLGgUhTorg1@messagerie.c-s.fr>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 01/11] powerpc: remove interrupt exit helpers unused
 argument
References: <20210521114422.3179350-1-npiggin@gmail.com>
 <20210521114422.3179350-2-npiggin@gmail.com>
In-Reply-To: <20210521114422.3179350-2-npiggin@gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> a =C3=A9crit=C2=A0:

> The msr argument is not used, remove it.

Why not keep and use that msr argument instead of re-reading regs->msr ?

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/asm-prototypes.h | 4 ++--
>  arch/powerpc/kernel/interrupt.c           | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/asm-prototypes.h=20=20
>=20b/arch/powerpc/include/asm/asm-prototypes.h
> index 1c7b75834e04..95492655462e 100644
> --- a/arch/powerpc/include/asm/asm-prototypes.h
> +++ b/arch/powerpc/include/asm/asm-prototypes.h
> @@ -71,8 +71,8 @@ void __init machine_init(u64 dt_ptr);
>  #endif
>  long system_call_exception(long r3, long r4, long r5, long r6, long=20=
=20
>=20r7, long r8, unsigned long r0, struct pt_regs *regs);
>  notrace unsigned long syscall_exit_prepare(unsigned long r3, struct=20=
=20
>=20pt_regs *regs, long scv);
> -notrace unsigned long interrupt_exit_user_prepare(struct pt_regs=20=20
>=20*regs, unsigned long msr);
> -notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs=20=20
>=20*regs, unsigned long msr);
> +notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs);
> +notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs=
);
>
>  long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_lo=
w,
>  		      u32 len_high, u32 len_low);
> diff --git a/arch/powerpc/kernel/interrupt.c=20=20
>=20b/arch/powerpc/kernel/interrupt.c
> index e0938ba298f2..38ae7057d6c2 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -352,7 +352,7 @@ notrace unsigned long=20=20
>=20syscall_exit_prepare(unsigned long r3,
>  	return ret;
>  }
>
> -notrace unsigned long interrupt_exit_user_prepare(struct pt_regs=20=20
>=20*regs, unsigned long msr)
> +notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
>  {
>  	unsigned long ti_flags;
>  	unsigned long flags;
> @@ -431,7 +431,7 @@ notrace unsigned long=20=20
>=20interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
>
>  void preempt_schedule_irq(void);
>
> -notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs=20=20
>=20*regs, unsigned long msr)
> +notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs=
)
>  {
>  	unsigned long flags;
>  	unsigned long ret =3D 0;
> --
> 2.23.0


