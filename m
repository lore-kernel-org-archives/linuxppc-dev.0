Return-Path: <linuxppc-dev+bounces-29527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4CFCC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:47:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rXg5WQMz3bsm;
	Thu, 15 Oct 2026 12:46:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028819;
	cv=none; b=nA1BD6zWNkmlcqUT3EWE8pHhdcHpOr1fJaFOJ4dLVILiDKAwti4nRnq6vjZLvGweZVyNYcyTnTcac2crcI2MZV9TEPRDVSuJT3cAMfnPkCxwriI5rojSttOmP3+vP7G3R1KSbhaSQQHh0J6/XthJHLNwME4NzqVrBUHRqf8P+TBLuD5XoirXG7UXRL+0Wi8077znyfKJdInuE6rahZeHX7R+SiGTy3ODy7xuiWE5VbJBDJ5wjwE5NVtKUH64EaDUzdi1wIu99O7lWRZOVvZ1t37PCsxp1ergY//cRAu2tCYAawLuoDiMkwCXQQe6Nsz/0a63+Q+o+N8Q0EQBlzFopA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028819; c=relaxed/relaxed;
	bh=QkExA76YJWwf2po0CbLVw6mxayxnqBJKULe/shJjNF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ddt44/LJuSr6JeLGWpX6MnM6q7/U9HPc42LEplpGYh3B0Y9b+CtwVC49lrPeC4LlygK2wwxGOJuau5CysFBT4filhgvwSm6+FBbNezNpmwD+WWmgCthpXhOkGU+2+7dgFIrQu9zsFbCudMMt0cwIBXJv+/Yo0bt3h+uOJvljuEHoSmp/hm1CPN076IRosBFIK4FRYldAufIuHVn1SaaiK++BJv8b6oBcCB7Ieyox+fiqrZ8duGJIRG9akfqX1B3w2DnB39/F3dUbzniw++KhVxqr47FXVGdTK/buMWQ7C/ieR6cJHXnUambX5DF1ze5AKiibgwjTgawBO8idWGJkQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kuN9SgT1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kuN9SgT1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rXf75jJz3btP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:46:58 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2e49fbf92aaso28036025ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028817; x=1792633617; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkExA76YJWwf2po0CbLVw6mxayxnqBJKULe/shJjNF8=;
        b=kuN9SgT10145CQYCfD3pJSDcMytjHO7g7MVHHihxvwIXCwoNwiFIhC8fETHCo1gO/g
         qRf4KRHMg8Kdf23v2+Pw4kD2Ka8AfNvh9F8Cc2ZCmiz+aHKfioFOsrPF5+hdOwjz8a18
         gzISFueOddsAp6MYeKX7nuVmoV+t2fr9G0mZ1pouJeNLOv2Jcsqdc333gKrIyvbXtM4p
         rGX7NNPRU9KJFczq9F057Jfw8dIokUngQUHP5jna0sZM7iy0Wo9ECxvhvjtAeWFLZrmV
         0X8fihc/OQtfwcS0VYfIwvO3BUN4HeaNvplOV+syMmVLjxb+05UPKKqbmbyJQX9iA151
         5Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028817; x=1792633617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QkExA76YJWwf2po0CbLVw6mxayxnqBJKULe/shJjNF8=;
        b=s3tYA1ZsGppVLNl4usTfdQ8qov89fhG4Gwvy4yB1IVuCwgrHFY8Zxorud6s9gmnm4H
         2qQBPbZ0lsYY4VgPZsY5oKFcDTXEA22HQrGMzS81S1pe15HjaO/BDokOSpcHboHOBPMN
         fONHdxaLUTUI7N361e0A7T0FDBp5JbjEYsbSv2Eo6DNpOGMLzvl3mSe8xl5w8L3fTOgr
         Cj1cV9Z6MdlKHZlG1939UESVeT5yzfwk9ec218NYnCZsxPI+NRl9bkPntSRwtOjShtqj
         riRg7GNNUt2HuivqpxjD3EJOUsi7vHz1v2YaH0/SGWqM6qM3n968DhSL/dlDN7jjRwhZ
         i+Vg==
X-Forwarded-Encrypted: i=1; AKwUvBwENi3OSS5zxPWWByQe2XGYgKKAwl7v4U47szoEXQcaRzmp5IOoz4yyCFipD9ycDjjFltk4HBcswCBxekA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLLkvxF7Hjj+dRp2yTl8FO5wnF8iS7QZUi3kU6V6kMz5VGYg3xJ
	mk3n439ZQJy/rPazQzkcO3dQhSc47OV41a6cxV/ilRU5fX2DmzXr5uOo
X-Gm-Gg: AYBFou0yKUMpLqKQlY7hU+ag1lauh2d2ho/tQPkKkIqlOwsGClZdVnipcLXn8LnDY/9
	YI3+OspNSsm/wE9i6m12+3L/oa/ERek+HUxXDjfC5x+dGrV44XLK3+noXa7Rbf0iGrQ8RTrjXtw
	HadChZP+COAzPsxJyFTG3EN3BNZhM924MNHSofbIGsNhMtUfD12m9FNdpyZHI/ZIK87yASSGpNR
	bVrX2TRYzDwsDmMUGsgXg2tsCA8x3Qq52ChEQ5XzNzqV7qVpT7zkPKdYa6KUrpHPlbxysuoPC8Q
	j5MHbmb7t3etVIr+Q5SQs/c3Tabgj/KGEtpYH8Yw1xbbJtnOH15iEhvzDbnsc2Tq3gP+OS7+I+f
	BWtwGG0/cFaxYJ/YfUaO68ooHO2+2kMsxNRes4ieEf6N6zUR87W8WshlOgfGNYq005nTv3SuFYL
	6I5N2K+rTh7nMbtaOalLqEMenrGco2XdbeBggGxs8O0puAmrcNdOuW5mZ/erlY46sgbCRv1/HnR
	j6rXvw6TZ7/4j3TIwx4SOJ+d7Ec4AiSOhbfmPRtdNSDavin9NXPZg8FEsW94iXv/aIPPjn1vQ+U
	FTbiCuJYFlucku7FiEvywTOF
X-Received: by 2002:a17:902:ebca:b0:2e9:401f:f0f4 with SMTP id d9443c01a7336-2e9401ffb38mr25578395ad.16.1792028816992;
        Wed, 14 Oct 2026 18:46:56 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:46:55 -0700 (PDT)
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
Subject: [PATCH v2 11/25] ASoC: codecs: nau8325: Ensure the DAI is marked as started on success
Date: Thu, 15 Oct 2026 08:43:10 +0700
Message-ID: <20261015014324.5569-12-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015014324.5569-1-phucduc.bui@gmail.com>
References: <20261015014324.5569-1-phucduc.bui@gmail.com>
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
from nau8325_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8325_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8325.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8325.c b/sound/soc/codecs/nau8325.c
index 2c95ed00a681..5ccf4c110567 100644
--- a/sound/soc/codecs/nau8325.c
+++ b/sound/soc/codecs/nau8325.c
@@ -489,14 +489,24 @@ static int nau8325_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
 	const struct nau8325_osr_attr *osr;
+	int ret;
 
 	osr = nau8325_get_osr(nau8325);
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
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
+	return 0;
 }
 
 static int nau8325_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


