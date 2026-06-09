Return-Path: <linuxppc-dev+bounces-22385-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CE2CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 04:40:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZtPt0VCMz2y1Y;
	Wed, 10 Jun 2026 14:40:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781009228;
	cv=none; b=c6Oqs/6NEEwWJSVIlHm0RRPjOfIu19hlt6CREmhPvCG+S2UfeaEBTa6zZSF8MKABcoFwBPO+F4FTaCtWQdVlsixENTVy8YVVH2NliOCf+dIx7YCm54Yyv0RRE9w2GXhLhI+smBHM5xu9YvX4vIG9C2GUtYJyBUBq7ti1YJ3uvq75qFapA526Lr2MsQPhO+0okri7fsjujJ2YZYSbeplTOTG3+pVw8nFeGhvtYT3yf8VVlWCfqS2BHyuUzp3P4nSeQmjx4BCLL374hswoefRPMs81FyndKbBlp6pef3cufB9weUWLNPVAyv0Eibm+6OHODNigZn82QuVJOc4r8rqZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781009228; c=relaxed/relaxed;
	bh=keoU58MOi5VGqip4nmTurg5eYjRQQf5+ZFnAVokgfv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIfLvewuNsAjvZZVGzNZzj34AEOJrgbkqp8jYCkz41uq1CnnQDBng4IyzQYWTZteQgk1HjWVSlXOw/eAHrBrECTOea6ta2gy6X5sLvfTP2i4/LWD7fpuv9bfIUUVKLBmBC1fjsbycBzg1JV2mWEwJ8fcaX99EOAXdbjdo2kay0Ul6CR0rMMWi3pfW/6fyAmtTOqQrwHqQvsvlbmTfZAHuBBX7Ww2RXQP1CuZ6Hj+rRAf95C8W6uIYeriJJsF308vBSsADoZJDj7mf1xZIYf8abLaE0XFin9XdUXqpyz3Y8dla1oA7sJ82WFmZujmE2rmfiMJ5/tWikMbpO++oLNXVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X31QsDXm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=sammiee5311@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X31QsDXm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=sammiee5311@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZTFR2kVnz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 22:47:06 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-36baec934b6so3595286a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781009224; x=1781614024; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keoU58MOi5VGqip4nmTurg5eYjRQQf5+ZFnAVokgfv4=;
        b=X31QsDXmDBU1TI1+5nmG/6OODIYujWgpcwX7mUxQj8lin+Omz9MIG2A39kBVJECb6f
         5oPxkc1deKr96njT8Fv1YbpbqOSId09oSTNJpWERAkI8w5lMEz1SASDPMV3zcPcd9j07
         2OJ9Zj/wgXbQsNRvBZdVKD+QEXdnnALbaI4RITC7MO3GqB+EixjjdAWEjUNby3hNeenk
         hGpp89HZe4vrU/oUrYXLza0kzBIH5VIVCUrh0zhiz/HhypZpIaYxLNtFiQ0k+KJhZ0Mi
         2JNbCwj/Ap4btfhVW9dF+JQuZ5JglH0BGJMGTPumlipA1pAKp4U/nMRC8XOtvA5SruWF
         rmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009224; x=1781614024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=keoU58MOi5VGqip4nmTurg5eYjRQQf5+ZFnAVokgfv4=;
        b=RWQdHDh5/DbN1b1gau22VW0t8GHze55eKs+Rzw/mW3EP0pFVoaU+22Ti6K4C3bZJfm
         HCmsqEMvLkHEOSP5xiMNvmgI8SGtBFwqAUSOeKKEDGi8bLSCZbPjxDUDx3MxEHRcUYZI
         FOq1ZqT5sSeCCPmkRu3QpA2ZYK8XnfVpUuaLB9Qh5SQwNakWdUU/I1lQFqKptQbW56gW
         zjxxHl0kQX7KBDdt9N2BjbuFJuiMjJQhtgVVmvIxJcS2dKfFTroiidorSPSSFoKaE2JB
         09FqCMBAJU4wq8I+9DQNCILd35eSUX390MQlvLv+RPac5eyYt70V26K08A7Ex2vBBLYJ
         B9ng==
