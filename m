Return-Path: <linuxppc-dev+bounces-26709-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E81C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:05:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf81L0xq2z2ypW;
	Tue, 08 Sep 2026 13:04:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836678;
	cv=none; b=LnE/qSP2fGgyrLIGqhO+qj+hxqHlnGhXuC7eEiUOmytfnsTTaiSqAJ+nL9mofOM44Ben0PMJGXjHZsfzWqSIJaZUgsf9Eb6QWV8xZdtIsTCzuR85znXHwjbds0Tu2kHrh5BlNhkmNfCYp70oFvbu0ie2emmlNEFiXqPb3fwjdnZmVldyDK5qMiAHFGSEDOut9BvcpwU1Sik2oqeRAXRoqa8Xy+iBqEFsTjc4nJ6EduwZ0Pq0NvvsZQ+kL6ojpoZs9xNiuCr9dPEArCeqCfjOIpcaDciM5bpBM4ju5d51jnNYDtrrRSjt4/WccSQxXKMTUd3MmDiKHiubrmNGsBZIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836678; c=relaxed/relaxed;
	bh=l5VVmQasiv9FjgFp8hyWKR9WL3WpfimdUt+OCxubG2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDIFgNL/BdxzBPWCEeutLwtIMFzO5NKZDWUabjykTRdcxwuMNZfwEQ0pSa35s0iLlBpjS2Hn5HOD3fo2nffF0gebhIAgrkleciu0ZZhp7Bes9LARm7iqbkc50sv8tdeEzm2VDQFOvmJpf7zItvM/fCiU6youszMW9M7VME8QQ8yZ5Ly9h4ycXmI67gppi00LOt6PLgmMEybVXYJUZ1kBPLfrOCpR5lCPiBlhafWkcSiGtez4XRqTrP35PCDkm73KGQKknzCYO+8Z3ynXz8dE9qz8Yf95aHeXLib2413guz//p/I25g1ydSxtVpTK4Oi/c2JIj0qy7ZcfBxibt39ngA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ljZbQRm6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ljZbQRm6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf81K3T1Cz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:37 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-853c947bfefso2992635b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836675; x=1789441475; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l5VVmQasiv9FjgFp8hyWKR9WL3WpfimdUt+OCxubG2c=;
        b=ljZbQRm6cqIfk6oUBN78zvQhpGq8e/rlQNx8dAnaCP3h7veyiGH7VDY9Zpo8+aIG/2
         8XAB5GqMv71HBQ6mIZsJ0PZbV2nlnDe2Lk+54vpNWn5o2mLyCHPwV+jv5IpL07+p8e9k
         MmoOX9ZkssrJkwLU6YUHTr6Sf2wvrk/fB/SQMCYcsO/O/DUxIF4nVF7ZV1zMazOkkDF3
         UAgoGaqFRYx5hf654NzyOTvWATnBGKXs9drhCMOQp3SdY38RoO0Sb6fFFW8SyB2MacuZ
         Y4tTLRJtBLJS38o4njto6bGxZkyzSsgi4wNOxjbMuKVdk2U4YKSlqcoFg0cBF0Q59pjo
         Qiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836675; x=1789441475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l5VVmQasiv9FjgFp8hyWKR9WL3WpfimdUt+OCxubG2c=;
        b=XeR/LdXtgilB1ZzJUqUHKFBR3tR2hvlJnuJ6RPZ0xYdr/S6IuKm17+DKtTryDP38JL
         GiPmQEY426n+A7m7VBZsikqNu/wigP+YIef1WyoKTNPYEufGqsVkra3YRUb5cjQn7Rw6
         YSfzkJ/NWbExd5j5m+EyTpe7PR07j166umgcy5GnS5sVbf85SXgLkLZHNqrKVAvPMdgE
         Fucbxd2MAtsDjsO46g48J4QHQ6VLLz6kUPIZXCHW9ejyz29q9KQ6Sacdt8/fUhYgqJyM
         yTIQZyNkXQh4Ubl1FDNvv2qqg3OXtAB0NN2GHOSJVvDxaCA4DaFGQa2IE0UdsAdC07ba
         y/Jg==
X-Forwarded-Encrypted: i=1; AKwUvBw+9LH9TF+HL7TdoN2zRLzVY8BfOVpYrF5hQ8ljncodTG8BLvAQ5zmdIF67l+c/teItzz4QVPQAHLt3Uz4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n7IB1nv3NB01bH6o7jwcwqof1SPqaBRyCCC8lh+Hs/bSoZK1DM
	TV36bwM+nHuttpOvCqbBmlgvuIbGdkS5MUf9GAc0PTYgB3q7nqBydpSXMIf/fT4yfpg=
