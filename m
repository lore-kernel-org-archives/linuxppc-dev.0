Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EFBC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 14:35:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A0A21B22
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 14:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0Ros9oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A0A21B22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MShM3C2nzDqcm
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 01:35:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I0Ros9oh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="I0Ros9oh"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MSdh1vY8zDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Dec 2018 01:32:55 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id y139so7729353wmc.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 06:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KedZckOY+dI25grJowxApG15n020/Su510hLf0aABzw=;
 b=I0Ros9ohY2Cvp8V6ONpEoXjiKhekbXZRt0VXUmPoNouWkNtGuG2K2BpsO2ftQrxVY2
 +juSJWFU5+k6AmKp1dbD5ccfOdYyLLaGbOCScITZOqXmUtnEi37MxLjowDJo6uHE63L1
 WZvLZawcxH87KoRKux2b8qu5x4zSBpGc8lLap0B9XNIV9LUaOV9UUjAHOWp/66o6drGD
 cfuCthXQXgz35/rA1Y5xwjP9/EfAUzsFM1F+chWPtVETKFl5If5UWk6zaJy5hdKV69bY
 BGZl/M7l7PhIKvxxHBfZ8QdPguH7jBvkgvbrd0y0B1zIKLjq/QbT2MBt53YK15pdEj1R
 KBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KedZckOY+dI25grJowxApG15n020/Su510hLf0aABzw=;
 b=JIVF7o7aTtywurjnj0v5inyrhNl6DsrcLnabiIbpytUhXvMO3ZXwI//ntDwVM+cvv6
 mp130CC7tBckOTcPLLx7ZQsQIUsO4j5WDn8Afi3aix9wCNftm3yrJ52a3dz0L8lCuptA
 SDjLjjORTnx1XuxGq2bsXyq/Hgfp/hu7btuM9+bWF/Rc+k+Nm0VafLTxzss7izSPynDb
 XQHIjJZl36MvB6LzOobdIKWFLCZ1auz7mm7MhppB5zpEa2vuppBDTx4jVlCvKN2r2LlO
 c6XYa9vgNVvoQi7KT3PR5gvlq+/crIhMYpU5m6V2SC6VP607kNLqNZCl1oWlBdsYYnvP
 XOnA==
X-Gm-Message-State: AJcUukf5qVa2ntD53foFB7loIx655cNNWTu1C5ja39Nhf4zy/Wi1+TDq
 NUImE66j3JFsC0U6n7FWm/E=
X-Google-Smtp-Source: AFSGD/VCVvuCTzMA63XZq8MP3MuRI2LG7NbLE89Pm+sLFQe1rr9EPemEXCGYbcNeGZxhnkI2QuvYkg==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr4512326wmj.127.1545489172597; 
 Sat, 22 Dec 2018 06:32:52 -0800 (PST)
Received: from debian64.daheim (p4FD094B4.dip0.t-ipconnect.de.
 [79.208.148.180])
 by smtp.gmail.com with ESMTPSA id l20sm31348256wrb.93.2018.12.22.06.32.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 22 Dec 2018 06:32:51 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
 by debian64.daheim with esmtp (Exim 4.91)
 (envelope-from <chunkeey@gmail.com>)
 id 1gaiKf-0005Zi-Oo; Sat, 22 Dec 2018 15:32:49 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/4xx/ocm: fix compiler error
Date: Sat, 22 Dec 2018 15:32:49 +0100
Message-ID: <10812488.F0pUFFIo3t@debian64>
In-Reply-To: <06576f55-e31f-2554-255d-d10f8576c7ab@c-s.fr>
References: <20181222100934.8051-1-chunkeey@gmail.com>
 <2160350.91F9KbYz58@debian64> <06576f55-e31f-2554-255d-d10f8576c7ab@c-s.fr>
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

