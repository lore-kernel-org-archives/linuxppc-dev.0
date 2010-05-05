Return-Path: <stevedeiters@basler.com>
Received: from tethra.basler.com (tethra.basler.com [206.107.254.19])
	by ozlabs.org (Postfix) with ESMTP id AF4E3B7D53
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 May 2010 04:48:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH resend] mpc5121_nfc: Changed SVR check to allow MPC5123.
Date: Wed, 5 May 2010 13:48:38 -0500
Message-ID: <181804936ABC2349BE503168465576460EA16F75@exchserver.basler.com>
In-Reply-To: <1272980863.3702.10.camel@localhost>
References: <181804936ABC2349BE503168465576460E95836C@exchserver.basler.com>
	<1272980863.3702.10.camel@localhost>
From: "Steve Deiters" <SteveDeiters@BASLER.com>
To: <dedekind1@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The revision in SVR for MPC5123 is 3.  The NFC is the same as MPC5121
revision 2.

Signed-off-by: Steve Deiters <SteveDeiters@basler.com>
---
 drivers/mtd/nand/mpc5121_nfc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/mpc5121_nfc.c
b/drivers/mtd/nand/mpc5121_nfc.c
index 191bf99..dc04d74 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -666,10 +666,10 @@ static int __devinit mpc5121_nfc_probe(struct
of_device *op,
=20
 	/*
 	 * Check SoC revision. This driver supports only NFC
-	 * in MPC5121 revision 2.
+	 * in MPC5121 revision 2 and MPC5123 revision 3.
 	 */
 	rev =3D (mfspr(SPRN_SVR) >> 4) & 0xF;
-	if (rev !=3D 2) {
+	if ((rev !=3D 2) && (rev !=3D 3)) {
 		dev_err(dev, "SoC revision %u is not supported!\n",
rev);
 		return -ENXIO;
 	}
--=20
1.5.4.3
