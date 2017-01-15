Return-Path: <SRS0=TlCr=Y5=m4x.org=nicolas.iooss_linux@bounces.m4x.org>
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1bpf6FRMzDqTB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 23:51:38 +1100 (AEDT)
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/1] ASoC: fsl_asrc: use dma_transfer_direction enum when
 calling dmaengine_prep_dma_cyclic
Date: Sun, 15 Jan 2017 13:43:31 +0100
Message-Id: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When fsl_asrc_dma_prepare_and_submit() calls
dmaengine_prep_dma_cyclic(), it uses either DMA_TO_DEVICE or
DMA_FROM_DEVICE. These values are both items of dma_data_direction enum,
not of dma_data_direction enum, which is the type expected by
dmaengine_prep_dma_cyclic().

Replace DMA_TO_DEVICE with DMA_MEM_TO_DEV and DMA_FROM_DEVICE with
DMA_DEV_TO_MEM to fix this type mismatch issue.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 sound/soc/fsl/fsl_asrc_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index dc30d780f874..282d841840b1 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -76,7 +76,7 @@ static int fsl_asrc_dma_prepare_and_submit(struct snd_pcm_substream *substream)
 			pair->dma_chan[!dir], runtime->dma_addr,
 			snd_pcm_lib_buffer_bytes(substream),
 			snd_pcm_lib_period_bytes(substream),
-			dir == OUT ? DMA_TO_DEVICE : DMA_FROM_DEVICE, flags);
+			dir == OUT ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM, flags);
 	if (!pair->desc[!dir]) {
 		dev_err(dev, "failed to prepare slave DMA for Front-End\n");
 		return -ENOMEM;
-- 
2.11.0
