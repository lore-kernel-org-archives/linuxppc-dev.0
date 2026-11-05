Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA23606A329
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HmrkNd1U
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKsRj2Plgz2xJR;
	Thu, 05 Nov 2026 17:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793859169;
	cv=none; b=PNOszyH7AiecWGjaqOOKK11nLPZTkraIocbBpjrdPMmKPM9k5dkT6z3a7h6ZDvp3HaEAAsHAtu/jwjgs0hkrtkjuXpuXjG+Crw60Tj9PMs8XWJbHCoJu1w1eZfK/e5YcMjIPPeGpdOh1eEO6G0BNzkEyCOuW+SvsnBnUcL/EIuh6unJQnwfgvWwFXlLS0NvxOfanzHms2uqAO+x7vss0TRB6BCMXnPP6cOaf74AjjyN7qHXLMUR2FzmQcqwGR83c8CkJZnMpFKOTplhp6NpYDyNrsmrW86CoZjkcSRvrdI3Ky89AbwTQqTUotaI+DAMPvhYEML8TFrcXS7G64zmaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793859169; c=relaxed/relaxed;
	bh=6Fm/jPwX8N/x42opaK4NB2WSpEb6W0SXK/qEq7+UeX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw8mUqm+kuYVP3MkGXIK4bTulkfuTJAjf76sGYUgAxBGWJ5PxicCFHXAV+kddAmLlsIeliJTmTuNrdiBQHJwq/DR7Yd4dZs2D1XUFyM7WGrzk93dNCWuoytZW/iYxie3jhcNCBmtr7VjnwTxnx3t1Yb2Kjvp/WyGm1KRpigg0M7QEQe3hVfar1+rgpUY/uL6yZ3yEoMdPmLVmUrEiDGe12EDSQ2JqbNqcRBLjcaF4zMuPI0Ba3gFu9kY/y4/aykBYSQsMPRc3zmrX/FfcuLM58p9HbxB+ZHG8An8tr91SUc0ZPzTYHh6T1PyVVERbnoqxRA6BiCkB04Y58WS7Ixn/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HmrkNd1U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HmrkNd1U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKsRh3sFqz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 17:12:48 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so1041253a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 22:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859166; x=1794463966; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Fm/jPwX8N/x42opaK4NB2WSpEb6W0SXK/qEq7+UeX8=;
        b=HmrkNd1UkDdD9ay2uL8s07B41nULaK7BOIpBlJyqREY37PyJWWIE6W9QxZVwQh5XVM
         CFFR2+U45+psLBTKx2satpJU89o8rd6R742FkkbJRGjQZNydVkw0kOME/fmDWc0+T6KF
         takSEu6fbCKjltW79/1x9pA9lLMqx8EKAe2wdyU0/lYONgoFdX5qT6zb7OyQN/kkH7vK
         3Jdj0emHSNkTMi4k1AMiLiIcvEt2JNt2xX7BpDSu0AynmoQ/4z7UNee7GydzKlWz94dc
         BMOasZ7o1sAge2l5pLOLWUpYNKaeICT6moAPUYu5UQEOmxWrMoPPm8dtecnZJKsWHCxg
         I+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859166; x=1794463966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Fm/jPwX8N/x42opaK4NB2WSpEb6W0SXK/qEq7+UeX8=;
        b=ipsurHV36rp2aCbfU/KPA9uz7XiFStqhmuE2r0zHNX4QBzD6wbYBsEsBEesIP/Ry1q
         ptloE9KVbU9dlg/0Kpwr3aG38yYX6oRUylAyoTnW5RH3go0W3nkqWkSpcKgUlQ0j4guD
         FfGq4Xwigwuos5wUtLxw2cJMUUyTtOFKVVHC2R10BIAgnrO9g21+RRAlN8uSZRy/+J/f
         G1KROWSBwjpXkEgiqtcZOUYyf3VXYI0vhPjejNNnfkoSHk2mugsr9geKPYHiFsOVBoL1
         gFVZldKeqDbQThectQnz6aZvYtElJoBKV+kagkH5JYfQoM3QOvX7ErO4lW4EUZlE5IKc
         NWMg==
X-Forwarded-Encrypted: i=1; AKwUvBzAFAAVwEMi6b6BHvN2dMrMQnuIax+TMIE0oy4vd9++W1ZaFmcjnpHUwBrgUJd6t1xkWSDbZ9FF76/7euQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/UmiJW/uG0dqD0ql9UzIqW7r0rRjY7VvNsGVCsQmQj0m9Ofuae
	LCQHhoje/2OLcjZiBRZqGrHjPNYm9QEMNTcSJ5++n0qyy0ER/z0Ln20H4Z7vbtqDAXs=
