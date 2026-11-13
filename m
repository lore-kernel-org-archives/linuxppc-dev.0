Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAF606A8A9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t5jzemkC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQldP45bxz3bcf;
	Fri, 13 Nov 2026 16:08:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794546489;
	cv=none; b=MaiJJap8mL/b+7IKZ7Bw6edMKZT9xAFBXbl8qmGSxZUEtqXSdx+ULyts+cy3KW3jYasDY9pSF/yQNeaW++6cAC5YfcW7l8uFbTfDFPtxtFoQfx5OKpjS8/sbtFKurZfcmghgdTbfWelrxthqFHseMFKJCnobCR3glyJQv/rScDmsptWMvut0Gvaslp+YGjW+Do+hhB8AvZgjER1n5btLd8OO8noWApaOsGvljvUSC/eRx1OpDNF7EhjtT1IbVG8eiQGo2Tq95Ga7PKcGAJ/rtJw2XuZ7MS7T9RWWfNDVDQWmP8XuSoO6oa/KFkRHXiDRaIHDR5DXJUgAJ9vd0H9dwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794546489; c=relaxed/relaxed;
	bh=mLcphuAq8INaoOM32yO8l0pyjtB9IUjLkKU7NMxP4hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBoIvtn7bE1n9Leu9NKr5ZzdT9VNnVNNH8aDK83lg1Wx5qk8u3Q/YYfzXX1bTTnfsTYVP91uBG5gXdQVEKrRrDR2tWNBVna6wlnceG6obdGFDSsKsFHtsR0oqy3MnDI9z4IPdTN0GJJoNvtz8an5fY/MwWZd2BoXBIdY57NcIrOYJAnTYpZw1ToLi8qcPi2lrcozQtgSJb+V3ebxiPzCkT0niyN03sj58za4N57WpKR1nv0Ea20DMMZjM47MXb6S19hNp+py1e9YxNHkl3rJzmxsGA+IQ348hQCBaPVARh+Gbka1hedzzN86Z72m0QsBFQffNKNmbsaXqtlSaVab8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t5jzemkC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t5jzemkC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQldN57dhz3bcr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 16:08:08 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2e9eb579c0eso3132595ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546486; x=1795151286; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLcphuAq8INaoOM32yO8l0pyjtB9IUjLkKU7NMxP4hU=;
        b=t5jzemkC8iwBc822ySejVmeBpSvIJFwKuVkPH/miTovTb5n6yIalt4ug7J6WmwK5Dj
         XaCfQcoS0zssuDf4nHd9vhzsC+JV3aZSyoX33kj7Z7GO4NgLE42WZRwg/0F8MgwBMxEY
         QJx3VkT8yfNMLBwoe+g50unzbOeFec6Zvd50W6FZFZSL8OPcPB7uGa6KmnDvQDeldq7W
         KnWmF8bjs1mDiM/K9/dyIRUDB8YYMQTaOEGFl5jEYqoTaFzLwrnSLwtRNgeYN7GXMoaT
         h39dlFUjsTvrKDEcj5wYUo9MQK1DMtr6i6bD43idSzWwfE8t/r8vH4c3ex4km3gPc5dz
         eerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546486; x=1795151286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mLcphuAq8INaoOM32yO8l0pyjtB9IUjLkKU7NMxP4hU=;
        b=MkO0hnUNU515xB8RW/rxS8I/YabJJLcs78Gu8Ooe34x+8NzwcTayjsaf97PlVIfGOA
         iCJnuEGZRcgQxWumaMDsRTdriZqA4gwdr2RKzE+4i5vIsqJSULjBA6DS7olgIskaRg2T
         kimG8CAt1gr5tFG6YtxQVLiSXk4+5X3+CkLx/ynCZogpglW9POdoZB67oUHDxg2bquUe
         ACR7G3pNstXt2o+mPjl6kBssvw63Aq28Oo7T9pa0AxjrghmIa9v8UzyTj6tiQv+fdeOq
         +bN4NHWHmCGo2+C7t/0kIEPTZm9sMAYX1r7MtxS0ZHV/7FsmkWz7r/LyRTP1kjGKVID3
         soEA==
X-Forwarded-Encrypted: i=1; AL+hErHMyU+brMrxp3tPkRbsanqbLZt+75xy5XDKI83WMKaMZTdSr2b1W1FJV1OeYWMyEcpdHGVrANL0g2GqSWw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+ULiER6cydqU2LsGQwK6+fSlAyVg7oAzOA+zp8k8AxHsu+aeM+
	j6I9PBd3/SRXrQVJyuE2qU7B/w8sNtQmqSOu3adA9NDFe3glGCy5MKgIXEKuyQ==
X-Gm-Gg: AYBFou10tepgeMpAQqrp4BERRpsNQoqhg7FpznmiDZdmA8Y+R9fqgdB+8/NQxrlYlkZ
	5/qxyV+Qikz3Y6Neez+AJRKgq/AHfXe2BZsQB+fOHHCHn7umMQp8qpbdBtEria6LlT+UsY0J4Xg
	yXN3rAX1Fe/fF3dTrMgW3sFNHyJAvuSq3b6eIENe1rYD1ZRttOYhj3D/e0kabeZRONsm55td6Lt
	annWEwphhgd5z4fJVzZlK+zxkpQX2XyFTBuGh0MG0ePK8lTuicRItxJ8GhINUWxhSEPvXai+zo7
	9cJsQhwUBLh9KGZsickOzXuq/rgIv9jzDWlkCtnmB7nsJ8x15gDQRv730k5HGO+3IiyRL6xRiZj
	CWGUpy/37ExDyi7cFPYlK7UG6PplY3jPCqrTbz4EGbZJt9AigwmvY0LziPuc5qAgVKGF3Pbb6dt
	smyFGLrFt9Bul6i73Hlcoz+igIoaBr8dRe57ouHQ0e/nbnhXYXU35WReWjJDYUAX60pgjeaYYPS
	xUgACnrbqiXH0Yuud9rWwwYtfSQrFsIpwOMV66NGzsAbsQMHRBn8OTsx8foIkiqxhzcGlXzehvr
	dSxCKtvjwAANcurL/HtgRuj9LIqiTqGeAW/y+/xZ42GN+8OV0kRSuDMJSoZBAEIC2ke1+DKdS+u
	XgBtmfFkN5GX1iMyL0rqXlp9jr5r5ZndqreRuEWlK/aXvAQ==
X-Received: by 2002:a17:90b:498f:b0:3b1:4018:bfdd with SMTP id 98e67ed59e1d1-3b1b07e8596mr968719a91.7.1794546486377;
        Thu, 12 Nov 2026 21:08:06 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm7643420a91.16.2026.11.12.21.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:08:05 -0800 (PST)
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
Subject: [PATCH v2 2/6] ASoC: fsl_asrc: Fix handling of deferred spba clock
Date: Fri, 13 Nov 2026 12:07:23 +0700
Message-ID: <20261113050727.14053-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113050727.14053-1-phucduc.bui@gmail.com>
References: <20261113050727.14053-1-phucduc.bui@gmail.com>
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


