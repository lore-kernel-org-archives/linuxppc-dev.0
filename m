Return-Path: <linuxppc-dev+bounces-24445-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDDBC4451B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 06:24:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Vpz3xtDz2xm3;
	Mon, 20 Jul 2026 16:24:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784528667;
	cv=none; b=STWZy3OrfwNjNkDtIarIemlc1/PUAHhhjKWN6nLBHLMuR6ox54p8z4N4jlxmclpEcc2/hLrzvostS29V3R63FyuObm8soJS0r0FdL0aVFQSGCJlUgosTIW9U4mmD/rYySashjlYCVEnojsNGUdZgezEIg4siiPWoAro4/zwv7qiynCYCLjEcH+qTdc4HsQx6YRgnj+zYjJjA9YntMEUp96aQ+PLQdSf1dNFcZv5IgjaJhkb6Xt7+3XnXKeHpcSir3lgMw1UKiOZ4NiXqJGuRI5HvGYr3xrqxZ8tLSeEgiWZWj7XCy98HoS4xqPOf+nqFy5qfzRtwwVp4xygmNQ8O4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784528667; c=relaxed/relaxed;
	bh=YeGYNprjO9RozTDm6r0Dm+rCthz+7k4Z0dmrZWw1tp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1ozE0vF1Zae7WfU+NZ383lR2WZfjamHMtJV64+xojhqTpGl/TWzsDM1OHxH8jgIO6QD4gjX/zMD4KXR71qj3AdcSoM3IKG1YQEV1xry1tGqdVDvxMYLBFs1tClTnVMCmS1gDmU8Vs2wp5mmnNgZpr9+nL1eso3/kURLULP5Yrx69b0nXSZsbRCXxWeNdDvwyt60pg02GPdfwzbhIP2WPjtb0Pmsmj13RVXfc5N2/iAaG/VzRnYrKtjkvwXzk5FfAjCKl/frtxAAA4dYZ5EfiDss20A9AjNCYUGy7H7NxVLGurYWwtNyfBM/0YUk6R/mk4kpac4U9ow2EIiFEFc1WQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aOGGEoFR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aOGGEoFR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Vpy2Nf9z2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 16:24:26 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4954dff6536so14128195e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 23:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784528663; x=1785133463; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YeGYNprjO9RozTDm6r0Dm+rCthz+7k4Z0dmrZWw1tp8=;
        b=aOGGEoFRxXrIN50TXmRtOeKu6ZGZGElGaNr72jwFBubimhwG99rTwg47fjwGBzuAR2
         iusFVQ71B8wDrl9M7D9Fnms6ALXHkgdB8jg8EOOAN0G952dPogrrW2HOyR9JzSvX++D9
         n6Fqyxc1YgTVeK6BgYjREmWCUqtskHxYiiVd7j8ZfuSzyWEY98BjgmKuieD5GRFmojB5
         8hKKg/Szso6OVbv9eUt9lZg+Qw1H3Qa6I1Z17iy312mvdfZoG5aHRFUDUtYr1gkmBjsJ
         oGzX0wP1mO9KVxc56HX73os4+K23uWtrw3fPwQjBLVbdf7K/3zVAHtSAJ5TjRKY+XwK9
         FBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784528663; x=1785133463;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YeGYNprjO9RozTDm6r0Dm+rCthz+7k4Z0dmrZWw1tp8=;
        b=eq/6lTHB/GXeZaC24+UFRKRyZl3Pjv77w7A0KaROTbjz81//81M2ihiYDMUoIg7LTg
         1nF8He8K1ml5sHozjWvVhpieq3T7wuEIvP1GrwoS8u3ucQ2TePzEqUPwbufRJgRuvJJ0
         SAv3VpKr5c793yoo1tlh8rAQp4z9z9MB2/mr1pxYLoeSxX91zDsUsrB0/pLO/f0fPLC6
         /qrCTafinn5OlJVScq+EvtcW5D29waZaU7da4hGFhIZ0Au6nHq8N6Y4eTli1s1IHCDfJ
         jmVPnZRgW+EXEl0i82frPrcT1qrRnutZH3BpzdqXoZdCEkFh5wmeGTi9rzMmeBuYlfOd
         83NA==
