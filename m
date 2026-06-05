Return-Path: <linuxppc-dev+bounces-22138-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130C5CD6E7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:02:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlh4WVPz3bwf;
	Sat, 06 Jun 2026 08:02:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696928;
	cv=none; b=EOvncIqITsSLsrFsUQwyttOaAo+kUnSpdM0kcrSyIw/iXYqzjMTHhiu5df9ZLmkPxQsiujdDs/f42+yepoK+vf7FXsKJemHmKxKWjJw29CqwnCvz7/Q7iTgjr6ChccIVRh50/WEh2dG27caqgGPNPlrlBwu9A23JUc5OIKGKkMxMmC7oftQxasVe3jWlTBD+O5c7iS/hYJbWT73BF1hncDq1cG16rdSr+78FthCbCHrLY48axOxmfJf67/P8/Q7QI7QXbl83mkVIqFDBe3HlRoZ5mH27QiqYD0ATR+ORajeN7fr5RxcAyCrMD67VfVYt6LR2ZFqJAmu6et7WBlB+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696928; c=relaxed/relaxed;
	bh=0c+DTbgBfPPUhSPBSk+riIkjYOZTEz8XaKJeP18mVBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRzcpORhfC60YPKTft9q7Y2LF9CJaXLykA3dvHynE660nihBqzjozf4QJ7QIGCMCJBbMO9UjDMf/De7czqS1c1r6uMn4ufIDPqCnV54FiwYHRQyzpUDHEpBFQBf8YU75CJyli84wQU0b6JbtBbG8nwqWDpVpVH8yklfUKNtQavJh30ekcHeAidOQe7fUwkvbtylhKKesrEQSKccQDi01QfIrduD0v3/yioMQgOJq+3CTZkZFh0uhC9mJLFiBqvzLXA/xtR+kYQMToEYMQSJj7zoAo348LzqaLAqS19vPzBBHTZi4LGf1umPWr4HmHt3svJeHhUuUThZJOjRKmArPrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SReELYm7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SReELYm7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlg1cWQz3byh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:02:07 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-8419ab3a297so1068713b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696925; x=1781301725; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c+DTbgBfPPUhSPBSk+riIkjYOZTEz8XaKJeP18mVBg=;
        b=SReELYm7uwHMBQiv6KqObl+zWcwr3ZXjQPhNKhMJXjHJFucNclakXYFDJTK5ApkFH0
         CtAN+ieOO7JmhpwYlV16/dcbEeNHyTn9z2f4FQ19bTq5MGZyPRC5wPh1KWSym9L4VIlo
         1rRJv7O+V/UsAcqPI4q4wqzPRbEhq1QJNGc1qy0gyhLWSipOAHMM/HV7NqSbm1ruA6nA
         2IkD2tFFZM1RKS1ZCHOLyMd86LefnVBRywHFrYFi8X9QbCE0jXwzxt7nB9qPFqM6vmsJ
         tPGjlm9SAFD1t0VWe7wVbIzI8JUvR35UDo1WVPHH8YSpT23I6STjnr+EO2Jr9gGVwO9M
         Kt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696925; x=1781301725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0c+DTbgBfPPUhSPBSk+riIkjYOZTEz8XaKJeP18mVBg=;
        b=KnPKWk19gxH97AmfwAiYqHUN8hhztsDFStnnIIQqFpkniJZVihvUwZBuCwaiGkost5
         cDEClIZ4pBe9h5qc8pN7jASoLVIvZJZQAAsjCvJcqcc1z/lP7x8E1rbUjfIwBBkUOoIe
         ByfdLk1tymEzaqHgWPJnsi/71iBTxUPTZhoex+jcKHPU+1FjUxJ/BRMZmzC1YfBNunQo
         R9v60GWDoTEM+VYsDr/Ktg7Wcku2zNb8DmGbN5P/dTwpB7yo8ImNFsVknfOpWz2u1MQq
         DkKK5iErIvd4IL6A74aPTBrTf6+MpF9Barzr5vsAzGC44Bf6qYrTp2zNj/EhDQ+1ttDZ
         A2QA==
