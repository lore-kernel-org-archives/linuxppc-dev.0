Return-Path: <linuxppc-dev+bounces-22139-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E39CD6E7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:02:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlj2N1sz3c1D;
	Sat, 06 Jun 2026 08:02:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696929;
	cv=none; b=Adc2yECrcKrvCcvF1m6zdLE+0MCfWZXt25LLqs3+rnMEkklecX9i7OQ4I13nMrJvwvCSc2/ejMZs5K6wItTfqXTeYi+Vvs/vpBrSqySYQTURxzUbHH77f57NBCMcA2VDjCXfuy1KMMKOK4G3SVPboUF9JAKPFmDWlYFYg1IPiZpWo1/N7XjQTPqu4TYDHPWgT+gkv7Kj7LCNo4toAYQviWceMZohfH1sZ5NUMauLivKmoZ90HOBBArvp6KzVacTWUUC+LqoAJEy1Tg49vrA5h/xAwCCy26302nrVTRF9WUm9RNA0rBEU81q0PHeBbvEqT+1ZmMDeq4mFEV2ys3Jgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696929; c=relaxed/relaxed;
	bh=KDWu5/hG//ENwpueDa3x2k+unyGwqq6tLB7KN2pYPhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqVl23PeQxSCWU3xjzA/i9EqEqQRUQ5X8Vd9sBNrJz35tLKqu2c+Z3kr26SE42f92Xphbw7dPYoZCxYbeC226JHuBsyhinJkWZPOOrxZt9snp9bRv3AMUAtJxiFWfcGR4dYfldLgdR/DPK1+xMnkmIwP9LA78HQPFiEJ4UxYt0cPD9FzXjawGUqGIp/uKMQS4cTWMHg3/fXiobyCKiWHJTE5hGaB6X2Kcj1Y/Hlz0gLEUUpmMBrYLIAmoS4V0OXGnl2xacTBzt5YgOv5myD1nMMuRLkOIiM3xRsB8CB742Z7xHgKeY5k0KnJ7dsWR8urbsZiVHe+y3M14HHg19b+Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iVTjVErA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iVTjVErA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlh51XTz3c00
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:02:08 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-84236f9b638so1129421b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696927; x=1781301727; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDWu5/hG//ENwpueDa3x2k+unyGwqq6tLB7KN2pYPhY=;
        b=iVTjVErA4jTJI81pD8D0trNATGx3Aiq5WIYvGqaPGk88q8+0WTfg+/VUu/1HdUtt8Q
         pKDN4K5/zDv2K2Ugyc5ybNODCmphrxlLSlaN83H+ZzxIMltjgigovrLKJwYXy9L3EuH1
         vP3lzBVc/7UGFp3PSAm1nm6/K5CrBd4JGpQB64nYbxcoPydFnlXpuCm6lZKmrjY1CYpD
         hFXgJEg+Pmi8sE7Ni8Tu1jAv0NZsQ11Hw4a/2gkAv2g8kFSn6LuXbQjZ7qbVvdia1Ajl
         vK8a28fayb+XicAHoGb12d9+hR32DK/bY4PYEoNsG3JcSEnGlIGr8u9sRnDQiB9Eo2sB
         Vh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696927; x=1781301727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KDWu5/hG//ENwpueDa3x2k+unyGwqq6tLB7KN2pYPhY=;
        b=eN4rM6+kRmYfBk+WL38a5pfQ3sCafHGNcboRBUn3i5RQzinZAiVmvWY0HGeS3DDkmr
         RdPbauFsQapFa8iKPgrjcWphfNouvGlAXxl6HYi4eJQ+JsQutk+g2Y/XZqGGHDIl0hj8
         qtkBrmgAgKaJSXhg+6lWXhUgfw+glKTB398O+HO+C7Va4P2PPpqvBc9S4FZryQ5xywDx
         mBWpQUHa/ZQQ22LzTZ00mxETrQAJg5vbhj+pVQRQznSlJVSd/+sgn5dB2giA9GCeETu4
         uyGBqcuFjrgpdSYBztf8mn6/VzDsbb4wpCf0rH8BVRefmvAhZQjZk91r9/Lsni0B+iqP
         q9zw==
X-Forwarded-Encrypted: i=1; AFNElJ+JCt8HwuHbQn5hT9txzX1G2fg7BfqNVW/iyUHsFVM9F4Ht+PAH9UyxfxoI6O1hRx91uo0Q43c+GciHmYY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjJYJrGYANCdMg3XsIiAqP1iA4gqqx9Kz4sXhd47EXS8QDJi99
	dIfXn7vLoo5OtBNx6wg7y8CVwj1GFopK/Md5WyHvC+ikt+1Hk8faVwwg
X-Gm-Gg: Acq92OFnTXdFz3a/JIo+MK4BS9Vp3fn7lA9P35+Rm9QjH0Wre0Qyfwh3ajPMMPWMgI0
	ee98GSJHCUvS5gcstGSX9aAvzfAR1vqzpd7eOWAXQJekj8HRPn1IMtVRfsVXf2LtfgLRAMFGekI
	F5DYUFapl07w+g8LgFku9Vn+GD3BMtCiRajkyALHN0HLcPuUeLBqWyjqpS/UosQKYDODED2q/kW
	hHOw3ptz5QtB+lnKQ/Iblyc7XGYEvf4tYaz/8Ixmh0W9RXSsn2v8Nn4I6/IatmDQycJ9hRcwDNB
	ohmvgdNzPC00MSNfgDzMbhrkUMn/VYm6sHpIJJ7kbHxXmdV7zZRgR5A4+O4ZY2DB+84DzqWQA3D
	7mw71NmepU5+tA7XMrem5RgZyHKX++R4nVEa7NhTAoHDSWb7B4vRvlyD05t9hReakG7oqIqfguT
	u74OAVXqQIkLaqUncQTbw9QBqiE9CTnHijlB5ijoKNa/FG3Un9U7EWI1ctCqlI+3aBuapna3RAZ
	IqThYnNx3CifzJSwhMEM3GSKT0yH3j5vIkrfQgL5I7rVA==
X-Received: by 2002:a05:6a00:bc81:b0:842:2ae0:968d with SMTP id d2e1a72fcca58-842b0f6f508mr5278874b3a.32.1780696926573;
        Fri, 05 Jun 2026 15:02:06 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:02:05 -0700 (PDT)
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
Subject: [PATCH 08/10] dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
Date: Fri,  5 Jun 2026 15:01:32 -0700
Message-ID: <20260605220134.43295-9-rosenp@gmail.com>
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

Use of_irq_get which returns a negative error code on failure
instead of silently returning 0. Update the IRQ validation checks
in fsldma_request_irqs from !chan->irq to chan->irq <= 0 to handle
both 0 and negative error returns correctly.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0d73ce3dbfe6..79a268139b9f 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1067,7 +1067,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 		if (!chan)
 			continue;
 
-		if (!chan->irq) {
+		if (chan->irq <= 0) {
 			chan_err(chan, "interrupts property missing in device tree\n");
 			ret = -ENODEV;
 			goto out_unwind;
@@ -1090,7 +1090,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 		if (!chan)
 			continue;
 
-		if (!chan->irq)
+		if (chan->irq <= 0)
 			continue;
 
 		free_irq(chan->irq, chan);
@@ -1180,7 +1180,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	dma_cookie_init(&chan->common);
 
 	/* find the IRQ line, if it exists in the device tree */
-	chan->irq = irq_of_parse_and_map(node, 0);
+	chan->irq = of_irq_get(node, 0);
 
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&chan->common.device_node, &fdev->common.channels);
-- 
2.54.0


