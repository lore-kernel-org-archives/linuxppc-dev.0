Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znFHl4DvbzDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 00:16:50 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Caleb Crome <caleb@crome.org>,
 Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Mark Brown <broonie@kernel.org>, timur@tabi.org, broonie@kernel.org,
 mail@maciej.szmigiero.name, kernel@pengutronix.de, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, caleb@crome.org, linux-kernel@vger.kernel.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()" to the asoc
 tree
In-Reply-To: <1513702819-42310-8-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eoqjn-0006L5-S6@debutante>
Date: Thu, 22 Feb 2018 13:16:39 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 501bc1d70cf5ba8ccd9775ce987c90485034464e Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:17 -0800
Subject: [PATCH] ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()

This patch cleans fsl_ssi_setup_regvals() by following changes:
1) Moving DBG bits to the first lines.
2) Setting SSIE, RE/TE as default and cleaning it for AC97

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fc5768d243d1..156f5132feba 100644
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
2.16.1
