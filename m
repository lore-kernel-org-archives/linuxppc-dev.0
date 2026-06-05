Return-Path: <linuxppc-dev+bounces-22137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EE4CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:02:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFld3nP9z3bwk;
	Sat, 06 Jun 2026 08:02:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696925;
	cv=none; b=EDywUgqDOyMQuqDG/xjNUF1vRFRTMs9d9W49ORMpsa/c3rYocLcC5f1UEDM2HRIKTEaHCucVtv5KeJMIFAXwWOW8l+eL0ymrXIua3QIUHn48Tyj8WcpaIx+dW3n8bnRupfEwE/zzfKBgFbf3HzP80czLEEGO11JlKxM1WW5PvZ33cIAHyOQS/a8dm+rANHtLzkI6r9AZjLglJ5cu63YooFnI48B4KEg/1tOoYUqciVZwOCak19utoWQWrK43t0gjphkaawZfTqmORtwYAKWTg6gD8BVYJvwo7O0PyFac19GJi4F6R/aAL68Li46AbiEgvWQhDj+7FZgoZ2aYehcHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696925; c=relaxed/relaxed;
	bh=3h60AiEE0ezQWif9mmBIRZAGzyRJ5Mypr0bfFicKOUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXzN80IEFjUwzH0eh0zR08mK7hvZT6P8/6FrL12ggNQVLF+Uo+O61hB6VSOI/dU3JIrrOHPMn9/tE+SJ9vdLABT8JTmTVljD/g2Y9IUdzUuz6phaKT0dRba2zjgDg/85bPEvkSoBwRGUvwVR/NxhtCePiiYhNSJY7+jSRop1O6mpHsQu37QSzOGaZBu1ATTqXp0UNWd2VfqRP4GP3coJweQv2rYFXYOF4WTOeMol/vdPFWnPyP+21OrxFE/G9tkFE56F5EnAH9Y51L382SmUBLZ09D2T96mMxD7mKrIzof/mz5HUeyRNjvisHs96e4Np0gtgazx/tM/KPbNq7spfgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QrG3Buop; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QrG3Buop;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlc48ntz3bw9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:02:04 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c858b5de728so1587139a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696922; x=1781301722; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h60AiEE0ezQWif9mmBIRZAGzyRJ5Mypr0bfFicKOUY=;
        b=QrG3BuopjD18Ofj6fOf4CSpDxMLgDo4BYBT9Ja+NEefJfE9VAd5mZpqgEVP026AaF6
         Lu9J8kYeO1FLpwFgEdJuUa4+zZ8V0jeH7E85EsYHuLv6nhf9BJ7rzCyF8jySMufIIgvc
         bcM6vFns7UqJ2j1hwJ/fLjwRQ+La881gsxJjY3HLCPvNYZtfylbnLuD2vsqWGysQOLNa
         v/WMcg+fuD6VsG1f9p+5d1U87VMSSWaM2fnkZ9CtMmZIf6hmwPd8bT8LUYQzt/zPN2E9
         cp4hrYl42z5JgHLoTGZobD8XkWKhVnUnGgoRIIsedLZYz2JSKkwD+wVK+Nuo9LQULte5
         6GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696922; x=1781301722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3h60AiEE0ezQWif9mmBIRZAGzyRJ5Mypr0bfFicKOUY=;
        b=sHCR6YtjSV+ZI7e5BybOkfkz2/YH3lCA07bXb1v7XemPtzFHxVsXy7ZoL6t2zBf583
         vSHC0cWprsnl7bkBU1uyST3VKNO2op8o1qJKvDFGOORxMGmM2XiehPh/2Y/5QOj+6ggm
         6Uw1nsnW5h8g7M2XUk0YvqhyUMPPQSwjK8iBWiCUUjxzSgSAOLgx4y+ika0/hJBUCQ3M
         GPe5nKQ3rn7UmM0HZ2esi1TCciPZCjCPPfbcBsetxQqzMSFefuLYP6rELLwxFX7Q7t6a
         lhY7fB/n5LflljdZioxgoALbLuab8VV6nxViX+1rJpOYZ/GuV0MxaoEm4C/IQ6ekgT8K
         gzBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8LkX/vVuhNC0daas73MIVZrzZJH58uVxExgyIRBoV1DpUlEja4au+xtA2QvpiiiHaURCMjwkdZcTtMB+0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZmsOFWI1DWwbylisGwmVqQsShtEsd3T2cbhOOIIN9CqbwgvYH
	mA6FscgWtgutmOXF8hCIuKiwS1HbnHHuC53nUZBAi4UbjFoHtGgJGTzz
X-Gm-Gg: Acq92OFTip7WiN3mLHlTwRrVRCCy+2KYgfWkSQ3C4MAVCeRB4WVY9p4dCze7dNl6PkR
	yfRC2rfKicsfSSkjxM7G6ywBon4p2oe77OV6XRJQeTEY2KwPxTRoMpPyu4Ho7pKGvAFS5RXsx5Y
	SOmXnssvkXNt1Nw1pX8u5O1h/j0bNc4KJ0nBnuM6wTg7dYMtRye7HMS4vcB/FdW3/lyDpJx0d2A
	p8fWdj6CirtgvDdp44Z2KJHyq2EKETLyL70gZLISgYdYcqbrufQQwLketHMNPksezxa9OD9XeXJ
	l9UZw9NXUR7GVFdo3YSsgge4YBq3VSDI+AwiaaLaNRcy+mDFJ3mmlYAkVE/zCaI1ylpmlGd8BRX
	IiJP6M1u0NPbllAa3LCFQzA0kt/fobqwfu/dG7r3TtIYTKgBcBXFyHhzsfHEtzzow6HRDpt5RCS
	++NAqS4akchScbGCuAcsGg3i2okX+Afosb2aptovkdQ+CtIt4uccGSlUku08xFdXWmo6w9siJux
	CbxME/eyk0Ixi3uL6qNwqD4Hz1glrCb1D7eF3ez7JT3sw==
X-Received: by 2002:a05:6a00:13a7:b0:842:48ae:1d6c with SMTP id d2e1a72fcca58-842b0f5477emr5790548b3a.24.1780696922232;
        Fri, 05 Jun 2026 15:02:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:02:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH 06/10] dmaengine: fsldma: convert channel allocation to devm_kzalloc
Date: Fri,  5 Jun 2026 15:01:30 -0700
Message-ID: <20260605220134.43295-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
References: <20260605220134.43295-1-rosenp@gmail.com>
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

Convert fsl_dma_chan_probe from kzalloc_obj to devm_kzalloc, tying
the channel lifetime to the parent DMA device. This removes the
need for kfree(chan) in both the probe error path and the remove
function.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 2a6a247761a4..ee6e595c2972 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1111,11 +1111,9 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	int err;
 
 	/* alloc channel */
-	chan = kzalloc_obj(*chan);
-	if (!chan) {
-		err = -ENOMEM;
-		goto out_return;
-	}
+	chan = devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
 
 	/* ioremap registers for use */
 	chan->regs = of_iomap(node, 0);
@@ -1197,9 +1195,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 out_iounmap_regs:
 	iounmap(chan->regs);
-out_free_chan:
-	kfree(chan);
-out_return:
 	return err;
 }
 
@@ -1208,7 +1203,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-	kfree(chan);
 }
 
 static int fsldma_of_probe(struct platform_device *op)
-- 
2.54.0


