Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWDDC0phMzDqpD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:39:39 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id y192so10270347pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 04:39:39 -0700 (PDT)
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
Subject: [PATCH 02/11] ASoC: Intel: make snd_soc_platform_driver const
Date: Mon, 14 Aug 2017 17:08:41 +0530
Message-Id: <1502710730-18912-3-git-send-email-bhumirks@gmail.com>
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

Make these const as they are only passed as the 2nd argument to the
function snd_soc_register_platform, which is of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c  | 2 +-
 sound/soc/intel/haswell/sst-haswell-pcm.c    | 2 +-
 sound/soc/intel/skylake/skl-pcm.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 49c7b88..b272df5 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -705,7 +705,7 @@ static int sst_soc_probe(struct snd_soc_platform *platform)
 	return sst_dsp_init_v2_dpcm(platform);
 }
 
-static struct snd_soc_platform_driver sst_soc_platform_drv  = {
+static const struct snd_soc_platform_driver sst_soc_platform_drv  = {
 	.probe		= sst_soc_probe,
 	.ops		= &sst_platform_ops,
 	.compr_ops	= &sst_platform_compr_ops,
diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 4765ad4..84cb568 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -395,7 +395,7 @@ static int sst_byt_pcm_remove(struct snd_soc_platform *platform)
 	return 0;
 }
 
-static struct snd_soc_platform_driver byt_soc_platform = {
+static const struct snd_soc_platform_driver byt_soc_platform = {
 	.probe		= sst_byt_pcm_probe,
 	.remove		= sst_byt_pcm_remove,
 	.ops		= &sst_byt_pcm_ops,
diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 9e4094e..c044400 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -1135,7 +1135,7 @@ static int hsw_pcm_remove(struct snd_soc_platform *platform)
 	return 0;
 }
 
-static struct snd_soc_platform_driver hsw_soc_platform = {
+static const struct snd_soc_platform_driver hsw_soc_platform = {
 	.probe		= hsw_pcm_probe,
 	.remove		= hsw_pcm_remove,
 	.ops		= &hsw_pcm_ops,
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index debdaac..e98d825 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1310,7 +1310,7 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 
 	return 0;
 }
-static struct snd_soc_platform_driver skl_platform_drv  = {
+static const struct snd_soc_platform_driver skl_platform_drv  = {
 	.probe		= skl_platform_soc_probe,
 	.ops		= &skl_platform_ops,
 	.pcm_new	= skl_pcm_new,
-- 
1.9.1
