Return-Path: <linuxppc-dev+bounces-27186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A5BC88E56
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 08:40:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjMDX67hdz30RN;
	Sun, 13 Sep 2026 18:40:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789288828;
	cv=none; b=NHH57EuJAOa4aAosPtybBpdAm0NMqmgGK7dbC9DtzgqGM366y/NX4C4+0LnCzPk3OYGWr+1a1J6iLXGxJuPzdd+t2W/YuOnyQUta8QOWD7Jme8TayYHtmCUrX1Rt1oJAOuIf1VaTXNYgNi+HGdMZRPx5BhCvsYSvZpANJO9lmItixV17Tud2/TCYAxgt52YJKhePPPx6AtcjiE+t+FKTS1m7RVPQwgn/WiGXz0SS6X9dSV5Cv/UNforjRBvoJYcM8m95TqISePj/4CE3mdZUYUTsQYT8+quYanms9UGa5OXf/HzdnnLP+voSpgZZcGTHbbSA+zHlF0p6Gkiqpf5kCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789288828; c=relaxed/relaxed;
	bh=eFsIa9cK+8+fehtCpbOiW01jVXax8X3u6/tt3T4Yifc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWmL7UZRwVo1rOHksyCzzlsTNp5PqNVvn3Gn1KrvUZiyHvJeUY15Q1t1ZSOhk7Lnpa91A/SCQ+z6wZSIcg+gSd2mIVMKisHnri/WtmvAJVM50GkolBRr0mj8xfVxCuE6EG7SaiCnOfHiM5uc6ZUNLnOyYdL9fFnsKsAWx6dLlkY4A7km2LRF4Q02eQpfJr1Zn2JKk3VZdYZiojLX9ie5knkTzeLhuyn4WH38WqbBNkogvnbBXl2Q0YJD/Jt/rmUxDqcE4vvsft7NaO9BHA55nf9IYdjiA7M3x0v4iBzBprINIWod6fXbEGPzfJw0HMlohx08s6SyqJeXabthi2KxXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eVvy5Ta8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eVvy5Ta8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjMDX1H0Kz2xft
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 18:40:28 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1602972b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789288826; x=1789893626; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFsIa9cK+8+fehtCpbOiW01jVXax8X3u6/tt3T4Yifc=;
        b=eVvy5Ta8g8j+3xY6/B0EtOVdbhCbzwTzlDUijFYmymg+sF3cC9gvLkTRvo/MgzldwF
         xOXA3H2QXdbuZhx08YxPwKxAJg/XvkFNb6o1mJsFrqFyWvQP3oImbDO69U8kTzcz4M+K
         95sXp/g7OZPAKBVJKy99OGh7B0WU8ssajXgbi6midFPY+J/xtMyl8atdE3dZ7jEfz0LS
         1mHjSqj5KwgoG8iUtTEC1JPXzkq990CCb6Jl1Pwu0Zw2kA/q+HrLx9qYd7xbYqB3qfCW
         cOimEzmIxJ90mXjiJe6SYIuf7IAEQmiNJAGL4UY7YQ1O04nDrv0STRyToP/n0q5ZGkv+
         JSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789288826; x=1789893626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eFsIa9cK+8+fehtCpbOiW01jVXax8X3u6/tt3T4Yifc=;
        b=pLnZprak9FCMzHEvcn1K2yh63YTYbZaSQyFJaUUPHhCM5l4Av9/1W981aK+NSLGjou
         C/sR/FyXufFiFTHp0eaEN+nfvnwkWxg4rQvuU+c8TdB9JxSGGVv/68nmm7IGJX966igo
         3ByftxDfqNO0caMtMkEZbxM7bbeLlK7zr3iZ3fz/8rH35ENwOwAgYhL4Ehu4u6Hs7ffU
         Rkgc8hoUaHzw4Qd7xRz2QvLIx+vwYNZ2NyszS+ZmHVMq9RF1mq3Yr9mT8Na3h0NTadSY
         9fIyKNm1oQBu8v2mDbgETVugX0bvmuMFPZEwIUzyk2Y6LFy6P/yT6q6qYZGcS3XrqBhG
         Mc7w==
X-Forwarded-Encrypted: i=1; AKwUvBwqoQlkJiJmu8YXgIlmJTgsXLfzMWcUnKKPF3/AIeA+zeorzn84gK1e0maggZVN/9n1EWRmUL6qT8tRLzE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nCgXOBd0cCQmxFrY57q1RbmWY9+ieh8+VVNCUW38Sl2IIOs7pQ
	5QOslOrYAFYTx48Q+UpuGcBown/3V/nMGi0nAarsoaWwZ8M5gKLqwvvkZwSOs5Iv2b8=
X-Gm-Gg: AYBFou2ZrFJGqWvgLsr2QurtQ9zO/Z/nqlgLb/28N1spFvBfvLZi012CO0L+FwOroTR
	ZnheDM21sbodML4ImxTmEXNEbVDy3dNO/5+1H9hekwN7KVUSTufchOZi+BOHJ0MdzMq/muuoYmF
	QZPho9hlXr8flZFYAUEq7zZEzZeLhJa0YFBmaOQjStDIb1o0tfrwBUxCrJt6hAdFsyNjsJfz/z9
	OHVc8LIoZ5dLywZnULsrFIisOnM/aUpC/SFCC05cKG2MtxDqdNhkwDaFzCqxUmeER12f9gmZhXO
	I75dihwjSEjVGf39UTMEtJ2v4lUq2L/IfqGWfu1W8XBL2JK9R/6Mh0eGfSIKEGfBlCrraDbPjY8
	ihFeGdV3nSorEYSUfbid3VI5TJhVGr/L6cbN3V26OdOJvezeRW9TDLuuX/XTakeS7ngpmChNhXb
	upkDDcEo/ZiN5z8xB0U3j4w4wvXCJ/c16gLMbzC4fXO0Ywb8GNEmpZRKYAXNLuKHNE+ZDKzDGUW
	N/lN4BhqasObyYdV/7u3m6t1oo=
