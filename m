Return-Path: <linuxppc-dev+bounces-29532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F2ECC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:48:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rZK5kT4z30St;
	Thu, 15 Oct 2026 12:48:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028905;
	cv=none; b=lTUuX1/iFbxRtqLArI4nmCCP6rHQJao+fpFFZJp1/R1o9YhP8uloU3ytEJ5AZhVXfTP+2Vu1IizoyoEUH2ioAMo8fMNSEu8VazuatvoeHU3RjlzNzejQVMdjctrzqfDaUTIEAxpI3yxLC9h1UDu/dY6dtmn+lGWa/gzDJwd8QgInMjrx+QOetEIUiuHwYNW6KdKSY2LjUCbhUU/CX/la3bSspb3DjkNkeEWnat9Bic2tNge/TneWEKViBUC1Tw7cPC9h/FBJ2bU72UcZIHcVQ5/nSA/PdXwn/udXvzvkhhpPV6TNQZDEy8Z1qrlZDaQFhQC3zGRi/1s0jvZXXqFRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028905; c=relaxed/relaxed;
	bh=t6Pl3gMBQYmN9D7oerWQplIq1HLxsu+OxdUd7erjjPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7nFVaBcIais58dR/sPiyyzSlGcjHRaA78UBvXWpGvBfGTcTxYmsGfDkjzPcKOtdETjC9gGhQTiXmInutVThaD284PMWgLhvjzXfAYX2bqQBJjWboliAs+Oi3PRanLHcyJThAzBXCdXjnCun6BGOs+EL4Oyzzw3uppI3OOKDsC3RubAai7D+FkC6i6fUmhVJvJgB3ZLVcdC84kn+bOed02X3dKQASYBEKPJ8vQgMo2AakG3g9kD4dGrJHxS+wHaE//WRj3eP3RGkHeot6Y2nIcjqSAYakrMz3J2ifjl7CUVKR8ek5BHTvTl7bhGk/WwYk8Ok4WaFZ3WFZZQMq4g+cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VJSZ7+VW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VJSZ7+VW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rZK0CzDz3bwR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:48:25 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2e7e742a2c7so32174035ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028903; x=1792633703; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6Pl3gMBQYmN9D7oerWQplIq1HLxsu+OxdUd7erjjPU=;
        b=VJSZ7+VWIbJooMvq/sdSsVF3q9zFTjtJyCQhqJS2rS4dxyRFBuWWwVs7w+hDPxnGqX
         XIMhML2814X7zp1LdirYaluGGXIDwLOmaWPApyi41DIzuKPeDxu2VY0WbXFJcrsnkpNy
         t2U7Mdz7YwWc2e6QFJpQp6pN96V29Rsi2JvA58DrMN+wkYwONUsoJ1SilJnNVjlZZMFh
         9hWnXM5/vjRo1LBkEgy3o28SWqqMito5sMoY97CrMj5aGiqcyj2L1wl1/uVkLbSyAV3N
         iWaCTQy7dMdhbotRbB0vZlL/zhIcowYP28IYn5+93osijOkQLbPP/8U1S49ONktE9iXK
         SIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028903; x=1792633703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t6Pl3gMBQYmN9D7oerWQplIq1HLxsu+OxdUd7erjjPU=;
        b=016aCXxKXl/aQVAfmpu2+U88JFeCqbAjaCaIwPrjcvDP4Ge00Pc1QxnhYBPIh4+d5/
         XmtmuM74ea5BrcSG0yRt3Q/bWLb92MJpiByGANafslEVb/h8sC03fP8oP+qd1Ac4Swki
         yRrDBDlW2H75DV99wudYJjPMfdAe+CRxYfSsmLCyy8WiiBIHqvk0y1LQYNKuGiik47z1
         2vz0yknieuG4/lvwU38k889yFf0G5Z9XmIT0+jUyOwZJMjx8SGoe5ssObCloyhGkIIyW
         lP876VDs13DHPSQsIwfKBw6eEIXskQvD3XPI7RPwrSR2Pxq5UCQovO2vOLfsub69Y0W+
         KuRw==
X-Forwarded-Encrypted: i=1; AKwUvBwdxQN6U5ljbH9OPsBclfYV0jZkVTWX33o5Q0lbwsJklvuPwbmc095nrCjf0Cp69BSPNBcSa7OkeetpSXk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJWZ17y/fI2exkX6hyBVeb9jf5wSt6O0+m6ztH4yk3xjX4xffON
	JWuqeNzV/1zYOiGYKc0tezXnTczrfmm//YuTjOQDXEmM1kuAoSkFL+Bh
X-Gm-Gg: AYBFou2DTCcgrXglsylPVNqyQP3uSZU5lk9aiO4osZ4tZUfaH2/8ffa0qSyX8Woz9Wo
	fGc1a5A1Vm2pEFU8JqN7/tqZ5AE269D0ko4pjO6uAwXQB/6iuFHXi7N7njAnf5+Pl3HLjl8L4tX
	vOYFRxLzOIDAtbsJJHTFdMJSq/XxH+aqBfSaAck/0adEFGXiW5RmpFZFyCjZ6GLkPEb1doHwyBF
	9yhB5bfOo5LZLxglo5FGs56uQCyWCeEdg1BpTTo3hRZHF8QuYwiMcunTo7Dp0B1QTUcAh/C+60r
	oHvllohqX2eyLTluFRE9yIEbf5NvFLQkKbtyOpqC1XATeYWgk63/Q0K7hjB6FRK/GyzvqY0HxHb
	AHiNk7+kB5fmunXBkNnBYn16d/pU1sA2xHkGUYAgSc4NgBDYe0qwdzqqwoh4fygLHrNB9rxAt9M
	q+6Fc3IKa9BKGYbqww14PdVzGpgVz9K3dvpNFvjBi2lI1kuqrvRnu/aP3rAeUl0yoMtI2GBy/Pj
	+4cPGPKX+XbPzv8LDz0FJ76QklF8xYR+R0rKPWioS3k/0MwwYUUXBS2yPOrUYfEpsRkFAEG8NrS
	KkZVaxURXH/c4n0=
X-Received: by 2002:a17:903:1b06:b0:2e9:5d1f:dfee with SMTP id d9443c01a7336-2e95d201631mr3403435ad.25.1792028902474;
        Wed, 14 Oct 2026 18:48:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:48:20 -0700 (PDT)
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
Subject: [PATCH v2 16/25] ASoC: codecs: wm8580: Ensure the DAI is marked as started on success
Date: Thu, 15 Oct 2026 08:43:15 +0700
Message-ID: <20261015014324.5569-17-phucduc.bui@gmail.com>
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
from wm8580_playback_startup(). ASoC only marks the DAI as started
when .startup() returns 0.

This currently has no functional impact, as wm8580_dai_ops_playback
has no .shutdown() callback. Still, return 0 explicitly on success
to match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/wm8580.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 9bc5d1e795dc..cee80da8f753 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -852,9 +852,20 @@ static int wm8580_playback_startup(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct wm8580_priv *wm8580 = snd_soc_component_get_drvdata(component);
+	int ret;
 
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-		SNDRV_PCM_HW_PARAM_CHANNELS, 1, wm8580->drvdata->num_dacs * 2);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_CHANNELS, 1,
+					   wm8580->drvdata->num_dacs * 2);
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
 
 #define WM8580_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
-- 
2.43.0


