Return-Path: <SRS0=DwJy=ZQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41560C432C0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Nov 2019 22:41:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79867207DD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Nov 2019 22:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="t63HcXb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79867207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47LlWX59MczDqYM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 09:41:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47LlTK5PhZzDqXd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2019 09:39:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="t63HcXb0"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47LlTH2Vrhz9sPT;
 Mon, 25 Nov 2019 09:39:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1574635156;
 bh=4q1KyTDlb0ND4mkqK8ewLqPEYFfOu065MxrD5xwKFzo=;
 h=Date:From:To:Cc:Subject:From;
 b=t63HcXb0b0Mer6zIkRhVWPC2By3UYL+T+Tj4eyhld18gQIEDHHo3HOJdhRSDC+PDw
 PCXJ9QEwmUY/1391+tu/5Lvyga4E5//cv0G0I/aIBS/EWf+bbd7BRwqb3le/JvVS/N
 jfwZzGDCQi61f3xJ73B23J2fcEQKsCuO5DCMIPYFdz4HZZA+zjLlpeYdUE1JapuoCc
 gFhiA8pQRSf+PXYtUEx1XJUmh27DfSwFOnOwFU/kLZ0IYJmV0BPBtAzda15JZFgfwN
 SNfJnrZZDAkf8otD9T7lpv1KZoYOuw3+rPT/2hK9sKr09RQfiEbJdkwvhlyhtpkyXP
 qwCfTysJumUCQ==
Date: Mon, 25 Nov 2019 09:39:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>, Michael Ellerman
 <mpe@ellerman.id.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the pci tree with the powerpc tree
Message-ID: <20191125093907.45e3421b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b+Onz14PBl20uhRM4dwdRuw";
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Simek <michal.simek@xilinx.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/b+Onz14PBl20uhRM4dwdRuw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pci tree got a conflict in:

  arch/powerpc/include/asm/Kbuild

between commit:

  265c3491c4bc ("powerpc: Add support for GENERIC_EARLY_IOREMAP")

from the powerpc tree and commit:

  356f42aff121 ("asm-generic: Make msi.h a mandatory include/asm header")

from the pci tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/Kbuild
index 148bee20e7e2,17726f2e46de..000000000000
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@@ -11,5 -10,3 +11,4 @@@ generic-y +=3D local64.
  generic-y +=3D mcs_spinlock.h
  generic-y +=3D preempt.h
  generic-y +=3D vtime.h
- generic-y +=3D msi.h
 +generic-y +=3D early_ioremap.h

--Sig_/b+Onz14PBl20uhRM4dwdRuw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3bBosACgkQAVBC80lX
0GxSCQf9GqVqx1LQuv7pxaUpAfSHTgqiURU3NYL+s6pFWcZqlqSZZuwOgW3Dlte5
Q5CwCC4z6FDugRWucbXvWo2dYTqBypijJugygqXYruHOHl3i40mgSyiTqIXkleWR
mdBbA8EOYfLfI7f/DboasIxKk/qaN4TZfCjW+rT7bPwHha/kMr1vYR8pUHPLsvVX
PNHDFavWlCT9UaPOo5CU4Q4H3gsGuag5m6owS42Ifp2gwQF3r25tgjtYDcxLPkh0
IoiqmtXKYIvHclm1p7QIjwxqbLreiuL/wvJWJYOWUICu66s3a2jkyVVjCCtOX2D8
8gHptQa/NAyg8RkEzB/F6yGCSJz/Qg==
=Idfr
-----END PGP SIGNATURE-----

--Sig_/b+Onz14PBl20uhRM4dwdRuw--
