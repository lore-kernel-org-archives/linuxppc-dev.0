Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4232360A2605
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C6wIvN7P
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQHJH2264z2yLY;
	Thu, 12 Nov 2026 21:51:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794480703;
	cv=none; b=TX/LcuEP4hfgXoAVfLduC2LRKsvCf9vcgzzK/cSE0MQD9Q2hHQrSmY7Lgpz9T2XM27h3YyRWpnCQ+d1u6gKGeXgOYTwphTsX015kIt6Utji9duvVXyJ5etyBQjGKjkJwHH3m5VNL6DYWWNKvgZnz9DgKj/exSfaEhBt/FrTV3mEfpcv83GbB/rh+1ZBjyHtyW1NdJIarbb5pp2v+4vfPx2EyD2KLIrX7jwMmTPr0pXQrwEJnd663jCGGpTNoSBKH9dYSRt0TePepSLIjycgqRuLGX97y8ByGTZlQld59w/rzw92RYVxbV/+dy5LpQoq6nuD5D2zQSttYcoJpvNGK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794480703; c=relaxed/relaxed;
	bh=mLcphuAq8INaoOM32yO8l0pyjtB9IUjLkKU7NMxP4hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IufY97kkDCwDO+5oecUTOKLFsWlFCejfegRoxPUyik8Fz8vyxq6+S7/ZkUbQKX6TUrVHAXXTSSMyf0FVEspf/8z35wmsLUIHvmrIcSFgSZOWqxwfHS+DDueuYa9fDPvY8b1EVZEb+eFontRPhA0ee2E4KhfCciMLUsqFdeXhyTWri6a6bf9Z01NZ6HycLBXaE9R2IdAG2xRcnSP1JAz6te//jKWR+OqgMb3fRflIG1mJo2dmtV++5/bGoi4qbukKb3Mh1wG+hAEa+JLCnTYzGwANGsmShMGR77cR3gnz+7kQO+BiMt4cPwvDUlvg/TZh1NFZl0FRWKOJk+3GdkqwOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C6wIvN7P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C6wIvN7P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQHJG52Kwz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:51:42 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so8142441eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 02:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480701; x=1795085501; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLcphuAq8INaoOM32yO8l0pyjtB9IUjLkKU7NMxP4hU=;
        b=C6wIvN7PQqB3CRz4pKMzbVtTGDek2O7KJNsDjnB986PXc94bRfiFGXF3MX3rpQUZyu
         j0cbMf1KbQ8p3yUfacWTTdsGCLv110dVhCmhB1omSJHEglqpKrM9GvJEm96zHhq4y0z5
         QyGG37xzDeJKhONkW9kVwXLxIgroPUw8NVQ+WiSOrx+Ij8L2Stxcrtk/BQUVe27YO1yr
         ChmUQg64BXdDlEzCnnYVziHmLrAWZ3gBGYyQi/0DDdf0ty8D6El8z+GeRTBtRLB0iIKN
         v3GGNDQ92QHfG0566a/Z64x2fRFopHaoVXsACuVT5eqdieVTY62SAFWeTNqTuIShHomx
         xaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480701; x=1795085501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mLcphuAq8INaoOM32yO8l0pyjtB9IUjLkKU7NMxP4hU=;
        b=ay6m8tGP2hdZbRapPOYW9X18Bt+X+FZKkaS4eX4y4PoIgvEKIxKGeVJYhEiOgy1k6U
         hgN3nDyw5+e9pLJjaYTaYcOlB+6BKBaw7B9nkYWRY7/mhPCqKmCz6ASE5JkQfhw/cIRU
         JpXTeY6FPE8hauRO67q/W+mY9B053//jzn2gXK4PwyxwNpY7ADnyHEDZevgJUMWlHDHu
         PMaPhDzChGKGE2JpS4wgBAKG5jqw5AZ4cdORkkk6wymGUeTgAFBLydBVKGyMY+KB8k//
         srryY1zeiGRp2KNEaBtKFqYT2aHOpkTzmH1Rn+2uXctv2iMb5wdxV+6Jtl0JNi6ggjVI
         InMg==
