Return-Path: <linuxppc-dev+bounces-29049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3299DCA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:44:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mp456Dhz3brr;
	Thu, 08 Oct 2026 21:44:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456268;
	cv=none; b=UYbY5Xea+BGOnPKbNbiO/fBfJjZdFPHzXJWtJPPv566tp3aro6HX7VirT6OxvgOCWmCYTA33rkr6qD1eCHGkflEpH73XjuXV41xsXQD32BOoJUUcBJZLN6PfLcPVoQfHBABYH1YPWEtE18NiYeuymfazCG32GPMgrToPSB/2NksEneOmwq5RCqCWQHb7wK/JqbMqSDO8ygmaBD25BXeuMmMRkjRVbpI5dq227WP7dTUUu+xtl5R2by8i6yvqKxjra/Y9b5ZTchp3xrh726MjOvimsEEhC95kRNRhUXWPIam6Tq377mUT0ennwAVjbsnQzvkMbPTbj0lzyC81Rh54Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456268; c=relaxed/relaxed;
	bh=UuLwPV5SkTfLeBmEQBHF5wyNVMglPos+3a2Ytz5Xtg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNM7n7k1aLuOdshyFfNskP4WBXaDpDpxaiFNNy9kfb4du9yL8kITbUQ8459Qjw5elG1rslgoPvgWEOcmKW0KbkXmaG89owx58qDWzHoUVvc8zmuV2R5IvlsFii2CbXqiKxGU2e8dc4ys9TgdClvSoDM/yoX52wr6MCjHHNrrmVL372w5TCbPsUs57YhWM27moAcEiOl3viVbnGqFIrNzhhFNAhT8/VZNgHpU6bUm60nfMjxvCYeYTXOMOjqfPkFXW/+rOqwgy7Hl+Kz5KcfHpNkRWoCLFhIm6I6HP+qTAMGphAoY4RoIqCVYFf21owpuOnhudCaP3rWwRxsL9Q4iXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SRSMhKIE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SRSMhKIE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mp40nbbz3brV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:44:27 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-351767ef18cso1965728eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456266; x=1792061066; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UuLwPV5SkTfLeBmEQBHF5wyNVMglPos+3a2Ytz5Xtg0=;
        b=SRSMhKIE2j5m9r/qadYyDFLu5qFIfd89RWT8POiK/NGoKHGsej5YTFK/0D0+MTbfvp
         fWtZewftbgdj8IAwNhO9xTD7//6w7E84a0jU1v1L+7wNHdTe2uXeVerk0iw9cZ2BBzwz
         k1RSCVqgXbqVkLsQ+Th9lXW8kpzsSjolF3EK/FnE5bZsiDQG4/b6nyRS1wF0mcwsbRCu
         4ukoclbQtyfVos4yw4wKm+dK9llaFVHYvSa2eV7/JdJQzfwtkWF4Hk3AieMyVjM9ux+L
         i6JIEqCRVEyWaYGC7GPwuZsFYdMc/dP7IMRm3CEUl4GC234EmYVx6F+DQACMC5bat86j
         S3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456266; x=1792061066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UuLwPV5SkTfLeBmEQBHF5wyNVMglPos+3a2Ytz5Xtg0=;
        b=GNR96D9knnvPwf/KZ+YZZYKyuhjtId/alWITiugkJKbL48d/iVwrYtAkMowMgYUj3c
         BsIaVsEARZVHsAKV0qQkPNVqKU4j1011mr0M7ST/iXnOJklIftEzAsRslregwapBgY3n
         VzNAiJfwOjvUGRdZ2RaJC2gzLfs/Jfo9iNjXiclQtdLcv+LxnCvvvYStdjfcPLlvyYPu
         xqL5auPS2r7wHDtFjVAnbm6ia3YU1gyKO+/A/Re2jCLe1wLMPQBV3DA/FN/m/GBJCvC7
         qTudz7Z1qqv6NljBqDwOyKq4PYkdA9svdYiv4EIzDUYLuvFsX5xBr9uU5ahOwPXhV8IU
         WfVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmIRHIT6SlkDfR2xwIMyEv5sIcZFx9kZ+ilYDiV7FGcBZgAKKdZy4D2SMGyfgvgRDgfvohOHvfA3Bb7Ug=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kteqkxTyb4g2t7p/mABtv9FH9Kk4l19OocEyw6ph+2ycYNIAWC
	x/aYceL1eIGyUiBcAIKhMQtNDu0V5jNOpLUtpba2gja6ugcc303rxYbl
X-Gm-Gg: AYBFou2MwS+Mq0VXDLrVjfBXbsYsGUgquQZL886h6ApAm1BeNwHc0T5evMulxsg1zcz
	jQW5HXnkZc+680Acb4lySuPyiFjnCTqcBYM2X1xonwOxyxGqBa/tjhu/62p7BYDS7+Rk4j+wX+b
	v4kbUk3YwI1OXDsAhEsaNl8Ls18KGxzaOUqSPiA9RSyXkczni3pDZn7CLaGwxcmjwka3FUjd2mR
	XNzaOfC0gKtOTbYGCZ7vN7YhKiRPGpSICGBn5anteqwiDacmtVAmGLe6ohJrtzRM25rvP5hV8FD
	M8IgrRcWkzShVyi9XpAPjsQO/DplzqYgYZFoehIYc+BtuQmpLZY/nZtibl5FaLzusHQteKXpJr3
	6gUH0Sh0+2JGlwUUpRayVGUu2pVZVSrejzevhBeaaQvtt0BmbRJJBpB8a+/N5LJaYqh820sBRL8
	Fqcoxr2g7ybRHqr7Elnv8S0dgLsGT3B6Y9PZ9QwpDaom01AMV+Y5z9wn6WTH7QlmEiDLcAj39EX
	pi5RFPu9/xroLrqG0sxtjYnLr7Sj0mOTv1TtJJOt3B9RJx86DtrkmkzcJxGWEV+8Lw5h6+WQBzV
	oUZBzA2tBC3HDA==
X-Received: by 2002:a05:7300:d408:b0:34a:e7ba:863c with SMTP id 5a478bee46e88-3515dde5512mr6327305eec.18.1791456265752;
        Thu, 08 Oct 2026 03:44:25 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:44:24 -0700 (PDT)
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
Subject: [PATCH 21/24] ASoC: renesas: msiof: Fix msiof_close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:28 +0700
Message-ID: <20261008103831.542533-22-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_integer() may return 1, which is then returned
from msiof_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: c61caec22820 ("ASoC: renesas: add MSIOF sound support")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/rcar/msiof.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
index 128543fc4fc9..9fead9a22cdc 100644
--- a/sound/soc/renesas/rcar/msiof.c
+++ b/sound/soc/renesas/rcar/msiof.c
@@ -427,10 +427,12 @@ static int msiof_open(struct snd_soc_component *component,
 	ret = snd_pcm_hw_constraint_integer(substream->runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 
 open_err_dma:
-	if (ret < 0)
+	if (ret < 0) {
 		dma_release_channel(chan);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int msiof_close(struct snd_soc_component *component,
-- 
2.43.0


