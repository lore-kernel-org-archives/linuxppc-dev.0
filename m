Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4752EC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 17:38:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C85C218DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 17:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C85C218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WX7w743WzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 04:38:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WX691N6jzDqLr
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 04:37:04 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43WX621Whcz9v25c;
 Fri,  4 Jan 2019 18:36:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 0iC6j55v_-A8; Fri,  4 Jan 2019 18:36:58 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43WX620ydVz9v25b;
 Fri,  4 Jan 2019 18:36:58 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id AFDFFD4E; Fri,  4 Jan 2019 18:36:59 +0100 (CET)
Received: from 37.165.122.65 ([37.165.122.65]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Fri, 04 Jan 2019 18:36:59 +0100
Date: Fri, 04 Jan 2019 18:36:59 +0100
Message-ID: <20190104183659.Horde.Xco_Q-bqCSSJoWwerf1bVw4@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: sparclinux@vger.kernel.org, Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] Remove 'type' argument from access_ok() function
In-Reply-To: <20190104092758.4378-1-malat@debian.org>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mathieu Malaterre <malat@debian.org> a =C3=A9crit=C2=A0:

> In commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") an attempt was made to remove a warning by referencing the
> variable `type`, however in commit 96d4f267e40f ("Remove 'type' argument
> from access_ok() function") the variable `type` has been removed.
>
> Revert commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") to fix the following compilation error:
>
>   arch/powerpc/include/asm/uaccess.h:66:32: error: =E2=80=98type=E2=80=99=
 undeclared=20=20
>=20(first use in this function)
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Should you add a Fixes:  96d4f267e40f ?

Note that sparc arch will have the same issue.

Christophe

> ---
>  arch/powerpc/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/uaccess.h=20=20
>=20b/arch/powerpc/include/asm/uaccess.h
> index b31bf45eebd4..5f0c98e511a0 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -63,7 +63,7 @@ static inline int __access_ok(unsigned long addr,=20=20
>=20unsigned long size,
>  #endif
>
>  #define access_ok(addr, size)		\
> -	(__chk_user_ptr(addr), (void)(type),		\
> +	(__chk_user_ptr(addr),			\
>  	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
>
>  /*
> --
> 2.19.2