X-Forwarded-Encrypted: i=1; AFNElJ8VNwrs4dvjuVj0fUFzNPeS/3QLX2rCRvaqf3WG1pZu0hU1WVEU5Uck/XrvSZB8SV7jvhGcqPStIoyGCfM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxXgl+Td4Hou61Zuhv2ljzcmARhXx4u+vUxxdO5XZBccxfxDeB1
	ZYCwBvl5dS9eKLqCY7l6Sal5cTDd5a/jVf9HeLf2G7aQh9hVr+8LVAUp
X-Gm-Gg: Acq92OEarC2PEiTb7RYWQf9r8ZkuMPZthHrh/Y/UxvITDq2RB4z7IR2BOWWXZI7klTw
	B7Zh8ekquiy9jIxU1bHyMdzLV+vU4PANcNLAro9cq85Nj9TjyJcVSydYjSvECsmn7pof2cd8VrE
	Jaqpni5jQWoz5raviVmVDe8+UZWdaglj/3g+Fvp3Hs0JFNG/kYA4GztfZ/kj/URoBLBSGQyDz4c
	fDJvTXnBpbgWD3AD8gKkRUvC9fUr9pBWuLJDPXzMHmV7o3oRXbBZxh0EYXgy4TfSIX4sNNTeZVi
	LlITJB2+p2EMZdTVVXFBhx8O4pQuzRA7IsmpRA5pClgHKgQPxNiZnXnkNpUPnYfGmI6bulDwdrF
	a+bMn+HPEYAKfk/e4LYoBbN+7y08LIuiQsccNTxI7B0UtSCS+6llceLEuX3ZbEUTUSpXcBymg8o
	aSzwyTbwGabuQJfaw9Mb1GoWVa7xF+PNa1c9CQ/2DMgnnuy2ET1yQqLgQp+xIv59LIuVvNdj8jh
	8zZUq0kR705JsQGNvCiBKPRZZQ=
X-Received: by 2002:a17:902:d2cd:b0:2c0:b74f:a58c with SMTP id d9443c01a7336-2c1ec7972e4mr167544185ad.16.1781009223982;
        Tue, 09 Jun 2026 05:47:03 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d40asm204686345ad.64.2026.06.09.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:47:03 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Viorel Suman <viorel.suman@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] ASoC: fsl: fsl_audmix: Validate written enum values
Date: Tue,  9 Jun 2026 21:43:15 +0900
Message-ID: <20260609124317.38046-4-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609124317.38046-1-sammiee5311@gmail.com>
References: <20260609124317.38046-1-sammiee5311@gmail.com>
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

fsl_audmix_put_mix_clk_src() and fsl_audmix_put_out_src()
convert the user-provided enum item with snd_soc_enum_item_to_val()
before checking whether the item is within the enum's item count.

The generic snd_soc_put_enum_double() helper performs that
validation, but these callbacks use the converted value first: the
clock-source path tests it with BIT(), and the output-source path
indexes the prms transition table with it.

Reject out-of-range enum items before converting them.

Fixes: be1df61cf06e ("ASoC: fsl: Add Audio Mixer CPU DAI driver")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/soc/fsl/fsl_audmix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 40a3b7432174..f819f33ec46b 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -117,6 +117,9 @@ static int fsl_audmix_put_mix_clk_src(struct snd_kcontrol *kcontrol,
 	unsigned int *item = ucontrol->value.enumerated.item;
 	unsigned int reg_val, val, mix_clk;
 
+	if (item[0] >= e->items)
+		return -EINVAL;
+
 	/* Get current state */
 	reg_val = snd_soc_component_read(comp, FSL_AUDMIX_CTR);
 	mix_clk = ((reg_val & FSL_AUDMIX_CTR_MIXCLK_MASK)
@@ -157,6 +160,9 @@ static int fsl_audmix_put_out_src(struct snd_kcontrol *kcontrol,
 	unsigned int reg_val, val, mask = 0, ctr = 0;
 	int ret;
 
+	if (item[0] >= e->items)
+		return -EINVAL;
+
 	/* Get current state */
 	reg_val = snd_soc_component_read(comp, FSL_AUDMIX_CTR);
 
-- 
2.43.0


