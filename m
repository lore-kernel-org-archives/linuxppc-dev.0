Return-Path: <linuxppc-dev+bounces-22141-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BDFCD6E7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:03:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlm5FpSz3c4Y;
	Sat, 06 Jun 2026 08:02:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696932;
	cv=none; b=gNVJJQN/fRkze3GyJurHswaefKvm+KlSmw69JGmc3fCpU683Gue9gLjno2a61JzBuYRtZcxRs5hGjqOOQlvkn9jHGVWVQKWZjpG913ZVQyYf/j/9YG9y+CpKs2VflK1db9QnL+3NgNL43tD5117dnmG56Q+TNsbywoGF/W3a6aGH0GZ/TtIplR7bVnGf2AubEV3UaTZNgLMqVv1w/FebVLxPoPjH0dw2aQt7ILaqfryEAsIwEeEoEk4vsfT7QlStjxK8uOD3IFZ3QGcQyq+EUIRDdRUFMRwZ/x5ddvf4KdqXeNatkai+9Rj9vTJ2PMbFI+4MdKTQGGJv62UNB4iawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696932; c=relaxed/relaxed;
	bh=lCrOV/66FRzdEdHCWluMsQiKmBFsYBQNgpZa33W4dWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Szrhijz8caAKOfbxkrbSWUfXs/LQEWL8cb/Odk1a9B/bCBYK60S0Z+tiEKCJ+kX6jL3mMLoAg0nfHrk8Msmw/1HK6bDoKSCu6T+u9HrhdqsYNxy7TCavrEQSZ6pcG++F4OPENgo6PvIIQnPqJ3xUuZHtEF/1N+0h3hSofxMSmWMkYYtREThAAodkggl/L0F7vzeKe1yRBQvGfE+EaJpDjfTIS49r0tZzLlvK0Lm19yEBN4dMv9g2KcLpQVxjCiVzTvvts01zG/HdnCX9AJ2NoekBflK+x5PW10iNtaZn8U2SV8Ys8bA/6A8rd065LuV+WIX+XYzs4NJAtKuf4n26kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EiA34XTz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EiA34XTz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlm00bwz3c2Z
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:02:11 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-84237c55ef9so1244899b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696930; x=1781301730; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCrOV/66FRzdEdHCWluMsQiKmBFsYBQNgpZa33W4dWo=;
        b=EiA34XTzSMYgTPJgInSiu07MRVf8VuYeF/cyT3kUdWcbMDI4axJMAtscBXkRE0vsIG
         mD0UBC4YbCy078gMXNroyUyWjFXB+4jodyQVgCGBU9DUoJY5mfVpXajglzXu56aVy2bM
         2rRwDOVc4w4i5/e70NRkmtyCm8Oc9EhhHQdB3Zb5i2YqXBPQC4DzYw/R07jJaEX7w7rb
         jeqWZPA2/I3brEnzaki5ccXH8MnulEhPfkWOubjaDtIWuTItK3eY1/BTJKivWEHwLf76
         Kizj7bGsyO+XdYXucPco/3evYRQpCa/fnAU97OVmnrSkYUeo/DMU1sB9TEpk67dc9s2y
         waNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696930; x=1781301730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCrOV/66FRzdEdHCWluMsQiKmBFsYBQNgpZa33W4dWo=;
        b=K3ZigEJyIlRNtgM4WvdXuwQQBK3sFFzIA2StzlZccxhuLKoKs4iCwfXZfp18Okam9C
         BhUBSPVOHIxn7uI0Pf0j5CeKN32yzjOC+GO4z4HCJcfDhjsg0oibdJD5rGb1xFv8K0JN
         VmvBxVDoybRk6DwjCNW/FIG7B5YUvqxNPLqh3TRnsMpO5QZ4OAgkWxbossHHmABneKAA
         pTwO/InJZGv0xr9nrRnyWHj0pIXS7R6k+h7d6cISYqsd0Xn0Vh6ucIflvQlRkWzJkzJk
         TGi6ILDoaDj/3EG9sXyhZMbuIRwlG1bGVKo0fqx4iU8kcJl3oBBdqAUFzH8MOMaa7cAn
         k3lQ==
