Return-Path: <linuxppc-dev+bounces-27464-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD35C88E5C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:45:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8WH48qzz2yps;
	Wed, 16 Sep 2026 16:44:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541067;
	cv=none; b=nrcJYjRAjbhBHtJ7G7e6X9bwfaLqARCd1JmAXk48sUmAzQ6YnVYoYWvBbiFWhQMQ1SI7E6rpjcXUzhhqqQd6hYZtrAJ+haPLk3x0YeyCXwD5wwMFn4k+Kbfl7hY6ZAjw33cO4qrP8BJ4PEWyZ70WhxSFXvY/8GOwtruJjX87QG7q0hxoKTPFCDAqNjgWp7K/B9LbUFFhDwv0kmzvgTntTkKEVbChuffdz/HXB0CnXETAt/eQeegZuelf3lKweuz3C3ApzKxKmhjJUmsFuOvhOoCdmgLddpjBeBSkwf3r8jR5j+UGUtir1jTUHfg/DPtqNSMgT3oj7RYalO82h3P47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541067; c=relaxed/relaxed;
	bh=nO/SIiOPBpUCTQXEHAeYL+mDwPc1g15QDptSjej1KB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9czGhMppu4my7sAEo6vkV9WnFDRHvkEkDXj86uNR8S3qBwg/r77cde22EY+637vTFzvelA00aR2TgZ3Gsict3RY6zBKUNXamlif0BDink77bliTohXn58kcDk9DjPbtk9Y4G13sE5d6IHnCt90PWVv46PH3V7QpEEBiMKlyJ105CgU/zm9+9y0tSULlctrPfW6ZmKiw2SpvmZTf4sBI0j86K5qimzeUFkTxbip6atkfI9ZpFr0ZCC6Is0XJ5ndFSz+5RM9URGmn6ILheDcpegXC7hPUzG0Ce9bUPzz9FqrWItRcr134GALe+jKJzi60xvh5EEfBpqt9sOUSSRFfww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KIoRLwzC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KIoRLwzC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8WG5DhQz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:44:26 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id d9443c01a7336-2dd88a115c1so6147135ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541065; x=1790145865; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nO/SIiOPBpUCTQXEHAeYL+mDwPc1g15QDptSjej1KB0=;
        b=KIoRLwzCHLr6kEEPlazQat4O4d3347W5oIcDAQkWIQBCO+eU0aTPXHzY+m1VVgdoxl
         FK/dulETY0wZRp6PJUCJifVUB1FkFE/EpvjVRCegPWZXTElag+RUoYzB0r0Tr7x2sh9e
         EqFvQDx7NNVlG9WRKED5MErzvtjbXlCIG5T6yysTUnqlrTSpgqNRvIifrOHWiLDPcmkL
         FpvHQKjdkLfx6BMOynbvc3vUIHMSde7m3d200eL9Eh8Wpuq4sUsv6iyhpUPhx6HVsURr
         kesP/k5TCeFvwCoazgXMBeStDKk4NLbEsjAz73jfc3nGoiCgnmooGdQXY70QRyGsJR7Y
         BFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541065; x=1790145865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nO/SIiOPBpUCTQXEHAeYL+mDwPc1g15QDptSjej1KB0=;
        b=pQliolxKKxmeu1GvVSSjFS+fTvDq1b/pa/MRnywYYXmGd60GQ0M5nusf+f8yBDMTxm
         0pLxzAyXLFnfQgnl8xhhL5ULnDuLS+x3iweB7SkXmPRf52E5qnRGm+BMxpcx4D1PPdP6
         Q7GfYqjM42MPEj5w8ue7kipZNClUTx6FIJkgz8OLgghTgbrz9dWZc9iYp7wnek5IcNkl
         Ap6HGyxP3QM34VbmHFkb+ohZO7ApVBmpe5Iwv42G4h35EVb0Qm6rRv+8JsrQ/SjRO6c2
         nhl0+fzgqLIJ//+gzgVRkRnq1UWB1kg2M2xnNLXkGZeI+83q0BHdL+fcDbMO70k8Mrw0
         iyQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4VqkrXfjukVCYPnl/RCZWPFVlrDNXu1ZwUpy+w+eHawVezlvbm5KkKsLp0LVBgxGRS0p+tfB6ggL2wXA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nAxEc4SXQOPiQnzdkdpSBrsPkrFuhRQSlAZt7q7rTAHvCb7mtu
	7Ay1qB5lyKmApHetWufVGY2DZg8924eV4OamnCZY1fVqw/KM9g2V8iJNO40NJSLoV6U=
X-Gm-Gg: AYBFou0+6vK6wCog2xVcT7xwuDM0CD30tdcs2zkvN0CCf+ih+/CO/vR73Iyzuc1g5qD
	CW0HsT+S9Hg7O314cLBUHs76qLbMta1kQIRRzOuWY0K7eJUw90Mryz1r2A+iSnA7p9ct2Q2iptd
	NomXW5XjLIXsUNUQbYiQZcvjuat0OHDJ+QNxVszR/F0jpgOk/YnN2xBCNiS4EWTburgkoDM6143
	PUKhWbCbfhPTw0sDuoNkkzqUdqStXWuBjXS7bGuHh6khZFuD38Y0flAlnsGiFblAqzEVjWijTFl
	mWOr2sO4LyF+w3ingHDW0dhxZg1R52KA1ZhTlD7vzIGK0cgp1ipVw799neJJXxfDivKoNxy9rx1
	dT1Mlx2GFv2R21dmwoxkeS2MJYcMl7gUujKxV6/LeW/60lkZv4joEZzhVrq7YBPx0ekYdSEQQFS
	53miaC+9pgDQ3Dq4ayl08qwPJ7bWJmMRwdvfvroMrv4WwdKSIOgWzxeZKUpg4LqQHHChbRgIi6U
	/3a6JF1DUwLKq4epZs=
X-Received: by 2002:a17:902:ce92:b0:2db:5f8c:b81c with SMTP id d9443c01a7336-2dd8e52ed65mr27165495ad.19.1789541064774;
        Tue, 15 Sep 2026 23:44:24 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:44:24 -0700 (PDT)
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
Subject: [PATCH v4 07/11] mm/sparse-vmemmap: move vmemmap optimization helpers to a public header
Date: Wed, 16 Sep 2026 14:43:37 +0800
Message-ID: <20260916064341.1825793-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
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
powerpc, which has its own vmemmap optimization implementation and needs
to use the common vmemmap optimization interfaces from architecture code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
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
 MAINTAINERS                          |  1 +
 include/linux/vmemmap-optimization.h | 94 ++++++++++++++++++++++++++++
 mm/hugetlb.c                         |  2 +-
 mm/hugetlb_vmemmap.c                 |  2 +-
 mm/sparse.h                          | 76 +---------------------
 5 files changed, 98 insertions(+), 77 deletions(-)
 create mode 100644 include/linux/vmemmap-optimization.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ef018673b5e..e4412c3d8d45 100644
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
index 000000000000..0f9da22bd8d0
--- /dev/null
+++ b/include/linux/vmemmap-optimization.h
@@ -0,0 +1,94 @@
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
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
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
index 5ddf06b83c96..a27f46fffb54 100644
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
diff --git a/mm/sparse.h b/mm/sparse.h
index 8f6ef0b50b4f..a5111087ee3a 100644
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
@@ -142,7 +69,6 @@ static inline void sparse_sections_init(void) {}
  * mm/sparse-vmemmap.c
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 void sparse_init_subsection_map(void);
 int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-- 
2.54.0


