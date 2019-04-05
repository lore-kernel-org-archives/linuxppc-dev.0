Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DF8C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 03:28:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACD02171F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 03:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="h+wUWTtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACD02171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44b4ym6vjyzDqSD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:28:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="h+wUWTtz"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44b4wg6NqKzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 14:26:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=isHyb2il+Ag94Qt74WcAtX5KXJrltPfq4KJ4zvpLROk=; b=h+wUWTtzHh/K
 6+zQZCSFNGsd9jGz1ik5a0un2aDCt50/idXq05ONb0sU7gumJNwZ3+AQePF9/eaiUPa0ZaZz8OIpZ
 8Lmss0eMcL1Xhi/IRwBlHRLYOLHmD3ccg8NidAOLkZkDBMdnx+fjxdlE/Lwy3jlNAG8blyADU3LOi
 KwgcI=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hCFUe-0005fQ-GE; Fri, 05 Apr 2019 03:26:16 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 6CFE7441D3C; Fri,  5 Apr 2019 10:26:13 +0700 (+07)
From: Mark Brown <broonie@kernel.org>
To: S.j. Wang <shengjiu.wang@nxp.com>
Subject: Applied "ASoC: fsl_esai: Support synchronous mode" to the asoc tree
In-Reply-To: <a24d5493c392d39aefc6239e3dd97f9dd5fff1a1.1554370750.git.shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405032613.6CFE7441D3C@finisterre.ee.mobilebroadband>
Date: Fri,  5 Apr 2019 10:26:13 +0700 (+07)
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
Cc: alsa-devel@alsa-project.org, "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch

   ASoC: fsl_esai: Support synchronous mode

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

From 1997ee89f36da906efb8e700f1d08368c73883be Mon Sep 17 00:00:00 2001
From: "S.j. Wang" <shengjiu.wang@nxp.com>
Date: Thu, 4 Apr 2019 09:40:56 +0000
Subject: [PATCH] ASoC: fsl_esai: Support synchronous mode

In ESAI synchronous mode, the clock is generated by Tx, So
we should always set registers of Tx which relate with the
bit clock and frame clock generation (TCCR, TCR, ECR), even
there is only Rx is working.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 3623aa9a6f2e..c7410bbfd2af 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -218,7 +218,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
 	struct clk *clksrc = esai_priv->extalclk;
-	bool tx = clk_id <= ESAI_HCKT_EXTAL;
+	bool tx = (clk_id <= ESAI_HCKT_EXTAL || esai_priv->synchronous);
 	bool in = dir == SND_SOC_CLOCK_IN;
 	u32 ratio, ecr = 0;
 	unsigned long clk_rate;
@@ -253,7 +253,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		ecr |= ESAI_ECR_ETI;
 		/* fall through */
 	case ESAI_HCKR_EXTAL:
-		ecr |= ESAI_ECR_ERI;
+		ecr |= esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
 		break;
 	default:
 		return -EINVAL;
@@ -537,10 +537,18 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
 
 	bclk = params_rate(params) * slot_width * esai_priv->slots;
 
-	ret = fsl_esai_set_bclk(dai, tx, bclk);
+	ret = fsl_esai_set_bclk(dai, esai_priv->synchronous || tx, bclk);
 	if (ret)
 		return ret;
 
+	mask = ESAI_xCR_xSWS_MASK;
+	val = ESAI_xCR_xSWS(slot_width, width);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
+	/* Recording in synchronous mode needs to set TCR also */
+	if (!tx && esai_priv->synchronous)
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, val);
+
 	/* Use Normal mode to support monaural audio */
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 			   ESAI_xCR_xMOD_MASK, params_channels(params) > 1 ?
@@ -556,10 +564,9 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx), mask, val);
 
-	mask = ESAI_xCR_xSWS_MASK | (tx ? ESAI_xCR_PADC : 0);
-	val = ESAI_xCR_xSWS(slot_width, width) | (tx ? ESAI_xCR_PADC : 0);
-
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
+	if (tx)
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+				ESAI_xCR_PADC, ESAI_xCR_PADC);
 
 	/* Remove ESAI personal reset by configuring ESAI_PCRC and ESAI_PRRC */
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
-- 
2.20.1

