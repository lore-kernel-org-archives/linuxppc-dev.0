Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C24921A0647
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 18:39:33 +1000 (EST)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.de>, <nicoleotsuka@gmail.com>, <Li.Xiubo@freescale.com>,
 <shc_work@mail.ru>, <fabio.estevam@freescale.com>,
 <shengjiu.wang@freescale.com>, <xobs@kosagi.com>, <arnd@arndb.de>,
 <sfr@canb.auug.org.au>, <timur@tabi.org>
Subject: [PATCH V1 2/3] ASoC: fsl-asoc-card: Fix build warning for
 maybe-uninitialized
Date: Mon, 18 Aug 2014 16:38:39 +0800
Message-ID: <b1711ff2c73f3b6acd6af000bc8294d930bbf16b.1408350626.git.shengjiu.wang@freescale.com>
In-Reply-To: <cover.1408350626.git.shengjiu.wang@freescale.com>
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When build fsl-asoc-card as module, there is following error:

sound/soc/fsl/fsl-asoc-card.c: In function 'fsl_asoc_card_probe':
>> sound/soc/fsl/fsl-asoc-card.c:547:13: warning: 'asrc_np' may be used uninitialized in this function [-Wmaybe-uninitialized]
     of_node_put(asrc_np);
                ^

vim +/asrc_np +547 sound/soc/fsl/fsl-asoc-card.c

   531                  if (width == 24)
   532                          priv->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
   533                  else
   534                          priv->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
   535          }
   536
   537          /* Finish card registering */
   538          platform_set_drvdata(pdev, priv);
   539          snd_soc_card_set_drvdata(&priv->card, priv);
   540
   541          ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
   542          if (ret)
   543                  dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
   544
   545  fail:
   546          of_node_put(codec_np);
 > 547          of_node_put(asrc_np);
   548          of_node_put(cpu_np);
   549
   550          return ret;
   551  }
   552
   553  static const struct of_device_id fsl_asoc_card_dt_ids[] = {
   554          { .compatible = "fsl,imx-audio-cs42888", },
   555          { .compatible = "fsl,imx-audio-sgtl5000", },

Add 'asrc_fail' branch for error jump after asrc_np initialized.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 sound/soc/fsl/fsl-asoc-card.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index cf3f1f4..007c772 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -469,7 +469,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		ret = fsl_asoc_card_audmux_init(np, priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to init audmux\n");
-			goto fail;
+			goto asrc_fail;
 		}
 	} else if (strstr(cpu_np->name, "esai")) {
 		priv->cpu_priv.sysclk_id[1] = ESAI_HCKT_EXTAL;
@@ -518,14 +518,14 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to get output rate\n");
 			ret = -EINVAL;
-			goto fail;
+			goto asrc_fail;
 		}
 
 		ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to get output rate\n");
 			ret = -EINVAL;
-			goto fail;
+			goto asrc_fail;
 		}
 
 		if (width == 24)
@@ -542,9 +542,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
 
+asrc_fail:
+	of_node_put(asrc_np);
 fail:
 	of_node_put(codec_np);
-	of_node_put(asrc_np);
 	of_node_put(cpu_np);
 
 	return ret;
-- 
1.7.9.5