X-Forwarded-Encrypted: i=1; AHgh+RpsuCQIgKR8UYpF35M8UdblH86ZM/leC9oAypj1h2XM10BwztorRzpoXMakVNzS5kTCNJE20THLvRPGLRM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwgLstXAKy6fkFZ/XXEbfoihta0qIP10JOr8rrB11AJLF9JaYfp
	mzhaQyDFv/11/1UluzNPA1rA9fF9WrGngFiG/LXkmhcl+gwLcJruW/jzhDst8H+WucU=
X-Gm-Gg: AfdE7clBZCQ6cAW67YG3tz0UqteU05ZU4ABe/8tmyu7qaYlZe/wHHqyPTqFO410X9Jr
	V89yYck3ePpB34aLStMIxlzapa9Gx1+V17bcSjrSf+sC3L9wDs7Ey361Ak1Ypn25PTut+lXRuyX
	mOwwrAUKRi8LDjeMi02OgRtE5uRPNR/nWDFzeMbxksGOz5oYwvC0m8TYetmeGOrbL3ITtTA3Orq
	n8IfALQodXHkML9YkzLe4axuR2JLrEOVuWHwnURojEvlq0zKSQq2Lgc682QtzFtScdZz1UL+RyW
	A0NLQ+vEu27GhHniSmeYB7eelEVjJXq9QBbrTZfhRRkJ/yj+xoEP5YeIcBMoW57ywnAT/v0bVb1
	85GaC5bIMyRjleBFrcv02Q9O7Vn8nYZf9Iaj3vqQp9PAO3B6xaWcIA2zw5xh6yuSPYxPlINts6H
	E/+IgkIT/aSvzjn9dqtA==
X-Received: by 2002:a05:600c:1d1b:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-4954a3db7dbmr131890425e9.15.1784528663074;
        Sun, 19 Jul 2026 23:24:23 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4954a2b87c6sm455259245e9.7.2026.07.19.23.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 23:24:22 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Srinivas Kandagatla <srini@kernel.org>,
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
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/6] ASOC: Unify code style for platform_device_id arrays
Date: Mon, 20 Jul 2026 08:23:50 +0200
Message-ID:  <093867d47c079d2aaab06bccaae734c54c342a7d.1784528081.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784528081.git.u.kleine-koenig@baylibre.com>
References: <cover.1784528081.git.u.kleine-koenig@baylibre.com>
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
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13598; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=iR1LqIFM5kpqU9FhK7AKXR85Ty5byfvUM0BITDHvv+A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqXb7/ZjkV1xENnv57f8GUMRLZBCpZ1LZrci46v TNMnyy6QuCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCal2+/wAKCRCPgPtYfRL+ Tk+/B/4zvL3PZkVE/LvqrCiNOp093/fSaf+JA33aGPRnYdd3KE4PbdhEyLN92lv8dUj8MS+5U/C nd/3Jw3tR64O4+HgjFbfwaFuQnkUnsAkl1y3vrsscJpaV5FfRy/q3Fe/rMxYj3rEB5B2S+eR9f9 9eqlrwN6uNkJfN+cCAjdjKOVgZflj7GY5J4tXcqRR9KG0dr2h186sG/16b6M7ocumP8SmSnlkor MIMG/xs6Yj+5RLaWHP4wsA3g6iAcmK4nA66jB3h44Eneonrp/xOpjrN+JJBxEmJOolDyTgsUgP3 bzcA38YgoukL02WmEgrd6mYHAhsOsBbKUz+ap5KbL2kWMmwU
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

 - Add a trailing comma for initializers unless the closing brace is on
   the same line and for the list terminator;
 - Use a single space in the list terminator;
 - Use compact one-line style for small entries;
 - s/\t=/ =/ were the tab is only one char wide anyhow;

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 sound/soc/au1x/db1200.c                |  2 +-
 sound/soc/codecs/adau7118-hw.c         |  2 +-
 sound/soc/codecs/bt-sco.c              | 10 +++-------
 sound/soc/codecs/wcd934x.c             |  6 ++----
 sound/soc/fsl/imx-pcm-rpmsg.c          |  6 +++---
 sound/soc/intel/avs/boards/da7219.c    |  6 ++----
 sound/soc/intel/avs/boards/dmic.c      |  6 ++----
 sound/soc/intel/avs/boards/es8336.c    |  6 ++----
 sound/soc/intel/avs/boards/hdaudio.c   |  6 ++----
 sound/soc/intel/avs/boards/i2s_test.c  |  6 ++----
 sound/soc/intel/avs/boards/max98357a.c |  6 ++----
 sound/soc/intel/avs/boards/max98373.c  |  6 ++----
 sound/soc/intel/avs/boards/max98927.c  |  6 ++----
 sound/soc/intel/avs/boards/nau8825.c   |  6 ++----
 sound/soc/intel/avs/boards/pcm3168a.c  |  6 ++----
 sound/soc/intel/avs/boards/probe.c     |  2 +-
 sound/soc/intel/avs/boards/rt274.c     |  2 +-
 sound/soc/intel/avs/boards/rt286.c     |  2 +-
 sound/soc/intel/avs/boards/rt298.c     |  2 +-
 sound/soc/intel/avs/boards/rt5514.c    |  2 +-
 sound/soc/intel/avs/boards/rt5640.c    |  2 +-
 sound/soc/intel/avs/boards/rt5663.c    |  2 +-
 sound/soc/intel/avs/boards/rt5682.c    |  2 +-
 sound/soc/intel/avs/boards/ssm4567.c   |  2 +-
 sound/soc/samsung/i2s.c                |  2 +-
 25 files changed, 40 insertions(+), 66 deletions(-)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 81abe2e18402..78346cd7959c 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -42,7 +42,7 @@ static const struct platform_device_id db1200_pids[] = {
 		.name		= "db1550-i2s",
 		.driver_data	= 5,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, db1200_pids);
 
