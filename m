Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E8967B70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 03:57:29 +1000 (EST)
Received: from mail-px0-f182.google.com (mail-px0-f182.google.com
	[209.85.216.182]) by ozlabs.org (Postfix) with ESMTP id 2B26EDDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 03:57:28 +1000 (EST)
Received: by mail-px0-f182.google.com with SMTP id 12so1758140pxi.17
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Jul 2009 10:57:28 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] ASoC: add locking to mpc5200-psc-ac97 driver
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
Date: Thu, 02 Jul 2009 11:57:25 -0600
Message-ID: <20090702175725.15773.37291.stgit@localhost.localdomain>
In-Reply-To: <20090702175719.15773.58956.stgit@localhost.localdomain>
References: <20090702175719.15773.58956.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

AC97 bus register read/write hooks need to provide locking, but the
mpc5200-psc-ac97 driver does not.  This patch adds a mutex around
the register access routines.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c      |    1 +
 sound/soc/fsl/mpc5200_dma.h      |    1 +
 sound/soc/fsl/mpc5200_psc_ac97.c |   13 ++++++++++++-
 3 files changed, 14 insertions(+), 1 deletions(-)


diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index efec33a..f0a2d40 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -456,6 +456,7 @@ int mpc5200_audio_dma_create(struct of_device *op)
 		return -ENODEV;
 
 	spin_lock_init(&psc_dma->lock);
+	mutex_init(&psc_dma->mutex);
 	psc_dma->id = be32_to_cpu(*prop);
 	psc_dma->irq = irq;
 	psc_dma->psc_regs = regs;
diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index 2000803..8d396bb 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -55,6 +55,7 @@ struct psc_dma {
 	unsigned int irq;
 	struct device *dev;
 	spinlock_t lock;
+	struct mutex mutex;
 	u32 sicr;
 	uint sysclk;
 	int imr;
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 9b8503f..7eb5499 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -34,11 +34,14 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	int status;
 	unsigned int val;
 
+	mutex_lock(&psc_dma->mutex);
+
 	/* Wait for command send status zero = ready */
 	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
 				MPC52xx_PSC_SR_CMDSEND), 100, 0);
 	if (status == 0) {
 		pr_err("timeout on ac97 bus (rdy)\n");
+		mutex_unlock(&psc_dma->mutex);
 		return -ENODEV;
 	}
 
@@ -54,16 +57,19 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	if (status == 0) {
 		pr_err("timeout on ac97 read (val) %x\n",
 				in_be16(&psc_dma->psc_regs->sr_csr.status));
+		mutex_unlock(&psc_dma->mutex);
 		return -ENODEV;
 	}
 	/* Get the data */
 	val = in_be32(&psc_dma->psc_regs->ac97_data);
 	if (((val >> 24) & 0x7f) != reg) {
 		pr_err("reg echo error on ac97 read\n");
+		mutex_unlock(&psc_dma->mutex);
 		return -ENODEV;
 	}
 	val = (val >> 8) & 0xffff;
 
+	mutex_unlock(&psc_dma->mutex);
 	return (unsigned short) val;
 }
 
@@ -72,16 +78,21 @@ static void psc_ac97_write(struct snd_ac97 *ac97,
 {
 	int status;
 
+	mutex_lock(&psc_dma->mutex);
+
 	/* Wait for command status zero = ready */
 	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
 				MPC52xx_PSC_SR_CMDSEND), 100, 0);
 	if (status == 0) {
 		pr_err("timeout on ac97 bus (write)\n");
-		return;
+		goto out;
 	}
 	/* Write data */
 	out_be32(&psc_dma->psc_regs->ac97_cmd,
 			((reg & 0x7f) << 24) | (val << 8));
+
+ out:
+	mutex_unlock(&psc_dma->mutex);
 }
 
 static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
