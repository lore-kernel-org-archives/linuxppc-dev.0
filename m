Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWDDk14SWzDqZf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:40:06 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u185so10275799pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 04:40:06 -0700 (PDT)
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
Subject: [PATCH 04/11] ASoC: nuc900: make snd_soc_platform_driver const
Date: Mon, 14 Aug 2017 17:08:43 +0530
Message-Id: <1502710730-18912-5-git-send-email-bhumirks@gmail.com>
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

Make this const as it is only passed as the 2nd argument to the
function devm_snd_soc_register_platform, which is of type const.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/nuc900/nuc900-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 2cca055..cd0486c 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -299,7 +299,7 @@ static int nuc900_dma_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_platform_driver nuc900_soc_platform = {
+static const struct snd_soc_platform_driver nuc900_soc_platform = {
 	.ops		= &nuc900_dma_ops,
 	.pcm_new	= nuc900_dma_new,
 };
-- 
1.9.1
