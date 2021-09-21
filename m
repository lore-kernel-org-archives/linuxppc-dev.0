Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D6FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 21:40:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8451E61159
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 21:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8451E61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDZbd1x1rz2ydk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 07:40:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LB1txrd3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LB1txrd3; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDZWc3pMZz3c6f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 07:37:00 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C89261131;
 Tue, 21 Sep 2021 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632260219;
 bh=J7PHhw9cNdQ6BGiWub2EqGalFkm6ejp/i7fbWHUB5Xg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LB1txrd3WlwtPfKTgjYKYZZDRGy0yRDN8kZUV2FLmjLo+gBavcdpsdWgHcyWN0JWW
 DzJ6eu6VNRFQPjPMvkmMEN9Q4LJLT4SsETADEPJAxrPLlNM8WeZI1SrxkaawWZW6NR
 KI/nb05QplmoPnRUyRqet5cPxiU1SUwg9F+pz46wzLRZZ9q1Rj/kS2Ngop0f5bUbg6
 FsYXGoI5G0ghC3UvaTkXT9MX9jqQBjV2w7lup6pJ2f/q5hPzIJpyyeDtKX2oXwaUi+
 /g1kGZF/NveGtfRE8arFp3ddDDBz8LimMhG/IHZ9chZpUS94VSeCf+suMJZ21Mz+T7
 BeFNg6VMauc6A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH v2 06/16] ASoC: fsl_sai: Update to modern clocking terminology
Date: Tue, 21 Sep 2021 22:35:32 +0100
Message-Id: <20210921213542.31688-6-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921213542.31688-1-broonie@kernel.org>
References: <20210921213542.31688-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4018; h=from:subject;
 bh=J7PHhw9cNdQ6BGiWub2EqGalFkm6ejp/i7fbWHUB5Xg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSk8X/riLcqzgY6r7/TPu0PUL9kESB/BZ4QzE1WrT
 6uteiieJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpPFwAKCRAk1otyXVSH0Nn+B/
 4iPVJb0KtM6IDuuO2X7ThLszL7p+vCDUmNM2XECnAwi0oUEeO3sCBJZVIrT1ehZXfvk0CbR7TMSmBc
 EuDjEEvrXZ+jcLp6u9dVScCXGKjt7MGA6El3PLt6h262lffYGxNTPaeK2Dk+StZbUDMScxn/jiV5Tb
 +WNagLYA93/JeU6Q5ncRY0CS0tRJ5tCOuR7oQe44A194yFIAXbUqvqV1hN3gNwPPMSPria77I+IBY+
 hW/vo2aadcyyuaAr0flCkb8vRX0rBWKj7XzGmfLy++65J6hsGVYMMsFZ4/iQcowhddqq2XCCjZNceV
 U7JIB7XccyO0ba1U/rQaxvQiXa8rD4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As part of moving to remove the old style defines for the bus clocks update
the fsl_sai driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 34 +++++++++++++++++-----------------
 sound/soc/fsl/fsl_sai.h |  2 +-
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 38f6362099d5..10544fa27dc0 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -297,23 +297,23 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
-	/* DAI clock master masks */
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS:
+	/* DAI clock provider masks */
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
 		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
 		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
-		sai->is_slave_mode = false;
+		sai->is_consumer_mode = false;
 		break;
-	case SND_SOC_DAIFMT_CBM_CFM:
-		sai->is_slave_mode = true;
+	case SND_SOC_DAIFMT_CBP_CFP:
+		sai->is_consumer_mode = true;
 		break;
-	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBC_CFP:
 		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
-		sai->is_slave_mode = false;
+		sai->is_consumer_mode = false;
 		break;
-	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBP_CFC:
 		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
-		sai->is_slave_mode = true;
+		sai->is_consumer_mode = true;
 		break;
 	default:
 		return -EINVAL;
@@ -356,8 +356,8 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 	u32 id;
 	int ret = 0;
 
-	/* Don't apply to slave mode */
-	if (sai->is_slave_mode)
+	/* Don't apply to consumer mode */
+	if (sai->is_consumer_mode)
 		return 0;
 
 	/*
@@ -462,7 +462,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	pins = DIV_ROUND_UP(channels, slots);
 
-	if (!sai->is_slave_mode) {
+	if (!sai->is_consumer_mode) {
 		if (sai->bclk_ratio)
 			ret = fsl_sai_set_bclk(cpu_dai, tx,
 					       sai->bclk_ratio *
@@ -502,12 +502,12 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		val_cr4 |= FSL_SAI_CR4_CHMOD;
 
 	/*
-	 * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
+	 * For SAI provider mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
 	 * generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
 	 * RCR5(TCR5) for playback(capture), or there will be sync error.
 	 */
 
-	if (!sai->is_slave_mode && fsl_sai_dir_is_synced(sai, adir)) {
+	if (!sai->is_consumer_mode && fsl_sai_dir_is_synced(sai, adir)) {
 		regmap_update_bits(sai->regmap, FSL_SAI_xCR4(!tx, ofs),
 				   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
 				   FSL_SAI_CR4_CHMOD_MASK,
@@ -543,7 +543,7 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
 			   FSL_SAI_CR3_TRCE_MASK, 0);
 
-	if (!sai->is_slave_mode &&
+	if (!sai->is_consumer_mode &&
 			sai->mclk_streams & BIT(substream->stream)) {
 		clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
 		sai->mclk_streams &= ~BIT(substream->stream);
@@ -577,7 +577,7 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	 * This is a hardware bug, and will be fix in the
 	 * next sai version.
 	 */
-	if (!sai->is_slave_mode) {
+	if (!sai->is_consumer_mode) {
 		/* Software Reset */
 		regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
 		/* Clear SR bit to finish the reset */
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index bc60030967dd..9aaf231bc024 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -259,7 +259,7 @@ struct fsl_sai {
 	struct clk *bus_clk;
 	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
 
-	bool is_slave_mode;
+	bool is_consumer_mode;
 	bool is_lsb_first;
 	bool is_dsp_mode;
 	bool synchronous[2];
-- 
2.20.1

