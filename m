Return-Path: <SRS0=VNWk=56=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77129C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 14:47:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7C520936
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 14:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KmMeUj3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7C520936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491pH26jmZzDqkc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 00:47:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+4a22011dcb1da0b09bf4+6078+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=KmMeUj3M; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491mFS0KVvzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2020 23:15:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=St6pI1zBFt7Bf4M5c9QT48qGrtLj/1D4E7IIJW6gPyw=; b=KmMeUj3MnDZJQG3q0UIbLIqe54
 +f5wB1SXlUTJUKGJxN+9GtxE1XijgFKmopyh1BNHGbZavM38F7wJj3WhSHCaFO5E9+Qh5F5qnBzvg
 HoXBOsCcwFfTx02AZsEX9O42q4j17e3SeRODiQXDl2RM3liEcJvSXiIGyyE1xldwcX/TqQOHX7H1U
 zrDkEkgs4fa8Tr+JqWK+Q5S+mN1pmGKCx60X9HXSC/oibzQpM5isEVknCi5c6x2oJExW+aZNPp/VB
 RGCaLRizOR6Dl3bbJ/WsN7NLyx/0dmIB6pDtlVe+p5Qh0cdNk/an6d8KogUsMj/j3usSpbssW5gzi
 TKlDPgRw==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOLPK-00010M-Az; Tue, 14 Apr 2020 13:15:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 x86@kernel.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Subject: [PATCH 25/29] mm: switch the test_vmalloc module to use __vmalloc_node
Date: Tue, 14 Apr 2020 15:13:44 +0200
Message-Id: <20200414131348.444715-26-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, bpf@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

No need to export the very low-level __vmalloc_node_range when the
test module can use a slightly higher level variant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/test_vmalloc.c | 26 +++++++-------------------
 mm/vmalloc.c       | 17 ++++++++---------
 2 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 8bbefcaddfe8..cd6aef05dfb4 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -91,12 +91,8 @@ static int random_size_align_alloc_test(void)
 		 */
 		size = ((rnd % 10) + 1) * PAGE_SIZE;
 
-		ptr = __vmalloc_node_range(size, align,
-		   VMALLOC_START, VMALLOC_END,
-		   GFP_KERNEL | __GFP_ZERO,
-		   PAGE_KERNEL,
-		   0, 0, __builtin_return_address(0));
-
+		ptr = __vmalloc_node(size, align, GFP_KERNEL | __GFP_ZERO,
+				__builtin_return_address(0));
 		if (!ptr)
 			return -1;
 
@@ -118,12 +114,8 @@ static int align_shift_alloc_test(void)
 	for (i = 0; i < BITS_PER_LONG; i++) {
 		align = ((unsigned long) 1) << i;
 
-		ptr = __vmalloc_node_range(PAGE_SIZE, align,
-			VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL | __GFP_ZERO,
-			PAGE_KERNEL,
-			0, 0, __builtin_return_address(0));
-
+		ptr = __vmalloc_node(PAGE_SIZE, align, GFP_KERNEL | __GFP_ZERO,
+				__builtin_return_address(0));
 		if (!ptr)
 			return -1;
 
@@ -139,13 +131,9 @@ static int fix_align_alloc_test(void)
 	int i;
 
 	for (i = 0; i < test_loop_count; i++) {
-		ptr = __vmalloc_node_range(5 * PAGE_SIZE,
-			THREAD_ALIGN << 1,
-			VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL | __GFP_ZERO,
-			PAGE_KERNEL,
-			0, 0, __builtin_return_address(0));
-
+		ptr = __vmalloc_node(5 * PAGE_SIZE, THREAD_ALIGN << 1,
+				GFP_KERNEL | __GFP_ZERO,
+				__builtin_return_address(0));
 		if (!ptr)
 			return -1;
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ae8249ef5821..333fbe77255a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2522,15 +2522,6 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return NULL;
 }
 
-/*
- * This is only for performance analysis of vmalloc and stress purpose.
- * It is required by vmalloc test module, therefore do not use it other
- * than that.
- */
-#ifdef CONFIG_TEST_VMALLOC_MODULE
-EXPORT_SYMBOL_GPL(__vmalloc_node_range);
-#endif
-
 /**
  * __vmalloc_node - allocate virtually contiguous memory
  * @size:	    allocation size
@@ -2556,6 +2547,14 @@ void *__vmalloc_node(unsigned long size, unsigned long align,
 	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
 				gfp_mask, PAGE_KERNEL, 0, node, caller);
 }
+/*
+ * This is only for performance analysis of vmalloc and stress purpose.
+ * It is required by vmalloc test module, therefore do not use it other
+ * than that.
+ */
+#ifdef CONFIG_TEST_VMALLOC_MODULE
+EXPORT_SYMBOL_GPL(__vmalloc_node);
+#endif
 
 void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 {
-- 
2.25.1

