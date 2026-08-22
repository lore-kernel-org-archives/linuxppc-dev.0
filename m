Return-Path: <linuxppc-dev+bounces-26052-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332CCC5B572
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2026 12:12:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRwyp6yRzz2xWt;
	Sat, 22 Aug 2026 22:12:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787400018;
	cv=none; b=ecazl1jdhVaGUuOyyNHlJD0x4avHA2wPl/cnBWxMeraTDRQ0YTZ2aOMquBvVYnuDkJQ3i81D2/aVbs+1nzuQy1cyYc35p1TU6ger3wU2BmaW+L5jptmWelGr9zJ+CI6G/03vt0+mgSWQQAYlHExZmDOzLVF7xbirOolDDs8g5Cb66vHThLacKsxvyN9j9Dij+TX1PD1k4tamcuPT4tVHIiBtWJbMv6WP4VKlk6ENV2tYBPbmaW/pUucmRGCJG+XQ5dY/ICx0Lkp/VfYFcO+g0kTkb4VviupNI5yF6pe9QuYQOvxis2jgUxXxmzKHqAmbdg/OFCxHtkQniJer4z7MgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787400018; c=relaxed/relaxed;
	bh=KvGxsjxJ9mwyqXPBI6LRqXNLhQj/rj1NMh48pIDPvnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EOrUSPrHkfHbK7SpYkUQ0HG+E7E05aASeK2H0SIgxmPWuag/gE5Keg+59bj4S6wx7SGEPOOuNeAslGGSXrINm9y7f3ct0J29r5uwaBoPnjxKqJO9bQfflxQ0P/1Rp7mhsGeoGpEZ+2d0v2hSB09YU429L44zT8qvGpUMzbfSiG9uxUIE5XrNV80uCe0gEqNfU9j54/cNuQjZQCsR5nu5tbdBXyDntVc5hGP7A04A1Bx6ayNhcaMI4zIT50y8nyLP+OPO7dkTXJCd0IW1ePLFDQ6T7UCGI/AqSncSYFFcpeXz9Jv0ZUNpRrRs45m+1hNYLBkSgZGZfbyYTTQrp0+Dcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VC4dTVsF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=stefanghetu9@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VC4dTVsF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=stefanghetu9@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRwjD4KQRz2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 22:00:16 +1000 (AEST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-c2055f5a993so220757966b.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787400013; x=1788004813; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KvGxsjxJ9mwyqXPBI6LRqXNLhQj/rj1NMh48pIDPvnw=;
        b=VC4dTVsF17HncXBIhsAA5G1IVlaqP0pbtKd9TKp95mIuYbbt7xOhX78wQM60cTal8r
         bM5PAUZ1hJkHbRO9GfReNFXqinzpPWlSN8iLF+Se1HoKLaemvZr7SKf2sZ5C5CreIkD8
         kanXeUhFCWvQP2LQQDCC7LlTNNmqCFpphGCSiuDWOx/9uGCLgIeM5ft+yEUvkVGLnh4n
         Ktdjl2ulv6Qn6ujjF5oYm7nuSaCL/LG12y30O32nMv81Cjs3JG/Cs4XAZVnzowWd1VxA
         x+XiSsoqAVFiDqbGfN+35u0yimm0MlF6sRfXN7T8nXsNJhuOuPpKWTp2U+MJC4LIyCaW
         saIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787400013; x=1788004813;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KvGxsjxJ9mwyqXPBI6LRqXNLhQj/rj1NMh48pIDPvnw=;
        b=bPQ86zOn3deoIehB+63xSPlcCPZQ7IVfvZxBxoZmT1R1KjbaLBdl9LPl4tWFJX0sVB
         oj0NDFCSCwbrNLnU/itxIz5+GGlQB58RFiqGmL776cjTvzWI0Y3wmlnHxjy+292ctPu/
         SKFp2BiSdVDWcNzMD7aAPcSSv7A/WZMSsn0/abSxovwec/X5fp8bn/9yaP8PxCBRvY7Z
         tMC6UQYwYymyy7qIuu5HEfKmCRJcEuS1jc2CtaANyymHeQ0weQz2KTkPlsEKQ2NNSWB6
         6QHsj3pwn3CbPE2EFKGtY/gwVgyr+JNhhAy9WvQ/3MKC6ukE+EfbXnFOc8PS0Q+5Pv8I
         i5ug==
X-Forwarded-Encrypted: i=1; AHgh+RoWjcciIHnhwQUUTSd0s8HrSCpqImi89E7wa/aI78QKsMFlufpvP4SKtAJP4F4DICh0DUyEcyol19ZNVOM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lq5AqiQvTtwT5vzBW9suuySELCE+11kRKvTchYlNjXKdGaUuUU
	MMm6Lr1SyaLcmolTdceaz4Kj6NAxRw9pHLBRPBir+A1KVONDpydJMTFQ
X-Gm-Gg: AR+sD10GhzYSORDC9ZDyQ6BuvFYqIG7OXLsZbE5HLObVRFLHUGzZrFRniTr8evojspV
	K/YHQmDBzRU5OvKWrrrTaoSIrN9d/S2CQ/c4fZX3ME3+bEHJb5lalkrRb2Gu1wc1QbLURdIxD5D
	ZBboGz3KGa5O2flvVxEr3JwcPxkPFISzpxUM9UYoR1i1cnbztkWRUVYxfbjF04XG7DuGXtkcYF5
	/c48HMTQkeW6VBA2fjGxsVUIKy2FIH7RnK36YS2V0PobEpEEd9hrWW2fSpCYOTrIEgQB31HVKxX
	5zsUmZ+Q2pNihnSRgtE/ikpWgXgOHbbYrSjrqIhXzhkyFXRaFxYTlloDEfXpA6wXwBPYqkrPkCe
	/Q27pmLVoU8nRW7GZzZCdCuXFy2jZWkWXzJ1HZ0BZRWKK82BBI3jhAsODltNFYL/sf5d2/odfPk
	8q587v7OxqpQnzT2te6+ChUpW+92zkpqrvf1sj5RwEd6Njz8ASw4KyKUVFUfeZ+AcEO0yilnW8u
	UcoWHkE5lXu5HGC5WADka/MFIVlivwVTD1+crLhzQwzF1/p+SkC4XwTC/tu3D/y5O+9QSY/H3Eu
	yWyknV1JloyA5o9wlK4ATy4DpeSqOciG9WIUzZ0P648Rhtwi9Z/dlbSiOUv87xANnExM5Grlzky
	nQsLBMvriV/wt1Vqo
X-Received: by 2002:a17:906:2481:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c246b4c5e33mr1111437566b.24.1787400012648;
        Sat, 22 Aug 2026 05:00:12 -0700 (PDT)
Received: from workstation ([85.186.165.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296cafsm298776866b.14.2026.08.22.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 05:00:12 -0700 (PDT)
From: =?UTF-8?q?=C8=98tefan=20Ghe=C8=9Bu?= <stefanghetu9@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C8=98tefan=20Ghe=C8=9Bu?= <stefanghetu9@gmail.com>
Subject: [PATCH] ASoC: fsl_micfil: balance mclk enable/disable
Date: Sat, 22 Aug 2026 14:59:59 +0300
Message-ID: <20260822115959.74496-1-stefanghetu9@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hw_params() enables mclk unconditionally and hw_free() disables it
unconditionally, but the PCM core does not guarantee 1:1 pairing:
hw_free() can run without hw_params(), and hw_params() can be called
multiple times from the SETUP state. This triggers an "already
disabled" WARN() in the first case and leaks an enable reference in
the second, leaving the clock ungateable.

Guard both sides with the existing mclk_flag, as fsl_sai.c does with
mclk_streams.

Fixes: b47024dc624b ("ASoC: fsl_micfil: Add mclk enable flag")

Signed-off-by: Ștefan Ghețu <stefanghetu9@gmail.com>
---
 sound/soc/fsl/fsl_micfil.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 60ac8eabab9da..5d8f0f76ab46f 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -953,12 +953,17 @@ static int fsl_micfil_reparent_rootclk(struct fsl_micfil *micfil, unsigned int s
 	/* Get root clock */
 	clk = micfil->mclk;
 
-	/* Disable clock first, for it was enabled by pm_runtime */
+	/* Reparent root clock to the PLL matching this sample rate */
 	fsl_asoc_reparent_pll_clocks(dev, clk, micfil->pll8k_clk,
 				     micfil->pll11k_clk, ratio);
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
+
+	/* Enable only once; hw_params can be called multiple times */
+	if (!micfil->mclk_flag) {
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+		micfil->mclk_flag = true;
+	}
 
 	return 0;
 }
@@ -991,8 +996,6 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	micfil->mclk_flag = true;
-
 	/* floor(K * CLKDIV) */
 	switch (micfil->quality) {
 	case QUALITY_HIGH:
@@ -1068,8 +1071,10 @@ static int fsl_micfil_hw_free(struct snd_pcm_substream *substream,
 {
 	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
 
-	clk_disable_unprepare(micfil->mclk);
-	micfil->mclk_flag = false;
+	if (micfil->mclk_flag) {
+		clk_disable_unprepare(micfil->mclk);
+		micfil->mclk_flag = false;
+	}
 
 	return 0;
 }
-- 
2.53.0


