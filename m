Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E07C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 18:53:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE992177E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 18:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LfPHU/XQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE992177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443Ch52H9DzDqJk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 05:53:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="LfPHU/XQ"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443Cb33w2LzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 05:49:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=FZw/nIU94/BV3+eC5ofCCRLmhZpkDi3wgLtrY44XoZg=; b=LfPHU/XQA5FP
 UooC6adsaDzjfoyEVIyslL4h6s86A4skorywc6ZLkBuS92azF4Dps9XX+hNEVTrHyPJxzlmQMUv2B
 z48WOZzMI7k3CBGfJyJD+Rsn22EVfyULl2WRX8fNsx45WAmkN3yJEYjTxFRvr7YNyeT1HEnu0xcoH
 37ykE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gvnyp-0001e4-3E; Mon, 18 Feb 2019 18:49:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 887FC1128009; Mon, 18 Feb 2019 18:49:26 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Applied "ASoC: fsl_spdif: fix sysclk_df type" to the asoc tree
In-Reply-To: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218184926.887FC1128009@debutante.sirena.org.uk>
Date: Mon, 18 Feb 2019 18:49:26 +0000 (GMT)
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
Cc: Viorel Suman <viorel.suman@gmail.com>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch

   ASoC: fsl_spdif: fix sysclk_df type

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

From 2231609a2c0a4807c017822ecb5834bbb7f59fb9 Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Mon, 18 Feb 2019 15:25:00 +0000
Subject: [PATCH] ASoC: fsl_spdif: fix sysclk_df type

According to RM SPDIF STC SYSCLK_DF field is 9-bit wide, values
being in 0..511 range. Use a proper type to handle sysclk_df.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index a26686e7281c..4842e6df9a2d 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -96,7 +96,7 @@ struct fsl_spdif_priv {
 	bool dpll_locked;
 	u32 txrate[SPDIF_TXRATE_MAX];
 	u8 txclk_df[SPDIF_TXRATE_MAX];
-	u8 sysclk_df[SPDIF_TXRATE_MAX];
+	u16 sysclk_df[SPDIF_TXRATE_MAX];
 	u8 txclk_src[SPDIF_TXRATE_MAX];
 	u8 rxclk_src;
 	struct clk *txclk[SPDIF_TXRATE_MAX];
@@ -376,7 +376,8 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 	struct platform_device *pdev = spdif_priv->pdev;
 	unsigned long csfs = 0;
 	u32 stc, mask, rate;
-	u8 clk, txclk_df, sysclk_df;
+	u16 sysclk_df;
+	u8 clk, txclk_df;
 	int ret;
 
 	switch (sample_rate) {
@@ -1109,8 +1110,9 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 	static const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
 	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
 	u64 rate_ideal, rate_actual, sub;
-	u32 sysclk_dfmin, sysclk_dfmax;
-	u32 txclk_df, sysclk_df, arate;
+	u32 arate;
+	u16 sysclk_dfmin, sysclk_dfmax, sysclk_df;
+	u8 txclk_df;
 
 	/* The sysclk has an extra divisor [2, 512] */
 	sysclk_dfmin = is_sysclk ? 2 : 1;
-- 
2.20.1

