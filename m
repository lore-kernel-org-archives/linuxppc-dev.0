Return-Path: <caleb@crome.org>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtvFn2y3rzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 04:02:36 +1000 (AEST)
Received: by mail-pf0-x22f.google.com with SMTP id 206so20331788pfu.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 11:02:36 -0700 (PDT)
From: Caleb Crome <caleb@crome.org>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Caleb Crome <caleb@crome.org>
Subject: [PATCH 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register list
Date: Mon, 25 Apr 2016 10:50:24 -0700
Message-Id: <1461606624-130216-1-git-send-email-caleb@crome.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to caching, SOR wasn't written when it should have been.  This
patch simply adds SOR to the volatile list.

Signed-off-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 216e3cb..2f3bf9c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -151,6 +151,7 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 	case CCSR_SSI_SACDAT:
 	case CCSR_SSI_SATAG:
 	case CCSR_SSI_SACCST:
+	case CCSR_SSI_SOR:
 		return true;
 	default:
 		return false;
-- 
1.9.1
