Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FE606A31B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGqEaF8U
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzSF6R0pz2xqh;
	Thu, 05 Nov 2026 21:43:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875421;
	cv=none; b=HIXLZNxrOyAPRlM8mbF7K9zt+tueMo49J9APDITd9osv/8EULZo0orZxn8wqMFKjRzBXiJIrZCsXY/Njdk/vY+EFllVce91HoshwsaOExW1hBZ+JoBzMKEPGTIGQfoapUNLEgNetSzCvgMFPWe/SJpPWJGBiJg9tiVQshRSY5Ly9WF2uxE2F0OuWEdGBwqclIYZYQ7QvfDMJbVjkF5MXUmO9lO5M3Q+zIeLyHfL/eu+2lfhZhNdyHqM+blYSGtOQB57daaR1Dr5Kwaqb9j7AuVS9iF2pjHhn/lV4tXmcTFH9utZCX8005+LYoDRKOg6bfuicavkHhjK5z+ezt/xY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875421; c=relaxed/relaxed;
	bh=HjeoZgaqimaxuDpHFJxW672cms57GDRelnn6QvWm0VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgmfzimYlsDGTgbNnP7eUc8yzcVhCAmN9a6MLBHEMsA6AENiIWujS67r74ov7ks+HdxLgxld0u0WT47+jEz1/Gw5s9ZcgWiw1qhuKQKchJYA01fBPFS0ZmByeQNbjsP/MHMcZ8/09ONMDGmi46e4Ch9uZQPGD//7X8TtLtOBwPvithXIutjlWhI39wUkMwB1FAlD9rdW11IGyIMXXyLWHYNqN69FGDIGzqG1xbSUMseUWrDcE2YmNmtRGg79m6ucDOFuEZsHSrWNRR+RVhadMZ24eKaoMbIuMMF9sVAXzhsMh5IAAicd+fyJ3kvqdk+aD+/mBFLUfELVDJe50WBOug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGqEaF8U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zGqEaF8U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzSF1rzGz2yD3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:43:41 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-36d6765756fso1924352eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875419; x=1794480219; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjeoZgaqimaxuDpHFJxW672cms57GDRelnn6QvWm0VA=;
        b=zGqEaF8Ujg7M1x0cyYX+LB3YrxHfaGYfjy66YQVLwzkoyh8S5N6hPfqcL8OZB1JrOK
         6mO4xqE++rJvy1/UObngNvUFWrdNkD+zqRTEUtAqPFqhKptYK3x3+U4lNrwkdGD61uxN
         T5+CgXbxG2uJB2wGApkURftBMWqqMNCxyJzRT/kPqGQstyMmluXpi3SElYyKaF1e8a9/
         sHS+DX5XmZah+pNB+AkNiG1PW1wbYEE6fwwaFWXzvlhnf1SF7BeXq9Vaf0Dj6BqcOvqA
         MWjL82153dj5TwS5hxBv/xPTq4DWvLwgnKsqbYuWlGfHmyPgXbfd3sqXTc2x/ucuTVc3
         QSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875419; x=1794480219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HjeoZgaqimaxuDpHFJxW672cms57GDRelnn6QvWm0VA=;
        b=ZfRW5HE8jfvztwiE2I2ZJLDOFsGii6GroIYGwAhJgOnFZQZAZBqB5m50ByvzaPKDuT
         oDkXyxvBR08udp1s1wsNI/rLyIu1QQa4qH+bFNZATqHZYSAxBLqgVV/zyRMdzAzAQN0Z
         ROYiYN3uS80O8CJCO4mwuvQkwLW+qI7hPfFKo5GeGoBS81VEnoHsgGov8ZRcDNrQhc0h
         lVDbSfQ5uy6vzDxgLm2ni0UDASmBMySRafGaW3IOnIC+ccHYVvJLc6/doiHmF9+uLb4v
         2KgSb1i8Jsb6TnMcRg/rk66DO9lP9cVDC/daJUPgqO/uGDoZ/kjGZVd1DP6kQrPC+5BK
         t5Lw==
X-Forwarded-Encrypted: i=1; AKwUvBzIxTJFQ8NWuhbN1HrarBwB8WjnrROYN6+iDl+epTh73X/UQGtkC4blO6+uGTpWPINI7ENhlcd0u7K6mHM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8VlNRXktYfXIiliiPL8nFTL0r+eqG/yrdpZJfDg3VGQ+oSkP9M
	EowDJjWZOOmv1z8Hvs/4r93kxF0pqBu1mZ/FssvV37i1IgGtgkHeD6zU
X-Gm-Gg: AYBFou3aaXRYuO+7dmvemZ2d+YdRFHvfVaQ63nSBujyfCyC848fAbHpthnX+l2qbKOc
	S7jJ8122/3KecCXZQHjo+2s9FCY28OrUOsihP3OyW51v9eTaw4csisUG+uX2ljvHfhJpZgoWY7J
	WOxsw9K4qnVEC/LayVWyzJswlNd/SJwmf0S3NYxJvu8tLY2H15NvDoIRmD+Wsz41JMcP1tvLvVW
	83vRKir2PNtIgdA2PeghHhymfe3dGSNQLjU0YOe1xwceQLemzBLcgmcOGUpmfjG7yL1zdX2WOrX
	HXRBaQ2b8pMN2usDzhwm9XzG56Tf6tRJ5IOnRu5ezXqtUg5U4SD2OAdRiSQlQ6yBhbldEnEn6dW
	pf0FR7FYHZRXrGsaR1WGA1tpZxNocId90qvF8+Musr78OK5vf+3xDWeriZgLYfbUjV+lGNa6Bre
	XJxcxNoVdpbSj4NuKR4Zoow9f0poPYRWlwqkv38uXH4FGpnrUQoN4SUzSPDF2QVMP2ndHMP0Njm
	TZ9Yz0eV6rZzN04mfHBP5A2s3orZ/TuyeajxtA6d5RlVYiun+KRbcQL8ANiEDLAs2rpJL9rXNgL
	aUxeFFmygMTiNzzun/7ZqLgaKRsvyLHeBHD8JCnaI9Tbgh8b4K7GNPhVBt/3Zz6gHwUSDxEgYNS
	e2gLYogn25HqWm3BM6MBxHFpcOz4jtlIKJcCHFFioS27V
X-Received: by 2002:a05:7022:3a8c:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-1ac4fa14bc6mr32640189c88.0.1793875417516;
        Thu, 05 Nov 2026 02:43:37 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:36 -0800 (PST)
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
Subject: [PATCH v2 05/10] ASoC: fsl_sai: Drop redundant dataline mask AND
Date: Thu,  5 Nov 2026 17:42:32 +0700
Message-ID: <20261105104237.38542-6-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105104237.38542-1-phucduc.bui@gmail.com>
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
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

The rx/tx masks with bits outside soc_dl are already rejected just above,
so masking them with soc_dl again is no-op. Remove it.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index cb07e7d13132..8315a0d8893b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1510,9 +1510,6 @@ static int fsl_sai_read_dlcfg(struct fsl_sai *sai)
 			return -EINVAL;
 		}
 
-		rx = rx & soc_dl;
-		tx = tx & soc_dl;
-
 		cfg[i].type = type;
 		cfg[i].pins[0] = hweight8(rx);
 		cfg[i].mask[0] = rx;
-- 
2.43.0


