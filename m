Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKgDT6vwhzF0X9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 15:22:17 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id q3so2800627plr.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 20:22:17 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v3 01/17] ASoC: fsl_ssi: Redefine RX and TX macros
Date: Sun, 14 Jan 2018 20:21:11 -0800
Message-Id: <1515990087-11598-2-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RX and TX macros were defined implicitly and there was
a potential risk if someone changes their values.

Since they were defined to index the array ssi->regvals[2],
this patch moves these two macros to fsl_ssi.c, closer to
its owner ssi->regvals. And it also puts some comments here
to limit their value within [0, 1].

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++++
 sound/soc/fsl/fsl_ssi.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index aecd00f..001e453 100644
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
index de2fdc5..18f8dd5 100644
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
2.7.4
