Return-Path: <SRS0=BtxG=OE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9082FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 00:58:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B634C61056
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 00:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B634C61056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7lNK19qbz2ywr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 10:58:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=lnNSLp21;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=canb.auug.org.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=sfr@canb.auug.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=lnNSLp21; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7lMb1L51z2y8S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Sep 2021 10:58:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
 s=201702; t=1631581096;
 bh=4bBuIPMdmELoKylP2iX669QdoWBwKrAGFrRPz3WvvPE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lnNSLp21rLaW0GmVIciJrY+OzGGH1asjn1nsX1tLQ7ky7e0ZjgjW0zNIXfW7IVOiK
 idCAvOP9iKLI0lVpEcSADgemxzPRnCETkk6VwYMFj0zRVSf1N5iiHjMyYcoQGkfafk
 N+r0o53H6WdcaAzHwerH0JGtllQ6zKBjZgScyZwn+mNugDwAOfiYN97HYHk7rfh+OZ
 3wY4VHwyJyTdVweNxGhHua0T6ScLGQXsabafbk0il5j7ryU06sI0V9HCH8WVmI0L4L
 KcBqMf+GF043kcmBGnWxAZJNSF0DmnMo/Mu4ZiKtzqrCkSF52ZvYp1nLrcxnKxrYQC
 zifa6UxR+1UQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4H7lMX1Qk7z9t0T;
 Tue, 14 Sep 2021 10:58:16 +1000 (AEST)
Date: Tue, 14 Sep 2021 10:58:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: build failure after merge of the origin tree
Message-ID: <20210914105359.5c651d55@canb.auug.org.au>
In-Reply-To: <CAHk-=whGuEkYmQcJx8WfZ7MFhbKGJDcA6NUZWtrnM6Y6xFqATw@mail.gmail.com>
References: <20210914100853.3f502bc9@canb.auug.org.au>
 <CAHk-=whOv-LZKxBqQr8yzmhi7sN4zoFG7t8ALNx+2XFhXjGTpA@mail.gmail.com>
 <CAHk-=whGuEkYmQcJx8WfZ7MFhbKGJDcA6NUZWtrnM6Y6xFqATw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UTHTjl21XVSe=CpidRPfhNW";
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

--Sig_/UTHTjl21XVSe=CpidRPfhNW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, 13 Sep 2021 17:24:11 -0700 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> On Mon, Sep 13, 2021 at 5:19 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > What version of gcc is this? Are you maybe on gcc-4.9 and we just
> > didn't check that properly? =20
>=20
> Hmm. That version check works for me (tested by just arbitrarily
> making min-tool-version return version 15 for gcc ;)
>=20
> So you got far enough that I don't believe you have gcc-4.

$ gcc --version
gcc (Debian 10.2.1-6) 10.2.1 20210110
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

> I have no idea why it then complains about removal of the GCC4 macros.

Me neither :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/UTHTjl21XVSe=CpidRPfhNW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmE/86cACgkQAVBC80lX
0Gx4lggAkRjo+wZPYMVZ8m6LU0Oh5xuknc9Hl+j/VClUpARA9WHSwiyIdBjK2Ncm
Cd9stopA4xLjDrF1PU+19NIImKpJbJjH6AJ6QrjWlhK1x24AQbWwE5bEDMJ5rNAO
MLLAXXexFZQbuiLRtx4bFwsGisYLnDtdmKAK/XBw5WKxy/yM4j26cDUHLB8lVvJq
MzGrwguzcKKtbE3Fa8H0eIvG++0I3UA2JG50YrK/Jq/ejdH46+a+Hn3xTYMxXm/e
ASHKEjr56GtKYYURtvc8Z/zKIuLpqs08tZDyXVEtLkG8AD/k+zn822O/YboTKNaL
LVIBPcRg+KGYMRW0iUz4Yo4+Z7/elQ==
=oysf
-----END PGP SIGNATURE-----

--Sig_/UTHTjl21XVSe=CpidRPfhNW--
