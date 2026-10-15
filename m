Return-Path: <linuxppc-dev+bounces-29536-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787E9CC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:49:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rbn1H9Nz3c47;
	Thu, 15 Oct 2026 12:49:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028981;
	cv=none; b=U08EEc7M6s/Qcv+lhBXHSN0sWg8pCIXkp4yEYe2jv/0stRttAfTWcOoA1b8ZXb4GpVsz4QpuyYskOVDY94yr58j+VRfJRDkbPAsk12xNNooPehh95mnFXvZ2c0dAdP80QFoOYkbJ4s+aMMZ4SPfEw8Q/XajW9WuHXOL7zNkSTkUSgBP55Qfb/t4isJ8QDlbZkM1wud6Q25gq682Y1ayF4OlMmD2S9ld1Nuj8e6fPNpbH/FSYx/X8Ab3XNs3Cy4V3DOFHJs40Zk5t5uxyetNCUoERykIzkuCZoEz0SPzShgKz3ubXjzCvHizhda/mV3Jk9oBKvaigbpXnhuALdl7OBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028981; c=relaxed/relaxed;
	bh=FVU2me1+3bnamRCjCl3aeaOsDD74U7zM2YYw6HaRgfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnCXWquUJ8sNzrQsuDW7f6G9POEYhzpRxz9O8B3Jlvz9cHtSsq+AJiNPW9L4N7VQwFbMlxldmZdM/gT0T/94NY/PWjDrXjM4lxTxNi2ucdL2L+GpIcL4p08TL4HJuhz6AwkklF6UTDhVa3Zn58mSrf3chP13YjgICIoKiaPp5noEJGAAqrAwwTvbVjmqSc/ovuBeHbSsq+kA73oaqbg6W8UC24QzDN1PqeBmZF9Bt78LnBoZrBx3nES9qM/tejBlJwnxvMQs+M+PEc0znApHGY7R0ZU1fw27xoIr7TdvVvuioHe1r8MINIEl701vkw9hzH1BCHmDAt9po25zEpJm+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fj8L5r9K; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fj8L5r9K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rbm3kwxz3bxL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:49:40 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2dd76b1361dso11015735ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028978; x=1792633778; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FVU2me1+3bnamRCjCl3aeaOsDD74U7zM2YYw6HaRgfo=;
        b=fj8L5r9KsERIemz8vg5jFxezhZXcybMfar1lKJTQVirxxYiK71YBXbSVbGIL8UYIAz
         yjK+6wyLoHdF47ZeVQwIjdkqSf6MHskyd5CjH23IJwh6zSEU5B8zrv7YTow7RFHnQpMs
         VvvSmQiI4LeRaSCjKVUWPVR3qWZEvHjBW/8RdWd+MrmDUO9sZnOkhXeNbEEa006uZkqe
         SS7pMfJPrZtIUiOZ4dyEQkOO3tnjE/tTfcvlv+SMsNGyQ4rmNLPZH5+6hph5nMVFpwAE
         eopiANB0fXVVpSJ5JRS+VNxEigC+OcIb+AgSy6Ax1ewUNj/EHp22qodnDBdVjoTWX5bt
         imAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028978; x=1792633778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FVU2me1+3bnamRCjCl3aeaOsDD74U7zM2YYw6HaRgfo=;
        b=zy+XSdy+OcOBwNjvJLamfwwd+oNzI27D9BbliswTNcK7QROrJASTYzJYtJmwyTenly
         JUmyuim1mjVy1HKVJjZ0Du0gPd2nVn4VFJEylYvg7hTKx2Egi97MCvQK7byCA/Km9+b3
         R/+heHh+n7X5pf9LOFIESvCZJfLqGQrNYCtsQAw1Q49bXntxa0ikVy7TsDS1LvHvKcYH
         Qrg7YTT2zTNVL9O4lhG7hSTCefK5I06lwI4EeoXSqYEbYC9rnHJPFFdJNlLQ8FXpd8zn
         XrfWUpw3vGH5OAXx8hDqv9nWTI2H/yo3Ipx0V+Ux2zzSkXpyMgQSG+JxMs8gF/VpjNOC
         Rmbg==
X-Forwarded-Encrypted: i=1; AKwUvBwfbe6W//XQwr7B9/b+jJ7tGZIB1ombiVBLBi4AVdyXhcAt5jX8x1P37ystPmLCyofjFnwFM5JnvMi5lxs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJgc32Sq26DHHJr/N8tP3jzfoMUQUnlAknLFO2CbJoJ3MIGJzLO
	nDZkyzEs9OIwSjTkkHlNttCAGPkrfExpObxFjG/Rw1oAzmMExMx/Ll9z
X-Gm-Gg: AYBFou0/3PhKDSKNOP0rzzViV7eZT345ZUU5cZO8ZYUMc6+12pxvnLzq/J/QmnXBtI5
	ktHxH3ze8QpiQbpFCXuoIwVAvB3FVIWbwkyrSoTkc3EvTXIIklLU0kqitu/DYJXoFvwPhivMYUj
	c9bCKLEsAZtmd3kE6V7TR+VZzXHJU8wgDOrxT+Vqo2OoTYfGU+QAhJYmHIJs5n2o+4ieZt2k0s8
	4Y5XlLqAvmNO2+LNAwwaBiBBaFnVCi+6JRU1C74qNQlrN7NKL75hwaeWnSX9b1dqgChxuMnumaY
	phc7clulFUUbkFgl5l923/IHChga9TMpzDRzhL25oVqmFAHQiG1Zt0/ApGqJ3ciH2TVMYev+Xae
	6GgVpusODMqXrYfBP089NT7FiToniGeZzkrQ0GIwCvTavGZMCBI5etv+21X0SlV9SdxfXCGAVp/
	PCLcPRyJ9NU/a/W1AbND0SC8N4493V6SfFrVqEwHZKCJ0DV5gSqCrMKkaO+cyiVSHYpCD7KLhtu
	sOhUyfy1aN+1vZHQS+5zV+37r/8s+pbk6cTrlVDM/GNdD36YEZ6m+BnUxZ1oUSbjXf1P9k0Ro08
	Intai93ki3h1Mw==
X-Received: by 2002:a17:903:3243:b0:2dd:ad74:ac32 with SMTP id d9443c01a7336-2e842bc61a1mr152460415ad.27.1792028978441;
        Wed, 14 Oct 2026 18:49:38 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:49:37 -0700 (PDT)
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
Subject: [PATCH v2 20/25] ASoC: renesas: fsi: Ensure the component is marked as opened on success
Date: Thu, 15 Oct 2026 08:43:19 +0700
Message-ID: <20261015014324.5569-21-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_integer() may return 1, which is then returned
from fsi_pcm_open(). ASoC only marks the component as opened when
.open() returns 0.

This currently has no functional impact, as fsi_soc_component has no
.close() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the component is correctly marked
as opened.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/fsi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/renesas/fsi.c b/sound/soc/renesas/fsi.c
index 23b7e63596d3..74e2ea002fbb 100644
--- a/sound/soc/renesas/fsi.c
+++ b/sound/soc/renesas/fsi.c
@@ -1811,14 +1811,21 @@ static int fsi_pcm_open(struct snd_soc_component *component,
 			struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret = 0;
+	int ret;
 
 	snd_soc_set_runtime_hwparams(substream, &fsi_pcm_hardware);
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure the component is correctly marked as opened.
+	 */
+	return 0;
 }
 
 static snd_pcm_uframes_t fsi_pointer(struct snd_soc_component *component,
-- 
2.43.0


