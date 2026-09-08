Return-Path: <linuxppc-dev+bounces-26708-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C06C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:05:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf81G0Y8Fz2ygp;
	Tue, 08 Sep 2026 13:04:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836674;
	cv=none; b=bHLi1zodesoEwfW14DOdnuTjWbCRPvj2/6ZlaaOKArKch0KmpXbj2QqJPp3A5mVbFZT3gt8sptYESpV0U7FQ2RCSZ8fii6bWnALPos+eicbyJeh8jLWiCq+hiexchQCPIGQtpRFyozLH5B6e77hc/N8syjXhMYbSd/TbE8cuVD8Qt7oRTRl8V4iKJNjPe3n0n8AbVMyxc2dj8vlBU6whWMM3rgr0QN/RbewoOX7WB5OtyPaAnTAn4bNqGCeDjwnTx6RWeSrIZcL2em/uDuCSGrsETCrreZcUoXY29kC11muT1B+wDRCux+zZ9/sterhqkIahiWd6vnLG0oOzrLwnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836674; c=relaxed/relaxed;
	bh=CVT6j1P3zfNYXYnEjgM8kLQiWtuO+wz13pOr0ZtKdew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChAWoWY5vKytNReYbXlIdze1xV5NN4uBQa/V2xJWIweJ8ZcDeJ+jlqFQVf8mpN4F/cp1fNezqKQzk5uf19ISaTBXdHKASX2aLXtvU9K7ttF/Z3fzieBcFAe9f7ttROSatO08UG9yTbrbkm2L5FmeDi46Jd+i+hBqrnpfWH4Bxr1gxy/UHsA1U9iInTo3gVW6qcIOU10yW9jBxbL7Kv7pPuIz0HUR8xLFr3j9lpHSj5nlZ1iP5AFIHX3jfL4ANWA55GjjTSqWr5Kiy3YxwAURIE5VEtb859NxWue1VFX75hQSzdeMXbIXm/uB12DsSKAzdsQfgki7IQMyfSBI1fxIiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cyi5EKN4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cyi5EKN4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf81F2b6kz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:33 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2719595a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836671; x=1789441471; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CVT6j1P3zfNYXYnEjgM8kLQiWtuO+wz13pOr0ZtKdew=;
        b=cyi5EKN4ZFmkjA1UynpQ05uiRLk3o5bWefYl6HGaqa1LPolXKs1rC5qagoULBvp0vo
         e2iA+IGx11gbXZXDyjoUHk9ODO0pGZTy+ouVph4479gJHzAdvaARli8cakDiudCEuKeb
         ih8cYC3/QiFsUmGmJL/l+7NbEzx1/004RFjfzhkCGUKsjdTBdd+PfGPCxR5sEJD1r0qH
         FrjY+/DA7EF374aeENfzdspirPL6snqludSK1NNUowGevJC6L5C2PmB6Arfkoeyxq37M
         5ZyK7vvi/vKO8Y6gAACqHNZT2xi2Xf/N80ZML7F0UfMmn7zkeRPZVA9ECu5MMXSxcfNW
         sQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836671; x=1789441471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CVT6j1P3zfNYXYnEjgM8kLQiWtuO+wz13pOr0ZtKdew=;
        b=KJDN9GHmwQa9NsWKrrzeR7m9X4necN+uyuB+4ORo8KqFOm3m6IvbyEvDpTxHydLsBU
         NdrzDgMTj0ygVzTIqEZjoCXojOkS1C7CYpmVMbCeWX8+Hcd01uNbQ5oGO/Gf9FIHvqB2
         kPxCu9dmReSx+RZP8kE1PaUwb4bT8Sm1+HxLrqptPZdf8/MdR66tkYLopNAeXEneErOr
         /Rh/8mEtN59TTRA7nczPtwJosQ7VET/kCZtKCXCwkIBRLkZsX+H4ZI2ClQtKs0VIA1YU
         LCdeeX08U8Y/wlI3202cdgVo0iBOneO2Bb+4NkvYE+InR8IVdao/nxZ4HDnEl7Yz073Y
         O9tg==
X-Forwarded-Encrypted: i=1; AKwUvBwzpCHjQf1Nh+fqCjsPc/a9eDnIzTyPHHF8BSOx92GVfY8efO0mTWpt1VGOORYW01ox+plKtVbHfCHR1e8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l7M8hMiA0sLKBKhhnxwaYfhhLDYXZjfeBNJyWlGMmu3PBFlu9i
	U7n1Mj42qu0082zEP/swUqPKri+nFv+G6uYJWMmJ8oP6L1Oq7i+9Cnr4F7j+ZWwMIAU=
