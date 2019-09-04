Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B942EC3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 13:14:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD1022CF7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 13:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ctJf2UJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD1022CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Nkmr1cMSzDqZ1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 23:14:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NjsT5gp5zDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 22:33:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="ctJf2UJZ"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46NjsS1WsDz9s3Z;
 Wed,  4 Sep 2019 22:33:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1567600396;
 bh=a/mNy3vFL2sGvNnyv4QB+peLbEbQk2/RU44v9YYnnYw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ctJf2UJZai/Q/BMgL6XG64zvmVlzWFPybkAQbPJj7zWSi+CFtJyV5Ws9E71uPNjE0
 V+pwCmSejvbk/8ncAS2hpcjpO36PavmyB0CHsiRXgWJrZmjGLWRcl+K9cDwR97A+6p
 EfeKgdZ2GMKtOlzQ+VGxpdmZtkpqQa/cfKoik8HyI3ML20nkqUnrhmOuhFkE2DfYcy
 D2SJgCHeXgmfzOWtoxsBaQP2DlCFHP4/dONI6hLI+DO3bEVZsiAmzrYmK/+T2AO9wb
 srBVpS7tscndl2G6dRCAnfPAlG24vXhOyNJjeN/c8U+5cr0mJzZxyDRkec2brcPAzj
 /x5M6i41BKY5w==
Date: Wed, 4 Sep 2019 22:33:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: linux-next: build warnings after merge of the kbuild tree
Message-ID: <20190904223312.553a7660@canb.auug.org.au>
In-Reply-To: <CAK7LNAQ8VJz8fxecnEWmbFCpD0rgt4tjoipOX0g3oY0xU8xt5w@mail.gmail.com>
References: <20190904101259.2687cea4@canb.auug.org.au>
 <CAK7LNAT=qUi76cF776GcT=UYce5QBo+_24gLwXH7ra15=1xLvQ@mail.gmail.com>
 <CAK7LNAQ8VJz8fxecnEWmbFCpD0rgt4tjoipOX0g3oY0xU8xt5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uDkxajeQp+GefRpMSunwwHd";
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/uDkxajeQp+GefRpMSunwwHd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Wed, 4 Sep 2019 15:22:09 +0900 Masahiro Yamada <yamada.masahiro@socionex=
t.com> wrote:
>
> For today's linux-next, please squash the following too.
>=20
> (This is my fault, since scripts/mkuboot.sh is a bash script)
>=20
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 41c50f9461e5..2d72327417a9 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -374,7 +374,7 @@ UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
>  UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
>=20
>  quiet_cmd_uimage =3D UIMAGE  $@
> -      cmd_uimage =3D $(CONFIG_SHELL) $(MKIMAGE) -A $(UIMAGE_ARCH) -O lin=
ux \
> +      cmd_uimage =3D $(BASE) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
>                         -C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
>                         -T $(UIMAGE_TYPE) \
>                         -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \

Umm, that seems to have already been done.

--=20
Cheers,
Stephen Rothwell

--Sig_/uDkxajeQp+GefRpMSunwwHd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1vrwgACgkQAVBC80lX
0Gxn3wgAheU3D4MTpR5mBwg7WtQxEJ9dSVn+mwjS4jwsoXc2fOPWF1HlbNTFgCLx
ANh5n+G0IMBTWfkjIqrrvRafd/9+obXEQIFrouVF8c1sGUgSZno7x+fPKXDrPcDM
v7ruhgry00bPAHQpvvkDqEOXbpvjIPurfU5ElkwGQR1npb0099o4Ivf/xyfh268m
wnFAf3BRnxVY7ioK4rcDgB5hqmZIsmpHb9hzIlH2IYVYDjMXnKJMYS0YtABGfRbN
5Xf1YxeuGSIOiwaNKye8+Gx40f0qE2bIxExW7eklxvQPPuWoFUj7C3Ah5fRQ4Gfq
BUgpdoSoFyUggJRQJJTk8wLSdFA4jg==
=DYTL
-----END PGP SIGNATURE-----

--Sig_/uDkxajeQp+GefRpMSunwwHd--
