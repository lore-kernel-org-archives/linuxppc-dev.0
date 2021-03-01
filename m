Return-Path: <SRS0=kNGO=H7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F8C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 07:48:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5991C64E3F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 07:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5991C64E3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DpspH6JvJz3dj7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 18:48:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=dcs28v1g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+bce9324c41c3486454c7+6399+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=dcs28v1g; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dpsl85nk3z3d63
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Mar 2021 18:46:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Nv2PzTFaNuvZMLFLXyjuLWvrF97az/7ZIuedCeQXxXo=; b=dcs28v1gCq97Kg7VGkzZDNtfBS
 5/Y9BWSDEFQ0ue8+GeO+pvfl9PH2Fa9smNuJM50LF1Mq+3hEEaB1VHWSyj/dcpsRTIinzTOpuTC5b
 feXtU4Are3eTutHu0jUVtlOEMlSECtX4EqblBryk1+ow7zc7Ho2mKmJuNtqugq8wrtI9IWLt5URtJ
 dtiRRCH0oKGw4/2bPQZciYOP1nmZ+lVgZRpEj8aALss9KfVEZMW/4Wav8dkCb6S8RJ4IdMSDjoWBZ
 yDBMCcgb9k+zD7C6KTqH3FoHhADuq5RVyDNDgVLKekqcZPdb4nQ04/3MhFlJfGsbra7rrfrT2bPfn
 8gl8q2lA==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGdFg-00FRDV-0p; Mon, 01 Mar 2021 07:46:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 08/14] xen-swiotlb: remove xen_io_tlb_start and
 xen_io_tlb_nslabs
Date: Mon,  1 Mar 2021 08:44:30 +0100
Message-Id: <20210301074436.919889-9-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301074436.919889-1-hch@lst.de>
References: <20210301074436.919889-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 Claire Chang <tientzu@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 Dongli Zhang <dongli.zhang@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The xen_io_tlb_start and xen_io_tlb_nslabs variables ar now only used in
xen_swiotlb_init, so replace them with local variables.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 57 +++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 5352655432e724..1a31ddf7139799 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -40,14 +40,7 @@
 
 #include <trace/events/swiotlb.h>
 #define MAX_DMA_BITS 32
-/*
- * Used to do a quick range check in swiotlb_tbl_unmap_single and
- * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
- * API.
- */
 
-static char *xen_io_tlb_start;
-static unsigned long xen_io_tlb_nslabs;
 /*
  * Quick lookup value of the bus address of the IOTLB.
  */
@@ -169,75 +162,75 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	int rc = -ENOMEM;
 	enum xen_swiotlb_err m_ret = XEN_SWIOTLB_UNKNOWN;
 	unsigned int repeat = 3;
+	char *start;
+	unsigned long nslabs;
 
-	xen_io_tlb_nslabs = swiotlb_nr_tbl();
+	nslabs = swiotlb_nr_tbl();
 retry:
-	if (!xen_io_tlb_nslabs)
-		xen_io_tlb_nslabs = DEFAULT_NSLABS;
-	bytes = xen_io_tlb_nslabs << IO_TLB_SHIFT;
+	if (!nslabs)
+		nslabs = DEFAULT_NSLABS;
+	bytes = nslabs << IO_TLB_SHIFT;
 	order = get_order(bytes);
 
 	/*
 	 * IO TLB memory already allocated. Just use it.
 	 */
-	if (io_tlb_start != 0) {
-		xen_io_tlb_start = phys_to_virt(io_tlb_start);
+	if (io_tlb_start != 0)
 		goto end;
-	}
 
 	/*
 	 * Get IO TLB memory from any location.
 	 */
 	if (early) {
-		xen_io_tlb_start = memblock_alloc(PAGE_ALIGN(bytes),
+		start = memblock_alloc(PAGE_ALIGN(bytes),
 						  PAGE_SIZE);
-		if (!xen_io_tlb_start)
+		if (!start)
 			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
 			      __func__, PAGE_ALIGN(bytes), PAGE_SIZE);
 	} else {
 #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
 		while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
-			xen_io_tlb_start = (void *)xen_get_swiotlb_free_pages(order);
-			if (xen_io_tlb_start)
+			start = (void *)xen_get_swiotlb_free_pages(order);
+			if (start)
 				break;
 			order--;
 		}
 		if (order != get_order(bytes)) {
 			pr_warn("Warning: only able to allocate %ld MB for software IO TLB\n",
 				(PAGE_SIZE << order) >> 20);
-			xen_io_tlb_nslabs = SLABS_PER_PAGE << order;
-			bytes = xen_io_tlb_nslabs << IO_TLB_SHIFT;
+			nslabs = SLABS_PER_PAGE << order;
+			bytes = nslabs << IO_TLB_SHIFT;
 		}
 	}
-	if (!xen_io_tlb_start) {
+	if (!start) {
 		m_ret = XEN_SWIOTLB_ENOMEM;
 		goto error;
 	}
 	/*
 	 * And replace that memory with pages under 4GB.
 	 */
-	rc = xen_swiotlb_fixup(xen_io_tlb_start,
+	rc = xen_swiotlb_fixup(start,
 			       bytes,
-			       xen_io_tlb_nslabs);
+			       nslabs);
 	if (rc) {
 		if (early)
-			memblock_free(__pa(xen_io_tlb_start),
+			memblock_free(__pa(start),
 				      PAGE_ALIGN(bytes));
 		else {
-			free_pages((unsigned long)xen_io_tlb_start, order);
-			xen_io_tlb_start = NULL;
+			free_pages((unsigned long)start, order);
+			start = NULL;
 		}
 		m_ret = XEN_SWIOTLB_EFIXUP;
 		goto error;
 	}
 	if (early) {
-		if (swiotlb_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs,
+		if (swiotlb_init_with_tbl(start, nslabs,
 			 verbose))
 			panic("Cannot allocate SWIOTLB buffer");
 		rc = 0;
 	} else
-		rc = swiotlb_late_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs);
+		rc = swiotlb_late_init_with_tbl(start, nslabs);
 
 end:
 	if (!rc)
@@ -246,17 +239,17 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	return rc;
 error:
 	if (repeat--) {
-		xen_io_tlb_nslabs = max(1024UL, /* Min is 2MB */
-					(xen_io_tlb_nslabs >> 1));
+		nslabs = max(1024UL, /* Min is 2MB */
+					(nslabs >> 1));
 		pr_info("Lowering to %luMB\n",
-			(xen_io_tlb_nslabs << IO_TLB_SHIFT) >> 20);
+			(nslabs << IO_TLB_SHIFT) >> 20);
 		goto retry;
 	}
 	pr_err("%s (rc:%d)\n", xen_swiotlb_error(m_ret), rc);
 	if (early)
 		panic("%s (rc:%d)", xen_swiotlb_error(m_ret), rc);
 	else
-		free_pages((unsigned long)xen_io_tlb_start, order);
+		free_pages((unsigned long)start, order);
 	return rc;
 }
 
-- 
2.29.2

