Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY2F158lyzDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 20:16:37 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y192so9163595pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 03:16:37 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, timur@tabi.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org,
 bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/6] ASoC: fsl: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 15:46:07 +0530
Message-Id: <1502964972-22722-2-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
References: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make these const as they are only passed as the 2nd argument to the
function snd_soc_set_runtime_hwparams, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/fsl/fsl_asrc_dma.c | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 2baf196..e1b97e5 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -20,7 +20,7 @@
 
 #define FSL_ASRC_DMABUF_SIZE	(256 * 1024)
 
-static struct snd_pcm_hardware snd_imx_hardware = {
+static const struct snd_pcm_hardware snd_imx_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP |
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index aef1f78..4e5fefe 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -154,7 +154,7 @@ static snd_pcm_uframes_t snd_imx_pcm_pointer(struct snd_pcm_substream *substream
 	return bytes_to_frames(substream->runtime, iprtd->offset);
 }
 
-static struct snd_pcm_hardware snd_imx_hardware = {
+static const struct snd_pcm_hardware snd_imx_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP |
-- 
1.9.1
