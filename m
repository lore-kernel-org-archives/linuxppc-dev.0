Return-Path: <linuxppc-dev+bounces-28565-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70579CA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:08:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxhf01gbz3017;
	Thu, 01 Oct 2026 00:08:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777281;
	cv=none; b=OWcK0iA/x0ZvxHbwsHiRSSYEs7H8ItMKOoW8A1QWqY7Ui314jZrnGozJouu5JNG2sWjjYbXI4OIEJHJi5hFCXIyIqcX+tZXc7omSCfGOzH+MTGgZWpEIiKXtksiCpbEKNtNf++VI0iEpmnRVW0RPSa25tsymvF46xMyQq3GP8YTV07aFUxG08fKS6LXBBKGYgag0qn6Pez+4CWD7GNSoQ+bjA3aIHTeTK6NavJgye2IEW3py/2VctEkia5taSM+xk6cBjTeuB/CUKbzMlqsmoubGrehuhQJHXqVxu1FP5qalYDGSY0aKNAiqI15GP9lCyr+c6Fht5jqlCeBlyy1CLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777281; c=relaxed/relaxed;
	bh=SfMxtfxa+3COrIjgzxsQNjSW0BqNRs0OC1S2RzR7Pys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3lO+nLMzeZ9zVqc7qFGIzoKP5dWwpXmrj0JIyMiQQSpQOKh6NINP+ZEMT+AiSlX9LfvKho4ZBThoDBt0bCmd7CWj9Hq35ZBRDQr2RzPHupISJX5OqPXzCHwy2kli/RVrcIDxY8zDs6k6yByAmafomR3QmSQX5aFZ/77/HU2fP/D/Zxw8K9/HFV4qtqPjW7RxbqBZNyXwOGKeO+H2qY7jr3xW6sJBrB/YTh0FVu9a4zDmJNpplJVkIb6mxfz4grn4HM7F1W1DjVptSOhHxbHfdJckLU7FDNjrfzG7oAryeaxHVO2pdASdNRDfj+FQYHXIngmtbhtfIQOOIkaGZQOAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=U0fI9aL8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=U0fI9aL8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxhd2jwTz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:08:01 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so2399286a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777279; x=1791382079; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfMxtfxa+3COrIjgzxsQNjSW0BqNRs0OC1S2RzR7Pys=;
        b=U0fI9aL8uORWqAGCRKtjly2VtZMXmyymWyakH8+KIsmoS7UcKpVhqTkZ/bDf+JdIi1
         Y2p9Hk2CwHrw/aMvTbn2tvLPs3KgKzKzdnE4I2swHImlVS52Bl/8/GFyYCsUVpHIniWz
         lZhu0b4nlziiOKc7b9Al2Gy25VeUQwmiUDkxF6UDfiHmm2n20hk/1/HteoWlMx2va29l
         e3/8tYgo1louSNQcUzp6kYBffADeufRB6tLiWWeomrqVTCkqEePSgzOI79WoxHO1uXRm
         tUPvbCDMVrJSvfGEj0tdFa2+d/nNk76Xlap1kYaObVX6xrllg4WIiHhTF2l+P4lUspBC
         Apog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777279; x=1791382079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SfMxtfxa+3COrIjgzxsQNjSW0BqNRs0OC1S2RzR7Pys=;
        b=2o8q79RBUBLkYHoy5OPyPCvVcbVMHTRPG8cp6GtwH/B9iMwJP8EzlzC7EWVa/mPOun
         ilhE9omUiIkeXx9C0u90gIdhiL6vjC+lX/xK5uhNewbr8aSIm5Og/XE8YZsEYy1yBROi
         qCE07Q+mF3kH2ci28muPxVjjU9GPAcHA7iuWG10aB5qG+ZTj42qKv/M8XI83GJdP6fLQ
         kPHhsriQ2wPoYvE2jZeMhKBSNXHnLgCRNn5+CWizpIr4r4OqDRtF29TkYP51efxX3wor
         g9EjjpSDqxl7CD5/OEOT/v4wuQmodgyDJqJJnH4qddoPUumRZ5SKSzTta1hNZWbBg/5N
         FktA==
X-Forwarded-Encrypted: i=1; AKwUvBw7ZE/fgMNnunqxUPyQKGl4XguCipJtJ3aTTWDCFTYUXl5Dauc7bnJVe0m/47c6Rhbmrc6xebGu1twjL24=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIyxX9qpW1LFlyIwTcQEDezlOF/CzeJmHMgqSem4PN5teUB2h/N
	5eNkBPUqLNNhJIVZ3WVD0nDmatFm6bowlC89otPDYslPsWBB5QPXrF1wBtBI5R2umnE=
