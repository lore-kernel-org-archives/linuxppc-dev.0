Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgKR80wH2zF0pS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:02:40 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id m19so3415330pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:02:40 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 01/17] ASoC: fsl_ssi: Redefine RX and TX macros
Date: Mon, 12 Feb 2018 14:03:09 -0800
Message-Id: <1518473005-14090-2-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
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
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++++
 sound/soc/fsl/fsl_ssi.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 24fb672..3c8dd60 100644
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
2.1.4
