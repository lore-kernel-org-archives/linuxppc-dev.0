Return-Path: <linuxppc-dev+bounces-22624-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FAACD98DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:39:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4pZ6QsCz3bxM;
	Mon, 15 Jun 2026 19:39:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516390;
	cv=none; b=WjaYDL211MAST+RoCTvMH/sxWgfKFfMbVjV+QmEpIe8BMFEfOARGGG1odps2uoKh+UNrL+2M0cGSarbjLUANVR61hU/bp7IKk3G1YqRcCwQ0Vwfbd5+kga44UXGiZ3XFoNuoF/LaVeB6PqPVMz7ifqnt5QVqmATKJfyGb85hID1tZXCLbcphoCG2KslhRBafLgK1eiEDvWM0RIpTMIyuyA6INWytqo8KA5h1psvNkdeCO7/6SQeuFxLNtEgZtcnTHQPCfxKlQT3r1WB/2LvVWyQSPjIbkQmGbWOOVfiRdN0Y/sI68jUyNafuMsPTVErdYctz9Fb+9dorDJsgT8J0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516390; c=relaxed/relaxed;
	bh=ANb0KIfsTx8/8tZ1jjFTsAAUSzrIuzqzfqRTdMc2tcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRNYhy54XpuEWugcg00eivbtLKmYkp7bGWNiF46/EtjIF5+LS3V2Lz1EMwZBbpofbhAMjlgTNMhW9oEHlU9zdMo3UQrf5hseNw+ele9/LzdzxnwwgqDhjIyMrc7jSvca2TBWIW3xNMTtNWQnU9EcZjE1PZQEV0hO1cMShaMKYk0BKnGDeaTuGIYh4iuNF3TB7XZhrbvAh9uQSzMqTT7LWvZAh5iruGAOX7UXVNvGHc5Oa9qcYmvLB1QFPSmKol4Jrhon9HT2FUM/5IiyVtqb9EV0M2SRU6LygvwC0GRKrKufO5UBe5Ek0Fh77p2XNclHGjZYnhErVHg08LJz6XtpyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LFTU+8mr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LFTU+8mr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4pZ0tYlz3btJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:39:50 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so1853869a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516388; x=1782121188; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANb0KIfsTx8/8tZ1jjFTsAAUSzrIuzqzfqRTdMc2tcQ=;
        b=LFTU+8mrDMBBZ4bH8ejl2rXSJSVPFliloVDuOHoCL6unXFRkecnlpOu/8YD1BZ9zFB
         1MCa4ArEktr0PkxbwdLy4kqVeyQOwEt3/oe6BC0CYvd6+0g6NnYifZRbtna5/xW9xjBI
         Pmtmeo4c5pPFAAfV/fBfY8wrolyLjnpqi+/qPBFhV6I2EbSM6l29fNSDkzjOe24oh9kE
         T/PMy/9Z/AArSWvl1q8kYv+Fi6eu/B+DyqLousiYlvZjOEO63qxODhrl2mpZ2IBbcuhd
         prMHc1EIuQd7BKiJPbVFGcvb8p+4W46mo9gTTcauCstLC6iq2qIDBx02DZmMoj9645+h
         Qoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516388; x=1782121188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANb0KIfsTx8/8tZ1jjFTsAAUSzrIuzqzfqRTdMc2tcQ=;
        b=LNF2owIF/WFQzBsGr3A4gi3bSjXhrLWlOcsOoIDpJxe02oRqpS4GVzPMqFoCpBVmTt
         kKiv9h7uE/SFBQK+0Y5ySG5r4FEwFUE2RqvFzBLZdXGm720PRgWpnuwgVYqH7AHJyLlu
         OS+oVx/0qCsGzM1APQalGR2PmOpvp/CV8Y+TSaBumwgfOLKMn+cQvkmwoM7fpmxpprak
         aVrDmIMeOnDQ31Ht8Jym9iU0oxLQ/HCC2T1NZ2Ge/e74OTSxu1gwNRWzrU7ejZ+TGl16
         4x86RQXbe0kFMJH3ajLUGg1nfFzverNKPPNcfNjsyE40g8EtRPf+D0kBJa2Q/RWIOfFW
         1rtg==
X-Forwarded-Encrypted: i=1; AFNElJ8KcHblLeg2fnA6js5oOYqpS05IAxvblobNBVbGynpwHFMaLTxEvQbk5PUCVoZcmGWw+YMua2D7MMQzQ+o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQURQ/zq83wN9U8LX79cGJBkaN6Ya+CCEOpot6R3m4tAcOfLHY
	jZvWN7GGY0FGUA4rlSbucS35s0RCFTSPTuheZ6kR316sge3zmICg3lbM
X-Gm-Gg: Acq92OEqKO2APPH/lcTQ++NwZwTpa2nFjMM+QjTUlglvk5Gl04gnP046r2HtPGczfj5
	R7xEQ6OBPFxVt7mkBJfzD4NxsNoKQOaiw1lzwAEbRc27LYKgZpbEsFZBacwrHXlo6jfXj4ic7HC
	xoWxaaEz28btDascDPejVkW5yuGKdEM0ltlI58PB+8H5Tqf8UsNxwXMJOsNhSCkCV66aoWFbgji
	VgVEtaUHp5/2sxyYywiOTpFd7CFtPqcGJwaNtk0TgQvMSto3w5WF5T8zjtjej+TdEKIkMljErVp
	bLsN2vI3jBOb5cs08wpZ60j10RxoRe2hZAloYKuteC3x03YnMigzAI7EQdVL/4GfX6eFQzLbDJL
	ONvW5BniMjLBqfNzVBeGqrxaQYIZjTX2j+1R98FYm7VIASad89/cvQA7qyyos/c0oXdXqfl2Xad
	Tu+PXjYxz0jg3YPDTn6v6q0Ds6ogg8CvNwJjdz40gRPAyJVp9XmclUBD3THQ==
X-Received: by 2002:a17:90b:1d8a:b0:36d:86a5:5b8 with SMTP id 98e67ed59e1d1-37a20016cf1mr10407905a91.11.1781516388272;
        Mon, 15 Jun 2026 02:39:48 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:39:47 -0700 (PDT)
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
Subject: [PATCH v2 03/11] ASoC: fsl_easrc: Use guard() for spin locks
Date: Mon, 15 Jun 2026 16:38:16 +0700
Message-ID: <20260615093824.115751-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615093824.115751-1-phucduc.bui@gmail.com>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
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


