Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-yh0-x22d.google.com (mail-yh0-x22d.google.com
 [IPv6:2607:f8b0:4002:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1FC41A019F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Dec 2014 11:14:29 +1100 (AEDT)
Received: by mail-yh0-f45.google.com with SMTP id f10so6898534yha.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Dec 2014 16:14:27 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Subject: [PATCH] ASoC: fsl_esai: Fix incorrect xDC field width of xCCR
 registers
Date: Mon, 29 Dec 2014 16:13:51 -0800
Message-Id: <1419898431-11336-1-git-send-email-nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, festevam@gmail.com,
 Xiubo.Lee@gmail.com, timur@tabi.org, linux-kernel@vger.kernel.org,
 a_bouin@yahoo.fr, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The xDC field should have 5 bit width according to Reference Manual.
Thus this patch fixes it.

Signed-off-by: Aurelien BOUIN <a_bouin@yahoo.fr>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

The patch was originally submitted by Aurelien BOUIN while in an
informal way. And he hasn't finished any re-submitting during the
past two weeks. Thus I create a new patch with his signed-off
included so as to fix the probelm as soon as possible, not sure
whether it's decent or not though.

--Nicolin

 sound/soc/fsl/fsl_esai.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
index 91a550f..5e793bb 100644
--- a/sound/soc/fsl/fsl_esai.h
+++ b/sound/soc/fsl/fsl_esai.h
@@ -302,7 +302,7 @@
 #define ESAI_xCCR_xFP_MASK	(((1 << ESAI_xCCR_xFP_WIDTH) - 1) << ESAI_xCCR_xFP_SHIFT)
 #define ESAI_xCCR_xFP(v)	((((v) - 1) << ESAI_xCCR_xFP_SHIFT) & ESAI_xCCR_xFP_MASK)
 #define ESAI_xCCR_xDC_SHIFT     9
-#define ESAI_xCCR_xDC_WIDTH	4
+#define ESAI_xCCR_xDC_WIDTH	5
 #define ESAI_xCCR_xDC_MASK	(((1 << ESAI_xCCR_xDC_WIDTH) - 1) << ESAI_xCCR_xDC_SHIFT)
 #define ESAI_xCCR_xDC(v)	((((v) - 1) << ESAI_xCCR_xDC_SHIFT) & ESAI_xCCR_xDC_MASK)
 #define ESAI_xCCR_xPSR_SHIFT	8
-- 
1.9.1
