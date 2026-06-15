Return-Path: <linuxppc-dev+bounces-22625-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896A7CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:40:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4qG1w9Kz3btX;
	Mon, 15 Jun 2026 19:40:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516426;
	cv=none; b=nzpWpXlOuE/Tc/pTMbQxs2Qh5/18rSpgkAb6i7zwaJd6HIlcqITi+hme0RfTIUEsk0A5+u4I2TZ9qoJR59ihkKWoWooQOMoqy67htk/4fVRF95FEpYTaMitJiOk9YugZC18jr2Ad1VYAssZKstv8DzEUQg92kd343MTmlvrWRzlDrwSaTwBs1Q8TN/LAgf1+rRo1i+iu9umm4nYSqTDyXCahW+uZIH5xyMiLE+8XTtAHTBOPa7vLPWvvopuG2t7srK0wV+8ON0khzQvfIWq1oCQj0/W8KXHfVWB3ps0Lwf+qVHuSq1KbvUPk2/TLQGcWRHPIvE4lPcjaR867MSCnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516426; c=relaxed/relaxed;
	bh=PmZ2sl38PCCS0bv5D9o7S4WvjIIRHmjBHALA0zfK1Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIMBKpAZ/UB8XWiy4bQKwG0INBOQoZ3v4rt1bHJ7nlyUXMM8Xi7lPFRh/66ndcHzEtciiIKsKRgfLA0zyjs8vOSxnUiZhOt9SKjON+jG+ylInG0P5DtNU/zWvnkPBU0OCCFd41DhiG9dsnUGtRPQFXc2ior7qXfl/ZTB1J8DePsaDnqBIjFzWCBS567kigqLminr6cHpVb8kA+Y41p6G57GJ0BdYinFSZ00tENm9LijmF1/8CoCZlog75BnhtCm4S0EhPLmgh9+zWyx4GeqwFc6Ub4oM5IDUunBnHkWEn2ywF3PeSJ2NOHnMDZfA+xbNYE2x3okKDRN9bYtdne62Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iZAP0Zk0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iZAP0Zk0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4qF3pqZz3bsM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:40:25 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so1472975a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516423; x=1782121223; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmZ2sl38PCCS0bv5D9o7S4WvjIIRHmjBHALA0zfK1Ow=;
        b=iZAP0Zk0w2WM+WseqWywnlZJrpG12OH6mZG0O7gseyDYcIxCw9U4WoyrFu6f5f2wux
         ZSu4/UrBj3S2jfUdWcjgrK7MCq7rmmw7cza6wFYU89YdUY2NdBXlnJKUpox8uP0h8saq
         0AY02IqO/z4XXnYRpsCwBDJGkXxhvEkdNiZ8/amlC2Ewswu6BzrWKJQXpXA76JVp44LR
         fmXfbNNjSXrIhVgop5IwAm3Oz5oJZlJftIy2nfSwf78JnvqsZcG/9Qw1n/fAuG4FCwmR
         hL2Bjk2zcyFUtKB6yM/9A/4F3l6jk8b6JiN7Z2IUIVuNvPxBqFsRM6m5I4RyKxCNowdi
         rx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516423; x=1782121223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PmZ2sl38PCCS0bv5D9o7S4WvjIIRHmjBHALA0zfK1Ow=;
        b=m6oKPA7Zr4MJLu/FQ+sDGWMBjgEhGEGhHRXR8KAECBieTsHLdVP39Y9jzoRP0tkjvn
         CqpIa4WiTlqBGovLAOMuecnDsvNQIVhfftCzqVmUHlGFGJb0USFaIRmSovuyYiqn3Ctp
         w7m07RGLinSuXNsjMe8cfv0yvrR/hJRGLninB5xQq4FESMBN7tVPqqltsGwLy88hHPw1
         8xjjHyy3mbhkjmheY5fbkDfsTdjC0pJEKrqYaatD6yPz+xD1jvmX4xWFItfuxZTBneXU
         9rnYQ29qQ3lIL+SZcVHLB64AL3kbi/s9TOwd3BW3JmMyEcHFnFTnDvfl7kGQo2+u21cP
         CDHg==
