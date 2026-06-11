Return-Path: <linuxppc-dev+bounces-22457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7270ACD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:54:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJb1PQsz3c2G;
	Thu, 11 Jun 2026 13:53:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149999;
	cv=none; b=metrjKgjEtjI8mC0o7ucIf6qPYdSpFyWJ/0nBHqjmSqJcvKdNo5zk3JgrEMUtRr8r3Rl890EWsprTTLjWAcRwYSNPGVI3SsdV1rY8sVAJ95Eb7pMnSpG77RZdmezkDVc7jtyjcDxHUGkpfFJ894OaPwEIg8DVMtuJUA5y2cVvH0uBCxr7FbshmY+Fgy8jCl1B7CA3gDrlQvJaAbhFzpPYTA4pxeJvLvMMd5PCni1tSgUMHN1PnSpA2GI3epyeQFYlyMAO0kgEtaYz8pTUjBdNNtVKypGQG/QbDm0rxRnGBYTlSPJiE9wwrNxEZtmWwYNl7orl41jY5g2lfYeOvSnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149999; c=relaxed/relaxed;
	bh=N3Y9CBzltffMyeyjO+tKHgWOm91RTvExE1MCtYJb7pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFGmVd53rzXQuZ3T2wIuC5r/AELoKprqLL1qU1/SxscVb/SbprK+7B9Zzw2po8RKk7XgcN3zONdQkiBreSlP8vPNHd04ing4CERrjsuiUSQcSrB+k08e9X3TLr2wwg8blfnoFPw19x2nrcZl8i1hsHNwWxZut0ueEquGX1eQXfQPlGVBzlVzPoIyzeqI5Vsw8K0ahCpCECy7axW+pf872SRmgs6WJk4CHVa5xwSghmNu1lykau8U+yPJwMYc5euzO8xyZJZWF4znROsOsL+EPhinv/Uf0CYvvhkdKkbZlZm2htd9ZlsIgqfIxBf47rEOKMLhip14UHuWPjG+zSSx3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aYgc+lIZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aYgc+lIZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJZ2tzFz3c3l
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:18 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so6314825a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149997; x=1781754797; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Y9CBzltffMyeyjO+tKHgWOm91RTvExE1MCtYJb7pE=;
        b=aYgc+lIZ7UocxOCga9aKHp5OwMnTTt11fL9G8CfXYElgtgqWn5cuVYTP3NM1rXpzKU
         i86RkcRBo51cQyFpI4jlQJhuK8NBJme4+7vgiWAU2XyBil3i5noZrD/SmKduWMFFBWiQ
         1mOrElhTA8oS/drHdZFSbdNyHUIrk8OTGBTJkwXZTB624I/l646p1HCOvKy48V0EO7zL
         r+8bdtX26ihyQbjoxsZR81aSZyrLU+BvJTWGXgRjmjQjwpSQgAC9toIDNK1heUvap8VL
         4UZc293qtdRCP+m6bj65PHDa9/cN8BKqEYGy6IQpdCFasavMZmVMh1sJ2dfhuxy7bJmJ
         OJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149997; x=1781754797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3Y9CBzltffMyeyjO+tKHgWOm91RTvExE1MCtYJb7pE=;
        b=cwoKe4GHtTtoDpPD43bOuCtRnXQdccHYGLlSZj6gUJdhuds7ZGrYE32agk3u4TISoQ
         t/o3myrJk3CjSMUCYQY71w5qICqZGT/YozvPPgEUyv/AELfFA//t7ywiF8VOcJnDMIH4
         KthT6OAj/0wBBphln4phCDsByPRU4pYBUACvmQAnmzwJU4teWyq/AlyJC/OOzI77EKdf
         YkuZ/1+fZYtqR8RJZVjrXxTBKIJkhIADiTV+r2G0lggulFZ4/1If3CtVMglx4wEjeYj+
         6zh2ElXrmeMYcfoUacV4q3ZWpE1ftCM1uTJUyZKKUZdDQl/pbGZqsNmsfeDPUu81f8TZ
         z27A==
