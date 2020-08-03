Return-Path: <SRS0=LND+=BN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1877AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 03:24:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7232206F6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 03:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7232206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKjtF1Nx8zDqSp
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 13:24:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKjqt1kZFzDqSJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 13:22:32 +1000 (AEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 840432000E8;
 Mon,  3 Aug 2020 05:22:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 189D82000F7;
 Mon,  3 Aug 2020 05:22:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0A4ED402DE;
 Mon,  3 Aug 2020 05:22:18 +0200 (CEST)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
Date: Mon,  3 Aug 2020 11:17:54 +0800
Message-Id: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

TX synchronous with RX: The RMR is no need to be changed when
Tx is enabled, the other configuration in hw_params() is enough for
clock generation. The TCSR.TE is no need to enabled when only RX
is enabled.

RX synchronous with TX: The TMR is no need to be changed when
Rx is enabled, the other configuration in hw_params() is enough for
clock generation. The RCSR.RE is no need to enabled when only TX
is enabled.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index cdff739924e2..a210c9836a9a 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -482,8 +482,6 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 			regmap_update_bits(sai->regmap, FSL_SAI_TCR5(ofs),
 				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
 				FSL_SAI_CR5_FBT_MASK, val_cr5);
-			regmap_write(sai->regmap, FSL_SAI_TMR,
-				~0UL - ((1 << channels) - 1));
 		} else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
 			regmap_update_bits(sai->regmap, FSL_SAI_RCR4(ofs),
 				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
@@ -491,8 +489,6 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 			regmap_update_bits(sai->regmap, FSL_SAI_RCR5(ofs),
 				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
 				FSL_SAI_CR5_FBT_MASK, val_cr5);
-			regmap_write(sai->regmap, FSL_SAI_RMR,
-				~0UL - ((1 << channels) - 1));
 		}
 	}
 
@@ -553,11 +549,18 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
 				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
 
-		regmap_update_bits(sai->regmap, FSL_SAI_RCSR(ofs),
-				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
-		regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs),
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
 				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
 
+		/* Enable opposite direction when necessarily */
+		if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
+			regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
+					   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
+		} else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
+			regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
+					   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
+		}
+
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
 				   FSL_SAI_CSR_xIE_MASK, FSL_SAI_FLAGS);
 		break;
-- 
2.27.0

