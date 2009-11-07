Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191]) by ozlabs.org (Postfix) with ESMTP id 3A28AB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 19:33:58 +1100 (EST)
Received: by pzk29 with SMTP id 29so1161651pzk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 00:33:56 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/6] ASoC/mpc5200: Track DMA position by period number instead
	of bytes
To: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com
Date: Sat, 07 Nov 2009 01:33:53 -0700
Message-ID: <20091107083345.18908.96473.stgit@angua>
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

All DMA blocks are lined up to period boundaries, but the DMA
handling code tracks bytes instead.  This patch reworks the code
to track the period index into the DMA buffer instead of the
physical address pointer.  Doing so makes the code simpler and
easier to understand.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c |   28 +++++++++-------------------
 sound/soc/fsl/mpc5200_dma.h |    8 ++------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 6096d22..986d3c8 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -58,13 +58,11 @@ static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
 	/* Prepare and enqueue the next buffer descriptor */
 	bd = bcom_prepare_next_buffer(s->bcom_task);
 	bd->status = s->period_bytes;
-	bd->data[0] = s->period_next_pt;
+	bd->data[0] = s->runtime->dma_addr + (s->period_next * s->period_bytes);
 	bcom_submit_next_buffer(s->bcom_task, NULL);
 
 	/* Update for next period */
-	s->period_next_pt += s->period_bytes;
-	if (s->period_next_pt >= s->period_end)
-		s->period_next_pt = s->period_start;
+	s->period_next = (s->period_next + 1) % s->runtime->periods;
 }
 
 static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
@@ -79,7 +77,7 @@ static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
 			if (bcom_queue_full(s->bcom_task))
 				return;
 
-			s->appl_ptr += s->period_size;
+			s->appl_ptr += s->runtime->period_size;
 
 			psc_dma_bcom_enqueue_next_buffer(s);
 		}
@@ -91,7 +89,7 @@ static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
 		if (bcom_queue_full(s->bcom_task))
 			return;
 
-		s->appl_ptr += s->period_size;
+		s->appl_ptr += s->runtime->period_size;
 
 		psc_dma_bcom_enqueue_next_buffer(s);
 	}
@@ -108,9 +106,7 @@ static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *_psc_dma_stream)
 	while (bcom_buffer_done(s->bcom_task)) {
 		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
 
-		s->period_current_pt += s->period_bytes;
-		if (s->period_current_pt >= s->period_end)
-			s->period_current_pt = s->period_start;
+		s->period_current = (s->period_current+1) % s->runtime->periods;
 	}
 	psc_dma_bcom_enqueue_tx(s);
 	spin_unlock(&s->psc_dma->lock);
@@ -133,9 +129,7 @@ static irqreturn_t psc_dma_bcom_irq_rx(int irq, void *_psc_dma_stream)
 	while (bcom_buffer_done(s->bcom_task)) {
 		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
 
-		s->period_current_pt += s->period_bytes;
-		if (s->period_current_pt >= s->period_end)
-			s->period_current_pt = s->period_start;
+		s->period_current = (s->period_current+1) % s->runtime->periods;
 
 		psc_dma_bcom_enqueue_next_buffer(s);
 	}
@@ -185,12 +179,8 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 		s->period_bytes = frames_to_bytes(runtime,
 						  runtime->period_size);
-		s->period_start = virt_to_phys(runtime->dma_area);
-		s->period_end = s->period_start +
-				(s->period_bytes * runtime->periods);
-		s->period_next_pt = s->period_start;
-		s->period_current_pt = s->period_start;
-		s->period_size = runtime->period_size;
+		s->period_next = 0;
+		s->period_current = 0;
 		s->active = 1;
 
 		/* track appl_ptr so that we have a better chance of detecting
@@ -343,7 +333,7 @@ psc_dma_pointer(struct snd_pcm_substream *substream)
 	else
 		s = &psc_dma->playback;
 
-	count = s->period_current_pt - s->period_start;
+	count = s->period_current * s->period_bytes;
 
 	return bytes_to_frames(substream->runtime, count);
 }
diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index 8d396bb..529f7a0 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -13,7 +13,6 @@
  * @psc_dma:		pointer back to parent psc_dma data structure
  * @bcom_task:		bestcomm task structure
  * @irq:		irq number for bestcomm task
- * @period_start:	physical address of start of DMA region
  * @period_end:		physical address of end of DMA region
  * @period_next_pt:	physical address of next DMA buffer to enqueue
  * @period_bytes:	size of DMA period in bytes
@@ -27,12 +26,9 @@ struct psc_dma_stream {
 	struct bcom_task *bcom_task;
 	int irq;
 	struct snd_pcm_substream *stream;
-	dma_addr_t period_start;
-	dma_addr_t period_end;
-	dma_addr_t period_next_pt;
-	dma_addr_t period_current_pt;
+	int period_next;
+	int period_current;
 	int period_bytes;
-	int period_size;
 };
 
 /**
