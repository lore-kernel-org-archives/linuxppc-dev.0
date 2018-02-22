Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znFJM6hDSzF18M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 00:17:23 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Caleb Crome <caleb@crome.org>,
 Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Mark Brown <broonie@kernel.org>, timur@tabi.org, broonie@kernel.org,
 mail@maciej.szmigiero.name, alsa-devel@alsa-project.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Redefine RX and TX macros" to the asoc tree
In-Reply-To: <1515990087-11598-2-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eoqkL-0006UU-Na@debutante>
Date: Thu, 22 Feb 2018 13:17:13 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Redefine RX and TX macros

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

>From 1476105c3f4a6b8f0c6c1fe07295fc85cbffbd83 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:09 -0800
Subject: [PATCH] ASoC: fsl_ssi: Redefine RX and TX macros

The RX and TX macros were defined implicitly and there was
a potential risk if someone changes their values.

Since they were defined to index the array ssi->regvals[2],
this patch moves these two macros to fsl_ssi.c, closer to
its owner ssi->regvals. And it also puts some comments here
to limit their value within [0, 1].

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++++
 sound/soc/fsl/fsl_ssi.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 24fb672f3c65..3c8dd609e42e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -56,6 +56,10 @@
 #include "fsl_ssi.h"
 #include "imx-pcm.h"
 
+/* Define RX and TX to index ssi->regvals array; Can be 0 or 1 only */
+#define RX 0
+#define TX 1
+
 /**
  * FSLSSI_I2S_FORMATS: audio formats supported by the SSI
  *
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index de2fdc5db726..18f8dd5209d5 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -12,9 +12,6 @@
 #ifndef _MPC8610_I2S_H
 #define _MPC8610_I2S_H
 
-#define RX 0
-#define TX 1
-
 /* -- SSI Register Map -- */
 
 /* SSI Transmit Data Register 0 */
-- 
2.16.1