X-Forwarded-Encrypted: i=1; AL+hErHk+UTWrOqWoaCrb59wtEfcYVANRUNdN09fk1RM8Z80ios3W4V1El/iaWbVT3ntMJBvunHMHHAy0uEYk7A=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/W9RkoBojIgxTzSedw9iCLr31qlvfqmx2zHFN8eTCqf6MU071i
	8mYtlLOYbHfCRKJOP/3OY1TRWkjF9AXc88hnjtj28xJH8OTxVyAP9xo3
X-Gm-Gg: AYBFou3OfWdllIP7gQYXcVolYj0lnH5f+dhYauOhv4IBz3PHdVLtJGRKSrV7dhntCsH
	VpbAR958WKedDFkJBxfkV3S1jVz+ciuLZTuf3o+OEZcHOirK1um7pRK4wbrdhbUfaHLkWwYbu22
	lnYksm0JXXvY2Ch4zc5j5xx1a/OFhffU3nXdjJ/e89PB3kGj0SeXT8LIgCHSAmh1nkvBMn2vwOz
	7PapzeVqu7L/a1ufxGNKehj58kuKbJrheddvkYuj94LYHwX1dMC6Qf/4UukfFdY8MqrsqoB9Dj5
	lM94fOTFdSajXjYqb0MP4dznBLzbkk6sETskDHp0zP1/QoWimqMkLv1e++/yCwgHLvzKsOo7/dj
	XMPg15dlYJ4Xba3YRLEO1NZt1jATJPci5fEIYfc6hIxgnOXU58KzAbIEbtPtV47Mfb683c43xLQ
	AX4SZgaUS/Iayopn+83uzEXgnVrKJ9nBlBlvD4p33sg2bFcqzmzYnQ8Af0fLJIZx6kNJbRMK8FV
	f7cxsqpSbTUBtn85RdiQP3Cl4mA2Ct8qSkDprvsImkJuraUHZ4O8C5gUrIIlq2L7Q6tOUaK12ES
	6TXfpUCh/r2ReYhCsm/a6G6rrNDhHktw1VLG0HZU8P1iR+XdxjeShCyuCR56gHZy13f+nqFPfAg
	66JXCRmVaO9TbXCs/CMPwM3HcYUeGeTEf3ZVSTCu+JEWw
X-Received: by 2002:a05:693c:69d5:b0:376:a6d7:8f60 with SMTP id 5a478bee46e88-376a6d790bdmr5227192eec.40.1794480700454;
        Thu, 12 Nov 2026 02:51:40 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm23047232eec.9.2026.11.12.02.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:51:40 -0800 (PST)
From: phucduc.bui@gmail.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/5] ASoC: fsl_asrc: Fix handling of deferred spba clock
Date: Thu, 12 Nov 2026 17:51:13 +0700
Message-ID: <20261112105116.32274-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112105116.32274-1-phucduc.bui@gmail.com>
References: <20261112105116.32274-1-phucduc.bui@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

The current device tree binding does not describe the spba clock
as optional. However, the driver currently continues probing when
devm_clk_get() returns an error.

Return -EPROBE_DEFER when the clock provider is not ready, allowing
the driver to retry probing later. Preserve the existing behavior
for other errors.

Fixes: 13b8a97a760e ("ASoC: fsl_asrc: spba clock is needed by asrc device")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 055593d5d37b..c91ffb5e0c5e 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1315,8 +1315,11 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 				     "failed to get ipg clock\n");
 
 	asrc->spba_clk = devm_clk_get(&pdev->dev, "spba");
-	if (IS_ERR(asrc->spba_clk))
+	if (IS_ERR(asrc->spba_clk)) {
+		if (PTR_ERR(asrc->spba_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_warn(&pdev->dev, "failed to get spba clock\n");
+	}
 
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
 		sprintf(tmp, "asrck_%x", i);
-- 
2.43.0


