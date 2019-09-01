Return-Path: <SRS0=xyAZ=W4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AB9C3A5A4
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Sep 2019 23:49:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88AA21744
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Sep 2019 23:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IM/wa5hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88AA21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46M90z336DzDqZB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 09:49:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46M8yT67YBzDqXL
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2019 09:47:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="IM/wa5hj"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46M8yS24Spz9sPJ;
 Mon,  2 Sep 2019 09:47:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1567381633;
 bh=zmc88K7pPwz/7pK597nkwLmMZfxgBX1IUukfW1MCsGc=;
 h=Date:From:To:Cc:Subject:From;
 b=IM/wa5hjdoxSeultbW2f/JTStiYCBqgVgQDblV7OcN1wn6K6FC/xUcMWC030P4qI0
 IkIwFfDb/KY15sOBmXm4CJHxTkdFwuOttbKcmlH9g5HpVdJ+ckYpBMM/fp1G1zajEd
 EFzv79SjhbiWVlazsNavTE9SXaUt91xHcanC6ezJvDi9V+jpJ4uuFbvmJ/OLXvRhd8
 0e87EpCAGQsyznCYVcS6x6EC0xnD7l0e73KuqJFT5r8YEcY6UBWCjxLZxHzAzulLWQ
 WGEb4DL8rfgfpKkjzIJ/jBL+VCua7kBNDfkODWTCoig/02grtoaYD51IYB052AcoaL
 v427yot0yTuwQ==
Date: Mon, 2 Sep 2019 09:47:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: linux-next: manual merge of the powerpc tree with the arm64 tree
Message-ID: <20190902094711.2625ba31@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WoIHGSr/SYoJjSAIyQJzfgs";
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
 Peter Collingbourne <pcc@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/WoIHGSr/SYoJjSAIyQJzfgs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/Kconfig

between commit:

  5cf896fb6be3 ("arm64: Add support for relocating the kernel with RELR rel=
ocations")

from the arm64 tree and commit:

  0c9c1d563975 ("x86, s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kc=
onfig")

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

diff --cc arch/Kconfig
index 6f4d3e9bf486,89e2e3f64f79..000000000000
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@@ -932,20 -925,9 +932,23 @@@ config LOCK_EVENT_COUNT
  	  the chance of application behavior change because of timing
  	  differences. The counts are reported via debugfs.
 =20
 +# Select if the architecture has support for applying RELR relocations.
 +config ARCH_HAS_RELR
 +	bool
 +
 +config RELR
 +	bool "Use RELR relocation packing"
 +	depends on ARCH_HAS_RELR && TOOLS_SUPPORT_RELR
 +	default y
 +	help
 +	  Store the kernel's dynamic relocations in the RELR relocation packing
 +	  format. Requires a compatible linker (LLD supports this feature), as
 +	  well as compatible NM and OBJCOPY utilities (llvm-nm and llvm-objcopy
 +	  are compatible).
 +
+ config ARCH_HAS_MEM_ENCRYPT
+ 	bool
+=20
  source "kernel/gcov/Kconfig"
 =20
  source "scripts/gcc-plugins/Kconfig"

--Sig_/WoIHGSr/SYoJjSAIyQJzfgs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1sWH8ACgkQAVBC80lX
0Gz1RwgAh57g+YWywSWFGyIU9PXvjl+BmXtD+RIQ15nEEK8g1yrfrql5eRSHnzAG
BL1OEsYKnP7gx5wOLq2dYBfv7N0DflELVB+g4TI92kk3fRfjOuxvYWt2jTuhSVZj
ym1o/Rb94B1I7aYuWMu5hpdura8TXP0AHmRdU/Us80NwabJ2Dy3NKycqUMGPhuwp
4CvOi/vKr6mETuBmBZGCwU/C1v6XNO4P2OtjiKpjWrRS1vJgBE4UqkxbDROuKd85
jW0NrimpSferCeJ+001AUTZhKcT4CiusyLT5JxxC/omU0YGIG/VRxok6R9/boCb7
t5d1Ze8RpGK1ehT1Y82XWyHDlHQkcQ==
=ZBzL
-----END PGP SIGNATURE-----

--Sig_/WoIHGSr/SYoJjSAIyQJzfgs--
