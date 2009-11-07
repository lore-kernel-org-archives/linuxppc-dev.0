Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id 12FD2100A02
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 19:34:35 +1100 (EST)
Received: by pxi7 with SMTP id 7so1163330pxi.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 00:34:34 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 4/6] ASoC/mpc5200: add to_psc_dma_stream() helper
To: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com
Date: Sat, 07 Nov 2009 01:34:31 -0700
Message-ID: <20091107083423.18908.21177.stgit@angua>
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

Move the resolving of the psc_dma_stream pointer to a helper function
to reduce duplicate code

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c |    7 +------
 sound/soc/fsl/mpc5200_dma.h |    9 +++++++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 658e3fa..9c88e15 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -133,17 +133,12 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct psc_dma_stream *s;
+	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
 	u16 imr;
 	unsigned long flags;
 	int i;
 
-	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
-		s = &psc_dma->capture;
-	else
-		s = &psc_dma->playback;
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		dev_dbg(psc_dma->dev, "START: stream=%i fbits=%u ps=%u #p=%u\n",
diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index c6f29e4..956d6a5 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -68,6 +68,15 @@ struct psc_dma {
 	} stats;
 };
 
+/* Utility for retrieving psc_dma_stream structure from a substream */
+inline struct psc_dma_stream *
+to_psc_dma_stream(struct snd_pcm_substream *substream, struct psc_dma *psc_dma)
+{
+	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
+		return &psc_dma->capture;
+	return &psc_dma->playback;
+}
+
 int mpc5200_audio_dma_create(struct of_device *op);
 int mpc5200_audio_dma_destroy(struct of_device *op);
 
