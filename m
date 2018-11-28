Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C0DC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 22:31:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7B820989
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 22:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rdCBbt51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7B820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434wNv6qqHzDqtR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 09:31:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rdCBbt51";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434wKs4c9MzDqtG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 09:28:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="rdCBbt51"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 434wKr4K4Kz9s3l;
 Thu, 29 Nov 2018 09:28:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1543444129;
 bh=oR8eni+t8uxEAANePe1Yj39/+FuhhNrMD6z+mY+KB6o=;
 h=Date:From:To:Cc:Subject:From;
 b=rdCBbt51EdQgRHJMsWCWm2YtzTgZMjdDfd1guAyHmGjPHQ2GrutsJWlKJ4s5et91V
 OgI0OyE1u5OPMWEfQ2wRQ6hXowczFUFWpJcsW/UKpHlLekVR+Pqm9PJadxKJJ0PzMV
 16Au36RwSc2GjWLZZRmnXodcitCX3sayzsQWmB8n7C+VhqdhIK0b3PM96hWNh/1sza
 3TkWAdw0xU2Ca/gZj4ioeuIUlnTr2XMdt5AaEkzZm1cOPMYK/hhmeIRlxA8iCL/A+v
 8/uOief3Od+rFUGiQuTxfbNaxH476E2k5p4qJVbT9QRrjATlgnwVsMyH67PIc9fag3
 X4/yni3CFsw6g==
Date: Thu, 29 Nov 2018 09:28:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: annotate implicit fall throughs
Message-ID: <20181129092830.40680c49@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Kxe7=.lMnwH7jx3OEI0sfDK"; protocol="application/pgp-signature"
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
Cc: "Gustavo
 A. R. Silva" <gustavo@embeddedor.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@google.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/Kxe7=.lMnwH7jx3OEI0sfDK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

There is a plan to build the kernel with -Wimplicit-fallthrough and these
places in the code produced warnings, but because we build arch/powerpc
with -Werror, they became errors.  Fix them up.

This patch produces no change in behaviour, but should be reviewed in
case these are actually bugs not intentional fallthoughs.

Cc: Kees Cook <keescook@google.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/nvram_64.c            | 1 +
 arch/powerpc/platforms/powermac/feature.c | 1 +
 arch/powerpc/xmon/xmon.c                  | 1 +
 3 files changed, 3 insertions(+)

The patch is relative to v4.20-rc4 and has been in linux-next for a
few days.

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 22e9d281324d..06e2eda2430e 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -809,6 +809,7 @@ static long dev_nvram_ioctl(struct file *file, unsigned=
 int cmd,
 #ifdef CONFIG_PPC_PMAC
 	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
 		printk(KERN_WARNING "nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n=
");
+		/* fall through */
 	case IOC_NVRAM_GET_OFFSET: {
 		int part, offset;
=20
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platf=
orms/powermac/feature.c
index ed2f54b3f173..a7ec06876b53 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1471,6 +1471,7 @@ static long g5_i2s_enable(struct device_node *node, l=
ong param, long value)
 	case 2:
 		if (macio->type =3D=3D macio_shasta)
 			break;
+		/* fall through */
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 36b8dc47a3c3..308326f8b7ed 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -4033,6 +4033,7 @@ static int do_spu_cmd(void)
 		subcmd =3D inchar();
 		if (isxdigit(subcmd) || subcmd =3D=3D '\n')
 			termch =3D subcmd;
+		/* fall through */
 	case 'f':
 		scanhex(&num);
 		if (num >=3D XMON_NUM_SPUS || !spu_info[num].spu) {
--=20
2.20.0.rc1

--=20
Cheers,
Stephen Rothwell

--Sig_/Kxe7=.lMnwH7jx3OEI0sfDK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv/Fo8ACgkQAVBC80lX
0GxceAgAm4e0+XBmPvq933rdtUP79jfjqxRCjD43Qj9LA4fenCWuISamjRiMaP0K
K59wip2ieHqzciDsnlW8E5pMGveqAMAxiwOqoXewZlriTx5mgodrpNr1lCFpBz14
kW7akiPvRpvKm4dFmJ5VyH1hqyEN0RfFa7fdi6AXNUVWo7/CSz9klnzG30lsmpX6
P12w7gL8qT8GhxLrqAeQXJI81zRpDQqxu0FEYPIMZP5oBmQYmvZtxDn02BtHtmlg
6Mbgfw1HzODqQNkIdKyf12nUh+XpeLWtfKbwy5wK3CGOcmBiO29DqyDAIkWfG691
hIkAc/RqTEP2Cxht7PIKH3qNHpVjPQ==
=fT4E
-----END PGP SIGNATURE-----

--Sig_/Kxe7=.lMnwH7jx3OEI0sfDK--
