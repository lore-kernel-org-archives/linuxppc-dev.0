Return-Path: <linuxppc-dev+bounces-19328-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7374EE64013
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:48:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXLb5lWmz2ybQ;
	Sun, 05 Apr 2026 22:48:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775328332;
	cv=none; b=D+D6ddxhHuSO6bMSK5Ti3gZDZMDZtR0iE5L0hbRpQjia9MOh1kc7ztC3peM613XzV5j/KBKbFlX6EgBVXg4iJghYn1JGeE3PCtfb7NcgGib0UpoZq7Fh0mISQeOhmKNijQgcfSTDTUKXUg4B49603RxM2ke1VAtMu5vYxus3dQvAeqvR+rE3LlaidAD9cBKBQa68iA0MQBJMBKWIuzmJxigr1SssyiJPmyqd61Tezq5S4vKSoeb7ubGk6GkdxVEpnr83mnsBtE97QHKe0UZqJAYNkVptcGS/BqhRWhwVag4Pb94uCm0zAvZFOSyVIgaQv60OGqeRavt09tZOVLdLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775328332; c=relaxed/relaxed;
	bh=NSBm8CQ9KV1sZc8xqRJrGb0nqJcw/MhMvwITjTm4MlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wdv7nLrLUfYeZf/AuBR/QizhJsVadsoTjDd/Z3qDsyIsORsXtONrcl/fbv/hUXfPaxCqM8ZqJmbrwPbuC/GpEgFC4rk2w2xxBNGJnw1mem2kQ5+bGgmV3NSPxl9b3HZpBjdWFPmDdGpxHAF6GAV1odIBQf5AOOri4KobRqnnl27s/kBXhKwy3kMP7eBHZYQI6VwaKfB+f2gawcT0N/YXL66zrBXTmxbc62zP2HF0j4TtA0TrEIpU8mpYsc21Qw1IopoR9xDl9eaDU/duIL+tTQomx7wU/2iY0DBJtkW7sw33PPx0PNki2a81cYSCl+5Nokx3xJRIRToUA2QjxcNhMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ViRbAUtR; dkim-atps=neutral; spf=pass (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org) smtp.mailfrom=nabladev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ViRbAUtR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabladev.com (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 569 seconds by postgrey-1.37 at boromir; Sun, 05 Apr 2026 04:45:29 AEST
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp4KP6qdqz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 04:45:29 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EF60113200;
	Sat,  4 Apr 2026 20:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775327757; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=NSBm8CQ9KV1sZc8xqRJrGb0nqJcw/MhMvwITjTm4MlU=;
	b=ViRbAUtRvwhoms+GPAP50uGr+Fp0PaHUne+gjQOz+eAmdLPm7y0XhoHq4vwoY1j4vwGZiq
	OFxMEJMjVq7q5t4IWVCuReOUCQcDeO2YwfwTUdjqiCDOVU58T62n5vcFqawha1xaZKQEZ0
	X3vrGhWvNAShQ1aweYxL0DXdk8hT9mcc5poluSoIvX7oqZ1sZOSMh8HVVOgb3F1L68eVcc
	rd5N4QorFVSLTLj/RlnZqyosbDQjqtW4rV+LUeqvde2p2JSogw2vXDdr/odeb0S2vQXOcQ
	hz6OkvMGiyjgwnmwY+Tr5X6YPA8TbUys9pj8u6OPZpLPe7iAvIOy/jE+PKojiQ==
From: Marek Vasut <marex@nabladev.com>
To: linux-sound@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] ASoC: fsl_sai: Add RX/TX BCLK swap support
Date: Sat,  4 Apr 2026 20:35:01 +0200
Message-ID: <20260404183547.46509-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404183547.46509-1-marex@nabladev.com>
References: <20260404183547.46509-1-marex@nabladev.com>
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
X-Last-TLS-Session-Version: TLSv1.3

Add support for setting the Bit Clock Swap bit in CR2 register
via new "fsl,sai-bit-clock-swap" DT property. This bit swaps the
bit clock used by the transmitter or receiver in asynchronous mode,
i.e. makes transmitter use RX_BCLK and TX_SYNC, and vice versa,
makes receiver use TX_BCLK and RX_SYNC.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
V2: Update email, rebase on next
---
 sound/soc/fsl/fsl_sai.c | 7 ++++++-
 sound/soc/fsl/fsl_sai.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index bd336d2e4cb38..87a40e2b9fdf7 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -355,6 +355,9 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 	unsigned int ofs = sai->soc_data->reg_offset;
 	u32 val_cr2 = 0, val_cr4 = 0;
 
+	if (sai->is_bit_clock_swap)
+		val_cr2 |= FSL_SAI_CR2_BCS;
+
 	if (!sai->is_lsb_first)
 		val_cr4 |= FSL_SAI_CR4_MF;
 
@@ -453,7 +456,8 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 	}
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, ofs),
-			   FSL_SAI_CR2_BCP | FSL_SAI_CR2_BCD_MSTR, val_cr2);
+			   FSL_SAI_CR2_BCS | FSL_SAI_CR2_BCP | FSL_SAI_CR2_BCD_MSTR,
+			   val_cr2);
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
 			   FSL_SAI_CR4_MF | FSL_SAI_CR4_FSE |
 			   FSL_SAI_CR4_FSP | FSL_SAI_CR4_FSD_MSTR, val_cr4);
@@ -1507,6 +1511,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	sai->soc_data = of_device_get_match_data(dev);
 
 	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
+	sai->is_bit_clock_swap = of_property_read_bool(np, "fsl,sai-bit-clock-swap");
 
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &sai->res);
 	if (IS_ERR(base))
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index af967833b6eda..6d84e5ff2258e 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -118,6 +118,7 @@
 
 /* SAI Transmit and Receive Configuration 2 Register */
 #define FSL_SAI_CR2_SYNC	BIT(30)
+#define FSL_SAI_CR2_BCS		BIT(29)
 #define FSL_SAI_CR2_BCI		BIT(28)
 #define FSL_SAI_CR2_MSEL_MASK	(0x3 << 26)
 #define FSL_SAI_CR2_MSEL_BUS	0
@@ -301,6 +302,7 @@ struct fsl_sai {
 	struct fsl_sai_dl_cfg *dl_cfg;
 	unsigned int dl_cfg_cnt;
 	bool mclk_direction_output;
+	bool is_bit_clock_swap;
 
 	unsigned int mclk_id[2];
 	unsigned int mclk_streams;
-- 
2.53.0


