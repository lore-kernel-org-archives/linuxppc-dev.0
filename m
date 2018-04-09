Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KBC8211xzDr3t
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 10:34:44 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id p6so1190174pfn.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 17:34:44 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
 lgirdwood@gmail.com, fabio.estevam@nxp.com
Subject: [PATCH] ASoC: fsl_esai: Add freq check in set_dai_sysclk()
Date: Sun,  8 Apr 2018 17:33:54 -0700
Message-Id: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The freq parameter indicates the physical frequency of an actual
input clock or a desired frequency of an output clock for HCKT/R.
It should never be passed 0. This might cause Division-by-zero.

So this patch adds a check to fix it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_esai.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index da8fd98..d79e99e 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -226,6 +226,12 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned long clk_rate;
 	int ret;
 
+	if (freq == 0) {
+		dev_err(dai->dev, "%sput freq of HCK%c should not be 0Hz\n",
+			in ? "in" : "out", tx ? 'T' : 'R');
+		return -EINVAL;
+	}
+
 	/* Bypass divider settings if the requirement doesn't change */
 	if (freq == esai_priv->hck_rate[tx] && dir == esai_priv->hck_dir[tx])
 		return 0;
-- 
2.7.4
