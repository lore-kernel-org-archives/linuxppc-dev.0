Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE1606A321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcnKXAZL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFmj4KpKz30VV;
	Fri, 30 Oct 2026 20:15:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793351701;
	cv=none; b=BiQlJlot98OVR3kHoOLcC4Z6QSho7cr7eJXQAS2LiWWBNSk3iC8QOnOc5GsGnIFZWHAwYY0IrNDB1VgVJIx23eLKrpss+mM6cAYlhmDEXO/XQiWCAYib7EeOc2w+ucKuI1Ghra5oVdCn3QbLvQU4v1fIurb4DR/TtbvlpglzA6/1lJ+033ffe8pMqGU26IzraXCM2h6dFZYwNyob1+OBQhtTW7AcQNOudwTHB8RsGhYVVuRZsl31Hp1CcFJS6Kqrcq25nVQhnkrC1acznyxvdHZ876sBNrksiBOZGdDU0ZomVDuBo2PIyt1KeW4VFZorn7x9WQmgEKkx8XbfScoj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793351701; c=relaxed/relaxed;
	bh=ggzT8mm/DyquJidfZW7gt7MxdM7xQZcIv/Px9dQuRS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT0fy2m25Wv84jbyq6MN3ReNWyIZpOqrsRzY1cr3l6SI+mAs5PvJlk9ympsuti7hpDCC0QEmWBY6MgKcPZCf0ZSDRujeKYRw5wOe22VW2X01FTEBWw7FW3Cjb6umfV0azK6jwKzTB8PMFSkeJL1ccLnoOCInu7yfrxAPcmphwEwi87bRHvAq1mN2bWZZk2fdwfWkH8yuYBfXGoLZOOnSyDq5Q0zhFZhUm9I9bghyNzes/MA+WZs1WMQr+C0osL1FpYMkWwXIgwhhWhSwwocsFUrlokw0mYeO35te2iRsgw8HBJRdJZ4DRnesw756/M0MrBwl28Uy+xz1dVUVja78Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcnKXAZL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcnKXAZL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGFmh5ZhXz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:15:00 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2e8fe8e343fso3166415ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351699; x=1793956499; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggzT8mm/DyquJidfZW7gt7MxdM7xQZcIv/Px9dQuRS4=;
        b=IcnKXAZL9geONpJblHyvrm9A7NTTKi+7DvCvkEmZNLsIMnq6s03RRFa+bUg6ajtTlo
         z7emQLOCmUvuE/C0SNvNImZxbKcoxOx/4QSfZjvNJvM/ciFdzsWV/ZySK5gdxrTUrjkd
         N6rVQjakYGSL4Ee3U96Wa/Xnzo2x/jIWa8YkeHMWYiinRRjXa5CeaXnbGGVwOAlSKPRI
         G9KNQURNcYeAnp1+dD0esnineqvsuCwhqy2nCtw7bcdp2zS6U0JGC5Fu9GXhbySU9fYv
         uOjqR9WBa+1yf22D8xME2F/5/MGm3deYGBu6z4bUYpLwZlZb7Zty9YGCW83lgR80vO5N
         t1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351699; x=1793956499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ggzT8mm/DyquJidfZW7gt7MxdM7xQZcIv/Px9dQuRS4=;
        b=GsWGg+okiuNdkCV/QrI8FZ7aZQyNFm2XN6bjOt8xw/JbIiBgw/rCUoDozTRRsXllS4
         a8rjNGGfLqHBQXTuH6KFvk7V3tdGNQBGzBz1E31JiiO25QK8Q7tRQa5q1vjxcy8VDrl+
         AxIUlsX9yVCmzwNezvFIgt8597Hn4PKNOGpq2YxnyCxGFHWZk7yHPPsgUmT+fc+RwhXV
         /22o/eSl40LFZzAPqowU4lnroyQVu/Q/jPsCEfDqJ9TkfdRJLtVFxuW57UKQenDdwWYl
         xSp/vg0M4fffDTF9Q3USIY3MNt8DURJQwbQJu83HcStBvHrKPebHhyjpRfqf2QJsjZ3/
         Beug==
