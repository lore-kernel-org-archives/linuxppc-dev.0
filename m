Return-Path: <linuxppc-dev+bounces-22534-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00982CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:00:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5PX2YkDz3bsK;
	Fri, 12 Jun 2026 13:59:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236784;
	cv=none; b=HL9pfH0yYh/9CP3I1e20DvfgwdG7q6bZ675XZSis2H4KEfV5UR1SZgWlWnJ9mlIDpGvn21z6avgPyjYpmDOZEEK7SoGHSqlS6EwrgY3PJEFVNQkO/c99UaAoANGE+UI0oybpS0Y6sxSzLODgoEB6H5ESSP1S5+MtRKISvS5tl5YJuKH3whCMxnatVBPkjBf5Y43vLrQ9X8JO+Rh8DB2gfTwPFMuT2x5xFFc3THfVqZc1OM0ilUcAuUUPvdTJ5O33yUBED7Elbj/KihU9+wbhY4J5AFlJMZzDWooNI7tFpbSkWAJvqqWZWswCcHtRou5c4l0FHX4MjwdQ9tpxQq+6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236784; c=relaxed/relaxed;
	bh=dEbLew8Y02WMzZJgEmHXqmt5ZtOiSFYiY5ZmDDudBcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQh+7b/xx7NIZMld/asoLPUzuIeB2xcEtxfdUWBR/lkNbLRmRidmDg6eBrqanRP8ToQUGB+C5TWw+undmq5snYJg4pXJGt+AsGqkAsEEKNbppwJS4RHjBhe99swSmLM/NVWV2xnZZc4nieKSyrWxfJVgfhYI3FgQNwp5Lzp96jUhSAAXYC9Gj+URRDfhM4qVCrwywEPjLVNV9hqnscL5n7yFtu6ayRp79momdNWV7+uecIl1OMiukAJhqbWunXU4jXZFuGcmRUr1HZaR6t69bqA3Rnczun47oOYIR0Zu0TdcdO3Xh3uMLcOGC6CwLsMO3HjZYE3YFEPK+xuLl1NU9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XnTa2jri; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XnTa2jri;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5PW5Ld2z3brx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:43 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-8422524cb38so266818b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236782; x=1781841582; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEbLew8Y02WMzZJgEmHXqmt5ZtOiSFYiY5ZmDDudBcc=;
        b=XnTa2jriaxo9AMztMu55h1/is9uvuCijXZ7u66gtMBaMKnp4QRorqZcHzTevtHXtg1
         79b+IjW+82h135vYevZvbrnqY3aQaxefdDgVmgMdvRcWWu7ht3uXy8tlFgUCu0Y7u2GL
         qTsklSiU+BwN8HGxysM8EkiyC47LZrqxMSzk4koGWPR+eWZO59IJC1vR3yGZet+xjnZp
         mP0fUELCPDRQbo7VFjZoOPj5sypfKLtyGkQtaItlIR3qGq1pWqGZpDsdIrsAJbPEcXFo
         NjEQEGkVRjPF7GVqOsJAO4hYmnjadOk5egqJfmPmV1hz8NaQEKQfBJnBFLPITzbGEj58
         lT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236782; x=1781841582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEbLew8Y02WMzZJgEmHXqmt5ZtOiSFYiY5ZmDDudBcc=;
        b=S+BXQn6qg2rLyARHI5v7jWfCLMxjuGOY6ORg3aGFBTaZf3HfWJrwg4d6RuaVFeRDD4
         yHzYKbJ2C3/BBBWdq2DjeDtHNtQdg432mbFsrKOFyQAe77oDK4Z1OX5Iv1wwJTjk0/9i
         rEUja3qZueHigC23V+fgcQ25RSN9dUGcAlsAPo+PKOQ8Vr8HORUnHY4LxglppN6sNm5W
         3JZPcWv1TrjovHzyWvxopbh7g+9zzA/fKK+iyDcnvpzeycmnV++zayN9Qdo40gxXI7Ap
         MHMYhpZTJAlWWnr6ICHoAFtac/AGN/oawHSnq0au2BSWOstp5SHcuTEJ6HzhR9p3YU0U
         ZuOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UaG8DZr1rHK+Kr7xmNI+bNgmvjdPVZwrsQxNYgDKyiw9CXi20aKPFWDUlhx+RHu2qOEPPJuYkhqG9eq4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyC62IGmIyCYi7CFAaOEir4EfxMsZBVxqK3TZOcM48QTdAASZIK
	YckZ0r4hgsLytTVpzMOu4vaWv7yeAsdPDCbjaLuoCaEL7+jUqFkbBjL6FaazQOBt/p4=
