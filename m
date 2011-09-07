Return-Path: <yong.zhang0@gmail.com>
From: Yong Zhang <yong.zhang0@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 60/62] sound: irq: Remove IRQF_DISABLED
Date: Wed,  7 Sep 2011 16:10:57 +0800
Message-Id: <1315383059-3673-61-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
Cc: alsa-devel@alsa-project.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>,
	cbe-oss-dev@lists.ozlabs.org, Wan ZongShun <mcuos.com@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Yong Zhang <yong.zhang0@gmail.com>, tglx@linutronix.de,
	mingo@elte.hu, linux-arm-kernel@lists.infradead.org,
	Eric Miao <eric.y.miao@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Geoff Levand <geoff@infradead.org>,
	Paul Mundt <lethal@linux-sh.org>, Simon Horman <simon@horms.net>,
	Joe Perches <joe@perches.com>, Jarkko Nikula <jhnikula@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This flag is a NOOP and can be removed now.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 include/sound/initval.h            |    2 +-
 sound/arm/aaci.c                   |    2 +-
 sound/arm/pxa2xx-ac97-lib.c        |    2 +-
 sound/drivers/ml403-ac97cr.c       |    4 ++--
 sound/drivers/mpu401/mpu401.c      |    3 +--
 sound/drivers/mtpav.c              |    2 +-
 sound/drivers/serial-u16550.c      |    2 +-
 sound/isa/ad1816a/ad1816a.c        |    2 +-
 sound/isa/ad1816a/ad1816a_lib.c    |    2 +-
 sound/isa/als100.c                 |    2 +-
 sound/isa/azt2320.c                |    2 +-
 sound/isa/cmi8330.c                |    2 +-
 sound/isa/cs423x/cs4231.c          |    2 +-
 sound/isa/cs423x/cs4236.c          |    2 +-
 sound/isa/es1688/es1688.c          |    2 +-
 sound/isa/es1688/es1688_lib.c      |    2 +-
 sound/isa/es18xx.c                 |    2 +-
 sound/isa/galaxy/galaxy.c          |    2 +-
 sound/isa/gus/gus_main.c           |    2 +-
 sound/isa/gus/gusextreme.c         |    2 +-
 sound/isa/gus/gusmax.c             |    2 +-
 sound/isa/gus/interwave.c          |    2 +-
 sound/isa/msnd/msnd_pinnacle.c     |    2 +-
 sound/isa/opl3sa2.c                |    2 +-
 sound/isa/opti9xx/miro.c           |    2 +-
 sound/isa/opti9xx/opti92x-ad1848.c |    4 ++--
 sound/isa/sb/jazz16.c              |    2 +-
 sound/isa/sb/sb_common.c           |    2 +-
 sound/isa/sc6000.c                 |    2 +-
 sound/isa/sscape.c                 |    2 +-
 sound/isa/wavefront/wavefront.c    |    4 ++--
 sound/isa/wss/wss_lib.c            |    2 +-
 sound/mips/au1x00.c                |    4 ++--
 sound/pci/sis7019.c                |    4 ++--
 sound/ppc/snd_ps3.c                |    2 +-
 sound/soc/codecs/tlv320dac33.c     |    2 +-
 sound/soc/nuc900/nuc900-pcm.c      |    2 +-
 sound/soc/samsung/ac97.c           |    2 +-
 sound/soc/sh/fsi.c                 |    2 +-
 sound/soc/txx9/txx9aclc-ac97.c     |    2 +-
 sound/sparc/amd7930.c              |    2 +-
 41 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/include/sound/initval.h b/include/sound/initval.h