X-Gm-Gg: AYBFou21czA4JmUopaXxYF+gRkieRAzbPw0ueVelpqx/gN9ADEPA+AVFEm8fkld420N
	YIYAyxlnM+QqVnzjwXEB8INKnX4UjkGoj1lsCFAJ2p+8oyLTZxhkGH35TaoOGgR4jrTLYvYZB9S
	raQ0z4KXquNBfkflsC8QWveeeFd4knfgXYPgeFqSt9QSEGz39DT4Iu+a1miopdMKU/6UyjSVgen
	3Ok1ykoxrPc1OggSat05uJ2i4g/TXuiqg3TBIg14zRsuEDmC2UMiXIDngg7M/zxdLHne6LGvn/l
	iKFityhvVBYXo4weJ1ot88A+ujW2HCRnsaRRuB/yPjRSTcl2aoDk1rOHox8oi02XhzPwOiMYe4s
	3ns54AkDUoezwWQiCDNKrKjheXiKZGEtPmMi6AXxL5L1ErfdeMm8IB8d49vT0f+p8RrDu25J/R2
	ww51GAj+aXHRmJ7kHKdXcIR4uF1aoiSKm3bbK5+5T5AgZeBR6kaAZO2o8pmVUT5o7O1Rnpk+u20
	8PVIrXfZzdC7RBPUhEpV2bM
X-Received: by 2002:a05:6a00:8c3:b0:856:30dd:91ba with SMTP id d2e1a72fcca58-86168e8bb34mr33801118b3a.2.1788836670753;
        Mon, 07 Sep 2026 20:04:30 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:30 -0700 (PDT)
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
Subject: [PATCH v2 07/11] mm/sparse-vmemmap: move HVO helpers to a public header
Date: Tue,  8 Sep 2026 11:03:31 +0800
Message-ID: <20260908030335.96549-8-songmuchun@bytedance.com>
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

The vmemmap optimization helpers currently live in mm/sparse.h,
which is an internal MM header. That works for MM code, but
prevents powerpc from using the same interfaces without including a
private header.

Move the declarations and inline helpers to
include/linux/vmemmap-optimization.h. This is a preparatory change for
powerpc, which has its own vmemmap optimization implementation and
needs to use the HVO interfaces from architecture code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Fix missing header dependencies.
---
 MAINTAINERS                          |  1 +
 include/linux/vmemmap-optimization.h | 91 ++++++++++++++++++++++++++++
 mm/hugetlb.c                         |  2 +-
 mm/hugetlb_vmemmap.c                 |  2 +-
 mm/memory_hotplug.c                  |  1 +
 mm/sparse.h                          | 73 +---------------------
 6 files changed, 96 insertions(+), 74 deletions(-)
 create mode 100644 include/linux/vmemmap-optimization.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c7aaa2e4790e..2985286cbbbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12096,6 +12096,7 @@ F:	Documentation/mm/hugetlbfs_reserv.rst
 F:	Documentation/mm/vmemmap_dedup.rst
 F:	fs/hugetlbfs/
 F:	include/linux/hugetlb.h
+F:	include/linux/vmemmap-optimization.h
 F:	include/trace/events/hugetlbfs.h
 F:	mm/hugetlb.c
 F:	mm/hugetlb_cgroup.c
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
new file mode 100644
index 000000000000..492dc662aae7
--- /dev/null
+++ b/include/linux/vmemmap-optimization.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * vmemmap-optimization.h
+ *
+ * Generic vmemmap optimization declarations.
+ *
+ * Author: Muchun Song <songmuchun@bytedance.com>
+ */
+#ifndef _LINUX_VMEMMAP_OPTIMIZATION_H
+#define _LINUX_VMEMMAP_OPTIMIZATION_H
+
+#include <linux/align.h>
+#include <linux/log2.h>
+#include <linux/mmdebug.h>
+#include <linux/mmzone.h>
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
+static inline unsigned int section_order(const struct mem_section *section)
+{
+	return section->order;
+}
+
+static inline void section_set_order(struct mem_section *section, unsigned int order)
+{
+	VM_WARN_ON(section_order(section) && order && section_order(section) != order);
+	section->order = order;
+}
+
+static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
+					   unsigned int order)
+{
+	unsigned long section_nr = pfn_to_section_nr(pfn);
+
+	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))
+		return;
+
+	for (unsigned long i = 0; i < nr_pages / PAGES_PER_SECTION; i++)
+		section_set_order(__nr_to_section(section_nr + i), order);
+}
+
+static inline unsigned int pfn_to_section_order(unsigned long pfn)
+{
+	return section_order(__pfn_to_section(pfn));
+}
+#else
+static inline unsigned int section_order(const struct mem_section *section)
+{
+	return 0;
+}
+
+static inline void section_set_order(struct mem_section *section, unsigned int order)
+{
+}
+
+static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
+					   unsigned int order)
+{
+}
+
+static inline unsigned int pfn_to_section_order(unsigned long pfn)
+{
+	return 0;
+}
+#endif /* CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION */
+
+static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
+{
+	const unsigned int order = pfn_to_section_order(pfn);
+	const unsigned long nr_pages = 1UL << order;
+
+	if (!is_power_of_2(sizeof(struct page)))
+		return false;
+
+	return (pfn & (nr_pages - 1)) >= VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES;
+}
+
+static inline bool vmemmap_optimizable_order(unsigned int order)
+{
+	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION))
+		return false;
+
+	if (!is_power_of_2(sizeof(struct page)))
+		return false;
+
+	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
+}
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+#endif /* _LINUX_VMEMMAP_OPTIMIZATION_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fda525bccf50..dff915e6c48b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -38,6 +38,7 @@
 #include <linux/mm_inline.h>
 #include <linux/padata.h>
 #include <linux/pgalloc.h>
