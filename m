Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sV1zd61w7zDsFt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 10:53:31 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Bard Liao <bardliao@realtek.com>,
 Oder Chiou <oder_chiou@realtek.com>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: constify snd_pcm_ops structures
Date: Thu,  8 Sep 2016 02:35:23 +0200
Message-Id: <1473294923-24220-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check for snd_pcm_ops structures that are only stored in the ops field of a
snd_soc_platform_driver structure or passed as the third argument to
snd_pcm_set_ops.  The corresponding field or parameter is declared const,
so snd_pcm_ops structures that have this property can be declared as const
also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct snd_pcm_ops i@p = { ... };

@ok1@
identifier r.i;
struct snd_soc_platform_driver e;
position p;
@@
e.ops = &i@p;

@ok2@
identifier r.i;
expression e1, e2;
position p;
@@
snd_pcm_set_ops(e1, e2, &i@p)

@bad@
position p != {r.p,ok1.p,ok2.p};
identifier r.i;
struct snd_pcm_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct snd_pcm_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/amd/acp-pcm-dma.c                  |    2 +-
 sound/soc/atmel/atmel-pcm-pdc.c              |    2 +-
 sound/soc/codecs/rt5514-spi.c                |    2 +-
 sound/soc/fsl/fsl_asrc_dma.c                 |    2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |    2 +-
 sound/soc/intel/haswell/sst-haswell-pcm.c    |    2 +-
 sound/soc/intel/skylake/skl-pcm.c            |    2 +-
 sound/soc/kirkwood/kirkwood-dma.c            |    2 +-
 sound/soc/qcom/lpass-platform.c              |    2 +-
 sound/soc/soc-utils.c                        |    2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 3154525..9e4094e 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -871,7 +871,7 @@ out:
 	return ret;
 }
 
-static struct snd_pcm_ops hsw_pcm_ops = {
+static const struct snd_pcm_ops hsw_pcm_ops = {
 	.open		= hsw_pcm_open,
 	.close		= hsw_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index da861b4..91b7069 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -381,7 +381,7 @@ static int atmel_pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops atmel_pcm_ops = {
+static const struct snd_pcm_ops atmel_pcm_ops = {
 	.open		= atmel_pcm_open,
 	.close		= atmel_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index a144c14..e2ff538 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -372,7 +372,7 @@ static int lpass_platform_pcmops_mmap(struct snd_pcm_substream *substream,
 			runtime->dma_bytes);
 }
 
-static struct snd_pcm_ops lpass_platform_pcm_ops = {
+static const struct snd_pcm_ops lpass_platform_pcm_ops = {
 	.open		= lpass_platform_pcmops_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= lpass_platform_pcmops_hw_params,
diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 77ff8eb..09103aa 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -236,7 +236,7 @@ static snd_pcm_uframes_t rt5514_spi_pcm_pointer(
 	return bytes_to_frames(runtime, rt5514_dsp->dma_offset);
 }
 
-static struct snd_pcm_ops rt5514_spi_pcm_ops = {
+static const struct snd_pcm_ops rt5514_spi_pcm_ops = {
 	.open		= rt5514_spi_pcm_open,
 	.hw_params	= rt5514_spi_hw_params,
 	.hw_free	= rt5514_spi_hw_free,
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index d1fb035..504c7cd 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -897,7 +897,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops acp_dma_ops = {
+static const struct snd_pcm_ops acp_dma_ops = {
 	.open = acp_dma_open,
 	.close = acp_dma_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 52ed434..25c6d87 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -670,7 +670,7 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 	return str_info->buffer_ptr;
 }
 
-static struct snd_pcm_ops sst_platform_ops = {
+static const struct snd_pcm_ops sst_platform_ops = {
 	.open = sst_platform_open,
 	.ioctl = snd_pcm_lib_ioctl,
 	.trigger = sst_platform_pcm_trigger,
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 77bfd40..86c125f 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1093,7 +1093,7 @@ static int skl_get_time_info(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_pcm_ops skl_platform_ops = {
+static const struct snd_pcm_ops skl_platform_ops = {
 	.open = skl_platform_open,
 	.ioctl = snd_pcm_lib_ioctl,
 	.trigger = skl_platform_pcm_trigger,
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index dbfdfe9..dafd22e 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -242,7 +242,7 @@ static snd_pcm_uframes_t kirkwood_dma_pointer(struct snd_pcm_substream
 	return count;
 }
 
-static struct snd_pcm_ops kirkwood_dma_ops = {
+static const struct snd_pcm_ops kirkwood_dma_ops = {
 	.open =		kirkwood_dma_open,
 	.close =        kirkwood_dma_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 53dd085..393e8f0 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -80,7 +80,7 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops dummy_dma_ops = {
+static const struct snd_pcm_ops dummy_dma_ops = {
 	.open		= dummy_dma_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 };
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index ffc000b..dc30d78 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -322,7 +322,7 @@ static snd_pcm_uframes_t fsl_asrc_dma_pcm_pointer(struct snd_pcm_substream *subs
 	return bytes_to_frames(substream->runtime, pair->pos);
 }
 
-static struct snd_pcm_ops fsl_asrc_dma_pcm_ops = {
+static const struct snd_pcm_ops fsl_asrc_dma_pcm_ops = {
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= fsl_asrc_dma_hw_params,
 	.hw_free	= fsl_asrc_dma_hw_free,
