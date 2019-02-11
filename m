Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFABC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:14:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85171222B8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="acIvOZoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85171222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ynpL4yt8zDqCk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:14:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+9b1dcb6e3a5668f89bb7+5650+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="acIvOZoy"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ymzJ6f4szDqSg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 00:36:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W9FJcTHMzF5rFxf5wloOxdXDIN4eS7UeMrDr1N/9VIE=; b=acIvOZoyjIOlcdNN91jqtE2VHc
 wyTYQROu3gLMmWo3Llh/eckVIVQm5Xt55KzQZfFMLel4VoUVuWlr1v5SonbkTOUEPWUvhTXcA7hYd
 lT5AXgX/b5gf82nr3ng5X9UmWXgSdMirDGqaThQnzOocIRI7j9I3WrXMQklDT6O3E14yDsyUGrCQi
 q2k0wcqTmDHkShP7DmXZ0cirIN4lCYNZAOJNq6BehdZQ5PhMRxg7yWI8tkdtW+hoDhdvhR2Upb4iK
 pBDjvo/tgt6m0sZLAMv7bz3CKa3ThF7l/+JGpHIlgSDsH9apGIDX37PVkBdn/6kBGgAOBXZaLrEbu
 OYsacSpg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBlA-0000WC-MV; Mon, 11 Feb 2019 13:36:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 12/12] dma-mapping: remove dma_assign_coherent_memory
Date: Mon, 11 Feb 2019 14:35:54 +0100
Message-Id: <20190211133554.30055-13-hch@lst.de>
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

The only useful bit in this function was the already assigned check.
Once that is moved to dma_init_coherent_memory thee rest can easily
be handled in the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/coherent.c | 47 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index d7a27008f228..1e3ce71cd993 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -41,6 +41,9 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr,
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	int ret;
 
+	if (*mem)
+		return -EBUSY;
+
 	if (!size) {
 		ret = -EINVAL;
 		goto out;
@@ -88,33 +91,11 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 	kfree(mem);
 }
 
-static int dma_assign_coherent_memory(struct device *dev,
-				      struct dma_coherent_mem *mem)
-{
-	if (!dev)
-		return -ENODEV;
-
-	if (dev->dma_mem)
-		return -EBUSY;
-
-	dev->dma_mem = mem;
-	return 0;
-}
-
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size)
 {
-	struct dma_coherent_mem *mem;
-	int ret;
-
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, &mem);
-	if (ret)
-		return ret;
-
-	ret = dma_assign_coherent_memory(dev, mem);
-	if (ret)
-		dma_release_coherent_memory(mem);
-	return ret;
+	return dma_init_coherent_memory(phys_addr, device_addr, size,
+					&dev->dma_mem);
 }
 EXPORT_SYMBOL(dma_declare_coherent_memory);
 
@@ -238,18 +219,18 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 	struct dma_coherent_mem *mem = rmem->priv;
 	int ret;
 
-	if (!mem) {
-		ret = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, &mem);
-		if (ret) {
-			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
-				&rmem->base, (unsigned long)rmem->size / SZ_1M);
-			return ret;
-		}
+	ret = dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
+			&mem);
+	if (ret && ret != -EBUSY) {
+		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
+			&rmem->base, (unsigned long)rmem->size / SZ_1M);
+		return ret;
 	}
+
 	mem->use_dev_dma_pfn_offset = true;
+	if (dev)
+		dev->dma_mem = mem;
 	rmem->priv = mem;
-	dma_assign_coherent_memory(dev, mem);
 	return 0;
 }
 
-- 
2.20.1

