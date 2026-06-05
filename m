Return-Path: <linuxppc-dev+bounces-22140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB0DCD6E7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:03:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlk5qzKz3c00;
	Sat, 06 Jun 2026 08:02:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696930;
	cv=none; b=jKbeo0nIU1hc2glRT25fycy7FhrQC/zABC9XHZkWsBiwITOy21WDLWkJufC2T2jqp55mynhq8ptt0+zTiw5KTm6gtVmacMAuH2su27Z8ch9fg/XJ2hSGME+hVMd5ZXwSlnQ6qk24/37sBiNhBztZf9s+801pLQDFB3vCUB0+YzaINm+9xEi1LaavDimZy6Xtgp5YEMIsHqaSUAMHzqHdT9rQlX/sNQt4BL3xTBZ46hcERbUs5bpEy9FCDd1zAmp/PInjXG688N/1dk4y1UINa/BwLFb4CDtf6705dF8ibxcIP+ievXDz66xCBM+q2tgzRLcbcVPjdpI4TnhjTaSstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696930; c=relaxed/relaxed;
	bh=XsujHfWeeEl/d7h28VlfSKrBHdpgYMwwQ54lzvrhDbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7FqROmNHM3nugVt2uZ7nLLq9myby20iK0N6fbsEfKhY3jT4D4NObjEOQ6tewW4e6nBpf+qPF5lUAyBfPklx9IipR2ONEDe25OorhclVGWTEnAWwAJMQH19yG+8sY/zWwpMz8geac2Q1qRbxTE085fzYDnfcohhca3ibgOhNQiDL7rtjCa7gpqUzxBbrUzWBQeIeur2+a2785GcpTQPxuuXGZzvHJIW+ybJtaao7uBEuZtrnoG/TN5iMbm+2giWCdSXL+AKJEG0l69rL0xu+3qFZhZ9hQ61OxcHa2PTjgXnZX8v1gBNRY0SGYV4vjjv7DLKpBKSy60xmCeGKp5Z/YQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kPqevzQY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kPqevzQY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlk0cWsz3c2Z
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:02:10 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8423efd76c8so1631336b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696928; x=1781301728; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsujHfWeeEl/d7h28VlfSKrBHdpgYMwwQ54lzvrhDbE=;
        b=kPqevzQYCBKuZ8oWUj+N9VoEGA5k8YHGHRXHNmnpkDe5nKT51AiKgqrchQTDF1ch1D
         aZk2wKFVVnFUWOBJ5DVuQl9IgcdBlU1E2agfpH876pgdj0yhFdRv9RAk6gEKRDEShYrP
         zPFsEGERVh7sUDmonPyK2/d7/QsjVv4lVxvT0ND1jjbJ/OBH+L1v2cPtB6tvlMRQ1+Ny
         qQ3ya6D3olc7Fqj5x8dnTku7y5WeBmKGltwSe0MBXM7mboB/3Lr4t/E48BAL9JEEEZ7o
         HhL7Y2FcmSR0jvI8icqhvUeVFDVXT4Gku7sd7MXnKScd3F7t11ciDv69gZWbN/dfwzWZ
         NZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696928; x=1781301728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsujHfWeeEl/d7h28VlfSKrBHdpgYMwwQ54lzvrhDbE=;
        b=O02777ncoEriouBU2vq5umGrc89rGdA6C654asebtz8rG2dRdRMepxwmD7mCwRvSzt
         glk+FXMIcsEsYn0/ZNyOXhkJgxrPLWMFoEkjzHa/2pd1wiogPP+a9CSHRU5jKRBpeGpA
         WkAya2OL0xun+FYxF1Ham7JMI0koKhnhYfq/doWT99v1e8S3LMv6eoVo3GUhcKp+PowM
         1v8tLaM2VnnTJQarQL8OI/3NGVdzW2MUb5d4KhIyf7pJH7/QA/it6ge11QmMjO0bl9j4
         Onc0l8Z24ak+xzVV639Vgzh0UNLc0XpU5wKKJ7XkSyOKTzKC7KLSkBnE0WkAa/tVl1Lg
         XIng==
X-Forwarded-Encrypted: i=1; AFNElJ/a8BNKWpaAwTej9ptn9o7vpcJuzzHlxJUZg1lm5RCMzcY5CtA5ThzriIG/wyjfrr4knc6EgQcJgFSetGk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwD/ykrykysOTxYkZEbZYl+qy1Nxd/CckA0QyTry6+R4jdftr0W
	75mddKDLC/VhGWb/AcHMovCuC3e67nhszxN+E1w3wEc+CC/FqEM3PmyO
