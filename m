Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sx7bc4DbHzDt4Y
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Oct 2016 02:26:20 +1100 (AEDT)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Timur Tabi <timur@tabi.org>
Cc: kernel-janitors@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] ASoC: constify snd_soc_ops structures
Date: Sat, 15 Oct 2016 16:55:50 +0200
Message-Id: <1476543351-17858-7-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check for snd_soc_ops structures that are only stored in the ops field of a
snd_soc_dai_link structure.  This field is declared const, so snd_soc_ops
structures that have this property can be declared as const also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct snd_soc_ops i@p = { ... };

@ok1@
identifier r.i;
struct snd_soc_dai_link e;
position p;
@@
e.ops = &i@p;

@ok2@
identifier r.i, e;
position p;
@@
struct snd_soc_dai_link e[] = { ..., { .ops = &i@p, }, ..., };

@bad@
position p != {r.p,ok1.p,ok2.p};
identifier r.i;
struct snd_soc_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct snd_soc_ops i = { ... };
// </smpl>

The effect on the layout of the .o files is shown by the following output of
the size command, first before then after the transformation:

  text    data     bss     dec     hex filename
   8748    1024       0    9772    262c sound/soc/fsl/fsl-asoc-card.o
   8812     952       0    9764    2624 sound/soc/fsl/fsl-asoc-card.o

   text    data     bss     dec     hex filename
   4165     264       8    4437    1155 sound/soc/fsl/imx-wm8962.o
   4229     200       8    4437    1155 sound/soc/fsl/imx-wm8962.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/fsl/fsl-asoc-card.c |    2 +-
 sound/soc/fsl/imx-wm8962.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -183,7 +183,7 @@ static int fsl_asoc_card_hw_params(struc
 	return 0;
 }
 
-static struct snd_soc_ops fsl_asoc_card_ops = {
+static const struct snd_soc_ops fsl_asoc_card_ops = {
 	.hw_params = fsl_asoc_card_hw_params,
 };
 
diff -u -p a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -61,7 +61,7 @@ static int imx_hifi_hw_params(struct snd
 	return 0;
 }
 
-static struct snd_soc_ops imx_hifi_ops = {
+static const struct snd_soc_ops imx_hifi_ops = {
 	.hw_params = imx_hifi_hw_params,
 };
 
