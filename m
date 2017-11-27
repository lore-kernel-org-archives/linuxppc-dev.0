Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylwsj0thPzDqqX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 05:52:57 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: serialize AC'97 register access operations"
 to the asoc tree
In-Reply-To: <9010cdad-4b05-d456-bf73-24cc48e38d69@maciej.szmigiero.name>
Message-Id: <E1eJOWK-00072K-EV@debutante>
Date: Mon, 27 Nov 2017 18:52:44 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: serialize AC'97 register access operations

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

>From b880b8056b31288323745a13930bc45cf4c86e9d Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Mon, 20 Nov 2017 23:16:07 +0100
Subject: [PATCH] ASoC: fsl_ssi: serialize AC'97 register access operations

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c3a83ed0297e..424bafaf51ef 100644
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
@@ -1260,11 +1263,13 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
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
@@ -1278,6 +1283,9 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	udelay(100);
 
 	clk_disable_unprepare(fsl_ac97_data->clk);
+
+ret_unlock:
+	mutex_unlock(&fsl_ac97_data->ac97_reg_lock);
 }
 
 static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
@@ -1285,16 +1293,18 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
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
@@ -1309,6 +1319,8 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 
 	clk_disable_unprepare(fsl_ac97_data->clk);
 
+ret_unlock:
+	mutex_unlock(&fsl_ac97_data->ac97_reg_lock);
 	return val;
 }
 
@@ -1569,6 +1581,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	if (fsl_ssi_is_ac97(ssi_private)) {
+		mutex_init(&ssi_private->ac97_reg_lock);
 		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
 		if (ret) {
 			dev_err(&pdev->dev, "could not set AC'97 ops\n");
@@ -1663,6 +1676,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		snd_soc_set_ac97_ops(NULL);
 
 error_ac97_ops:
+	if (fsl_ssi_is_ac97(ssi_private))
+		mutex_destroy(&ssi_private->ac97_reg_lock);
+
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
@@ -1681,8 +1697,10 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
-	if (fsl_ssi_is_ac97(ssi_private))
+	if (fsl_ssi_is_ac97(ssi_private)) {
 		snd_soc_set_ac97_ops(NULL);
+		mutex_destroy(&ssi_private->ac97_reg_lock);
+	}
 
 	return 0;
 }
-- 
2.15.0
