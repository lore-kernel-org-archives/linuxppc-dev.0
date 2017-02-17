Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0167.hostedemail.com
 [216.40.44.167])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPkwk2NwszDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 18:21:42 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 44E8A212004
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 07:13:20 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 35/35] sound/soc: Convert remaining uses of pr_warning to
 pr_warn
Date: Thu, 16 Feb 2017 23:11:48 -0800
Message-Id: <3d93f7226ba34fede99f72ec038098a3d98a139a.1487314667.git.joe@perches.com>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To enable eventual removal of pr_warning

This makes pr_warn use consistent for sound/soc

Prior to this patch, there were 5 uses of pr_warning and
10 uses of pr_warn in sound/soc

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/fsl/imx-audmux.c     | 6 +++---
 sound/soc/samsung/s3c-i2s-v2.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index fc57da341d61..41e877d2b400 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -152,7 +152,7 @@ static void audmux_debugfs_init(void)
 
 	audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
 	if (!audmux_debugfs_root) {
-		pr_warning("Failed to create AUDMUX debugfs root\n");
+		pr_warn("Failed to create AUDMUX debugfs root\n");
 		return;
 	}
 
@@ -160,8 +160,8 @@ static void audmux_debugfs_init(void)
 		snprintf(buf, sizeof(buf), "ssi%lu", i);
 		if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
 					 (void *)i, &audmux_debugfs_fops))
-			pr_warning("Failed to create AUDMUX port %lu debugfs file\n",
-				   i);
+			pr_warn("Failed to create AUDMUX port %lu debugfs file\n",
+				i);
 	}
 }
 
diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 644f186fd35c..7423e4257a1b 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -669,13 +669,13 @@ static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
 		iismod = readl(i2s->regs + S3C2412_IISMOD);
 
 		if (iismod & S3C2412_IISCON_RXDMA_ACTIVE)
-			pr_warning("%s: RXDMA active?\n", __func__);
+			pr_warn("%s: RXDMA active?\n", __func__);
 
 		if (iismod & S3C2412_IISCON_TXDMA_ACTIVE)
-			pr_warning("%s: TXDMA active?\n", __func__);
+			pr_warn("%s: TXDMA active?\n", __func__);
 
 		if (iismod & S3C2412_IISCON_IIS_ACTIVE)
-			pr_warning("%s: IIS active\n", __func__);
+			pr_warn("%s: IIS active\n", __func__);
 	}
 
 	return 0;
-- 
2.10.0.rc2.1.g053435c
