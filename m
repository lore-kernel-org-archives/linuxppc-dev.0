Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [88.79.252.171])
	by ozlabs.org (Postfix) with ESMTP id 75AA7B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Nov 2010 04:41:39 +1100 (EST)
From: <Sergej.Stepanov@ids.de>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<dwmw2@infradead.org>
Date: Tue, 23 Nov 2010 18:38:36 +0100
Subject: [PATCH][v2] Fixing the garbage collector problem after NAND-flash
	image record in u-boot
Message-ID: <4206182445660643B9AEB8D4E55BBD0A106A0AA93A@HERMES2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: scottwood@freescale.com, Rolf.Riehle@ids.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch should fix the following problem:
 1. the  jffs2-image update in the u-boot was ok
 2. first restart and first mount of the NAND-flash-partition was also ok
 3. before the restart of controller there are no any activity on NAND-flas=
h except of the jffs2_gcd_mtdX-process ...
 4. BUT after the second restart the NAND-flash-partition could not be real=
ly used after the second mount,
    dmesg filled with messages:
...
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03ce0000: 0xc0=
ff instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03d00000: 0xc0=
ff instead
....
Just for for info:
the behaviour observed on mpc8313-based board with the large-page NAND.
The only activity on NAND-flash was the garbage collector process, that loo=
ks for CLEANMARKER-nodes

As Scott said it was broken by commit 3ab8f2a2e7011c5e83363b42950757e46ef06=
824

Signed-off-by: Sergej Stepanov <Sergej.Stepanov@ids.de>
Cc: Rolf Riehle <Rolf.Riehle@ids.de>
Cc: Scott Wood <scottwood@freescale.com>
Cc: David Woodhouse <dwmw2@infradead.org>
--

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_n=
and.c
index c141b07..7a13d42 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -388,6 +388,8 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsi=
gned int command,
 		         "page_addr: 0x%x, column: 0x%x.\n",
 		         page_addr, column);
=20
+		elbc_fcm_ctrl->column =3D column;
+		elbc_fcm_ctrl->oob =3D 0;
 		elbc_fcm_ctrl->use_mdr =3D 1;
=20
 		fcr =3D (NAND_CMD_STATUS   << FCR_CMD1_SHIFT) |
