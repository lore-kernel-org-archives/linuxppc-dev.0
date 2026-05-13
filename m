Return-Path: <linuxppc-dev+bounces-20902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23FACD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvHk3n7fz2yr6;
	Wed, 13 May 2026 23:21:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678498;
	cv=none; b=ElnVKG+nj6FEiAbAiu3/G6vyT7Dn91Pb77T1on46jDxj5YyUA+GVMu5qg0asCSwYXjtN1zL9a5T7+xm4zO9d+UpvAGdLOAsHphO0ZjuX0diu14vRye5IeaotwAht0yWpFe94x1WIZYbhc2u2YJSUXvTXKITInM5xMVB8x24wS+4HeXVVj8gHCbJh/dehPEOCiPZts1H0tF0bZ3sVlTFHeFDmWPT50n2eCAb5sAArCVugaOeb3DdRjG9AktkckwrAKGlAY2FXVt3m7z3NPwxD0QJZWfPuVYrbNKRVmwP/kzccnCtlSL9Gp9lrl3xEQzYgKyOXoBKF/SUQoV4qrSxiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678498; c=relaxed/relaxed;
	bh=Wk2DSdjqKxbCAHCUFPSIsYyI95cGv7pmmX0gweVd3ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUKr7B6hXr661HsPtB22P0GLVHmmmITj3m4xjSP6kzo6AyeJt1rxcjZkehIuYehIOFYYoM44Un8dlzjV7MBMT4lz670ELYVodb47hLPP8VmXPwUyh2Q6ocVOiQPix57yINWzJpxmA65rPxP5Uptdsf/4AVqE05RRnXhvOnt/ntq1X4EVrDvH/o0NgweBF2wmjaAA29xhqeQaYH0xfWlu+HSO9SRtvGdKXImW2yBVW2y2Pm58wOlVRWmBIArwMVllRqJqqBaPt8jak/qFHSKJ0EmLCRimZ14qOUfOPpKe+Mupi5czlfyfRraas2vljmKQnQiSPSACBCLgXCTUTydoHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IyUnCMMP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IyUnCMMP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvHj4THtz2yTP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:21:37 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso4490488a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678496; x=1779283296; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk2DSdjqKxbCAHCUFPSIsYyI95cGv7pmmX0gweVd3ds=;
        b=IyUnCMMPxaTNsnMMaoR9shgHpEcKw90Ppj2lh7JzN0VkceB/umKkBT7c1jOkMBhQVo
         t1Wtt5U67xzFcuycdNHeWjGz6jX4CPXHF2KHeslLSOU4QOWwzguRd2YnuEuIl1l0ve50
         VEUav7CF6XGdL3D5Gru/eHjkqAvE54Hqiv4Y7QAtV/WsmN/n+JOCdA+z9OVgtPmAv4tK
         2+31qVnQVqybSiFx5c0fdF/CHmSd8Cv4YKf2i23TtYJbBnoVrx6Z4cCAEJiG4jcLMU4m
         tygvP7brevElbB0TN06OopdH8eiELodCJS4zSAfJYAGuOvQuouOPlnvR4QbRjTFclzo+
         Bwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678496; x=1779283296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wk2DSdjqKxbCAHCUFPSIsYyI95cGv7pmmX0gweVd3ds=;
        b=OJnnII6SnBJSFfF+oo5+A1P+GViD+GuNIKEeRa3pEIM8LGSVojf+ym2bst1syOESYN
         IQ03RLgelYMz9ay3ggOcnYq2jG51KfhbiH4rt7ZR/AFu15w4ojiAN1l1k6+HgJQwGYoh
         igmxrbHP34RiHnGoP/RU+/vnEFt42HcSqoluXJXCVFaqp7ke0zwOKm8N5QwzIwYDPD0e
         OAgB8vUHrEaiwyVJdISFo9vxKab+tKpH0NALdrHGiIQYHsmpGskxHrWpUTTdqILvJmZ7
         4ZZvYh7fmF51NF8oJ9OpqjyPADWJ2PsQ/03n6fWJppySlcCUvjpVKJll0oav7UiNSq3f
         Y2Og==
X-Forwarded-Encrypted: i=1; AFNElJ/73p52qim1SCb2vWd6gDpnjqeGltmMNeZ75cRApZCUkLp544HWb4mVfWuQ/Vw9iWki52uEobxO6ptRfh0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyzBol9QvwcMDJjaKWzjzJdoXM89fXid+QbC7xD2f4kGvaZTRu1
	8VBWfR7ECJzCuwA06MbJPiudE5ANsCcB1KINgmOvj2vMFAv+e4JVhoE1AWXWgmIYU5A=
