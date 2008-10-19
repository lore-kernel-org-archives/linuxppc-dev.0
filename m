Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 71B65DDDD4
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 00:49:15 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so216050yxg.39
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 06:49:13 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by terra with esmtp (Exim 4.69) (envelope-from <jonsmirl@gmail.com>)
	id 1KrYed-0006v8-Jf
	for linuxppc-dev@ozlabs.org; Sun, 19 Oct 2008 09:49:11 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Fix some minor errors in mpc5200 psc i2s driver
To: linuxppc-dev@ozlabs.org
Date: Sun, 19 Oct 2008 09:49:11 -0400
Message-ID: <20081019134911.26576.13218.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix missing unsigned for irqsave flags in psc i2s driver
Make attribute visiblity static
Collect all sysfs errors before checking status

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 8692329..809c5c4 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -277,7 +277,7 @@ static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct mpc52xx_psc __iomem *regs = psc_i2s->psc_regs;
 	u16 imr;
 	u8 psc_cmd;
-	long flags;
+	unsigned long flags;
 
 	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
 		s = &psc_i2s->capture;
@@ -699,9 +699,9 @@ static ssize_t psc_i2s_stat_store(struct device *dev,
 	return count;
 }
 
-DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
-DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
-DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
+static DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
+static DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
+static DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
 
 /* ---------------------------------------------------------------------
  * OF platform bus binding code:
@@ -819,8 +819,8 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
 
 	/* Register the SYSFS files */
 	rc = device_create_file(psc_i2s->dev, &dev_attr_status);
-	rc = device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
-	rc = device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
+	rc |= device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
+	rc |= device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
 	if (rc)
 		dev_info(psc_i2s->dev, "error creating sysfs files\n");
 
