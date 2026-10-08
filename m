Return-Path: <linuxppc-dev+bounces-29038-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBCFCA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:41:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mkn1RdGz30YZ;
	Thu, 08 Oct 2026 21:41:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456097;
	cv=none; b=Ssa+dedMPkM4odtitzTh+umlg02ZzDugxGVxRT8g4ewkibmizanszeZNOu/9i2tVi+eXOLLS2w5b9tK8UtgkuNToGffSy12mVhSt3T9p5YDT1vKjA+2VmLhO4KKMNMQbq0bFecoFOj6zJflTraTCNHsna9lm8BMb4c1Y1noEyApmlsTXNNvfYIg2TipsKNRycAC5GxP0560ifcGcbhXhcoH8E1K54Z8izx36aUTFoVIAMHAu3tZdp/oBV1jOfwJB9zbLTvjyzpz3yPsEhIXLZtoEggWj8UMq7YODbYUoCaAYEyuoVMuuvwxoNxwU7DjE510KCFbAx0iqZ7DZowRR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456097; c=relaxed/relaxed;
	bh=v/S64Lx6xVOJYbkzotXNTKtSzFgcjJur08r/Jkt4vOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+ArcMnRpu/Jv+KonIaJyzqmtHu5BdNcp+Et14sHxXDHvGuJg/T9WpsZrSsbvSLTBXD6pRxdB4HhK7wv1ZYePlwLeK8V9oTn7rfAto/dxC439qYX3pg2ex3nQvoywfZ2U2QzCLp1fcKJlY9oT0fE+ZfCeCqPmfhQEnUf/pmN00VtInvaZ/SUjhHJ2J362SF2vIaNjZ6wQDYMOljPrHs9Zk7AUWzhbeprF3mm6Fi/foKCL+kqOMUk7yhTp21ETAmF95uFGxTeqYd+LmG5qSO4ShYJBI8nL4pye3RPu4R/PW3X3Hr5RKJ/gNITZYz+8tqBS3ezQjRin9UmJMQIxtkZYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N06cMm9V; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N06cMm9V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mkm44Hvz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:41:36 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-34bb8b31647so7926925eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456095; x=1792060895; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/S64Lx6xVOJYbkzotXNTKtSzFgcjJur08r/Jkt4vOs=;
        b=N06cMm9VJ1oOVcGGm9A2j/gRQk4xHP4/iSNSix3qiCia03ma0LN9UR4JCuPdb/1j++
         xtMrrZYGEARmGXBUx+dacFugJ+AHG6k4H3ZxHNw8W8AcbliTzpt6xdZKDPK73NbcLT5w
         XLzbtuq9Wqtvor2XNqOl8aRzwukTfHhGUIEwg5cSa6rFrPwPx76jYZg9CZ/GScxlMV7k
         2hJNnDisDgt7U1OzYYuB02uOa37re7JhVSDsC9CO60K4BOx++UWeRezjyjZzedpk+qg0
         wA1vl9377j5/VLqa7YbyanqAp6jSVudnf+bqO5QlS7UXWcNChROdUhe7J+FmY+UHkM0d
         XaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456095; x=1792060895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/S64Lx6xVOJYbkzotXNTKtSzFgcjJur08r/Jkt4vOs=;
        b=ny0HlI2i7WH+5zUmo5jqapdxgrHPcOMOSN2cfFCE/ZdQJMr+qzwvoA5+EkA7GJBF6u
         c0jfj+GEqbG/9O7hQ7LCwuUoQIuBILvmUomUJxvCe9y7OmascZEO/bXNdbIdhoky8rtT
         mhqdKbkrWNiGHspMFgreP/IpiUVyLyiuufaf8E9X71tnIB9ZYP5s7xsmTg4oImphIVer
         5548QZxZl4YVxObkFpd+quCftr9aCTsXydV1YTFyFFZYYcAylOnJPZcKUnf6H+uRm1VC
         yFjYcT8PN+QEeSRpdgvEAWuIQ/i7u+T1nbEb2rL/Az6+6ASGpUL8XsVmKQnYRPL5pDTU
         xErQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4CTiRQ9nQOgRnTtMCI7nieU0lQnbgx9tBF0rzhomuzjYxIZq+k86gBJdqoL6fQDWnpPN5VeOtMNi1y14=@lists.ozlabs.org
X-Gm-Message-State: AFuF++njdIAXy+fCiAtZaI1zrRp/Vaw212txekdI607ENSNqbH/tiVZs
	r7VETjCGdJivI9ILFF1QsgmDIDGFhY2qpjg59IlQbY4/CLId1HpwElLi
X-Gm-Gg: AYBFou3Z/9eTGfx72Oo2CxZbVz9u81M/p3nfbqU09khIgJzRdEpo0XxurdZoswbkBe4
	rcjkKd+pjVd8R64Etwoo9LnB9T5rcoNV6CKZAqrI1qdQyzJevDt44z9XKxIfv5FjOmpa9oadlM3
	Utb5lNjInQAmEJqqOKxm1rRGoYykr/fTUERFVJtFoKVuAPdwypzgh2+2htJPoiOC5oBl1qxRFee
	IOuxKJR9WXhzKNywK294VezlV9rD+ZE+qB68c37y49o4wtix2OPlcJ9/Z/fcG8wAnoIfdRWSZ7O
	s+G2iPXo4oBBzF4DdNgZ+XYDibnlJRfJX3BYdilzMiWjE1TTQkNHOiACyWVPikY1sVXCxlcxEar
	DwLor8tKYrmIQAsEfZKEENnjTnmMgyGTeucskYNwOkBmZl+6+K5Hi+r53k+AqRj7JaXNSQLYJlV
	qLmBtjvnUW3z/PZurXFbVYv2Lbf8HZMvUl26ODMVhW4pe8iNceE/QPFPI2Yo4Q5YuNm+gc5pL2i
	q620x9emX48WoSnAKArZe49aotHNmWV5/EYSQni2iEI8sVFdDHiGvSpjBb36ZB1IaK3vlNwR5eO
	TbCcpwktbibpMw==
X-Received: by 2002:a05:693c:895c:10b0:34c:7e54:65e6 with SMTP id 5a478bee46e88-3515db9c59bmr5695422eec.5.1791456094502;
        Thu, 08 Oct 2026 03:41:34 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:41:33 -0700 (PDT)
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
Subject: [PATCH 10/24] ASoC: codecs: cs42l42: Ensure the DAI is marked as started on success
Date: Thu,  8 Oct 2026 17:38:17 +0700
Message-ID: <20261008103831.542533-11-phucduc.bui@gmail.com>
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
from cs42l42_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as cs42l42_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/cs42l42.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index b5d69d5516a6..f6e4bf6206b7 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -890,6 +890,7 @@ static int cs42l42_dai_startup(struct snd_pcm_substream *substream, struct snd_s
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	/*
 	 * Sample rates < 44.1 kHz would produce an out-of-range SCLK with
@@ -900,9 +901,13 @@ static int cs42l42_dai_startup(struct snd_pcm_substream *substream, struct snd_s
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
+	return 0;
 }
 
 static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


