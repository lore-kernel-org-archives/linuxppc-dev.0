Return-Path: <linuxppc-dev+bounces-22561-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1418ACD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:48:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMpc4RNbz3bs2;
	Sat, 13 Jun 2026 00:48:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270826;
	cv=none; b=J4xJeIvPw95OqP2tKldUIxvAQAnlLJhvpImxlEnX/777+YD7unVLHvCwd4l2WOBLN2eyazustrQUS2nmvVjLezwSESx7P0I7SZVU2q4vDQosmxas5pswy9Y46xhM4rkK8xwlzNyI23Hf6Bx1oB/NnsfN1FPvdWKQ1NEsnt3JbF4ajS+mIP1EbDqAi80FNXKcZq+LJp41lBfeWuLUAH4O2lSI6Qq9P9dFWZrFNL77/y4eFzBycN9cefK3TTSRErhhyr7PcUt+GcEk9tUcmD9Rd0XQ73FcPw8ESZrrAddFrRYt+qSaZQsmXm82uWHdd6ZkPS3iMxON2rL2k9UBXkTGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270826; c=relaxed/relaxed;
	bh=IOlleqlCU9UASt9sEqw41R4UllxELkSYjKqivDR96C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogZy4JekPluHcVE/Y9gkPvPqIn9SJ4H+avPjBZe4TJAK1w1UxEmHeR0W3wxjGHLyb6TB+ArnPXs2GqqkCbGckJoRnXvoEms/xpGyo4MUjODMiNtHNs+XKeL8brK8O5wxRJqZD19urYn26w3PHbAEUTNBloNnbPGwg6ygEy83fLhTwDvY6KwRoDO/RQ7GGQ62uuRRGqEY4iB9lmL0jqW4snw95P8zEa7dpPCyOexpUEzqYbAbM7LZ3iDj/uqsY78ken37Dr94xKlKiWjQGacCxuzZ8YL120HqeKqRRte+UKZwzT+GWCHht0ZpwgZ0A5j6c9GmPIHeDHuDIxNWdKM40w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hxmaKFee; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hxmaKFee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL096Strz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:05 +1000 (AEST)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-30749947917so2923260eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270824; x=1781875624; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOlleqlCU9UASt9sEqw41R4UllxELkSYjKqivDR96C8=;
        b=hxmaKFeesBsyODH280Anze6+fBNVj9oAxuo9/MWEU4l3hSFVMTu62HBqgXb7u9vLBp
         D00p762zb+g861IoAdEdQgBAv7Fb8Qaa+G2JyKJbZGBDICLvbCW4ltV6hsUY6AUwoR2+
         7cZDpbfe7Ac5iuBoexO/RbO04u1jOS0qFJzq2uGw/rHP2NF15u9WEptmdCljcfXWNTfz
         +wHiSLJLyWIGz1FjnGpntwmYHw+EAfJ8y5goxBLdlhhbKuaxgEGLEAb2tmoNQdZWlPIJ
         +rRHWbMJMzfitnEU65F/49+sUMwURXE++QYqVPWm38+++cDvQ/U7PElkioL2x4z1HWYx
         XTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270824; x=1781875624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOlleqlCU9UASt9sEqw41R4UllxELkSYjKqivDR96C8=;
        b=UkxlY3AxCni8k5/omXxCpa+LMu02UK6+sBHnJcPSdTH1v3JnYMm/6PM0snHUljugs8
         KZ3RESGpz3SxKWFMHqmluhCVM4p0TwLgJjjL6Y+BN6l6VHaiNpXpjjRX7rKW0eBCeqG9
         wBmCjtV4oO+taxe03Rj3XlIZsqGcwPkgeG/56DvQK2IoMsH/hdEsHX4UqJn6wwKJH63p
         GndzI6ahApQqtTOtD8qodcLjpZArIKv+OP4QlGtz0hzhzhqfE+DopB83LtG2KmZE2IgL
         j2FOycmLB80ESw+Us2II42ZvC9PCwru80VXikqr78xw19qZoIETzaQrkMukAEaggrjE1
         fjww==
X-Forwarded-Encrypted: i=1; AFNElJ/9WgpyEC+f29PnHqFY4dOPD4y52c3H5VjZdl2j6ojFtLoWfCyImIirZCQWr04zwYsBxF5iTIv+1xl/0Z8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzhB+YhWcq6YbG2sKjxupYPlC4gXUn4IGZH+pNTOfDjimtVchY/
	aI42lD2Rh8D4hhjqyscl+I3t6n8vQLl9K/XeoIBzA4Kps7dt5pEVVJRF
X-Gm-Gg: Acq92OHHjMRX67FrwdewmXjC0jqmPdQKKGA/dAPS7KC2K9+482y/15JNk8A65ctzQ17
	7VOF8fFi1zzXhqnIEPMfnbsZL0znSWiKiKADbJLCZfZ2tnTiBifdGPb1oAkurzAq8OWGAXCgakT
	c+5Owmt7MPbsGUulEU3bqwho1kDQ/VhPNdNFXW8q9ivTkW16v33PimjzApTgpwuXyHS573MpG6j
	JQ87bXvcc9PpkzNrPq3FFUB1P+lGj7acPCD/TbABTRRMRWCGRApO8COeTwhjr/32UKkd8FoAmtA
	ofTT1ImcU65gTC8LcrR0YTNjq5jXNUUcoCxTdelTeZHSB72bhD8Tso0UZGkaC3R4PyrUU1z01Du
	DXqQbbpFvBAk2M9drOr8eSD4l0aBo/xe8NvpWRJIM+UtaVoxiK1AW/LqFuTHj0C7q4wz0YN4+2d
	qhbRhG4y243UMCZR3IXqVp4fOlPvhH7/1PRGwUVV13tkQq+icD0J2p+Qdung==
X-Received: by 2002:a05:7300:3c1e:b0:307:91f5:9377 with SMTP id 5a478bee46e88-3081ff945bcmr1832507eec.9.1781270823971;
        Fri, 12 Jun 2026 06:27:03 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:03 -0700 (PDT)
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
Subject: [PATCH 01/11] ASoC: fsl_asrc: Use guard() for spin locks
Date: Fri, 12 Jun 2026 20:26:29 +0700
Message-ID: <20260612132639.78086-2-phucduc.bui@gmail.com>
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


