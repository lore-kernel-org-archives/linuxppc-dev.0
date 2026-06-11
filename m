Return-Path: <linuxppc-dev+bounces-22453-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC4ACD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:53:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJT6VsNz3bwF;
	Thu, 11 Jun 2026 13:53:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149993;
	cv=none; b=oPclTayF74rbVDMk1nER2Uego/+Zs5ywHSv+ZBuv6oHjO7XVSyDH1Fi7dHwxRlhFHEyQkf8MhJhcZXiKA8ZSk6GxMQaSwBEjL+X5iKxLD6xFUvFwMJLHInzhjCI7V3j7tnNcIepHUJA2vBZG5MhEaDJDxuDRluunbCz0pXI6nIZe1+s1HRgTos7nwHYj6PPIsgTjwO63ZPH2CNzweEqsifWJoDf7noEEu9NEON8htom45oxHLaDddzSRRju97QOXeOQy/Yz6KjcWonRAy8GkKvCXjQNxs227KCGlREmMa2rbxLI+IPO8xECOdU2+Qs2DzuTynj5j4EWiQdif76OprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149993; c=relaxed/relaxed;
	bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkqL9sYL71Cq0GRFrV+Jycw+kFYq+TEvOG2mndPrSdce1QFkibuBtb1nytTTxPZU+cT9bv1Si+JAuGq7EUaSpdoTd6iqOaOZtr3ziyUkbOZe2q+75GGOhqpPsdLzvfVszhinRaln4CpAROlCJ9rfrUDSoiniAG9E+NeyxnyuWyEKEu/3CmJqqzDX2y2gPWZAeOV9uWYQt2S7gNnajXTBcXE+LTYuxhyK2dASm3D3Gs6+TVgpx/BtUQ2dKggbPF5Kzl4Khuyz2rt+QSnQknP/PE2e9p5rS5sTOTT3dU6IaqQWjaNAgbCNv21G5K1IENNaNWew/W2hzMa/8yMRvgsQYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r/Z+Be9H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r/Z+Be9H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJR61zsz3btk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:11 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-36b903567fdso7677275a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149990; x=1781754790; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
        b=r/Z+Be9Hs8ASbsPvSuCUnEFutbHUVuONDlULmD7l9XpXyUh21tfGXOh+5mhmbLKYrw
         7jKOFgOgRaCiQCMKlZpwkivHNPDETAufpG0b/nB5xso6S69fmYUpetDDvWb6wrv+M7vM
         a7YPcqalrqwGI7KGqen9UDMsoNl1T1bxyHQgpsTPmwISfreqOHsLP6+61RpdfXmHQRD/
         RZjItMTpy6xp2f0PFKDNRPJPK9Y2AbdiXjshk/QPs6Q9JCcguyD8SPSP+aBQAAG/sgRZ
         VzK8bvduSAMU9eTc0mnCbJVhFIXL/RQBxaNRR/N0tz7rgRxKEknW1HDmI8ex3D6/a1OX
         VDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149990; x=1781754790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
        b=R6FTENW6u4HZSMhOZG/7PdyZIUkO7lz6AGnho7lB69DF3+u2DIeCXf40BI4eqeh5f9
         UFyNkLtrTooJ8+kdFR7NV6QA5UunoE71l+L09wy1fdIY1JhQsdmPn+8WWUVaF8pQSN1T
         QkJ2TZGwlJcHsKYt9KSprD5GCpgvDYd3bujdEXvTpU5m8mqr0+ySAyz4/GOctu9RYPzo
         u7YYlKU14LPA5Ta8VKoNCGdHnKCS2dON6US92kfw/3deNzEFcLPDwuWSK4iPofgzk7yL
         kqCzY54ZYPn2Kg8qPt+fmhk4xIxes4VKn3yp/h09FOjqG2M5e8MogOqf+ESJX2q5fmj0
         bgug==
X-Forwarded-Encrypted: i=1; AFNElJ/ozDv8vbY3qawzMe6uhKKS2iafnl1xVhU3r9yZxuhMHO2RT3K8T6uzNq4SjzHyUes8LxbDm3bGsFBls60=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywar4akRRoH/KnZ0fBYY5pe6hLFJvf/VXhH+X2QoAEHkLHqIzi3
	JWuDRBcPDVAR2ecsxBjexsNN93Io5uL4gsxXNl5p+soqKZ6wXiZBKuLx
