Return-Path: <linuxppc-dev+bounces-29589-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A78CC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:12:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5Wjs434wz2yjw;
	Fri, 16 Oct 2026 15:12:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123937;
	cv=none; b=VKUsLiJi88ww7JIBEHKscgtZ7Ol/w+WBReMN57cP0BD93LP+BblmvcUfCkI6mZZJjKb87SCKNK92sxGaT9LSasZFNl9MXUiKQm7B3IOozKmLX6sxq4ucFywbnF6m5bU7CaoRq9E4PIrhg4d+We6PZ0uWf95HlY/zNzNC12iQTD900hGL9GbuNXEdYKUMLBoUCSq1JHA8o7Fj1A0m8OwVGqF3kMj3/WB/K9N+ykGBPobg8BU7gxkpmuCS0Fto7BO9dr6s2RVP+8Ltlzo45ZLQdbI8l4gGQwjg6unBn8huSg0DICccwjQ4mgHB3tPw2dV11Bvb39rN07YqEwMiUV/AEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123937; c=relaxed/relaxed;
	bh=7AZDJdjhNuFXFYn0yeoBtoVorlOWOlf41UfMI392qg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1Rd/7VKO22nFtx/0CmSdg3q4pL4hl135p+DIlPMcEmRouImeCsbHxXGv72yX9yuAGzE8rGt2o17fRD4N16ge+RABb6OIBuTV4RbN6knj1kw+2gOOcbOfJfPWltGCrtAAKVIwczwPp20mNWQLj7l0yhoKbMLwLp3higq6vETpXCwfQPUuLF4aZqJq8AJMVDnwKqNP7jejYpJbOq/vC58/nDdoxCEQEyjaa4yJ4RTMkuhvAjPkAKrZLvf2hYLd3h32//Itm5Z+3TAdh6Y+IG62uCdRUujafwvovfHBs+dQUiubmhEz8rbiMX/77j+znddk2C2JGF5b1gNuEWBJIcRpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R+57+XoQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R+57+XoQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5Wjr5qTMz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:12:16 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2e934449bb0so21415675ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123935; x=1792728735; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AZDJdjhNuFXFYn0yeoBtoVorlOWOlf41UfMI392qg0=;
        b=R+57+XoQZ5qxtYK3oBWE76SB5mezGnwxMcl81K1iFJ07uAnCOpDqkXB8NqaY21xmJz
         ZcAsDWiyhW3SuRIiEcWVcIRvZZi3qwLeqKhAgaWLaOcgKuw4pD6P8JpqeCpZVeL3WRTJ
         Da+6jEsXgPWYlYLPQVtZdyo9oEiWVvUCuC5zpcwf49Jl3MQJ1NyhZggpVuMbAjkflREF
         DzZLR7IyHsNjwAB20oHdytSkYlERH4ZpqP4pY5M28JF4bTYzv6rvl6RcxbNDcJQYkHr+
         KIvxc034z+nVlQUBp4IrpBZ0aiZE5QW7qTxHjLQVEWOLjgGsibPkEyFxpllEZ9QX9+13
         jnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123935; x=1792728735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7AZDJdjhNuFXFYn0yeoBtoVorlOWOlf41UfMI392qg0=;
        b=X4yw4HUPpXCZz4JcEp/qTySFdwaDI2JYUPbUX+WK/WR4jaCOBNoTB+qfy6ratSkja/
         d8YLq3Ogtgkdf5MHXpEJKkaNIMyJHy7+gaCl1qSu3UIihbqSnfidiAHDYvWDq6VGDVJ+
         a6vxWNB7Jhl9gt6/aUvgLT2rkzlS2i8oW/Ab0yexJlHPj8p7uC+bPOoz+H8vaCMZFHsH
         KDMD7VdpZV8tWI0QfK8h7OG+JSHF1Fz6S3FKUsXcdwfS1gurT+dr2ke1VlQmhqWnnzOF
         N8AbhMR42bu46bA+Cy7I173bF98WgpFHnwTBiO7hS+bTmYVCR3v/farmwR68saVpQpct
         ctEA==
