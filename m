Return-Path: <linuxppc-dev+bounces-22460-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2BBCD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:54:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJh0VNJz3bqh;
	Thu, 11 Jun 2026 13:53:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781150004;
	cv=none; b=EhigH/Da9fJYJXMRRBf84YsXK7TAEdAz7En6keu/7YOuQRMcZWVwmoB9uyllyR4UbA7a92ymO6KhMR0rVKCXpcwXoufT0XPADHTYrP/Q9oZh8lwFUWquM6tskHgYFb4VDYyg2W7lcIj4JYLO37qn6xaEd3j5ioCTV6QxsMSCurxpI9gT6aSv57sZcqvjnMj5zt3PonMPFYriB6HraoscyyNw17V7zFdCHXZtMFJxgel3BfiBcKhkismisUplKjNx5bIMCDmhZqqDNXEpjCXWAHLoQOIekofk/4TFB5ijDQjH78R8QbI3icsOo364kViDLNN10ed2eMnGVl3IK0HLng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781150004; c=relaxed/relaxed;
	bh=fUIaRwpiq+bPDJ7oRrThyVs0svDhFW8QwchzUggrjyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO44MXNHqalasK4uTz0nn7h1GE/9GvnHdTNqeUl40Tsf4I2GohRklyOUi2Pfn4FZFaVqIe1w3M7Cli1+OT/vC7nnGeMGpgaQJ7os33WDEEJ+OQbxb0HU4AyqkiE2hc9YbkUydc3nEK/QZdnhzXCU6qkl87sYCT09LvYJDzSQHPOYiyj4Lp6oBC0EyaX99Gbk1x9RHTWc3Igpq+cDIcdQZHEwkb21725RvIkp5DExwdhlLmqdY3jipEHCHhwUFhkGNDPQ6hqQ99pmv5RPCDK5GPmSN61nfWeBJSze1vFWw1S4E5U/OOlOW4DmtpZlff8zpq53g0zkbSMTtew4hl3eHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SXwrmT7D; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SXwrmT7D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJg2NRvz3c5m
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:23 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-36b900f350fso6465695a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781150001; x=1781754801; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUIaRwpiq+bPDJ7oRrThyVs0svDhFW8QwchzUggrjyo=;
        b=SXwrmT7DcH9/gSSHh7bA1pq8lbDO5KdrOMis0S4AleCH1Hd29boZsy5UUJVgteJOX4
         UUCg5QykB8Y7dv4OdXdzqIsWd8Q7egZ9zj2JJguqQVcujy3/iAbFdw0q9llTr36ztpAu
         cyzEA/pAYHS/HXNM1v9fn82qL5EUf1+A/n1PBjVo0CPbKYFoW7XoGHZOM8/7dH+ZxBDu
         yfeLq3dPq8attFWq8Z4gvjWnZKu0oAQoUZ6blPIUOTBT7JGjbSASQNXsLVENzBpxTVCh
         Hyli8TzsaVbo9ggJd3CaH1aH0+HEMXgQZsVdaMGcF0EcCiX9OSDmOhMysQyaUBHjZRbP
         9/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150001; x=1781754801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fUIaRwpiq+bPDJ7oRrThyVs0svDhFW8QwchzUggrjyo=;
        b=dFAcyuoAuQbtUJjKzagVYSmG7vtUu7iKgfH6nJQKNkNX6OZChQmxC7SkNeL470ITbp
         imKY4uLDN17rSUV860/BH9hbX8DrPku1Rok3JncBjgD7T0rgMkxK4Y5Qv1CUUPrAPlxd
         0vRzI3nBs3mQ5mYIxWEX8S/jW/VsLrDnmGfXb0C3Y561DWAtaC60T4w/Q8JLtSyu0LYi
         /olX4OTiqn3JUd2sqMV213hIxzQ1Gs12MJnxYC5gQocRnje0/yZJyubSvkfg+0qymERp
         NkSMLQQGs+5OH8YsIRFVB3MDxPKjwB74QtE4mrZ5dFFtNBP8GqJDHsy42WpFWVuJr1y2
         oUlg==
