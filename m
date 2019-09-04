Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04677C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 00:15:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735CE22CED
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 00:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hMmtYMXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735CE22CED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NPVP6sFrzDqlZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 10:15:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NPRy6V1zzDqlZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 10:13:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="hMmtYMXz"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46NPRx71w0z9sP3;
 Wed,  4 Sep 2019 10:13:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1567556014;
 bh=9sKqcVmNPYcGRbL8j5mK/risVZPS130A9GxQFjJc+2w=;
 h=Date:From:To:Cc:Subject:From;
 b=hMmtYMXzvtmigmoLB8fOijNYtv0w5+23EcHc04CBtf7WVe1yOFljK8/8JBMv0QYYK
 sj3vgnkfMV07qCWR2S11v+HEgAcxQiXVr2h7CBqCSoon2uSCqelyjObd3OHkACDdbq
 TQ4jsVE5GPT7/F6jlmtINjBcCW64T4xw64tqMJU1TM9tfUkRWLVMe6pDEom1/9R2fZ
 xRnuZE1vNZQWMPFf6lIYE8QRrqUt4SHTw39cJZK/ye9bNwlse+27i6lpiUefqlZRCF
 mqOmFYYFQRIK56R+XSEQqfLtnuJdEmzpE29jGxuYiEN9PJ8jd6qM12eYrSCoVOzryg
 N4W6fPgtzWARQ==
Date: Wed, 4 Sep 2019 10:13:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: build warnings after merge of the kbuild tree
Message-ID: <20190904101259.2687cea4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ssBCJi3mTERdd=v=ROJKrJr";
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

--Sig_/ssBCJi3mTERdd=v=ROJKrJr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (powerpc
ppc64_defconfig) produced these warnings:


Presumably introduced by commit

  1267f9d3047d ("kbuild: add $(BASH) to run scripts with bash-extension")

and presumably arch/powerpc/tools/unrel_branch_check.sh (which has no
#! line) is a bash script.  Yeah, is uses '((' and '))'.

--=20
Cheers,
Stephen Rothwell

--Sig_/ssBCJi3mTERdd=v=ROJKrJr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1vAaYACgkQAVBC80lX
0GxOmAf+IJwgmJGltVlvpa0v/AYyBNUCM/OMskna4gAT92XarZeed2UfoxwB0g/l
hXnIdav7xtwj/Enz2jsOiomWSzBEAY+D2idUi2T8VMD+VVWdV5xFXFyFKL7+c0/N
lxyYAXB/oKmyhNTOPMNJk8ThSr+hBZEgDSHX//j0iJ39+wfmf098N+RbvdVCUqXc
jirj7RLWRrWA4LcUjMMPQMky3gp+CI5olpcFdVyGNKS4j+nE3BTR/DzQCGLPO31Y
2XlhVtnbDGD18/aGnc8n0qBm5wqVexi939dCcXJDGmO2l+Jyb7iUAvPFD4Tev2u+
0HyFqdbbIU5lqfTTQGgwcKlbePY3CQ==
=l4Bs
-----END PGP SIGNATURE-----

--Sig_/ssBCJi3mTERdd=v=ROJKrJr--