+#include <linux/vmemmap-optimization.h>
 
 #include <asm/page.h>
 #include <asm/tlb.h>
@@ -52,7 +53,6 @@
 #include "hugetlb_cma.h"
 #include "hugetlb_internal.h"
 #include "mm_init.h"
-#include "sparse.h"
 #include <linux/page-isolation.h>
 
 #define HUGE_BOOTMEM_ZONES_VALID	BIT(0)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4a57e6c3352c..25c4e7d2664c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -15,10 +15,10 @@
 #include <linux/mmdebug.h>
 #include <linux/pagewalk.h>
 #include <linux/pgalloc.h>
+#include <linux/vmemmap-optimization.h>
 
 #include <asm/tlbflush.h>
 #include "hugetlb_vmemmap.h"
-#include "sparse.h"
 #include "internal.h"
 
 /**
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0db0379826df..d7a59167bec4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -43,6 +43,7 @@
 #include "mm_init.h"
 #include "page_alloc.h"
 #include "shuffle.h"
+#include "sparse.h"
 
 enum {
 	MEMMAP_ON_MEMORY_DISABLE = 0,
diff --git a/mm/sparse.h b/mm/sparse.h
index 59b825df83b9..e511d99fc26b 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -9,77 +9,7 @@
 #define __MM_SPARSE_H
 
 #include <linux/mmzone.h>
-
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
-static inline unsigned int section_order(const struct mem_section *section)
-{
-	return section->order;
-}
-
-static inline void section_set_order(struct mem_section *section, unsigned int order)
-{
-	VM_WARN_ON(section_order(section) && order && section_order(section) != order);
-	section->order = order;
-}
-
-static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
-					   unsigned int order)
-{
-	unsigned long section_nr = pfn_to_section_nr(pfn);
-
-	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))
-		return;
-
-	for (unsigned long i = 0; i < nr_pages / PAGES_PER_SECTION; i++)
-		section_set_order(__nr_to_section(section_nr + i), order);
-}
-
-static inline unsigned int pfn_to_section_order(unsigned long pfn)
-{
-	return section_order(__pfn_to_section(pfn));
-}
-#else
-static inline unsigned int section_order(const struct mem_section *section)
-{
-	return 0;
-}
-
-static inline void section_set_order(struct mem_section *section, unsigned int order)
-{
-}
-
-static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
-					   unsigned int order)
-{
-}
-
-static inline unsigned int pfn_to_section_order(unsigned long pfn)
-{
-	return 0;
-}
-#endif
-
-static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
-{
-	const unsigned int order = pfn_to_section_order(pfn);
-	const unsigned long nr_pages = 1UL << order;
-
-	if (!is_power_of_2(sizeof(struct page)))
-		return false;
-
-	return (pfn & (nr_pages - 1)) >= VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES;
-}
-
-static inline bool vmemmap_optimizable_order(unsigned int order)
-{
-	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION))
-		return false;
-
-	if (!is_power_of_2(sizeof(struct page)))
-		return false;
-
-	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
-}
+#include <linux/vmemmap-optimization.h>
 
 /*
  * mm/sparse.c
@@ -139,7 +69,6 @@ static inline void sparse_sections_init(void) {}
  * mm/sparse-vmemmap.c
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 void sparse_init_subsection_map(void);
 int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-- 
2.54.0