On Saturday, December 22, 2018 2:08:02 PM CET christophe leroy wrote:
>=20
> Le 22/12/2018 =C3=A0 12:27, Christian Lamparter a =C3=A9crit :
> > On Saturday, December 22, 2018 11:59:04 AM CET christophe leroy wrote:
> >>
> >> Le 22/12/2018 =C3=A0 11:09, Christian Lamparter a =C3=A9crit :
> >>> This patch fixes a recent regression in ocm:
> >>>
> >>> ocm.c: In function =E2=80=98ocm_init_node=E2=80=99:
> >>> ocm.c:182:18: error: invalid operands to binary |
> >>> ocm.c:197:17: error: invalid operands to binary |
> >>>
> >>> Fixes: 56f3c1413f5c ("powerpc/mm: properly set PAGE_KERNEL flags in i=
oremap()")
> >>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> >>
> >> What's the problem here ? Is PAGE_KERNEL_NCG undefined ? If that's the
> >> case, wouldn't it be better for fix that by including asm/pgtable.h ?
> >=20
> > PAGE_KERNEL[_NCG] type is a struct of pgprot_t, whereas _PAGE_EXEC is
> > considered an int.
>=20
> Oops, I missed that.
>=20
> Could you put the entire error message in the commit log ?
Will do in v2... which I'm going to sent out shortly. I mainly wanted to
make the most "trivial fix" since it probably needs to be backported to
4.20-stable at this late in the rc phase.

> >=20
> > arch/powerpc/platforms/4xx/ocm.c: In function =E2=80=98ocm_init_node=E2=
=80=99:
> > arch/powerpc/platforms/4xx/ocm.c:182:18: error: invalid operands to bin=
ary | (have =E2=80=98int=E2=80=99 and =E2=80=98pgprot_t=E2=80=99 {aka =E2=
=80=98struct <anonymous>=E2=80=99})
> >         _PAGE_EXEC | PAGE_KERNEL_NCG);
>=20
> Usually, Guarded implies no exec (at least on 6xx and 8xx). Does the 4xx=
=20
> accept guarded exec ?

Oh, I simply copied over the individual _PAGE_* flags that the PAGE_KERNEL_=
NCG
macro set. The OCM is usually a small (32 KiB) DMA descriptor storage, I do=
n't
think anyone would want to execute code in there.

>=20
> >                    ^
> > arch/powerpc/platforms/4xx/ocm.c:197:17: error: invalid operands to bin=
ary | (have =E2=80=98int=E2=80=99 and =E2=80=98pgprot_t=E2=80=99 {aka =E2=
=80=98struct <anonymous>=E2=80=99})
> >         _PAGE_EXEC | PAGE_KERNEL);
>=20
> That's PAGE_KERNEL_X
>=20
> >                    ^
> >=20
> > I think pgprot_val(PAGE_KERNEL[_NCG]) could be an option too.
>=20
> Yes I may have a preference for that.

K, I liked having all _PAGE_*. But I'm fine either way.=20
see you for v2. :-D=20
> >=20
> > Christian
> >>> ---
> >>>    arch/powerpc/platforms/4xx/ocm.c | 6 ++++--
> >>>    1 file changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platform=
s/4xx/ocm.c
> >>> index 561b09de69bf..04ff69ddac09 100644
> >>> --- a/arch/powerpc/platforms/4xx/ocm.c
> >>> +++ b/arch/powerpc/platforms/4xx/ocm.c
> >>> @@ -179,7 +179,8 @@ static void __init ocm_init_node(int count, struc=
t device_node *node)
> >>>    	/* ioremap the non-cached region */
> >>>    	if (ocm->nc.memtotal) {
> >>>    		ocm->nc.virt =3D __ioremap(ocm->nc.phys, ocm->nc.memtotal,
> >>> -					 _PAGE_EXEC | PAGE_KERNEL_NCG);
> >>> +			_PAGE_EXEC | _PAGE_BASE_NC |
> >>> +			_PAGE_KERNEL_RW | _PAGE_NO_CACHE | _PAGE_GUARDED);
>=20
> Could be _PAGE_BASE_NC | _PAGE_KERNEL_RWX | _PAGE_NO_CACHE | _PAGE_GUARDED
>=20
> Or pgprot_val(PAGE_KERNEL_NCG) | _PAGE_EXEC
>=20
> Or pgprot_val(pgprot_noncached(PAGE_KERNEL_RWX)) (that's my preference)
>=20
> >>>   =20
> >>>    		if (!ocm->nc.virt) {
> >>>    			printk(KERN_ERR
> >>> @@ -194,7 +195,8 @@ static void __init ocm_init_node(int count, struc=
t device_node *node)
> >>>   =20
> >>>    	if (ocm->c.memtotal) {
> >>>    		ocm->c.virt =3D __ioremap(ocm->c.phys, ocm->c.memtotal,
> >>> -					_PAGE_EXEC | PAGE_KERNEL);
> >>> +					_PAGE_EXEC | _PAGE_BASE |
> >>> +					_PAGE_KERNEL_RW);
>=20
> What about _PAGE_BASE | _PAGE_KERNEL_RWX instead ?
>=20
> Or pgprot_val(PAGE_KERNEL_RWX) (that's my preference)

I'll test if any of these make a difference and sent a separate patch.

Christian


