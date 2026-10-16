Return-Path: <linuxppc-dev+bounces-29583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E045CC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:11:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5WhR4TvCz2yQH;
	Fri, 16 Oct 2026 15:11:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123863;
	cv=none; b=Sx9y6cibHIyJC+K0wgxltLps587ilZU0gVkSmpmh+Fmk29qRn2NPTcxana5n9X5j5Q1OGoTw8oRsJBG2TnlyyjGb1qmltJfgcDg8iodxF9O220hiAsOUXdFCnjR7CmZGI7I8E5LkGtvP5aRIbskvAHF9flwoSN9wcSCC1XweZ/GfQYJwgPlTqy4ozL8vRuP19cKikLJborBSwr4k29JMGsbMzf1wHYVFc7BD/eEVrUvtL0p3MRbNnwPSp2fIuHBfXJGM/ujL1JYmH1Zh+bmasfeZp/jUWEZHFnT4ToRfdfej9at2cNYuvle0k1Du16B8Bh4Jg2uZ+tj1+OiaDwpMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123863; c=relaxed/relaxed;
	bh=4cGMzRNU9hZgiCZEwiJrPZgZXHYdPhSTuWZRtxpdn1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aL1Lh9JYoydp8+VazSIv/NbNuSjy32v/qmdGvyKNwuz6kf4HNgfTKieJ7VrJWEZVAGj8fF2o164y5kbJxmio/8M0lErItDrr3GkWodNgnbDx6Jqoj7L+Fb7T6rMkVpmIfIguDRZYUQvrTpg7TPkDMUkR+AGv8ajGyQh3Vpc+ps1HnprMFPXjRTKPa0WPam8iMA2n/pBFmWQLwusL+RbQ1Rin6NyizSFPjsLX7F4ZMF0NS4yj046Hw2OgLq2jkJ1WLAPVjswo+DUromVkLcHoQMzrOYRgLll1Jk4ELv1AvJ2r17/JjbabfNLE2MYpAYzATLDntX1da0owSl3Fohe83A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qNDxafzn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qNDxafzn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5WhQ67Z4z2xS6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:11:02 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2e95b3b52f2so8348445ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123861; x=1792728661; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4cGMzRNU9hZgiCZEwiJrPZgZXHYdPhSTuWZRtxpdn1k=;
        b=qNDxafzno8woiKzJZ8aJ1tDlfbCkaLUDXaTz4wSzLO8gc9+1TKQSaMEM+bcmsN7iAw
         pYH2L1NmW+BQGCDJEPtF46ekayhmGmX+sHMscywI36WKxRcKKlP4rf1i3+EJbPrb4u64
         mbB+MgN/zhpfhePUBuZwdEBQA06EksCcLx1m0qeXZVddog9ENhH3IAcqMNxeKCMtMsZf
         MeqaqsxWKsasVpnQrkd/6MCru0Vq/PrU+wTmx+6+EdQl0cKOItQv29UuSnxYBtYPG84U
         8BGfUoi/9S0YKXjnwt0924I3UUeFrtdv45KqdVrL1yBiUQRD66f27UQeR44//ZG0Cs9l
         Pdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123861; x=1792728661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4cGMzRNU9hZgiCZEwiJrPZgZXHYdPhSTuWZRtxpdn1k=;
        b=MYn/AOQxEIurGMYNuPqBFTL3n+BDkkLKI0+z4Sw1i3t08OAPS3SAfoS/x4530KdguX
         K3iVC57OayJ7VUZldkxgWJIj4foR/7JbzHGAx1AoHew5pTa8li+7HzFZDYYIyrG1Z9q6
         wIhhnch0MvhQ3/8QhveFxt0YO3E9qoRFkiIQJuqXfZ4BcSCiNZlcMKVVH5QLbuz8DiHh
         WzfJiPH/Kw5VJ3rfp72WN5Inb0fqAC+8gdiqhnAstuw3SSch4x0IrKsz5hnP1wpf/RKY
         8W+81Da+gMv6iGr6Fp5vcJZ3GH+Y/BRPBqEUqO3tqmOfUtBkKOx5ZcE7wYZv3zhV3Uke
         rPIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxki14FsGVxSlh/3T7xmAp7iyw86139AEGAQUzGXbM3Bn4FwJLx3MKwB/J0/kxUYMlyWsCknScjMMQOxbE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKmU3mAzIRoQJclKPJQ8eNxahpDqvezMrf378Ncgervqc0x66vy
	vfoooRWZnXlaToZoDEUJrmd1q6/lhq0Tph9ADds8nxhiGutqwthcE+06
