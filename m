Return-Path: <linuxppc-dev+bounces-29537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1D6CC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:49:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rc427w7z3bsm;
	Thu, 15 Oct 2026 12:49:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028996;
	cv=none; b=XA0Bm+CvCxLo3YG/ouSG8rhNLrV0H72ZmGB84sM9+bcmXhfUN8Vt7DpFoZinB36whM6VT9tdSl7fejb6C3uBGy7GENLI3Mf81Q04VsjVrXt2c401JXyoB8Els8LF8mPUNf1ej1L9XbXRb7GHqXIF1I1uMjBBj1laeBfl+Y/9Hi6gNEcTBu6dI5mhU6LSgz/+gA4A7ovibQuRR7/JzJ+fn9HSvMH+X/3O6Wm950UtZqk0VWm8kC7lULhHjqFTk4pfmvagnB8nIXVl9+P7WLoDmlUbWyB8v7f+2QhbSfLgC/00UGOFdDT0tTdSnnKdrWNOeex5GDqVTrERF7CPG51TIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028996; c=relaxed/relaxed;
	bh=X8N5wvVyB4OZfrBnjP1FYFZJGH9J4CpZz0KjhM2upoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHL+1naSB40FIDd6jQ2LlXnx1g8Jm3LzagnwRron8phkiHNDJgHfWlJsB0MZMCqCvYiKkX/E6uQ+9rvtAKrAlwkWjeR+9er3tPM8s5Q/+mo7e4vxWFCWna1bbSQnfOfWOmiowQ9z1u42mweV3yytGbZaxzqGWxXKHmmw9PrLuwe1KHhUvSQJL+ZOzJ54rZt+ug4atBfKqGe37wyB2jSIFakxvwecaTgw614d2NzqOu0q2qFS0omkhnmZufHhlRMbwkDsaIkbeNHiEdiqgskvEn+cldTgU+QQqiRBBY1OUKHBuGxRFyYO7BPKJy2PzJWcfzTWK+KhQGlJJvypBRJp8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JstEWCtu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JstEWCtu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rc32m0Nz3c4h
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:49:55 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2e5378b281aso26430705ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028993; x=1792633793; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X8N5wvVyB4OZfrBnjP1FYFZJGH9J4CpZz0KjhM2upoM=;
        b=JstEWCtupOsncNiyH+eU1yoZ4vDw7aSfmyfNFJ9N+x9V92oa9NZLwDF9mtlRGS+G6y
         NnQUlZkFYXHNJlSWK6LkpAD4Dfb2yppl5fBBAW4aRd2KOSAc61C3r2DQw38QjoMWnZhi
         M9fPNH6h10vycwbTdyXdiprKYEZhBQ87NOcVPADf4hBD1vujopsIOpngypLYkwgIdJKv
         BIasCbqU6xrAmgCrf8YNHwnwow6HryFuAUdcqt0QID9UQYMfsodYtk/r+coGyAGfQbky
         ZeGqjzbunONAAOOqnSRY3mbuy90zFWHJYchfyvPpmQOYIyJ29oqlTFtEWOqwvL9Ttf4P
         ePDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028993; x=1792633793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X8N5wvVyB4OZfrBnjP1FYFZJGH9J4CpZz0KjhM2upoM=;
        b=b0E1ALJlp60Vq2PQe6wo9epzHpLc2S13zMhb+8YKWjq2Ocxbbs9kgGV7l2gmJVoNRW
         +EkgH5gR7mEhG7459D0ErqrOSgiyyO9TJ9dV4//WZG/Y29icwoHzN009NkhaXdeW6m/W
         LLvFK4IgLqTW/n0/wSS7B+GAnUA/+XLbxkd60FBEO+t3TpUJLAcXWmInTPiJSFkl8ejJ
         zeklK/NKnSfSg+nOll8EJTed/BCzYiNH2grfNVKfHreLJjwECv2cKmTF5MnxydV7HMLZ
         NGMPXI+WbU9ztc6F8RZKjBQdVk70k/+cbKGZEcpJnQ97UL7BllRIZAAu9BVlHxaS4EZH
         +2zA==