X-Gm-Gg: AYBFou2Lw9w5JfQV1m6dFB91laeO0x/gyfXoJYFEzxpfQIvV/Enj8s+Y6xN42y+ypc9
	OsblrCNX+e7F84wAOHoCYXWym8UiDx4F9XPFHykRi/t/kjOBCYNyrdHy6yW5ji+yzJSKBD3t6ZI
	Gxd6p/JAbzg0hR/TEajGR7uPqHKmVJg62fNkK4vhrc5IBOxtovxje5b1MHVOvz/nm70+Z58scPo
	LPMHufc/nEbN7n2jhmJNHAHLQVN6jmYBu2fGsyea4PjTS3m9QPSgmqtZnjLAJTcXaPQkm1tEo4S
	UQFf5EUtos7W+8ewq8bCBy8n76GKODPRvMgZsLQ53FvA3oEKJe7KORP5qIPBU9g1AyGy+DFw5AQ
	ZJDj6JKrfu/0UrEBBguxmqIRjkg7s6SDfiKSlaS/AsHoSqouax0J7XN0mxR/S+t5TyYkzAMY3lW
	emRjS6EuiMvYov5ULhCGXT00je7bjfRoqXO9dzxM5eUE5b46gEm14L1p6lo/Kkvqb3fd+GQPhW9
	0QIZZ6hdsYL9vOZcyQu9ihk+4eVb5xplT+enQkbH6gfPHyfXHgoQEcsh/x5RYbuuSRACgwLqTh8
	AvS9Z4dQOR3L6YgjzfLtD2EQ2Bay1aizbUdW/5+SCU89cBtxJNUCPJisjrKS7yzj/Q==
X-Received: by 2002:a17:90b:17cd:b0:3ac:b7b9:6471 with SMTP id 98e67ed59e1d1-3ae8987a7bfmr15528967a91.65.1793859166073;
        Wed, 04 Nov 2026 22:12:46 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:12:45 -0800 (PST)
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
Subject: [PATCH v2 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Date: Thu,  5 Nov 2026 14:12:14 +0800
Message-ID: <20261105061217.13302-3-songmuchun@bytedance.com>
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

Whether the optimized mapping can be used is now decided in the
architecture-specific vmemmap_populate() path. When PowerPC has to fall
back, such as on Hash MMU, it can disable optimization for the populated
vmemmap range there.

Add section_vmemmap_optimization_disable() to centralize this fallback,
use it in the Hash MMU path, and drop the radix-specific
vmemmap_can_optimize() override.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Add section_vmemmap_optimization_disable() for architecture fallbacks
- Use the helper for the PowerPC Hash MMU path
- Include vmemmap-optimization.h directly (reported by Sashiko)
---
 arch/powerpc/include/asm/book3s/64/radix.h |  5 ----
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 10 -------
 arch/powerpc/mm/init_64.c                  |  2 ++
 include/linux/vmemmap-optimization.h       | 31 ++++++++++++++++++++++
 mm/sparse.h                                |  5 ----
 5 files changed, 33 insertions(+), 20 deletions(-)

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
index 0e777d7dc332..4d6928f717cf 100644
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
@@ -282,6 +283,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		return radix__vmemmap_populate(start, end, node, altmap);
 #endif
 
+	section_vmemmap_optimization_disable(start, end);
 	return __vmemmap_populate(start, end, node, altmap);
 }
 
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
index 858311a71b0c..5c09da4df4d8 100644
--- a/include/linux/vmemmap-optimization.h
+++ b/include/linux/vmemmap-optimization.h
@@ -57,6 +57,27 @@ static inline void section_set_compound_order_range(unsigned long pfn,
 		section_set_compound_order(__nr_to_section(section_nr + i), order);
 }
 
+static inline bool section_vmemmap_optimizable(const struct mem_section *section)
+{
+	return vmemmap_optimizable_order(section_compound_order(section));
+}
+
+static inline void section_vmemmap_optimization_disable(unsigned long start,
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
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
+	section_set_compound_order(section, 0);
+}
+
 static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
 {
 	return section_compound_order(__pfn_to_section(pfn));
@@ -79,6 +100,16 @@ static inline void section_set_compound_order_range(unsigned long pfn,
 {
 }
 
+static inline bool section_vmemmap_optimizable(const struct mem_section *section)
+{
+	return false;
+}
+
+static inline void section_vmemmap_optimization_disable(unsigned long start,
+		unsigned long end)
+{
+}
+
 static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
 {
 	return 0;
diff --git a/mm/sparse.h b/mm/sparse.h
index fdbc4cacf91d..9b81a549d928 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -46,11 +46,6 @@ static inline size_t mem_section_usage_size(void)
 	return struct_size_t(struct mem_section_usage, pageblock_flags,
 			     BITS_TO_LONGS(SECTION_BLOCKFLAGS_BITS));
 }
-
-static inline bool section_vmemmap_optimizable(const struct mem_section *ms)
-{
-	return vmemmap_optimizable_order(section_compound_order(ms));
-}
 #else
 static inline void sparse_init(void) {}
 static inline void sparse_sections_init(void) {}
-- 
2.54.0


