Return-Path: <linuxppc-dev+bounces-29045-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CD8CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:43:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mmr3CL4z3brM;
	Thu, 08 Oct 2026 21:43:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456204;
	cv=none; b=jcFXtGG+XLq6wiPL5Yw1iwEEJMAcsRQcdUWn4l9tOs2EBu16B7dN4+oLrJSeEn6fqC2ASLZHFFBS9w8KGNV1Zn3VvLCbs2QtbzPUlHtk3c/JYEDLNHRuMifx+hTs1BFxFNGB0IGUJ+iwRLkk43AbFAcVpxyMgZZtB5iDGaUpNKS/195lQgxPaMrNXW6vBGWEMQnjYsApe+9j6fzLRcZ/G0UzOExWFueuQmxly6jML+5FW/nJpQSkkWNSOZk5S9+7fwAOijss6CDph/Nygj6Y2BVwzsFjYls8om96w+elUtchjXcJG82rRE5/ER3VJw+YCIezkAa0Cs1hZtN1w+sBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456204; c=relaxed/relaxed;
	bh=tshzH2hs2YBcBixu+hfpqJYKGYNe4yJtAc6VriLVkyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXjH8BqQz9oVX1blEov5+b5N97JgsO5Ple7evRslSGVFhwXxEIP3lv/1siG/1S0NEJoUV1r2EHOt0z1VLLniBBNoEhXqjtk/V++XgC75U4L98RAies2I+tZsF61+7Iq85TLsCKlwvS/VMri7+KeD2ljFuQXMeNAGZEoQ1CCEhFnHKhYX26sQJYM5Pc3x+vltOrLv7S6yk3CeWkOibOCZZjWIw7SD8jPxKEBM6T9mgz3cYqvMeCxt9C8glLfO9Nw2JuBr1FR67IZi+6z6/fWoREB2vUuvU7EUVdJy8YbOCP7ub1qUrzii9cU965rfDD8PNARPrqLtiIPGGisOepM2Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z2TZW5Yy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z2TZW5Yy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mmq6B1lz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:43:23 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-3518cbe59b0so251719eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456202; x=1792061002; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tshzH2hs2YBcBixu+hfpqJYKGYNe4yJtAc6VriLVkyE=;
        b=Z2TZW5Yy+yy7zhJJieYa4IY4FxWJp0WhLoWPvz+HEqj3uZecN6eTS/qhWEyxVBEX5d
         021Us+c/A5mPqTeKyGlSEG/oLa+mc94nXn4xFRKjDxI3Y48Oj/NNR5MC2zuyPPhzyT0L
         yYihe9vP06JmH62SqYD8wc9Fbq+mW6dvUGWMEFJqTIiBMjQul2PgGO66AzLEsBTTryF3
         UPOBeYLKf3GwVD04O2N+IfBgAuQqKp+wwDaT4eiIJAxe2D9b1Mx6DOlL4uVv02AFoKBb
         PDftFc8KBfiK/5CaliKFR8JOPWYqyVHN03Y6SuHLCRXTvED7IK6ViLYw4a3cZv2oR3tD
         4eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456202; x=1792061002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tshzH2hs2YBcBixu+hfpqJYKGYNe4yJtAc6VriLVkyE=;
        b=DlnG8JAHEl0lva7BMS0WPPfco3xjghwyVWKm0Hn+NMIls1mhXKT4TlQQbdv5RRBboQ
         AXnsaTuD+r1S7ezdUBdFD/fHLWm8VMFwyIr+0GfY0qEMo7WaXtx52xfNRXG2pC9Srq1p
         wFGQt7NlLWbB+KHFt4YBGE4g0XtjbyQqt1KDwK6nuDyAzf8lUsXe3Ai3VJJ/lh+5dnTN
         /oRQBSw/+VtmVo8Ak4mdHp1QMBLb6gpnkhPWue301wrUlrfMrMYUEuqFaHV28WUU49xD
         v/OH4Lgcc9wqX3uMp6IrHMNG5ZaRnz7opmXASI1HQaVR4iJA+vA2mxnTy4Ne1WJ+yEKO
         iRNQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/HHSlK5RlaB+JNHQWs+OFUKO8Xk4OjV52JtSLLXSg1VZ88ogYyyun6fC1BHNL8WDGfHe34xDs78fn9Nc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKLK7tOXtXA7R8EeOWGQ8LqR+NE/RvcxivLodo7HYojT5fAjRL5
	aCpTWMwp4+AFDJ5cGQKzMPLj8zUhlOBhvgXOfK5cLMU3BAqqtYct1Anq
X-Gm-Gg: AYBFou2+VNynbZOYpZIEdbRwdFnZZljD/I22ogyS7KlJuiPOuMvwY3gejRitUB4oRFI
	zSmaVIAY5sptMFafBLBB1BVnhSfUQoi4lXGeRRIy2M+tdrU0gqxU2Ekt2ikObDKrN7X+BvRr+9n
	/Dwsq2o/+VmWlRAhSiq5gCJANsh6w4Pq/P34B63tqobJ8sFKqm8s9cnIfKNDTDZNMIKdv0PgrwA
	kWsllUfA3upLh3yuNa5y9u6Fraa4dytSE+v5DxlfGFkw5A98bVXisniy7R2EOwKKq1nqT4zlzUh
	KWRsy4kEvqdrCShGWraTd3/XFpEp5RgNXCltaCg8nMg2MeivTZ9r5BPAf8nGExoT5V/AIVjOD5a
	T3sp704RuyFzqCJ+3cz9O2afS8e9sSKBVUbNec+K6PgDHmXILWfh52qFoXxcRRvisi1TxMmC4NH
	TY7X9iVM2S/V/6DoTdw8EE+TGz7iQ7N9IDcQpIhQR0aoY3Ay79hCpBycs5enUl+/IGDssSPIR2h
	hs12bwdIfQ80CXH9NYz3rs7oNFoxYNsY73ZyW5W9Flc+/6N6eOwP0/KRIAN+NgkYvzMM5iicvs3
	sga9uWKmG6nJtw==
X-Received: by 2002:a05:7300:601e:b0:351:2200:1cde with SMTP id 5a478bee46e88-35177712b66mr2416825eec.8.1791456201448;
        Thu, 08 Oct 2026 03:43:21 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:43:20 -0700 (PDT)
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
Subject: [PATCH 17/24] ASoC: codecs: wm8782: Ensure the DAI is marked as started on success
Date: Thu,  8 Oct 2026 17:38:24 +0700
Message-ID: <20261008103831.542533-18-phucduc.bui@gmail.com>
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
from wm8782_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as wm8782_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/wm8782.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 3a2acdfa9b85..767251ac4f89 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -39,9 +39,14 @@ static int wm8782_dai_startup(struct snd_pcm_substream *sub, struct snd_soc_dai
 	struct snd_pcm_runtime *runtime = sub->runtime;
 	struct wm8782_priv *priv =
 		snd_soc_component_get_drvdata(dai->component);
+	int ret;
 
-	return snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
+	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
 					   8000, priv->max_rate);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static const struct snd_soc_dapm_widget wm8782_dapm_widgets[] = {
-- 
2.43.0


