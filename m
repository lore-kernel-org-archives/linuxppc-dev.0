Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00450C6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 16:36:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570CF2075D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 16:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570CF2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hV4v6QYQzF0Pd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 03:36:47 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hV1R1ffCzF3JG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 03:33:47 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42hV1G4LDGz9ttRr;
 Fri, 26 Oct 2018 18:33:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id nHV3wnDiCJfu; Fri, 26 Oct 2018 18:33:38 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42hV1G3Z1Kz9ttRl;
 Fri, 26 Oct 2018 18:33:38 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 9DB627B6; Fri, 26 Oct 2018 18:33:37 +0200 (CEST)
Received: from 37.165.153.35 ([37.165.153.35]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Fri, 26 Oct 2018 18:33:37 +0200
Date: Fri, 26 Oct 2018 18:33:37 +0200
Message-ID: <20181026183337.Horde.lH9XlZlFf844hU8quta91Q6@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH 3/5] powerpc/lib: checksum GUAP support
References: <20181026063513.30806-1-ruscur@russell.cc>
 <20181026063513.30806-4-ruscur@russell.cc>
In-Reply-To: <20181026063513.30806-4-ruscur@russell.cc>
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

Same comment as for futex

Christophe

Russell Currey <ruscur@russell.cc> a =C3=A9crit=C2=A0:

> Wrap the checksumming code in GUAP locks and unlocks.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/lib/checksum_wrappers.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/lib/checksum_wrappers.c=20=20
>=20b/arch/powerpc/lib/checksum_wrappers.c
> index a0cb63fb76a1..c67db0a6e18b 100644
> --- a/arch/powerpc/lib/checksum_wrappers.c
> +++ b/arch/powerpc/lib/checksum_wrappers.c
> @@ -28,6 +28,7 @@ __wsum csum_and_copy_from_user(const void __user=20=20
>=20*src, void *dst,
>  {
>  	unsigned int csum;
>
> +	unlock_user_access();
>  	might_sleep();
>
>  	*err_ptr =3D 0;
> @@ -60,6 +61,7 @@ __wsum csum_and_copy_from_user(const void __user=20=20
>=20*src, void *dst,
>  	}
>
>  out:
> +	lock_user_access();
>  	return (__force __wsum)csum;
>  }
>  EXPORT_SYMBOL(csum_and_copy_from_user);
> @@ -69,6 +71,7 @@ __wsum csum_and_copy_to_user(const void *src, void=20=
=20
>=20__user *dst, int len,
>  {
>  	unsigned int csum;
>
> +	unlock_user_access();
>  	might_sleep();
>
>  	*err_ptr =3D 0;
> @@ -97,6 +100,7 @@ __wsum csum_and_copy_to_user(const void *src,=20=20
>=20void __user *dst, int len,
>  	}
>
>  out:
> +	lock_user_access();
>  	return (__force __wsum)csum;
>  }
>  EXPORT_SYMBOL(csum_and_copy_to_user);
> --
> 2.19.1


