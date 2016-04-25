Return-Path: <caleb@crome.org>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtwGS3lK5zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 04:48:16 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id n1so72029489pfn.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 11:48:16 -0700 (PDT)
From: Caleb Crome <caleb@crome.org>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Caleb Crome <caleb@crome.org>
Subject: [PATCH v2 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register
 list
Date: Mon, 25 Apr 2016 11:36:18 -0700
Message-Id: <1461609378-467-1-git-send-email-caleb@crome.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CCSR_SSI_SOR is a register that clears the TX and/or the RX fifo
on the i.MX SSI port.  The fsl_ssi_trigger writes this register in
order to clear the fifo at trigger time.

However, since the CCSR_SSI_SOR register is not in the volatile list,
the caching mechanism prevented the register write in the trigger
function.  This caused the fifo to not be cleared (because the value
was unchanged from the last time the register was written), and thus
causes the channels in both TDM or simple I2S mode to slip and be in
the wrong time slots on SSI restart.

This has gone unnoticed for so long because with simple stereo mode,
the consequence is that left and right are swapped, which isn't that
noticeable.  However, it's catestrophic in some systems that
require the channels to be in the right slots.

Signed-off-by: Caleb Crome <caleb@crome.org>
Suggested-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

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
