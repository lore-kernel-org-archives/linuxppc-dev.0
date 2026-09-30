Return-Path: <linuxppc-dev+bounces-28571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74730CA5FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:08:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxjb00P9z30V2;
	Thu, 01 Oct 2026 00:08:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::29"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777330;
	cv=none; b=BqbRzlnWpu71EUbIIBqnjFMsXEH5yM55QK+Ehl06IVLTiiNaSPt1uCiLS37uq8s/U54CnqeSoQBZT6YmB5oPz2tUMwvC2IwumZB5xIqYuhCiHP2ChbrpGIRDFxX5QJ9NIMD8e84ZtWmoPLMuqlHKhReayLPZTUnjNZvKTeJf6JJUKsa/6C48WqyHFW7C28VJkY49TJm0vBGzoelElMQCfWXGtmKILVMseOuMZpqrtsHBK0ZGFJ2xy+JcS1Yb1Bv4DqwfgJziNpCGk+7VBLB0F8cmwGF8G8fMq2xu+qTRUeusibZ73TK2DL976pcvwZLtFRQlA9znz1pSCH4iNV1L9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777330; c=relaxed/relaxed;
	bh=Xa6t5Ld51NH0IkEH0Cbkiyr6aGf7JfNQsVmQ3uezLic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ljw8J16LiXGw2RZTydugf3adWKWQ41XTcr9cXWpw26stgPMzCJDzHsWkizHmjjU22iIkvXOhUkow2SSqrtgJ7VZh/ZE3uoCn4DoOyemmwBtbrYcqsjyYzZeCiiWyBo/bSltQTbPLD6l63YeaChtEgY+MtMuXnzFKhM9To3kncSY5XFVpxMuKfTscnlvvm4G6a2j57Z0AagOx408SCbe/9nDg6sb3fpGgsR9vdgQUuc7HQ0OMqWqQg0+2N6AUdyTqxgXwIQUNHX5nvDWrPP3Vzr1bED1flbh5MGigodk/fTtBa/ajPzzUSqfT4n2xM7KxBeCTkaBlrZFAuZ2eAcjmxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JYUULJEk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::29; helo=mail-pz2-x29.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JYUULJEk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::29; helo=mail-pz2-x29.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x29.google.com (mail-pz2-x29.google.com [IPv6:2607:f8b0:4864:3b::29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxjZ1vhdz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:08:50 +1000 (AEST)
Received: by mail-pz2-x29.google.com with SMTP id 41be03b00d2f7-cc7cadbe09cso1078062a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777328; x=1791382128; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xa6t5Ld51NH0IkEH0Cbkiyr6aGf7JfNQsVmQ3uezLic=;
        b=JYUULJEkA8Yhjtpm6wFQXV4M/+lP7YKYiPje9GC0vPIGBlJdn4cI1ENcc0IrJPg0wP
         97hL9tDNhFtUuB7e141jeTmHNBr4T4oH+JUX2AfO9TvhmkLA8RqOsv46Xr3sm/2Hf7E3
         eM5UZkhKHurol95vevzNSuh9GGzP+w2bYlCOf3UKEdn1qGOiTCIz1gaE38SowYXQEdDC
         IDSy0cG+vwnNJgz4zCkAFydJvQwcJ5Q7DXuSxvHbPP6W/8Nu7pbzldIs7n2OgCSsWoXO
         cvIEaw8kNuS+zeY1kmHCNXHZHh39w4lajLP3j3Eo8N6GO+qz4ne9OdsYrm6AMVkFiIq5
         2+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777328; x=1791382128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xa6t5Ld51NH0IkEH0Cbkiyr6aGf7JfNQsVmQ3uezLic=;
        b=x55IglAuJv0ukxcpR3XqcX8UUaaSzOhQqSVp7Qsi39Nx+zSwLZvr3SYm+m4TPxlRdW
         aYuDcafl/l3qssqU2tOh3IObCvsFIq+vBGi6fqmozvt5hbjaeUupVQ3GwVcLxnU6l47F
         nRIpn8aJPk4WtAW+L5VgAFuzeAXunLtRs9neXTdDWtrJ5Ry2faeWbUrwhlpmbY+rTJgU
         0yxHyrN5k9mvZYip11CbwzDA1ai7q+TuGBhLDmKI1Q+bWNyiu7e353byAUS+UhOL9DdF
         Gr/vWfUR3e73WRsyxtKeTIFeW+kmN543DWo63eS0EexBxJcGKEtUrmf09s3/obVocURx
         PbyA==
X-Forwarded-Encrypted: i=1; AKwUvBz+K1HfXOwQm0fJD2dwEaau0UoAEF12uj9tfyaaUEn2FQ2+B3f7cBvPdFqH+1TZc90aIcEWiVi1rXDzA7k=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJdq8GBkOvppui4U9GHJhkTOqMytW/j3F/TDRdafKWzdQIe3Uhy
	JslBgT2suX35T4VcJaConf4l2dVWGbvVJUhECIE2dvpXgynAh1jZwoIOyTaMnZC8QtQ=
X-Gm-Gg: AYBFou2KK0iRk1BSR9OA5nbmKuKCFcEFNWNPvwmoPCBDnEz2um3Srw6PkgNmWMSqgrh
	yypvLlXdg//KW5ZPJoTF6/KC4CsWDO2FvGa5wirIcvhv9cpmBWHFjE3BcwjtD4J3HLFEfCdpNVa
	SPKwKUKfHjFNiqHsDwihrHGpujybqg2GRQ0HqkLEBJyF4HgWeGXmewrTFW/dCbMcBuLKGYRmL9B
	PqH+Bvp1Uu9F1YL3bZo1lgL286r/NkqIq0kWPEbMPsFQeRBaSzFYm+ApfMtzDSzhv5qSaLZ0ucE
	XDUWl6muxwWCe+FHPqFjwLuVSYI+5dedwiE9wm5LxuWB1EOwK78n8ti8xMt2PMH5BfSDU7SztX0
	c6OZntHrDICgly8wXfPaXcIVSA+ZwmG4Ygo6OD6rpFIUJJNi3uIMoux+JcjiLs+7Ar9jKfwHyb7
	TzoLL03MvR1kFT6q4dTb6C8lkR0W721q2HiwJUo1bebnhg/u0RVpG07wD74/QqvG6TqxdaiTQ7g
	z95XCqeoJRUb9hVTyPX6Kgu
X-Received: by 2002:a17:90b:5404:b0:3a0:b959:4479 with SMTP id 98e67ed59e1d1-3a4d18a28a5mr1270065a91.38.1790777328422;
        Wed, 30 Sep 2026 07:08:48 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.08.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:08:47 -0700 (PDT)
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
Subject: [PATCH v6 11/12] mm/sparse-vmemmap: drop unused section_nr_vmemmap_pages() arguments
Date: Wed, 30 Sep 2026 22:06:26 +0800
Message-ID: <20260930140627.57431-12-songmuchun@bytedance.com>
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

section_nr_vmemmap_pages() no longer uses the altmap or pgmap
arguments, so drop them from the helper and its callers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v6:
- Collect Acked-by from David Hildenbrand

v3:
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 10 ++++------
 mm/sparse.c         |  3 +--
 mm/sparse.h         |  6 ++----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 4cea94126cf6..4be85e194c78 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -131,8 +131,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
 	const int order = section_compound_order(ms);
@@ -674,7 +673,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages));
 
 	return page;
 }
@@ -685,7 +684,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -695,8 +694,7 @@ static void free_map_bootmem(struct page *memmap)
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							NULL, NULL));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 	vmemmap_free(start, end, NULL);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index cc28bb41fdb1..b75921c622ed 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -250,8 +250,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 						nid, NULL, NULL);
 		if (!map)
 			panic("Failed to allocate memmap for section %lu\n", pnum);
-		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							       NULL, NULL));
+		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 					SECTION_IS_EARLY);
 		usage = (void *)usage + mem_section_usage_size();
diff --git a/mm/sparse.h b/mm/sparse.h
index a5111087ee3a..530692cdd516 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -70,12 +70,10 @@ static inline void sparse_sections_init(void) {}
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 void sparse_init_subsection_map(void);
-int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
+int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages);
 #else
 static inline void sparse_init_subsection_map(void) {}
-static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 }
-- 
2.54.0


