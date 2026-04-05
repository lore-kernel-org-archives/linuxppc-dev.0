Return-Path: <linuxppc-dev+bounces-19371-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC94E6401A
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:58:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXZ36pG1z300V;
	Sun, 05 Apr 2026 22:58:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393883;
	cv=none; b=j12itQYNge36v1ZEDdp8yJQf45DS2vQIY4a1PoK5HkwNv6vBjd8Uht5fv/xgbz6Yim0jxUN/F/Wb3nWUVFG9QNMxES4LymAr8j4n7ziWRa1aAQzl9mzjmeEBs479lKaF8qA255d/DR8PajNbksUf4XvU+4ZMM/1uFzlglOS09PGHTfVrJ8WZmImuGZhL4pYYXF8ArgbAYpqzELYgGDon9Peu/QeDbY6Tqmg58gLulZm07Ecc60zPOBDVhTexUJ9DDG+Ap0RP28ti5FX1QlaWydkpKtQtk7+neswSW31a4Pau3eg8ulUcA3THTAfz9twhwoNIxyxXkJKIW+/nv2WeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393883; c=relaxed/relaxed;
	bh=MUKNSIiZkKh812RF4RmJVKT9tRU/GLdSthiF4gOWCSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1FLeXgN8iDjejLqtMAJodPZ/rIeoQ5PVDitEEk+gO4CtRwyWnL7fKehrfEjEinoTRb/uxRv923GfzxN96qnA7jeuqmGB7s06XbmFgAfZr1B9GuUh/+vsTpQWdIdsYojbSfvAEZ4f7hvyOExVhVuANy6gj1V4CzO4FwXedSIwFs49aUVr3P9Dg0DGx6DxaQBhcER5SCiMbhmCERlttSgVz1Ar6HR+faT3tliOa4KjCBMylm2/r5EtOji+aabVc2LgPbmqvLJysJWS+daJ/LvvtLBorPqhr/Fds0Il1Ck5QzGzqaBaqFUn8jJohFGOM+oGIyCpHPiqEczVx4sN/rdSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KwVAu36Y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KwVAu36Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXZ323Grz300F
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:58:03 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso2358613a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393881; x=1775998681; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUKNSIiZkKh812RF4RmJVKT9tRU/GLdSthiF4gOWCSk=;
        b=KwVAu36Y8insX/YWd+sA6h6xGPFZnk0XAEWcxwY5uYT0ZO6dH5m6Ekv0dUwdk/1GnG
         u7ThMZJHl12v5oAdQtu525zGvj2jHuqkvRUw0PzgdVtgrowuJtkOlzkeZieW7Z1/q/Ks
         Q1IsFurMnBecT7nV51MlYSvkRXNmX93mxFW8B+UfU4YXbCex+ZLRZlE0G28THL+NEEnH
         ioKOB+BpFsYffIqOfAw3HtWJ4DB4b6SJoL6ezlH6cDR4VOUEcDEQkX6CqaIO/4AZhHGb
         7+nyd6je097B1NRtopF1B+7Do+sLvIIoCS6DMZzDUCYdJjcjZHhJNHVEhKyPSEROR/4c
         iujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393881; x=1775998681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUKNSIiZkKh812RF4RmJVKT9tRU/GLdSthiF4gOWCSk=;
        b=K9UaxS4UZHdwF0CFRnpE+MtAgkraiiBHhY0qnY6RIZ3BYfZwtrJ2JWxMUEFw09cOek
         QEptCs+JJfPzwCMs/JiRA5n8buaj8q6hH2JmyiXnt5OmtkP6BEWhICoN7cQmISwcC19F
         gQzITkkycpbLc9Nq+ocrvDyKQbc/SirwvcgtGWpztncDOK+au58WusF9WS2ZmPYpAQzE
         TXhf+7Sb7eF3E0U8oSZY+57U5BkqGmHc6jSOmeWLdMiXOPn/NdzDaifHqQ4lQxO8yMOn
         Dk/dJM0mFMoxUIQywrTnFbFT3xoJ7J6zY0GPkSxk5o3EWM1A2S+vGtCljJeICmR6uA8t
         M/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjyIpplYY/q3tHrmwsyKQTVFcwyTXK1zDmNt22/BCzPYX6quTUl2Ua+cHXXKXP125BgBkIoqmaq29/56I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwwoATCTUttcYjZdSU8fY3bf1FQ/24yYZ6n4nzl2HLCCROJHeHJ
	Y24dZkYj4nlOEE9Shi2b81gIPfI0Qi6319w42AxebR01sw+hOMnZCxxL9mlgqoTAC28=
