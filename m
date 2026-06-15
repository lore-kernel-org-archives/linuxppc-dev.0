Return-Path: <linuxppc-dev+bounces-22622-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D521CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:39:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4pF6Hvcz3btl;
	Mon, 15 Jun 2026 19:39:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516373;
	cv=none; b=aYfayXQVjwbgcHgnUrahE0gD6CQtLmr79QPr9noEaU0TbQD7EltqCWKcrjvan1YwcKziS7oKHkegBExL+/Y05FZxnWQcVhuoMA5WY7X6DY8yQdGtcE2/U6QBKDBd0BMt1SIuCSyLibduvMW28JWrjdTzc/3P/EYjLuZfOdFbJMqKOHY14wibXGmias5hg4j/D2q3/KvRvAFHfWeWZgqEY9S23LAjOyKOwuURair9LM8XamWz/dT1vwKmawPvQbWE0RqHZrojkD9a6A9LuTpGJvRZdRuLW7qF2it4g0XO5NWQElxyFaZ5+eJFX/PPOPxkwv8Go9O9+51fhupKIlJ0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516373; c=relaxed/relaxed;
	bh=IOlleqlCU9UASt9sEqw41R4UllxELkSYjKqivDR96C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJenD7hPStG7ealDHxShLhGkap+LrgC+yM0SqHy4dcsPLrmpxmGohzlgoSfbX68IVlpVai2AYftkswkXwlBVAi74IlixV+cfEUS6hlkuzJ2z9TkFjHGLaMDe9Bf6QLl8zOIV9B0/paMiDIHaK7mBouEEsi7hCwPVZGynsKpHssLbY/wfSkd1vK5xOZ0n68hgYBXIp68pdHN2rHngM8flajK/2EGOUS1zBihyLI4J0qoMaYS/o64/keHO8uflbIgmCq51zWUkjp1ovChWKJkQyeGFoDbQ8DdoBJKjCsP+GtiPGuX7+9vIaz3g0T0bfo9PPuy3XjgeMc3VcWmcGAzDKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DLcxTU50; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DLcxTU50;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4pF0jRDz3bsK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:39:32 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so1798689a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516371; x=1782121171; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOlleqlCU9UASt9sEqw41R4UllxELkSYjKqivDR96C8=;
        b=DLcxTU50PJiNOwg1SeZ0Lfmyuh0X4aAcv3fiRt/m1hruiXPvryxYmeGThwGIW2e//M
         ddJvR9dIm+fl+TQfNlEOQqFvzKzTJSzDzKwEE1vQs4DRG4043bLijV+Yt9Iu5ZeePJQn
         D9g45LhpJBgG9MpMRrsLuSJIxByybNrmmWP46fpv80AmAKOwaOwHwbLDf6ZOdNUbrskr
         UOMNlDbLnHhXk9r+GDaL4fMlF+Oenifqm/793wAJJx89gyIMN8BzIPYD4SrLXAhvOsCO
         aCkKaMyuM6nZqLszm2hzRoD1H+uSKyMEIca/TN7PKrPbmdlPrKisV3JXZY1bsghVtuwj
         9G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516371; x=1782121171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOlleqlCU9UASt9sEqw41R4UllxELkSYjKqivDR96C8=;
        b=pbCpG5kewXSoWlyEFh6DrZKWnZwlr5Yg+FmTNsJDDWrgTa3RZ76FTxTVZO6coN3hmX
         fFX1bgxCIcI1wZxzdn8G2jyLEqLml2/T5e2OGmFwRVox70GfwHoKWrSiTCtedJ9wdSnI
         rCulGlIZmOjRSHyf2hWFSJJ2ugH+46vTsIxX+Qx5blxEsp6g4gdIJQ+OvqQCrC6vht2C
         E4JP1h/dc7qE+T9ko5C8NqL6Mck6r/taxWpcNDRG0rCUvSPezY/jxzPTWpF5TBWczXd3
         LdQeEUN0Sq7RPys7rdHp7uthCN+AnUuCxkKd6X2Auyzo7DK2nveUzNPBDiNUd6ZifjzO
         Uq7A==
