Return-Path: <linuxppc-dev+bounces-22458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6885ACD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:54:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJc31GKz3c3l;
	Thu, 11 Jun 2026 13:53:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781150000;
	cv=none; b=gIWoEBTbbML+IPwoRAf4bMDl5gI2odxGER8zOSvAHpT+wJt0uZYTBrqrF/CaeeCoCAClCG+NICuQdpTrqDWHNnHGgBN88v6PBspKsjVXbXf3RbvvZVam6LiN/fFpez8ztycywBRhf0C8ai6DH4IOV1nkERl3V6WAEvNV9D5dpOv126/Nx5cLVKNR2G2qsYwfnab4KvObtBIuKJLHvFzj4rJVUXziuDDs7FY7ys0zeAgc8+QEU7kqi+r8xpeFVHzbh43ltDkp9zOjPk7qI03cmD1nlLCcqaawwAodVPXKzT1zorwCBw+M/4yfaWNsw/l6HOGstwivqlNb/A3UkFVKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781150000; c=relaxed/relaxed;
	bh=/RqUuykkdPZkLeqRZi/NqGaxU3+Ffx6rHHdgS1c9JQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BREXKS6Zcw0vpHtDYwObSa7p7fGEnwju/KC0bn2H46hDW1fAwxEvVNCAJbHPYmxcOp+BJkwK2z1bXlHF1kBto+4lzMttH8dr4V+pKz+DJbSsEWfFMPn7gLVof2Ct7t8C+jBRJ8ZaEXmfbWl092fPQdoelj0FmUGa26xyhkXTLXbtqpeyKoHNGzE5xvECLAB9AurVvzZcEGgkWlq452vZdQTGFz1VRYYL/pfBt+69p+Z7WzuIdF5gmNH2UlA6X8uxkAHN05aMlhUdEgiFlqloYZzMC1FMdBRsMgrKhPdvd1lV0HIlOIBpai2jH5c99P1IQcfsBnZbjzOnEycEo/i/JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aKZtqTIr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aKZtqTIr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJb5FX3z3c4h
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:19 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso7406281a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149998; x=1781754798; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RqUuykkdPZkLeqRZi/NqGaxU3+Ffx6rHHdgS1c9JQc=;
        b=aKZtqTIrSDY04ezD2xzFrLfHsznXFoSCG2FnWE0FVqZM1GKtyxLr6rRMBdN3w/Pm+1
         DzjUurNO2OmoorVf2NFoUj4Gmw2p06w7qFglIfzng7VUeYofbgAqdmDLUwccDmfrRACo
         rWsEiMHtoHO6L7OIGYzjajRKBcD0MCiM2YRrfqtERQNuN9lNjSbFmNGIL4O1aH7U9flM
         QREmyqcYM99z/y6JxWz5pYpnN8/zq3NAQH2mQP4ElD+uth8xWFcmRCKL9b09XDsHuxPt
         cltut3iQFney7JJEp4d9bLTwJZCoH1NJ9tE89ubgk/RYc/z1iIQsDWucAZIApwkOAfao
         AQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149998; x=1781754798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RqUuykkdPZkLeqRZi/NqGaxU3+Ffx6rHHdgS1c9JQc=;
        b=pbDaTRfWDGnU3tFqXCpRJnwqOk/PJjfxIE6Bu+7IYV5QQBp+9zqxw8d1p7xEh3n7xa
         gLMZw/yGG5OyyMh8X/XiDexlL3TOcXqrbNuMNXk4y7Dt8s0ROKNPtl+QbIHV++QK10pW
         C8b5Y4O7B1/ltKCjI+ojmEhPAClEK1ADzW/a2LHWpUwp8Y7jq6/ZzSPIeU5+0O66Ix+D
         Hs9gXjNpJD+8wVUz+4NGppvZZDBQ9BwgQjwZsNJfSmokaNHO1WZI8vlNEiwd/fOofBfy
         ZZOuas8VMFoL33F4Y8uKUFmVTk4Xge+r7I7BcnpuXvazw7WQwWXb+qjtkp0T/DyjbxG1
         9X+g==
X-Forwarded-Encrypted: i=1; AFNElJ/RYMz1ASFze9J66vQGfd/duGKiy5RHDmGkodLWSvj4PF8fQt634jbVU3WXOx2mXNM1J24g4YtgeaaeYH8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQbYLZx5zO+JWgRKx61/tL2ruS8Mp29/mIJbtzSW+FZQu74mG4
	Eh3QhUwroOlkg0a/tQMahpt9dZSrxgfPIUepQfN7cl2/M86v/wU5FTML
X-Gm-Gg: Acq92OEKzh/Prz9sMnKRUPJzCnXmHQGpf1ScSAPLY+4FaLOyp4Duh9Pas8UvZqU6QGY
	bni04kkD5v0ItEpssMpw3BcxIPibnILWfJlz5bbvVr52G9dDQcGTd4YQjT23Yt8xziePhyGmYwg
	ZgKoQd5609gm0ovs49SOq7Q9uCe1bra4r1Zum9squ9amTzWn+c2lyURMBrjaqN9yi0yG6laTQ1E
	q5YfBHBfakgJ38g98nsvIV/DI2jNRzyGhfWdaMyzWjy/XwNblK3RyajHAPih7wX70/AhCX3OSNO
	skeH9XJoLPbQBmWk5tL0qeZJPu9RHO2/MKBzRRHHJAZJDnIsZ8UDWaBDZm5v82vf5n9nqAWf5rE
	DBNxeikd4nzY/xk94ozQoE29Pt/pSme6/D8uPcY5hckLJUt9TpubLkWeRq7RjpgYKxsLKxH2IPW
	NWnytnOVflGJ2XPI3IlD1Dj2s3lEOvPqVhET/Sd3e/7f6ApqyaxbwP5LwQrEScvo2DvIJB4Gceh
	wpjK1TQ6bjF0YU5jTuGPj6mqG6Wy7hu+pzOLZ0/Tsp88A==
X-Received: by 2002:a17:90b:3a05:b0:36d:b12f:613c with SMTP id 98e67ed59e1d1-3779f186dcfmr1274210a91.10.1781149997909;
        Wed, 10 Jun 2026 20:53:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:17 -0700 (PDT)
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
Subject: [PATCHv4 10/15] dmaengine: fsldma: use devm_platform_ioremap_resource()
Date: Wed, 10 Jun 2026 20:52:40 -0700
Message-ID: <20260611035245.13439-11-rosenp@gmail.com>
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
 drivers/dma/fsldma.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index c3d2b24f8f07..e4a3315a7d9d 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1238,17 +1238,15 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
 
 	/* ioremap the registers for use */
-	fdev->regs = of_iomap(op->dev.of_node, 0);
-	if (!fdev->regs)
-		return dev_err_probe(&op->dev, -ENOMEM, "unable to ioremap registers\n");
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
 
@@ -1319,8 +1317,6 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-out_iounmap:
-	iounmap(fdev->regs);
 	return err;
 }
 
@@ -1352,8 +1348,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (chans[i])
 			fsl_dma_chan_remove(chans[i]);
 	}
-
-	iounmap(fdev->regs);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


