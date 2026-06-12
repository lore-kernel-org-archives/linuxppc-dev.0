Return-Path: <linuxppc-dev+bounces-22564-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E716BCD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:49:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMqC4pzlz3bsL;
	Sat, 13 Jun 2026 00:49:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270842;
	cv=none; b=KMS1hhHR+LZefu/WUPXQE/TC/TbOPHvvyitaR3uzPhSZDCrJtoxkHc+SgS7uaad2XHPm0Qgm8jGDEzb0gXEUX6dRsfsRzNtEvctBkj8xv82mElO5kw8UqTUBQHDvV+M5xTZugZMbw5WsDv4v1yeMMV1xHw1TKW6uGVaf/eB1DupGijt4ZQhkRlc4w2aR57ch04gNK4ZTQuN/Cvi3Xy/4viuC69RhdldFi7gqY3SyoEI9IMpGAaAJBaw4XDwLrewL2TyYsFiNI/piAD6QOh9HPDfx7h5w/veoT5u+zcb337CG+bJ/BlQkdMlmrKr27FLC6Xp1sukWarpUMCkMxodeog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270842; c=relaxed/relaxed;
	bh=PmZ2sl38PCCS0bv5D9o7S4WvjIIRHmjBHALA0zfK1Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dd4C1VzL5WRBAD1Fe3U829I4xt25DYT9OkNkPUdzxXmHisJ9GTVh1k4koycdboqkKC8yMcGgJFBrkSBxRxsh0uboR0zZMpfA/8mtdhImH/2ormCqnw1NMPPYkb8nt/8N+itbnpOQZzUGERvCrHIZvTyIifkyzP2Ht00ZQddP5OJSY+iFrh8fE8XSnFz7jfbC9xkYn9EYRzmw/FzMu+lJ64Ggsks6jEW6nlc8SD1LTP8b0E84TBUcE0lK0ClCUNNtzOKbZ2AGaG8fIyrXris5fex6VeCBdJ31MUaGmGBqx4uUFTCSl4HN9nuBxdSRg/B/nBzYm0FrDRzgs8Nd/+0fDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jN0ab9JN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jN0ab9JN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com [IPv6:2607:f8b0:4864:20::1234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL0V1mjkz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:22 +1000 (AEST)
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-13809223fd4so1009676c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270840; x=1781875640; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmZ2sl38PCCS0bv5D9o7S4WvjIIRHmjBHALA0zfK1Ow=;
        b=jN0ab9JN0BP+bahRineLqUbY2vXyEC7RZe7NK2FWirQ2oZTI8r2HCV0En59gFWFR4w
         tAONp5KLtj5NcQBpEDhVtwCOJyh+dWiKH9lLu2Y42sSskHhPQvtKLyo5Sx419CnSVz7j
         lNpvhBafsAHD9VjlRDIDX1hp/QA3FOzmoRQJvRGVvkAO58io4h2Sba9S9hS1LQvRPAd8
         lT+fi31iDCpJHUTy6ItbMjWtTozkcpC4bNe6uxRCdgetTo9/mRgfnIXOtzq1Zh/g7cIa
         7w0CuzfBseTdd5eIj6930c52mXaq8QCFX7tIbM/G8To1g4B6fK6GC4l7XaUjJGhJKs2Y
         faFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270840; x=1781875640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PmZ2sl38PCCS0bv5D9o7S4WvjIIRHmjBHALA0zfK1Ow=;
        b=Vd5EMYqHUsyX+aML8cP5z7V0A/dJTfbcaptJQgCXwRMWw9BxT5lbnmJpzT2b98QGfD
         Vu+LyKYB7+LKFJ1TzXXPjvYwRuToArHyPmRib3Ve6JTWfSsSJfI7VvTL9Xya2dZO9vAN
         xp9P2vfgBgjOEpwvmIWZJWZ64vS/OV7CC6j2N/sZKNTKY7vPOnwg8OV/r6pkdBQ7KFFU
         GZhs+bmDNsds67rnTuq3rX0yUy724+q2/jrmFgiLlQg9gXMYj6bvSXoYGa2MVuSPnyy7
         KlVf8B9MBUYLQIolFp93wkHjHSwgYUDrSx1VXqszkgFR4CouOUbvXpC4jZ/0FE8BNfNP
         uxbA==
X-Forwarded-Encrypted: i=1; AFNElJ/5R9/iEwkfQ9DZ0J/kaMiA/oNyGieQoRdRTp2AHVypn1ehFuC1BUByfQ6tsIBlfnN86ISDmJc8h4QG0U4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwYXZC3R1lwEun+04KsEDNs4S2BOAKKIwLSDIspVwHjTUCk6XX6
	vjcapw/m2T3uHPd7BnUf9Vtk7iTacCWa5P39mdQNwlaJ9/F0ry5xResB
X-Gm-Gg: Acq92OEVymnzstGAadfC0Wsw7SwAKLCrB1J3QeFLVytiaF8Nc3xBzpG+G5RjCYH39IC
	/Py7LbJGu9fQ72ZwV0s9RMi5Q1fFhr/tK8qQih50Na+F6MWG5ovbVsxnu6DxfnEXnuwiAf03Y80
	Q9MdGfRje+QHGHUP8G2u8zgm/gmWK1M/Tih32F5q6tjbU3c9loT8mnQ1BhKR8Sp+9kOz09ELNUh
	qjJE84yba0CYlrz5jlIYqi+X5ojKz1Q5xZIuxC+FEqMhewq3TvC+mXxNmxzenDgb7PuWspwqCq0
	Qv1yTZjcTwocW248bkZ8Qiw9/0XertNK11wbwtDyKhInNMWHCtb7duVzqkYFnIAcEmWpFKziuE2
	j61F7oUjuyRePyRPGh4sxT7IxU4R1DjcGup/caTwwZDwfJvSVWBsHCiSSY1fjmfdpZkNUR5ni3P
	jFv8V4tNDZJcFUWHv9kWwHKOs4HpHYEN1gODKZjPul9KwoPR/0nCyEOOwiQA==
X-Received: by 2002:a05:7300:238b:b0:2f5:3fb3:4a76 with SMTP id 5a478bee46e88-3081ff73b6fmr1678230eec.10.1781270840085;
        Fri, 12 Jun 2026 06:27:20 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:19 -0700 (PDT)
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
Subject: [PATCH 04/11] ASoC: fsl_esai: Use guard() for spin locks
Date: Fri, 12 Jun 2026 20:26:32 +0700
Message-ID: <20260612132639.78086-5-phucduc.bui@gmail.com>
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