X-Forwarded-Encrypted: i=1; AKwUvByl6jYZOjBSbDBP14FGCF7fhDdxscD8jxzPnF/lFCavJ1IeekCOtrkaklwpHzAm2iO8rvlneX2nBj1uhcI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYISEMnsC/ST/V3nWhq5QcHzgbdLUh0BoQGFzNgt79lKG6xZ9QK9
	s78JiLoY7G5TpY8LGJJNvaGo+bKKll7ZmBDIGhoDAA91GEz9HES8HD3U
X-Gm-Gg: AYBFou2uxiqXGOi4OpEY7VxuwrFWh3bF+KqnV7TRr4CjZt6n+5oV3aF2WHp4A0tEl6p
	Eg4XeZ82Bn6HTgkSqZl3JAJKmAuO6F8sv8sJvQ/dFBGlQlOoUPkoH+/vLfBjtwbvqJORMGYtltZ
	CA5FUKJNyN6SCwP2zYwd6sLSStImlRNG+rB5WWVivkJnryvoYG66BOvjjf00JguYSOLzdV2G5bA
	B/7rQQqrLTcsRXXGL162JQjKVOadv4EO3cZF+0HnsbXujdo6Rg3kk4k+Y9AJ5aIf9VT5ByFZmFx
	TrG0SwqlaBSa8fuEKqU+sVNqGO50NfC/h7I5/JPvrRVUBr3Z0A8SoR6O39ERzfVO8jcnlPVrInE
	QLNv8lJjh8t66fcPrYzUWNwrVlU2jYBlW3V9UFGlnIodjoqKAI8KauJUT0B2pF67q7pqMc7NOTV
	bJYFjeb4Q4lb+CjrwcLmJEsUOg3nH8nnJGw4opMOPLiABzoj8b9AEjExmUS14fEC7liKbqf+Wyl
	PObPDT4lrCEZOq2OBzElPxck3hRJfeFtXzKMO1VpwMqcwVC1tbeu95k2pBEwS4gOY3xDS+WePTN
	hrzyj8ptOVu+sw==
X-Received: by 2002:a17:902:f70f:b0:2e9:660a:7944 with SMTP id d9443c01a7336-2e9660a7bc6mr31481475ad.58.1792123934758;
        Thu, 15 Oct 2026 21:12:14 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:12:14 -0700 (PDT)
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
Subject: [PATCH 10/11] ASoC: renesas: rz-ssi: Remove redundant component open callback
Date: Fri, 16 Oct 2026 11:09:45 +0700
Message-ID: <20261016040946.521195-11-phucduc.bui@gmail.com>
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

In DMA mode, the generic dmaengine PCM component already applies
the integer PERIODS constraint in snd_dmaengine_pcm_open().

Since rz_ssi_pcm_open_dma() only applies this constraint, remove
the redundant component .open callback.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/rz-ssi.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 9f36fe2c16d2..9a0781bb072d 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -954,19 +954,6 @@ static int rz_ssi_pcm_open_pio(struct snd_soc_component *component,
 	return 0;
 }
 
-static int rz_ssi_pcm_open_dma(struct snd_soc_component *component,
-			       struct snd_pcm_substream *substream)
-{
-	int ret;
-
-	ret = snd_pcm_hw_constraint_integer(substream->runtime,
-					    SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component *component,
 					    struct snd_pcm_substream *substream)
 {
@@ -1017,7 +1004,6 @@ static const struct snd_soc_component_driver rz_ssi_soc_component_pio = {
 
 static const struct snd_soc_component_driver rz_ssi_soc_component_dma = {
 	.name			= "rz-ssi",
-	.open			= rz_ssi_pcm_open_dma,
 	.legacy_dai_naming	= 1,
 };
 
-- 
2.43.0


