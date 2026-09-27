Return-Path: <linuxppc-dev+bounces-28300-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7082FC98328
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:55:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspw452xvz30Vm;
	Sun, 27 Sep 2026 12:55:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477732;
	cv=none; b=O+mM90b15Oiy6u3Pf1j393jxHdN+ByRHKj+greZ2tRSp4qDRSMs6OjujRFwQ3PDeCtZ/JMP0Y+xyI9KkcMHyUTKveiyjKGksekUlnn0Yk1qbYNB5S42rUCYkmAhO9WcC6pYhTnivYZfXOSPoA3GT0c7dnIRUmf2rzAaui9vj2DeM7W8E73Zdb7l/IghXuDDru9bNby9Erd/jpxB/HA56XKhkJeCLJm4sp9USvp1pikFiTbMQesVfDVYh8Hdjzk9N0MsKp93wvDQRQQAzz/CjFp/zgQI8sQk1A82s5/iu7MHh93AAPmaq54e/8MhXCJnLGqPijCPD8xGPqc4vBVDpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477732; c=relaxed/relaxed;
	bh=pAcaB474KEF0IVelcpOPWrCamxFeX3XsOjErZzGRGOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhoBlcRJ87lO1rQ4yPCF/WVb1AGOUnYhM75PAodefzWRsiiOM6WHEEWmEuTMTg0E3QEr8FLJ1I8U3TICzalmZssfQ31yUKTsgq8r13Q/yZisMAOLgndgItS3lyq0+Wa1TzUJgjTQ68/7wdLFOzPNl6yY8y26qq9syGsx9t9iqQtyMT587XV4adzWWiC5AqRw1Rt7X028dYYUb3iMvUl1qdtSFVy79/q8P3o8hwkxtdz8E7O73+hxfUVbxvXfLOxt82KrjKHi3REz4Dw5nsY5fdL3pvj1FJWGeWKsa+prLGGbiDYUUXYquEFA5jHiJDwBnqt4qr3T8TgsrAqkMVcQ8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O0QXwRPE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::d; helo=mail-pj2-x0d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O0QXwRPE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::d; helo=mail-pj2-x0d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0d.google.com (mail-pj2-x0d.google.com [IPv6:2607:f8b0:4864:39::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspw35nJCz3048
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:31 +1000 (AEST)
Received: by mail-pj2-x0d.google.com with SMTP id 98e67ed59e1d1-3a0bd71827eso1035491a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477730; x=1791082530; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAcaB474KEF0IVelcpOPWrCamxFeX3XsOjErZzGRGOo=;
        b=O0QXwRPEqG0wCIseNf0C6Y+ykzER5psKdVMR8oT2rqk0+XrKPZwM2CsSU5DXpI7fek
         SoAzE5vJHt88p8BB6IN1PkBBS1aGa3cEznMijC/6VSus3XDjgEt69OMpVS4e871K8fa4
         R7aYEgnW4jJqXTUw7hvJWo/qO39BPZDIZ/W/coPyz4X+Cl5uioRQw7m9NvilDBbPwPZO
         RwsnQldAVOdA36wpeLJEtzOGeClwUbKE8czGVxKGrfu7xmblnzWT9vqxnMBI5m49WsFo
         R3Sildpbx3s9W+tTb4ywhsqNbJUXsxsq82j4IAdPdNT3+0c+GqUQg5tGnmPumP4mPzbi
         qmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477730; x=1791082530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pAcaB474KEF0IVelcpOPWrCamxFeX3XsOjErZzGRGOo=;
        b=GzYXwpubTLyn+YGWVHTq6+ZeLZJOPy/7vEekQvWADk7X2ac5qbTfM0giwKW9Y2cBhl
         LUv0y1No5i/m4+R48BMk7wvq5/N/friNWfu0Z4hb32J4fR+WjVKnag1cEBNticSLJ3w1
         /jnWh3148spMQ0fSc0Vmf0G38s1GqRNM2CF5P8xauLD4cP56qOho3MkEkVplFD+BAipa
         GEkW8sVWODNVVh9/NtWUFP6uvWGS+mL77JP4dcjbwKEvKohU9e0mU6I1ixa+Xz5Zu9U/
         kZLCyHiJygLaoMsD+sVa16TKnqw8y33KYwUaiXteJmlBJTj99VOmY9sxu4dB68hWwlPz
         VXpg==
X-Forwarded-Encrypted: i=1; AKwUvBz+Dib3mVYh670sR6eghk8d3ri09COZDC1pFWmI0kWWWByIzKT3jk4xujuOw5sl2MH80OAMWcsUAwZrtB8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJPakTE4PFbUm8KG8Z5Tvuhrnk+PnX1FRY3k51lgUoJI7VSP4Zg
	nnGbrYU5mNUDSqkWCPcY3Hi/VGlM9uWuxi3AbWdWD/itMgUaGgIjOK5k9yS8RsThxLM=
X-Gm-Gg: AYBFou10UAFjjVAjqS1EW05ltWddaBXxXwBe/qfZkM9Ho0TVLkjy+Cpn82mwuav+kOR
	cgpXXQvEvXe+Z/GclNt10IuTszkSYRuRbcRKV+cLGe6VBKLVZrFKHloOEOscpkwtSXOo9CjMQ4y
	5GOrZL5sofPetBHp7X6oK1oiwCKsxcIVu/311AXK1mU2Gm/kmw8iS7iLQxmGekLFrPbuHtS+xs9
	ienRJ43D3SZ+DX8LBd8nO04WxmSJvgxpQ8zSJzJ88VLcK6nn4+Zqgr6nfMV7oT0RGv+bmfzeu6d
	NpqrfZay9MwqWiappRzEONnKaiVr/ZwMReGHGMCN+9zl6rcTAqmoq6UrDRyXd4RCef6JGMDROHk
	szEoz7De528dBV65rvES5NHtf97t5NYK8vOBgap6g/iv77Y1Hxclc3UEXPVAj+dMQuO8dMtMvHu
	2JEmjWq8X9IHNREqUcmrpzoOpaYAxlafXwrBGB48G+ITmI11Bu3E6cRCSzv2LhWEYOAU1ULnw7G
	KqqcGtmq8OilkW9QWOj
X-Received: by 2002:a17:90a:d41:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3a0986079a8mr5017252a91.26.1790477729889;
        Sat, 26 Sep 2026 19:55:29 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:29 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 08/12] mm/sparse-vmemmap: move vmemmap optimization helpers to a public header
Date: Sun, 27 Sep 2026 10:54:37 +0800
Message-ID: <20260927025441.741633-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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

Move the declarations and inline helpers to vmemmap-optimization.h.
This is a preparatory change for powerpc, which has its own vmemmap
optimization implementation and needs to use the common vmemmap
optimization interfaces from architecture code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v5:
- Move the VMEMMAP_OPTIMIZATION_* macros and MAX_FOLIO_VMEMMAP_ALIGN to
  vmemmap-optimization.h

v4:
- Use the renamed VMEMMAP_OPTIMIZATION config in the public header
- Collect Acked-by from Mike Rapoport

v3:
- Update the subject and commit message to describe common vmemmap
  optimization helpers
- Collect Acked-by from Qi Zheng

v2:
- Fix missing header dependencies.
---
 MAINTAINERS                          |   1 +
 arch/loongarch/include/asm/pgtable.h |   1 +
 arch/riscv/mm/init.c                 |   1 +
 include/linux/mmzone.h               |  17 -----
 include/linux/vmemmap-optimization.h | 109 +++++++++++++++++++++++++++
 mm/hugetlb.c                         |   2 +-
 mm/hugetlb_vmemmap.c                 |   2 +-
 mm/sparse.h                          |  78 +------------------
 8 files changed, 115 insertions(+), 96 deletions(-)
 create mode 100644 include/linux/vmemmap-optimization.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7eae9228f547..6aa7308cb6c3 100644
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
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index cf29a4c8ac59..f87603135131 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -72,6 +72,7 @@
 
 #include <linux/mm_types.h>
 #include <linux/mmzone.h>
+#include <linux/vmemmap-optimization.h>
 #include <asm/fixmap.h>
 #include <asm/sparsemem.h>
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fb37b0b67efe..857f9a55039c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/hugetlb.h>
 #include <linux/kfence.h>
 #include <linux/execmem.h>
+#include <linux/vmemmap-optimization.h>
 
 #include <asm/alternative.h>
 #include <asm/fixmap.h>
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index cd68c1904c91..65de3bb13eb3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -96,23 +96,6 @@
 
 #define MAX_FOLIO_NR_PAGES	(1UL << MAX_FOLIO_ORDER)
 
-/*
- * HugeTLB Vmemmap Optimization (HVO) requires struct pages of the head page to
- * be naturally aligned with regard to the folio size.
- *
- * HVO which is only active if the size of struct page is a power of 2.
- */
-#define MAX_FOLIO_VMEMMAP_ALIGN					\
-	(IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION) &&		\
-	 is_power_of_2(sizeof(struct page)) ?			\
-	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
-
-/* The number of retained vmemmap pages with HVO enabled. */
-#define VMEMMAP_OPTIMIZATION_PAGES		1
-#define VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES	\
-	(VMEMMAP_OPTIMIZATION_PAGES * PAGE_SIZE / sizeof(struct page))
-#define VMEMMAP_OPTIMIZATION_MIN_ORDER		(ilog2(VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) + 1)
-
 enum migratetype {
 	MIGRATE_UNMOVABLE,
 	MIGRATE_MOVABLE,
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
new file mode 100644
index 000000000000..bd0974b262a4
--- /dev/null
+++ b/include/linux/vmemmap-optimization.h
@@ -0,0 +1,109 @@
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
+/*
+ * HugeTLB Vmemmap Optimization (HVO) requires struct pages of the head page to
+ * be naturally aligned with regard to the folio size.
+ *
+ * HVO which is only active if the size of struct page is a power of 2.
+ */
+#define MAX_FOLIO_VMEMMAP_ALIGN					\
+	(IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION) &&		\
+	 is_power_of_2(sizeof(struct page)) ?			\
+	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
+
+/* The number of retained vmemmap pages with HVO enabled. */
+#define VMEMMAP_OPTIMIZATION_PAGES		1
+#define VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES	\
+	(VMEMMAP_OPTIMIZATION_PAGES * PAGE_SIZE / sizeof(struct page))
+#define VMEMMAP_OPTIMIZATION_MIN_ORDER		(ilog2(VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) + 1)
+
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
+static inline unsigned int section_compound_order(const struct mem_section *section)
+{
+	return section->compound_page_order;
+}
+
+static inline void section_set_compound_order(struct mem_section *section,
+					      unsigned int order)
+{
+	VM_WARN_ON(section_compound_order(section) && order &&
+		   section_compound_order(section) != order);
+	section->compound_page_order = order;
+}
+
+static inline void section_set_compound_order_range(unsigned long pfn,
+		unsigned long nr_pages, unsigned int order)
+{
+	unsigned long section_nr = pfn_to_section_nr(pfn);
+
+	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))
+		return;
+
+	for (unsigned long i = 0; i < nr_pages / PAGES_PER_SECTION; i++)
+		section_set_compound_order(__nr_to_section(section_nr + i), order);
+}
+
+static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
+{
+	return section_compound_order(__pfn_to_section(pfn));
+}
+
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
+#else
+static inline unsigned int section_compound_order(const struct mem_section *section)
+{
+	return 0;
+}
+
+static inline void section_set_compound_order(struct mem_section *section,
+					      unsigned int order)
+{
+}
+
+static inline void section_set_compound_order_range(unsigned long pfn,
+		unsigned long nr_pages, unsigned int order)
+{
+}
+
+static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
+{
+	return 0;
+}
+#endif /* CONFIG_VMEMMAP_OPTIMIZATION */
+
+static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
+{
+	const unsigned int order = pfn_to_section_compound_order(pfn);
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
+	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
+		return false;
+
+	if (!is_power_of_2(sizeof(struct page)))
+		return false;
+
+	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
+}
+#endif /* _LINUX_VMEMMAP_OPTIMIZATION_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fd00141b089a..2003439ea13c 100644
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
index 76765c97ff68..0057fa2a16a8 100644
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
 
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
diff --git a/mm/sparse.h b/mm/sparse.h
index 326ad43bb5c3..a5111087ee3a 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -9,80 +9,7 @@
 #define __MM_SPARSE_H
 
 #include <linux/mmzone.h>
