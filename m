Return-Path: <linuxppc-dev+bounces-29539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A5CCC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:50:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rcc5rPBz3c55;
	Thu, 15 Oct 2026 12:50:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792029024;
	cv=none; b=ZFjScxsF00OVv/tWlHHdmz3zG2KXQPZgFiPFitkJ1v1KFiSYjPyC1kW8OtqcY7yuPWGLAzCV+v/OdcTir2kDSWANZNqQDiA1TOCkx5fGeZjTGmZckW7ijEofqj9bWMjAEsmqk5yeu530avw3nQrGRwOQCcfHYdcBzQEBvObuY3pIUExQMf4v/rQI1uBkthxT9/g2U5G3X4oZCPr3xJT4XdNM4IQlXmGp0owlIMR/wRyfG60lgSl38jVInmlifMp+8u26CgKnA+/UYzB+LB1SMwJUi6yW128QDkkXdzHyq5SNPxJB2alNEzniIjgIySkiAQ1AjdE/ih9QEAydBAjCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792029024; c=relaxed/relaxed;
	bh=adbLjE108wpHReKKgrEkXzgfA1DRZ6TN8trHQTyRjGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gn/eNmONFRb3zSpWtqEDQa1+EhK5YVApu0kP/rwMcwtIlESzYS+kQkAQTDg7ef+soplLlH0PxsGl0/Gxn/rDhDrfIxrfrko5/UYSIuPEa/93Hxxun88lQylgCungdn+m7ewg6pHqjMjSqNsL4wcz+g+oe5jTQhZdInHEm//ab/PAyVLS5cjZ721+NIj38TOpZd2CUzlgJnPeZWCRau4n26uFlv0MIKRGmNmH1v2K097tX9ZU40dIhGPMg0X5bPiIXE9nuEsFJaNKMDjwIFTdjnXdmr15hUNtBtkleA3PlKGyrH3UlghqBfRcJN3k/34ZkA5vBlDq11EVM8s0DdC59w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N6ETaUKe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N6ETaUKe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rcc05Rhz3c53
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:50:24 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2db80fcdf8bso27577415ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792029022; x=1792633822; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adbLjE108wpHReKKgrEkXzgfA1DRZ6TN8trHQTyRjGk=;
        b=N6ETaUKeRUTmevrkZShQ+FXsgJDJXkn39CemUBSsD64/txl0BxzAN/tk6j4tuzfoWy
         7Em7zcjfbHIl8OVP1FeHqN8v0jvGe/tBno9jYkp/jTlMUTOKdYKGN69aTSfWzZ9IxzlI
         EX53u/hYu4GP+BUJ8XbVehGN30nqU7q0Ls3srI/hqnkaAeM2MJNrVdFY1r1oVsOoh7qK
         RUY4IzA92EgOckdLYUfj2iRru4/HJVOx0apgNcxgT9ychEnPmK02+4oV15qGeP1tJzEY
         UMEC6UzFQqc8ma3JKHTS7U1uM6qa0kve9onXaUZ/EX0y7hsl8M8vPq8uQrYreansFH01
         BZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792029022; x=1792633822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=adbLjE108wpHReKKgrEkXzgfA1DRZ6TN8trHQTyRjGk=;
        b=Hf+VtETvfXFWtXs9xXf1GUWbJi/CJldJJnwi53MP9tFMLN1UyhaFiFOIauoiuOMfyD
         ByQ5+9SpJu8/9A8GGZiKIqYy+dKRCglkOsJNfqOmwIKr+cLTnamcVJijlfUEbU5rJZEP
         DZRtzioiKulaynSrmZUFtdNl+fpViShoAut1gQdUFWL7e9xUaIgu7QyXmdX8Kw1fwv6B
         O3tnoBi9Nttxc9JZFih3PIhqrSeLMN4RSBHTFE5n+sr+msKfT+4zF99kn8U1ToalliHg
         MWsTzm4gWipybXGetB34Aa/9+pPbLEyE1S14USFKEkEl7/ebtIcYlm6uuaHgXEg4nhBC
         CRWw==
