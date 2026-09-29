Return-Path: <linuxppc-dev+bounces-28440-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2E5C9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:33:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv6KB3rkvz30WX;
	Tue, 29 Sep 2026 15:33:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::26"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790659998;
	cv=none; b=NCQ17b5V1+Cxfmt5ZK2v1Ojwet25tjvm+PhQruIWLd1b+8RDCZCywg2v8yuoAGCg3871P9lnBju8xUi5np8FMQvf/eBKau35srqSmhABra3NjEWa1lFBvNO4zyMLs19lcFxlogip5SzGwDLfRzbd1v16H67+Wvffix3ohzt5muNJCSXkLuK6fIcXlImlzT15+5cVU0P7+2pltMT9xRdtiUdhsSocTpgx8mJju8PgiDTJVENnSCjf3NpGEQkV2/Jawsf7VqunM+8izccCEBpCUWmdWVdA18/AfNlE6XFvb4W/kUdKEoeYPP06r39xneNVP3sWcPdmW2obYG9zXP8CYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790659998; c=relaxed/relaxed;
	bh=58VRsumoisic/ifQBSVplSYobqhWBYVn5fC/uIc+7J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxPfUlqyO8TKgzVsg8/njg0BwvAnpHneRRzI7IuVGJga88mNeUHRqB+isj5B4m8WpcQVEBfn58ICfk4kS+SepfOqbXBz/hPG7pHfM5/DC9iEW5sgKdokvX/wZw8eIo3YolN2/FrZ1hF0AysQXaHfs0ca+la39Bt9NJ92opJ3/XXVY8TLwaDjwnubcl4jNdlfzyBrbsR87IWn7zZtEG/RJNtuNQop4Jx6t5H3dncEGi454wQge/tPxgk4+U/HyVDc3pPQCYXO8/koA4BTQjlcI/XQ+EDKfYUMkK4LgLA6D0CIDijarvkrsOA29/ZV4fW2yGDhJdM9F/9xQ9rm0x39jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=G65WreUl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::26; helo=mail-pj2-x26.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=G65WreUl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::26; helo=mail-pj2-x26.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x26.google.com (mail-pj2-x26.google.com [IPv6:2607:f8b0:4864:39::26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv6K95vw5z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 15:33:17 +1000 (AEST)
Received: by mail-pj2-x26.google.com with SMTP id d9443c01a7336-2d747eb79f7so16985685ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 22:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790659996; x=1791264796; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58VRsumoisic/ifQBSVplSYobqhWBYVn5fC/uIc+7J4=;
        b=G65WreUlUHKHQRc38rlV0B8sJ3GAHmBVdFJmtTi+ro92HmKJYCXq1kZUF06icIJ7Dj
         VPlFJFgwtx8ivOXe7Tjrn/dZzoLYUH0QDtS7P5Y93oJ46E9fTj3x2epsKaDfiLN/AzDA
         FPvCOA7+TdwjdsmQHQj5CljLeVER6WFMDeTCgjCepKDUe+4ckitm67J1hD7hwRecuAxQ
         EcnZ+YesOxni+aeZfoP27XsSKlXwXWePHKgjD/sdveHYQu4g+MYTRg8iR9ZKgH3T5/oW
         cN4c54Ls7VMjuu5JxUU7kkglTS4AnEc/1AP+ACaRXeJ7DdNXf9oyzcfw26+c3GzkthXL
         iLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790659996; x=1791264796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=58VRsumoisic/ifQBSVplSYobqhWBYVn5fC/uIc+7J4=;
        b=y102UWQJKm4E7Y3Omj+PYToy+ZxewI6FmjzrwHr3+Il6uOMCxhegCnp5vlDPFeeApz
         PNOfnzIG7NWmFCvNA9vT/xzq66CseViqMbQhQ6gxbS+7i2KKsjs6LfwAaK6KRJNZ0JD1
         0sYp3ZagT5RDHOQNm+529wba0rDRze69hVo670jFTceuYl5TvvCw9u+2omUVbBhl27X9
         08TDnflfYSvJB0tdG7PpSTlNeI8kIBg80elN1zvIuYawWGHCjYE75Ldn7re2DZqfUSRi
         h6ShIhxA8cOVXoafSgh4HhPWlgVG7/HsIynVF+efWyWupV/YiDtp658IQTgEEMR8TR/0
         B5mA==
X-Forwarded-Encrypted: i=1; AKwUvBxHZSSELTp2c7gr0YYjpxDK1TekbYdWlzVPsMgao6i1VDXThIz5wlX6LYFvqG+TLz+zDn3izs88NqM3Ivo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK4iIYMp9ZqnltVZUhAK3laV6ZEHOFvks0N6l0PoFfbLJEMj0cp
	YtPpHMRKilr2QW9y5oS0IAPUqOos0zRX/Q86bdpuz/rusHlYi9SfeBSK1aRvbnggR1w=
X-Gm-Gg: AYBFou2yWcVI/nAmp6jeclLzRciHp1AFEtGyn3oFrI3l+qbkpPxL3HFvYbxLG11inH/
	mlXivnpsBPX6b5xhggrrBdlsBX33Urh9aY3XTSFTEQ9s3PF1pkevlHbUUf04KNoeUlTptYjCp7a
	ieoZ6aqD6Ab13jC7sDxojlb3gxua87AWRFuzth59FIzc9MXR17cMe1wL7vrgPsg2VQrD1UNTWFM
	OKpo3IJz7YG9IdISJ+VSM5vcS0Jr5K4lU+reBgNJ8EC0/f4KzoEK1N9pYUcd+hdrubp4QkOK4O9
	l3rBOB6+m3J0PL+1G2xn/cZS70EJkcw2uye7iEL4EUYn3tyb3B76fIwZtl12aJunkJd6wZ6TaHa
	cZRilgw+KBv8QLpH7sSS8Wg6JTP0/igmNdWArDzglKqV+CWlOmdqI86JwygC6U7wlgFeCuGqBQK
	FTNa5FAUQGMVvwaDWSnrMexnNrcldXcnwy7N4e/lvdilh+8gAN7rNGwc/hyTckZIIzBqm5q+yIl
	n5+53HC9sm+gf9xWCc=
X-Received: by 2002:a17:902:db06:b0:2e2:c84b:43e9 with SMTP id d9443c01a7336-2e2c84b48d6mr11044645ad.1.1790659995651;
        Mon, 28 Sep 2026 22:33:15 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm49251765ad.51.2026.09.28.22.33.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 22:33:15 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
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
Subject: [PATCH v3 1/6] mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
Date: Tue, 29 Sep 2026 13:32:26 +0800
Message-ID: <20260929053231.66085-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929053231.66085-1-songmuchun@bytedance.com>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
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

VMEMMAP_POPULATE_DAX currently distinguishes DAX vmemmap population in
two places: it keeps allocations on the normal path and takes a reference
when a backing page is supplied for reuse.

After Device DAX switched to the common per-zone shared tail page, both
conditions can be determined locally. DAX supplies ptpfn for every shared
tail mapping and requests an allocation only for compound head mappings,
whose PFNs are not optimizable. Therefore, vmemmap_optimizable_pfn() alone
selects the correct allocation path.

When ptpfn is supplied, the caller is reusing an existing backing page.
Once the slab allocator is available, take a reference for each reused
mapping to balance the release performed by vmemmap_free(). Although the
buddy allocator is available before slab, no vmemmap population occurs in
that interval. Earlier mappings are backed by memblock/reserved memory and
do not need page reference accounting.

Remove VMEMMAP_POPULATE_DAX and the flags argument from the vmemmap
population helpers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Explain why the buddy-to-slab initialization gap is safe (suggested by
  Qi Zheng)
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 111efc802465..8219abc6c3e5 100644
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
@@ -237,7 +231,7 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 #endif
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-		struct vmem_altmap *altmap, unsigned long flags)
+		struct vmem_altmap *altmap)
 {
 	struct zone *zone;
 	struct page *page;
@@ -247,7 +241,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 	 * Device DAX still relies on vmemmap_populate_compound_pages() for
 	 * head/first-tail allocation and tail-page reuse.
 	 */
-	if (!vmemmap_optimizable_pfn(pfn) || flags & VMEMMAP_POPULATE_DAX)
+	if (!vmemmap_optimizable_pfn(pfn))
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 	zone = pfn_to_zone(pfn, node);
@@ -259,8 +253,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-				       struct vmem_altmap *altmap,
-				       unsigned long ptpfn, unsigned long flags)
+		struct vmem_altmap *altmap, unsigned long ptpfn)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	unsigned long pfn = page_to_pfn((struct page *)addr);
@@ -269,7 +262,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		pte_t entry;
 
 		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap, flags);
+			void *p = vmemmap_alloc_pte(pfn, node, altmap);
 
 			if (!p)
 				return NULL;
@@ -287,7 +280,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * Use try_get_page() to prevent the shared page refcount
 			 * from overflowing.
 			 */
-			if ((flags & VMEMMAP_POPULATE_DAX) &&
+			if (slab_is_available() &&
 			    !try_get_page(pfn_to_page(ptpfn)))
 				return NULL;
 		}
@@ -351,8 +344,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn,
-					      unsigned long flags)
+					      unsigned long ptpfn)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -372,7 +364,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn, flags);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -383,15 +375,14 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
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
@@ -402,7 +393,7 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
+	return vmemmap_populate_range(start, end, node, altmap, -1);
 }
 
 /*
@@ -531,7 +522,6 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
-	unsigned long flags = VMEMMAP_POPULATE_DAX;
 	struct page *page;
 	unsigned int order = pfn_to_section_compound_order(start_pfn);
 
@@ -541,14 +531,14 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 
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
 
@@ -558,7 +548,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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


