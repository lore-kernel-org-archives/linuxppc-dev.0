Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKgDg0TbkzF0Xg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 15:22:26 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id j2so7416111pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 20:22:26 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v3 09/17] ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()
Date: Sun, 14 Jan 2018 20:21:19 -0800
Message-Id: <1515990087-11598-10-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch cleans fsl_ssi_setup_regvals() by following changes:
1) Moving DBG bits to the first lines.
2) Setting SSIE, RE/TE as default and cleaning it for AC97

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b76a517..e5efee2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -580,18 +580,16 @@ static void fsl_ssi_setup_regvals(struct fsl_ssi *ssi)
 {
 	struct fsl_ssi_regvals *vals = ssi->regvals;
 
-	vals[RX].sier = SSI_SIER_RFF0_EN;
+	vals[RX].sier = SSI_SIER_RFF0_EN | FSLSSI_SIER_DBG_RX_FLAGS;
 	vals[RX].srcr = SSI_SRCR_RFEN0;
-	vals[RX].scr = 0;
-	vals[TX].sier = SSI_SIER_TFE0_EN;
+	vals[RX].scr = SSI_SCR_SSIEN | SSI_SCR_RE;
+	vals[TX].sier = SSI_SIER_TFE0_EN | FSLSSI_SIER_DBG_TX_FLAGS;
 	vals[TX].stcr = SSI_STCR_TFEN0;
-	vals[TX].scr = 0;
+	vals[TX].scr = SSI_SCR_SSIEN | SSI_SCR_TE;
 
 	/* AC97 has already enabled SSIEN, RE and TE, so ignore them */
-	if (!fsl_ssi_is_ac97(ssi)) {
-		vals[RX].scr = SSI_SCR_SSIEN | SSI_SCR_RE;
-		vals[TX].scr = SSI_SCR_SSIEN | SSI_SCR_TE;
-	}
+	if (fsl_ssi_is_ac97(ssi))
+		vals[RX].scr = vals[TX].scr = 0;
 
 	if (ssi->use_dma) {
 		vals[RX].sier |= SSI_SIER_RDMAE;
@@ -600,9 +598,6 @@ static void fsl_ssi_setup_regvals(struct fsl_ssi *ssi)
 		vals[RX].sier |= SSI_SIER_RIE;
 		vals[TX].sier |= SSI_SIER_TIE;
 	}
-
-	vals[RX].sier |= FSLSSI_SIER_DBG_RX_FLAGS;
-	vals[TX].sier |= FSLSSI_SIER_DBG_TX_FLAGS;
 }
 
 static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
-- 
2.7.4
