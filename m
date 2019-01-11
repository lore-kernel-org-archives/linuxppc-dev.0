Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66ADC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 18:24:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE0A21841
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 18:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LFem+/N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE0A21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43brqD1rQqzDr0r
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 05:24:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+7463624bcd8ccf6d3e50+5619+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="LFem+/N1"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43brh36P2XzDqq8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 05:17:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JLpLHdTCHahq6CRna6iLuThPvU7rWXqfOAvxr0FwauE=; b=LFem+/N13BNaJy5IpQonIsHRZg
 7V0GMdcx4LscjZqG25au3AENuQRxTyyCFUXPCAoRCaLh4KHnyjJRoSP0VCDavjdMDKFh9PY5R0jFI
 L5ECkDGgB2euOZobp9LMPQZ/IEgt7zEQJw+HmSU/YjhJKMpV6s2jBxBa8dTt1fxCNnAM8XJWKP1if
 VrAqX2CLSKEgdQnXqNMoGSQ3i/xMbrC0TSOO4iNzI6675CS4p/7tMPsRSyzorFMI3cun2py1jDfa9
 1q4CjhFECZTUK+CEvS4jdCFVU/ZzgZ6KhvmvbojFBePOl+8WVzYXzi5OQh48/Cs2I4Phqxtf/NXRt
 zr/guyow==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1NK-0000zl-Ke; Fri, 11 Jan 2019 18:17:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Date: Fri, 11 Jan 2019 19:17:31 +0100
Message-Id: <20190111181731.11782-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111181731.11782-1-hch@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
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
Cc: Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

vb2_dc_get_userptr pokes into arm direct mapping details to get the
resemblance of a dma address for a a physical address that does is
not backed by a page struct.  Not only is this not portable to other
architectures with dma direct mapping offsets, but also not to uses
of IOMMUs of any kind.  Switch to the proper dma_map_resource /
dma_unmap_resource interface instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../common/videobuf2/videobuf2-dma-contig.c   | 41 ++++---------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index aff0ab7bf83d..82389aead6ed 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -439,42 +439,14 @@ static void vb2_dc_put_userptr(void *buf_priv)
 				set_page_dirty_lock(pages[i]);
 		sg_free_table(sgt);
 		kfree(sgt);
+	} else {
+		dma_unmap_resource(buf->dev, buf->dma_addr, buf->size,
+				   buf->dma_dir, 0);
 	}
 	vb2_destroy_framevec(buf->vec);
 	kfree(buf);
 }
 
-/*
- * For some kind of reserved memory there might be no struct page available,
- * so all that can be done to support such 'pages' is to try to convert
- * pfn to dma address or at the last resort just assume that
- * dma address == physical address (like it has been assumed in earlier version
- * of videobuf2-dma-contig
- */
-
-#ifdef __arch_pfn_to_dma
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return (dma_addr_t)__arch_pfn_to_dma(dev, pfn);
-}
-#elif defined(__pfn_to_bus)
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return (dma_addr_t)__pfn_to_bus(pfn);
-}
-#elif defined(__pfn_to_phys)
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return (dma_addr_t)__pfn_to_phys(pfn);
-}
-#else
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	/* really, we cannot do anything better at this point */
-	return (dma_addr_t)(pfn) << PAGE_SHIFT;
-}
-#endif
-
 static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 	unsigned long size, enum dma_data_direction dma_dir)
 {
@@ -528,7 +500,12 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 		for (i = 1; i < n_pages; i++)
 			if (nums[i-1] + 1 != nums[i])
 				goto fail_pfnvec;
-		buf->dma_addr = vb2_dc_pfn_to_dma(buf->dev, nums[0]);
+		buf->dma_addr = dma_map_resource(buf->dev,
+				__pfn_to_phys(nums[0]), size, buf->dma_dir, 0);
+		if (dma_mapping_error(buf->dev, buf->dma_addr)) {
+			ret = -ENOMEM;
+			goto fail_pfnvec;
+		}
 		goto out;
 	}
 
-- 
2.20.1

