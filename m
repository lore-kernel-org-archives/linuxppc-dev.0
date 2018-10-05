Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33994C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 06:16:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F52F2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 06:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bezn5lhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F52F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RKK36YtZzF3Km
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bezn5lhl";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RKG853wLzF3KQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 16:14:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="bezn5lhl"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42RKG83Bgfz9s1c;
 Fri,  5 Oct 2018 16:14:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1538720048;
 bh=jK0o3PtWZeLAF8khM/jrOtwToJhWv4Nn4c4dbxoOTZE=;
 h=Date:From:To:Cc:Subject:From;
 b=bezn5lhlwxyiQL9WaiGD2+TlBMM5fUFP4sUTkTc/eH/5JqXufFtjCAZE/7ihvxDF4
 EQyolfr47hcoLXVXRVrSgai+KeTC8k4D63yCVPeBYNExoEnz4DZUro78XlzW4XD6Zw
 rRIxKVgRbTFi7Hq93Y3J78K/EghWdDC6o37rU7rO8SZsfG59QxLP2pApn3GLZw8QZP
 L9LwNvaEnqfw4cSFsBRhVGjVcQNiveXGvUujrAnncNqLDkmqQTYcLk9FfRi+lcQdbI
 11m9mi5xYVw5GuVSXq3OumiHoBUw8Dvw+AECnQLH+gme/oSr6vzx1zhfHG/nfcb3oS
 bYDMicLHyw/rw==
Date: Fri, 5 Oct 2018 16:14:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the akpm tree
Message-ID: <20181005161406.73ef8727@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PqI=Q4__5fvqHM010aHNvvg"; protocol="application/pgp-signature"
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
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/PqI=Q4__5fvqHM010aHNvvg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/kernel/setup-common.c:36:10: fatal error: linux/bootmem.h: No =
such file or directory
 #include <linux/bootmem.h>
          ^~~~~~~~~~~~~~~~~

Caused by commit

  49353a51a758 ("mm: remove include/linux/bootmem.h")

interacting with commit

  d90fe2acd9b2 ("powerpc: Wire up memtest")

from the powerpc tree.

I applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 5 Oct 2018 16:09:34 +1000
Subject: [PATCH] powerpc: fix up for removal of linux/bootmem.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/setup-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup=
-common.c
index 2b56d1f30387..93ee3703b42f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -33,7 +33,6 @@
 #include <linux/serial_8250.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
-#include <linux/bootmem.h>
 #include <linux/of_platform.h>
 #include <linux/hugetlb.h>
 #include <asm/debugfs.h>
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/PqI=Q4__5fvqHM010aHNvvg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu3AS4ACgkQAVBC80lX
0GxCyggAg5gUWegEXXnk7wl/PLRnQNhoBupsa4E65FXsIkDF4WoiF+i9lhogvJ3+
0xoJ7ebndA4ouD+mpfvHblrhvHaUoTCTn89Oay9IQcYnvZWqOUBEYulZHMufaBpe
iNWajM0BVMfQ4x7xXWZTSyPFJR6McVXjdqln70zk6yyMjbpfAdmDZSjs1cQW56iM
ZNi8Q8J8JRL3JeSZeQqIlhTQ4vITRYhntHFD50mWNqXUviBw0zfFsIlvgH8XEMEf
/8V5OWQ1Q57Jj+vMbJY/UgyF0HNZWvnWmVAv8+VP2M0RjN7GKfcY4RtTv+Zyun81
L4UwewyWuPg+/tvjH2MhBzwzVcENTw==
=Pl6b
-----END PGP SIGNATURE-----

--Sig_/PqI=Q4__5fvqHM010aHNvvg--
