Return-Path: <linuxppc-dev+bounces-22462-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB03BCD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:54:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJk6Rd1z3brB;
	Thu, 11 Jun 2026 13:53:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781150006;
	cv=none; b=C1xly3C0C3M9XJa58EtO73JrCNK1mhRUm4gxqXpyl3RWFum3IoKEYmA0yspnvENCJ7Y0pLoXMI6cjcimuMq/A8wL+R6C5y1gF22z9p/IwIa4q2HG92BEmWKEcYiMH/pRTSFBNKR05HakCs4mYtR/vs6DfM/rS4RRZaQzatS5BNbdMheAYIKPwbaOI9+QSCNDZh15hIvJtDvBptnDpJzOydIkGvv+eBaW5GnOhU97FS9IgZJxz0eRgfLbWV/C0k7zxUc5+duHgJIVMyiFwefbgL7TkoWB01AoC7F3Nv3Pj58TLWePbOJwWOsvQD1Vu+fau6bjdykF36RBJ8b6YXcH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781150006; c=relaxed/relaxed;
	bh=bwl7yp6z2DJ8E/UGfDrMntTB6a7fFKpl/92m0Qbl/AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGYPI9Bvs7G5gZOq8WzxQf2VCkXhyyA+HtSZhsGmHCSrFF22TWOfb3zyPoFyMb/s4XEwxy8h9tMGVyBmZXMat/P1R4nGVSeMkrO1DlzQFdR9OMesT3r7jd/bTFzcuJ1kOWNIbpIeSkWQwn94qyp06Dm1blwP3ojeGJae+xwmCY8MIpQV7Jl6NOPf2hzxK20uRCFjnIzb0ETExIB8FfDYRVsPYgL8STAhVf9M1ncAEDmv24ys8YVFm1vMpwkDB/5qtTzFymQeHEiBCPo2tiAxZ1e7wLmc/7cSrrvUYTOFhPrPJSbuLYZUzKDzPRxdp3+cv4wd7nr9tpHbmU7z32BKig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LtdQVYkK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LtdQVYkK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJk1G5Kz3c9q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:26 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so315852a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781150004; x=1781754804; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwl7yp6z2DJ8E/UGfDrMntTB6a7fFKpl/92m0Qbl/AQ=;
        b=LtdQVYkKUpiy482YClJF1C5tvAH2l1LXXFTf9IkwEJMI5M1i82UW/COldvKeOKIzcD
         /S6K+X0KzqzzfzlMlMK4gkCCLPFykngUTdxCjrihdsQC1p/BksBMUH2o750qCHIU9gj2
         Ot/xe5jdghSIjw6cLDT4QKBUtbBskxXfu3ueLrplZIlPJjfgo+dJ3s2PrWS1jClvz6QJ
         eXQrD0IEyRyduPnEtWPdawGbZRi++JeNHaig10cULUR5hMDtbkWFEhMAeHuSbrxNTLUn
         Yano1ghXEUH+9mbDfBjj9kHGEbgWlDLhqS0mD4hEYZ8OVAJZnm4K5id15vb7iIG/GZNi
         i7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150004; x=1781754804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bwl7yp6z2DJ8E/UGfDrMntTB6a7fFKpl/92m0Qbl/AQ=;
        b=dJNbdn0guu/r04A00C1WTOgfYEOJmN09c5FIBdkNyOEKiZ1KUzQ01bE4B507HWXk5X
         DhAWzYA9cHEFcVMdBYPVg3pvMQ8lugzkTUQRC/RH2X3GqhyOQpxOenvJuOIlZQA8Ybph
         P0X2GNvXWpD/My83ykRsEKHU7Kkk0Ad+4C3jrdqM10j1PzxiGWfDwJ2HOl2hoz6uq2Vp
         t7l7p8GwyZp81SzaKFUARXyAcoTOGsyEY5XVez+MLy9gTsBrHChZcwHF1479z+fGsQtH
         CbqjwrR+URoNcLBfSFa4fZH5eXNSnnay6pPP70SfsufDTnuPbEIYeZWCEmUZAe/y3PoQ
         gYjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WjuMR4HaPumlF6p2ADnHuw7iy6JuR+aTsr1//gy9fKJMlp0e/3NRkmcw9FxzfwWBVeXSAnL2xPEl6eLo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8x2LMgebmFyVNs6iF5m21uUUcOkmWwEfXPVMl0z4l3ORc8MXD
	slHQs7ohnz7i/NkNDLu+Sh4Up5UXjTjyUY/mxDDEruc9Pf4+ft5oOa8B
X-Gm-Gg: Acq92OGKQKP9O+fPxlsDTHVTRUonH6Kb/BQSa1ubf5cDUxm2OmCDrMyN6ukgzFr4o4h
	ssXiOMbMYGYeLjMUR0j/qe0UxHRFfe2EmFgysDwT0m7HFYKaK33yBo/feXlxeO9vNJ2RZr/krR9
	pcyl/eEHpO9j4qpLb1RweB6FxprKIAVdnpTQXl+2lLqufexBj2ugDIsZH1tsWHmbJPxlvj/3uOr
	dBRvawOxuSbVnbwqgAq3IwO89FuCLacG1z/edDgWTDcj5vC7cyK8MxHyLFnVCPQQyUYEP1tgF2o
	smqlu2oajU6ggAHdbbt23edHpXKvC3xRH1uZvV8dSVpkG9Le+OgtLLAPAGwnp6ThbHQC4kzcn0T
	Pm5vQfD7B62c4KP3sz0ezno+3hHk/8udKAqLCFZKwTzVb+Z52LZa6IyqWhbuNbkl1xYmBs3zgfh
	gTSCOrqXub+zmSgWyTcHZABEn/mFY2cxJmCjvV9mG119YIXYgodNBMGVEfkXd7yu/WRGxDQQc/V
	tmWst82Og9GHCPa+M0kAgt+O4fPRZl00Fa1h1MzAjKXGA==
X-Received: by 2002:a17:90b:580d:b0:36d:630a:c4e4 with SMTP id 98e67ed59e1d1-37800fee6f0mr745354a91.3.1781150004392;
        Wed, 10 Jun 2026 20:53:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:23 -0700 (PDT)
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
Subject: [PATCHv4 14/15] dmaengine: fsldma: replace ppc-specific accessors with portable generic ones
Date: Wed, 10 Jun 2026 20:52:44 -0700
Message-ID: <20260611035245.13439-15-rosenp@gmail.com>
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
index 0ee3d719ae95..157db416eaaf 100644
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