X-Forwarded-Encrypted: i=1; AKwUvByMbbVNTlKGIzingbF4W2EbQ+34yBiLbMc4qEKx3Vw+oKPSUOYRS32Hkygf1ReJcV6K7GZ88Xal19YrS0s=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIhSoADncVh1sXv7SyI4KhOj/hCjxB33EhvKQFDwwARIblNNKo9
	qQyT758JnERvNkhRsEsIq8vp3x9rOrT33rxgE+ny5qM9q/w8FgZt6/Hd
X-Gm-Gg: AYBFou2hV8MNabEc10S3gDId9iW4HGbn7r4dlntpHFtlmw6KFDjeID5NDM12J6yIJce
	IO3ZUCR54illnZBy1x855lgg2VOjNpTx73jearg6HovF7Y/8P/I1wyMxnbh7xusdYMgB/G9gOhf
	B7bevuo6/8V4DCVQD6VTwGx4Bp2rnRbX0lSJ8EQWKxKQr9Db5qa7cqeu6e/oHTxqO+ZVXV1n5wL
	IG7TjyD7AnHd6t0eizKT7ASq5zje93GpVLEiEBYXqjdkWS5jaJmQTw3aAXhVRJ2KMJoihyXSKVQ
	GE23Tg1BcMMqCes3R18DwAOBwDbtNlr+LLCqoAbZi42Rbxw+twPF2PPuMoQQPE0GTezdSJwO+7A
	1Pq0P6kKM6+VLKTkoQvLuIVD0R4DaMIfzJo8jOKYoyh8y15rEsszxViY4KH07FXtgEna7iSKPk0
	NfAZKeL/VrdIxAbirSyOV7X5zsCn2K7PWyjXGAS2VK/B4mC3B4TGJiddlzqGBdIIUiHF383lGcv
	Cn2zQQwfl+Kwf3k802gQcgpQdUfsuu+CFR87ZnkIl5YutQhNxlDpcHmr9lDn9otJ5aOwZ0Lm09j
	OoG1qX8twP7spQ==
X-Received: by 2002:a17:902:ef44:b0:2dd:c100:7cbb with SMTP id d9443c01a7336-2e842bc6930mr140413355ad.55.1792029022012;
        Wed, 14 Oct 2026 18:50:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:50:20 -0700 (PDT)
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
Subject: [PATCH v2 23/25] ASoC: renesas: rz-ssi: Remove redundant component open callback
Date: Thu, 15 Oct 2026 08:43:22 +0700
Message-ID: <20261015014324.5569-24-phucduc.bui@gmail.com>
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

In DMA mode, the generic dmaengine PCM component already applies
the integer PERIODS constraint in snd_dmaengine_pcm_open().

Since rz_ssi_pcm_open_dma() only applies this constraint, remove
the redundant component .open callback.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/rz-ssi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 5f4a53886541..9a0781bb072d 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -954,13 +954,6 @@ static int rz_ssi_pcm_open_pio(struct snd_soc_component *component,
 	return 0;
 }
 
-static int rz_ssi_pcm_open_dma(struct snd_soc_component *component,
-			       struct snd_pcm_substream *substream)
-{
-	return snd_pcm_hw_constraint_integer(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_PERIODS);
-}
-
 static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component *component,
 					    struct snd_pcm_substream *substream)
 {
@@ -1011,7 +1004,6 @@ static const struct snd_soc_component_driver rz_ssi_soc_component_pio = {
 
 static const struct snd_soc_component_driver rz_ssi_soc_component_dma = {
 	.name			= "rz-ssi",
-	.open			= rz_ssi_pcm_open_dma,
 	.legacy_dai_naming	= 1,
 };
 
-- 
2.43.0


