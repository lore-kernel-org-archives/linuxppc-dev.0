Return-Path: <linuxppc-dev+bounces-29528-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2CFCC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:47:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rY74CJZz3byT;
	Thu, 15 Oct 2026 12:47:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028843;
	cv=none; b=YwKWoyr5AMaDHZmkdIWbuAy72+UbDJK7CJew6hFxaOqkFWSJRo0k2SQTJMcSBCEwDa3+XaIRJ1jxCk9Kkwl1tApgaxSpHL+ciaKswvsMtmBgMbeNtliciRQ3CsM2KVyb37e9LHZ/K2iybo1KuUnhJtjdsUyh4Aw7Lb5om5YIMgavROb7v4e10wlekludkl14Nsydv8YeTrqfOT1gZU0BzSW47DzIHTozehMkHSaswZfJURJmWjIK6WZgmj86cyhRXooM1Y965XyxmJo9JMj/donrQNrsLPR1laX5qgQfmZGhBgEfjvCAG+/jXe2NBeOnodniD8S79n0go48Kc2ONRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028843; c=relaxed/relaxed;
	bh=sl+xZe1w/+ufceVKXDka/4tzEgH/pdjCTIAX9h5M0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W17rnoP0Zof+1i6e5tn6RGphynHFgAU1nryk/Nw2yp8Gs5x29Fghf5OSJLzY1wxSgzw4Q2vrCYxQfX09vBGxFxyfU5lggsDOgYQMFfNI4UxYodQDk0GIkQz++3TOAz+8OFclGQtSwkkNDJh9ZCIaSaHS47fEnuQxUiySR6wkqBoIL/v9CHKsrdYpyUw1phsODlUNLd5C9lfwFMtKBGvFdIMYtIDYlH1QxoGrv9r9ip3dI+4O4ljI2Wr+QlI5Unn9f/57gzChtFL0ghU0AQuvE8wPOSdNx8mRoAdH56/urF0a5KoGoOsIqddD12yW80gjYG2Dji7YNt2BexWLW3VQZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qi846ItR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qi846ItR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rY65zqqz3brv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:47:22 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2e8246b13cbso35373575ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028841; x=1792633641; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sl+xZe1w/+ufceVKXDka/4tzEgH/pdjCTIAX9h5M0vo=;
        b=qi846ItR4/Yfq55hId9it/0OaceGm4A+l6qvj5kRzFVEqzFrrZe07hl+xtEc7yeutS
         DJMqyfd4q6g40z543cIpIuou8wUKAX3VCHyNVHUEebIsiJXbuHGZfTja1LZkRbr9u68Y
         C5g7+Tvoz6y2H/UhDnJ2ONomAxXis4VNS9o93bvsnFgtGryV3RDhEpMboNF2HIND6AZp
         z1Amb/xeeoEsqE3k2/YLvN58XVZr2eujaPZqbj2fEaP3rP1sAMkIH0hfs8aWst/b+tk4
         1yrMITjUJXEqZNcCn+Rf+cmHay/7VnRMGssi3Q/0cmPf2hL3f009MKAWuaY2OmOKRiql
         NmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028841; x=1792633641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sl+xZe1w/+ufceVKXDka/4tzEgH/pdjCTIAX9h5M0vo=;
        b=iSbXVBu5TyJ4Tr1pb4iXMYVS6OJa4W/AZj1KYPILm/jaMhOVmoMgGLOOBYXhz/1k8l
         vpyK49FU0L1zsqodAro/ciKoP73zGHKdR230cB/OagbNtRO5ouAqStbF9PAEvXRtxg+c
         ggsyu0L8Zyf1oxLZTkPHYFEvBHp50nSS2QXfVFHyvuiJa2iClLl+c8uTekokXNUYiiqz
         qLWX/NoWP753cRbDtxlGvbZ1N4xSvoXD0UHHZOLDiZIe6Dq4mTxA8+6ttuiRWgyY1WV1
         xPYUVdo0QnDCJzI5FsW9BGeVC+/kMqI0IgJlZXsVdq/XbzyaWT01iV10gLiAnHYsZyUe
         F/Dg==
X-Forwarded-Encrypted: i=1; AKwUvBzQrhLSj5CKxlyPTdX5E/7vRmJKkFAYzNgfqFtN3Egn66x7ITh2V5cjodI7wSOy71mf/Gy3MFfqT3qO0VI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJd5CsPy8ykTzwi7IYLj7G3OAO2GdHPQc8amZj4JVsSipFVHMPT
	oFCgMb/MZbVV8tBKmP/1Y4IEJYUruukEmqQrIxsxIH+dUh62CZXUIxY4
X-Gm-Gg: AYBFou3MUgENjlqFWME5TCTRq9fNCpBR1AUAb67CncBRgVU7m407E3zOZ0O/8DH5nHZ
	oKU/mjNRKxIbXspZDetny4NLFXAoF9dfyxf9ZHP+n2H/DFteiRbAvdR2jv2BFzeW0uEZYlFdsDv
	Zrmiy1vuUArwUsH2da9jo8IKSNCEJluLthqfBe/Nwzwao96gMcyvMYTzpjtksmTogIKlWpjJ3uZ
	aapIKiI97I1XeSwZx93grssDfG0cvd7Jqf6TCeQ8b1A/eF4ruDbO0HF5bBWF31AWLOwa8QDo2QT
	wvmNEuVtCRT/ZQ/bwAYxjlJuBMVovcgyuwMsCNcvVFfJzyVyoepXRX9Gp/masgU2/yklmu3D2DE
	sLT8sS8jYYXoKEom0w0upm6zdZCkGb0F0sWo5WyVVd5EBQ/TYvRMeCD3rOwrzGeb94gP6O2dLJG
	EDtPeQAEhTBkA4+H8icGmzRV30nHET/xx7DyTYwACeIORCnwyQ8WC/YvnojJNZbA6MOuwcbMjTs
	g7rXzWWWqQDGE3Hvni6XVy+S5hZai0TuIdKrfuBou4ELCDsBrbsJRzG4zTRqIHUtaDN4gymJwQK
	fsIIIqcyMvPNqQ==
X-Received: by 2002:a17:902:f54a:b0:2e9:628d:e9c1 with SMTP id d9443c01a7336-2e9628df363mr1150385ad.26.1792028840848;
        Wed, 14 Oct 2026 18:47:20 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:47:19 -0700 (PDT)
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
Subject: [PATCH v2 12/25] ASoC: codecs: nau8540: Ensure the DAI is marked as started on success
Date: Thu, 15 Oct 2026 08:43:11 +0700
Message-ID: <20261015014324.5569-13-phucduc.bui@gmail.com>
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
from nau8540_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8540_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8540.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index d4211a76b096..09e7f31a904d 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -419,14 +419,24 @@ static int nau8540_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8540 *nau8540 = snd_soc_component_get_drvdata(component);
 	const struct nau8540_osr_attr *osr;
+	int ret;
 
 	osr = nau8540_get_osr(nau8540);
 	if (!osr || !osr->osr)
 		return -EINVAL;
 
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-					    SNDRV_PCM_HW_PARAM_RATE,
-					    0, CLK_ADC_MAX / osr->osr);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   0, CLK_ADC_MAX / osr->osr);
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
 
 static int nau8540_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


