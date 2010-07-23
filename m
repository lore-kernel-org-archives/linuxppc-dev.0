Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 71E3D100A2F
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jul 2010 00:01:06 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 1/5] fsl-diu-fb: fix issue with re-enabling DIU area
	descriptor
Date: Fri, 23 Jul 2010 16:00:35 +0200
Message-Id: <1279893639-24333-2-git-send-email-agust@denx.de>
In-Reply-To: <1279893639-24333-1-git-send-email-agust@denx.de>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, devicetree-discuss@lists.ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On MPC5121e Rev 2.0 re-configuring the DIU area descriptor
by writing new descriptor address doesn't always work.
As a result, DIU continues to display using old area descriptor
even if the new one has been written to the descriptor register of
the plane.

Add the code from Freescale MPC5121EADS BSP for writing descriptor
addresses properly. This fixes the problem for Rev 2.0 silicon.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v4:
 - use workaround code as suggested by FSL technical support.

v3:
 - no changes since v1

 drivers/video/fsl-diu-fb.c |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 27455ce..9b8c991 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -317,6 +317,17 @@ static void fsl_diu_free(void *virt, size_t size)
 		free_pages_exact(virt, size);
 }
 
+/*
+ * Workaround for failed writing desc register of planes.
+ * Needed with MPC5121 DIU rev 2.0 silicon.
+ */
+void wr_reg_wa(u32 *reg, u32 val)
+{
+	do {
+		out_be32(reg, val);
+	} while (in_be32(reg) != val);
+}
+
 static int fsl_diu_enable_panel(struct fb_info *info)
 {
 	struct mfb_info *pmfbi, *cmfbi, *mfbi = info->par;
@@ -330,7 +341,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 		switch (mfbi->index) {
 		case 0:				/* plane 0 */
 			if (hw->desc[0] != ad->paddr)
-				out_be32(&hw->desc[0], ad->paddr);
+				wr_reg_wa(&hw->desc[0], ad->paddr);
 			break;
 		case 1:				/* plane 1 AOI 0 */
 			cmfbi = machine_data->fsl_diu_info[2]->par;
@@ -340,7 +351,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 						cpu_to_le32(cmfbi->ad->paddr);
 				else
 					ad->next_ad = 0;
-				out_be32(&hw->desc[1], ad->paddr);
+				wr_reg_wa(&hw->desc[1], ad->paddr);
 			}
 			break;
 		case 3:				/* plane 2 AOI 0 */
@@ -351,14 +362,14 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 						cpu_to_le32(cmfbi->ad->paddr);
 				else
 					ad->next_ad = 0;
-				out_be32(&hw->desc[2], ad->paddr);
+				wr_reg_wa(&hw->desc[2], ad->paddr);
 			}
 			break;
 		case 2:				/* plane 1 AOI 1 */
 			pmfbi = machine_data->fsl_diu_info[1]->par;
 			ad->next_ad = 0;
 			if (hw->desc[1] == machine_data->dummy_ad->paddr)
-				out_be32(&hw->desc[1], ad->paddr);
+				wr_reg_wa(&hw->desc[1], ad->paddr);
 			else					/* AOI0 open */
 				pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
 			break;
@@ -366,7 +377,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 			pmfbi = machine_data->fsl_diu_info[3]->par;
 			ad->next_ad = 0;
 			if (hw->desc[2] == machine_data->dummy_ad->paddr)
-				out_be32(&hw->desc[2], ad->paddr);
+				wr_reg_wa(&hw->desc[2], ad->paddr);
 			else				/* AOI0 was open */
 				pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
 			break;
@@ -390,27 +401,24 @@ static int fsl_diu_disable_panel(struct fb_info *info)
 	switch (mfbi->index) {
 	case 0:					/* plane 0 */
 		if (hw->desc[0] != machine_data->dummy_ad->paddr)
-			out_be32(&hw->desc[0],
-				machine_data->dummy_ad->paddr);
+			wr_reg_wa(&hw->desc[0], machine_data->dummy_ad->paddr);
 		break;
 	case 1:					/* plane 1 AOI 0 */
 		cmfbi = machine_data->fsl_diu_info[2]->par;
 		if (cmfbi->count > 0)	/* AOI1 is open */
-			out_be32(&hw->desc[1], cmfbi->ad->paddr);
+			wr_reg_wa(&hw->desc[1], cmfbi->ad->paddr);
 					/* move AOI1 to the first */
 		else			/* AOI1 was closed */
-			out_be32(&hw->desc[1],
-				machine_data->dummy_ad->paddr);
+			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad->paddr);
 					/* close AOI 0 */
 		break;
 	case 3:					/* plane 2 AOI 0 */
 		cmfbi = machine_data->fsl_diu_info[4]->par;
 		if (cmfbi->count > 0)	/* AOI1 is open */
-			out_be32(&hw->desc[2], cmfbi->ad->paddr);
+			wr_reg_wa(&hw->desc[2], cmfbi->ad->paddr);
 					/* move AOI1 to the first */
 		else			/* AOI1 was closed */
-			out_be32(&hw->desc[2],
-				machine_data->dummy_ad->paddr);
+			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad->paddr);
 					/* close AOI 0 */
 		break;
 	case 2:					/* plane 1 AOI 1 */
@@ -421,7 +429,7 @@ static int fsl_diu_disable_panel(struct fb_info *info)
 					/* AOI0 is open, must be the first */
 				pmfbi->ad->next_ad = 0;
 		} else			/* AOI1 is the first in the chain */
-			out_be32(&hw->desc[1], machine_data->dummy_ad->paddr);
+			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad->paddr);
 					/* close AOI 1 */
 		break;
 	case 4:					/* plane 2 AOI 1 */
@@ -432,7 +440,7 @@ static int fsl_diu_disable_panel(struct fb_info *info)
 				/* AOI0 is open, must be the first */
 				pmfbi->ad->next_ad = 0;
 		} else		/* AOI1 is the first in the chain */
-			out_be32(&hw->desc[2], machine_data->dummy_ad->paddr);
+			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad->paddr);
 				/* close AOI 1 */
 		break;
 	default:
-- 
1.7.0.4
