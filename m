Return-Path: <linuxppc-dev+bounces-22368-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69DECD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:21:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyl5qDpz3c7R;
	Wed, 10 Jun 2026 08:20:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043615;
	cv=none; b=oxDytDuRrKE6l15TyMn2NTBK8KpYVSgH3auR5UhPbiOz4UHjWiiRuReFCSUz05ott+jULZ+EKLYmL1gzVBpJ5tINVobMvPLLkFVkIfl/P36uExzrMPca0j3PKMeVcr4GvSLw1NWFGoE8XVxOAQyCZSEpRZgMfJJCq8Ww7BDiNaTgLMKGFrkzNwZmQB9QvGdDBqQM8YL6Wq90WaCSafMCm6ResG8hToiFoj5jj3aIHbL5/YSSjE02YzvpFKnGCo1CQ409/ZETjVWBXtFdvbX7RKjc/nZ9GfdiOsQfz7tNKxRPLWmtHXVDZhJDmHkpp7LYFwzZC0ZpF/MZKlCebw3jfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043615; c=relaxed/relaxed;
	bh=8UhO55Yo3qdvFwINhOeOCySQ32WXkyaaxtV0xfPLwL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fprrkgy8pQX3q9bsnr999DVf2FmVmQ4u20rcVAilIATUXIXUAP7ugSGOapfvjXrePmAE5Sg99RMk0ZCzqKqrzq7FLQHnk3SQIQSpHFG2zlEDo3IyqX7axety9lm19s0BPxqD16wtoTxJ3WvzTg2LeICtctZy52y7QOkQ+L8A0rbD2A5iJQ0NPkc7I3c0N6TPZgWF+TvJT0p3NSLccrSQj08xipqWzZ6Vhq+zpRC9Wa1mUYkjL8K2GdP6hoytz+RAL7X5ItB4okQ93AxXCk9oFGxkguK3Sv+CuT5zY0Ta+EZ5qC4T6HKB4XEeBanpMzxcfTT+Ekl6L0/hJSeqq6vcCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ngejjje8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ngejjje8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyl0XF9z2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:20:15 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so3707285a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043613; x=1781648413; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UhO55Yo3qdvFwINhOeOCySQ32WXkyaaxtV0xfPLwL8=;
        b=Ngejjje8E+ClLA/xJuwc6uF6K2pp/qLqemCnPKRNps8mW3EHsE0LJCrSo0ZytCfyxU
         U8c9PDrfmsFBSUMWq/Ql1tW5IJ19180x6pwAWjNfGXDFsHMox2f0k+BKkNFl+GotXmqH
         7nWS9xqeXrMftTr4ICI6/F4mhetNu5ixfLifkyKoNFDHedKI4BrSwKs1BPW0/lVNctlz
         O4htqpB+aZr+9NQFDqcI2zPiOXSooPcncTYHlr656TNID+7iimgp0vXUYeF8aRWzc8HH
         pbOOxlDt6ru5F8+9BuOvld3tUKzMW1yYrTalBWwK7LDfmKfA5j48yKLK4YO85UZL+cz2
         2N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043613; x=1781648413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8UhO55Yo3qdvFwINhOeOCySQ32WXkyaaxtV0xfPLwL8=;
        b=HQD0Vq65ne/CbT/hxXzND3gk6KiYL4SyJxP1l1/KTy/7XFkDJ9H8AZVKZn4tdoBGVR
         uvoiK8RpTqvl22uhjgU9Wnx5SVBH50Ov6b8Yqx1QrHlVcO2cK+8M4/uqK08sX/jdv9he
         vZpYDz/o6QMIKpQh7gF4/N5KdOUeu3YVJayJ7YCGzme8y6Zdeck1byY1qoipWcAdxUFu
         xOGzWM+1RV1vahYFdP2+u+HwI1oRkStB58o+DJQ3ACCHgP1AOae2UazZxiEDUQee3MQf
         EsJPZJPFCyOjNtljgGOfaunG14WyfzPVHRIRqC/Qac0Hv81Zw7H3rVoSp/XBbXwcAtZF
         yVow==
X-Forwarded-Encrypted: i=1; AFNElJ8OgNq9+RTk2KJl8feHx8Quy6mkxZdCI/Z7sdDOI248ZAUScIcuhT/rZ9GLw+AzWhjlOYLqWTMunl46Fr0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzS8Z5vT9P7UTl7ghLPAIoNbiilg2bJ99if26FrSAcUSKz2t+bK
	cn8u63BpnWms1euDNapyFJ94Lt67I2/GBi2Z1t5BZHvBn9AnEEuK10aI
X-Gm-Gg: Acq92OGbCLSgBLNOkvGilPOwtYdnNoXGxQZPwROODxrUwXtYe000oanx1kQpyGJaVV4
	nFKRWbYyRUnKUF5BdrsCrc/boZt6YHXu5M0YEb9fDYxXqVtsdnXc8Ca3ZuwoZL+SVL+cibtRUvj
	J+4qrWAylBWT/e+O1I8ev4NGQiMOKLMKandKdyS1x2W8EM/yGsIPdnPORW6xTGqM8uKFDgguzda
	5PV5s3lZNzQGtNbi+cGMa45fdzaqekrXNVjy54XrcgouGJAdX5EJDYjl/woAefCf2vSvn7kwN84
	R0K8bQBmUlehxslak2p6SmVLMngKVUIz242vpD3i3XZRNhPfmABSyMCJJabNUoVhv2iioVjntQc
	m7VgcP/BTAXxKyEWKrudFQQW4vC66kAVPU+K+m55T9qa4Bp3VQLzKHX33cLm0rAY7EG/IxlQfs2
	YlPB9kX98tIlZDWK53GCld8i0yR6so7NendwgH+Tw7tpSms336X8o2mH5R2ysDf80SsJjDZKCP/
	jm9AwfXS1QbYjh4iH8m4DkMOqrD4c+9WrfVJhJnhqTxtw==
X-Received: by 2002:a05:6a20:918b:b0:3b4:79fd:cba4 with SMTP id adf61e73a8af0-3b4ccdedeb9mr26932559637.12.1781043613288;
        Tue, 09 Jun 2026 15:20:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:12 -0700 (PDT)
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
Subject: [PATCHv3 14/15] dmaengine: fsldma: replace ppc-specific accessors with portable generic ones
Date: Tue,  9 Jun 2026 15:19:25 -0700
Message-ID: <20260609221926.35538-15-rosenp@gmail.com>
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
index 7d0c80121aa4..d4c9b81ade0d 100644
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
@@ -1007,8 +1009,7 @@ static irqreturn_t fsldma_ctrl_irq(int irq, void *data)
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


