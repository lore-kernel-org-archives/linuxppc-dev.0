Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA29F1A0186
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 17:05:08 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_sai: Set SYNC bit of TCR2 to Asynchronous Mode
Date: Mon, 4 Aug 2014 15:07:25 +0800
Message-ID: <1407136045-8940-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicolin Chen <Guangyu.Chen@freescale.com>

There is one design rule according to SAI's reference manual:
If the transmitter bit clock and frame sync are to be used by both transmitter
and receiver, the transmitter must be configured for asynchronous operation
and the receiver for synchronous operation.

And SYNC of TCR2 is a 2-width control bit:
00 Asynchronous mode.
01 Synchronous with receiver.
10 Synchronous with another SAI transmitter.
11 Synchronous with another SAI receiver.

So the driver should have set SYNC bit of TCR2 to 0x0, and meanwhile set SYNC
bit of RCR2 to 0x1 (Synchronous with transmitter).

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

@Mark
Sir, I don't see your last patch in your branch. So I guess we can still use
this better fix which does not have the 64bit compiling issue either. 

 sound/soc/fsl/fsl_sai.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index faa0497..9f10575 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -333,8 +333,7 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	 * The transmitter bit clock and frame sync are to be
 	 * used by both the transmitter and receiver.
 	 */
-	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC,
-			   ~FSL_SAI_CR2_SYNC);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC, 0);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR2, FSL_SAI_CR2_SYNC,
 			   FSL_SAI_CR2_SYNC);
 
-- 
1.8.4