X-Gm-Gg: Acq92OF1mchhvmVjcLyQ0JFxmyyZjTBo+BO9dO+dTR38e2p2j+oFtv4SEoGgBLC09yM
	6kMGthZdG563GbIh9vEecvQwIwqPRhHxULD33F9mILee9GZcWQW9bRRHVREW0v8s1Eom96feHfr
	BWO4pfvJBBv3wD7AcqytGUQvF9/TRshY1oTefq/pppItCFBlcUJj9/Ve1UnN/Q+KBhuXNC5sNq2
	4nrKQH9yOBtDMJGYduayGI0POKCn4kBYOBr0j8ovLtlHIikoaXkgwFJZ2ugstpYGt/ls2wqoWXS
	U7geQ+WyGHVHJwGzUbB8P1Qizm9bcBybe4pX9chlaulHV3UApOEsruG29VA+7PLRZ65Q/y9/aIw
	ksXWFU13r0FGxOxFS8R+OnZwBZNs98PRT2OPvYp3mQR27k8ZcWhlSNqUb7vNLSY7NqG9vWhtQEF
	mTV8T27WhBJRXzBrnIpc7kPO4V476jHj0fzU0lX3yD4FA=
X-Received: by 2002:a05:6a00:f95:b0:842:4a39:6047 with SMTP id d2e1a72fcca58-8434ce93db8mr1116163b3a.29.1781236781794;
        Thu, 11 Jun 2026 20:59:41 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:41 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 06/19] mm/sparse: Panic on memmap and usemap allocation failure
Date: Fri, 12 Jun 2026 11:58:50 +0800
Message-ID: <20260612035903.2468601-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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

When vmemmap or usemap allocation fails, sparse_init_nid() currently
marks the section non-present and continues. Later boot-time code can
still walk PFNs in that section without checking for this partial setup,
which leads to invalid accesses. subsection_map_init() can also touch an
unallocated usemap.

Auditing and fixing all early PFN walkers for this case is not worth the
complexity. These allocation failures are expected to be fatal anyway,
and other memory models already treat them that way.

Make memmap and usemap allocation failures panic immediately instead of
trying to recover and crashing later in less obvious ways. This is also
consistent with how other memory model configurations handle memmap
allocation failures.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 mm/sparse.c | 44 +++++++++-----------------------------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 16ac6df3c89f..c92bbc3f3aa3 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -239,15 +239,8 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
 		struct dev_pagemap *pgmap)
 {
 	unsigned long size = section_map_size();
-	struct page *map;
-	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
 
-	map = memmap_alloc(size, size, addr, nid, false);
-	if (!map)
-		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
-		      __func__, size, PAGE_SIZE, nid, &addr);
-
-	return map;
+	return memmap_alloc(size, size, __pa(MAX_DMA_ADDRESS), nid, false);
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
 
@@ -300,17 +293,14 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 				   unsigned long map_count)
 {
 	unsigned long pnum;
-	struct page *map;
-	struct mem_section *ms;
 
-	if (sparse_usage_init(nid, map_count)) {
-		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
-		goto failed;
-	}
+	if (sparse_usage_init(nid, map_count))
+		panic("Failed to allocate usemap for node %d\n", nid);
 
 	sparse_vmemmap_init_nid_early(nid);
 
 	for_each_present_section_nr(pnum_begin, pnum) {
+		struct mem_section *ms;
 		unsigned long pfn = section_nr_to_pfn(pnum);
 
 		if (pnum >= pnum_end)
@@ -318,34 +308,18 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 
 		ms = __nr_to_section(pnum);
 		if (!preinited_vmemmap_section(ms)) {
+			struct page *map;
+
 			map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
-					nid, NULL, NULL);
-			if (!map) {
-				pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
-				       __func__, nid);
-				pnum_begin = pnum;
-				sparse_usage_fini();
-				goto failed;
-			}
+							nid, NULL, NULL);
+			if (!map)
+				panic("Failed to allocate memmap for section %lu\n", pnum);
 			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
 							   PAGE_SIZE));
 			sparse_init_early_section(nid, map, pnum, 0);
 		}
 	}
 	sparse_usage_fini();
-	return;
-failed:
-	/*
-	 * We failed to allocate, mark all the following pnums as not present,
-	 * except the ones already initialized earlier.
-	 */
-	for_each_present_section_nr(pnum_begin, pnum) {
-		if (pnum >= pnum_end)
-			break;
-		ms = __nr_to_section(pnum);
-		if (!preinited_vmemmap_section(ms))
-			ms->section_mem_map = 0;
-	}
 }
 
 /*
-- 
2.54.0


