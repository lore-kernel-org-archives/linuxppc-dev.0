Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A4C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 22:29:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC6220836
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 22:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SCE35DjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC6220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4458Kl5smPzDqMs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:29:47 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4458Hd29ZLzDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 09:27:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="SCE35DjS"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 4458Hd05Pbz9s8m;
 Fri, 22 Feb 2019 09:27:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1550788077;
 bh=BwxWgQboLjV5OYmx2QFJypOm12VHnn4vyzoPFS3il7k=;
 h=Date:From:To:Cc:Subject:From;
 b=SCE35DjSp0aQlontuJf2DVRTYFBXpLZC1QjJdR6Z8W/nMsdXa2C94dARu6s6qcptc
 953xfiDrydkgmnS2fKQobL+R05Hga3HRJqspzyR9O/rRezjmYUSlg5vUFFlxUAGRLu
 WNYXUQf3yoR1YIUvv8L7CxHuRHF8Ct1wVqsqNABg8qHK/rk5dO+mTsC8+DM8tdTtSU
 6mhknrtegfgZ+1+20cs8Zx9jfw64jl8j/oiRO4YmEJeBQU8YdAIPQY1LFT+0gb2fJa
 TeXs+YgIBRaE7087e1bahwctRMKBO6x7YeXJlIGoT7ojwViEWgEAwPTqxHmST3ROnB
 zZb4IalxmVYKQ==
Date: Fri, 22 Feb 2019 09:27:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the powerpc tree with the dma-mapping tree
Message-ID: <20190222092756.242ea484@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xSTNhqAJGIWR29=5si.DuMS"; protocol="application/pgp-signature"
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/xSTNhqAJGIWR29=5si.DuMS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/kernel/dma.c

between commit:

  cfced786969c ("dma-mapping: remove the default map_resource implementatio=
n")

from the dma-mapping tree and commit:

  68005b67d15a ("powerpc/dma: use the generic direct mapping bypass")

from the powerpc tree.

I fixed it up (the latter removed the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/xSTNhqAJGIWR29=5si.DuMS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvJewACgkQAVBC80lX
0GxbmQf+NAs/oRsBxAr/Ipe9K32wdO4LWuYjEznzPv53Q8YaK5LpmSFM2xqcQGFX
8b1/POspGA5KmE4Ua8gNILZmF/h61Lu58nusKMdEg1ju7JwDUjCVcBDOcp0GHGbs
K6u2z7oLeUH4f/g6cVThWziMoKu/8FQOG/weCUbRDZtUpex0Vndt9niCc+59U/ZV
kUEernFXFCalXFFTBC+tayDLsh/819/Vq0jEcfZ81vPz7ObWC1Utw+6zerctw8hd
T6N9demZeNtV3SAN+ecnDxx3VmQOWZ/a3x97md86T/CDCGt0BK7hEfoQzwZHsa+f
b6UDZ33hX5Icsn9SAiAe5eew62doHg==
=d8NK
-----END PGP SIGNATURE-----

--Sig_/xSTNhqAJGIWR29=5si.DuMS--
