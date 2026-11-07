Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36814606A331
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 04:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TaKxuzOo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jM36n53f7z2y2K;
	Sat, 07 Nov 2026 15:32:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794025937;
	cv=none; b=ShE4EUREwwL/NeqtChA2q1J/5t8O9vNrqPaQZgAXfnSNT2+NkM9Zsm7vCgssHqsSyXem3YFDGR8F+fJtMgB0bc4SVl5N1jJGIvO7Moi/foP21nGlvAWQVFMTM6CMEhoYGWMU2KZqmAxgut0M2ssNYPXXVc3NnPplXCD9iSLiNMB949KZD6XejFfeV+1a9/P6Q1x/4h912YGtnCmcmh0M5YUOzfA9VorOw4rmZxMkFPgqmX9efkPbbWqzSFYa9TC0gzLgzqD1d9zNKbXU1JO7nPOwDx1sx6XCRmIrqut1V4/WE8MACOvgpCaT0CF061o1ZTiQ/nnnBvBGjKU+kcSIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794025937; c=relaxed/relaxed;
	bh=EjmiDhGTyjFqhaR2vuKwqHt93n+hCHkzTadeMRKHv0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi7jyjdZs1kmhOyVD31j/trOlV4okWgZzifeW61Ln5vFfWHjG8tz3k4wk6/rtVd8ipRyqjCSabbxnQ+BcVd7fb8D1EFfcAE3df3tCrf8XW8hcxUEt6QQ1RnHKZCVqiRSpa1HGQxEs6fYWOI7o7vNq4snsduCIeEZNH3nX/uxdtTqlm/iiODyrLjyJDZ5bmKlDI+ojDqbvCFixk7UYnDdfyDx8d+ZppfqtRqpHtGuS6Al6GFDNMwv79kb4dDRBNojRhjZqvRpwHc9t4qMRDP42PwHeFdhv28fXj5OKIxGZ22wFD3j0d3VOsI9Vl3bkQfzHVJTP9Lsmi46EBtOOZyS7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TaKxuzOo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TaKxuzOo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jM36m6T2nz2xS6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 15:32:16 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so744172a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 20:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794025934; x=1794630734; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjmiDhGTyjFqhaR2vuKwqHt93n+hCHkzTadeMRKHv0k=;
        b=TaKxuzOo5pY3PMkInIYrPRer4fA3SaeDQWkaEFvHotks9me2+tXPjH4USwouzISgrO
         6HZ5QT44phgGJG4lRIw566J9yzoRh7yNKrqeijUqrDAxHfpKXBNLxdJUPxzLOF7BmRsO
         oDSeOFV4jZcEHDSr38ht70D8Vs85P8ejOhg8F0PomW3zJ2urBV9MeHJRD0qz8dVh1afp
         WbRDaeI1Tz/V6jAJoaaUtqoRVrfhAMj3qOUUaGpWSB+gfeqTrY67HvaISvZqUU3y/JAq
         tHVvZRhoACCCWVvQSRdZhVXMBGZCWiTa10NRmO7d3WmX4EG9O71U8H66K6D6jy9HE6vz
         QX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025934; x=1794630734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjmiDhGTyjFqhaR2vuKwqHt93n+hCHkzTadeMRKHv0k=;
        b=p4/0y8i6SsTeApQW38gMn4XZ5pnh/I7nZAcTmc0tmlMjkwByTSSR9DBWsYijxZ0G+5
         GxP2UNfv+J/inOuKniP01Zb7fY7QyYNsE6Om0PDNoj5kUSP2laXqRUeHceBT855V6aYO
         yw71G1lHRBBH7fZY4NfgIT/1dYiUyUJDD8yiFj+6/9/VlsINXTr8TllObtQExF/BVR1f
         nBMxcXfBrihiWVWS/T5TqI4BG981A1JexafB7hQB0Pv6VGArAmuOzbrJuPgWfuKBCWz8
         PafNSA+ReKOR7AgcXlpIyfo0BuVeis0CYcAfuRIxpsKAlFhvKyG46Zv3gNXUTU2ZM5ET
         MYBg==
X-Forwarded-Encrypted: i=1; AL+hErFA44kSNky89yzqxy2BgIYq/oOJXAS17C8sIzbyN+1ECGn6M7cDbx2iYujaUp2tFayu7VC6HGOAjo0MDc8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9LUEcgJgseH0mVTTvm29QKVNV+d8ujfluJSomNDJAGo9e/EdVp
	IZXPjiLx/mf34dlPtVHFW7y/K4KKBli4R+2/9T2eiiqE0MvMkTGD92OUZ48ZUSsZ6yE=
