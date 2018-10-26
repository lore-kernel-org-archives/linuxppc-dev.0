Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1849AC6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 16:34:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8454020831
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 16:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8454020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hV2N3qnTzF3J7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 03:34:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hV0J6kbczF3H0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 03:32:48 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42hV0765Gmz9ttRr;
 Fri, 26 Oct 2018 18:32:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id RlaJyK_vUIXU; Fri, 26 Oct 2018 18:32:39 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42hV075Wvgz9ttRl;
 Fri, 26 Oct 2018 18:32:39 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id E03DD787; Fri, 26 Oct 2018 18:32:38 +0200 (CEST)
Received: from 37.165.153.35 ([37.165.153.35]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Fri, 26 Oct 2018 18:32:38 +0200
Date: Fri, 26 Oct 2018 18:32:38 +0200
Message-ID: <20181026183238.Horde.Qb6gGcTLnJI-ma8mXsMeBA1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH 2/5] powerpc/futex: GUAP support for futex ops
References: <20181026063513.30806-1-ruscur@russell.cc>
 <20181026063513.30806-3-ruscur@russell.cc>
In-Reply-To: <20181026063513.30806-3-ruscur@russell.cc>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Russell Currey <ruscur@russell.cc> a =C3=A9crit=C2=A0:

> Wrap the futex operations in GUAP locks and unlocks.

Does it means futex doesn't work anymore once only patch 1 is applied=20=20
?=20If so, then you should split patch 1 in two parts and reorder=20=20
patches=20so that guap can only be activated once all necessary changes=20=
=20
are=20done. Otherwise the serie won't be bisectable

Christophe

>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/include/asm/futex.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/futex.h=20=20
>=20b/arch/powerpc/include/asm/futex.h
> index 94542776a62d..3aed640ee9ef 100644
> --- a/arch/powerpc/include/asm/futex.h
> +++ b/arch/powerpc/include/asm/futex.h
> @@ -35,6 +35,7 @@ static inline int arch_futex_atomic_op_inuser(int=20=20
>=20op, int oparg, int *oval,
>  {
>  	int oldval =3D 0, ret;
>
> +	unlock_user_access();
>  	pagefault_disable();
>
>  	switch (op) {
> @@ -62,6 +63,7 @@ static inline int arch_futex_atomic_op_inuser(int=20=20
>=20op, int oparg, int *oval,
>  	if (!ret)
>  		*oval =3D oldval;
>
> +	lock_user_access();
>  	return ret;
>  }
>
> @@ -75,6 +77,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *ua=
ddr,
>  	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
>  		return -EFAULT;
>
> +	unlock_user_access();
>          __asm__ __volatile__ (
>          PPC_ATOMIC_ENTRY_BARRIER
>  "1:     lwarx   %1,0,%3         # futex_atomic_cmpxchg_inatomic\n\
> @@ -95,6 +98,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *ua=
ddr,
>          : "cc", "memory");
>
>  	*uval =3D prev;
> +	lock_user_access();
>          return ret;
>  }
>
> --
> 2.19.1


