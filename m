Return-Path: <linuxppc-dev+bounces-22364-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C2CD8CAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:21:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyb1d56z2xl6;
	Wed, 10 Jun 2026 08:20:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043607;
	cv=none; b=gr0l2Eiqi9p1Ex61qEAe4AsoIu4BbeP2L1wU83f+tBIJ9ydtcdGTRJbNuV2jIw26daZGmIRdJ6bnyNN7tj+j8eD4d1fRwp5RVYRuFZzy7uVi88s5pCk86g5ktOr6SbX8O2Tz6y0cYJhkxuNldgHlpobkwO/uRcGoLVGoMsgropeXkc6JE5Xb1iGo1W2hFXHK0u2E1kz0f4Y+g8Vci2KI0C+6CWySH3+vvzSLtl/MAyLIKGhQtb8zKDR2KxfQJcKy5QrxndQrPehm4m5BSOOuzc3Uyv5ji55QKZ3wk/1gs5JMiBWrXNbhm8TOc8C1hH+7wC8P2oAdrCHp6+ubQeJvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043607; c=relaxed/relaxed;
	bh=6ULHTpyGJ6cpn7WfROoaIerINb7NFwICa9HOQzecsP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILl/R81ROQiD8N4LqDL8+d+Adm/PamR8P5LszcZ1FF2ne5ZjjmbeFyNwmfsLEFICjynKd4j0E6hIwzGg8u7V8mUTglZ9tDSJSSv3ZzZCOXCPjgogbpTfeLjXjOuc6WdLMp7Um93Q3nF0rkrkRawUHraBXJG0wpbdp931eItOfanUm9EBIPdB2vxpFjkMFf882NEe0TyFo9v+C4SLEhM0H4AyWPz74Yx7qke1oGNu5uEz8kg+h4fYKf4mFN+5xU0SOKHQR12FQXIGM1EKQZetMcaogUG2L8H+wE3Cgb7DkcJzIqYedyAScUCSwArteBrDwb5IU10wEjo20pzaEsEZPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bjVAgZKw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bjVAgZKw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyZ3NtWz3c2v
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:20:06 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c8588ec1b44so4162543a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043605; x=1781648405; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ULHTpyGJ6cpn7WfROoaIerINb7NFwICa9HOQzecsP0=;
        b=bjVAgZKwQhBDjf7hJdYb06YnlSacLqGyF6XSnYRtaK1DAGKistwZJuYB5Oc5hWVUn9
         yMctMobUOmQ6QOhRQcxEQ/E/pf4XazWeJK/lKunp6jsyagi4ICgHlbM/5RRE38Xy3tRZ
         1975KlqkHbAISdwBIaBpxgl/yCAmEh+BNkOzLBwKv08/b0XP4uIal6R0Xwl1WORFdk8z
         w1sTO4pNdQe8vTTdjOKXoBlFj+l7J4YbpfJfDtMdCwwFiLEQgwvvDYGsuoD5oZzQ57t+
         8KzTOMOD60JSfBLeviwvwa9OfLQtj33HD/K4hg2ehnfIKYfyJGOQf1cok+Q1qnqEHGdn
         MQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043605; x=1781648405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ULHTpyGJ6cpn7WfROoaIerINb7NFwICa9HOQzecsP0=;
        b=VKIovKKDfa3mHRVVOPpHOVC/MFR6CmHwKJOKu6ArN8g8NrxCytbVHNVVjh9SJE0cGI
         v6/ZTrwQJtGO4QqnCRdQCjTwuUbLYc6Fz6DwgPJuTpTksgq4B1ElbpIrcCCx27Kc47qd
         hsahOsAUqe4wEe0KLsEztH3jl5cNKxJu7uY4xGujU/j1LTdGcaOgiKppqETalcfowwqF
         31zXWD6/gQp7jttEag7hcJp71qvACAMGSG+wumyZT/7QiNc52QPGdeP7TdljA+z+xwbx
         kWYHEst1YSD5qlG/RRjpvUs22pVWtIbhFn92og4HjDzj1DNz/mAHlvUXpwS+inTWAOMG
         B9jA==