X-Forwarded-Encrypted: i=1; AFNElJ+OiDMSpKHvV2JxrtwpHROsqHKy69Gd2ZpUM6j7V9+PqI6GMLqwl2Qf2BwtxiNyNhitaV5cRb39nw5vz8c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyebWdKePyZSaixl3dZnpkhpvSQXa0wf3XdIgBkpJaimjMPuh+s
	nBRxvYTC8tdfe5CQ2xBsvz9JJr9GjFebBpAkxMph0G5zhdqHvHZN5Vxj
X-Gm-Gg: Acq92OHczVevCJ0agn1mF++ZKws2ThmV13NQ7II84Qu81zTUu3UO7qbpyZOuUdPfeUw
	4ZGfARoErfJEqasUYRAgjqNA6e1mOudNTJiAvCLI2uWWb5FJ+BVySt+tcpjIc8SFWFKErRUeGXz
	Cq7vW/JozHTX/8ru2GlTEAO2nxG2L6KAb6hMrLVcsAZhOAFloKUbUXJQ7sA7bbeZvKO+3WTmfat
	veHv/kROb6z2GiBvVW49I0HdZUV2qzFj3dPpNY25D8L7dL11vnXB+09zD1Idm7TyKoGhu5+qGAb
	3GuVONyIxSzNdqH/ua4iF6HQKAeSl+wh/uL0ofu3yNlvYSj/HjpDRgrMv18oZvaq9ATec+5hVuA
	Q4ON0EdauR5Qb00YMChfMHPP2KXaAFlCncgCAuKrMvg1Tf+Le4Di8AAeELWIlhdoDQtpgB71rZs
	ibqpzOwwyymiHTPJM3Xg8wEfKC/fBWiVQ8axmFnhMjPXNB8gCx5N90uGx861mEO656BLtP
X-Received: by 2002:a17:90b:3a81:b0:36d:633a:e7e5 with SMTP id 98e67ed59e1d1-37c2bc5d64bmr9860091a91.3.1781516423443;
        Mon, 15 Jun 2026 02:40:23 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:40:21 -0700 (PDT)
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
Subject: [PATCH v2 04/11] ASoC: fsl_esai: Use guard() for spin locks
Date: Mon, 15 Jun 2026 16:38:17 +0700
Message-ID: <20260615093824.115751-5-phucduc.bui@gmail.com>
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
 sound/soc/fsl/fsl_esai.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index cde0b0c6c1ef..4a530a6c33f0 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -709,10 +709,9 @@ static void fsl_esai_hw_reset(struct work_struct *work)
 {
 	struct fsl_esai *esai_priv = container_of(work, struct fsl_esai, work);
 	bool tx = true, rx = false, enabled[2];
-	unsigned long lock_flags;
 	u32 tfcr, rfcr;
 
-	spin_lock_irqsave(&esai_priv->lock, lock_flags);
+	guard(spinlock_irqsave)(&esai_priv->lock);
 	/* Save the registers */
 	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
 	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);
@@ -750,8 +749,6 @@ static void fsl_esai_hw_reset(struct work_struct *work)
 		fsl_esai_trigger_start(esai_priv, tx);
 	if (enabled[rx])
 		fsl_esai_trigger_start(esai_priv, rx);
-
-	spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
 }
 
 static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -759,7 +756,6 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-	unsigned long lock_flags;
 
 	esai_priv->channels[tx] = substream->runtime->channels;
 
@@ -767,16 +763,14 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		spin_lock_irqsave(&esai_priv->lock, lock_flags);
-		fsl_esai_trigger_start(esai_priv, tx);
-		spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
+		scoped_guard(spinlock_irqsave, &esai_priv->lock)
+			fsl_esai_trigger_start(esai_priv, tx);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		spin_lock_irqsave(&esai_priv->lock, lock_flags);
-		fsl_esai_trigger_stop(esai_priv, tx);
-		spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
+		scoped_guard(spinlock_irqsave, &esai_priv->lock)
+			fsl_esai_trigger_stop(esai_priv, tx);
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0


