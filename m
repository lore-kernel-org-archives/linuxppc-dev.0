Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A02C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:39:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0105021479
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iOd+EwXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0105021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V0Hm13z0zDqfD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 01:39:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="iOd+EwXl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+39c443e67938b060f200+5525+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="iOd+EwXl"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TygS1R7QzF38X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:26:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K74mCYmVOLJRzyNfEnzhXh0UECbS5GU9R54tYFzJ4NQ=; b=iOd+EwXl95eb2AVGqS8jW/oHlA
 QkWuS3BVe5xM5dRfwO5pKw3OUinJ8vhM5YMk+pEEpBFS9VSO7m7WMf10lNcIvi6uonCHXdg7g5cBg
 s9zDsXqxuWo5FyU3W4R5fvifHnciQwKfrG79vSVhNQVH5ICk0jcpJMEdNp4x6CeKZjppu6oqzAEYb
 QheWujtsqDMvaU3hVYwlEJt6sQ9tbBe4LNe+8RbEmrb+0vl0Wi0pxXCqrq6tN8DEVn3ADjm9t79Uz
 n6nbJtlxZjGdjvtMy8bVVoAmTtchZSCUPjY7Ye1mas5OKo/Sao130eS9Re9qXUqw8Rfyj/kNW8Odg
 BX+B971Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s1q-0001fX-WC; Tue, 09 Oct 2018 13:26:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 33/33] powerpc/dma: trim the fat from <asm/dma-mapping.h>
Date: Tue,  9 Oct 2018 15:25:00 +0200
Message-Id: <20181009132500.17643-34-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is no need to provide anything but get_arch_dma_ops to
<linux/dma-mapping.h>.  More the remaining declarations to <asm/iommu.h>
and drop all the includes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/dma-mapping.h | 29 --------------------------
 arch/powerpc/include/asm/iommu.h       | 10 +++++++++
 arch/powerpc/platforms/44x/ppc476.c    |  1 +
 3 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index a59c42879194..565d6f74b189 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -1,37 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2004 IBM
- *
- * Implements the generic device dma API for powerpc.
- * the pci and vio busses
  */
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-#include <linux/cache.h>
-/* need struct page definitions */
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
-#include <asm/io.h>
-#include <asm/swiotlb.h>
-
-static inline unsigned long device_to_mask(struct device *dev)
-{
-	if (dev->dma_mask && *dev->dma_mask)
-		return *dev->dma_mask;
-	/* Assume devices without mask can take 32 bit addresses */
-	return 0xfffffffful;
-}
-
-/*
- * Available generic sets of operations
- */
-#ifdef CONFIG_PPC64
-extern const struct dma_map_ops dma_iommu_ops;
-#endif
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
@@ -43,5 +15,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-#endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 264d04f1dcd1..db745575e6a4 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -334,5 +334,15 @@ extern bool iommu_fixed_is_weak;
 #define iommu_fixed_is_weak false
 #endif
 
+extern const struct dma_map_ops dma_iommu_ops;
+
+static inline unsigned long device_to_mask(struct device *dev)
+{
+	if (dev->dma_mask && *dev->dma_mask)
+		return *dev->dma_mask;
+	/* Assume devices without mask can take 32 bit addresses */
+	return 0xfffffffful;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index e55933f9cd55..a5e61e5c16e2 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -34,6 +34,7 @@
 #include <asm/ppc4xx.h>
 #include <asm/mpic.h>
 #include <asm/mmu.h>
+#include <asm/swiotlb.h>
 
 #include <linux/pci.h>
 #include <linux/i2c.h>
-- 
2.19.0

