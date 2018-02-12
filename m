Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgKRM75JPzF0py
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:02:55 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id t4so7362294pgp.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:02:55 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 13/17] ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()
Date: Mon, 12 Feb 2018 14:03:21 -0800
Message-Id: <1518473005-14090-14-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

AC97 configures most of registers earlier to start a communication
with CODECs in order to successfully initialize CODEC. Currently,
_fsl_ssi_set_dai_fmt() and fsl_ssi_setup_ac97() are called to get
all SSI registers properly set.

Since now the driver has a fsl_ssi_hw_init() to handle all register
initial settings, this patch moves those register settings of AC97
to the fsl_ssi_hw_init() as well.

Meanwhile it applies _fsl_ssi_set_dai_fmt() call to AC97 only since
other formats would be configured via normal set_dai_fmt() directly.

This patch also adds fsl_ssi_hw_clean() to cleanup control bits for
AC97 in the platform remote() function.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 36f3d51..dfb0da3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -987,9 +987,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, REG_SSI_SRCR, srcr);
 	regmap_write(regs, REG_SSI_SCR, scr);
 
-	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
-		fsl_ssi_setup_ac97(ssi);
-
 	return 0;
 }
 
@@ -1255,10 +1252,34 @@ static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
 		regmap_update_bits(ssi->regs, REG_SSI_SCR,
 				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
 
+	/* AC97 should start earlier to communicate with CODECs */
+	if (fsl_ssi_is_ac97(ssi)) {
+		_fsl_ssi_set_dai_fmt(ssi->dev, ssi, ssi->dai_fmt);
+		fsl_ssi_setup_ac97(ssi);
+	}
+
 	return 0;
 }
 
 /**
+ * Clear SSI registers
+ */
+static void fsl_ssi_hw_clean(struct fsl_ssi *ssi)
+{
+	/* Disable registers for AC97 */
+	if (fsl_ssi_is_ac97(ssi)) {
+		/* Disable TE and RE bits first */
+		regmap_update_bits(ssi->regs, REG_SSI_SCR,
+				   SSI_SCR_TE | SSI_SCR_RE, 0);
+		/* Disable AC97 mode */
+		regmap_write(ssi->regs, REG_SSI_SACNT, 0);
+		/* Unset WAIT bits */
+		regmap_write(ssi->regs, REG_SSI_SOR, 0);
+		/* Disable SSI -- software reset */
+		regmap_update_bits(ssi->regs, REG_SSI_SCR, SSI_SCR_SSIEN, 0);
+	}
+}
+/**
  * Make every character in a string lower-case
  */
 static void make_lowercase(char *s)
@@ -1540,9 +1561,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
-	if (ssi->dai_fmt)
-		_fsl_ssi_set_dai_fmt(dev, ssi, ssi->dai_fmt);
-
 	/* Initially configures SSI registers */
 	fsl_ssi_hw_init(ssi);
 
@@ -1592,6 +1610,9 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi->pdev)
 		platform_device_unregister(ssi->pdev);
 
+	/* Clean up SSI registers */
+	fsl_ssi_hw_clean(ssi);
+
 	if (ssi->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi);
 
-- 
2.1.4
