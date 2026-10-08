Return-Path: <linuxppc-dev+bounces-29042-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96254CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:42:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mlx1wjdz3bvL;
	Thu, 08 Oct 2026 21:42:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456157;
	cv=none; b=GyZs3I1u+nAsd9mmUzcifYSv1UKEQf1ocGsmuX8viPLlTPBhMWaJf4bVFx0yPM7qXvKp9HM81spOEYsvaxCDHse7QX4EnVFoAGbxkonu0vDfl4rcPBTLcwQeP7mBTvi09Ktz7B8p3IbvUIl2aCZ9wXKqlhqi665LdOMxP1IoVd46SutdDZ+jEGlKuw5b+kCW7N46BzxsaWdqrtwiNYt/kbqyg90vSlSW2VEM+Voi2LP9eYPElSaSVj/0lJ+uWe4JwwtHsDtPPWeOsAq9BTh/LBLR92vn0PiIct+Van075urn+daxte51N89SW4bn5ByAObg9CHAZdRdTbVPDGmyu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456157; c=relaxed/relaxed;
	bh=Uc00trQPX7RuBM3kvjd0hrBbedJ5QhnOwvfpAMsSqmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxViftapdaMYYUkgcSZGKVAhBei8vmizaOEsolejLrZRDZR86ABSgWMWb/H8LOtFKnQJcmt5XELBVuvSgtrz9uKc+xUpPAVIeivV8fhNxK/Ohq+smt6feJdG5AriM1WSVa8XtDOH8SG54I880jOk+SisI8/h6L+aik4knGZTxoZ8uUvYLJC7N48x77DUPj8IH1N/egtz900A/kU+hnFjhJ7r5MLDXtw1VP1k5NgQVAL2Qzn8CIacho2L4Z66FzeFtoWj7YJmLWPjVVOThQtLla6B0URBXXNjuD67hPSdfIc/KLmOS2BeZ51M61SSxvXWBMMva3UgZ3M7dNg90d1H4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rIojj2cP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rIojj2cP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mlw3fbbz30Vy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:42:36 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-3282db206d3so796558eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456155; x=1792060955; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uc00trQPX7RuBM3kvjd0hrBbedJ5QhnOwvfpAMsSqmQ=;
        b=rIojj2cP1o8UJMBsCHM1SWrHJ36/IrL2s6IbBMyuFMv6ITZkVT7ofLArVnezl9d6PN
         uFkjAsgMCBOFj1D5sZ1h4ryZYMr05KXqhBoLIHknDlsWiVbxAPbM+CSchARYSzv9XO5d
         6Iny2ytY6Ypa4ONiHrtidB0Ws0ZDVIIraGS6OKGdvLEyo/m8p1rkWfsAqz0XoxjYFTZp
         peRs4klshIa3J6Y9breTKRnKAcCCyET4mao/4KQ3IGuBA9Q5lg3DBzFri6rlNW6la20n
         yytw+lHlbWASB1kVO0ufn6arNEPqUjXqzeqemt5fMgJ36zMWOfjzlBYKn0KzRCN6ATKk
         9/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456155; x=1792060955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uc00trQPX7RuBM3kvjd0hrBbedJ5QhnOwvfpAMsSqmQ=;
        b=zvy2pQ8kmlNnzIMEPS/cov2GjzO2IsS5y2C/VFUNOvztrdoz9kpRMCK2S6LO0Xl6Yn
         DE+fmOrc0xstclG9dsVkyQBCbt4tlSVO/6t6+KyklznNdhFsnlX/Lu6UH55y5xPh+63j
         sHxIDzDh3lVG+g4zlYupLu0Vsh8F1PSsJBJTFWeA3cMn+hGjrPX7FmgPOBA33kY2nZJs
         /AtzNtDw1mS2dkywDISUL809Y88ARgjEBCHTphT0Ci+YcgYmT/B3S4PpI19fJvXvbhCo
         QfPoq0jbPP//pCI3wUAU7RnYJClFegzC6a8640F3m0zJTO6odoGgjYKcVQTaSImloZ/d
         xctA==
X-Forwarded-Encrypted: i=1; AKwUvBzwW6gql9+FhKRgUzw3rzM+nnAKARvZn4rfmzfIHMfV3qRNzWWO75xXXtv2SKUUJ0FABsmNQin28CQ92Pw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nCfICly7BeIMnHLdpB80NcNql25t5ZhG4mwEdW2vfNGaM7doPc
	Gw0RVcU3vHS1QK7pznVYf8CGVL4zeak0wKEsCDygkwB+mEAfiKOsJ2Ih
X-Gm-Gg: AYBFou14OjMFGdLEau3RWQcnIW87zQ2UlPseKNnOTdfZz/E05jNK66nUUnNhanr1Sf7
	z/C5YuBY3gsFVvZ7Ss3hjMHhIMXYNXkDry8l1J65Kte1etQd6Rsv1aLFb2pI+hrT1e3irbAIqME
	PjB06HNzbGkG1jSbEBWCWGLR3LQm616vYWgkNUFYMJpkgLLFWT9scM1j2fVmOkjI0ULt4Yq2h6P
	4fTGJY96XlPfZYn+8Gs7wYGLSH01t0e4e+R9F89VPZCAhEtn7MDVlv4fn9eiEWobEISfqnE5Wen
	a2nHpCL0hWawEzwu6GcFT1+8LAF38BTB19GAscohcy7SIAsbUcXQSNh/VyNut7eBtmjY+ka5xRq
	QQnf3ZCrDJvp6zcgWWrqsNJNGKnioFHJ1HTiCD2rdGs0+iPN0kujLPfdc3iKwdyR/2lMpxOb5s3
	GX846gmAk2gXxYKxGcqRKPV3NBkmue63l5WGAbrUFPJ5Wn5xC8QY5dVzCV3HZkEAI2qom4KcOWt
	2nNsnfVvyd87fEs5LEaOttOOCgUiYHgrqudEk8VQj/TctaFrpXtr0ntCc1jXBZElGHNN+qojsN0
	dduEZmFXzMjNwA==
X-Received: by 2002:a05:7301:d194:b0:351:28eb:8cd8 with SMTP id 5a478bee46e88-3515ddee11cmr6279341eec.18.1791456154501;
        Thu, 08 Oct 2026 03:42:34 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:42:33 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	povik+lin@cutebit.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Kees Cook <kees@kernel.org>,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Neo Chang <YLCHANG2@nuvoton.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	u.kleine-koenig@baylibre.com,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Md Shofiqul Islam <shofiqtest@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Zain Aboobacker <zainaboobacker33@gmail.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
	Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
	Bo Shen <voice.shen@atmel.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-sound@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 14/24] ASoC: codecs: nau8824: Ensure the DAI is marked as started on success
Date: Thu,  8 Oct 2026 17:38:21 +0700
Message-ID: <20261008103831.542533-15-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008103831.542533-1-phucduc.bui@gmail.com>
References: <20261008103831.542533-1-phucduc.bui@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

snd_pcm_hw_constraint_minmax() may return 1, which is then returned
from nau8824_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8824_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8824.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 853eb9472af9..c89889aa420e 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1061,14 +1061,19 @@ static int nau8824_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 	const struct nau8824_osr_attr *osr;
+	int ret;
 
 	osr = nau8824_get_osr(nau8824, substream->stream);
 	if (!osr || !osr->osr)
 		return -EINVAL;
 
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-					    SNDRV_PCM_HW_PARAM_RATE,
-					    0, CLK_DA_AD_MAX / osr->osr);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   0, CLK_DA_AD_MAX / osr->osr);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int nau8824_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


