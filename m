Return-Path: <linuxppc-dev+bounces-22563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A98CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:49:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMpz0DT8z3bsZ;
	Sat, 13 Jun 2026 00:49:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270837;
	cv=none; b=a2z9Tx6MV12WBNHZO7GqaHmwn367nmXaqpB7NX7iG2SUUvzH3tmR0O9ilDR3HCl/3qs1cA6QY/02FNXLuM0jj2ERtuYTLxqn5PHakmfZq4aHgwtoZejnJNDc2VbzISApKR2bvc3fr4nwj1WUhedVb4A7XzEQyp75UJg+BgKwaiWbyDsq5b/3bEciSkdGAJJ/iPt9b3TERJ+RTX5yfdpeXtC8tk9nNCngVhO32BRCzTx7JKDI3WTa6Qk2301klMNRhDrVRNtkGoHI1R7M11Y4hedV2MPeMiQ4vIljrExWKwUcd3px0qgc0P3/iTsLU6E3yvZxDPB7qpy9Z1rtpxeTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270837; c=relaxed/relaxed;
	bh=ANb0KIfsTx8/8tZ1jjFTsAAUSzrIuzqzfqRTdMc2tcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mad82iNf8ij0gIQA/LSTncFn03TJQBhcgDNtvEBngwjDUSCXP6WjUimQnQme8cw/YE1nGMNz3X6/PvZoI1wLhgQRbdYJny6OnzAOIP/naJut6Ct8R26abZ1V3Lt9FQChr8Jj2OmR/oiGd3L+AERP1GxTY6XVBf4DMb6pW/E4KmJaX5MDcGll5jjF3GPmBludWBVy5RAz3oLw6tEB27XCFfRle8KMpbyCmKPCoF5FyTfR7NEOmxx/AfQq7dN3/Ga2H6LKjKmZ8s1GRxIOCi1igkbnGyBGtv5Tc45BOIVNU5FL1humJJ0kqaBdZBJGCyoOZrFx63+J07cQMVchHNqkoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n/6MK4+X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n/6MK4+X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL0N3Qbnz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:16 +1000 (AEST)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-30749947917so2923783eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270835; x=1781875635; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANb0KIfsTx8/8tZ1jjFTsAAUSzrIuzqzfqRTdMc2tcQ=;
        b=n/6MK4+XnlEBZBmMo+xZ+lZJvbucrOZSCokD56kl/HdPQ4pqNcZz4SMYyRfpte60kt
         ZtVk0E/U+LhXpCzWhw6T7GC9myr5JlaOb11/+rLoowSU0WbG4rzqxhHL8rLBER+AcyTB
         MaVOB9FWmsV6MhLoWR0lzuIJQVtxssCX4pIqf0LSO55s8LHJ+PgU6WuJbNSt0C28uUr+
         xXx1uX1u5BmnGqhklnCb1+XhTjk9qjBy3yiqohZv0otfV+yqa9kYJKirp+qg3VnbCJgU
         EPN9EPicaG4WWo8rH29oDDaLSJfcSVnKCZPncnmuye5UfyFECzKuYYQBjhGMSqL8c2/F
         96pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270835; x=1781875635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANb0KIfsTx8/8tZ1jjFTsAAUSzrIuzqzfqRTdMc2tcQ=;
        b=IOHC4gE+79a8SZBrylR9v+25I/wp2eTTFRQh+hTYucyJBPZ1sawZs6A36VaVvGxS/N
         iPr5GHsfmZ9a4zEAtQKrc5+BZY3MUA/8RIgcYw9VmRIqC1ytS9SHLKsc3BXH2pbsHoia
         XxNGmbZ4YMQGbtUrFQ624Pso1vGP8TGo+vGXyaW7VthebSKuDtW4veY1HL0DQFETl+wW
         Z+gc7LX3hk3MQ7InsW3li3AIH0opSZHlgJs/t8qU/MMB3gU4mvqn7fLca61drPR63ur9
         q0DFCA94X3veNfwzOTmgQRa5yJ5eBZKQBEJLnPwVNGTOapDT2bBeAlHGaDJ81aliI6MD
         UjEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PcDzy7jaU0JmTTaBk8Y2q5vN4G64UcUSygJrkK4k0vcTNN8zLooEn27UAOJIXvO1poEWnfJCa3R5dT0E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz13+6EA4EsCxHmHIBHwIfkAPo7NQKqY5mk/KPMg6dMabuVQBB0
	aHYb8/QtcRgKQSaemqi8mE9rWOCiD2O5WX/D6Gc/mDo/JJ3p9JuqY7+3
X-Gm-Gg: Acq92OGDg7ViIuO1S3iCDgLONLcspWeIMaTzXl8ymnuMXrKNxf/hS9hzOjmS3ouUthm
	t5Cm+MTsuAYoiGP7FhuxTjJ7UP8XyZjNrYmOLSq0g6mnlsZjb5G6ptkwXYytEsJ4g32LNNMgX0t
	x/v8RA2vkzTB5WaLo6aVxiu7xXl6lknNeiW9cpWW5kACJKOsJM2L0X2P1FXzw3qPWMD21yHeK9y
	8zOi1gOF040IXiVxZG1fV642nXFdy5AxzuDb4rn/TnoYjJCbokTQtT4nQ/bwUY9PcHSqQ32veCF
	cn6n2LM0p5YR+CPVOOD/0TdACvUX4STeNnmZQSFKzfHi4DipJpN6w9dCfL2j5uloyS/FDyKKnY7
	/bH+V0qzq+HU3PNexPJ/Yc+pN/QnCDJYeeJK1kgSzaxkrDUMcgQy5Gp5MP6PL85mQ1zyIz7CJHc
	Jzi9NbpqBuIsgfEqZfA3t+DS1+uvrZR7earBZ/oJpwk4+yEnau2WZLTIvdHPgcoMKTuMI3
