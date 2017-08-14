Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWDDS3Lp5zDqlN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:39:52 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 123so10256421pga.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 04:39:52 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 bardliao@realtek.com, chiou@realtek.com, timur@tabi.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
 yang.jie@linux.intel.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com,
 daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 plai@codeaurora.org, bgoswami@codeaurora.org, krzk@kernel.org,
 sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 03/11] ASoC: fsl: make snd_soc_platform_driver const
Date: Mon, 14 Aug 2017 17:08:42 +0530
Message-Id: <1502710730-18912-4-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make these const as they are only passed as the 2nd argument to the function
snd_soc_register_platform, which is of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/fsl/imx-pcm-fiq.c | 2 +-
 sound/soc/fsl/mpc5200_dma.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 92410f7..3fcc7b5 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -341,7 +341,7 @@ static void imx_pcm_fiq_free(struct snd_pcm *pcm)
 	imx_pcm_free(pcm);
 }
 
-static struct snd_soc_platform_driver imx_soc_platform_fiq = {
+static const struct snd_soc_platform_driver imx_soc_platform_fiq = {
 	.ops		= &imx_pcm_ops,
 	.pcm_new	= imx_pcm_fiq_new,
 	.pcm_free	= imx_pcm_fiq_free,
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 1f7e70b..cdd848c 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -356,7 +356,7 @@ static void psc_dma_free(struct snd_pcm *pcm)
 	}
 }
 
-static struct snd_soc_platform_driver mpc5200_audio_dma_platform = {
+static const struct snd_soc_platform_driver mpc5200_audio_dma_platform = {
 	.ops		= &psc_dma_ops,
 	.pcm_new	= &psc_dma_new,
 	.pcm_free	= &psc_dma_free,
-- 
1.9.1
