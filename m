Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F5C43214
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 09:56:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544A161057
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 09:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 544A161057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GtSLf6FSkz2yNN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 19:56:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=Ldz2Hmwx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=canb.auug.org.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=sfr@canb.auug.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=Ldz2Hmwx; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GtSKs2Pggz2xrG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Aug 2021 19:55:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GtSKp4R2pz9sW8;
 Mon, 23 Aug 2021 19:55:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
 s=201702; t=1629712542;
 bh=zwzpiVdFpUOY3sgpUH9+i47HU7keaNx8ICF/xEg2hKY=;
 h=Date:From:To:Cc:Subject:From;
 b=Ldz2HmwxLh7cUWHIhCxZj5vYjNzl7SWL3bsnjAU6T8556c06n6QdNJRBkwCkGx6R7
 LW5E4tfDMsVyafrAkVGfF7n9wjnKz4DZ38rvLkndsoOFGvrjibQeKLySV28x4loW7X
 sfyb4eV4cba+P4/miXxfvsmpLa9xjZLpYo2+hnKIk9LUOFUUDgz0xggolkTbRpUa2U
 7fStyKn8qcQI3GRiX2wUFrFrMuDk6+2WRuN00kvJUGOH6uFEjkhJEmjGyfoMlhIcxV
 N/YwuzAnjP8jSuKP3DpS3VSW3fnXKpYhGWSKpjv3eshJjT25xN2hVGu6+dN7VX8cBx
 lB7Ji5T6Hg06A==
Date: Mon, 23 Aug 2021 19:55:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build warning after merge of the powerpc tree
Message-ID: <20210823195540.4d7363ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OD3gpQqjzB8vriqSeKQB=VJ";
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/OD3gpQqjzB8vriqSeKQB=VJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, today's linux-next build (htmldocs)
produced this warning:

docutils.utils.SystemMessage: Documentation/powerpc/associativity.rst:1: (S=
EVERE/4) Title overline & underline mismatch.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
NUMA resource associativity
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Introduced by commit

  1c6b5a7e7405 ("powerpc/pseries: Add support for FORM2 associativity")

There are other obvious problems with this document (but sphinx seems
to have hung before it reported them).

Like

Form 0
-----

and

Form 1
-----

and

Form 2
-------

--=20
Cheers,
Stephen Rothwell

--Sig_/OD3gpQqjzB8vriqSeKQB=VJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmEjcJwACgkQAVBC80lX
0Gwknwf/eh5eOVTLm0/phY7/CRqjgQcgkibEQyOqtvv75dvTPGVX/nZtzfRp9n0p
Xqyk/sWo7FldmiKb3mp8me9CnTaEDayf46TVX8VqxNx5o82CAHbtEymja9SBces5
trw5sejneOtOWhPF9yIYTXTVy1Q9PDiLbJQCcRfFP5piFGVUDTiTqadPbFDdGWbO
CASRhJVras/MoOdKEpF7fy6iED0BDTn/gU1Oi0jqPrC6H0euL5TRgDfaTRqsJhol
BRtytK/oM4n7PBLbyC50pjsoOGGFmZ2xGP2YosqR3bWAaN/h95v0bvoK0IX8bWUI
iGIu6DbGTceYrOMcXM8CrQ34b9TtzA==
=UOWd
-----END PGP SIGNATURE-----

--Sig_/OD3gpQqjzB8vriqSeKQB=VJ--