X-Forwarded-Encrypted: i=1; AKwUvBzlSXSQp9sopUYqgh9ocsgMcoYPtF1qVPbyaEEXicnMVwgFWLNoKWgzgHhx5iSots8/zCTCEkZdWu9jcHE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJLz6qiS2Z0HLyxkHzPriEiUJfA7PPvAPVtg+9VVQgJoTxkGCtT
	LFdALzHQWoGo8oDCw8TMqXj8z7KYcsEox3qRu3IQlUvJJiQakPJXhYX2
X-Gm-Gg: AYBFou2YYmJ5ZIWHSZFL5UGvzMyIhHTNkLfCLojW1Q2sgzqLz+dC1vj89V4Wbm2ZKuF
	PD8DiYsP61ljn2R+olmhuXVzCKTBHWjJbHAtkPqqkx3pmugsh57O+07zo/n9SV5OYfqnXPJ0otk
	Ite+6EjJcibeX8RZ7fBinXRKCMGfo/Ach+C35Gi0LTUKf+Vjm6MW6SSWoS31DanYT3ubmVbaRHv
	I2oBztchKjF5U35mmtyX+zoCiNTpIw5OUxo1RJMvm2F7fKKS5Go6AtX1dXPN/gdPa5/+M4o/s/j
	ecXfOvtOAsjA9fqmwMLzOfYDCNtJAyJF3Psw31Y81e1PLgmJFwqdmVNyFLa8iccRc9he4BdInxl
	W0edHycr7q8MRRMmgLafwLTVGsRzGrfs+1O3mqANmCB7mkmpdsCEVEG3lME0NH+1P6ys06CRYW6
	8HmH94nR25/7cynyljzmvaiHQQ0MCn3CFULe6lTlEMNTX+jN8q6nBFuN1SByqjpdIWTCLnRMXk1
	6AIko+48YW1PGon1wodS10Ml9WnVvH0kEB9InooSIMEimnx/s004SNeZDPoazH8DY4v9U4EJew/
	Ne6XXNV9FLjqqA==
X-Received: by 2002:a17:902:ef4f:b0:2e5:c563:c0dc with SMTP id d9443c01a7336-2e842cdb0f8mr158108285ad.42.1792028993312;
        Wed, 14 Oct 2026 18:49:53 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:49:52 -0700 (PDT)
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
Subject: [PATCH v2 21/25] ASoC: renesas: msiof: Remove redundant period constraint
Date: Thu, 15 Oct 2026 08:43:20 +0700
Message-ID: <20261015014324.5569-22-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_integer() is already called by
snd_dmaengine_pcm_open(). Calling it again in msiof_open() is
unnecessary, as the constraint is already applied and the second
call returns 0.

Remove the redundant constraint call.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2: 
 - Remove redundant integer constraints already applied by 
   snd_dmaengine_pcm_open().

 sound/soc/renesas/rcar/msiof.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
index 128543fc4fc9..11a6f22ec0ad 100644
--- a/sound/soc/renesas/rcar/msiof.c
+++ b/sound/soc/renesas/rcar/msiof.c
@@ -419,18 +419,14 @@ static int msiof_open(struct snd_soc_component *component,
 		return PTR_ERR(chan);
 
 	ret = snd_dmaengine_pcm_open(substream, chan);
-	if (ret < 0)
-		goto open_err_dma;
-
-	snd_soc_set_runtime_hwparams(substream, &msiof_pcm_hardware);
-
-	ret = snd_pcm_hw_constraint_integer(substream->runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-
-open_err_dma:
-	if (ret < 0)
+	if (ret < 0) {
 		dma_release_channel(chan);
+		return ret;
+	}
 
-	return ret;
+	snd_soc_set_runtime_hwparams(substream, &msiof_pcm_hardware);
+
+	return 0;
 }
 
 static int msiof_close(struct snd_soc_component *component,
-- 
2.43.0


