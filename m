Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E5606A32F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=iCeq4rk2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jM37619H3z2yD3;
	Sat, 07 Nov 2026 15:32:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794025954;
	cv=none; b=WMvMJDNSm0b4hGWq1WbzjbUhLLX8RniXKGZhgVJ6jQCNNr62bpTvmjmF+81717D8TMsO6DKUrxvf96fJMrl3/7aiwMOR6IrPRjFxpjj5bn8LSBaRLX1Tyr+PN8M1meN4t70qEqxy72ygg5ymgFiiS9Rt5Q56sQZodyb5P4zIAxsVr24V77z5C0cDj0mG8LUWsCR8oS2oRm2y6ZbDEfdFWXvgQJ2NwpKr+mwdc5kbi7zfh7whfibqSlwUH8I6jChELYGsd98ZtLkzNLLVB0TACVWgjriuncwy6Ze/eB7HZeirS3eM4n4nUWbyQxTgJMambBey0zbWAmXT9d/OSPjEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794025954; c=relaxed/relaxed;
	bh=BY1PW5EQCsSwahWNQsNirKWCM+cX6Fs3QmmMD9rosww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QflYZxkP0Z5Wktz+zMQV6CG5+FV4YKnaIq/kXe4FF0Kq1rERuhJdASbStEKtru4J3SN0McKwtseLxVXma3mdrXJKofjXOEy1mDsIkRQoA3Q7N7GX8dQHt0rmyeKhDPYVxFURaKb+DlhFWJ4kc4LHskfDWWPoXsC4W7TpFg5iWeuSPuNWNPf54efNprFOBLJfx/+KpQ+q8tGdRk/RNRANl7dMeMlRcz3XhwgHSmTBNMp171MyPUJhOT9V19MwP1zuyNP8Jbqu7t2CWrRyKhgdG290Bql/vgMxBx5jrtY8I7qJCZdWrAPdGmelBEgcix1G+jDApinZM/4MTlWcdOl5XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=iCeq4rk2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=iCeq4rk2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jM3752RJzz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 15:32:33 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso719377a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 20:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794025951; x=1794630751; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BY1PW5EQCsSwahWNQsNirKWCM+cX6Fs3QmmMD9rosww=;
        b=iCeq4rk2tQaSmOeZpRdgl0T5Hs9hcZLDC5iyBBu1QcKWpNXMDGvuYw9BPtrPcELiwv
         gtCN7JSUV39S+ELUGgDqVkZ1EY2LvRhSokOMdf0HzSGTsMsJ6gEvJI6PDQVphtF3jM2L
         Q9DGC8pOqhiY4/43mXGxoFsc0llxvqLO90i/FCM7E41YxLUdQVrDBipIwPv2Pu3n5jRV
         sfrBRsOE5LvyBVCh+4BfBIucsTxKtp1GDy5uxF+jE1h1jED49QknIRIRwRSqTMmcbH0u
         y5LIeQOa1TpMX7b2De3X4udTtss0ObFVus92c9XiTfRiAAtM1NBLinlzIkn/WWfY9k5V
         zQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025951; x=1794630751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BY1PW5EQCsSwahWNQsNirKWCM+cX6Fs3QmmMD9rosww=;
        b=nEs2jE2K3cNBqe5QW0XZrACz61WiRU6cYw895YXeUDkT/7bH4d4ahgvkCbIfVdnSxv
         QKooPV1i4FP3lSkRc3qoI9+n6gXRXS9bI3/nhSyrcInuwecm48QZHwvps4ZZ+fevH/PW
         6F+3PyAFqWYNDIEr8Gy31PRCTLLdU3UlOkU6agk+7/e6oS/pu2hstAi32HfCmfWNoojG
         NogbCxqNKc2VHSBjsX7ko3XwOYW7hr0VDTjYsPqCJWCKoZHOplwP0HPqIhdGollmDOTR
         dTVOCnLfgusgSOu/HMaBtXGQ8Q9WEAPSnsNRGKYsreFzh+x4iYoO3nV9z5EvhpAgFWA+
         m+iQ==
X-Forwarded-Encrypted: i=1; AL+hErFPFGXPTNHZn2g+xWJiKF7SHmaO5ZXneULe9SBFtQVex1qYvaDklrkKP1s1G6SHp6W0gYC4p/tw8MqKgiU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9v81vGTLc9qeWj2Z3Mcened2zufoKwqPEKV/ZwnOsS97D6FZ91
	cDkYmvla4vnhQQmv8rc9V5VIV2+SEx88aEw3v2CY3PvIVnpqonqNH/E+IZoIa7LJNAQ=
