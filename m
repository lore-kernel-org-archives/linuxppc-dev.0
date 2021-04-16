Return-Path: <SRS0=vApQ=JN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6E8C433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 23:09:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65408610CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 23:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65408610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FMX300wqGz3c1m
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 09:09:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=YmfVnEk3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=YmfVnEk3; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FMX2J4rDWz3c9g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Apr 2021 09:08:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=7RQQOKlZfptY8lQfv4l5MN8bW99nIhpZAUjYQWKjbHY=; b=YmfVnEk3XiuEP8jmPep/KMKTCm
 FCer4kctEbk/+GNHuBZ8YFNrdKU44xlcl41J+bNFEc53pi74cE5/BLRbsjHC4f8PKiEVIVwlUAR7t
 Z55+HNT/99N2xVNKwp+BxJDdxbFavbZStT6ml+LiqeSScnyJEGjUY1qv3vZy9XpWik8pDr0R3u9mr
 YZpRlXaZY6zK/e2aevHlOS8hCwxYF9T5hfqXwKOxLAXe4vi1AER+8AHlbktawk4qufHp5LqztQe62
 fJGCts2hlsjYoXQcLvgSA+p/Z2uMF0IYb8xmYDmqAjunEiQdpXqkeM7qmy56jDoYHdcHnWv1GagYl
 bqoyQWlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lXXYn-00AZOP-Kg; Fri, 16 Apr 2021 23:07:43 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: brouer@redhat.com
Subject: [PATCH 2/2] mm: Indicate pfmemalloc pages in compound_head
Date: Sat, 17 Apr 2021 00:07:24 +0100
Message-Id: <20210416230724.2519198-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210416230724.2519198-1-willy@infradead.org>
References: <20210416230724.2519198-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: arnd@kernel.org, grygorii.strashko@ti.com, netdev@vger.kernel.org,
 ilias.apalodimas@linaro.org, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, linux-mips@vger.kernel.org,
 mhocko@kernel.org, linux-mm@kvack.org, mgorman@suse.de,
 mcroce@linux.microsoft.com, linux-snps-arc@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The net page_pool wants to use a magic value to identify page pool pages.
The best place to put it is in the first word where it can be clearly a
non-pointer value.  That means shifting dma_addr up to alias with ->index,
which means we need to find another way to indicate page_is_pfmemalloc().
Since page_pool doesn't want to set its magic value on pages which are
pfmemalloc, we can use bit 1 of compound_head to indicate that the page
came from the memory reserves.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       | 12 +++++++-----
 include/linux/mm_types.h |  7 +++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ba434287387..44eab3f6d5ae 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1629,10 +1629,12 @@ struct address_space *page_mapping_file(struct page *page);
 static inline bool page_is_pfmemalloc(const struct page *page)
 {
 	/*
-	 * Page index cannot be this large so this must be
-	 * a pfmemalloc page.
+	 * This is not a tail page; compound_head of a head page is unused
+	 * at return from the page allocator, and will be overwritten
+	 * by callers who do not care whether the page came from the
+	 * reserves.
 	 */
-	return page->index == -1UL;
+	return page->compound_head & 2;
 }
 
 /*
@@ -1641,12 +1643,12 @@ static inline bool page_is_pfmemalloc(const struct page *page)
  */
 static inline void set_page_pfmemalloc(struct page *page)
 {
-	page->index = -1UL;
+	page->compound_head = 2;
 }
 
 static inline void clear_page_pfmemalloc(struct page *page)
 {
-	page->index = 0;
+	page->compound_head = 0;
 }
 
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c10a45..39f7163dcace 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -96,10 +96,9 @@ struct page {
 			unsigned long private;
 		};
 		struct {	/* page_pool used by netstack */
-			/**
-			 * @dma_addr: might require a 64-bit value on
-			 * 32-bit architectures.
-			 */
+			unsigned long pp_magic;
+			unsigned long xmi;
+			unsigned long _pp_mapping_pad;
 			unsigned long dma_addr[2];
 		};
 		struct {	/* slab, slob and slub */
-- 
2.30.2