-
-#ifdef CONFIG_VMEMMAP_OPTIMIZATION
-static inline unsigned int section_compound_order(const struct mem_section *section)
-{
-	return section->compound_page_order;
-}
-
-static inline void section_set_compound_order(struct mem_section *section,
-					      unsigned int order)
-{
-	VM_WARN_ON(section_compound_order(section) && order &&
-		   section_compound_order(section) != order);
-	section->compound_page_order = order;
-}
-
-static inline void section_set_compound_order_range(unsigned long pfn,
-		unsigned long nr_pages, unsigned int order)
-{
-	unsigned long section_nr = pfn_to_section_nr(pfn);
-
-	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))
-		return;
-
-	for (unsigned long i = 0; i < nr_pages / PAGES_PER_SECTION; i++)
-		section_set_compound_order(__nr_to_section(section_nr + i), order);
-}
-
-static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
-{
-	return section_compound_order(__pfn_to_section(pfn));
-}
-#else
-static inline unsigned int section_compound_order(const struct mem_section *section)
-{
-	return 0;
-}
-
-static inline void section_set_compound_order(struct mem_section *section,
-					      unsigned int order)
-{
-}
-
-static inline void section_set_compound_order_range(unsigned long pfn,
-		unsigned long nr_pages, unsigned int order)
-{
-}
-
-static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
-{
-	return 0;
-}
-#endif
-
-static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
-{
-	const unsigned int order = pfn_to_section_compound_order(pfn);
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
-	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
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
@@ -142,9 +69,6 @@ static inline void sparse_sections_init(void) {}
  * mm/sparse-vmemmap.c
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-#ifdef CONFIG_VMEMMAP_OPTIMIZATION
-struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
-#endif
 void sparse_init_subsection_map(void);
 int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-- 
2.54.0


