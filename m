Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D38C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 20:44:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BD22145D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 20:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Krg6BOaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BD22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZS3G5FXKzF3Nd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Krg6BOaW";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZS0P6l4jzF3Fm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 07:41:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="Krg6BOaW"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42ZS0N5lcXz9sCW;
 Wed, 17 Oct 2018 07:41:56 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1539722517;
 bh=g9HCIoAOTTUZcKSB4RMXCijCR4QTPLIl6zKivyuQ5EU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Krg6BOaWGqxDAtyZSY1tgySEsR1OhcAACed8YkzKdFFYYXfCBXJ6EDCnd386gt7wj
 YEye7aVWjbGu22jErBuSMZJfTWELf7VSyxUkONbL0lUi1WJtdwYPfofVkFIf/tNnQi
 Sb6Y3SaHMD7dPdsfP8GLMdFmni8rIlRwI3NOKmKwAK9e/6e7JIb7zQr5DrCwXJtvkA
 AsrNzS9TMQ+GURamtb1jDy0xIBPfl119RE1smEr6GWmbjKoFZTvu11BZXdL2Muajub
 O8T8UyoCISJfkf2ebl2wPP7jVVPpqcBjuZ4+mWbDZM0osKevabV9pGxYaAfCgMuMhS
 n5D9sLQTF6lSw==
Date: Wed, 17 Oct 2018 07:41:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181017074149.4372a1a0@canb.auug.org.au>
In-Reply-To: <20181016133656.GA10925@rapoport-lnx>
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
 <20181016072439.42613abd@canb.auug.org.au>
 <20181015151319.3a443f0421c20bd7ed055cb9@linux-foundation.org>
 <20181016133656.GA10925@rapoport-lnx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pb3eVjDhw/.Jnl_hv2MTcRM"; protocol="application/pgp-signature"
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
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/pb3eVjDhw/.Jnl_hv2MTcRM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, 16 Oct 2018 16:36:56 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> After some more grepping and spatching I've found these:
>=20
> From 8b014bae53a78ab747dbb76b9aff7df4cefcb604 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Tue, 16 Oct 2018 16:03:00 +0300
> Subject: [PATCH] memblock: fix missed uses of implicit aligment
>=20
> A couple of memblock*alloc uses were missed during conversion from implic=
it
> alignment setting with 'align =3D 0' to explictly using SMP_CACHE_BYTES.
> Fix them now.
>=20
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks.

I have added that to linux-next today as it should get rid of the stack
trace we are seeing in PowerPC boots.

--=20
Cheers,
Stephen Rothwell

--Sig_/pb3eVjDhw/.Jnl_hv2MTcRM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvGTQ0ACgkQAVBC80lX
0Gx71Qf+IGsZZmjIgk71d2ZkyIq2CE16ktyU4y8Z0t53j9oiVAtehFGc8uFztX1E
zXnhMX/f5FALESg+78Gzcy95CMrUPIZ44c9/sb+6hE0s4nYd5piERjMXMH5hB8gS
YiUm6B4SSiSk3Px1c0JNtY+1C+UwZIV9i+Ur9Snrb7vePlBEbQYj28rOBNN6mBOP
ofshJmbh/Yx5Bnad5iPet+vOYsHu9a78HP27LEJWZPcFYePXvhnEN5P5SWf84TvT
pE4cCByvjInZfTWkBzQwJqeihAI4LA7+Rts1w1qWc+PFP+CxrzaiDnRtesLZwnvJ
fasRUAMaep6nMStMx5nD+f2tAJYMQA==
=BIOR
-----END PGP SIGNATURE-----

--Sig_/pb3eVjDhw/.Jnl_hv2MTcRM--