X-Forwarded-Encrypted: i=1; AFNElJ+y0iOhRn4sMTK+tQOagA533ZCToGwoBcEDVkPii6JoWnxG5ScIW6AG2OLFWY1yLaAtM/8pYX2v7NKuRv8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxpk1nMWGSgeIdkSvjriwnIqTd4c26wqq9R4z9jYXi9UVnIMnLk
	H9o/ZpS2cMxzo6v4VC/PBNBmX7IUZ2Nht9eNzt2ezxH3KesiEu9r+jki
X-Gm-Gg: Acq92OGSrQhCw+sz2o9s3wi0V39C+UDXfKsXFfUBR4s+90ymK8P1XCXOK7qNgvledyC
	eXuTHkAJjj544OJ1AyjFRRrXVJWA1J8jLLDuTZHChPUs4+Et9K5NI/077i5WxfMStuGitANFR/B
	itdJxPR2HS7FgHmFoUuoMhy8AuVGKaQFjoQ8tQi9cs5JHcz3Ls8gaQYnFRbuTR4OpbxoBJiGBeP
	eU0h8ivyT9cZy4pnqxvHzPJ4uytfLuWEcjmlkER6f3pClahall/w65LK/x2lMmsVBf71s4DUR4S
	TU5cdPXItt7q795pjIZ+avKJod0xlJrQK4voMZO6+whQuD3awLaEy+5TD6W1P/2Fb22oqZi//eQ
	7ixWR0u63EcmxOocQPlM3kLCvdefaGaMoJBsKEVxKYEE8znD3wZWATzZSD3pcoVBZofwH7KGkPH
	K8u3ToEIQxU7RrCJjb0PP3kcDFHH33sKJPovx9IGqT+Cvh07GizNavM/T4F8xJPb5gWLOroYx3c
	5ZLY/nd6S6tnDNySubIYg+81xeMD48PLn9ipxgrkyK0Ow==
X-Received: by 2002:aa7:88c6:0:b0:834:e5a2:d089 with SMTP id d2e1a72fcca58-842b109cf44mr5622300b3a.33.1780696929651;
        Fri, 05 Jun 2026 15:02:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:02:08 -0700 (PDT)
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
Subject: [PATCH 10/10] dmaengine: fsldma: replace ppc-specific accessors with portable generic ones
Date: Fri,  5 Jun 2026 15:01:34 -0700
Message-ID: <20260605220134.43295-11-rosenp@gmail.com>
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

- Convert remaining in_be32/in_le32 calls to FSL_DMA_IN macro
- Replace __ilog2 with generic ilog2 (pull in linux/log2.h)
- Add linux/io.h include
- Expand non-PPC accessor support from ARM-only to all architectures
- Guard 64-bit generic accessors with CONFIG_64BIT; provide
  emulation using 32-bit accessors on 32-bit platforms

Add COMPILE_TEST support as a result for extra compile coverage.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/Kconfig  |  2 +-
 drivers/dma/fsldma.c | 11 ++++++-----
 drivers/dma/fsldma.h | 35 ++++++++++++++++++++++++++++++++---
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 302021540d76..9b13e7aa31c7 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -206,7 +206,7 @@ config EP93XX_DMA
 
 config FSL_DMA
 	tristate "Freescale Elo series DMA support"
-	depends on FSL_SOC
+	depends on FSL_SOC || COMPILE_TEST
 	select DMA_ENGINE
 	select ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	help
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 01c9cd27e795..a7c1f1b4c9ac 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -32,6 +32,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/log2.h>
 #include <linux/fsldma.h>
 #include "dmaengine.h"
 #include "fsldma.h"