X-Forwarded-Encrypted: i=1; AFNElJ8MIyXDjrO1hGO7PlGBzKCIiLPYa3iC9HNDQA9FcIRbs9Y3jnFmfuyo7DCarVIiSVMWcWjnES0p6EhOYfM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxylXYlGuXGVHgLmkP31LMbwSRNUCUzkis3UwhvEoDmZPeDGdLM
	F3V9RE7Wbf5sTj5GK66pA0HjMvt+N9bj5+NzlKonmvUAW3Z3l1jTCf+F
X-Gm-Gg: Acq92OH0KsLiIiGgAqq9/v0zNAah5JAiG8U1A9IOqrO+GsHWFRwES/rPAoKkpo26nNK
	3th77xOjdUtGERLxhxtA+a5E87To6lAMkjiePWM5u5pelFLa5jx6xiCxrmub8sgZ3PMpql47Lmg
	EggnDR+fywcfWeHCCnzmZLPssOQsXHpgQInOe6+2EXrgFo6FXGgts+xP2j3tItOVBze0dHOUSDQ
	aAjkEm6e5itv8xfuz/h9QBt41v0+0kjO/tFeSqYfNepvtivKMzDN4nWnP6S3+4sgAjB6FHI6pW/
	eLeSgzD7Dzi7HLNRFrobNUpnidVvR02F2s3rP//nsEpjZ25AAmYhfVx98NcRa1EmuEZuNE1Md94
	WyFkp1wcSazJUE5g0OVej0Hhr9Vmf0w7e1aAHEC0cbq85oty8GnIifiCR8a61kS7Vu0tECabiOT
	n9eIRxzNJMkUGD/5ucg88CCpp9/qlMr3YqvFGQDFozcACIvoQRuYN00rrUFVx2bZyHkiXa7LM8D
	ta8eMwPYGKTPisVv39YftOuSzYOTS/jGeFdb8bxYou4Wg==
X-Received: by 2002:a17:90b:48cd:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-377a73e273dmr1261621a91.15.1781150001523;
        Wed, 10 Jun 2026 20:53:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:20 -0700 (PDT)
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
Subject: [PATCHv4 12/15] dmaengine: fsldma: use devm_of_iomap() to simplify code
Date: Wed, 10 Jun 2026 20:52:42 -0700
Message-ID: <20260611035245.13439-13-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611035245.13439-1-rosenp@gmail.com>
References: <20260611035245.13439-1-rosenp@gmail.com>
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

Replace of_iomap() with devm_of_iomap() for per-channel register
mappings. This eliminates the iounmap calls in both the probe
error path and fsl_dma_chan_remove, and simplifies the error
handling by returning directly on failure.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0df09789187d..dc70a6bf5723 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1119,18 +1119,13 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		return -ENOMEM;
 
 	/* ioremap registers for use */
-	chan->regs = of_iomap(node, 0);
-	if (!chan->regs) {
-		dev_err(fdev->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free_chan;
-	}
+	chan->regs = devm_of_iomap(fdev->dev, node, 0, NULL);
+	if (IS_ERR(chan->regs))
+		return dev_err_probe(fdev->dev, PTR_ERR(chan->regs), "unable to ioremap registers\n");
 
 	err = of_address_to_resource(node, 0, &res);
-	if (err) {
-		dev_err(fdev->dev, "unable to find 'reg' property\n");
-		goto out_iounmap_regs;
-	}
+	if (err)
+		return dev_err_probe(fdev->dev, err, "unable to find 'reg' property\n");
 
 	chan->feature = feature;
 	if (!fdev->feature)
@@ -1146,11 +1141,8 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	chan->id = (res.start & 0xfff) < 0x300 ?
 		   ((res.start - 0x100) & 0xfff) >> 7 :
 		   ((res.start - 0x200) & 0xfff) >> 7;
-	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
-		dev_err(fdev->dev, "too many channels for device\n");
-		err = -EINVAL;
-		goto out_iounmap_regs;
-	}
+	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE)
+		return dev_err_probe(fdev->dev, -EINVAL, "too many channels for device\n");
 
 	fdev->chan[chan->id] = chan;
 	tasklet_setup(&chan->tasklet, dma_do_tasklet);
@@ -1195,10 +1187,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		 chan->irq ? chan->irq : fdev->irq);
 
 	return 0;
-
-out_iounmap_regs:
-	iounmap(chan->regs);
-	return err;
 }
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
@@ -1209,7 +1197,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
-	iounmap(chan->regs);
 }
 
 static void fsldma_device_release(struct dma_device *dma_dev);
-- 
2.54.0


