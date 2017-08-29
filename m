Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhdxx6P0JzDqF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 05:29:56 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_dma: remove dma_object path member" to the asoc
 tree
In-Reply-To: <20170829123755.9496-1-robh@kernel.org>
Message-Id: <20170829192944.48E884400E7@finisterre.ee.mobilebroadband>
Date: Tue, 29 Aug 2017 20:29:44 +0100 (BST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_dma: remove dma_object path member

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

>From b1dc00abcf18d27b36de500c150be88022c82270 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Aug 2017 07:37:55 -0500
Subject: [PATCH] ASoC: fsl_dma: remove dma_object path member

dma_object.path is unused, so rather than fix it to work with DT
full_name changes, just remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Timur Tabi <timur@tabi.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index c17359648915..0c11f434a374 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -63,7 +63,6 @@ struct dma_object {
 	struct ccsr_dma_channel __iomem *channel;
 	unsigned int irq;
 	bool assigned;
-	char path[1];
 };
 
 /*
@@ -903,13 +902,12 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
+	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
 	if (!dma) {
 		of_node_put(ssi_np);
 		return -ENOMEM;
 	}
 
-	strcpy(dma->path, np->full_name);
 	dma->dai.ops = &fsl_dma_ops;
 	dma->dai.pcm_new = fsl_dma_new;
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
-- 
2.13.2
