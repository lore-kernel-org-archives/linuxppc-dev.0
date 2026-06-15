Return-Path: <linuxppc-dev+bounces-22623-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC786CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:39:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4pS3MM6z3bsd;
	Mon, 15 Jun 2026 19:39:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516384;
	cv=none; b=nhbnztfh1ph0pp4Z9tbXMMtC7jrvnZWpXmlX639dHBpF1f6oPhQocroqC8TOvcRCccaqg5ml5dGAggRRsTGOCnPPu8BjfqVn9Tv2XL6tuE5P9HS1iwnrPkidRrlEoZ9XvR1B/QRFpJczK53y+9LDo7iavoiVoZR/aITjHTKuWqKjbsteQxNfq1rKDnfY1zRphUIZecucMtSYDU/4UtMMUiuPaZFoVo1e/5d1SbJAe2elA1dZoLX4MzvVCGCOcxAL69o1YGZFIUwoCMGrrktbhTy7pJM4e6yz5rFWyedadEDobX/tFJ5CSu8K77MSQKRkOxSLtPkHA9xKldoF9aD2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516384; c=relaxed/relaxed;
	bh=6XAdGAHmWyaxfC0CIkFTqcFEJz2zy9rtxVk5mFpwGBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO1vKO6f3jfAcTYRonXwBEaEIxF3Nml9QWaUb0YTsZ/aZ3EYHKXR4PwMWdX8WVq6TLUDvYz1MNJTB36Ib/HbOikKGEZyjHeiu+UGjHUlLOjkFtDMR59hRK6WJxtvrZJLFWfK7wy5a0BkAHu6YwtMM7k5MfKIpU7REPVhvcv29z7/WP7U4VWmKr7ujhh9u12SwMOgTvtO+fc3TLFsKlfkKsW+KCMusnO520aSaeXj0YmH5uv2OcG7HJclSjfObL8H18P13zbjowoKTMR72jqYty3n4CIl7Zf331pdP3Jv9Fu99uucGC/OPnnvAzRP3e8eU8p5J5jKyZQmtktu7rKMgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=INeX+gdn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=INeX+gdn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4pR4y6hz3bsj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:39:43 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so2683702a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516382; x=1782121182; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XAdGAHmWyaxfC0CIkFTqcFEJz2zy9rtxVk5mFpwGBY=;
        b=INeX+gdnYCGd2kZAvkR1ngeHDpSHAFFkb1HMd3Szukg/mN2TyahtLq7G93Xvo1defR
         O3DtRkxhPR2fO4bExURC9l/u1Rrj4NELjZAcJWfEVQ1NKVprGgpNjmX+trzMlcXYfkNQ
         ppiP4qwSn3J37HLCbJ6HjsQNVnHHb0xxuSl4miUfLEzNkMo9U5umNzGLbb2amkQuHWV8
         ZC6+RkT7Tw87OLjeAra/g1X4OJOoYYcBRxtzMUaIuooGheZvvvTPbk24f7L6OElbbbhY
         g1RRPRb3hWH+Zw03pQvhWjejEZz+2wXhU3I0bsl+S+QtdvZ+iA6Uv8ruKEYfMige6wIC
         pJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516382; x=1782121182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XAdGAHmWyaxfC0CIkFTqcFEJz2zy9rtxVk5mFpwGBY=;
        b=PyYt5mnf61s4VYDzm2xt6HLcFrdIpZEvBluzgKfoxq6K/4F44aRiOK1fUoxpgCfBmH
         ufPtSu1h/m2fe4N2lPW+92uJ/clDZugNzf1SJhozAm25x7sOJ4xruvANPDqs1WRIKQxZ
         BfjGf/GnpJK5DCMV8M4FHEMQ5xCr+bfhAwEYIPpq9BousmuIHzs2A6RWjgTektVbq8EV
         +u6LJBitwqMNVOhNLEkJieTUUrstgZFhpR9Gne5CYw8s+kmgRBHiyWjdQwt9LIVTHGXy
         8uaRHrZU9p1pcnb8Bs1kh3CR1QoA8QutZEEnN5xju/ITH4aUppw3rUFlmc/q/6vMBzQN
         k72w==
X-Forwarded-Encrypted: i=1; AFNElJ92y78vgld5HZVIaR4iK/0KPZman3OfMv0J4ZbXPCr/MzoyExVhr70nrFeCDYVKjzeNRFF6+gClNRT1rTA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyiwGFJ0d9SKlOJJd665Xww2M8WyTk9JgP1IfZWgEbyYqrS/t2p
	3xQ2kZBY+DW0iod5txn297C5relWfLMqt6Ty3xo0obP3Ha/TuJ7ud4Wz
X-Gm-Gg: Acq92OGd+BdrC149HPRruQSYRuzVWRVYHGW8AeJtWDn3TD0AXEj0n6zcxMv8GoNo8ZW
	GokC3w6c4Z+EjmqCd4YqX1h243AAD6YfYTFk3+x0OXCwopeyVJ8sGOObhUl7RekGF3kA/sUVtba
	Z4qzBV0+OV1NPJzMIb1PiLRQvOx2y6N23mpRNT2YmVImOq7Hm1NTIB2dXgKY/YXAKBAGbSQogKU
	juwOfro3gDKbB543EP3PDLPAkv/fH3LMGWadHvDYNOHzhY6BKC8LyIcDIc5K4rTCQlA6Wg9T1RG
	n0iS7kV3o9+tDzU/BFRbkhwM/sCp8/9Kwlkx2M+zRwRupsDt9GL3MbtOo/io+vZyCOedPFN9Krj
	3iV73XiHhEtan2WwCa8wNVGl9G74SyoteFrIrJUkpK/r/wPXLOG9EnST9Kb0TSUUOBXc3K72A79
	Vrb4TJHyYyQsppIZsS58HAeHbr5VVvWDIFP+cUe3ZXl7gtiffwlkRTzZ4CTg==
X-Received: by 2002:a17:90b:33ce:b0:36b:3ecd:88d2 with SMTP id 98e67ed59e1d1-37a01847928mr13640118a91.3.1781516381562;
        Mon, 15 Jun 2026 02:39:41 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:39:40 -0700 (PDT)
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
Subject: [PATCH v2 02/11] ASoC: fsl_audmix: Use guard() for spin locks
Date: Mon, 15 Jun 2026 16:38:15 +0700
Message-ID: <20260615093824.115751-3-phucduc.bui@gmail.com>
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
 sound/soc/fsl/fsl_audmix.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 40a3b7432174..066239c64037 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -280,7 +280,6 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 				  struct snd_soc_dai *dai)
 {
 	struct fsl_audmix *priv = snd_soc_dai_get_drvdata(dai);
-	unsigned long lock_flags;
 
 	/* Capture stream shall not be handled */
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
@@ -290,16 +289,14 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		spin_lock_irqsave(&priv->lock, lock_flags);
-		priv->tdms |= BIT(dai->driver->id);
-		spin_unlock_irqrestore(&priv->lock, lock_flags);
+		scoped_guard(spinlock_irqsave, &priv->lock)
+			priv->tdms |= BIT(dai->driver->id);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		spin_lock_irqsave(&priv->lock, lock_flags);
-		priv->tdms &= ~BIT(dai->driver->id);
-		spin_unlock_irqrestore(&priv->lock, lock_flags);
+		scoped_guard(spinlock_irqsave, &priv->lock)
+			priv->tdms &= ~BIT(dai->driver->id);
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0


