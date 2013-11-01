Return-Path: <B47053@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F7CB2C044C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 18:49:37 +1100 (EST)
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <r65073@freescale.com>, <timur@tabi.org>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>
Subject: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver about
 regulator.
Date: Fri, 1 Nov 2013 15:04:52 +0800
Message-ID: <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, perex@perex.cz,
 LW@KARO-electronics.de, linux@arm.linux.org.uk, b42378@freescale.com,
 oskar@scara.com, grant.likely@linaro.org, devicetree@vger.kernel.org,
 ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org,
 rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org,
 fabio.estevam@freescale.com, linux-kernel@vger.kernel.org, rob@landley.net,
 r64188@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On VF610 series there are no regulators used, and now whether the
CONFIG_REGULATOR mirco is enabled or not, for the VF610 audio
patch series, the board cannot be probe successfully.
And this patch will solve this issue.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1f4093f..c2f6d86 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -61,6 +61,7 @@ static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_DAP_AVC_DECAY,		0x0050 },
 };
 
+#ifdef CONFIG_REGULATOR
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
 enum sgtl5000_regulator_supplies {
 	VDDA,
@@ -93,6 +94,9 @@ static struct regulator_init_data ldo_init_data = {
 	.num_consumer_supplies = 1,
 	.consumer_supplies = &ldo_consumer[0],
 };
+#else
+#define SGTL5000_SUPPLY_NUM 0
+#endif
 
 /*
  * sgtl5000 internal ldo regulator,
@@ -112,7 +116,9 @@ struct sgtl5000_priv {
 	int master;	/* i2s master or not */
 	int fmt;	/* i2s data format */
 	struct regulator_bulk_data supplies[SGTL5000_SUPPLY_NUM];
+#ifdef CONFIG_REGULATOR
 	struct ldo_regulator *ldo;
+#endif
 	struct regmap *regmap;
 	struct clk *mclk;
 };
@@ -879,6 +885,7 @@ static int ldo_regulator_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 #else
+#ifndef CONFIG_SND_SOC_FSL_SGTL5000_VF610
 static int ldo_regulator_register(struct snd_soc_codec *codec,
 				struct regulator_init_data *init_data,
 				int voltage)
@@ -886,6 +893,7 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
 	return -EINVAL;
 }
+#endif
 
 static int ldo_regulator_remove(struct snd_soc_codec *codec)
 {
@@ -1137,6 +1145,7 @@ static int sgtl5000_resume(struct snd_soc_codec *codec)
 #define sgtl5000_resume  NULL
 #endif	/* CONFIG_SUSPEND */
 
+#ifdef CONFIG_REGULATOR
 /*
  * sgtl5000 has 3 internal power supplies:
  * 1. VAG, normally set to vdda/2
@@ -1373,6 +1382,7 @@ err_regulator_free:
 	return ret;
 
 }
+#endif
 
 static int sgtl5000_probe(struct snd_soc_codec *codec)
 {
@@ -1387,6 +1397,7 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+#ifdef CONFIG_REGULATOR
 	ret = sgtl5000_enable_regulators(codec);
 	if (ret)
 		return ret;
@@ -1395,6 +1406,7 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	ret = sgtl5000_set_power_regs(codec);
 	if (ret)
 		goto err;
+#endif
 
 	/* enable small pop, introduce 400ms delay in turning off */
 	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
-- 
1.8.4