X-Gm-Gg: AYBFou0S/xsLJd9dFJSC4eZsSnPOeRJP8T3aEVqEPvHXSpuYL0vVQUKHRu9Zm4g+NGO
	AzrA+ZusULUFt8ShjDGLK2e6uM2nTpcRPmC1RjQkct2EIFWVzMzyAe5oJop40YYjGzWSCar288k
	6vfeZioOVjbqHCKuK8AfyGmHZQanEM5q/Lv4kt4iY0fnictkXv3inOT5EyY4QM2dzuxQh/u/txm
	Mj7cjViYzr6rU0UuYZeT5nb1ujhcN6t/SRL+c8mBSm87wRIlGgMC87W9wg7UUNnA1m8Pp8cKrUN
	ZXLK/87bhMF4x8zYgoZX+cBWKoUYIEOLnbzzMPkHI0mD9lP3nn84/U+XUxolmx30DpGK9CtbTRh
	AWCAIt8/Ar2dci2XKA6Lof53BtauMp7ifheBpfkYxUvM150Yfxjpyif0kzYprn0HswWynYwQNYp
	VJNa5rW2eAQCE1pQprh/8hHFTRsgmdMzI8tnfAvNnNnujxSD6T8yEwANo6cvTrmAIKrpQhKylZv
	cCC3IzAYmeBtTcvaULxvP8n7OSiOUw/WU8t/Af9n8gtGnDusF4bx4EK37eQtMLRPtvFAtNBJiXz
	iVvsLuzDfbn0P+KqmMTfkiA3dAsIXRqEMule6tJ99kOUjcqt4T41lpSTxE+NOjK+VvNHg/VM8BI
	u8zXC2g==
X-Received: by 2002:a17:90b:530c:b0:3a8:59d3:530f with SMTP id 98e67ed59e1d1-3b0db71d480mr4559125a91.57.1794025951057;
        Fri, 06 Nov 2026 20:32:31 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10584b66bsm1578451a91.14.2026.11.06.20.32.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:32:30 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 4/5] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Date: Sat,  7 Nov 2026 12:31:21 +0800
Message-ID: <20261107043122.25650-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107043122.25650-1-songmuchun@bytedance.com>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

section_vmemmap_optimizable() can already decide whether a section uses
vmemmap optimization based on the section compound order. The DAX-specific
vmemmap_can_optimize() helper duplicates that policy, so remove it to
simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Ignore non-optimizable nonzero section orders while retaining zero
  as the reset value (reported by Sashiko)
- Use section_vmemmap_optimization_disable() for the altmap fallback
- Move vmemmap_optimizable_order() before its first caller
---
 include/linux/mm.h                   | 37 ----------------------------
 include/linux/vmemmap-optimization.h | 25 ++++++++++---------
 mm/sparse-vmemmap.c                  |  6 +++--
 3 files changed, 18 insertions(+), 50 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2d0b8a4c9974..43eb19474d26 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -38,7 +38,6 @@
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
-#include <linux/vmemmap-optimization.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -5385,42 +5384,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
-					  struct dev_pagemap *pgmap)
-{
-	unsigned long nr_pages;
-	unsigned long nr_vmemmap_pages;
-
-	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
-		return false;
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
-	return !altmap && (nr_vmemmap_pages > VMEMMAP_OPTIMIZATION_PAGES);
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
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
index 22e5a322be0b..985a37dfcab7 100644
--- a/include/linux/vmemmap-optimization.h
+++ b/include/linux/vmemmap-optimization.h
@@ -31,6 +31,17 @@
 #define VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES	(VMEMMAP_OPTIMIZATION_SIZE / sizeof(struct page))
 #define VMEMMAP_OPTIMIZATION_MIN_ORDER		(ilog2(VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) + 1)
 
+static inline bool vmemmap_optimizable_order(unsigned int order)
+{
+	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
+		return false;
+
+	if (!is_power_of_2(sizeof(struct page)))
+		return false;
+
+	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
+}
+
 #ifdef CONFIG_VMEMMAP_OPTIMIZATION
 static inline unsigned int section_compound_order(const struct mem_section *section)
 {
@@ -40,6 +51,9 @@ static inline unsigned int section_compound_order(const struct mem_section *sect
 static inline void section_set_compound_order(struct mem_section *section,
 					      unsigned int order)
 {
+	if (order && !vmemmap_optimizable_order(order))
+		return;
+
 	VM_WARN_ON(section_compound_order(section) && order &&
 		   section_compound_order(section) != order);
 	section->compound_page_order = order;
@@ -109,15 +123,4 @@ static inline bool vmemmap_optimizable_pfn(unsigned long pfn, unsigned int order
 
 	return (pfn & (nr_pages - 1)) >= VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES;
 }
-
-static inline bool vmemmap_optimizable_order(unsigned int order)
-{
-	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
-		return false;
-
-	if (!is_power_of_2(sizeof(struct page)))
-		return false;
-
-	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
-}
 #endif /* _LINUX_VMEMMAP_OPTIMIZATION_H */
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 57aa5c2d8034..f6a8b8e51b6c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -490,6 +490,9 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
+	/* Altmap-backed vmemmap pages cannot be optimized. */
+	if (altmap)
+		section_vmemmap_optimization_disable(start, end);
 	r = vmemmap_populate(start, end, nid, altmap);
 	if (r < 0)
 		return NULL;
@@ -717,10 +720,9 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
 	struct page *memmap;
-	unsigned int order;
+	unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
 	int rc;
 
-	order = vmemmap_can_optimize(altmap, pgmap) ? pgmap->vmemmap_shift : 0;
 	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
 		return ERR_PTR(-EOPNOTSUPP);
 
-- 
2.54.0