X-Received: by 2002:a05:6a00:148d:b0:848:6c9c:4074 with SMTP id d2e1a72fcca58-86b30413328mr18406280b3a.1.1789288825870;
        Sun, 13 Sep 2026 01:40:25 -0700 (PDT)
Received: from G6L4RL2QG9 ([2409:8a00:1832:cf0:5137:990:100e:cc7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb0d3sm3070531b3a.42.2026.09.13.01.40.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 01:40:25 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH 1/6] mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
Date: Sun, 13 Sep 2026 16:37:29 +0800
Message-ID: <20260913083734.86802-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260913083734.86802-1-songmuchun@bytedance.com>
References: <20260913083734.86802-1-songmuchun@bytedance.com>
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

VMEMMAP_POPULATE_DAX currently distinguishes DAX vmemmap population in two
places: it keeps allocations on the normal path and takes a reference when
a backing page is supplied for reuse.

After Device DAX switched to the common per-zone shared tail page, both
conditions can be determined locally. DAX supplies ptpfn for every shared
tail mapping and requests an allocation only for compound head mappings,
whose PFNs are not optimizable. Therefore, vmemmap_optimizable_pfn() alone
selects the correct allocation path.

When ptpfn is supplied, the caller is reusing an existing backing page.
Once the slab allocator is available, take a reference for each reused
mapping to balance the release performed by vmemmap_free(). Early mappings
are backed by memblock/reserved memory and do not need page reference
accounting.

Remove VMEMMAP_POPULATE_DAX and the flags argument from the vmemmap
population helpers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 96506f594924..878d29a4e862 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -32,12 +32,6 @@
 #include <asm/dma.h>
 #include <asm/tlbflush.h>
 
-/*
- * Flags for vmemmap_populate_range and friends.
- */
-/* Vmemmap population for ZONE_DEVICE compound pages */
-#define VMEMMAP_POPULATE_DAX		0x0001
-
 #include "internal.h"
 #include "mm_init.h"
 #include "sparse.h"
@@ -208,7 +202,7 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 }
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-		struct vmem_altmap *altmap, unsigned long flags)
+		struct vmem_altmap *altmap)
 {
 	struct zone *zone;
 	struct page *page;
@@ -218,7 +212,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 	 * Device DAX still relies on vmemmap_populate_compound_pages() for
 	 * head/first-tail allocation and tail-page reuse.
 	 */
-	if (!vmemmap_optimizable_pfn(pfn) || flags & VMEMMAP_POPULATE_DAX)
+	if (!vmemmap_optimizable_pfn(pfn))
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 	zone = pfn_to_zone(pfn, node);
@@ -230,8 +224,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-				       struct vmem_altmap *altmap,
-				       unsigned long ptpfn, unsigned long flags)
+		struct vmem_altmap *altmap, unsigned long ptpfn)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	unsigned long pfn = page_to_pfn((struct page *)addr);
@@ -240,7 +233,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		pte_t entry;
 
 		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap, flags);
+			void *p = vmemmap_alloc_pte(pfn, node, altmap);
 
 			if (!p)
 				return NULL;
@@ -255,7 +248,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
 			 */
-			if (flags & VMEMMAP_POPULATE_DAX)
+			if (slab_is_available())
 				get_page(pfn_to_page(ptpfn));
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
@@ -318,8 +311,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn,
-					      unsigned long flags)
+					      unsigned long ptpfn)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -339,7 +331,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn, flags);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -350,15 +342,14 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 static int __meminit vmemmap_populate_range(unsigned long start,
 					    unsigned long end, int node,
 					    struct vmem_altmap *altmap,
-					    unsigned long ptpfn,
-					    unsigned long flags)
+					    unsigned long ptpfn)
 {
 	unsigned long addr = start;
 	pte_t *pte;
 
 	for (; addr < end; addr += PAGE_SIZE) {
 		pte = vmemmap_populate_address(addr, node, altmap,
-					       ptpfn, flags);
+					       ptpfn);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -369,7 +360,7 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
+	return vmemmap_populate_range(start, end, node, altmap, -1);
 }
 
 /*
@@ -498,7 +489,6 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
-	unsigned long flags = VMEMMAP_POPULATE_DAX;
 	struct page *page;
 	unsigned int order = pfn_to_section_compound_order(start_pfn);
 
@@ -508,14 +498,14 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 
 	if (reuse_compound_section(start_pfn, pgmap))
 		return vmemmap_populate_range(start, end, node, NULL,
-					      page_to_pfn(page), flags);
+					      page_to_pfn(page));
 
 	size = min(end - start, (1UL << order) * sizeof(struct page));
 	for (addr = start; addr < end; addr += size) {
 		unsigned long next, last = addr + size;
 
 		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1, flags);
+		pte = vmemmap_populate_address(addr, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 
@@ -525,7 +515,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 */
 		next = addr + PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    page_to_pfn(page), flags);
+					    page_to_pfn(page));
 		if (rc)
 			return -ENOMEM;
 	}
-- 
2.54.0