X-Received: by 2002:a05:7300:ec09:b0:2ed:e15:c927 with SMTP id 5a478bee46e88-3082021fa5fmr1811315eec.35.1781270834683;
        Fri, 12 Jun 2026 06:27:14 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:14 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 03/11] ASoC: fsl_easrc: Use guard() for spin locks
Date: Fri, 12 Jun 2026 20:26:31 +0700
Message-ID: <20260612132639.78086-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612132639.78086-1-phucduc.bui@gmail.com>
References: <20260612132639.78086-1-phucduc.bui@gmail.com>
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

Clean up the code using guard() for spin locks.
Merely code refactoring, and no behavior change.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_easrc.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 114a6c0b6b73..edfd943197a0 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1025,7 +1025,6 @@ static int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
 	struct fsl_easrc_ctx_priv *ctx_priv;
 	struct fsl_asrc_pair *ctx;
 	struct device *dev;
-	unsigned long lock_flags;
 	int ret;
 
 	if (!easrc)
@@ -1053,9 +1052,8 @@ static int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&easrc->lock, lock_flags);
-	ret = fsl_easrc_config_slot(easrc, ctx->index);
-	spin_unlock_irqrestore(&easrc->lock, lock_flags);
+	scoped_guard(spinlock_irqsave, &easrc->lock)
+		ret = fsl_easrc_config_slot(easrc, ctx->index);
 	if (ret)
 		return ret;
 
@@ -1301,13 +1299,12 @@ static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
 	enum asrc_pair_index index = ASRC_INVALID_PAIR;
 	struct fsl_asrc *easrc = ctx->asrc;
 	struct device *dev;
-	unsigned long lock_flags;
 	int ret = 0;
 	int i;
 
 	dev = &easrc->pdev->dev;
 
-	spin_lock_irqsave(&easrc->lock, lock_flags);
+	guard(spinlock_irqsave)(&easrc->lock);
 
 	for (i = ASRC_PAIR_A; i < EASRC_CTX_MAX_NUM; i++) {
 		if (easrc->pair[i])
@@ -1331,8 +1328,6 @@ static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
 		easrc->channel_avail -= channels;
 	}
 
-	spin_unlock_irqrestore(&easrc->lock, lock_flags);
-
 	return ret;
 }
 
@@ -1343,7 +1338,6 @@ static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
  */
 static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
 {
-	unsigned long lock_flags;
 	struct fsl_asrc *easrc;
 
 	if (!ctx)
@@ -1351,14 +1345,12 @@ static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
 
 	easrc = ctx->asrc;
 
-	spin_lock_irqsave(&easrc->lock, lock_flags);
+	guard(spinlock_irqsave)(&easrc->lock);
 
 	fsl_easrc_release_slot(easrc, ctx->index);
 
 	easrc->channel_avail += ctx->channels;
 	easrc->pair[ctx->index] = NULL;
-
-	spin_unlock_irqrestore(&easrc->lock, lock_flags);
 }
 
 /*
@@ -2292,15 +2284,13 @@ static int fsl_easrc_runtime_suspend(struct device *dev)
 {
 	struct fsl_asrc *easrc = dev_get_drvdata(dev);
 	struct fsl_easrc_priv *easrc_priv = easrc->private;
-	unsigned long lock_flags;
 
 	regcache_cache_only(easrc->regmap, true);
 
 	clk_disable_unprepare(easrc->mem_clk);
 
-	spin_lock_irqsave(&easrc->lock, lock_flags);
-	easrc_priv->firmware_loaded = 0;
-	spin_unlock_irqrestore(&easrc->lock, lock_flags);
+	scoped_guard(spinlock_irqsave, &easrc->lock)
+		easrc_priv->firmware_loaded = 0;
 
 	return 0;
 }
@@ -2311,7 +2301,6 @@ static int fsl_easrc_runtime_resume(struct device *dev)
 	struct fsl_easrc_priv *easrc_priv = easrc->private;
 	struct fsl_easrc_ctx_priv *ctx_priv;
 	struct fsl_asrc_pair *ctx;
-	unsigned long lock_flags;
 	int ret;
 	int i;
 
@@ -2323,13 +2312,11 @@ static int fsl_easrc_runtime_resume(struct device *dev)
 	regcache_mark_dirty(easrc->regmap);
 	regcache_sync(easrc->regmap);
 
-	spin_lock_irqsave(&easrc->lock, lock_flags);
-	if (easrc_priv->firmware_loaded) {
-		spin_unlock_irqrestore(&easrc->lock, lock_flags);
-		goto skip_load;
+	scoped_guard(spinlock_irqsave, &easrc->lock) {
+		if (easrc_priv->firmware_loaded)
+			return 0;
+		easrc_priv->firmware_loaded = 1;
 	}
-	easrc_priv->firmware_loaded = 1;
-	spin_unlock_irqrestore(&easrc->lock, lock_flags);
 
 	ret = fsl_easrc_get_firmware(easrc);
 	if (ret) {
@@ -2377,9 +2364,6 @@ static int fsl_easrc_runtime_resume(struct device *dev)
 			goto disable_mem_clk;
 	}
 
-skip_load:
-	return 0;
-
 disable_mem_clk:
 	clk_disable_unprepare(easrc->mem_clk);
 	return ret;
-- 
2.43.0