X-Gm-Gg: AeBDievY8hCu22Sao3Jp6T7vWvBZtDKWA9oWOOnT5FQT9TYxXRJ7r2hipM7kGhrW0rC
	f8qy3MOjuaH9VEJeHVVy4UqHyah3DrT3R/QuDv9j2DLr5qV3POfM+Zh3LIO2V76kOnv7fFBIVwr
	3JKR8/qZA0PkkL3rTCZEFdW3knqe83wmCNFLw5l6ujClnxk0FEn494gvj7jUWvxjeZ/0m7KFD06
	DZm0UpMEz/+Xe08UBClzQHhsA2CVp0wpdP9jWIGeRmVbEPT2eL9mDyYDiu/8+Sf0vMNWTRIdQjZ
	/iQNqblns1IFonmjKE6XQgjUCW6KgrKpigDncWleVlSfNRgQf1GPwM0a2lWC58ED4xE2a/XTWcf
	0DZdS9rnd6RR47locTkf4vDsoWE+uDqVYoafLewRO5BswD8yEjb39JapUih0gjUbWpeKC6tAQNG
	3NmK3n5KvB5Dmv/i0gD4KU7XHfuDR/XZWpj3WkreoEzZd4+YeKAO3Mkg==
X-Received: by 2002:a17:90b:268a:b0:35b:8d89:7199 with SMTP id 98e67ed59e1d1-35de68ec6eemr8635210a91.15.1775393881284;
        Sun, 05 Apr 2026 05:58:01 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:58:00 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 41/49] mm/sparse: simplify section_vmemmap_pages()
Date: Sun,  5 Apr 2026 20:52:32 +0800
Message-Id: <20260405125240.2558577-42-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

After unifying DAX and HugeTLB vmemmap optimizations, we can now
simplify section_vmemmap_pages().

Previously, section_vmemmap_pages() needed to take altmap and pgmap
arguments to determine if vmemmap optimization was enabled. However,
sparse_add_section() already sets the section order using
section_set_order(ms, pgmap->vmemmap_shift) if vmemmap_can_optimize()
is true and the size is aligned to PAGES_PER_SECTION.

As a result, section_vmemmap_optimizable(ms) is sufficient to determine
if the section can be optimized, and section_order(ms) can directly
provide the order, making the altmap and pgmap arguments redundant.

Remove the unused altmap and pgmap arguments from
section_vmemmap_pages().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h       |  3 +--
 mm/sparse-vmemmap.c |  8 +++-----
 mm/sparse.c         | 18 ++++++------------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b569d8309f4d..7f0731e5c84f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -998,8 +998,7 @@ static inline void __section_mark_present(struct mem_section *ms,
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
 
-int section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-			  struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
+int section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages);
 #else
 static inline void memblocks_present(void) {}
 static inline void sparse_init(void) {}
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index ba8c0c64f160..ac2efba9ef92 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -608,12 +608,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * section_activate() and pfn_valid() .
 	 */
 	if (!section_is_early) {
-		memmap_pages_add(-section_vmemmap_pages(pfn, nr_pages, altmap,
-							pgmap));
+		memmap_pages_add(-section_vmemmap_pages(pfn, nr_pages));
 		depopulate_section_memmap(pfn, nr_pages, altmap);
 	} else if (memmap) {
-		memmap_pages_add(-section_vmemmap_pages(pfn, nr_pages, altmap,
-							pgmap));
+		memmap_pages_add(-section_vmemmap_pages(pfn, nr_pages));
 		free_map_bootmem(memmap);
 	}
 
@@ -658,7 +656,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		return pfn_to_page(pfn);
 
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
-	memmap_pages_add(section_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(section_vmemmap_pages(pfn, nr_pages));
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap, pgmap);
 		return ERR_PTR(-ENOMEM);
diff --git a/mm/sparse.c b/mm/sparse.c
index 04c641b97325..163bb17bba96 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -345,28 +345,23 @@ static void __init sparse_usage_fini(void)
 	sparse_usagebuf = sparse_usagebuf_end = NULL;
 }
 
-int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-				    struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
-	unsigned int order = pgmap ? pgmap->vmemmap_shift : section_order(ms);
+	unsigned int order = section_order(ms);
 	unsigned long pages_per_compound = 1L << order;
-	unsigned int vmemmap_pages = OPTIMIZED_FOLIO_VMEMMAP_PAGES;
-
-	if (vmemmap_can_optimize(altmap, pgmap))
-		vmemmap_pages = VMEMMAP_RESERVE_NR;
 
 	VM_BUG_ON(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound, PAGES_PER_SECTION)));
 	VM_BUG_ON(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
 
-	if (!vmemmap_can_optimize(altmap, pgmap) && !section_vmemmap_optimizable(ms))
+	if (!section_vmemmap_optimizable(ms))
 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 
 	if (order < PFN_SECTION_SHIFT)
-		return vmemmap_pages * nr_pages / pages_per_compound;
+		return OPTIMIZED_FOLIO_VMEMMAP_PAGES * nr_pages / pages_per_compound;
 
 	if (IS_ALIGNED(pfn, pages_per_compound))
-		return vmemmap_pages;
+		return OPTIMIZED_FOLIO_VMEMMAP_PAGES;
 
 	return 0;
 }
@@ -396,8 +391,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 						nid, NULL, NULL);
 		if (!map)
 			panic("Populate section (%ld) on node[%d] failed\n", pnum, nid);
-		memmap_boot_pages_add(section_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							    NULL, NULL));
+		memmap_boot_pages_add(section_vmemmap_pages(pfn, PAGES_PER_SECTION));
 		sparse_init_early_section(nid, map, pnum, 0);
 	}
 	sparse_usage_fini();
-- 
2.20.1


