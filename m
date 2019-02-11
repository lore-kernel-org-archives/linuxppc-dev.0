Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33124C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:07:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B33E21B1A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uhrLKOKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B33E21B1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ynfZ3kl4zDqVN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:07:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+9b1dcb6e3a5668f89bb7+5650+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="uhrLKOKu"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ymz4601fzDq5n
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 00:36:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kHv07RO/ngeVD0MskaRXdcNaSdwFKKqN7y8s8LEfCNA=; b=uhrLKOKuwnH5KX77gyHYN/v3Rh
 9Rr4l5MbkcZKYIvsPi3aTtaXpKR7YWZkELiP0w81boKUpWsMeA3Gbf2Z1miu+h0DTuRgOVo2y+UvD
 Vd5jWbbqUUDW3mjqe12LtbGWlWki8ClMoclJf24qm1CEmiu0xVYY54jTkBhhkmhMhbOYVINf8vj3J
 rwndVrx3ZtgjkxCnxN49njtwUo599OOHrA51uihdxDKcLt7ua3ztKanRqWHWrULWwMnaaYBzz/Rgx
 bR4QgNoMJNJ31riFwPKIapuoKGIk4DjlMiemZ76hWw/geWgRhzI53lDirWbBeGSaK+Jem/HDExBQ1
 8A3ETI0A==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBkz-0000G0-BA; Mon, 11 Feb 2019 13:36:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 08/12] dma-mapping: remove dma_mark_declared_memory_occupied
Date: Mon, 11 Feb 2019 14:35:50 +0100
Message-Id: <20190211133554.30055-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This API is not used anywhere, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API.txt   | 17 -----------------
 include/linux/dma-mapping.h |  9 ---------
 kernel/dma/coherent.c       | 23 -----------------------
 3 files changed, 49 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 78114ee63057..b9d0cba83877 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -605,23 +605,6 @@ unconditionally having removed all the required structures.  It is the
 driver's job to ensure that no parts of this memory region are
 currently in use.
 
-::
-
-	void *
-	dma_mark_declared_memory_occupied(struct device *dev,
-					  dma_addr_t device_addr, size_t size)
-
-This is used to occupy specific regions of the declared space
-(dma_alloc_coherent() will hand out the first free region it finds).
-
-device_addr is the *device* address of the region requested.
-
-size is the size (and should be a page-sized multiple).
-
-The return value will be either a pointer to the processor virtual
-address of the memory, or an error (via PTR_ERR()) if any part of the
-region is occupied.
-
 Part III - Debug drivers use of the DMA-API
 -------------------------------------------
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index fde0cfc71824..9df0f4d318c5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -735,8 +735,6 @@ static inline int dma_get_cache_alignment(void)
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size, int flags);
 void dma_release_declared_memory(struct device *dev);
-void *dma_mark_declared_memory_occupied(struct device *dev,
-					dma_addr_t device_addr, size_t size);
 #else
 static inline int
 dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
@@ -749,13 +747,6 @@ static inline void
 dma_release_declared_memory(struct device *dev)
 {
 }
-
-static inline void *
-dma_mark_declared_memory_occupied(struct device *dev,
-				  dma_addr_t device_addr, size_t size)
-{
-	return ERR_PTR(-EBUSY);
-}
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 4b76aba574c2..1d12a31af6d7 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -137,29 +137,6 @@ void dma_release_declared_memory(struct device *dev)
 }
 EXPORT_SYMBOL(dma_release_declared_memory);
 
-void *dma_mark_declared_memory_occupied(struct device *dev,
-					dma_addr_t device_addr, size_t size)
-{
-	struct dma_coherent_mem *mem = dev->dma_mem;
-	unsigned long flags;
-	int pos, err;
-
-	size += device_addr & ~PAGE_MASK;
-
-	if (!mem)
-		return ERR_PTR(-EINVAL);
-
-	spin_lock_irqsave(&mem->spinlock, flags);
-	pos = PFN_DOWN(device_addr - dma_get_device_base(dev, mem));
-	err = bitmap_allocate_region(mem->bitmap, pos, get_order(size));
-	spin_unlock_irqrestore(&mem->spinlock, flags);
-
-	if (err != 0)
-		return ERR_PTR(err);
-	return mem->virt_base + (pos << PAGE_SHIFT);
-}
-EXPORT_SYMBOL(dma_mark_declared_memory_occupied);
-
 static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
 		ssize_t size, dma_addr_t *dma_handle)
 {
-- 
2.20.1

