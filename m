Return-Path: <linuxppc-dev+bounces-29520-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F5ECC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:45:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rVn5slxz30St;
	Thu, 15 Oct 2026 12:45:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028721;
	cv=none; b=W6+80YO+m1ikBjOBwZNumFSOwVoKJp/A70d4vE1LmKdnltqcgT1CXvKkqWkMPUOekXBPEbXZZYy0KAAT4jFYNQgvifdYG2bJ8ZxhnavN3URMk+ZG7eCs5r1YLG9vIaZhaJHNAkp1Y46z43oaJp0wGLU9TS7FuOf+DfOnoF4sPk/muFd8LdWoH/qkWT1PUbV48YATmsS1UzGZSlSzWJjJQrbbzR5KadM09S7ZCCJQOdQrHPS7EBfdr9yB5ciX16bCICKDNmx2e/sZ0yCdzefKuQzhsI1ve1+FMkYURH4Z+qUhtHDnJU9wvt+AfCq3pKp6lXABVRq/BEg/S+8DkiW/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028721; c=relaxed/relaxed;
	bh=LV2XZk4JI85UeqWxHMk6K3Umo8587cjHfY2RFPxWAV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auvpxxZAlMzdyY+BEH9HPKgqyxT3goKU8IT/G587ejAIaakz8nrZsuR3BVLaV3taDCaB1T3/RD9RualaUK/y5agZbQ9/qL6hxRr8rPCaqnO5m3JeRsMqqmDdB2CRbp3FXX1nZfA6CJjrrh/axiRZYcXhav8Mlgrkjp5pI1OiXizjol4kn+k8FtUKYoRhsKwz2Pn6aGQlvJs1tHY0zWzQVvDrnA6F1h9Hxb6UtfyWiHJ4NVkb0ATDY31rhi08IkjxbSochJWTSNxHJcZEjsNQwgsxZboyvh7fD3iEOrDgp/EeUHOMj7OXaE7Q6V7TPM+S5dDjABunDFet62GH5C5PiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SxyOydiF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SxyOydiF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rVn10SJz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:45:21 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2df8c28a0b1so22288415ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028719; x=1792633519; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LV2XZk4JI85UeqWxHMk6K3Umo8587cjHfY2RFPxWAV0=;
        b=SxyOydiFYsDKIVNTyWeaiUijsmpV3DyhscVX4NFpEc1LnWt/ZK//clE00Q2lPvVF0H
         eD1wvgYpPZt1Y2x58zycCsr7W0UU4zflIFA2kwKimgUpDyLG70S2ljLetw0+3w7kBXMU
         eRHSxDMv6P4Zg9GiS3AkID3lyxToZU0eSEK1BwYdvPEdLKVpXF8wugvk/HvHxKBDEWG9
         C5bvScKDzWcdeCkse67eGj5kJRMK3BE3nIPrLEJsQ5gN4CHDfRknO5gH0pgabnzedtjN
         w7ewyKx/1eP/8uArh8SMgj/lcThPp8bqxMJjnsdP8uEeaA6odtWeNRVFWWv/RE1KZIqC
         Bf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028719; x=1792633519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LV2XZk4JI85UeqWxHMk6K3Umo8587cjHfY2RFPxWAV0=;
        b=nz3CGIQUbYuO0KLCGOTtohXo4yej1SaVqSfczU8U2NG/ChwL3lr6OWDuuSwLCLIfJ6
         djAOJ8n6zYfLJUd1F3B+l+/+PZ+SoMSaRZAP7svTzhfqYvg+duHf6+/Y2quq2p/KvJdN
         grw0zcKnYR7wpRw2WzOLmXM4tHv10Rx9hQteZ0gPCKcJGn1HcIb2Ah58AD/hagmyhP22
         gZeXYg5QlEzyTc0DLBNohqP5+pomwiJgTi1SbowgeBBGmj99ETYLyeEw7a6ELKmI7N5Q
         yiYh84YCXyQ8KdXOfw5aNU8K3+I1Z465Zkabd4b8U5JZV5jDCXwe5HNKdTWDmgBTkPVL
         rHEA==
X-Forwarded-Encrypted: i=1; AKwUvByk+uSL8LRerZyU976EWq6svapQIDMbCXQrTz6l0x+K9z+9/CpnsZyv+TDoDw6mF22tKTBtjY6djpd1JGw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKbEBJIvEmzejQx3PhHbUSsNgyJcmqeHOzCvIu8jBi+iiqKhjEE
	GN1udC1DGgSY81ekX8ExmiR0h2C3knShjlx6V4DldgWyH+8UV+iYNBo8
X-Gm-Gg: AYBFou3ZtSzcsiWOopzyH3Lr6qbSNV+qnkx3RkUdKnqqtebsW6FGjBIn/J2MAZEm4mK
	94ylx68uedB1ClsXNMqk/MA1fE+pUcNkBl3d8jB0yMCpBVpb/Y2QZ0pVaVS8erBYyyW25KceLfl
	nFLnf8xbmeJt0HjZ8NUvrdF6dxRP01VO4NnT5ErWy/+c8eudu1OjyATBiLYnOYEpK2wjwkperBs
	tqslW0I54ktGBCMfSKazYQg2RtS4Q0Bg4oM7DJOHw4sj21UcriASGAl27ZHEfKA6M49LFSpo5wZ
	wkN01aNdiVYNPM6vSoD+vEexPg8/Duqon9itT+PJKh2dJPhlwtxMgWPTKyp3xnnUwGt/Yten+vx
	2Wo1gsNEngc99SKgXAJqIU7ozUUAi4RdVB5IgzeWW3U89yIJ0IFCjGfK0T4inCzEvzVfRpY9Vdu
	RJUmkMm9kqHIa/cgCXFLTfO3r7iwp3cK+knwak16l0/fOuVsQhi4Ds9cnA9sxJTwmrUFense2+g
	PC4s/Af6hbXTeNxFa6Y1KODabeKaYcyi2VpMr7urBbPx49SUb3WcADBL2Dp8th73uh4icqhk1k2
	+c9Wr+RVtnR4yQ==
X-Received: by 2002:a17:902:ecc3:b0:2dd:ad73:5b6b with SMTP id d9443c01a7336-2e8429ab7acmr151706215ad.27.1792028718870;
        Wed, 14 Oct 2026 18:45:18 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:45:18 -0700 (PDT)
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
Subject: [PATCH v2 04/25] ASoC: amd: raven: Fix acp3x_dma_close() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:03 +0700
Message-ID: <20261015014324.5569-5-phucduc.bui@gmail.com>
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
from acp3x_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 703a6e22888b ("ASoC: amd: Enabling I2S instance in DMA and DAI")
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 37ea5c572eb9..765057499021 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -237,7 +237,13 @@ static int acp3x_dma_open(struct snd_soc_component *component,
 
 	i2s_data->acp3x_base = adata->acp3x_base;
 	runtime->private_data = i2s_data;
-	return ret;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
+	return 0;
 }
 
 
-- 
2.43.0


