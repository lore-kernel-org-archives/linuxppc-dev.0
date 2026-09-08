Return-Path: <linuxppc-dev+bounces-26705-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5DCC79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:04:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf8103nQ0z2yhP;
	Tue, 08 Sep 2026 13:04:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836660;
	cv=none; b=Eh7HBAwnmveXrPE/syuHDFZ22t2hUlpXGxOZs+imWO13OFfPx2C2UyhQp31kPhRbA+Y3+4tjfsgxVupjlDkjr1nT9cFmB8wr/vxCA+ndHyWEU58BUzxv4eolOhiasLX5QXd35o73pX+IOXR6NcfVEN1tCxbCCmPMUVKA1GEG5qf5RxMRIw1XC27vU+zbvODkKYv4tjQxrtRdmlR8rUodwYDSy2xaacUmQC/j7+xi/FA0TlmEv5AEsaDGSAeqMEn7xUiCvbIrrwl+P3SnrHBeknJO5/4JrmtkPgKbK2J644+n3C8ZF+Dqi4oo6BWYBbkvCiB6g6tVuYXg/bj4h4HBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836660; c=relaxed/relaxed;
	bh=IUXKrxViB50EGCJ21IU1wh3SHWR1crLUNz3m8pEDEC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs8n8MuyB8FP0482i9ybyMZJh37Ru179Pj4uo+2YypuPTxBc/7GudZZ3Y3/meAnJxuzpSesAXMaQn6838++l9lWnj9NuXK3lSh2ePsKo1dyXyQexFiGx76xrD3Co/+Mt1Uv2IZ5NZDDbBNLHyI6K2VUR5UXhbXm+U+XbST8Jhp1s70GCltLLIy1p5k4D8IBUotBqyB2WJ6hGooGw6ZtIXqVpgpPEi4hqiAllSTPBj2n93y699Fs2pt9V10PUQz4ZFZeJH5cXJZenQyNE2dAcIpFcL4+/D1r0FFMLkHjQqsvnTm4sIIB545AjnRHV9Ro9GI46svBqzPOno7bPLyC+Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=X+u+u/0k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=X+u+u/0k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf80z6CVpz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:19 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-85469d28035so250914b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836658; x=1789441458; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUXKrxViB50EGCJ21IU1wh3SHWR1crLUNz3m8pEDEC8=;
        b=X+u+u/0kWSmmMCgkfDSueXUpz89NlcW/CguHy16bttunMa0Omga5Q5RB792f4jVPsw
         G4H+uzR/zepNgjLjcHKO1P90mwGn/0kcURWQfnpHqqVMWc0Qq3+hZc9nGeUzHsC68jVR
         1uLNa1hJwt/W4ltiHbrfjq49D65GY39fvupglzIcgiPJEHDAgCzGmpZdMZFiTc7TI5U6
         TRYyZVGMZXA6aBUXR6nP5lQUkPQacgwLMrlH0QR8kHZab4iQQL6Vm+87WIl4m2GYjZNX
         hu7fcVCN2ZVhBShoLWZI/5COgWc3g8mVbdIP5yFQdrca3hzZTJs0lhWETmHfCeOrpz9g
         d8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836658; x=1789441458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IUXKrxViB50EGCJ21IU1wh3SHWR1crLUNz3m8pEDEC8=;
        b=FHeG6C5wM80ZkHUTqMH7u9hcxTzpgQV9ADyYz2oA3mIRJhnfyRn6zcKw/T2yaFlwFd
         SBMZ0wbBp1n7vma8fy+KGHRdNzEBcA6TUkLmCpNi/aN97hyooDNI7XVQsmIfe0dAp8u1
         h56H8/rB3PYj7A7Umgit8ESenK0r9v+JcTKR2Cu26Kbm5dCmJDMducCFfOy40FbPrs3v
         lt0di0goEuEgtt9+O87AaXrw4RMmTdPUskETL4qrovKM+dIFBjKL5PMKersbDO99W96p
         zjjdh7pu5UnDfmcjK5fwM1h4qNuxe8cU1qoz2R5g0YHd5p2cfst7eEsuZEQVRaIxggAu
         xBDA==
