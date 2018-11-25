Return-Path: <SRS0=BtxG=OE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161B5C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Nov 2018 21:59:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FA42084E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Nov 2018 21:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ixEWztnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FA42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4333qc15NyzDqmh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 08:59:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ixEWztnZ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4333b75jmlzDqnD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 08:48:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="ixEWztnZ"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 4333b70hjrz9s29;
 Mon, 26 Nov 2018 08:48:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1543182531;
 bh=yNgt1uTGUPx01kjElXb3WKyLeC3WP9EoSO7b7TsMn7I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ixEWztnZjATjCMoLhibaI1qjD+hxeek7byzSqpnKL6tFcoqFqXiJo76PJZOHamL8z
 e6+6pZaZ87/2GFRi8NLnzhoDEO1Vecv7TkAy3+C7fJqf4YSlcO35PqyZu/yNG6c+ZQ
 n5PRmKtwGEj5CsUUNb9HrPoL4bsBb/UCybScdqN5sCdaG/fPJ1tl2p6k+sriQ2eKj0
 q3BMVkMmPwAjegKYPCtFO4H+GT5JQK1OaPrqlUETLPzVT6iFcSKoBQ3rioi8yt0QU1
 /r4RXKEDFlXyXCFvgM/lV1EDMwWrHtYH2n8iY5TRSO6hXN987LCcXSJmCXn9NcqORO
 Fomw0kteU8VZQ==
Date: Mon, 26 Nov 2018 08:48:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@google.com>
Subject: Re: New linux-next KCFLAGS
Message-ID: <20181126084841.13679afd@canb.auug.org.au>
In-Reply-To: <CAGXu5jL9WDRVCzPP0V2cvFHWfwAfd74kBNX9O+0frFkD26ti1Q@mail.gmail.com>
References: <CAGXu5jL9WDRVCzPP0V2cvFHWfwAfd74kBNX9O+0frFkD26ti1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8NMYZvBrW3QGjCNjSx64S1o"; protocol="application/pgp-signature"
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
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/8NMYZvBrW3QGjCNjSx64S1o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Fri, 26 Oct 2018 01:34:33 +0100 Kees Cook <keescook@google.com> wrote:
>
> So, if you it's possible to "seed" some new flags for linux-next, I'd
> be interested in making sure no new instances of warnings from
> -Wimplicit-fallthrough (gcc 7.1 and later) appear. VLAs will be gone
> in a couple days, so I'm currently only interested in killing implicit
> fallthroughs[1] now. There are hundreds of cases remaining, so ignore
> those on the first build, but anything NEW is what I'd like to get
> maintainer nags sent for (CCing myself and Gustavo Silva would be
> especially nice, too).

I don't know Gustavo's email address ...

> Thanks!
>=20
> [1] Gustavo has fixed lots of actual bugs as part of this work:
>      https://lkml.kernel.org/r/1f64449a-ef19-20c8-f8cb-7e629f8fe71b@embed=
dedor.com

I finally got around to this.  I have added the following patch to my
fixes tree (which is merged immediately after Linus' tree).

commit 4d8360ade996cf1823e570544791c9d7bd660ffb
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon Nov 26 07:58:34 2018 +1100

    Check for new cases of implict fallthrough
   =20
    for Kees
   =20
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

diff --git a/Makefile b/Makefile
index ddbf627cad8f..380164f590bc 100644
--- a/Makefile
+++ b/Makefile
@@ -804,6 +804,9 @@ KBUILD_CFLAGS +=3D -Wdeclaration-after-statement
 # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
 KBUILD_CFLAGS +=3D $(call cc-option,-Wvla)
=20
+# Check for implict fallthroughs
+KBUILD_CFLAGS +=3D $(call cc-option,-Wimplicit-fallthrough)
+
 # disable pointer signed / unsigned warnings in gcc 4.0
 KBUILD_CFLAGS +=3D -Wno-pointer-sign
=20

Unfortunately, some of the kernel is built with -Werror, so I have had
to add the following patch as well just to build Linus' tree:

(I just marked them as "fall through", I am not sure if that is the
correct resolution.)

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 26 Nov 2018 08:32:39 +1100
Subject: [PATCH] powerpc: tag implicit fall throughs

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/nvram_64.c            | 1 +
 arch/powerpc/platforms/powermac/feature.c | 1 +
 arch/powerpc/xmon/xmon.c                  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 22e9d281324d..06e2eda2430e 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -809,6 +809,7 @@ static long dev_nvram_ioctl(struct file *file, unsigned=
 int cmd,
 #ifdef CONFIG_PPC_PMAC
 	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
 		printk(KERN_WARNING "nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n=
");
+		/* fall through */
 	case IOC_NVRAM_GET_OFFSET: {
 		int part, offset;
=20
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platf=
orms/powermac/feature.c
index ed2f54b3f173..a7ec06876b53 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1471,6 +1471,7 @@ static long g5_i2s_enable(struct device_node *node, l=
ong param, long value)
 	case 2:
 		if (macio->type =3D=3D macio_shasta)
 			break;
+		/* fall through */
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 36b8dc47a3c3..308326f8b7ed 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -4033,6 +4033,7 @@ static int do_spu_cmd(void)
 		subcmd =3D inchar();
 		if (isxdigit(subcmd) || subcmd =3D=3D '\n')
 			termch =3D subcmd;
+		/* fall through */
 	case 'f':
 		scanhex(&num);
 		if (num >=3D XMON_NUM_SPUS || !spu_info[num].spu) {
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/8NMYZvBrW3QGjCNjSx64S1o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7GLkACgkQAVBC80lX
0GwEsgf+IxpcfoHy0CKXspRD9/aoPut4W8qsqHD3QLRX334/IiW6ah2UMjwez0Gu
2Ez/qSd/vqpc5U34U/ehX81cQSQci/w+w3VW8djhiaup9t5HLNRyiYw4rQ9T5+6i
o9vzptrfptZeDherrsHARU5TZ8dh+2nda1JxhYxY0Pg6tuzKaU6i+zTBmP1Ztki8
W6x83Gd6pw7LDcxA/4qAzTtLaJ0cb0tH674rVwjWlPXua2qRSqJlE/Mj5q6v7+eH
kJVqga94WGYCemrleLT1F/m0DEr/eYxBk9RukPK3XqgHmxsuvBYyWzbUACyC8AcB
XKaTTlvOYHKPC6VJdfbgDaqUFcYRnw==
=s/tl
-----END PGP SIGNATURE-----

--Sig_/8NMYZvBrW3QGjCNjSx64S1o--