X-Forwarded-Encrypted: i=1; AFNElJ/7BNkP3Ue2xL+jDa95xI7jyDRUnzljYF5zMGIuEN3gEOBpcsg9Ax/SJrRB2dsL5LdAl/lfzbBrK+eV7yo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz39vSvLoZXQ2pKwdrPQP131ndseX6gBTGE+rjuBolwMT6lyei3
	lZrmp5FglEXDv+ABa4U7xpfgOSQC3ajlYIw+L6ioy/4oeMhJOKGVEsFK
X-Gm-Gg: Acq92OHp8piwaXtcyclirvMdMP/XlPvAXVuHVw0V9/X+fgi4hv/vd7W3GywGZ1UZV2H
	RnSAmvwd+TdN0Up06UE3HjklHqyih/1aFNI0Ddmzs0J7UnMemqHSe7VVc3TZfYmCBIr8b7STcyx
	Cu4Auo8H4vEm+gjxPHdRDh6tdsNx5omqn/17FDIKFv55gwxi0806lXicZhWafyhIPJwlo2+cRrz
	QpX92Im924txpimMDvV/GK6wC26apOuIiNcH277UupThMm4NvKSGFYcTyo703nePLDI04wGRBaX
	4VY1bpW+74SoC6CQP9DcpES5aXAT+JAOxd3l8AO15Suv1ksEweeMfGBdxdw7L7+tv7AcLdnDCN/
	voeP0BB06/qZSG+jCtbeRL+g6csWpFG6S+uAfRM05SYSY0X+Ijx8Onsr2yVh9WoL7aM+aKkpyeX
	EIyEbzBs5aEWn6e/fZOJXmBHYJlSg0OVR/J0v/XtLRUHo7IgGTU3YMEPVtqgttRYsECz08zki8P
	Tr2cSCQacjjJsiwGKXKKLGyLOYQh6THDUn6B1D/8OYU0Q==
X-Received: by 2002:a17:90b:5905:b0:36d:649b:ea46 with SMTP id 98e67ed59e1d1-3779beb2b77mr1242498a91.2.1781149996617;
        Wed, 10 Jun 2026 20:53:16 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:16 -0700 (PDT)
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
Subject: [PATCHv4 09/15] dmaengine: fsldma: use devm_kzalloc() to simplify code
Date: Wed, 10 Jun 2026 20:52:39 -0700
Message-ID: <20260611035245.13439-10-rosenp@gmail.com>
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

Convert fdev allocation from kzalloc_obj() to devm_kzalloc() to simplify
the probe error and remove paths by dropping the explicit kfree.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index eba194d64105..c3d2b24f8f07 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1222,29 +1222,25 @@ static void fsldma_device_release(struct dma_device *dma_dev);
 
 static int fsldma_of_probe(struct platform_device *op)
 {
+	struct device *dev = &op->dev;
 	struct fsldma_device *fdev;
 	struct device_node *child;
 	unsigned int i;
 	int err;
 
-	fdev = kzalloc_obj(*fdev);
-	if (!fdev) {
-		err = -ENOMEM;
-		goto out_return;
-	}
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return -ENOMEM;
 
-	fdev->dev = &op->dev;
+	fdev->dev = dev;
 	INIT_LIST_HEAD(&fdev->common.channels);
 	/* The DMA address bits supported for this device. */
 	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
 
 	/* ioremap the registers for use */
 	fdev->regs = of_iomap(op->dev.of_node, 0);
-	if (!fdev->regs) {
-		dev_err(&op->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free;
-	}
+	if (!fdev->regs)
+		return dev_err_probe(&op->dev, -ENOMEM, "unable to ioremap registers\n");
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
 	fdev->irq = platform_get_irq_optional(op, 0);
@@ -1325,9 +1321,6 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 out_iounmap:
 	iounmap(fdev->regs);
-out_free:
-	kfree(fdev);
-out_return:
 	return err;
 }
 
@@ -1361,7 +1354,6 @@ static void fsldma_of_remove(struct platform_device *op)
 	}
 
 	iounmap(fdev->regs);
-	kfree(fdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