X-Forwarded-Encrypted: i=1; AKwUvBz5lGtY5DTXiKAL+uzgCX7v7eCSy8IHde3F2JfdOrScPt18x32dSmjmr4babjB30XsBU9YbnB0MAZL2Uc0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kFsnlktyspHM2Klj6D690P/XX+1wfL9WVl6j/rVx+mbN3RkUS5
	hzb4/p9+5C5k4dXfOC89nj/dfNIdw81kbhiY08Es2IupE2Lk5ZnaGAv2JqKf93RakPc=
X-Gm-Gg: AYBFou0k6h4XSF8FHpG5GTyXLENVN7+8OLYPfot4dOgRvi+vp5plK6v3IfKalStIRf2
	oS4ERqQUeGqrWly3NN6qPMJJaH5KbaKvi0tQogEFCFBSE8Tfo741qhNS9StreLgsq9ykG+6ryHD
	h92hloDFuG11wrd4uBtCB+557mJCQlyPO8+gqb3AWfKJnVJQ6OWyxPjNSVy13ggpiNzx08FzdTU
	Bt1ZFqYZazma1JSkKVoB76QTPU0ddjy/Vbo8pi3/bPyMeeo8bBJtmiiNXnwks9CmlEGc+6SNZm3
	/wWlI/ZfUHMb3f5NgM9pChlDL1WAgCykREz4GqxsuDu8l1LdzjEfPZ1b8RpYUkDGUyLtRpH/3tV
	T+s6HxNZJ+8aaOAYc3DFc5S+5H8JPWbZD+X9w961WXUqVW6V3Czoa39fVsr4F5EbfQEwOFJzIaD
	8juZYK/uNlQOH5B83SffpfUZJM+tCg8HFu2CPgalCxF8OhYNOKTmk2Y0hDmbnflRt7YcNyhLn9x
	8EPaL8zsm1tqBWTXWqWSYhU
X-Received: by 2002:a05:6a00:1807:b0:862:bb07:2ba1 with SMTP id d2e1a72fcca58-866988d9942mr4431251b3a.4.1788836657402;
        Mon, 07 Sep 2026 20:04:17 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:16 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 04/11] mm/sparse-vmemmap: prepare DAX vmemmap population for section orders
Date: Tue,  8 Sep 2026 11:03:28 +0800
Message-ID: <20260908030335.96549-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908030335.96549-1-songmuchun@bytedance.com>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
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
population path yet. Once a later patch records the DAX compound-page
geometry in the section order, DAX head and first-tail PFNs can look
optimizable to the generic helpers as well.

Add a DAX-specific population flag for this transition. It keeps DAX
head/first-tail allocations on the normal vmemmap allocation path, while
preserving the existing page reference for reused DAX tail mappings.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index e453ce4675a0..54ae8c284324 100644
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
@@ -208,13 +208,17 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 }
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-					 struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, unsigned long flags)
 {
 	struct zone *zone;
 	struct page *page;
 	const unsigned int order = pfn_to_section_order(pfn);
 
-	if (!vmemmap_optimizable_pfn(pfn))
+	/*
+	 * Device DAX still relies on vmemmap_populate_compound_pages() for
+	 * head/first-tail allocation and tail-page reuse.
+	 */
+	if (!vmemmap_optimizable_pfn(pfn) || flags & VMEMMAP_POPULATE_DAX)
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 	zone = pfn_to_zone(pfn, node);
@@ -236,7 +240,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		pte_t entry;
 
 		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap);
+			void *p = vmemmap_alloc_pte(pfn, node, altmap, flags);
 
 			if (!p)
 				return NULL;
@@ -251,7 +255,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
 			 */
-			if (flags & VMEMMAP_POPULATE_PAGEREF)
+			if (flags & VMEMMAP_POPULATE_DAX)
 				get_page(pfn_to_page(ptpfn));
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
@@ -511,6 +515,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	unsigned long size, addr;
 	pte_t *pte;
 	int rc;
+	unsigned long flags = VMEMMAP_POPULATE_DAX;
 
 	if (reuse_compound_section(start_pfn, pgmap)) {
 		pte = compound_section_tail_page(start);
@@ -522,8 +527,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 * with just tail struct pages.
 		 */
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_pfn(ptep_get(pte)),
-					      VMEMMAP_POPULATE_PAGEREF);
+					      pte_pfn(ptep_get(pte)), flags);
 	}
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
@@ -531,13 +535,13 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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
 
@@ -547,8 +551,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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


