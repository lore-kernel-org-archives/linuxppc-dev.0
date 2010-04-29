Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id AF5CDB7D1D
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 09:49:37 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] fsl-diu-fb: fix issue with re-enabling DIU area
	descriptor on MPC5121
Date: Fri, 30 Apr 2010 01:49:34 +0200
Message-Id: <1272584978-19063-2-git-send-email-agust@denx.de>
In-Reply-To: <1272584978-19063-1-git-send-email-agust@denx.de>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss@lists.ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On MPC5121 re-configuring the DIU area descriptor by writing
new descriptor address doesn't work. As a result, DIU continues
to display using old area descriptor even if the new one has
been set.

Disabling the DIU before setting the new descriptor and
subsequently enabling it fixes the problem.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/fsl-diu-fb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 994358a..ee15a99 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -329,8 +329,11 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 	if (mfbi->type != MFB_TYPE_OFF) {
 		switch (mfbi->index) {
 		case 0:				/* plane 0 */
-			if (hw->desc[0] != ad->paddr)
+			if (hw->desc[0] != ad->paddr) {
+				out_be32(&dr.diu_reg->diu_mode, MFB_MODE0);
 				out_be32(&hw->desc[0], ad->paddr);
+				out_be32(&dr.diu_reg->diu_mode, MFB_MODE1);
+			}
 			break;
 		case 1:				/* plane 1 AOI 0 */
 			cmfbi = machine_data->fsl_diu_info[2]->par;
-- 
1.6.3.3
