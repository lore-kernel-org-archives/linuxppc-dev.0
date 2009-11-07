Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191]) by ozlabs.org (Postfix) with ESMTP id 828621008B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 19:34:21 +1100 (EST)
Received: by mail-pz0-f191.google.com with SMTP id 29so1161651pzk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 00:34:21 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/6] ASoC/mpc5200: Improve printk debug output for trigger
To: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com
Date: Sat, 07 Nov 2009 01:34:18 -0700
Message-ID: <20091107083410.18908.86509.stgit@angua>
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

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c |   15 ++++++++++-----
 sound/soc/fsl/mpc5200_dma.h |    1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 4e47586..658e3fa 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -77,6 +77,7 @@ static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *_psc_dma_stream)
 		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
 
 		s->period_current = (s->period_current+1) % s->runtime->periods;
+		s->period_count++;
 
 		psc_dma_bcom_enqueue_next_buffer(s);
 	}
@@ -101,6 +102,7 @@ static irqreturn_t psc_dma_bcom_irq_rx(int irq, void *_psc_dma_stream)
 		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
 
 		s->period_current = (s->period_current+1) % s->runtime->periods;
+		s->period_count++;
 
 		psc_dma_bcom_enqueue_next_buffer(s);
 	}
@@ -142,17 +144,17 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	else
 		s = &psc_dma->playback;
 
-	dev_dbg(psc_dma->dev, "psc_dma_trigger(substream=%p, cmd=%i)"
-		" stream_id=%i\n",
-		substream, cmd, substream->pstr->stream);
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		dev_dbg(psc_dma->dev, "START: stream=%i fbits=%u ps=%u #p=%u\n",
+			substream->pstr->stream, runtime->frame_bits,
+			(int)runtime->period_size, runtime->periods);
 		s->period_bytes = frames_to_bytes(runtime,
 						  runtime->period_size);
 		s->period_next = 0;
 		s->period_current = 0;
 		s->active = 1;
+		s->period_count = 0;
 		s->runtime = runtime;
 
 		/* Fill up the bestcomm bd queue and enable DMA.
@@ -177,6 +179,8 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
+		dev_dbg(psc_dma->dev, "STOP: stream=%i periods_count=%i\n",
+			substream->pstr->stream, s->period_count);
 		s->active = 0;
 
 		spin_lock_irqsave(&psc_dma->lock, flags);
@@ -190,7 +194,8 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		break;
 
 	default:
-		dev_dbg(psc_dma->dev, "invalid command\n");
+		dev_dbg(psc_dma->dev, "unhandled trigger: stream=%i cmd=%i\n",
+			substream->pstr->stream, cmd);
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index d9c741b..c6f29e4 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -27,6 +27,7 @@ struct psc_dma_stream {
 	int period_next;
 	int period_current;
 	int period_bytes;
+	int period_count;
 };
 
 /**
