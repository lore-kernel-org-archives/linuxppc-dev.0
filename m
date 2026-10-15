Return-Path: <linuxppc-dev+bounces-29530-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E93CC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:47:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rYj6twbz2xbQ;
	Thu, 15 Oct 2026 12:47:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028873;
	cv=none; b=KDCrnCChJjqpO7e89Ll7hZoDTT3frvN6w10PWM4VXz1ugTYCY9LbiRNyTIj/XLLFrU8cFAo6SSQT//sqN0/B6z8HBEsaJrKjpGoI+HyfoQF1RdoxS4C89rUHkPEO8KWfixKK5Ecdi4cUWgQjHoRwk4L42tsW2ofqyuxu7ewyk7xKexXNnHn/ZbttMy368rwZPW33HF0G5DIqOPeOHJHhs3AbAoaiT/dPQTrSR9Hl5f59bfidsYaluSzex7ia3aMaXNSRUDOTTOBTIs2POeNSZX0ysSd9f4FyZDDIwwwzsK9dpepUa3qb4RPMXVOAWt1C/tJ68iTMYDbJeYzJhfgIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028873; c=relaxed/relaxed;
	bh=r52r7lHoOPMhC++VZB/BAS85K3dCRyowF6eP319pd4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7GTBMHLieSZBEFIznj2QBAEAEContMAOJ2Z9nz6c70xm6lIamSNk85GRTvOO/B43HkLuyuK2g3wyRZVsCxAzmpRXIFlwt8v/yz3Z7jz32AHsF5kSRaxKO9U8EhSmVKx3ygRWUUvYUlNv6Anx2OpOtO1hoagLSDgJnrbhiG2gohyS7XOWeppXNY3EfsX7YfwBYgOoYq0AX+HkPwt7ugezvjdR7RVnqs9/tp7i/ZC9U5K0iDaTCTYYSU8fqzdihB6Z9WF+eVybCvkTSt7kELksqElZITvmJ9/6wEPf3rCsyoBHpdpQkR0nYqjdeG0be3NTM4Vigq5AeedldOa8BBd+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ChxAVltC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ChxAVltC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rYj1SMyz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:47:53 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2dd76b1361dso11009125ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028871; x=1792633671; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r52r7lHoOPMhC++VZB/BAS85K3dCRyowF6eP319pd4Y=;
        b=ChxAVltCdiF7Qpb9Dl2jMDL3BFa4xyLrRBL4UlseMiNKOg+Md3lns9H8Eo3wn0cF6z
         iOdOfZLSCsBNrX8GI3CXKTHNKDbNpY9d3Y5COFwqLuWSiB8T3uco8aauY5IQcSbmGX4X
         qhv8fzeVE80uMUpecGt9VNRRKVmcCr1LNcA1voffSoDjwQtpqFQ5M5CLbvWRmVFS/wEh
         ySwZnxAl7+0CZek/mq1rX9HC0bTx1+95hktRCgOcWKSZMjBq5KnJocNTtQkNyieOk8NT
         luxw/VSW9W20x7ae/BqorCcSHi2h50hdZYVLkw2Q9tt8QVxZTviY++c4zrJz4zdU9GTY
         okgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028871; x=1792633671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r52r7lHoOPMhC++VZB/BAS85K3dCRyowF6eP319pd4Y=;
        b=AysdwzzFVrqlVpfs4W5S0u9V+bpIIIWhttOPINFF+nRZRVq5gH2jsVfTTE3HJseIb3
         K7pG8o0Ys5yx/uy8bOkpfyGEyKPoH/k1nVxBmsiKRPmvmt2OB1r/iRWk9eY4XOulR3d3
         Ix3QWryRWkEadLmwQbM1IG4etat3wTNiYkDYBppiXyCl2rdpC64eyhcfzNRIjbXKGBsM
         2p/TNy5MbXs8I91XK3+RC4V9DMgTCtEMNGcV49Y3uZd9wnUFOMAdFsucDmA3NMI90/S2
         pEN3FC54ukrru/4B+EIvJhl4hlSVvo1okkstqdXgOCgpI1Yb9EAlV4tnAElwB7Mo4YXn
         cWrA==
X-Forwarded-Encrypted: i=1; AKwUvBy742BwnS6O8nRj44N9DcETyvzxhDgKzvTq+ERrBoYtbuWw7zOPwhY2Oh0vyTTc/enhldzzZUGVJ6Wp9EA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIr0jwJbKTv6S14tYzLwu+zRVBVOevh3xEeB4ETwoXg806ZilYf
	XEXDaLMMcd/2/PSAKdALrBhZ7MKQwBsBGoTJHfLDJoQ0Hi+hCVtmJ8eh
X-Gm-Gg: AYBFou29pHitScNMN5Zdvf1e/ucTX88zaKmR2Xcznza44aBViKAriWxPyUaSnN0dmxD
	UX5tVKnj79avEbihUwbbo9iM/eM9/xpKKnaib7kQXhZ2rmTn/QKKiuCKwZNSr0uW9Zxjpqu/eV9
	nLK1+4xkSYdNZon43grHOP8/LcntpJ6z562EOZi3o2HRh3Oysr05NjAqC4YD0DwWwo/UNAUdv5R
	PMMEPBZlPIcoOIbZK19tCufSnLvkhZCmZdPt7LJPc2vLoYyLDGSj17S1aR3xFCq3Bfnfd+NKCL6
	mEvAI9EuoqFoQPNFhpLPt0sjDQlwPzINyLKs4taUk3a61ycvXIrjNKW0ur7tyokVyEe2RYXJwg1
	5Y9MKQVF+055leJrsf11oPfUDvhGciLOshFdPIP7RHcJLGE1UiL71xtm6rYsc33G6XF0TfO1m00
	h+765W/B57YqSk/twgCiX1R5k7pebjNqNxsvKRT1Ylvlck7Cav8twsTGkr8RzTswuSiGlSRVANC
	JST18t3Jt3mLB5IJ8lRGm7dB4Hse4XzEAJI8gxPxbuNBBKgdsFG7rWMXTaU2gPekK6ECA7wTpYy
	M3e8J8IkTXPKD+E=
X-Received: by 2002:a17:902:d4c9:b0:2e2:dbf6:3744 with SMTP id d9443c01a7336-2e842ce7d6fmr143717775ad.42.1792028871192;
        Wed, 14 Oct 2026 18:47:51 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:47:50 -0700 (PDT)
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
Subject: [PATCH v2 14/25] ASoC: codecs: nau8824: Ensure the DAI is marked as started on success
Date: Thu, 15 Oct 2026 08:43:13 +0700
Message-ID: <20261015014324.5569-15-phucduc.bui@gmail.com>
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
from nau8824_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8824_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8824.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 853eb9472af9..046cce9192b7 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1061,14 +1061,24 @@ static int nau8824_dai_startup(struct snd_pcm_substream *substream,
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
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
+	return 0;
 }
 
 static int nau8824_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