X-Gm-Gg: Acq92OFtLp5i7KkQ9MibFJm5nYZsdG0WQ7LIATPNY+VUfgmlI9NSZFEejRCJSW8IY3Q
	fyVJ9Jif3CYx+XSavYhoSLZ9JuN0uPftb+uYwU8aVkI3zoRVduN1L3TgnUujjmuSGFvsVHuhEr/
	MeMGyXpNTkPnVnOQbFtkSbINOBddB39KEpuK/+C6uBee0YBbZ2VsTGFVTMJpkD8OtG6Cn/3S+Wy
	bbpZ8MDrmB7FXuckWZ9W/9vkpBdqL06mob4HviF7lLcXVkuzKm01domu2PIF6RE0Aeda+Py7Eu1
	lVgiOz/G4MwCIix3kcWlBeZxBWgMcpeGKsYCuV8zodPRoPdwfBdxL/iTA6FSsmjFu/GCR0YeFUM
	jrPUFV5kXiM3Qt8aEyuktezX5ACVTBiiRk8X/gtxlIjrD+naW8JjdT4jW1UQcyoQmXJczX/vDUd
	f2mOGtOVmYrip2IjDx9DWPO7myEFPIZzehG0VNRqQS3hK4gcI4D8QdJKeTekid5fTR3WyO7ZEno
	22fyvWhZLa9CiOvdnNBtGD8/fax9VD8EMdezVDci+8Rhw==
X-Received: by 2002:a17:90b:48c7:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-377a15f7523mr1221678a91.10.1781149989944;
        Wed, 10 Jun 2026 20:53:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:09 -0700 (PDT)
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
Subject: [PATCHv4 04/15] dmaengine: fsldma: provide device_release callback
Date: Wed, 10 Jun 2026 20:52:34 -0700
Message-ID: <20260611035245.13439-5-rosenp@gmail.com>
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

The DMA core requires drivers to set dma_device.device_release so that
the container structure is only freed after all references to it have
been dropped (see the comment above dma_async_device_register()).

This driver violated that contract: fdev was devm_kzalloc()'d with no
device_release callback.  If a client still held a channel reference
when the driver was unbound, dma_device_release() would eventually
run on freed memory, causing a use-after-free.

Fix by allocating fdev with kzalloc_obj(), adding
fsldma_device_release() to free it, and setting device_release.
fsldma_of_remove() now saves channel pointers and frees IRQs before
calling dma_async_device_unregister(), since fdev may be freed by
the release callback inside that call.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 1ba10d065278..43d817f6ded1 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1219,6 +1219,8 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	kfree(chan);
 }
 
+static void fsldma_device_release(struct dma_device *dma_dev);
+
 static int fsldma_of_probe(struct platform_device *op)
 {
 	struct fsldma_device *fdev;
@@ -1257,6 +1259,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->common.device_issue_pending = fsl_dma_memcpy_issue_pending;
 	fdev->common.device_config = fsl_dma_device_config;
 	fdev->common.device_terminate_all = fsl_dma_device_terminate_all;
+	fdev->common.device_release = fsldma_device_release;
 	fdev->common.dev = &op->dev;
 
 	fdev->common.src_addr_widths = FSL_DMA_BUSWIDTHS;
@@ -1316,19 +1319,33 @@ static int fsldma_of_probe(struct platform_device *op)
 	return err;
 }
 
+static void fsldma_device_release(struct dma_device *dma_dev)
+{
+	struct fsldma_device *fdev = container_of(dma_dev, struct fsldma_device,
+						  common);
+	kfree(fdev);
+}
+
 static void fsldma_of_remove(struct platform_device *op)
 {
-	struct fsldma_device *fdev;
+	struct fsldma_device *fdev = platform_get_drvdata(op);
+	struct fsldma_chan *chans[FSL_DMA_MAX_CHANS_PER_DEVICE];
 	unsigned int i;
 
-	fdev = platform_get_drvdata(op);
-	dma_async_device_unregister(&fdev->common);
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++)
+		chans[i] = fdev->chan[i];
 
 	fsldma_free_irqs(fdev);
 
+	/*
+	 * fdev may be freed by fsldma_device_release inside this call;
+	 * use saved copies of the channel pointers afterwards.
+	 */
+	dma_async_device_unregister(&fdev->common);
+
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
-		if (fdev->chan[i])
-			fsl_dma_chan_remove(fdev->chan[i]);
+		if (chans[i])
+			fsl_dma_chan_remove(chans[i]);
 	}
 	irq_dispose_mapping(fdev->irq);
 
-- 
2.54.0


