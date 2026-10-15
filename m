Return-Path: <linuxppc-dev+bounces-29538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2947CC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:50:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rcL3CcLz3by8;
	Thu, 15 Oct 2026 12:50:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792029010;
	cv=none; b=eIPGT9T8Ly18m6dZOO4SmtUIgjQOcSMflnyaQl9nufW9ZMFEzqo5mAh/kT8c1xYZmIGA3sY5s0Zc8nF9brF/02kfWpyJ5FMrYyujQDXSEHhfspFUYVSP58NntJB4nkQxDXymNZk2MLF9BWKggMl1jQRkj45oFZYcTKdKapuZKrjaH8ndjyzMW60yvtg/IDjgN1Nf7AySZdxS6GYQmdlilbnztkYAw52dNXApVE9w6j6rCwIOmhc0g2D96TU2yYj48Xa1Sxtk8mlnKhZIhwc59XaX+RzAnHiQlAjfN457KD3TMg81w4zfnHu95HJO69VSjZReAgzlEjHJkDdkRU2F4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792029010; c=relaxed/relaxed;
	bh=gxE6KFVupvhvfG6m0kR0QYNTixMRnaDY+YvcWwq9JEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0h1dKNMtr+q5fmSiJQt0EA1GnlqCdncBWP+Ack7jkZqX6SWv62y6+/2zxR5ygG3zpClVTddPdDOXWYM9ar3LxknxSqSCU0kC4MRmymwFIwFUrTPzK8WCI0kn8ysBd57Bp2BR8NhSco4c2R3wVMf+qHGzPjLaKZfKgOGH2vwt8WZf/20ydxAjAlAxbkMzNS3Cmm3npf95pqW8vdf4RqG5L8LVbqt9HFggDG581Og67KQKa0MYuLsBTL3mDXpjJrBva/G4B54qAFIyjjMSnnY2ehcRrfVntmlh+LRHSZpZ+7001wvATufpOlrDpnpyFF3sFE/oa4XenZa96Y7yOt0vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BJp8ydTT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BJp8ydTT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rcK5Ykqz3by2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:50:09 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2e934449bb0so11225595ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792029008; x=1792633808; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxE6KFVupvhvfG6m0kR0QYNTixMRnaDY+YvcWwq9JEM=;
        b=BJp8ydTTsUQAJp9eW1M70Vgp+8fCweWw2DibeEPOd0iWOuF7lG86QmzoZgItV5tRZD
         zU2qvRF2nuRV/kJvAen4gT3ymzzBpRBOxeHfo3ue07JGTsjlepB59M0UjbePn1afYi+M
         kWaRzn8ZVI6ZtQ0tk7XlnEcMX3Pk6Y86Rd3Ewon9jgBEJ1VpMyShPXLHn2mukQwtAhcI
         JfOO0BCIuH4Iu2z++j5xuLKkOvS7X+KyKKRkFH0TONR0V7pXgvlcQRSLg8fZ59PeZDY2
         E6aOEDAyns+G4SRfb2SsWp4c5Eh9wF8eSSx5qp3uP9eJo5UmC5Aasq3qT5BFgbvbZmzc
         P12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792029008; x=1792633808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gxE6KFVupvhvfG6m0kR0QYNTixMRnaDY+YvcWwq9JEM=;
        b=MsAbLNEiisYeK9AobVeIZssW4buqbaZb18kM6XJerYY1t8ETBoX/XlfwomaS/e2xQd
         e/PonXP25hqahyNEwlP0hLTMNAzGc6/GHWFwfgm7QF/6f9NTrZevLh1lNPUuLRS6Jx2U
         Kaosq2Ng0bUuNii4D0qx3LR8J+syjZjLfoTY66Luy6eSEWczUmQXRGdXU3b7qjgwk8qY
         iy2SSiQh86Ld96e3AyEa64beZXExlIDf+vqsTOOezyKJv+gYR8+VF9wi+wfQXa7a2N/2
         Vd3a/CaUGSLaxc1Mp8LSwkyD5+pwvakjrF8a6oCFN0Jhv2ADSv0A2qvdS43/DUmWkccm
         DnSw==
X-Forwarded-Encrypted: i=1; AKwUvBwLfY4NEI6kBLfX4B7Qm8vx2HcAVRwOxOiq4YEIuRCtEd/xJjvf7RfrIlfnollwmFG2nt6hUaBIeIjjuGE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIcUo02wNoboEvSCT1WSCV2mmS0aS/xTNGYwc7mUiSz7VKfD5hn
	DsKh5RSuwUukOYP2S5I0yI3G0rRK4VspyStAd7ViUwuMM3KQ9u61K7Fc
X-Gm-Gg: AYBFou3NtsHT2l79oPtBGBCuXXC5dTLK3URRVfEB/CyHUOfEzcm/jijRiSEmQZLCD4U
	pyAiCRb23oJZPichfFFd/FFcyf1RfXo2DMG3jKm5Rm28MIZV+VumPZqQvNbOkSu4kf6IQzCONNu
	U4PTVT+mXQ8WiuDaGrb0X7/fGDLmFmz8qz8Z5PBJmnVvhc/ZiL9M+IUKReubHcZavhPLJIvR4im
	5LGOAPoisaaH9KatzHzvO8lxsLQzI8zASC4d9404HOSiraOrudiIPEkJGKpbEmD81t5UBNK5Q4R
	0W6kqKkHLy+zgtACYGRY3EIlnEuLSy04Gud5lLN43ZSDZYILOO9w8dlbefItjfk1FUCeFLjzG/A
	TLZJ9zDF7ufXXh64tGTvM9eWFuUlMsNjgwH3nzqlMWky0nlCSwzQowbxqRwe6L+L32H24+BUthD
	P48xDHSRVqYJJyTth2oGVUOm06Ep4yHdxYMnxqkNzo+gHIZUNExeRrTHziKaAoUCv4Rcf73ZwA4
	OOyYn3wYRKsLAUpfw6h8NZi0aMkYQ7meBqYeo9lCbz8ByEgDsj24rq8uePcyRdAju0pqXAm5VZ0
	r4ZuZqyqXhtVYA==
X-Received: by 2002:a17:902:d58f:b0:2e5:d33a:88da with SMTP id d9443c01a7336-2e842cd4632mr139407115ad.16.1792029007639;
        Wed, 14 Oct 2026 18:50:07 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:50:06 -0700 (PDT)
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
Subject: [PATCH v2 22/25] ASoC: renesas: rz-ssi: Ensure the component is marked as opened on success
Date: Thu, 15 Oct 2026 08:43:21 +0700
Message-ID: <20261015014324.5569-23-phucduc.bui@gmail.com>
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
from rz_ssi_pcm_open_pio(). ASoC only marks the component as opened when
.open() returns 0.

This currently has no functional impact, as the component driver has no
.close() callback. Still, return 0 explicitly on success to match what
ASoC expects and ensure the component is correctly marked as opened.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/rz-ssi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index b1587f499cb8..5f4a53886541 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -937,10 +937,21 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 static int rz_ssi_pcm_open_pio(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream)
 {
+	int ret;
+
 	snd_soc_set_runtime_hwparams(substream, &rz_ssi_pcm_hardware);
 
-	return snd_pcm_hw_constraint_integer(substream->runtime,
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure the component is correctly marked as opened.
+	 */
+	return 0;
 }
 
 static int rz_ssi_pcm_open_dma(struct snd_soc_component *component,
-- 
2.43.0