X-Forwarded-Encrypted: i=1; AKwUvBxTHvliszmKLBYgcaLORoLd6Z1q9KI5aagztZeSbOrTp7iro0I064brhXzSx93ycuFOJBj99REEpF+sMcw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIXFon94vlyFknrV6DopWeKLZok6XMGskGTUvvD8x3hQys+OVPA
	iaBzd2WDef6dzi9FPj8z6O43rN1zbmJUT5qXDa2TxvzR2jRhTWrTQTCS
X-Gm-Gg: AYBFou3/W7eK3ZbVVkDofolhk53m+zmTN7PeSAcDtCrFVvo78lJ++Prg5NYAwiP0icC
	X3onbvPMkdRdFsACZt08UBmza65XefnhKk33mhKHVMuiBF/UdUabsbx9baEzZvJBWdYnyLEM1H1
	8Rnb6d/99tTmTfPXnF6tlAQpUrnvcBo5gv36sEu/djfSnHFiymW9Z41QeRV5x38XnFqDEGZNbUe
	aMbtsqm9sbKZjzh0nu/83CErAu1+jpH/l9uGkf3R6r2yMG0rgQhTG53KD8IdDz3hiX8Q3eHKlNd
	mu+VLNIHsbiAC3wwigZc6r8xmRwFjJay6PfKUmawiXL5dVpU+/0ZyM1F9iD+I8nYZHMxOCesofJ
	EDkFMXKrDpOaUH8Qvp/Ii9svR2uqteMxiznRoMi8Bg7FsTwxqVXMFGqBzkDNGQGeptt/I9V94G/
	rumMFTHxjI8qaqIHH/tZ3mM08hns+Aks6G1ufc+BDIj3nduybk+6+iM9C0LCAIy/+LNAMTFnwcH
	luefTdRTtNHnyaS3Ld69DzPn2bW8R/kavi3Yzgq6+Fds0E1eUb+Y2udsjhf92nz/3BrpZZTlGhg
	3yk7uVJSHS/iz/xHvLqCScet+n3dBPp2/F5L3bElRND/rK0cTwiRQhN/9yDbl97+fIgwP3DEY7g
	HUbwYePaKxQxkKkBXmMsEwFni+CsbLFcXJkoP7BCSE3Wh
X-Received: by 2002:a17:902:f545:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2eb3647be16mr17041095ad.54.1793351698836;
        Fri, 30 Oct 2026 02:14:58 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm4734685ad.6.2026.10.30.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:14:58 -0700 (PDT)
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
Subject: [PATCH 3/5] ASoC: fsl_sai: Remove redundant error messages
Date: Fri, 30 Oct 2026 16:14:02 +0700
Message-ID: <20261030091404.18757-4-phucduc.bui@gmail.com>
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

The errors are either reported directly by these functions
or already reported deeper in the call chain, so additional
dev_err() and dev_warn() calls are unnecessary.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 44a34f48a0cf..5532fab80be0 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1615,10 +1615,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	/* read dataline mask for rx and tx*/
 	ret = fsl_sai_read_dlcfg(sai);
-	if (ret < 0) {
-		dev_err(dev, "failed to read dlcfg %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -1698,9 +1696,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(dev, "Error reading SAI version: %d\n", ret);
 
-	ret = fsl_sai_reset_hw(dev);
-	if (ret < 0)
-		dev_warn(dev, "Failed to reset hardware: %d\n", ret);
+	fsl_sai_reset_hw(dev);
 
 	/* Select MCLK direction */
 	if (sai->mclk_direction_output &&
@@ -1715,10 +1711,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, fsl_sai_isr, IRQF_SHARED,
 			       np->name, sai);
-	if (ret) {
-		dev_err(dev, "failed to claim irq %u\n", irq);
+	if (ret)
 		goto err_pm_get_sync;
-	}
 
 	if (of_device_is_compatible(np, "fsl,imx952-sai") &&
 	    !of_property_read_string(np, "fsl,sai-amix-mode", &str)) {
-- 
2.43.0


