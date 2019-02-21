Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01890C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 22:28:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739FF20836
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 22:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C48jI7pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739FF20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4458Hl3mZgzDqBV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:28:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4458DT5qlrzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 09:25:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="C48jI7pe"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 4458DT4BCMz9s6w;
 Fri, 22 Feb 2019 09:25:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1550787913;
 bh=eAXJr57ufS6P2ldxEApeayAtZo9CDAi9SD3WmE6B3V4=;
 h=Date:From:To:Cc:Subject:From;
 b=C48jI7peM0j7sj0JAWVlpboLaEv0JeQB8dLW5JGBIe0p+23BCaNBWaYeK3nibEaTI
 ZMhAt9mjdYqDFrJR73vZghvUIOz44NSFsHNlG7Xt0rF+1vfVLNraxVbgIoXsuFcjXU
 B+7e9FY6qa8doKR7eQGNaIfdihF2lFwAq2go6YwJdJA2SrUW2GcTQfAYgSMtJVkhG8
 CdomUd+Mq46QlbmQbD2nBVS636AiyxUFGHMdEQUvf1eMbqE1IzYr338hIDpaRnkAyp
 jFrZvumJLDlShIgGI0/oh5+x2C3Ftyp+wWiQeoVlzTeqed8EvhdgbjBJ9SMuzldmQy
 JhYrDokk9BYpA==
Date: Fri, 22 Feb 2019 09:25:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the powerpc tree with the dma-mapping tree
Message-ID: <20190222092513.6fc2a708@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zNp4Tra4Z_ikkK3FNtEyRzz"; protocol="application/pgp-signature"
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

--Sig_/zNp4Tra4Z_ikkK3FNtEyRzz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  kernel/dma/Kconfig

between commits:

  ff4c25f26a71 ("dma-mapping: improve selection of dma_declare_coherent ava=
ilability")

from the dma-mapping tree and commit:

  11ddce15451e ("dma-mapping, powerpc: simplify the arch dma_set_mask overr=
ide")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/dma/Kconfig
index 212aac7c675f,0711d18645de..000000000000
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@@ -16,13 -16,10 +16,16 @@@ config ARCH_DMA_ADDR_T_64BI
  config ARCH_HAS_DMA_COHERENCE_H
  	bool
 =20
+ config ARCH_HAS_DMA_SET_MASK
+ 	bool
+=20
 -config HAVE_GENERIC_DMA_COHERENT
 +config DMA_DECLARE_COHERENT
 +	bool
 +
 +config ARCH_HAS_SETUP_DMA_OPS
 +	bool
 +
 +config ARCH_HAS_TEARDOWN_DMA_OPS
  	bool
 =20
  config ARCH_HAS_SYNC_DMA_FOR_DEVICE

--Sig_/zNp4Tra4Z_ikkK3FNtEyRzz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvJUkACgkQAVBC80lX
0GxiSwf/QpkrhZ2Ci6hLUg8KmKSjZGbd/tA2zE9R7AFWwQhExWsOJ0iHhdHxF2lG
KzY5YGEURbnEca9Q3pIUg4IUn14Fk97/ZK2S/EClyMku95wszM2eZL3gZOFBM5ZZ
ByaXE3Z+AUrJhov73SDJrC6Am9akrCR4WERVle66mNZ4GsoGVqOvRmS8R/yxZgC9
1pVkcru/IMaLW3uq2SlPwadUNcl4nv0rYZKGPUThraKz4zjWgpuEScbvCzvaIeLC
+IrLVQU+RIqOzWleqUaO0PrV5jevcsvsUl2AoxDEZWN/W/evx7P6+oDy2/J5sRCH
iyGDSsdCrp4K5fYtdmULWLi59xrBxg==
=bKYM
-----END PGP SIGNATURE-----

--Sig_/zNp4Tra4Z_ikkK3FNtEyRzz--
