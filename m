Return-Path: <linuxppc-dev+bounces-29578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2FFCC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5WTD44VZz2xS6;
	Fri, 16 Oct 2026 15:01:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123280;
	cv=none; b=bSJk4I3gvtRCYoost6xT+qKnWEq8HBFDFjgNdpFzfnX3WbxMNqGzRhAhqgtTY5mzuH+dEizwzP8Msei8Wbp5HuuV/dZ+goNmU8EcLEY+VaMhmjyX0zsINBy4t2DWOpO8/pfur6AihVfHIRtN/G0ofj9O4AxDxkQs2XohYIJ3CFFH56I+05guKk96FdSdNc/e1V5ZHc2P12ik/5zmXEZkYOjtEhXI1GwryNCUVWCZc39p2KNgg1EnOqJBw/Li6+0TwHIEvmGp5le9Aoxbb6ZxS6Nelsro6yXTsuquHbBV6huUJO0SYvJtafFV7NrfEzTKnj/CZlRJ24DImIDk2bmZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123280; c=relaxed/relaxed;
	bh=5Qhe5E4dgThyJhSYyDtuQ9hNBBoGOWOTPXhOMe7iZzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZiCrQLFqYROHCY2nftbW2/Mvek/+FRt45uC/badFXJqGEbiRjH7WAReHReMvQl6L6Lgdxve+g4nykE7BopWh4jbC3B7OG5azZQm3He6SxkQWEbYXcf0wjOWOWHgpuMClG4GnwKkRzC5Pzfj5zum7EiEmzfO1dfhvyz+EeJGqMACIG5CrF0+IFs6WQ+qtk17JJF9if3rIpUgSQihyiyHFuJrTFfohPitlEuRa7On1+QsMhrnyWhTiYu9W5s/OVIFDlOKbsw5RBYfqmry5mLfxD4djgonEfGWWd2ED79b1cl73GQNuiDH3izDwlw7CNGbJrsu6pS2A3RsKFFFR9mubw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gubZvrrJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gubZvrrJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5WTB6bsdz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:01:17 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2e987b4a710so1115245ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123274; x=1792728074; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Qhe5E4dgThyJhSYyDtuQ9hNBBoGOWOTPXhOMe7iZzE=;
        b=gubZvrrJT/whiBs3uOABt/vRvlqX8YudUZmHDNn2v3wO05ZAmVUDwfTqgd0ud4wLms
         Qe9P1Kerna2wc0fWk/c2plx/Okj9tMNeUUfLK61x1MHWdR9bPZJMBzDgA2FLbNwVmYYN
         95Rcmwe+UvoDmm848cHz9D9qAYOHExsYVOonynkwBnvaTYkhnANWMkC+qTNl3dyKUqWt
         Sahy/Ms19FAWdxF/3Ff6UfVUpSe8MbDWN81r0fAWflUhgGPn8FlBZgi212gkYcBugtdj
         8siaTSdvqNbuckIVoEcgFd1UthOm4WH+J6PBQR0VZkRhxlDWLEgSENAvYHa0rBX3O+Ol
         gOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123274; x=1792728074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Qhe5E4dgThyJhSYyDtuQ9hNBBoGOWOTPXhOMe7iZzE=;
        b=CpVeQ27X7gIKwePbY2TjuICGmjdGj2KM3KKinUiWeGWfOOpzKjnqVtpsBBHeB6OqGu
         +f/YHnl2ATeboHqazEVqF84jsdkwDjugk3k1nMTBQlTNkwZJHnsir4IIPp+lDntDaeUr
         3O//G6y5UHI9foDsk/4/9AxiQMhbsdLE/dDCMOg/weTKrDt6dKgCftZGQFriIf2vMGS4
         p5iuXZnf0oSUwNM3q8Qi4yj4xVo+TdiAI8ohmGEx/K/Qn8mGXBcukJh9TG4r6Gf+iWrK
         SkMcGL1oYAQHBseHPq62jTcAfcPjY5RPY0dcpMTv3uDdceP33iX4MNW/zyRA9D2kROHY
         /1Tg==
X-Forwarded-Encrypted: i=1; AKwUvByWLCI1qqMO8HtsUnrKz1bMPWvplg331neimp32oj2Rnisx7FUQLcVyPHuHYhpZPoO6AUiX8q8dg+kj9NM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIU0z6DRPrGiYvjttg/5YvBC1VvF5KWkhTXITB0L1F4RjyRBOVc
	T6YTNGnxlr6IK+RtAPhucligjd5VJAa7IJk7H8YIqI92mvxlUgRutN6/
X-Gm-Gg: AYBFou0V+o+zqCSR9uxena1YygxRki67TMzkOFZ4ydYe6IY/Gx3EjkkfgpNexANl9Oc
	nuZwp/wOH8NObwAGYYWW4CNwSkNVu+1wG9KmuNaH9tSiu0kOXZBy+AGZga5/msnGa/+RvgpmNBa
	eFZBBl9JsVlsoq+bHn4qBfzEJP2CQXmY87SgH6GNHHDTV3hGoC4w2T1MQFDFvQgvUfpN0P+SuUj
	I8pzUKX9rbcb/fxqHQW+aXh5RyluEzWojP2OroTBz31AtXjPcIwnfUWGn+pNDq2064WFlgyKMhA
	/Y/2ND+AmiV7dyXNsqDYMnE05Paeywkk/EQEvRqDPPNS8v1tr39CkGqVdT3JR8N/ErIIpWOj4ZT
	aByu/Nb9yBZkJQWOzR863cRN+P1KWs+NR1Kvg29bUMvcS191y621bNsNjT6VeCrIH6kMvbJmZeC
	d6ZSfM72Oow7FGXL+HF7lwCIhmKMlCn4Ky3gV7prWl0IlrstXehPYlnAOUDIovxzK3CTg5vcGcV
	5L7eYrrZVy0aQc8ZGZcsCMB+5GxojdQ2dENY8c4Qh4Jlykz5l7Q1EYNNOnMu7qqE5IpI1unpH9L
	N9eSAREGAVFh3S4=
X-Received: by 2002:a17:90b:39a4:b0:3ac:b764:8521 with SMTP id 98e67ed59e1d1-3acbb9255ccmr1718768a91.38.1792123274359;
        Thu, 15 Oct 2026 21:01:14 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4872861sm2304450a91.7.2026.10.15.21.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:01:13 -0700 (PDT)
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
Subject: [PATCH v2 25/25] ASoC: rockchip: rockchip_max98090: Mark the link as started on success
Date: Fri, 16 Oct 2026 11:00:48 +0700
Message-ID: <20261016040048.506531-1-phucduc.bui@gmail.com>
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
from rk_aif1_startup(). ASoC only marks the DAI link as started
when .startup() returns 0.

This currently has no functional impact, as there is no .shutdown()
callback in the relevant snd_soc_ops. Still, return 0 explicitly on
success to match what ASoC expects and ensure the DAI link is correctly
marked as started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/rockchip/rockchip_max98090.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 426506a8e18e..de392b420ebd 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -191,12 +191,23 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 
 static int rk_aif1_startup(struct snd_pcm_substream *substream)
 {
+	int ret;
 	/*
 	 * Set period size to 240 because pl330 has issue
 	 * dealing with larger period in stress testing.
 	 */
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-			SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 240, 240);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   240, 240);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * ASoC only marks the DAI link as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI link is correctly marked as started.
+	 */
+	return 0;
 }
 
 static const struct snd_soc_ops rk_aif1_ops = {
-- 
2.43.0


