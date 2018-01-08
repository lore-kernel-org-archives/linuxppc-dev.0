Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFZWG18bKzDqmT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 23:35:53 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Fix build error" to the asoc tree
In-Reply-To: <1515344750-6159-1-git-send-email-linux@roeck-us.net>
Message-Id: <E1eYWeQ-0003K9-QM@debutante>
Date: Mon, 08 Jan 2018 12:35:38 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Fix build error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From a5a86a7f87d7b684f0369e1f207bb294cfa58dde Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 7 Jan 2018 09:05:50 -0800
Subject: [PATCH] ASoC: fsl_ssi: Fix build error

powerpc:mpc85xx_defconfig fails to build with the following errors.

sound/soc/fsl/fsl_dma.c: In function 'fsl_soc_dma_probe':
sound/soc/fsl/fsl_dma.c:916:34: error: 'CCSR_SSI_STX0' undeclared
sound/soc/fsl/fsl_dma.c:917:34: error: 'CCSR_SSI_SRX0' undeclared

Fixes: a818aa5f967b ("ASoC: fsl_ssi: Rename registers and fields macros")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 0c11f434a374..8c2981b70f64 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -913,8 +913,8 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
 
 	/* Store the SSI-specific information that we need */
-	dma->ssi_stx_phys = res.start + CCSR_SSI_STX0;
-	dma->ssi_srx_phys = res.start + CCSR_SSI_SRX0;
+	dma->ssi_stx_phys = res.start + REG_SSI_STX0;
+	dma->ssi_srx_phys = res.start + REG_SSI_SRX0;
 
 	iprop = of_get_property(ssi_np, "fsl,fifo-depth", NULL);
 	if (iprop)
-- 
2.15.1
