Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWDG21y4FzDqm7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:41:14 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u185so10279965pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 04:41:14 -0700 (PDT)
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
Subject: [PATCH 09/11] ASoC: sh: make snd_soc_platform_driver const
Date: Mon, 14 Aug 2017 17:08:48 +0530
Message-Id: <1502710730-18912-10-git-send-email-bhumirks@gmail.com>
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

Make these const as they are either passed as the 2nd argument to
the function devm_snd_soc_register_platform or snd_soc_register_platform,
and the arguments are of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/sh/dma-sh7760.c | 2 +-
 sound/soc/sh/fsi.c        | 2 +-
 sound/soc/sh/rcar/core.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 8fad444..81c7433 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -320,7 +320,7 @@ static int camelot_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_platform_driver sh7760_soc_platform = {
+static const struct snd_soc_platform_driver sh7760_soc_platform = {
 	.ops		= &camelot_pcm_ops,
 	.pcm_new	= camelot_pcm_new,
 };
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 005b215..60bb23f 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1818,7 +1818,7 @@ static int fsi_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	},
 };
 
-static struct snd_soc_platform_driver fsi_soc_platform = {
+static const struct snd_soc_platform_driver fsi_soc_platform = {
 	.ops		= &fsi_pcm_ops,
 	.pcm_new	= fsi_pcm_new,
 };
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 650cc28..361afc0 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1318,7 +1318,7 @@ static int rsnd_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
 }
 
-static struct snd_soc_platform_driver rsnd_soc_platform = {
+static const struct snd_soc_platform_driver rsnd_soc_platform = {
 	.ops		= &rsnd_pcm_ops,
 	.pcm_new	= rsnd_pcm_new,
 };
-- 
1.9.1