X-Gm-Gg: Acq92OFjP4YwQ+dOzJ5lFpuuJ6CLBPOwRMZogVfQLf0KzSdbKMQRPOGIZDZcTFYsnuL
	PIZ3pWJ6UY55UsNpCGn9gZpII9D5NKYbPf3JQPk2NMJf7Cw7S/OMu011jdGGOxBnfCePuDlSgDw
	6TQQVZ/9LVVqDnIK5BkgtHdOqSeyxxZ4tLuP5Kc3wuRQbyedRQIvvTH+vrCwxcQ3FrOtE7IsMLj
	dKgL74Za1/QmjsqJtZvvy9FPz6JBYtTB2VSCnY/crnjzebUHX5U3De3xrJfvYc7u1Hnj2StAg5B
	S954QPVuAzAyoR2HuhC2QUvExgrb1F8EQ89915y8jIuzSQ7TIFyz+l8YntNfWob2dHKy3zyPWdf
	R751dN7g7QWl8p5nK7SFY+jJBR11zoITuE6ibil0KGVs1tk8CJmsipkPTMDlahuSKh/u0EEVmg3
	NWIuCPmmP9cgYQr9HQBHsoCkCMWGlwqsDWceGUjrwOx0AfPSptZtypcOqApxxEaP9OpXpH4fowd
	Jrt4lHF2z6RmuHILipTGUM+Ml6Eflk/TqDat5xoXwU6YQ==
X-Received: by 2002:a05:6a00:a13:b0:82c:d7c9:5479 with SMTP id d2e1a72fcca58-842b0e3da19mr5756498b3a.32.1780696928113;
        Fri, 05 Jun 2026 15:02:08 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:02:07 -0700 (PDT)
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
Subject: [PATCH 09/10] dmaengine: fsldma: convert to devm_request_irq
Date: Fri,  5 Jun 2026 15:01:33 -0700
Message-ID: <20260605220134.43295-10-rosenp@gmail.com>
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

Replace request_irq/free_irq with devm_request_irq, tying IRQ
lifetimes to the parent DMA device. This removes fsldma_free_irqs()
entirely, eliminates the out_unwind error unwind label, and drops
the explicit free_irq call from fsldma_of_remove.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 50 ++++++--------------------------------------
 1 file changed, 6 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 79a268139b9f..01c9cd27e795 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1027,26 +1027,6 @@ static irqreturn_t fsldma_ctrl_irq(int irq, void *data)
 	return IRQ_RETVAL(handled);
 }
 
-static void fsldma_free_irqs(struct fsldma_device *fdev)
-{
-	struct fsldma_chan *chan;
-	int i;
-
-	if (fdev->irq) {
-		dev_dbg(fdev->dev, "free per-controller IRQ\n");
-		free_irq(fdev->irq, fdev);
-		return;
-	}
-
-	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
-		chan = fdev->chan[i];
-		if (chan && chan->irq) {
-			chan_dbg(chan, "free per-channel IRQ\n");
-			free_irq(chan->irq, chan);
-		}
-	}
-}
-
 static int fsldma_request_irqs(struct fsldma_device *fdev)
 {
 	struct fsldma_chan *chan;
@@ -1056,9 +1036,8 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 	/* if we have a per-controller IRQ, use that */
 	if (fdev->irq) {
 		dev_dbg(fdev->dev, "request per-controller IRQ\n");
-		ret = request_irq(fdev->irq, fsldma_ctrl_irq, IRQF_SHARED,
-				  "fsldma-controller", fdev);
-		return ret;
+		return devm_request_irq(fdev->dev, fdev->irq, fsldma_ctrl_irq,
+				       IRQF_SHARED, "fsldma-controller", fdev);
 	}
 
 	/* no per-controller IRQ, use the per-channel IRQs */
@@ -1069,34 +1048,19 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 
 		if (chan->irq <= 0) {
 			chan_err(chan, "interrupts property missing in device tree\n");
-			ret = -ENODEV;
-			goto out_unwind;
+			return -ENODEV;
 		}
 
 		chan_dbg(chan, "request per-channel IRQ\n");
-		ret = request_irq(chan->irq, fsldma_chan_irq, IRQF_SHARED,
-				  "fsldma-chan", chan);
+		ret = devm_request_irq(fdev->dev, chan->irq, fsldma_chan_irq,
+				       IRQF_SHARED, "fsldma-chan", chan);
 		if (ret) {
 			chan_err(chan, "unable to request per-channel IRQ\n");
-			goto out_unwind;
+			return ret;
 		}
 	}
 
 	return 0;
-
-out_unwind:
-	for (/* none */; i >= 0; i--) {
-		chan = fdev->chan[i];
-		if (!chan)
-			continue;
-
-		if (chan->irq <= 0)
-			continue;
-
-		free_irq(chan->irq, chan);
-	}
-
-	return ret;
 }
 
 /*----------------------------------------------------------------------------*/
@@ -1304,8 +1268,6 @@ static void fsldma_of_remove(struct platform_device *op)
 	fdev = platform_get_drvdata(op);
 	dma_async_device_unregister(&fdev->common);
 
-	fsldma_free_irqs(fdev);
-
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
-- 
2.54.0