X-Forwarded-Encrypted: i=1; AFNElJ+tR2j4vcq2sqAJ4TzFDn6ADu4PfHqjv77CNzH3olxf6HuyqvTx2RePm2WwavPPv8MVsrlO41ZcFLBfLos=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDapgmNkcDHEeHydbBwMODYDMmhKK+1XenZuxkt3vmCgYluD+2
	dILr3pvaQgRxyXBc8KFGy2zF2bobuhDGuGk/GcPzfSDgLUBmneUdMAQ5
X-Gm-Gg: Acq92OEimqvFxBK6GYVqIr8nTJkfebXHVEaq+l8Z1iP9n2LDUGUxHzx5qF2wqcaNp+P
	+d0eAWVT+GLW3+GOnmQ2nOvOy8SKT6e3EdMFRIJbZ4WcndNm8x4ociwW62D/TvlqE14p7h2huDQ
	HXXk0+P/B2+gN6eAzQ0+l+nQwZTh7FbqPkc28sDyLruXnh5D8+bLpLeXPXfV/YRDsgIcGMv/Myg
	Df3Q5iJkKSvHdqqpLHFRkOb6wxIeDQx7MhScV8hVYp6vW4riH+/lSAlc/Nnkr3tkaofIMDx8zNi
	E0EjJjfXM86Zd6/q/X2Nq6n67e3otsFrq/xv6AgnDmM6U/h/DKTgPIEa9HGwOhzgNhyFsTPM8j2
	Jg7shpGyNhiDOcxwunkfbqbpV+WW3DhHrqOFD9F76IAGzsguA1O2T2LQ3b3f3J/NlUuvIXX4FQ3
	f/C6BN6W9/CDyZqp+QiRWMT/P0q71q24ugNS+KyyIYcAMickakba1jtmhXKdtqlCMXf34xTI1DL
	Hcz8tUDbFtGWVuNX2aZal1mk5GgirXPLMTeOgzhrRwfiA==
X-Received: by 2002:a05:6a21:730e:b0:3b4:cd6:891 with SMTP id adf61e73a8af0-3b4cce1eb3dmr26797561637.20.1781043604699;
        Tue, 09 Jun 2026 15:20:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:04 -0700 (PDT)
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
Subject: [PATCHv3 10/15] dmaengine: fsldma: use devm_platform_ioremap_resource()
Date: Tue,  9 Jun 2026 15:19:21 -0700
Message-ID: <20260609221926.35538-11-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
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

Convert of_iomap() to devm_platform_ioremap_resource() to let the devm
framework handle unmapping. This allows removing the out_iounmap
label and the explicit iounmap() in both the probe error path and
the remove function.

The DGSR (fdev->regs) and per-channel registers (chan->regs) map
physically distinct regions in all supported variants
(EloPlus/Elo/Elo3), so there is no overlap risk.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index dac12de06ef5..e4a3315a7d9d 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1238,19 +1238,15 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
 
 	/* ioremap the registers for use */
-	fdev->regs = of_iomap(op->dev.of_node, 0);
-	if (!fdev->regs) {
-		dev_err(&op->dev, "unable to ioremap registers\n");
-		return -ENOMEM;
-	}
+	fdev->regs = devm_platform_ioremap_resource(op, 0);
+	if (IS_ERR(fdev->regs))
+		return PTR_ERR(fdev->regs);
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
 	fdev->irq = platform_get_irq_optional(op, 0);
 	if (fdev->irq < 0) {
-		if (fdev->irq != -ENXIO) {
-			err = fdev->irq;
-			goto out_iounmap;
-		}
+		if (fdev->irq != -ENXIO)
+			return fdev->irq;
 		fdev->irq = 0;
 	}
 
@@ -1321,8 +1317,6 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-out_iounmap:
-	iounmap(fdev->regs);
 	return err;
 }
 
@@ -1354,8 +1348,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (chans[i])
 			fsl_dma_chan_remove(chans[i]);
 	}
-
-	iounmap(fdev->regs);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


