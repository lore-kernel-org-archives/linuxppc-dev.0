Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id 4C75BB7D0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 19:34:46 +1100 (EST)
Received: by mail-px0-f177.google.com with SMTP id 7so1163330pxi.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 00:34:46 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 5/6] ASoC/mpc5200: fix enable/disable of AC97 slots
To: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com
Date: Sat, 07 Nov 2009 01:34:43 -0700
Message-ID: <20091107083436.18908.42234.stgit@angua>
In-Reply-To: <20091107081631.18908.82921.stgit@angua>
References: <20091107081631.18908.82921.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MPC5200 AC97 driver is disabling the slots when a stop
trigger is received, but not reenabling them if the stream
is started again without processing the hw_params again.

This patch fixes the problem by caching the slot enable bit
settings calculated at hw_params time so that they can be
reapplied every time the start trigger is received.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.h      |    4 ++++
 sound/soc/fsl/mpc5200_psc_ac97.c |   39 ++++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index 956d6a5..22208b3 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -16,6 +16,7 @@
  * @period_end:		physical address of end of DMA region
  * @period_next_pt:	physical address of next DMA buffer to enqueue
  * @period_bytes:	size of DMA period in bytes
+ * @ac97_slot_bits:	Enable bits for turning on the correct AC97 slot
  */
 struct psc_dma_stream {
 	struct snd_pcm_runtime *runtime;
@@ -28,6 +29,9 @@ struct psc_dma_stream {
 	int period_current;
 	int period_bytes;
 	int period_count;
+
+	/* AC97 state */
+	u32 ac97_slot_bits;
 };
 
 /**
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index c4ae3e0..3dbc7f7 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -130,6 +130,7 @@ static int psc_ac97_hw_analog_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *cpu_dai)
 {
 	struct psc_dma *psc_dma = cpu_dai->private_data;
+	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
 
 	dev_dbg(psc_dma->dev, "%s(substream=%p) p_size=%i p_bytes=%i"
 		" periods=%i buffer_size=%i  buffer_bytes=%i channels=%i"
@@ -140,20 +141,10 @@ static int psc_ac97_hw_analog_params(struct snd_pcm_substream *substream,
 		params_channels(params), params_rate(params),
 		params_format(params));
 
-
-	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		if (params_channels(params) == 1)
-			psc_dma->slots |= 0x00000100;
-		else
-			psc_dma->slots |= 0x00000300;
-	} else {
-		if (params_channels(params) == 1)
-			psc_dma->slots |= 0x01000000;
-		else
-			psc_dma->slots |= 0x03000000;
-	}
-	out_be32(&psc_dma->psc_regs->ac97_slots, psc_dma->slots);
-
+	/* Determine the set of enable bits to turn on */
+	s->ac97_slot_bits = (params_channels(params) == 1) ? 0x100 : 0x300;
+	if (substream->pstr->stream != SNDRV_PCM_STREAM_CAPTURE)
+		s->ac97_slot_bits <<= 16;
 	return 0;
 }
 
@@ -163,6 +154,8 @@ static int psc_ac97_hw_digital_params(struct snd_pcm_substream *substream,
 {
 	struct psc_dma *psc_dma = cpu_dai->private_data;
 
+	dev_dbg(psc_dma->dev, "%s(substream=%p)\n", __func__, substream);
+
 	if (params_channels(params) == 1)
 		out_be32(&psc_dma->psc_regs->ac97_slots, 0x01000000);
 	else
@@ -176,14 +169,24 @@ static int psc_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
 
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		dev_dbg(psc_dma->dev, "AC97 START: stream=%i\n",
+			substream->pstr->stream);
+
+		/* Set the slot enable bits */
+		psc_dma->slots |= s->ac97_slot_bits;
+		out_be32(&psc_dma->psc_regs->ac97_slots, psc_dma->slots);
+		break;
+
 	case SNDRV_PCM_TRIGGER_STOP:
-		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
-			psc_dma->slots &= 0xFFFF0000;
-		else
-			psc_dma->slots &= 0x0000FFFF;
+		dev_dbg(psc_dma->dev, "AC97 STOP: stream=%i\n",
+			substream->pstr->stream);
 
+		/* Clear the slot enable bits */
+		psc_dma->slots &= ~(s->ac97_slot_bits);
 		out_be32(&psc_dma->psc_regs->ac97_slots, psc_dma->slots);
 		break;
 	}