X-Gm-Gg: Acq92OG5EtH6zV/HBYF85R16s3b6rOqBdpEKYgDZzrX96Xd+D8Qj5+K5qrsYykUETvo
	swzNUJknJxhc4ey5c/wqKEyvU1UCjgg8BTBOHUy3tdzFZ9x9bFkSrueIr4S0WzNWjJGZ0HnbsPN
	l1dcfrU7V4LB60RVBq8+89ue0BXT8G1ahjzVU24Jc2uBISCfyE7Hi17ltftXXzPErXiP4FVIOne
	eFAxUR8hXhaSbGs4ZtNxROGO2EkwoQY+Gv616+xijErwq9/AykpxeSGpleWW/fy2yypGyW9XPYh
	mPPmb5chcVB7VOydtehEXkZsuN9/YeiwK2nCF20GHfPauWpUtNOwZyZ+3IlvVtU1E6rzEi6iYyi
	OUguX56SptAdvLbtYCOLdltODcQex85TQo0HA5zi6HEFcqEAhed4HVX7NtOMbjbs05poULfUbb9
	bgX5ap0LPR710NZ6raNl2wnSZbFdMZB/pNpk1BcadTrZEKYFzAEUOUTma0twEf
X-Received: by 2002:a17:90b:2550:b0:368:fd8b:7da9 with SMTP id 98e67ed59e1d1-368fd8b8195mr2143454a91.0.1778678495451;
        Wed, 13 May 2026 06:21:35 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.21.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:21:34 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 53/69] mm/sparse-vmemmap: Drop vmemmap_can_optimize()
Date: Wed, 13 May 2026 21:20:18 +0800
Message-ID: <20260513132044.41690-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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

vmemmap_can_optimize() no longer needs to gate section activation.

section_activate() can use pgmap->vmemmap_shift directly to record the
requested section order and leave support checks to the vmemmap
population path. That keeps the policy local to the code that actually
instantiates the mapping, instead of requiring callers to pre-filter
unsupported cases.

In particular, altmap-backed memmap allocation cannot support HVO, so
__populate_section_memmap() clears any inherited optimized section
order for full-section adds and rejects subsection re-adds. Unsupported
optimized mappings are therefore rejected where the vmemmap backing is
set up, and callers no longer have to care about that restriction.

With that handling in place, vmemmap_can_optimize() becomes redundant
and can be removed.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h  | 34 ----------------------------------
 mm/sparse-vmemmap.c | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5e38c9a16a0a..5f45de90972d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4896,40 +4896,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#define VMEMMAP_RESERVE_NR	OPTIMIZED_FOLIO_VMEMMAP_PAGES
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
-					  struct dev_pagemap *pgmap)
-{
-	unsigned long nr_pages;
-	unsigned long nr_vmemmap_pages;
-
-	if (!pgmap || !is_power_of_2(sizeof(struct page)))
-		return false;
-
-	nr_pages = pgmap_vmemmap_nr(pgmap);
-	nr_vmemmap_pages = ((nr_pages * sizeof(struct page)) >> PAGE_SHIFT);
-	/*
-	 * For vmemmap optimization with DAX we need minimum 2 vmemmap
-	 * pages. See layout diagram in Documentation/mm/vmemmap_dedup.rst
-	 */
-	return !altmap && (nr_vmemmap_pages > VMEMMAP_RESERVE_NR);
-}
-/*
- * If we don't have an architecture override, use the generic rule
- */
-#ifndef vmemmap_can_optimize
-#define vmemmap_can_optimize __vmemmap_can_optimize
-#endif
-
-#else
-static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
-					   struct dev_pagemap *pgmap)
-{
-	return false;
-}
-#endif
-
 enum mf_flags {
 	MF_COUNT_INCREASED = 1 << 0,
 	MF_ACTION_REQUIRED = 1 << 1,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 793fd4ce1393..549be01d90f8 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -384,11 +384,23 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
+	struct mem_section *ms = __pfn_to_section(pfn);
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
+	/* HVO is not supported now when memmap pages are backed by an altmap. */
+	if (altmap && section_vmemmap_optimizable(ms)) {
+		/*
+		 * A subsection re-add can inherit order left by a partial
+		 * remove after full add.
+		 */
+		if (nr_pages < PAGES_PER_SECTION)
+			return NULL;
+		section_set_order(ms, 0);
+	}
+
 	return vmemmap_populate(start, end, nid, altmap) ? NULL : (void *)start;
 }
 
@@ -613,7 +625,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	unsigned int order;
 	int rc;
 
-	order = vmemmap_can_optimize(altmap, pgmap) ? pgmap->vmemmap_shift : 0;
+	order = pgmap ? pgmap->vmemmap_shift : 0;
 	/* All sub-sections within a section must share the same order. */
 	if (nr_pages < PAGES_PER_SECTION && section_order(ms) && section_order(ms) != order)
 		return ERR_PTR(-ENOTSUPP);
-- 
2.54.0


