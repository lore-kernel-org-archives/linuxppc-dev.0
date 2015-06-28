Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23B331A05E3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 23:44:18 +1000 (AEST)
Message-ID: <558FFA24.9070305@maciej.szmigiero.name>
Date: Sun, 28 Jun 2015 15:44:04 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/6] ASoC: fsl_ssi: enable IPG clock during AC'97 reg access
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IPG clock have to be enabled during AC'97 CODEC register
access in fsl_ssi driver.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c7647e0..9c46c7d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1127,10 +1127,17 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	struct regmap *regs = fsl_ac97_data->regs;
 	unsigned int lreg;
 	unsigned int lval;
+	int ret;
 
 	if (reg > 0x7f)
 		return;
 
+	ret = clk_prepare_enable(fsl_ac97_data->clk);
+	if (ret) {
+		pr_err("ac97 write clk_prepare_enable failed: %d\n",
+			ret);
+		return;
+	}
 
 	lreg = reg <<  12;
 	regmap_write(regs, CCSR_SSI_SACADD, lreg);
@@ -1141,6 +1148,8 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	regmap_update_bits(regs, CCSR_SSI_SACNT, CCSR_SSI_SACNT_RDWR_MASK,
 			CCSR_SSI_SACNT_WR);
 	udelay(100);
+
+	clk_disable_unprepare(fsl_ac97_data->clk);
 }
 
 static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
@@ -1151,6 +1160,14 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 	unsigned short val = -1;
 	u32 reg_val;
 	unsigned int lreg;
+	int ret;
+
+	ret = clk_prepare_enable(fsl_ac97_data->clk);
+	if (ret) {
+		pr_err("ac97 read clk_prepare_enable failed: %d\n",
+			ret);
+		return -1;
+	}
 
 	lreg = (reg & 0x7f) <<  12;
 	regmap_write(regs, CCSR_SSI_SACADD, lreg);
@@ -1162,6 +1179,8 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 	regmap_read(regs, CCSR_SSI_SACDAT, &reg_val);
 	val = (reg_val >> 4) & 0xffff;
 
+	clk_disable_unprepare(fsl_ac97_data->clk);
+
 	return val;
 }
 
