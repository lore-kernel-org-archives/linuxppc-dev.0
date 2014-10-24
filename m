Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 979BC1A1868
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Oct 2014 10:48:28 +1100 (AEDT)
Received: by mail-pd0-f173.google.com with SMTP id v10so2286973pde.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 16:48:26 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	b02247@freescale.com
Subject: [PATCH 2/2] ASoC: fsl-asoc-card: Add slot_width setting for cpu-dai
Date: Fri, 24 Oct 2014 16:48:13 -0700
Message-Id: <3c45318a95056000736874fe7cc0a26922b742e1.1414193668.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1414193668.git.nicoleotsuka@gmail.com>
References: <cover.1414193668.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1414193668.git.nicoleotsuka@gmail.com>
References: <cover.1414193668.git.nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ESAI may need to use fixed slot width to comply with external
CODEC. So this set_tdm_slot() call will allow the ESAI driver
to override its default dynamic slot width policy.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 14572e6..3f6959c 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -51,6 +51,7 @@ struct codec_priv {
  * @sysclk_freq[2]: SYSCLK rates for set_sysclk()
  * @sysclk_dir[2]: SYSCLK directions for set_sysclk()
  * @sysclk_id[2]: SYSCLK ids for set_sysclk()
+ * @slot_width: Slot width of each frame
  *
  * Note: [1] for tx and [0] for rx
  */
@@ -58,6 +59,7 @@ struct cpu_priv {
 	unsigned long sysclk_freq[2];
 	u32 sysclk_dir[2];
 	u32 sysclk_id[2];
+	u32 slot_width;
 };
 
 /**
@@ -142,6 +144,15 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	if (cpu_priv->slot_width) {
+		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2,
+					       cpu_priv->slot_width);
+		if (ret) {
+			dev_err(dev, "failed to set TDM slot for cpu dai\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -453,6 +464,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.sysclk_freq[RX] = priv->codec_priv.mclk_freq;
 		priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
 		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
+		priv->cpu_priv.slot_width = 32;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-sgtl5000")) {
 		priv->codec_priv.mclk_id = SGTL5000_SYSCLK;
-- 
1.9.1