X-Gm-Gg: AYBFou0NxH1aZ/U8gyhl1gTkRCyVyDDDC0f6R/XzVGifAwRrTFStROKz0IYE7j8Niwv
	xDCa0veSQYalGAEnKzLfz29A/FYsCNihzpjjWFLT/F0UjEWhZiulTRjfNTC7oDgDsOBrabk0rIX
	Zzn+2b8obPTuaRIxh2cTnE/eyLKPoiqXOj0E310IytfhOSTiw2KOvcDQUNwcJMW4uV+Rej2YbL8
	EnFLUbqX/1DN7zkMhwoluiUf/jDNDeXt1n9bRuNmNenN6kV23C2gBoLRdd9F9PG8suLB+Oh3qE9
	mH73kUzHR+eYJ7P6H+ncJHLXkWxfn/FR8S5DxTNmiP4JNMHwa0yO93M/3SkgJYnTVQB71HFyzyb
	JsSjarX9FIhgF3Gy+HEh1ZIZU5Ty/4jr3ERksH/gSqR6+m+gzROw+ixL7T1o45nfp2xOuy7LrYC
	mS4pPgYbvgo1g2229THtUZT/Bt2h0tiZ/jQIHtYZeg9oG/9P2MuWDZ+Y7Vu2+5CyBVyhOuA+xCx
	6RtGbGc7m5dKLSXDcSpAo/p
X-Received: by 2002:a05:6a00:991:b0:848:4c3a:a359 with SMTP id d2e1a72fcca58-85ffeadd0famr28321527b3a.19.1788836675326;
        Mon, 07 Sep 2026 20:04:35 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:34 -0700 (PDT)
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
Subject: [PATCH v2 08/11] powerpc/mm: switch device DAX to shared tail vmemmap pages
Date: Tue,  8 Sep 2026 11:03:32 +0800
Message-ID: <20260908030335.96549-9-songmuchun@bytedance.com>
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

The powerpc radix compound vmemmap population path still finds a reusable
tail page by walking the vmemmap page tables.

Switch it to the common vmemmap_shared_tail_page() helper instead, so it
can use the shared vmemmap page directly to simplify the code.

This removes the powerpc-specific tail-page lookup and its fallback path
and aligns the device DAX vmemmap optimization path with HugeTLB.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 80 +++---------------------
 1 file changed, 9 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index cf692b2b5f7b..831c231a4a18 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -19,6 +19,7 @@
 #include <linux/string_helpers.h>
 #include <linux/memory.h>
 #include <linux/kfence.h>
+#include <linux/vmemmap-optimization.h>
 
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -1250,59 +1251,6 @@ static pte_t * __meminit radix__vmemmap_populate_address(unsigned long addr, int
 	return pte;
 }
 
-static pte_t * __meminit vmemmap_compound_tail_page(unsigned long addr,
-						    unsigned long pfn_offset, int node)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long map_addr;
-
-	/* the second vmemmap page which we use for duplication */
-	map_addr = addr - pfn_offset * sizeof(struct page) + PAGE_SIZE;
-	pgd = pgd_offset_k(map_addr);
-	p4d = p4d_offset(pgd, map_addr);
-	pud = vmemmap_pud_alloc(p4d, node, map_addr);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_alloc(pud, node, map_addr);
-	if (!pmd)
-		return NULL;
-	if (pmd_leaf(*pmd))
-		/*
-		 * The second page is mapped as a hugepage due to a nearby request.
-		 * Force our mapping to page size without deduplication
-		 */
-		return NULL;
-	pte = vmemmap_pte_alloc(pmd, node, map_addr);
-	if (!pte)
-		return NULL;
-	/*
-	 * Check if there exist a mapping to the left
-	 */
-	if (pte_none(*pte)) {
-		/*
-		 * Populate the head page vmemmap page.
-		 * It can fall in different pmd, hence
-		 * vmemmap_populate_address()
-		 */
-		pte = radix__vmemmap_populate_address(map_addr - PAGE_SIZE, node, NULL, NULL);
-		if (!pte)
-			return NULL;
-		/*
-		 * Populate the tail pages vmemmap page
-		 */
-		pte = radix__vmemmap_pte_populate(pmd, map_addr, node, NULL, NULL);
-		if (!pte)
-			return NULL;
-		vmemmap_verify(pte, node, map_addr, map_addr + PAGE_SIZE);
-		return pte;
-	}
-	return pte;
-}
-
 int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					      unsigned long start,
 					      unsigned long end, int node,
@@ -1320,6 +1268,12 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	struct page *tail_page;
+	unsigned int order = pfn_to_section_order(start_pfn);
+
+	tail_page = vmemmap_shared_tail_page(order, device_zone(node));
+	if (!tail_page)
+		return -ENOMEM;
 
 	for (addr = start; addr < end; addr = next) {
 
@@ -1349,10 +1303,9 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			next = addr + PAGE_SIZE;
 			continue;
 		} else {
-			unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
+			unsigned long nr_pages = 1UL << order;
 			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
 			unsigned long pfn_offset = addr_pfn - ALIGN_DOWN(addr_pfn, nr_pages);
-			pte_t *tail_page_pte;
 
 			/*
 			 * if the address is aligned to huge page size it is the
@@ -1377,23 +1330,8 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 				next = addr + 2 * PAGE_SIZE;
 				continue;
 			}
-			/*
-			 * get the 2nd mapping details
-			 * Also create it if that doesn't exist
-			 */
-			tail_page_pte = vmemmap_compound_tail_page(addr, pfn_offset, node);
-			if (!tail_page_pte) {
-
-				pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, NULL);
-				if (!pte)
-					return -ENOMEM;
-				vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-				next = addr + PAGE_SIZE;
-				continue;
-			}
 
-			pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, pte_page(*tail_page_pte));
+			pte = radix__vmemmap_pte_populate(pmd, addr, node, NULL, tail_page);
 			if (!pte)
 				return -ENOMEM;
 			vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-- 
2.54.0