X-Forwarded-Encrypted: i=1; AFNElJ+2R/6xDnwHgTi2lqFzGUSz9y03erOW2YU0igDlE7s9HscMagbzQ0ZbRG1zojEVQd7jH7XvSRE8j/SkIkY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwkCTFtIb3QHFsNAy8X+Bl7uRm7dOKHyrdH1lUdR9mZ5MZ11WKI
	30kSrbZ2puHqOIQDZYfaa3fQ0CwFh26w8idoFSIukmQA5gSrxm6wuUq2
X-Gm-Gg: Acq92OGOGU/RSkGBHdBTXoiSIh5/tPEuJSjCi+r+sS7+jzsMJLMNzTtcOuZZxlxFpXw
	M5k0S3kuS2ninOVhT+j1u2BGRu+egz4/VJiENhSrq55mzLU9EEHBLdEXEcJovl9Kg7qa/eUhsac
	vG/AouzUZh65a3nfOinS9ZBPs+SBH9DXdoL0l9quAjk7ZV700JGXbXjPcOEakdUygk1W00qi8MY
	LV3j2LDjUp/jXejE5TEXnUslHaF+rXNJgp3SnTLBuCFbhcZkMuMGAtO7X6FHLeenWCPfRK5fgsL
	VPOTWGsp42Xwvn9wvEc77c4oCZKEu+EH5mPLy9kwTtwfmf2RIb1uJCOrMII4FZkxsNVgstnZRlB
	23LXqWrIjO7jbzqr+0ahy9pRE09VzAPIvUc/ZQb16L3vIHPVWICQYgK4qni5Xr6wOfSwvWbE8nZ
	Ogtmqf0V3aYe52vC5DnVniUWlsIa4o4dC6lray8D7S9NVGPRUOzq1Du3IQDSjztWrwaykjU/AkA
	z27+RdLWDMtxmPNwnHvU4d7DJ8/ICs1Ysh4qEk8VDckpA==
X-Received: by 2002:a05:6a00:66c1:b0:842:6004:3fb9 with SMTP id d2e1a72fcca58-842b0f52ecemr4959351b3a.25.1780696925057;
        Fri, 05 Jun 2026 15:02:05 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:02:04 -0700 (PDT)
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
Subject: [PATCH 07/10] dmaengine: fsldma: convert channel ioremap to devm_of_iomap
Date: Fri,  5 Jun 2026 15:01:31 -0700
Message-ID: <20260605220134.43295-8-rosenp@gmail.com>
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

Replace of_iomap with devm_of_iomap for per-channel register
mappings. This eliminates the iounmap calls in both the probe
error path and fsl_dma_chan_remove, and simplifies the error
handling by returning directly on failure.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index ee6e595c2972..0d73ce3dbfe6 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1108,7 +1108,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 {
 	struct fsldma_chan *chan;
 	struct resource res;
-	int err;
 
 	/* alloc channel */
 	chan = devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
@@ -1116,17 +1115,16 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		return -ENOMEM;
 
 	/* ioremap registers for use */
-	chan->regs = of_iomap(node, 0);
-	if (!chan->regs) {
+	chan->regs = devm_of_iomap(fdev->dev, node, 0, NULL);
+	if (IS_ERR(chan->regs)) {
 		dev_err(fdev->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free_chan;
+		return PTR_ERR(chan->regs);
 	}
 
-	err = of_address_to_resource(node, 0, &res);
+	int err = of_address_to_resource(node, 0, &res);
 	if (err) {
 		dev_err(fdev->dev, "unable to find 'reg' property\n");
-		goto out_iounmap_regs;
+		return err;
 	}
 
 	chan->feature = feature;
@@ -1145,8 +1143,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		   ((res.start - 0x200) & 0xfff) >> 7;
 	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
 		dev_err(fdev->dev, "too many channels for device\n");
-		err = -EINVAL;
-		goto out_iounmap_regs;
+		return -EINVAL;
 	}
 
 	fdev->chan[chan->id] = chan;
@@ -1192,17 +1189,12 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		 chan->irq ? chan->irq : fdev->irq);
 
 	return 0;
-
-out_iounmap_regs:
-	iounmap(chan->regs);
-	return err;
 }
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
-	iounmap(chan->regs);
 }
 
 static int fsldma_of_probe(struct platform_device *op)
-- 
2.54.0


