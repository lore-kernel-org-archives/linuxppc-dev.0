Return-Path: <SRS0=X2ql=PB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA34CC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 05:06:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2894B21736
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 05:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="u1WTlyuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2894B21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43NRz26950zDqSv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 16:06:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="u1WTlyuD";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43NRwG0CJlzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 16:03:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="u1WTlyuD"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43NRwF3Sl2z9sCr;
 Mon, 24 Dec 2018 16:03:56 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1545627837;
 bh=4XH7AJKXZIvu8VvJSX9IoXQuV6WkeoZRM6daq6oDEGc=;
 h=Date:From:To:Cc:Subject:From;
 b=u1WTlyuDhfajzlU6IVd8oiJNdzmPBxv8NLozj0ESedBa/9E7HkH0vMlJsSa67rL8w
 tJPLmCl40YqAyvgElS7GbThbjHdunlfisq+n5py2AChQFt0zWiuIsa3B29SLJCSqdc
 fgfZkgwY+PVViXFWen4JgrshZ7e/29o9J/skHiqLo09gMAvw7GbzCg4ufERemxxC+5
 HQ0HrC89ywPgMLo071wnRa1ZViZa+4aycI41f11zxFh3H7jBHuk3F5T3hIAG45ideD
 O+ITbksIllnutWrfHelEiD5GQbUWXCFXpXz5Br5qKEaVE28NP+iIv2kxqCafy6/so2
 /mpYTdpKYd9tQ==
Date: Mon, 24 Dec 2018 16:03:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joerg Roedel <joro@8bytes.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the iommu tree with the powerpc tree
Message-ID: <20181224160351.04a23901@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_/09.8j6P+ZIxSBW5akcE94"; protocol="application/pgp-signature"
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/_/09.8j6P+ZIxSBW5akcE94
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommu tree got a conflict in:

  arch/powerpc/kernel/iommu.c

between commit:

  c4e9d3c1e65a ("powerpc/powernv/pseries: Rework device adding to IOMMU gro=
ups")

from the powerpc tree and commit:

  bf8763d8f837 ("powerpc/iommu: Use device_iommu_mapped()")

from the iommu tree.

I fixed it up (I just used the powerpc tree version which removed the
code modified by the latter) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your
tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/_/09.8j6P+ZIxSBW5akcE94
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwgaLcACgkQAVBC80lX
0Gznegf/XgNzS4mNguePYLbRoG0Y96FOr3AYK8WKVvhjyUbF0B1WhA5gfwN8bU+7
XsHv5QD2Hu4zeB/48cY5r2k8t/q4P0NGcLm/s59zoTgAvJ3Dgdcr3QBEbyMfUepS
PzloWf0HrtsKLGCwNieg9Zz4+2ltSCDlDuYEtIdNT58d3Evqk9/2HGcIKLU7YLqw
ewYmKizxviamZvcmAFgedf0ZbXyPm/Th0La1H1M/mOuoLx21er38OecvCeJqnaeV
JyKDg5njjn/j3yCJl+I78UmuPypYfpF5ODtKMz3VpVNBPUUQd3qCvkl6vgZVlivg
tAoeKWLGc8aH6UhKglB39UPUzSujnQ==
=9OWf
-----END PGP SIGNATURE-----

--Sig_/_/09.8j6P+ZIxSBW5akcE94--
