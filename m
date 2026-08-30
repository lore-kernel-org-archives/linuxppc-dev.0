Return-Path: <linuxppc-dev+bounces-26202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89822C61DD9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:51:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY46G1Jnlz2xwN;
	Mon, 31 Aug 2026 06:51:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788123078;
	cv=none; b=miZpNLdEzHRWNTpTwHBFcaRj4+U8b8Bf90WADF3kC2NXZ5sNLxn3WAAjN/kPUckPbJvkboiWVN4Ea7Mtt5JHnHb/BTu6DG+n2SstVrasmX9LO/xIEdhZH0D9v/C8V3OY2MJ5VkAG1IewU13dosymFKSaWd4nXFbNOQsYaKho/0+RcZNzLlC7cPLHR1BDQIc4WvVf2BPIIUmJuael/8xAATRPJDpm91N/KTA06ysFOEdI8gyf7nY5ykTkx2TTtW59NhoLv5KZ/TErCScmY8YVb93ZPJQtbzDVoABQo8BzMGxfD6LXpn/Po0JPXucSAMAwE5jhwpb08g5mHDMSOjcuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788123078; c=relaxed/relaxed;
	bh=LoZfYCgqZbEQ0teo+NtTssPLrP4Kgxaj7h/3WUn4gBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhI9nUbOrJHrb7Hzkzcmek+wkYNDooMK7Yvbb9s9eYpA4TgJRZBfCjVq1A3efar82oSvbk2/l7shYP5r2bvQuLxH6DDIfVexLQ49wMRD9EwZK2wsSkqA69M1cxjN4MoanC0nQHc1+kcuNUn75+akPSy6wBFQ2Y6iYk9WKwvvW7T9B85rwngPMRnP7tfCojC1XHv6t2sGo31Fjn/UFY8swgTnsI3Uzyne7HATe9AeQqhYYU5kgqmjpS2uyWt78ElUUDhvo3GExUIxLPPpysyT4HDex/xoU4ikGj/v1WWGIo8jR0phSIBSf+1qz71MrcYvb/DubPuh2TN1Li8inLjxQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TthT9J1v; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=stefanghetu9@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TthT9J1v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=stefanghetu9@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY46D3fCzz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 06:51:15 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so31463325e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788123071; x=1788727871; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LoZfYCgqZbEQ0teo+NtTssPLrP4Kgxaj7h/3WUn4gBg=;
        b=TthT9J1vGME4k0J9IpFj2pKj6aw0kVYDOW+GogwfupQid1PYSW1TMFdkixMOjj8owi
         l+wSKE7ur4S0f06TPrtjdKSXCmHDdvOs3FVSBclocnQ+upk67LtlqGIZMF4mZ2sPOGr/
         OLJHFJUmW5iw3zYNodkM0nEzEX6ARnhURzpWifyugMZq/wPsQnZRwZGC4UWfMb6ssWTX
         ZsUVkwZvuZfj9I09h225zQ0ZGpF8udzVg+SgpgyXY4pCHifESTkCqyCjfy5q2CfQdCEQ
         yc4ibA05HYER4f4ZMc/vRRrHA7nhJUk6WfXAqqEhFJBfe4bKFD7fetp16olWOtaGJDhF
         YxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123071; x=1788727871;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoZfYCgqZbEQ0teo+NtTssPLrP4Kgxaj7h/3WUn4gBg=;
        b=GShUL6l5M1XVWJmn5zHlIpq0bAZoQuVVbY3m1XjpFZnaIaOl5k3GpB+2dGmfUN+zSm
         CX17gJIGcpmGaitqBLoagVU6DE1LAtxk9GHhSqly2NSExe8vmaZEwdDxW2OrjHSn6xfk
         CQ48G1iVG/2MQ3xporac2v7V/FcXlz1JIqOSBTD10tj9v7torKaGIl484MOUciT/oZWM
         NsBL43ClkczIO19EeW3Pxt5RF4HnlATGw+1GDdZNOW8elyrdH9gjNoHvCB3QX2rfvJ8H
         0JrdMFMF2gtC3hksfX8WakR+L9uMmzmNr8Wk+0i3xhn+edN4y4ZWSzCJrJZl/f6uwvvY
         x2Sw==
X-Forwarded-Encrypted: i=1; AHgh+RoHVw061RfHT7ykXJG5G12JATnKUHU7Xub2TbC9Adxv//Fxb4V9xYwO9//yvs7NP4Gj/3lgegBhth+WygU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nh4QKQjBofesT86F40gF+mZWIZLrzitRyGFasfq/UI2bNu6Tcb
	T3GQTKjMJe+x7t1Pa2PMmLASNKUML2l+qO4J2yHzQAn1d5dkd7ZjYdvM
X-Gm-Gg: AR+sD11RtAymnuoteEuvGUsCQzJcSVBJc7NLhj0kftoIQKapaZRJ8Op63WHfTjTyELa
	OqM4Aey3FGGI2hNQ92F0eufPzQIUmT+0e4VD7sBkSefhkG60xDEtlaKCnYS8V8c9YEh67KkUV62
	mbsdImxR6RhO/x54iAoMaI1QAy+dw5xaD6IMlT8hAqXyPgAfGCVCjJApnus+HwpTL+QBVs6Li/f
	kYbQ2iOpOVpOULF7FbGZbGaLDhwL1mJHmTpzBsBTxmqM1ctxHeq/HP7vV5hYjqmk/2N2tnq5zp4
	ISB/LUzY6HC8Qkd/+eaVXi445P4nLI1M9ezQDJSsD+Qpoz61YQ69mYHGiZdSf6lgGctu9ZYXgDJ
	PcpBXnEdTiKEbLRLmLNfZFbrQpZSvmYFF8cD3/Nwx36QHXy+YXkx/A4A/AZKDphXBlwK6azhYPQ
	S0GMqwQr4J//kCzbo7/c1boRuH6dWOzE8I1l6gqFJ3eawadpyt2BwSMkjeltlyZnbMnC2g2qNoI
	EpAwEpRv1EeN9apf8LJQlHfh8tqD85l9RfCyRmezrDWTDWAcuxlfpeY+/occTilIIW8umX3+7lK
	zteEt4xkCdsDn4QjPT7NwrfQq+1bWs1WxLlFcSzzcQRyzWm9a+B+iQf1tpnG577L5wZipx44I5A
	4aqGTdg==
X-Received: by 2002:a05:600c:c4ac:b0:499:a5fc:2087 with SMTP id 5b1f17b1804b1-49b91c20e36mr320052515e9.6.1788123070924;
        Sun, 30 Aug 2026 13:51:10 -0700 (PDT)
Received: from workstation ([85.186.165.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dd2517sm233634495e9.7.2026.08.30.13.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:51:10 -0700 (PDT)
From: =?UTF-8?q?=C8=98tefan=20Ghe=C8=9Bu?= <stefanghetu9@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chancel Liu <chancel.liu@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C8=98tefan=20Ghe=C8=9Bu?= <stefanghetu9@gmail.com>
Subject: [PATCH v2] ASoC: fsl_micfil: balance mclk enable/disable
Date: Sun, 30 Aug 2026 23:51:06 +0300
Message-ID: <20260830205106.11267-1-stefanghetu9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260822115959.74496-1-stefanghetu9@gmail.com>
References: <20260822115959.74496-1-stefanghetu9@gmail.com>
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