index 1daa6df..f99a0d2 100644
--- a/include/sound/initval.h
+++ b/include/sound/initval.h
@@ -62,7 +62,7 @@ static int snd_legacy_find_free_irq(int *irq_table)
 {
 	while (*irq_table != -1) {
 		if (!request_irq(*irq_table, snd_legacy_empty_irq_handler,
-				 IRQF_DISABLED | IRQF_PROBE_SHARED, "ALSA Test IRQ",
+				 IRQF_PROBE_SHARED, "ALSA Test IRQ",
 				 (void *) irq_table)) {
 			free_irq(*irq_table, (void *) irq_table);
 			return *irq_table;
diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index d0cead3..e518d38 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -443,7 +443,7 @@ static int aaci_pcm_open(struct snd_pcm_substream *substream)
 	mutex_lock(&aaci->irq_lock);
 	if (!aaci->users++) {
 		ret = request_irq(aaci->dev->irq[0], aaci_irq,
-			   IRQF_SHARED | IRQF_DISABLED, DRIVER_NAME, aaci);
+			   IRQF_SHARED, DRIVER_NAME, aaci);
 		if (ret != 0)
 			aaci->users--;
 	}
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 88eec38..8ad6535 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -359,7 +359,7 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 	if (ret)
 		goto err_clk2;
 
-	ret = request_irq(IRQ_AC97, pxa2xx_ac97_irq, IRQF_DISABLED, "AC97", NULL);
+	ret = request_irq(IRQ_AC97, pxa2xx_ac97_irq, 0, "AC97", NULL);
 	if (ret < 0)
 		goto err_irq;
 
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 5cfcb90..2c7a763 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1153,7 +1153,7 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 		   "0x%x done\n", (unsigned int)ml403_ac97cr->port);
 	/* get irq */
 	irq = platform_get_irq(pfdev, 0);
-	if (request_irq(irq, snd_ml403_ac97cr_irq, IRQF_DISABLED,
+	if (request_irq(irq, snd_ml403_ac97cr_irq, 0,
 			dev_name(&pfdev->dev), (void *)ml403_ac97cr)) {
 		snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
 			   "unable to grab IRQ %d\n",
@@ -1166,7 +1166,7 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 		   "request (playback) irq %d done\n",
 		   ml403_ac97cr->irq);
 	irq = platform_get_irq(pfdev, 1);
-	if (request_irq(irq, snd_ml403_ac97cr_irq, IRQF_DISABLED,
+	if (request_irq(irq, snd_ml403_ac97cr_irq, 0,
 			dev_name(&pfdev->dev), (void *)ml403_ac97cr)) {
 		snd_printk(KERN_ERR SND_ML403_AC97CR_DRIVER ": "
 			   "unable to grab IRQ %d\n",
diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index a797c1f..3ba8a43 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -86,8 +86,7 @@ static int snd_mpu401_create(int dev, struct snd_card **rcard)
 	}
 
 	err = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401, port[dev], 0,
-				  irq[dev], irq[dev] >= 0, IRQF_DISABLED,
-				  NULL);
+				  irq[dev], irq[dev] >= 0, 0, NULL);
 	if (err < 0) {
 		printk(KERN_ERR "MPU401 not detected at 0x%lx\n", port[dev]);
 		goto _err;
diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index 5c426df..1eef4cc 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -589,7 +589,7 @@ static int __devinit snd_mtpav_get_ISA(struct mtpav * mcard)
 		return -EBUSY;
 	}
 	mcard->port = port;
-	if (request_irq(irq, snd_mtpav_irqh, IRQF_DISABLED, "MOTU MTPAV", mcard)) {
+	if (request_irq(irq, snd_mtpav_irqh, 0, "MOTU MTPAV", mcard)) {
 		snd_printk(KERN_ERR "MTVAP IRQ %d busy\n", irq);
 		return -EBUSY;
 	}
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index a25fb7b..fc1d822 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -816,7 +816,7 @@ static int __devinit snd_uart16550_create(struct snd_card *card,
 
 	if (irq >= 0 && irq != SNDRV_AUTO_IRQ) {
 		if (request_irq(irq, snd_uart16550_interrupt,
-				IRQF_DISABLED, "Serial MIDI", uart)) {
+				0, "Serial MIDI", uart)) {
 			snd_printk(KERN_WARNING
 				   "irq %d busy. Using Polling.\n", irq);
 		} else {
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index fc8d1b6..6691880 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -204,7 +204,7 @@ static int __devinit snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard
 
 	if (mpu_port[dev] > 0) {
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
-					mpu_port[dev], 0, mpu_irq[dev], true, IRQF_DISABLED,
+					mpu_port[dev], 0, mpu_irq[dev], true, 0,
 					NULL) < 0)
 			printk(KERN_ERR PFX "no MPU-401 device at 0x%lx.\n", mpu_port[dev]);
 	}
diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index 05aef8b..177eed3 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -595,7 +595,7 @@ int __devinit snd_ad1816a_create(struct snd_card *card,
 		snd_ad1816a_free(chip);
 		return -EBUSY;
 	}
-	if (request_irq(irq, snd_ad1816a_interrupt, IRQF_DISABLED, "AD1816A", (void *) chip)) {
+	if (request_irq(irq, snd_ad1816a_interrupt, 0, "AD1816A", (void *) chip)) {
 		snd_printk(KERN_ERR "ad1816a: can't grab IRQ %d\n", irq);
 		snd_ad1816a_free(chip);
 		return -EBUSY;
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index e59c5f5..f3de6b2 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -256,7 +256,7 @@ static int __devinit snd_card_als100_probe(int dev,
 					mpu_type,
 					mpu_port[dev], 0, 
 					mpu_irq[dev],
-					mpu_irq[dev] >= 0, IRQF_DISABLED,
+					mpu_irq[dev] >= 0, 0,
 					NULL) < 0)
 			snd_printk(KERN_ERR PFX "no MPU-401 device at 0x%lx\n", mpu_port[dev]);
 	}
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index f1936c7..d65d941 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -234,7 +234,7 @@ static int __devinit snd_card_azt2320_probe(int dev,
 	if (mpu_port[dev] > 0 && mpu_port[dev] != SNDRV_AUTO_PORT) {
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_AZT2320,
 				mpu_port[dev], 0,
-				mpu_irq[dev], true, IRQF_DISABLED,
+				mpu_irq[dev], true, 0,
 				NULL) < 0)
 			snd_printk(KERN_ERR PFX "no MPU-401 device at 0x%lx\n", mpu_port[dev]);
 	}
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index 87741fd..a7288c7 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -597,7 +597,7 @@ static int __devinit snd_cmi8330_probe(struct snd_card *card, int dev)
 	if (mpuport[dev] != SNDRV_AUTO_PORT) {
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
 					mpuport[dev], 0, mpuirq[dev],
-					true, IRQF_DISABLED, NULL) < 0)
+					true, 0, NULL) < 0)
 			printk(KERN_ERR PFX "no MPU-401 device at 0x%lx.\n",
 				mpuport[dev]);
 	}
diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index 2f5174a..defe59e 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -131,7 +131,7 @@ static int __devinit snd_cs4231_probe(struct device *dev, unsigned int n)
 			mpu_irq[n] = -1;
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_CS4232,
 					mpu_port[n], 0, mpu_irq[n],
-					mpu_irq[n] >= 0, IRQF_DISABLED,
+					mpu_irq[n] >= 0, 0,
 					NULL) < 0)
 			dev_warn(dev, "MPU401 not detected\n");
 	}
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index ffa42f3..88fb603 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -450,7 +450,7 @@ static int __devinit snd_cs423x_probe(struct snd_card *card, int dev)
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_CS4232,
 					mpu_port[dev], 0,
 					mpu_irq[dev],
-					mpu_irq[dev] >= 0, IRQF_DISABLED, NULL) < 0)
+					mpu_irq[dev] >= 0, 0, NULL) < 0)
 			printk(KERN_WARNING IDENT ": MPU401 not detected\n");
 	}
 
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index 9ebe7d9..dc5329b 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -174,7 +174,7 @@ static int __devinit snd_es1688_probe(struct snd_card *card, unsigned int n)
 			chip->mpu_port > 0) {
 		error = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688,
 				chip->mpu_port, 0,
-				mpu_irq[n], true, IRQF_DISABLED, NULL);
+				mpu_irq[n], true, 0, NULL);
 		if (error < 0)
 			return error;
 	}
diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index 0767620..d3eab6f 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -661,7 +661,7 @@ int snd_es1688_create(struct snd_card *card,
 		snd_printk(KERN_ERR "es1688: can't grab port 0x%lx\n", port + 4);
 		return -EBUSY;
 	}
-	if (request_irq(irq, snd_es1688_interrupt, IRQF_DISABLED, "ES1688", (void *) chip)) {
+	if (request_irq(irq, snd_es1688_interrupt, 0, "ES1688", (void *) chip)) {
 		snd_printk(KERN_ERR "es1688: can't grab IRQ %d\n", irq);
 		return -EBUSY;
 	}
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 1d1c329..8080700 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1805,7 +1805,7 @@ static int __devinit snd_es18xx_new_device(struct snd_card *card,
 		return -EBUSY;
 	}
 
-	if (request_irq(irq, snd_es18xx_interrupt, IRQF_DISABLED, "ES18xx",
+	if (request_irq(irq, snd_es18xx_interrupt, 0, "ES18xx",
 			(void *) card)) {
 		snd_es18xx_free(card);
 		snd_printk(KERN_ERR PFX "unable to grap IRQ %d\n", irq);
diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index d65f274..77d775a 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -586,7 +586,7 @@ static int __devinit snd_galaxy_probe(struct device *dev, unsigned int n)
 	if (mpu_port[n] >= 0) {
 		err = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
 					  mpu_port[n], 0, mpu_irq[n],
-					  true, IRQF_DISABLED, NULL);
+					  true, 0, NULL);
 		if (err < 0)
 			goto error;
 	}
diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index 12eb98f..3167e5a 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -180,7 +180,7 @@ int snd_gus_create(struct snd_card *card,
 		snd_gus_free(gus);
 		return -EBUSY;
 	}
-	if (irq >= 0 && request_irq(irq, snd_gus_interrupt, IRQF_DISABLED, "GUS GF1", (void *) gus)) {
+	if (irq >= 0 && request_irq(irq, snd_gus_interrupt, 0, "GUS GF1", (void *) gus)) {
 		snd_printk(KERN_ERR "gus: can't grab irq %d\n", irq);
 		snd_gus_free(gus);
 		return -EBUSY;
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index 42158ed..3c756b2 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -318,7 +318,7 @@ static int __devinit snd_gusextreme_probe(struct device *dev, unsigned int n)
 	if (es1688->mpu_port >= 0x300) {
 		error = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688,
 				es1688->mpu_port, 0,
-				mpu_irq[n], true, IRQF_DISABLED, NULL);
+				mpu_irq[n], true, 0, NULL);
 		if (error < 0)
 			goto out;
 	}
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index 3e4a58b..c43faa0 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -291,7 +291,7 @@ static int __devinit snd_gusmax_probe(struct device *pdev, unsigned int dev)
 		goto _err;
 	}
 
-	if (request_irq(xirq, snd_gusmax_interrupt, IRQF_DISABLED, "GUS MAX", (void *)maxcard)) {
+	if (request_irq(xirq, snd_gusmax_interrupt, 0, "GUS MAX", (void *)maxcard)) {
 		snd_printk(KERN_ERR PFX "unable to grab IRQ %d\n", xirq);
 		err = -EBUSY;
 		goto _err;
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index c7b80e4..5f869a3 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -684,7 +684,7 @@ static int __devinit snd_interwave_probe(struct snd_card *card, int dev)
 	if ((err = snd_gus_initialize(gus)) < 0)
 		return err;
 
-	if (request_irq(xirq, snd_interwave_interrupt, IRQF_DISABLED,
+	if (request_irq(xirq, snd_interwave_interrupt, 0,
 			"InterWave", iwcard)) {
 		snd_printk(KERN_ERR PFX "unable to grab IRQ %d\n", xirq);
 		return -EBUSY;
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index ec53ee8..8c77b38 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -600,7 +600,7 @@ static int __devinit snd_msnd_attach(struct snd_card *card)
 					  mpu_io[0],
 					  MPU401_MODE_INPUT |
 					  MPU401_MODE_OUTPUT,
-					  mpu_irq[0], true, IRQF_DISABLED,
+					  mpu_irq[0], true, 0,
 					  &chip->rmidi);
 		if (err < 0) {
 			printk(KERN_ERR LOGNAME
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index 859f7cb..581ce1a 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -667,7 +667,7 @@ static int __devinit snd_opl3sa2_probe(struct snd_card *card, int dev)
 	err = snd_opl3sa2_detect(card);
 	if (err < 0)
 		return err;
-	err = request_irq(xirq, snd_opl3sa2_interrupt, IRQF_DISABLED,
+	err = request_irq(xirq, snd_opl3sa2_interrupt, 0,
 			  "OPL3-SA2", card);
 	if (err) {
 		snd_printk(KERN_ERR PFX "can't grab IRQ %d\n", xirq);
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 05334db..80aa0e1 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1378,7 +1378,7 @@ static int __devinit snd_miro_probe(struct snd_card *card)
 	else {
 		error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
 				mpu_port, 0, miro->mpu_irq, true,
-				IRQF_DISABLED, &rmidi);
+				0, &rmidi);
 		if (error < 0)
 			snd_printk(KERN_WARNING "no MPU-401 device at 0x%lx?\n",
 				   mpu_port);
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index a222a16..f2c3a55 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -892,7 +892,7 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 #endif
 #ifdef OPTi93X
 	error = request_irq(irq, snd_opti93x_interrupt,
-			    IRQF_DISABLED, DEV_NAME" - WSS", chip);
+			    0, DEV_NAME" - WSS", chip);
 	if (error < 0) {
 		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", irq);
 		return error;
@@ -914,7 +914,7 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 		rmidi = NULL;
 	else {
 		error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
-			mpu_port, 0, mpu_irq, true, IRQF_DISABLED, &rmidi);
+			mpu_port, 0, mpu_irq, true, 0, &rmidi);
 		if (error)
 			snd_printk(KERN_WARNING "no MPU-401 device at 0x%lx?\n",
 				   mpu_port);
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index c0dc829..3236ece 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -322,7 +322,7 @@ static int __devinit snd_jazz16_probe(struct device *devptr, unsigned int dev)
 					MPU401_HW_MPU401,
 					mpu_port[dev], 0,
 					mpu_irq[dev],
-					mpu_irq[dev] >= 0, IRQF_DISABLED,
+					mpu_irq[dev] >= 0, 0,
 					NULL) < 0)
 			snd_printk(KERN_ERR "no MPU-401 device at 0x%lx\n",
 					mpu_port[dev]);
diff --git a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
index eae6c1c..d2e1921 100644
--- a/sound/isa/sb/sb_common.c
+++ b/sound/isa/sb/sb_common.c
@@ -240,7 +240,7 @@ int snd_sbdsp_create(struct snd_card *card,
 	if (request_irq(irq, irq_handler,
 			(hardware == SB_HW_ALS4000 ||
 			 hardware == SB_HW_CS5530) ?
-			IRQF_SHARED : IRQF_DISABLED,
+			IRQF_SHARED : 0,
 			"SoundBlaster", (void *) chip)) {
 		snd_printk(KERN_ERR "sb: can't grab irq %d\n", irq);
 		snd_sbdsp_free(chip);
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index cb3195c..1859eb0 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -658,7 +658,7 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 		if (snd_mpu401_uart_new(card, 0,
 					MPU401_HW_MPU401,
 					mpu_port[dev], 0,
-					mpu_irq[dev], true, IRQF_DISABLED,
+					mpu_irq[dev], true, 0,
 					NULL) < 0)
 			snd_printk(KERN_ERR "no MPU-401 device at 0x%lx ?\n",
 					mpu_port[dev]);
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 407d364..fb9b03a 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -826,7 +826,7 @@ static int __devinit create_mpu401(struct snd_card *card, int devnum,
 
 	err = snd_mpu401_uart_new(card, devnum, MPU401_HW_MPU401, port,
 				  MPU401_INFO_INTEGRATED, irq, true,
-				  IRQF_DISABLED, &rawmidi);
+				  0, &rawmidi);
 	if (err == 0) {
 		struct snd_mpu401 *mpu = rawmidi->private_data;
 		mpu->open_input = mpu401_open;
diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index 5669e49..b7c969e 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -418,7 +418,7 @@ snd_wavefront_probe (struct snd_card *card, int dev)
 		return -EBUSY;
 	}
 	if (request_irq(ics2115_irq[dev], snd_wavefront_ics2115_interrupt,
-			IRQF_DISABLED, "ICS2115", acard)) {
+			0, "ICS2115", acard)) {
 		snd_printk(KERN_ERR "unable to use ICS2115 IRQ %d\n", ics2115_irq[dev]);
 		return -EBUSY;
 	}
@@ -449,7 +449,7 @@ snd_wavefront_probe (struct snd_card *card, int dev)
 	if (cs4232_mpu_port[dev] > 0 && cs4232_mpu_port[dev] != SNDRV_AUTO_PORT) {
 		err = snd_mpu401_uart_new(card, midi_dev, MPU401_HW_CS4232,
 					  cs4232_mpu_port[dev], 0,
-					  cs4232_mpu_irq[dev], true, IRQF_DISABLED,
+					  cs4232_mpu_irq[dev], true, 0,
 					  NULL);
 		if (err < 0) {
 			snd_printk (KERN_ERR "can't allocate CS4232 MPU-401 device\n");
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 2a42cc3..7277c5b 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1833,7 +1833,7 @@ int snd_wss_create(struct snd_card *card,
 	}
 	chip->cport = cport;
 	if (!(hwshare & WSS_HWSHARE_IRQ))
-		if (request_irq(irq, snd_wss_interrupt, IRQF_DISABLED,
+		if (request_irq(irq, snd_wss_interrupt, 0,
 				"WSS", (void *) chip)) {
 			snd_printk(KERN_ERR "wss: can't grab IRQ %d\n", irq);
 			snd_wss_free(chip);
diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 446cf97..7567ebd 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -465,13 +465,13 @@ snd_au1000_pcm_new(struct snd_au1000 *au1000)
 
 	flags = claim_dma_lock();
 	if ((au1000->stream[PLAYBACK]->dma = request_au1000_dma(DMA_ID_AC97C_TX,
-			"AC97 TX", au1000_dma_interrupt, IRQF_DISABLED,
+			"AC97 TX", au1000_dma_interrupt, 0,
 			au1000->stream[PLAYBACK])) < 0) {
 		release_dma_lock(flags);
 		return -EBUSY;
 	}
 	if ((au1000->stream[CAPTURE]->dma = request_au1000_dma(DMA_ID_AC97C_RX,
-			"AC97 RX", au1000_dma_interrupt, IRQF_DISABLED,
+			"AC97 RX", au1000_dma_interrupt, 0,
 			au1000->stream[CAPTURE])) < 0){
 		release_dma_lock(flags);
 		return -EBUSY;
diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index bcf6152..5ffb20b 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1234,7 +1234,7 @@ static int sis_resume(struct pci_dev *pci)
 		goto error;
 	}
 
-	if (request_irq(pci->irq, sis_interrupt, IRQF_DISABLED|IRQF_SHARED,
+	if (request_irq(pci->irq, sis_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, sis)) {
 		printk(KERN_ERR "sis7019: unable to regain IRQ %d\n", pci->irq);
 		goto error;
@@ -1340,7 +1340,7 @@ static int __devinit sis_chip_create(struct snd_card *card,
 	if (rc)
 		goto error_out_cleanup;
 
-	if (request_irq(pci->irq, sis_interrupt, IRQF_DISABLED|IRQF_SHARED,
+	if (request_irq(pci->irq, sis_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, sis)) {
 		printk(KERN_ERR "unable to allocate irq %d\n", sis->irq);
 		goto error_out_cleanup;
diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index bc823a5..775bd95 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -845,7 +845,7 @@ static int __devinit snd_ps3_allocate_irq(void)
 		return ret;
 	}
 
-	ret = request_irq(the_card.irq_no, snd_ps3_interrupt, IRQF_DISABLED,
+	ret = request_irq(the_card.irq_no, snd_ps3_interrupt, 0,
 			  SND_PS3_DRIVER_NAME, &the_card);
 	if (ret) {
 		pr_info("%s: request_irq failed (%d)\n", __func__, ret);
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index faa5e9f..243d177 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1431,7 +1431,7 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 	/* Check if the IRQ number is valid and request it */
 	if (dac33->irq >= 0) {
 		ret = request_irq(dac33->irq, dac33_interrupt_handler,
-				  IRQF_TRIGGER_RISING | IRQF_DISABLED,
+				  IRQF_TRIGGER_RISING,
 				  codec->name, codec);
 		if (ret < 0) {
 			dev_err(codec->dev, "Could not request IRQ%d (%d)\n",
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index d589ef1..a6b7b7f 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -268,7 +268,7 @@ static int nuc900_dma_open(struct snd_pcm_substream *substream)
 	nuc900_audio = nuc900_ac97_data;
 
 	if (request_irq(nuc900_audio->irq_num, nuc900_dma_interrupt,
-			IRQF_DISABLED, "nuc900-dma", substream))
+			0, "nuc900-dma", substream))
 		return -EBUSY;
 
 	runtime->private_data = nuc900_audio;
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index f97110e..884c8a1 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -444,7 +444,7 @@ static __devinit int s3c_ac97_probe(struct platform_device *pdev)
 	}
 
 	ret = request_irq(irq_res->start, s3c_ac97_irq,
-					IRQF_DISABLED, "AC97", NULL);
+					0, "AC97", NULL);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "ac97: interrupt request failed.\n");
 		goto err4;
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 8e112cc..1493ebf 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1285,7 +1285,7 @@ static int fsi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	dev_set_drvdata(&pdev->dev, master);
 
-	ret = request_irq(irq, &fsi_interrupt, IRQF_DISABLED,
+	ret = request_irq(irq, &fsi_interrupt, 0,
 			  id_entry->name, master);
 	if (ret) {
 		dev_err(&pdev->dev, "irq request err\n");
diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 743d07b..a4e3f55 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -201,7 +201,7 @@ static int __devinit txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 	if (!drvdata->base)
 		return -EBUSY;
 	err = devm_request_irq(&pdev->dev, irq, txx9aclc_ac97_irq,
-			       IRQF_DISABLED, dev_name(&pdev->dev), drvdata);
+			       0, dev_name(&pdev->dev), drvdata);
 	if (err < 0)
 		return err;
 
diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index ad7d4d7..f036776 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -962,7 +962,7 @@ static int __devinit snd_amd7930_create(struct snd_card *card,
 	amd7930_idle(amd);
 
 	if (request_irq(irq, snd_amd7930_interrupt,
-			IRQF_DISABLED | IRQF_SHARED, "amd7930", amd)) {
+			IRQF_SHARED, "amd7930", amd)) {
 		snd_printk(KERN_ERR "amd7930-%d: Unable to grab IRQ %d\n",
 			   dev, irq);
 		snd_amd7930_free(amd);
-- 
1.7.4.1
