Return-Path: <SRS0=PW3U=LW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B2BC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 09:56:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8427B61C5B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 09:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8427B61C5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GD3135BYmz3bf6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 19:56:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=EmkkJGQl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=canb.auug.org.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=sfr@canb.auug.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=EmkkJGQl; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GD30c523sz309Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jun 2021 19:56:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GD30S1CY7z9sT6;
 Mon, 28 Jun 2021 19:56:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1624874185;
 bh=DZNIfQVrWlttYmCGu5ye7TC2D4EmqHr4nUgO5sXzjgk=;
 h=Date:From:To:Cc:Subject:From;
 b=EmkkJGQl34vveOjjKzzYJgX5nZD5E15svrS++il3/H0V3u+twTf7UeWqTkFMzBIH7
 RYYC7tfJPOGgl+9mt6iCNkk8zcqFB34jWu5frapNsgV21bMCfNp4LZFzbmsPxaGOnj
 3bYB7DHlVmttqQ7pvmP/+pxzbxXK2TlerGeNSHAi6wKg17GufrYXG3nrbObJCbyMzq
 BYumoyNVNTXyaJqNLAXVLuFgzfD5Ounld7DWtGigEvmKfJGxCPQKYTY5REO0AjD6uP
 apMU+pLL42KvX683JYxaZVs+oyXg3W41XifaAsuF9B/znMIqYQWujO63j6GiEqI0TP
 CXlqnJwmsNYmg==
Date: Mon, 28 Jun 2021 19:56:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the akpm tree with the powerpc tree
Message-ID: <20210628195621.05913135@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kXpS+cmPI/L.YfNVhvGYYgt";
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/kXpS+cmPI/L.YfNVhvGYYgt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/powerpc/kernel/setup-common.c

between commit:

  56afad885228 ("powerpc: Remove klimit")

from the powerpc tree and commit:

  6e6e0df2a484 ("powerpc: convert to setup_initial_init_mm()")

from the akpm tree.

I fixed it up (I just used the latter since it had also decided to use
_end directly) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/kXpS+cmPI/L.YfNVhvGYYgt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmDZnMUACgkQAVBC80lX
0GzotwgAjN0ousRTuOOhlqsVHvuzF8YYXVwitj4vN9tnoCKkARvV09Plv4Bk1+Lg
0ruFkGISlkHDSWTArOxNGLMabbQcQCSeS7hYke549ubyB+t+kQ5m+XQtcKYqeR8U
Wxz9J52BVczf8aqzjYzffFRn3Io9+JHsfT/J34HGuAgrcay1oyiE+Ohgv49L+qzC
bQ0BYpJnL5N0+luT9UJFxn+MhHJ5O9WfSwl/STeHuadhxE0RF04oCQWlLv1y0XFR
IEKr0XkBaku7AYTvwhQ7a0nyVW/z4vSrN0SrmdcKBaEMYypQ90YV/ARoHW41L4Y9
wEvsUYcoAmnqZd/gltnMZgfX2wmbeg==
=seFv
-----END PGP SIGNATURE-----

--Sig_/kXpS+cmPI/L.YfNVhvGYYgt--
