Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QaA1gy6M
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFmb6xcLz3bNr;
	Fri, 30 Oct 2026 20:14:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793351695;
	cv=none; b=ny628qhveU0P6VsTWMHDADgwrJqhKpnSmGXQbDz4O2XzH/Q5bMsby6hsPuxK1kH3urPv/3Ztfc3JzYnF2qgXQFLzoR/X/4ONp+e4fu0g8vWN4bvboQ3fMfbhix7lHKHr4146BPSlTvDsBZCobqCFo63Z86NMX+MAP6nIXL395xloVvCks0Eqh8zV1wt+gUvwuCifqqykPMMisJpz2c68B5m9pzMC3wXgC81vcupbG98PlNGqr8c5IpYzbEUue7T8hKa73OpobYOpnYH+muL7WY6Qm+e4aczHtnoRDUgmcdCm4wcmjga1AR8RDUammi7BKr6enZo4fkaMJWgdx9ATnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793351695; c=relaxed/relaxed;
	bh=aTbOMPeQQR/WAw575MjV+whoOIimG2HfOgrdg3UiGjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYDQMTaDP+1O/aRm0bTSJqIf0LohMgdLs94XIlZcttrgTmhyjw1k+gBfo2RIkga8jturRfrOgG+sC39CyANct0Ph6gNGQKu0uy165cPjWJCTMo2YkrMRkmaG4Sy/iPI9R8W7141VIHnLjK+qeeLgk/SjNAngRWpZK7at/J/sDqrUTePpk2vuvh3pZ9Wo2sSvi/775pbAW/tPdqEihNy/zMNPz/+/4GULuefNouB0s9c+26r1eGmqb7HB2GcERYpdZBeG2Gw3W4c+duZ9e19aonlq4PKP4ptN8ZcH8nEeLgMa8L+eNesmRygwNAuoCsWNiAqfLD/b2HhefCWQN7mY4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QaA1gy6M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QaA1gy6M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGFmb2M0Hz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:14:55 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2ea94541adbso2113885ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351693; x=1793956493; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTbOMPeQQR/WAw575MjV+whoOIimG2HfOgrdg3UiGjw=;
        b=QaA1gy6MtzwdfU3d7u0vByeyWUgn7dWX1v1V9AjR5UTY5aztHm4l9npliDwq4z4SUb
         pQhlTfY9yKugA3CCjR+xaVc98aemlCL5ROAsiB4rmPAjYvUyROisnHP3RZkWBbSWi15y
         h6jM3W2TrYF3uJ2d/oM2fPdNQ1GwVmY73ANj2Cbl3fHNAXZ4JYWqGJPnKHNJCooIgfXB
         0pCOg3tcWYwBcAmgT7zY4oVBkGMpWqMFmEnmv4Wrhbp9VSgKUCfZ0cbDvzn+PJIY7sQY
         Z9Jwt7PussCJpIzf28SqSCdqKa3BLxouCehuQN7lDCk6MR0CCrbD0tXg1pWUi0QW8nrt
         UbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351693; x=1793956493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aTbOMPeQQR/WAw575MjV+whoOIimG2HfOgrdg3UiGjw=;
        b=0hjvwloIntXGO5nSOmE2tvzgkIdYQgmzpkAzHqI39ULy2ygajFdH0OBojS3R4tKp9K
         6Ug0+ZZZjqhYCPzKY+BWI/sdweGT83a91JJo6FUN1tY55d+DIQXids0L+hj4nKkQgeJx
         lPTqQKX2IhNedLoO9YVAwh/CD5oPMRc2oLebPU7kV0PFLUvB/nJwdNy5gVflTmum+O0o
         YKUY8yFBGzyM71Sl6e4XUt0nQIUvKraLGupikyin1cUnFRWnpaKOF0zNw7r6bjE0jpIq
         mxgb5wpbGveYl0u9SGXkLfKT+ysQlOh3GqLcN/XBsXF1DeMrgT0lSFduX1wx1TzeewRe
         ZnCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlFZHm4zMTO7+8mUxai9hdr5xio/Dda9ddIN8Vtrt7CNCPuNlsE8PM55dq7NO/QOB3MtZyuDMcOll4MJ8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJlFAsspQAgj/7Z7EzfyKS1RDyv3lQrh658nVYQL4CW0kwhe2O9
	0fejrcqEae7GeK44CPLdzgv6PTZWKNfKKjPCnAY8z59rzrXwwcShdNXNmVsinw==