@@ -266,7 +268,7 @@ static void fsl_chan_set_src_loop_size(struct fsldma_chan *chan, int size)
 	case 4:
 	case 8:
 		mode &= ~FSL_DMA_MR_SAHTS_MASK;
-		mode |= FSL_DMA_MR_SAHE | (__ilog2(size) << 14);
+		mode |= FSL_DMA_MR_SAHE | (ilog2(size) << 14);
 		break;
 	}
 
@@ -299,7 +301,7 @@ static void fsl_chan_set_dst_loop_size(struct fsldma_chan *chan, int size)
 	case 4:
 	case 8:
 		mode &= ~FSL_DMA_MR_DAHTS_MASK;
-		mode |= FSL_DMA_MR_DAHE | (__ilog2(size) << 16);
+		mode |= FSL_DMA_MR_DAHE | (ilog2(size) << 16);
 		break;
 	}
 
@@ -326,7 +328,7 @@ static void fsl_chan_set_request_count(struct fsldma_chan *chan, int size)
 
 	mode = get_mr(chan);
 	mode &= ~FSL_DMA_MR_BWC_MASK;
-	mode |= (__ilog2(size) << 24) & FSL_DMA_MR_BWC_MASK;
+	mode |= (ilog2(size) << 24) & FSL_DMA_MR_BWC_MASK;
 
 	set_mr(chan, mode);
 }
@@ -1004,8 +1006,7 @@ static irqreturn_t fsldma_ctrl_irq(int irq, void *data)
 	u32 gsr, mask;
 	int i;
 
-	gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs)
-						   : in_le32(fdev->regs);
+	gsr = FSL_DMA_IN(fdev, fdev->regs, 32);
 	mask = 0xff000000;
 	dev_dbg(fdev->dev, "IRQ: gsr 0x%.8x\n", gsr);
 
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index d7b7a3138b85..01f93123b233 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -232,17 +232,46 @@ static void fsl_iowrite64be(u64 val, u64 __iomem *addr)
 	out_be32((u32 __iomem *)addr + 1, (u32)val);
 }
 #endif
-#endif
-
-#if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
+#else
 #define fsl_ioread32(p)		ioread32(p)
 #define fsl_ioread32be(p)	ioread32be(p)
 #define fsl_iowrite32(v, p)	iowrite32(v, p)
 #define fsl_iowrite32be(v, p)	iowrite32be(v, p)
+
+#ifdef CONFIG_64BIT
 #define fsl_ioread64(p)		ioread64(p)
 #define fsl_ioread64be(p)	ioread64be(p)
 #define fsl_iowrite64(v, p)	iowrite64(v, p)
 #define fsl_iowrite64be(v, p)	iowrite64be(v, p)
+#else
+static inline u64 fsl_ioread64(const u64 __iomem *addr)
+{
+	u32 val_lo = ioread32((u32 __iomem *)addr);
+	u32 val_hi = ioread32((u32 __iomem *)addr + 1);
+
+	return ((u64)val_hi << 32) + val_lo;
+}
+
+static inline void fsl_iowrite64(u64 val, u64 __iomem *addr)
+{
+	iowrite32(val >> 32, (u32 __iomem *)addr + 1);
+	iowrite32((u32)val, (u32 __iomem *)addr);
+}
+
+static inline u64 fsl_ioread64be(const u64 __iomem *addr)
+{
+	u32 val_hi = ioread32be((u32 __iomem *)addr);
+	u32 val_lo = ioread32be((u32 __iomem *)addr + 1);
+
+	return ((u64)val_hi << 32) + val_lo;
+}
+
+static inline void fsl_iowrite64be(u64 val, u64 __iomem *addr)
+{
+	iowrite32be(val >> 32, (u32 __iomem *)addr);
+	iowrite32be((u32)val, (u32 __iomem *)addr + 1);
+}
+#endif
 #endif
 
 #define FSL_DMA_IN(fsl_dma, addr, width)			\
-- 
2.54.0


