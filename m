Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx9Nf4p3rzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 20:46:26 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Caleb Crome <caleb@crome.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1461606624-130216-1-git-send-email-caleb@crome.org>
Message-Id: <E1aw5vv-0001Iy-KV@debutante>
Date: Fri, 29 Apr 2016 11:46:03 +0100
Subject: Applied "ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register list"
 to the asoc tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register list

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3cc6185bcccff32df41faa97d592a99d258db185 Mon Sep 17 00:00:00 2001
From: Caleb Crome <caleb@crome.org>
Date: Mon, 25 Apr 2016 11:36:18 -0700
Subject: [PATCH] ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register list

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
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ed8de1035cda..08dcbbf60adb 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -137,6 +137,7 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 	case CCSR_SSI_SACDAT:
 	case CCSR_SSI_SATAG:
 	case CCSR_SSI_SACCST:
+	case CCSR_SSI_SOR:
 		return true;
 	default:
 		return false;
-- 
2.8.0.rc3