X-Gm-Gg: AYBFou0kwGZ3+D4fpgQvSesmDHzzzpG5IXU8ELdAKWfuR9bBFbE2PgulqFx83NjNYYS
	27PlZV4n4UoFKOHUX0dNDqJlT6rxMnupHptPHASuKT5BOK0R+vP+Kvwl7a4NIADW2HCBu+AASoW
	7w+D3yk2kakodbtcgSgw5zlTRNbVvmljsXYj0GOmiL2LKSFoRCeLZfDlMSsWPFVAYkfvwn6b0a5
	qxfDkBzRlfr1PGqDnOvEWlKFgL8TQdpcdASgvMqlF+T2SdpGX9SK32YP7cf382Ezq9KltZ1YKMD
	Wov3QT7YLEtCZ2GBzmUqYPFmlkge90XtqFLWjv0Hae9lMrgvVYXG8ZzzZvgK6W6hATxGa5DRVL+
	xpmE0EZ57KlVxRzxMlfFenNaRiN0QA/xSZJIz6rlKwpY6/sJh78yNsv5yQYPouSR+5T9vV0f1V8
	2T1yY7xYYPDRSpGivXi08dm8FGOsxcqwcOFryJAE3nlBajSplVwLxUtSR8BKcylRHM+XEhG15tk
	IuJnhOl+6dbHYqu+SzwrTBnaZL1DBM7UVlfMzZRjNKAHgS5WWWOOSviRWoSiIFZyGRR7L5uWlUM
	2xh/rbAMvuL832lBKOtWx4NrEkAFj8Xywq81TDCqpB16fOlElDyWk/uaZDcekiRIDyeN1t8acEq
	pT7kYatcdJT8Xe30jfnsOqxWvBzJ40l+U8NoJE3wJBYAoYw==
X-Received: by 2002:a17:903:1ace:b0:2dd:b6e7:ac1b with SMTP id d9443c01a7336-2eb364005fcmr20273635ad.2.1793351692941;
        Fri, 30 Oct 2026 02:14:52 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm4734685ad.6.2026.10.30.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:14:52 -0700 (PDT)
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
Subject: [PATCH 2/5] ASoC: fsl_sai: Use optional clock getter for MCLKs
Date: Fri, 30 Oct 2026 16:14:01 +0700
Message-ID: <20261030091404.18757-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030091404.18757-1-phucduc.bui@gmail.com>
References: <20261030091404.18757-1-phucduc.bui@gmail.com>
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

The current code uses devm_clk_get() and sets the clock pointer
to NULL when it returns an error. However, this silently ignores
errors such as -EPROBE_DEFER, allowing the driver to continue
probing without the requested clock.

Use devm_clk_get_optional() to handle missing optional clocks
automatically, and dev_err_probe() to properly propagate other
errors, including -EPROBE_DEFER.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 042885ba415e..44a34f48a0cf 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1589,12 +1589,10 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
 		sprintf(tmp, "mclk%d", i);
-		sai->mclk_clk[i] = devm_clk_get(dev, tmp);
-		if (IS_ERR(sai->mclk_clk[i])) {
-			dev_err(dev, "failed to get mclk%d clock: %ld\n",
-					i, PTR_ERR(sai->mclk_clk[i]));
-			sai->mclk_clk[i] = NULL;
-		}
+		sai->mclk_clk[i] = devm_clk_get_optional(dev, tmp);
+		if (IS_ERR(sai->mclk_clk[i]))
+			return dev_err_probe(dev, PTR_ERR(sai->mclk_clk[i]),
+					     "failed to get mclk%d clock\n", i);
 	}
 
 	if (sai->soc_data->mclk0_is_mclk1)
-- 
2.43.0