X-Gm-Gg: AYBFou2eoG4QNdVBAnkBbriz5O/D2eTjKHVlCp7RxB46balbWID+5XbrWG6XnYvLzA/
	T2TjXYG+zpTQpAsfle35qZMIo86TzdVp18BSq7Zc3eQ3P59NdLQGhMmZLL3ZtrAoqMRHESLC/SC
	+RE1K/lWj9pKMYAig2TWFYCIaY3sNAjaGg9N8J74uNNE2FgBuICrVqqlbsmi1XchVAh0XZeFUn2
	dlikVUT998uLDNE81wedQDOJxiYT1QAF/hBLaaMIvTlc2rXJSPsAd1kkycdNbJij5W8Skqle/OS
	Y5gbs9r5Dal07fL6JMEFj4Sam21TVNUbRuxNPI2+jBbJ4AMSSu2pv4NKYAuBajTywlA5BK4gh/9
	BUyaGge0Hl+H6l2vrDJGYevih7r0tQEGXM+v0d1WSCfa8OAfS28qqXrpAa3Nfq06nKlOmwnnKED
	N/skF1i3Qwgr5fJQ+kE6nk2zZkPkffEGBErqqHwwbEiSSFmwoPLBRKsOHK3JAji0SKg2E8Uf/D0
	4z1ljysLwyEbKz7RbqbTIul2/bA3rBpGwRqCWS86Wlmzo5bVnuwSQi/yyW9KOzJC2GEYF0YCRmb
	M7M5RZbDFLiteZUERwrGtn1oZ1lKMp5DdXAOrgNkgBq3pXHgu0frBRoQ93Sa
X-Received: by 2002:a17:90b:28c4:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b0db7114f1mr4190441a91.40.1794025934315;
        Fri, 06 Nov 2026 20:32:14 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10584b66bsm1578451a91.14.2026.11.06.20.32.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:32:13 -0800 (PST)
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
Subject: [PATCH v3 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Date: Sat,  7 Nov 2026 12:31:19 +0800
Message-ID: <20261107043122.25650-3-songmuchun@bytedance.com>
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

Whether the optimized mapping can be used is now decided in the
architecture-specific vmemmap_populate() path. When PowerPC has to fall
back, such as on Hash MMU, it can disable optimization for the populated
vmemmap range there.

Add section_vmemmap_optimization_disable() to centralize this fallback,
use it in the Hash MMU path, and drop the radix-specific
vmemmap_can_optimize() override.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v3:
- Move section_vmemmap_optimization_disable() to mm/sparse-vmemmap.c
  to avoid the LoongArch header dependency (reported by Sashiko)

v2:
- Add section_vmemmap_optimization_disable() for architecture fallbacks
- Use the helper for the PowerPC Hash MMU path
- Include vmemmap-optimization.h directly (reported by Sashiko)
---
 arch/powerpc/include/asm/book3s/64/radix.h |  5 -----
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 10 ----------
 arch/powerpc/mm/init_64.c                  |  2 ++
 include/linux/vmemmap-optimization.h       |  6 ++++++
 mm/sparse-vmemmap.c                        | 17 +++++++++++++++++
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 8452a2714cb1..df67209b0c5b 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -351,10 +351,5 @@ int radix__create_section_mapping(unsigned long start, unsigned long end,
 				  int nid, pgprot_t prot);
 int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
-
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-#define vmemmap_can_optimize vmemmap_can_optimize
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-#endif
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 2924604fbb38..63f369d296b4 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -978,16 +978,6 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
-{
-	if (radix_enabled())
-		return __vmemmap_can_optimize(altmap, pgmap);
-
-	return false;
-}
-#endif
-
 int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 				unsigned long addr, unsigned long next)
 {
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 0e777d7dc332..7329fcacdaf4 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/vmemmap-optimization.h>
 #include <linux/swap.h>
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
@@ -281,6 +282,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	if (radix_enabled())
 		return radix__vmemmap_populate(start, end, node, altmap);
 #endif
+	section_vmemmap_optimization_disable(start, end);
 
 	return __vmemmap_populate(start, end, node, altmap);
 }
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
index 858311a71b0c..22e5a322be0b 100644
--- a/include/linux/vmemmap-optimization.h
+++ b/include/linux/vmemmap-optimization.h
@@ -63,6 +63,7 @@ static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
 }
 
 struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
+void section_vmemmap_optimization_disable(unsigned long start, unsigned long end);
 #else
 static inline unsigned int section_compound_order(const struct mem_section *section)
 {
@@ -79,6 +80,11 @@ static inline void section_set_compound_order_range(unsigned long pfn,
 {
 }
 
+static inline void section_vmemmap_optimization_disable(unsigned long start,
+		unsigned long end)
+{
+}
+
 static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
 {
 	return 0;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b8b55e12f5ba..57aa5c2d8034 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -232,6 +232,23 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 
 	return page;
 }
+
+void __meminit section_vmemmap_optimization_disable(unsigned long start,
+		unsigned long end)
+{
+	unsigned long pfn = page_to_pfn((struct page *)start);
+	unsigned long nr_pages = (end - start) / sizeof(struct page);
+	struct mem_section *section = __pfn_to_section(pfn);
+
+	if (nr_pages < PAGES_PER_SECTION) {
+		VM_WARN_ON_ONCE(section_vmemmap_optimizable(section));
+		return;
+	}
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SECTION));
+	VM_WARN_ON_ONCE(nr_pages != PAGES_PER_SECTION);
+	section_set_compound_order(section, 0);
+}
 #endif
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-- 
2.54.0


