Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4991CC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:29:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8B921A4D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqai+KGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8B921A4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MNZT2gDtzDqPX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 22:29:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rqai+KGp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rqai+KGp"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MNWm47hvzDqML
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 22:27:32 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id l9so7636404wrt.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 03:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MDT8ITZ4RyrGlPJixj9dn7LmnQheLcwSaPAHnkSmB9c=;
 b=rqai+KGp9cXkd1SRTnv0fGgbZ0KrC3/8fK73NysBFU+Chyomrr2ugPlyvfkQ/rYK/z
 SPPCvugrQSZuce3O7xm1cWQf/6FP3tR5YtZDFmVitC6k0zOCFobXxuoeEjWq9SCGMjX+
 iO0kGs2IhqpCHjqf/k2rpFdW4PFA/CcDEND7s7Nkisaq2EnrbO7qizIZv+28Yf4eIyQm
 r+LVp9soFsKdECkGJKz7ZHing8l3/NjtFjiuNqnwlfOedvzVwLCeVRz4tJtwB1dO+rNl
 r7IzuH0y/16b5GOZxmMrO97cSftlpCLYbHmMHbXXm6ux2s8O2G0bKuwWLJp4ELx8Yont
 NgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MDT8ITZ4RyrGlPJixj9dn7LmnQheLcwSaPAHnkSmB9c=;
 b=GGxpAuXV7GtjsC0wjKVkKYidN4JhddbWcPyBlaJ/+5wvJHkkSSIXA11yXEqJKEQn7o
 B/tDD1bzFm9wKiVeCmL4bhs0JsHiBhEDlQ2I9dlVRbIvA74VT33PsrhpwUJhb+M1ayP+
 AFF/RDrb7H5K+DTW94n3+R9imihKtQdGamdlQrFqEZMfSek+YFL39RE/uPi6D/Kd9i41
 39ZgCP7O/JhERUJiOJfeCwe55ISV5u+M3fJyxv4zneaFA7z0f0KY1t31+P8RPfwROWvz
 pwt4Vyqgm4YyvfESnM7eGKaSU8BgBkpuvu3Cf06I8sANUZFsfUu0TugHXroz75UeIREg
 ealw==
X-Gm-Message-State: AJcUukd0MHxw4f7ihVFa03PAtD0Q/NYuO3TSc8pN9SmKo8728PLV52Vy
 p0CuKORZu9Zxgz7jjYewvOg=
X-Google-Smtp-Source: ALg8bN5TiNrpM0tpFYM0MyBIcnJS26tGzAf8F6jdgi++vkkHiK/GGu0wnu2YF4KwuakTT7qKSJLA+Q==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr6321411wrt.241.1545478049249; 
 Sat, 22 Dec 2018 03:27:29 -0800 (PST)
Received: from debian64.daheim (p4FD094B4.dip0.t-ipconnect.de.
 [79.208.148.180])
 by smtp.gmail.com with ESMTPSA id o4sm15215171wrq.66.2018.12.22.03.27.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 22 Dec 2018 03:27:28 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
 by debian64.daheim with esmtp (Exim 4.91)
 (envelope-from <chunkeey@gmail.com>)
 id 1gafRH-0002iH-R2; Sat, 22 Dec 2018 12:27:27 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/4xx/ocm: fix compiler error
Date: Sat, 22 Dec 2018 12:27:27 +0100
Message-ID: <2160350.91F9KbYz58@debian64>
In-Reply-To: <abadbc68-c612-94c3-3248-dc6b55cf6822@c-s.fr>
References: <20181222100934.8051-1-chunkeey@gmail.com>
 <abadbc68-c612-94c3-3248-dc6b55cf6822@c-s.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev@lists.ozlabs.org,
 Markus Elfring <elfring@users.sourceforge.net>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Saturday, December 22, 2018 11:59:04 AM CET christophe leroy wrote:
>=20
> Le 22/12/2018 =C3=A0 11:09, Christian Lamparter a =C3=A9crit :
> > This patch fixes a recent regression in ocm:
> >=20
> > ocm.c: In function =E2=80=98ocm_init_node=E2=80=99:
> > ocm.c:182:18: error: invalid operands to binary |
> > ocm.c:197:17: error: invalid operands to binary |
> >=20
> > Fixes: 56f3c1413f5c ("powerpc/mm: properly set PAGE_KERNEL flags in ior=
emap()")
> > Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>=20
> What's the problem here ? Is PAGE_KERNEL_NCG undefined ? If that's the=20
> case, wouldn't it be better for fix that by including asm/pgtable.h ?

PAGE_KERNEL[_NCG] type is a struct of pgprot_t, whereas _PAGE_EXEC is
considered an int.

arch/powerpc/platforms/4xx/ocm.c: In function =E2=80=98ocm_init_node=E2=80=
=99:
arch/powerpc/platforms/4xx/ocm.c:182:18: error: invalid operands to binary =
| (have =E2=80=98int=E2=80=99 and =E2=80=98pgprot_t=E2=80=99 {aka =E2=80=98=
struct <anonymous>=E2=80=99})
       _PAGE_EXEC | PAGE_KERNEL_NCG);
                  ^
arch/powerpc/platforms/4xx/ocm.c:197:17: error: invalid operands to binary =
| (have =E2=80=98int=E2=80=99 and =E2=80=98pgprot_t=E2=80=99 {aka =E2=80=98=
struct <anonymous>=E2=80=99})
       _PAGE_EXEC | PAGE_KERNEL);
                  ^

I think pgprot_val(PAGE_KERNEL[_NCG]) could be an option too.

Christian
> > ---
> >   arch/powerpc/platforms/4xx/ocm.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/=
4xx/ocm.c
> > index 561b09de69bf..04ff69ddac09 100644
> > --- a/arch/powerpc/platforms/4xx/ocm.c
> > +++ b/arch/powerpc/platforms/4xx/ocm.c
> > @@ -179,7 +179,8 @@ static void __init ocm_init_node(int count, struct =
device_node *node)
> >   	/* ioremap the non-cached region */
> >   	if (ocm->nc.memtotal) {
> >   		ocm->nc.virt =3D __ioremap(ocm->nc.phys, ocm->nc.memtotal,
> > -					 _PAGE_EXEC | PAGE_KERNEL_NCG);
> > +			_PAGE_EXEC | _PAGE_BASE_NC |
> > +			_PAGE_KERNEL_RW | _PAGE_NO_CACHE | _PAGE_GUARDED);
> >  =20
> >   		if (!ocm->nc.virt) {
> >   			printk(KERN_ERR
> > @@ -194,7 +195,8 @@ static void __init ocm_init_node(int count, struct =
device_node *node)
> >  =20
> >   	if (ocm->c.memtotal) {
> >   		ocm->c.virt =3D __ioremap(ocm->c.phys, ocm->c.memtotal,
> > -					_PAGE_EXEC | PAGE_KERNEL);
> > +					_PAGE_EXEC | _PAGE_BASE |
> > +					_PAGE_KERNEL_RW);
> >  =20
> >   		if (!ocm->c.virt) {
> >   			printk(KERN_ERR
> >=20
>=20




