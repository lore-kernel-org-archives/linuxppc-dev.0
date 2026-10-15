Return-Path: <linuxppc-dev+bounces-29526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24251CC6B33
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:46:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rXP5q1dz3bxL;
	Thu, 15 Oct 2026 12:46:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028805;
	cv=none; b=D7YuzB+84z7fZuMMPKkXCA54gCgiJ3uZkVqAZRY/ftw2IiZUwQ9TN7Qii3HIkvozPXHKV1jMCeyX0UYOSpPCokmVgLBDj8o2n5LoFpco/IdQ6pSAy9xi1X6nyyFLFF4qq/czbjbNgxW7OLxJeIA6pJiurijghM8z+Sq1IEoN5gin8gj5mhit3p0jdZZJzL/XzWKqJOWyryOrYigsccUqlVUSIELddn8mKbxfrwZUi3t0Nd/3w8usBSDnjIvhSgmj/dGVuS2wo+eGXur3EEDD7Y8S88Ajmqi/0Uzw3pXpKv5SoN+jE7vqE4iVliquyX/srUP4ImLmg5VhFggXeZpJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028805; c=relaxed/relaxed;
	bh=tNKaoas0suhXoNZM631qYPKJn33cxyMQnmMBR8n2e68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FagQgdBOhO2LCE/svKuRmWS9iDLsMqE0fNXIrsaIikcT9UyF3A7OuKOcSc0Xq80+o9EyeIjugdqNsREkCvHEdPsAcH+8Ye3SHVtCVzXHcp0ccEBaCqJalimTsLS33dXiGrLw7pIWT1HjD+qsnrzaOLQojFoRHs4d0M7iaRsNLwSL1Od7bV2ZwyiWAic6M5kXbzVuDIjh6m7mNGHiZ5J/7zU3YnJ3HIOrC6hVIDu2JfrUm/vy6q/g15POJxUPh3rA9FxGzXynZb0Q67nDOdjUtLiSvODCi/H37xnuaicbm2L3rgRMp+X4XodooRgg7MYuAyhhQMWugcz+SrmJLIbBHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EFV528u/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EFV528u/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rXP1CFQz3bxC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:46:45 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2db710396ffso36899965ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028803; x=1792633603; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tNKaoas0suhXoNZM631qYPKJn33cxyMQnmMBR8n2e68=;
        b=EFV528u/9BYG8vRlieJIr8/+qfZrjsg0K51Gjj+rqRVvUEjIaH1HL8ZKxPM/F1V8Pf
         RxpnvJ75R2uhhfUKtB8vsKtUaf4lNa8N84c15zI4NSjBbQsDsd7mDYQxYcuyx/Pgvq2V
         5Id8Ocrsa4aCmf4NbDg/ULkFCtuYLzQRmeIIxa/kIcVnAfInSZvEfw/tXTEiHadD65ei
         7+cTQFBRJHI+/MDMeRgf6ImL3iNFDLyta3I3p71pThRLhFLfJ+Vj8OzXpOk4LmIzEBTG
         BxvhZ1mVqikB4OkrTrG2X7QLxVj64Uz76uhqaw1kiwZnDVO3PmlIHIqpDYj81xK5QZes
         g2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028803; x=1792633603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tNKaoas0suhXoNZM631qYPKJn33cxyMQnmMBR8n2e68=;
        b=OvtWXVcUsUA05WLhdxoFpX3LNbDZRZUEEntqtNiexKnAv7KT5TIjFTDUjDPCDM/ItU
         w4WQD8/yaydsb7J6bK1UTspKbwarNPnnQ9SzEaCEQKQSmJprnx0zEDK27KKAGT5o+qeZ
         loXuW3i6n1NzSptvdqvLWHFu3U5unWJ9dMdaS2fbiQ2Up0ZWS+btRSi5jeCWeRiSfHgV
         WcOvdCBocZqKiOpOHf0Bj6WmeBEnW7T/qHZCEX41VrINrBy+jEmkZYMzsOgiXXiFLN8W
         LbUFqCQMLjA0qIK8RVj1u9xlH0c6vhfgYD/I+Xmn8dvm93kByr/HWWHFAn8kQaqbCGgN
         Cd1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwUaNZDDxCt5yriC3LzmoUW1u5Q4AzikaNf9CwjsiHQvx4/uRsN3t4WOtnvIzzZrrmms6Y0ZwAc2sBT0LA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLiyerBUIKATz51W3C0KVAvsp6buH4HcjPt91m21qGhMFgwpPLY
	aqJkgIz9BrX+81wgqFOR7Xq64LprcHu/IPwu7sr9REiz935o4BYfWHeb
X-Gm-Gg: AYBFou1DVO5lX+knYuyKYtJML8FwqQ6DoFFkmij+aS5gJ9wGy/EhBXQTCzwDHY+S7Jq
	Qsc5JLfyLfRsFYpA/YNVKk3z1CrQj+svjfIFwo/uA5upOd6015UTGTLZ6XuDXvBFrNH0fuQ1geT
	ucKyANHD/Jv0MvBDpAxFatd4y3w/SzG5qkgzRMfCUa1yxIrjhz2+alxHVjgoL/pYJYeXGNNPW3s
	AhHNIrfG4GQqLV+eoXF6jyUwd0sYJ0HcUygb5G4Brnbh0stIlunZcoiuMk6a8I7677tjubf1FZB
	bGw19MSJ83CeZLMKapoeiF4pLTLGgonkywBWnwcJ1x2kKy8OlB/PihJovxiiu/gk77i7187t0Ab
	BVQkqK28vkHvAwGIcYQuKjofOc8+ESYPvWoeZAtBog0tcvOwS01m/kMLTcoFz6k8YJidzyV9nUf
	+ZJcdT/AqgPMVKfaUH9bkZueBiIFcOdmblNvSBoKkrsSJFbn0iWxQg1w/6Mvo8Kp6U3+cDosFXR
	EeEDOlM2+X8IG/8d/+Z4thQ9rLqVwP0UUwjr1Jz1Mu4/zozUuu0Tpxd7T/7L0pf0GDEl6/mlTzz
	dWuiMHmquQLGPQ==
X-Received: by 2002:a17:903:37cd:b0:2e8:5857:b5f4 with SMTP id d9443c01a7336-2e85857ba34mr106063185ad.10.1792028802766;
        Wed, 14 Oct 2026 18:46:42 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:46:41 -0700 (PDT)
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
Subject: [PATCH v2 10/25] ASoC: codecs: cs42l42: Ensure the DAI is marked as started on success
Date: Thu, 15 Oct 2026 08:43:09 +0700
Message-ID: <20261015014324.5569-11-phucduc.bui@gmail.com>
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
from cs42l42_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as cs42l42_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/cs42l42.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index b5d69d5516a6..18d6cb9bfa2c 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -890,6 +890,7 @@ static int cs42l42_dai_startup(struct snd_pcm_substream *substream, struct snd_s
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	/*
 	 * Sample rates < 44.1 kHz would produce an out-of-range SCLK with
@@ -900,9 +901,18 @@ static int cs42l42_dai_startup(struct snd_pcm_substream *substream, struct snd_s
 		return 0;
 
 	/* Machine driver has not set a SCLK, limit bottom end to 44.1 kHz */
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-					    SNDRV_PCM_HW_PARAM_RATE,
-					    44100, 96000);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   44100, 96000);
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
 
 static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