X-Forwarded-Encrypted: i=1; AFNElJ8zFPm1AvR/hSKdlo6sFXXu6M41hC9f4A2ZensK+QQpPY8z+6sQGPL+Y5adQo7ghCkYNhrJOlbYIxpupxM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YycoHi4m4GA0fsbfC1VeE8XUlSgubyanyaAFENd1w1/6rd2n23j
	bVHVFCKmsiAwETriG4tBA7z7o0ODiKLKopupN1mTUnmfjz78BMu34LUZ
X-Gm-Gg: Acq92OEIwZt9dl7oR79c7kc7Uo+b+Okc9gTkLmWvcBZwiVjlFBp5JqomKdr6DRAQTAa
	KuMi1ufprxejiW17XVn4U/5ICoNEiaH7fzj81ANAzQ9p6x68OcJoNYnltTOCTOg/lC7bGa+AKjT
	UWZ3JSlDzPjTq5Gwlt+nQZXyMQKxeZeqCHsajP6QGAO3PexosaADeG+c2L4ktaLFpWvktgwqZ2m
	h6mExoChLFwwWJ8aBLq+eegXOdROOyoXyIkxHEYLQSwsCRu6q8vcGXVlBLUXkUEqYsE/O4nl1Wq
	cGEalUkm2MXiGaSxnUlx8kSgAbwU0YeUTti8PrSv8gi9yB/YlUr5/KMzf45Ln4MSe2mIL5Gn3ff
	AHCvSa5iRbE6B1wX/XfnjXUU+BseFAenoOz+GeT2IoPTH8UKuqbyaN+7hLYxjOtrgRnfWfwaM3v
	4vRrxrpT2LZbHekV+SDN+hrJ6BUzlg9jzmcOGK8eZ5cT070yiWYUmGnMXOWA==
X-Received: by 2002:a17:90b:5685:b0:36b:9798:4f6a with SMTP id 98e67ed59e1d1-37c2bc86b05mr10709031a91.10.1781516370882;
        Mon, 15 Jun 2026 02:39:30 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:39:30 -0700 (PDT)
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
Subject: [PATCH v2 01/11] ASoC: fsl_asrc: Use guard() for spin locks
Date: Mon, 15 Jun 2026 16:38:14 +0700
Message-ID: <20260615093824.115751-2-phucduc.bui@gmail.com>
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
 sound/soc/fsl/fsl_asrc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 5fda9b647c70..0b28bcfa47fe 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -222,10 +222,9 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 	enum asrc_pair_index index = ASRC_INVALID_PAIR;
 	struct fsl_asrc *asrc = pair->asrc;
 	struct device *dev = &asrc->pdev->dev;
-	unsigned long lock_flags;
 	int i, ret = 0;
 
-	spin_lock_irqsave(&asrc->lock, lock_flags);
+	guard(spinlock_irqsave)(&asrc->lock);
 
 	for (i = ASRC_PAIR_A; i < ASRC_PAIR_MAX_NUM; i++) {
 		if (asrc->pair[i] != NULL)
@@ -250,8 +249,6 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 		pair->index = index;
 	}
 
-	spin_unlock_irqrestore(&asrc->lock, lock_flags);
-
 	return ret;
 }
 
@@ -265,19 +262,16 @@ static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
 {
 	struct fsl_asrc *asrc = pair->asrc;
 	enum asrc_pair_index index = pair->index;
-	unsigned long lock_flags;
 
 	/* Make sure the pair is disabled */
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
 			   ASRCTR_ASRCEi_MASK(index), 0);
 
-	spin_lock_irqsave(&asrc->lock, lock_flags);
+	guard(spinlock_irqsave)(&asrc->lock);
 
 	asrc->channel_avail += pair->channels;
 	asrc->pair[index] = NULL;
 	pair->error = 0;
-
-	spin_unlock_irqrestore(&asrc->lock, lock_flags);
 }
 
 /**
-- 
2.43.0


