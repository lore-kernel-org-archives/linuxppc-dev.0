Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8jQ94P7LzDq8W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 03:28:49 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Nicolas Iooss <nicolas.iooss_linux@m4x.org>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
In-Reply-To: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
Message-Id: <E1d1cMA-0001vD-Sz@debutante>
Date: Fri, 21 Apr 2017 18:28:30 +0100
Subject: Applied "ASoC: fsl_asrc_dma: use correct direction enum type" to the
 asoc tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_asrc_dma: use correct direction enum type

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 24dbd9edb668e2376ce871199f5ee4fd59c62276 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Wed, 19 Apr 2017 23:36:07 -0700
Subject: [PATCH] ASoC: fsl_asrc_dma: use correct direction enum type

The direction argument is of type enum dma_transfer_direction, and
not enum dma_data_direction. The enumeration values are the same
so this did not had an effect in practise.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
