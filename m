Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygk903PZjzDrMg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 09:36:34 +1100 (AEDT)
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 2/2] ASoC: fsl_ssi: serialize AC'97 register access operations
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <9010cdad-4b05-d456-bf73-24cc48e38d69@maciej.szmigiero.name>
Date: Mon, 20 Nov 2017 23:16:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

AC'97 register access operations (both read and write) on SSI use a one,
shared set of SSI registers for AC'97 register address and data.
This means that only one such access is possible at a time and so all these
operations need to be serialized.

Since an AC'97 register access operation in this driver takes 100us+ let's
use a mutex for this.

Use this opportunity to also change a default value returned from AC'97
register read function from -1 to 0, since that's what AC'97 specs require
to be returned when unknown / undefined registers are read.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a71bb8391f61..9dea1b16de82 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -38,6 +38,7 @@
 #include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
@@ -265,6 +266,8 @@ struct fsl_ssi_private {
 
 	u32 fifo_watermark;
 	u32 dma_maxburst;
+
+	struct mutex ac97_reg_lock;
 };
 
 /*
@@ -1262,11 +1265,13 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	if (reg > 0x7f)
 		return;
 
+	mutex_lock(&fsl_ac97_data->ac97_reg_lock);
+
 	ret = clk_prepare_enable(fsl_ac97_data->clk);
 	if (ret) {
 		pr_err("ac97 write clk_prepare_enable failed: %d\n",
 			ret);
-		return;
+		goto ret_unlock;
 	}
 
 	lreg = reg <<  12;
@@ -1280,6 +1285,9 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	udelay(100);
 
 	clk_disable_unprepare(fsl_ac97_data->clk);
+
+ret_unlock:
+	mutex_unlock(&fsl_ac97_data->ac97_reg_lock);
 }
 
 static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
@@ -1287,16 +1295,18 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 {
 	struct regmap *regs = fsl_ac97_data->regs;
 
-	unsigned short val = -1;
+	unsigned short val = 0;
 	u32 reg_val;
 	unsigned int lreg;
 	int ret;
 
+	mutex_lock(&fsl_ac97_data->ac97_reg_lock);
+
 	ret = clk_prepare_enable(fsl_ac97_data->clk);
 	if (ret) {
 		pr_err("ac97 read clk_prepare_enable failed: %d\n",
 			ret);
-		return -1;
+		goto ret_unlock;
 	}
 
 	lreg = (reg & 0x7f) <<  12;
@@ -1311,6 +1321,8 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 
 	clk_disable_unprepare(fsl_ac97_data->clk);
 
+ret_unlock:
+	mutex_unlock(&fsl_ac97_data->ac97_reg_lock);
 	return val;
 }
 
@@ -1571,6 +1583,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	if (fsl_ssi_is_ac97(ssi_private)) {
+		mutex_init(&ssi_private->ac97_reg_lock);
 		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
 		if (ret) {
 			dev_err(&pdev->dev, "could not set AC'97 ops\n");
@@ -1665,6 +1678,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		snd_soc_set_ac97_ops(NULL);
 
 error_ac97_ops:
+	if (fsl_ssi_is_ac97(ssi_private))
+		mutex_destroy(&ssi_private->ac97_reg_lock);
+
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
@@ -1683,8 +1699,10 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
-	if (fsl_ssi_is_ac97(ssi_private))
+	if (fsl_ssi_is_ac97(ssi_private)) {
 		snd_soc_set_ac97_ops(NULL);
+		mutex_destroy(&ssi_private->ac97_reg_lock);
+	}
 
 	return 0;
 }
