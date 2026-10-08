Return-Path: <linuxppc-dev+bounces-29041-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24DFCA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:42:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mlf219Qz3btX;
	Thu, 08 Oct 2026 21:42:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1232"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456142;
	cv=none; b=jxhugZp16mN7vmuDwUV4h/PQJJtRp8Ng1lHRJ8Lk5tqMXe66kjC63LLHGg0Co5NLjAiAprr7Yv3XXD1kgXdViE1U+VQeV+aaT9cRm5Gkd+1UyO+Pr+ucm2Wu75H5VotGNB7x0qm5UsjXwoInWGKJo76dlY0NgQwNc7dDlWbZI0qiqGfMxzuYFm64ol3s11tFHxeac+j+tKgZK4JHZBXHH3JpdMDUZq43QvYAjfawo38BMw7Ahfz/F1zv45JVjsiXD5TvNUtqfFunTCeD2Iy2TmnlnsRYIuroWhJ7M0JkefmmlDhh4HO/OoG4Pv+qif6ZVHmZJM9Fj5E0fJdBt4fmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456142; c=relaxed/relaxed;
	bh=p0qhtd+efK/Hc1Em0lvih3vUFvGAfNajebBLWEpeLzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIyBa42ZCgPRAxt/ZL2JMKh/b5UqgDWR58HofBLSFchrU6/bDZ3+WWozYykHLotphyjx3glIYlhfdzbCWV0rLcKtTxLk4/cm2Usha2f3Xu+DHphDT9JdyYsuFtkBjWdGFEpS9KuecvmJgHcIl9Ib8iObKzKOpwtXqaDDwaNkgNlQT5hiPwBeFWca95adVBxT1Lt2lnQc3qlvaayTn5nSrbunSGyAIDvA6gUKY/wRW+HHeDrorqv3C7WDhAKzojIqpn0QDJ5vZq/lprLWH1Vl+/R7Rokdr7Mnx/II/jJlCoVgQhcJIKZurWAzlvitMCnUP2jjMreA2BI2H9hflxu3+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WQyjUDDI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WQyjUDDI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com [IPv6:2607:f8b0:4864:20::1232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mld4kfBz3btS
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:42:21 +1100 (AEDT)
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-150f88d22aeso2387840c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456139; x=1792060939; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p0qhtd+efK/Hc1Em0lvih3vUFvGAfNajebBLWEpeLzs=;
        b=WQyjUDDIHV9sEEo9KiB8sq7N6MundhkYm6xxnrlwt09dnanGBLkEaalS7Z/IwM7S1D
         AkdsrNk9Qq0CdOxVc8Qqj7tt2cV1nTDavS7GcitpkZ0GyQWGz/v1fG7sCpRjm7NCV3JF
         MPy2rdbySmJAdpengB9qiXsco6VCanJc86+ZjP9Y27O8UmzmEu++hYxXgn8XHZf/Mb3W
         RLbkgyASNQDfEwANSiVHawyjS5HsQQs2HfKg0d1LjtCiL6NfMUom5H7q4idmepqCQ7jb
         w3i7ljKb0C+P+BMtFSuw2ycL4I86WX1RJazPVcPd03ePSmWxI3sqqTw1bisjXYhlCuIF
         7GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456139; x=1792060939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p0qhtd+efK/Hc1Em0lvih3vUFvGAfNajebBLWEpeLzs=;
        b=jupiyym+ZdplslKMRnWDD88zP1TEf0hbYWwvVULCtDVLsqMo9DtJa9ANU9ue7mBQVE
         u1eg5svhtOoW+D0nNFiCsX/cxHjHI4agbq/rH+SRKyoUNa4/vVOpkNteKQojTUp/5TZq
         tzvI24dQubvTCOCozrnETEU/RTBvVWZTXkS/XCbeQkjzGAa6GRj62mTwAo1ATeDBa1zG
         h7vJlPphePRwMDBLnRbqXLmQS4cZmGPjCp8SYVWBJ36BWjwtE8rYIiuZ/x1Q9iOtb4sP
         ohMVRxEhPg0KvjDxCKLLQ5P414qtHj6eWe9/3YdEl9+ZXrZSTiQW4m/oWrXJzJWrU6/t
         gRyg==
X-Forwarded-Encrypted: i=1; AKwUvBwsl4wDZ8xuvS3kOI4y0JdzyKisGuXIjIqRTL5xPlLtyZPprDfbMphB/a5oT9E4wwF/tMtpkQEiBxoTXoY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++moZd15ltP4gaRM+KqoS9pnkQxdyTgSOsrXI5QJ7cGwWM+MeiyD
	iRFkMbp+blPOLSRYpPOHlr92g4cXJqWXVuAI6HZ8n1IsWLq2643aTCPJ
X-Gm-Gg: AYBFou1ybibaI6EC4VC5YtEjzDEJplJhQjF8GT/2yioRHEhPYox5RvX59uVJDo3I/ps
	wlw8YfaK3tGTvZud4Cehdfg9JiRpDBkxsn8rkAVAP7lJLsRCHSzS9hO7hXaC44784rA7DW6LXXC
	eqI0DxYUjhyuKAsV5mXupWwOJUJ14LAl1Sqr/ISPSbr+hAwM92i6rDhYE7k91T8LTokC4rrYIoS
	3RJep81/PNEMqRlZCO4AmhQYIOjcAbB/e6s5tI/bc5Op25B1CTU2UOw4eaVBrUtRV8KMWdaN9as
	J6eTz28yQo8JZxRpfUxU2mXjcxDFQXxzl/3IxtDPNM77EkJduEgRiwkZ+YBBFm9rjMlP+miOW3q
	yX0A3WK7O2Wr0L8lHL/I13XByTj4E2iepfBayO9Z/6ZnIOgrWAZIjK3nCh7pMj4W5zQdWQbqO5S
	LZtVkeYwb7Hn4/54YPINKJJHPP21rsGTJfTP2PJVaWoe9ZyWrBc925Wm+oNqNUS2tRV+s2r6iaB
	QwjZ3RwG97WTsyGTsI52H2P8/1ffnUqIsECMMF18gZiRjk0B6AAmrm3zqSWLFBfr+GTqiV4kRlw
	FshLmG+9CY/AgvA=
X-Received: by 2002:a05:701b:4501:10b0:15f:6789:2c2a with SMTP id a92af1059eb24-16207d7c2a4mr5290246c88.36.1791456139402;
        Thu, 08 Oct 2026 03:42:19 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:42:18 -0700 (PDT)
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
Subject: [PATCH 13/24] ASoC: codecs: nau8821: Ensure the DAI is marked as started on success
Date: Thu,  8 Oct 2026 17:38:20 +0700
Message-ID: <20261008103831.542533-14-phucduc.bui@gmail.com>
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
from nau8821_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8821_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8821.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index ecadbaee1037..935df063822c 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -829,14 +829,19 @@ static int nau8821_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8821 *nau8821 = snd_soc_component_get_drvdata(component);
 	const struct nau8821_osr_attr *osr;
+	int ret;
 
 	osr = nau8821_get_osr(nau8821, substream->stream);
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
 
 static int nau8821_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