diff --git a/sound/soc/codecs/adau7118-hw.c b/sound/soc/codecs/adau7118-hw.c
index 92b226b8b4bb..4342eb7dd9e5 100644
--- a/sound/soc/codecs/adau7118-hw.c
+++ b/sound/soc/codecs/adau7118-hw.c
@@ -22,7 +22,7 @@ static const struct of_device_id adau7118_of_match[] = {
 MODULE_DEVICE_TABLE(of, adau7118_of_match);
 
 static const struct platform_device_id adau7118_id[] = {
-	{ .name	= "adau7118" },
+	{ .name = "adau7118" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, adau7118_id);
diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index c0bf45b76cb8..b085885e3f18 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -85,13 +85,9 @@ static int bt_sco_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id bt_sco_driver_ids[] = {
-	{
-		.name		= "dfbmcs320",
-	},
-	{
-		.name		= "bt-sco",
-	},
-	{},
+	{ .name = "dfbmcs320" },
+	{ .name = "bt-sco" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
 
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index bc41a1466c70..a9e6f2923099 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5899,10 +5899,8 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id wcd934x_driver_id[] = {
-	{
-		.name = "wcd934x-codec",
-	},
-	{},
+	{ .name = "wcd934x-codec" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, wcd934x_driver_id);
 
diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index ee741f3d79bd..7086fb7fc1eb 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -810,9 +810,9 @@ static const struct dev_pm_ops imx_rpmsg_pcm_pm_ops = {
 };
 
 static const struct platform_device_id imx_rpmsg_pcm_id_table[] = {
-	{ .name	= "rpmsg-audio-channel" },
-	{ .name	= "rpmsg-micfil-channel" },
-	{ },
+	{ .name = "rpmsg-audio-channel" },
+	{ .name = "rpmsg-micfil-channel" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, imx_rpmsg_pcm_id_table);
 
diff --git a/sound/soc/intel/avs/boards/da7219.c b/sound/soc/intel/avs/boards/da7219.c
index 2b17abcbd2bc..163d9982d797 100644
--- a/sound/soc/intel/avs/boards/da7219.c
+++ b/sound/soc/intel/avs/boards/da7219.c
@@ -259,10 +259,8 @@ static int avs_da7219_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_da7219_driver_ids[] = {
-	{
-		.name = "avs_da7219",
-	},
-	{},
+	{ .name = "avs_da7219" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_da7219_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/dmic.c b/sound/soc/intel/avs/boards/dmic.c
index bf6f580a5164..8d36bc7ddf16 100644
--- a/sound/soc/intel/avs/boards/dmic.c
+++ b/sound/soc/intel/avs/boards/dmic.c
@@ -104,10 +104,8 @@ static int avs_dmic_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_dmic_driver_ids[] = {
-	{
-		.name = "avs_dmic",
-	},
-	{},
+	{ .name = "avs_dmic" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_dmic_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/es8336.c b/sound/soc/intel/avs/boards/es8336.c
index 301cfb3cf15b..36c13db3a272 100644
--- a/sound/soc/intel/avs/boards/es8336.c
+++ b/sound/soc/intel/avs/boards/es8336.c
@@ -309,10 +309,8 @@ static int avs_es8336_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_es8336_driver_ids[] = {
-	{
-		.name = "avs_es8336",
-	},
-	{},
+	{ .name = "avs_es8336" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_es8336_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/hdaudio.c b/sound/soc/intel/avs/boards/hdaudio.c
index aec769e2396c..03cfd91202d3 100644
--- a/sound/soc/intel/avs/boards/hdaudio.c
+++ b/sound/soc/intel/avs/boards/hdaudio.c
@@ -231,10 +231,8 @@ static int avs_hdaudio_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_hdaudio_driver_ids[] = {
-	{
-		.name = "avs_hdaudio",
-	},
-	{},
+	{ .name = "avs_hdaudio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_hdaudio_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/i2s_test.c b/sound/soc/intel/avs/boards/i2s_test.c
index 9a6b89ffdf14..787d781ba1d9 100644
--- a/sound/soc/intel/avs/boards/i2s_test.c
+++ b/sound/soc/intel/avs/boards/i2s_test.c
@@ -107,10 +107,8 @@ static int avs_i2s_test_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_i2s_test_driver_ids[] = {
-	{
-		.name = "avs_i2s_test",
-	},
-	{},
+	{ .name = "avs_i2s_test" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_i2s_test_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/max98357a.c b/sound/soc/intel/avs/boards/max98357a.c
index e9a87804f918..389a50923d3b 100644
--- a/sound/soc/intel/avs/boards/max98357a.c
+++ b/sound/soc/intel/avs/boards/max98357a.c
@@ -136,10 +136,8 @@ static int avs_max98357a_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_max98357a_driver_ids[] = {
-	{
-		.name = "avs_max98357a",
-	},
-	{},
+	{ .name = "avs_max98357a" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_max98357a_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/max98373.c b/sound/soc/intel/avs/boards/max98373.c
index 8b45b643ca29..b8231f71d3d6 100644
--- a/sound/soc/intel/avs/boards/max98373.c
+++ b/sound/soc/intel/avs/boards/max98373.c
@@ -191,10 +191,8 @@ static int avs_max98373_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_max98373_driver_ids[] = {
-	{
-		.name = "avs_max98373",
-	},
-	{},
+	{ .name = "avs_max98373" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_max98373_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/max98927.c b/sound/soc/intel/avs/boards/max98927.c
index db073125fa4d..d657e7da1cc0 100644
--- a/sound/soc/intel/avs/boards/max98927.c
+++ b/sound/soc/intel/avs/boards/max98927.c
@@ -188,10 +188,8 @@ static int avs_max98927_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_max98927_driver_ids[] = {
-	{
-		.name = "avs_max98927",
-	},
-	{},
+	{ .name = "avs_max98927" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_max98927_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/nau8825.c b/sound/soc/intel/avs/boards/nau8825.c
index d44edacbfc9a..d7ea08bb27cd 100644
--- a/sound/soc/intel/avs/boards/nau8825.c
+++ b/sound/soc/intel/avs/boards/nau8825.c
@@ -293,10 +293,8 @@ static int avs_nau8825_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_nau8825_driver_ids[] = {
-	{
-		.name = "avs_nau8825",
-	},
-	{},
+	{ .name = "avs_nau8825" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_nau8825_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/pcm3168a.c b/sound/soc/intel/avs/boards/pcm3168a.c
index b5bebadbbcb2..9d415fd0499a 100644
--- a/sound/soc/intel/avs/boards/pcm3168a.c
+++ b/sound/soc/intel/avs/boards/pcm3168a.c
@@ -132,10 +132,8 @@ static int avs_pcm3168a_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id avs_pcm3168a_driver_ids[] = {
-	{
-		.name = "avs_pcm3168a",
-	},
-	{},
+	{ .name = "avs_pcm3168a" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_pcm3168a_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/probe.c b/sound/soc/intel/avs/boards/probe.c
index 73884f8a535c..4053d14289b9 100644
--- a/sound/soc/intel/avs/boards/probe.c
+++ b/sound/soc/intel/avs/boards/probe.c
@@ -64,7 +64,7 @@ static const struct platform_device_id avs_probe_mb_driver_ids[] = {
 	{
 		.name = "avs_probe_mb",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_probe_mb_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/rt274.c b/sound/soc/intel/avs/boards/rt274.c
index a689f4c80867..289f1230851f 100644
--- a/sound/soc/intel/avs/boards/rt274.c
+++ b/sound/soc/intel/avs/boards/rt274.c
@@ -261,7 +261,7 @@ static const struct platform_device_id avs_rt274_driver_ids[] = {
 	{
 		.name = "avs_rt274",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_rt274_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/rt286.c b/sound/soc/intel/avs/boards/rt286.c
index 4c9ac545555a..9364d60cfcc7 100644
--- a/sound/soc/intel/avs/boards/rt286.c
+++ b/sound/soc/intel/avs/boards/rt286.c
@@ -231,7 +231,7 @@ static const struct platform_device_id avs_rt286_driver_ids[] = {
 	{
 		.name = "avs_rt286",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_rt286_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/rt298.c b/sound/soc/intel/avs/boards/rt298.c
index 2d7a7748d577..5d3b3cdc9564 100644
--- a/sound/soc/intel/avs/boards/rt298.c
+++ b/sound/soc/intel/avs/boards/rt298.c
@@ -250,7 +250,7 @@ static const struct platform_device_id avs_rt298_driver_ids[] = {
 	{
 		.name = "avs_rt298",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_rt298_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/rt5514.c b/sound/soc/intel/avs/boards/rt5514.c
index 22139eaad83a..e448bc9fa5ad 100644
--- a/sound/soc/intel/avs/boards/rt5514.c
+++ b/sound/soc/intel/avs/boards/rt5514.c
@@ -178,7 +178,7 @@ static const struct platform_device_id avs_rt5514_driver_ids[] = {
 	{
 		.name = "avs_rt5514",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_rt5514_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/rt5640.c b/sound/soc/intel/avs/boards/rt5640.c
index 2990d32f2301..c4e33d71e82f 100644
--- a/sound/soc/intel/avs/boards/rt5640.c
+++ b/sound/soc/intel/avs/boards/rt5640.c
@@ -252,7 +252,7 @@ static const struct platform_device_id avs_rt5640_driver_ids[] = {
 	{
 		.name = "avs_rt5640",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_rt5640_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/rt5663.c b/sound/soc/intel/avs/boards/rt5663.c
index 68fea325376a..aadbd3f2a1b2 100644
--- a/sound/soc/intel/avs/boards/rt5663.c
+++ b/sound/soc/intel/avs/boards/rt5663.c
@@ -249,7 +249,7 @@ static const struct platform_device_id avs_rt5663_driver_ids[] = {
 	{
 		.name = "avs_rt5663",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_rt5663_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/rt5682.c b/sound/soc/intel/avs/boards/rt5682.c
index 81863728da1d..d33699cca595 100644
--- a/sound/soc/intel/avs/boards/rt5682.c
+++ b/sound/soc/intel/avs/boards/rt5682.c
@@ -325,7 +325,7 @@ static const struct platform_device_id avs_rt5682_driver_ids[] = {
 	{
 		.name = "avs_rt5682",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_rt5682_driver_ids);
 
diff --git a/sound/soc/intel/avs/boards/ssm4567.c b/sound/soc/intel/avs/boards/ssm4567.c
index ae0e6e27a8b8..d7c9bff37556 100644
--- a/sound/soc/intel/avs/boards/ssm4567.c
+++ b/sound/soc/intel/avs/boards/ssm4567.c
@@ -180,7 +180,7 @@ static const struct platform_device_id avs_ssm4567_driver_ids[] = {
 	{
 		.name = "avs_ssm4567",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, avs_ssm4567_driver_ids);
 
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 56d11741dabd..81d5dd36a246 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1675,7 +1675,7 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
 		.name           = "samsung-i2s",
 		.driver_data	= (kernel_ulong_t)&i2sv3_dai_type,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, samsung_i2s_driver_ids);
 
-- 
2.55.0.11.g153666a7d9bb


