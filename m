Return-Path: <SRS0=qW4V=JL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B561C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Apr 2021 06:45:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A5A61222
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Apr 2021 06:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A5A61222
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FKtKC2q6Fz30Ff
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Apr 2021 16:45:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=nviLuOh6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=canb.auug.org.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=sfr@canb.auug.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=nviLuOh6; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FKtJk2rp9z304F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2021 16:45:24 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FKtJY5rm7z9sVb;
 Wed, 14 Apr 2021 16:45:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1618382721;
 bh=/jodwSXgSQIoA9PKAVNuVIZztq5p2I1zYdAcnFOt/QI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nviLuOh6vv6t0otwNWX8zUg4K7TpYLIfF2mKXNz4miCmYGBKYPii8JbbMGE50K389
 /7gLpYYMyg8jf0tZMsL4WFsIoWGRC+VevBVJ7FoFLE9BeL9xdYWjBWs1jxxkf5wB9U
 BdD2uV49k4hNwvFJ8ckGLENvxVWo34hc9mhVkNTtvkyCnDIE2hcoqGNJ3Z1CpQHuFR
 WkIWVSg+uhV3LzZL47CHSmq/bnSPHp3RnaSFyarITSDS6Iey9YXTCG9e9F1PY5tY61
 xiBKcf/NoOetBTlhz5BzDAFqr0YjKsYU6bE43A7pK++5PbMej109F3sMRxyE9m/ybS
 Mv0hOdc6mGxFQ==
Date: Wed, 14 Apr 2021 16:45:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] uapi: remove the unused HAVE_ARCH_STRUCT_FLOCK64
 define
Message-ID: <20210414164515.7358054a@canb.auug.org.au>
In-Reply-To: <CAK8P3a2MSJarPMfJ8RrSKDMXte3KQec=+GQ-LzV6HB7-Nm1FcQ@mail.gmail.com>
References: <20210412085545.2595431-1-hch@lst.de>
 <20210412085545.2595431-2-hch@lst.de>
 <CAK8P3a2MSJarPMfJ8RrSKDMXte3KQec=+GQ-LzV6HB7-Nm1FcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OE1o8UymrAeVhdVEl6xjBsl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Parisc List <linux-parisc@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Helge Deller <deller@gmx.de>, the
 arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Heiko Carstens <hca@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/OE1o8UymrAeVhdVEl6xjBsl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, 12 Apr 2021 11:55:41 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 12, 2021 at 10:55 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de> =20
>=20
> The patch looks good, but I'd like to see a description for each one.
> How about:
>=20
> | The check was added when Stephen Rothwell created the file, but
> | no architecture ever defined it.

Actually it was used by the xtensa architecture until Dec, 2006.

--=20
Cheers,
Stephen Rothwell

--Sig_/OE1o8UymrAeVhdVEl6xjBsl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmB2j3sACgkQAVBC80lX
0Gx4pggAkNW0y0/RLSwNvx8cwugIMwm76PePVHws/DSpK21w82ztk8XPzmrlHYlo
MP4xnpeval236Udlgam+Jc+7defed018uxwQyX1zKt+a0seZO9HrNSBZk8FwT1ck
rq+/vwVxpRmpXxh4wrHNZ9kEEB8siALYt1IhhjOMuPDEFZQhhRv+1GM11ZEb4TNm
QXiVEOPdln45S2tKu+icyaVERYFY/6j5minprLhTWeY7Rg/+eoZwC6KtkvXpRqfl
WsUS0axrNP124+5bOizsZyTaCeeLFwTQR18nvDu703iKPre8y4K3CEiM3YQddALr
8OeaCYAcDp1LKDXR1UZZmal4VJxxdg==
=76mG
-----END PGP SIGNATURE-----

--Sig_/OE1o8UymrAeVhdVEl6xjBsl--
