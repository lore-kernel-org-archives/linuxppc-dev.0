Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F3606A31B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=c4A62Rm1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKsRx0c4Lz2xlk;
	Thu, 05 Nov 2026 17:13:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793859181;
	cv=none; b=dCLTfKP3TioOHVK/ZoN8z1MptwqUTSuASnDQDjERJkVkVjOrvDLOW3acfeZiG2iuzYzl1WOMGS6t0lJleiYAqaPxF9yE3ol4bumTBwdrJX0ecGDA69SUXMt8y3LZgOWO5P1QkDsSvYBRPpzI/a5wY4K8Pi9aB/nHA0XueqNv5LPUifQ3jTKerMkebFn96RDJrHSlX5fHTtAWpQnAjw5Y6Jtn2swdBbHU0cv8zG/rDLysQ/uGYYM+Zis12Kg5gVwy+1eRml8w1t0OccntnhkZzUOudnYnzAHm1eU7TXwV+XPlL9meRmnYINAkxKQMd+FY1lypDke6ZULi6dqj+ifeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793859181; c=relaxed/relaxed;
	bh=kKRQNq+YvdEons4PssMSMvDyZ1aDaAIj0dg+GEUgY+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnUTqCSo9Qcb9tvlgveIVf0R7qv8OugFLTcShA8lklR43kUOGx6yBJtHf9IPNfFA/w6CbVyAPdp/TTardpSctlSDFKVuvJPPLhFOCI00wpN8rtdtWuV3LvgdtfT3VGJA+YxKwqAoNPaMDcTld7Or5dgSypjQa2uDTSj+MhMPwFJExXpORa3lzyKddJW4d/wX/V/uTLD2WAc0LqJQNYA/X1j0Guzf1P/7Zh5z2nzX7EgO2LM7uCTVvSssxAiDEnNGrOm1zlknLvczTcKtpS+dpNxKGrOC0QRDomnypETP1xlbIt7NvC9zFPUH1Lioq6fo5UhrnCIiuAqynh/aEVAIxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=c4A62Rm1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=c4A62Rm1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKsRw0h8Vz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 17:13:00 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso8447505ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 22:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859178; x=1794463978; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kKRQNq+YvdEons4PssMSMvDyZ1aDaAIj0dg+GEUgY+U=;
        b=c4A62Rm15prrp6Wr7IVFNycnQ3o6+Qy27grmcndyjS81a4f/S13+QY2t2XprQ2VWBl
         JEibhJPt5dphm0w33vYa1sdIuVZIvloRxQZF93Q4wKj7pY1GTam0yrv3tHbgGNOaTzMA
         JEvfDZN+8ZLF/eGU6QZ5LLucAt4+MVkxdGxbHwZjEj+Lw+4T0PgngDQKIrEaSowwV+0u
         jlsWpBu7p7xCTOoYvBzwytc4CxY203Z6ETFsPKGOj0gD9t7f0YjxT1ubirypdsSkjkU5
         oce/88zYgfa46gZ+/gsLhb+/JP+w4fM1nW44ZNSjohn2IUNZwd/wfnL3FzeEUH4FiuIp
         2vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859178; x=1794463978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kKRQNq+YvdEons4PssMSMvDyZ1aDaAIj0dg+GEUgY+U=;
        b=asrr2sSEaF8ixbCfICycU8mkgU+oD8n2mD6SWlAx8tC+nn7QMhyf0go8fguO7WAmNw
         dg1/YobK0NWElxanWln52UaBd34czJ4GQNevvj6Wdn8qQi03dt+9+uzhIInDztR8rFCW
         y5R217yTr4+Va4XQ1uxxm/Ye2EU/BPdHcDwxbjttB9dh2ze+3CFos/EqiYbEx4nEoshB
         SGCBqHVgVSbrRGDVTPZBtd7z471MsC1FtJqCa57PmY8bLm4mufkB5Lu+W5W3rZfma0Cn
         BkZoNpiBNA1i2+kz6qKb3OZO5e7vGlnPGEsvw1FrISE4y5dzZNNpGSjuGbdG6zdvxzte
         wYGA==
X-Forwarded-Encrypted: i=1; AKwUvBzc1/I8/W6zKHXEaWxRRMgENkQRdF8YZToQkRxVRl+S++uqJsm725hIINyBMdA1/GisGbKXqvYlgy8ft9Q=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8UVm7gha4yIjYEWMm9Fe21kU5UPsx4KchLgGto6OJwsio+ukMK
	RwKGs6KEbtE15rImHhlb2l7GVpdVcxgAbcjvThlvoOAS/TGwTawHX/JvzP+airPfrik=
X-Gm-Gg: AYBFou3LIYz4LjW375H/d/V6nwpO3pPj/eIPAmHG1+rEAJ28NltZsPRrWKWQFTwf/dd
	XJbiTvGgrJbg5hZMV/yu6DqmoCXsbEg875T7Gjo19F/Gw56/laI0xuGvqCX1nLuQMfkP1suMwxC
	8Mc2qFWkthYFBZcHNNIoYSLxK6uVCDC57NdCTr1A49TIt5BYWEryjoM4sRigQG3RNsdbEherMdn
	f5e4sL9OtQE2GDO3f3pvJtLbKM0ap1Qh7nMaLH4UdW67wdO5nQYjzBsAz7wyHUYAZ706EvSsOaf
	93UDvNUVcgLay0ob9mcJmsbBm3yqv8RRI2/67Cf+kugfzKfPikllsEQnBArZYIPU7UbJm7VN2K8
	1aNnMThR7HUcRSk5IQirIkiMwEvHiJ9/Uk9h1XstlaE+1Y73IxK7pyKSVsMoOifb1oQc3ldXMSL
	SFjv7jakTNWB/TAhf500evHIbrBbwXquJNrTNjnKtU6XpKTJ5Be0j6hdoifKKCbAQaI8mXotygz
	v1HkYjxkgFhsqLRWersrSNf5iMN2nfBpIfSyYldjmk4Yauv7Qe7leVCkqUc2d7dTXrSG3OvuPPV
	Idk1zqOEXHIWORWQkRiWRSx/7CqKh5NcxMeWA/FXxHZIGM1HYXx7/KzKkUe2cH/mmg==
X-Received: by 2002:a17:90b:380c:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3ae896f8315mr16195357a91.11.1793859177566;
        Wed, 04 Nov 2026 22:12:57 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:12:57 -0800 (PST)
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
Subject: [PATCH v2 4/5] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Date: Thu,  5 Nov 2026 14:12:16 +0800
Message-ID: <20261105061217.13302-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105061217.13302-1-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
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
index a060a7150401..2fa5ce73b382 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -38,7 +38,6 @@
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
-#include <linux/vmemmap-optimization.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -5366,42 +5365,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
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
index 5c09da4df4d8..9d9f7a67d195 100644
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
@@ -134,15 +148,4 @@ static inline bool vmemmap_optimizable_pfn(unsigned long pfn, unsigned int order
 
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
index b8b55e12f5ba..71a927d67a9f 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -473,6 +473,9 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
+	/* Altmap-backed vmemmap pages cannot be optimized. */
+	if (altmap)
+		section_vmemmap_optimization_disable(start, end);
 	r = vmemmap_populate(start, end, nid, altmap);
 	if (r < 0)
 		return NULL;
@@ -700,10 +703,9 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
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