X-Gm-Gg: AYBFou3lU8lUEBRLis5PNrvLB6PvYHCcZHqjRUpPuwuCA5FagvZapOlahZbsbNkzJyo
	j7eWMC8E1apwUyOoSiL8k6HuVXLCmaCYHkPHCFeRCB9fKYkY3gSuOHip34NZYdrKCzl67t58s4D
	H1rEHyCWEHrdCFXOIZBlA05G481N9E078pN9aew0bUcZd0dAg8pGVdGs1wp564GHZmCD7E9E7Td
	5LPpp+d8wGiu3ZmWzQXd3mPOl1/05mgQEXLBNdZEv4XYcFWaxTtnj5n+ktDSX1rlpYrS2OQZV+k
	gUmY00EWegF8xt2kN/2k9kgaTk9Ltom2ueDIrYsTJ6AvoVPHFqBLFAAdANDCuZuOLFqatEffBx/
	FkxuLstuPYuAXxpTfUpAY5GM5/Q1afEdW7JpzL8aYifgoGRQ9rPECYdEPViewJCRU2/yrt9t2QY
	f4umeTuGfba8Hq22A1qAA4gawGC5IergW5bVJDKoNbl9lx6B8OIeXdZcTYQW0e9HCtCrEPWXv72
	D0RRA5c/ChVqA==
X-Received: by 2002:a17:90b:4acf:b0:39e:4c7f:8b1b with SMTP id 98e67ed59e1d1-3a4d19d23e4mr1306484a91.32.1790777279220;
        Wed, 30 Sep 2026 07:07:59 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.07.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:07:58 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v6 05/12] mm/sparse-vmemmap: prepare DAX vmemmap population for compound page orders
Date: Wed, 30 Sep 2026 22:06:20 +0800
Message-ID: <20260930140627.57431-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930140627.57431-1-songmuchun@bytedance.com>
References: <20260930140627.57431-1-songmuchun@bytedance.com>
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

Device DAX still uses vmemmap_populate_compound_pages() to populate its
compound-page vmemmap mappings. That helper allocates the head and first
tail vmemmap pages explicitly, then reuses the first tail page for the
remaining tail page mappings.

Device DAX is being moved to the section-based vmemmap optimization
infrastructure, but it cannot switch to the generic section-based
population path yet. Once a later patch records the DAX compound page
order in section metadata, DAX head and first-tail PFNs can look
optimizable to the generic helpers as well.

Rename the existing VMEMMAP_POPULATE_PAGEREF flag to
VMEMMAP_POPULATE_DAX and pass it through all paths in
vmemmap_populate_compound_pages() during this transition. This keeps DAX
head/first-tail allocations on the normal vmemmap allocation path, while
preserving the existing page reference for reused DAX tail mappings.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v6:
- Clarify that the DAX flag is renamed and used on additional paths
  (suggested by David Hildenbrand)
- Make flags const and move it to the top of the function (suggested by
  David Hildenbrand)

v3:
- Update the subject and commit message to use compound page order
  terminology

v2:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f77e6e1e5a8b..b4b72f233bf6 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -35,8 +35,8 @@
 /*
  * Flags for vmemmap_populate_range and friends.
  */
-/* Get a ref on the head page struct page, for ZONE_DEVICE compound pages */
-#define VMEMMAP_POPULATE_PAGEREF	0x0001
+/* Vmemmap population for ZONE_DEVICE compound pages */
+#define VMEMMAP_POPULATE_DAX		0x0001
 
 #include "internal.h"
 #include "mm_init.h"
@@ -247,13 +247,17 @@ static inline struct page *vmemmap_shared_tail_page(unsigned int order,
 #endif
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-					 struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, unsigned long flags)
 {
 	struct zone *zone;
 	struct page *page;
 	const unsigned int order = pfn_to_section_compound_order(pfn);
 
-	if (!vmemmap_optimizable_pfn(pfn))
+	/*
+	 * Device DAX still relies on vmemmap_populate_compound_pages() for
+	 * head/first-tail allocation and tail-page reuse.
+	 */
+	if (!vmemmap_optimizable_pfn(pfn) || flags & VMEMMAP_POPULATE_DAX)
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 	zone = pfn_to_zone(pfn, node);
@@ -275,7 +279,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		pte_t entry;
 
 		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap);
+			void *p = vmemmap_alloc_pte(pfn, node, altmap, flags);
 
 			if (!p)
 				return NULL;
@@ -290,7 +294,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
 			 */
-			if (flags & VMEMMAP_POPULATE_PAGEREF)
+			if (flags & VMEMMAP_POPULATE_DAX)
 				get_page(pfn_to_page(ptpfn));
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
@@ -547,6 +551,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 						     unsigned long end, int node,
 						     struct dev_pagemap *pgmap)
 {
+	const unsigned long flags = VMEMMAP_POPULATE_DAX;
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
@@ -561,8 +566,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 * with just tail struct pages.
 		 */
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)),
-					      VMEMMAP_POPULATE_PAGEREF);
+					      pte_pfn(ptep_get(pte)), flags);
 	}
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
@@ -570,13 +574,13 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		unsigned long next, last = addr + size;
 
 		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(addr, node, NULL, -1, flags);
 		if (!pte)
 			return -ENOMEM;
 
 		/* Populate the tail pages vmemmap page */
 		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, -1, 0);
+		pte = vmemmap_populate_address(next, node, NULL, -1, flags);
 		if (!pte)
 			return -ENOMEM;
 
@@ -586,8 +590,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_pfn(ptep_get(pte)),
-					    VMEMMAP_POPULATE_PAGEREF);
+					    pte_pfn(ptep_get(pte)), flags);
 		if (rc)
 			return -ENOMEM;
 	}
-- 
2.54.0


