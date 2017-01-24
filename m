Return-Path: <prvs=119740d71a=mark.marshall@omicronenergy.com>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v75BZ5rk2zDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 22:12:54 +1100 (AEDT)
From: <mark.marshall@omicronenergy.com>
To: <computersforpeace@gmail.com>, <linux-mtd@lists.infradead.org>
CC: <markmarshall14@gmail.com>, <raghav.dogra@nxp.com>,
 <boris.brezillon@free-electrons.com>, <leoyang.li@nxp.com>,
 <oss@buserror.net>, <prabhakar.kushwaha@nxp.com>,
 <linuxppc-dev@lists.ozlabs.org>, <raghav@freescale.com>,
 <b44839@freescale.com>, Mark Marshall <mark.marshall@omicronenergy.com>,
 <stable@vger.kernel.org>
Subject: [PATCH] mtd/ifc: Fix location of eccstat registers for IFC V1.0
Date: Tue, 24 Jan 2017 12:01:22 +0100
Message-ID: <1485255682-2373-1-git-send-email-mark.marshall@omicronenergy.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mark Marshall <mark.marshall@omicronenergy.com>

The commit 7a654172161c ("mtd/ifc: Add support for IFC controller
version 2.0") added support for version 2.0 of the IFC controller.
The version 2.0 controller has the ECC status registers at a different
location to the previous versions.  This broke the code for IFC all
versions less than 2.0.

Correct the fsl_ifc_nand structure so that the ECC status can be read
from the correct location for both version 1.0 and 2.0 of the controller.

Cc: stable@vger.kernel.org
Signed-off-by: Mark Marshall <mark.marshall@omicronenergy.com>
---
 drivers/mtd/nand/fsl_ifc_nand.c | 5 ++++-
 include/linux/fsl_ifc.h         | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 0a177b1..123c0f8 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -260,7 +260,10 @@ static void fsl_ifc_run_command(struct mtd_info *mtd)
 		int sector_end = sector + chip->ecc.steps - 1;
 
 		for (i = sector / 4; i <= sector_end / 4; i++)
-			eccstat[i] = ifc_in32(&ifc->ifc_nand.nand_eccstat[i]);
+			eccstat[i] = ifc_in32(
+				(ctrl->version >= FSL_IFC_VERSION_2_0_0) ?
+				&ifc->ifc_nand.v2_nand_eccstat[i] :
+				&ifc->ifc_nand.v1_nand_eccstat[i]);
 
 		for (i = sector; i <= sector_end; i++) {
 			errors = check_read_ecc(mtd, ctrl, eccstat, i);
diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
index 3f9778c..c332f0a 100644
--- a/include/linux/fsl_ifc.h
+++ b/include/linux/fsl_ifc.h
@@ -733,8 +733,12 @@ struct fsl_ifc_nand {
 	__be32 nand_erattr1;
 	u32 res19[0x10];
 	__be32 nand_fsr;
-	u32 res20[0x3];
-	__be32 nand_eccstat[6];
+	u32 res20;
+	/* The V1 nand_eccstat is actually 4 words that overlaps the
+	 * V2 nand_eccstat.
+	 */
+	__be32 v1_nand_eccstat[2];
+	__be32 v2_nand_eccstat[6];
 	u32 res21[0x1c];
 	__be32 nanndcr;
 	u32 res22[0x2];
-- 
2.7.4