X-Gm-Gg: AYBFou2HyH5nJ9BagY0rs0Zh5Ocbq62vzSLdx+p/H63NexL91BmFVfLpzCErUJ11JN3
	izrX2hB1QShz1/jcBog+B66yclaAWQlh6+hzDEkAVcAfrbZAkIfX4XoM9wKzCuHw8/dyyrVThiT
	5UccZ0ghyh5CC0KX5mLn0cpyin3D5wh7uNzVrPy/t9RPnf4+Awe3tn2hiHVHeUzJAfctn8HcMU4
	vRDYVaqPgeOPXW6Um9OW+v10mW/xBDirWGgPQKK/EByvJQ2EJRKxxHE+6uJ1b8Uy+VjO3i1S12I
	zGgTvwgzyVlcbcQyB7Qc4wM8DA3vwuNjOH7AznkR/lroEz0MDYxgngnz8FqfrVK2Yw/7kPIHAq7
	s0fjQ+ElB3iWt7VgAYy5e3oW4pJYrxdQqNumgZQUSeLbLhIbZs9A1nzVkQY2DsLz+YHphDCkGJ6
	9xLw8gwCCElTUswiweKHDNAMgAAvx9dzKWqB03CeYBTAGsFmrrbMe262GB7CGqwW/MloPTHIvXZ
	BNWL64rAuVBuqdsuWo1cFSJsEkvKdSRWChELApOm1ha5gVS+5rZeiRMi69tSmJtuTQ6KgGFqtkS
	8SjIVfo5Pw7TaHsaidbS/zVnyw==
X-Received: by 2002:a17:902:d541:b0:2df:8f19:5db8 with SMTP id d9443c01a7336-2e842f136acmr187140595ad.59.1792123860729;
        Thu, 15 Oct 2026 21:11:00 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:11:00 -0700 (PDT)
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
Subject: [PATCH 04/11] ASoC: codecs: Explain DAI startup return value handling
Date: Fri, 16 Oct 2026 11:09:39 +0700
Message-ID: <20261016040946.521195-5-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016040946.521195-1-phucduc.bui@gmail.com>
References: <20261016040946.521195-1-phucduc.bui@gmail.com>
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

Add comments explaining why the .startup() callbacks must return
0 on success to ensure the DAI is correctly marked as started
and prevent future changes from reintroducing the issue.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/cs42l42.c | 5 +++++
 sound/soc/codecs/nau8325.c | 5 +++++
 sound/soc/codecs/nau8540.c | 5 +++++
 sound/soc/codecs/nau8821.c | 5 +++++
 sound/soc/codecs/nau8824.c | 5 +++++
 sound/soc/codecs/nau8825.c | 5 +++++
 sound/soc/codecs/wm8580.c  | 5 +++++
 sound/soc/codecs/wm8782.c  | 5 +++++
 8 files changed, 40 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index f6e4bf6206b7..18d6cb9bfa2c 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -907,6 +907,11 @@ static int cs42l42_dai_startup(struct snd_pcm_substream *substream, struct snd_s
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/codecs/nau8325.c b/sound/soc/codecs/nau8325.c
index 0902a7d7730d..5ccf4c110567 100644
--- a/sound/soc/codecs/nau8325.c
+++ b/sound/soc/codecs/nau8325.c
@@ -501,6 +501,11 @@ static int nau8325_dai_startup(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 9484388ab262..09e7f31a904d 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -431,6 +431,11 @@ static int nau8540_dai_startup(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index 935df063822c..7b88ee3159d1 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -841,6 +841,11 @@ static int nau8821_dai_startup(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index c89889aa420e..046cce9192b7 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1073,6 +1073,11 @@ static int nau8824_dai_startup(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 10bbfbb460b1..af2a49c893d3 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1273,6 +1273,11 @@ static int nau8825_dai_startup(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 5343d445c322..cee80da8f753 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -860,6 +860,11 @@ static int wm8580_playback_startup(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 767251ac4f89..cbf0c823c022 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -46,6 +46,11 @@ static int wm8782_dai_startup(struct snd_pcm_substream *sub, struct snd_soc_dai
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
 	return 0;
 }
 
-- 
2.43.0


