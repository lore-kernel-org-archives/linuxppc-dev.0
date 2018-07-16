Return-Path: <srs0=gorp=ka=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TXsF2LCzzF379
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 16:03:29 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41TXsF1Wz2z8tfk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 16:03:29 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41TXsD50ztz9rxs
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 16:03:28 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6G5whvr139441
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 02:03:27 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k8bny8y0b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 02:03:26 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Jul 2018 07:03:24 +0100
Subject: [RFC PATCH v6 1/4] mm/page_alloc: Introduce an interface to mark
 reserved memory as ZONE_MOVABLE
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Michal Hocko <mhocko@suse.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com
Date: Mon, 16 Jul 2018 11:33:16 +0530
In-Reply-To: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153172098506.29252.14851475255748792913.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Add an interface to allow a custom reserved memory to be marked as
ZONE_MOVABLE. This will help some subsystem's to convert their reserved
memory region into ZONE_MOVABLE so that the memory can still be available
to user applications.

The approach is based on Joonsoo Kim's commit bad8c6c0
(https://github.com/torvalds/linux/commit/bad8c6c0) that
uses ZONE_MOVABLE to manage CMA area. Majority of the code has been taken
from the Joonsoo Kim's commit mentioned above. But I see above commit
has been reverted due to some issues reported on i386. I believe this
patch is being reworked and re-posted soon.

Like CMA, the other user of ZONE_MOVABLE can be fadump on powerpc, which
reserves significant chunk of memory that is used only after system
is crashed. Until then the reserved memory is unused. By marking that
memory to ZONE_MOVABLE, it can be at least utilized by user applications.

This patch proposes a RFC implementation of an interface to mark
specified reserved area as ZONE_MOVABLE. Comments are welcome.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 include/linux/mmzone.h |    2 +
 mm/page_alloc.c        |  146 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2dc52a..2519dd690572 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1288,6 +1288,8 @@ struct mminit_pfnnid_cache {
 #endif
 
 void memory_present(int nid, unsigned long start, unsigned long end);
+extern int __init zone_movable_init_reserved_mem(phys_addr_t base,
+							phys_addr_t size);
 
 /*
  * If it is possible to have holes within a MAX_ORDER_NR_PAGES, then we
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..0817ed8843cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7687,6 +7687,152 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 	return true;
 }
 
+static __init void mark_zone_movable(struct page *page)
+{
+	unsigned i = pageblock_nr_pages;
+	struct page *p = page;
+	struct zone *zone;
+	unsigned long pfn = page_to_pfn(page);
+	int nid = page_to_nid(page);
+
+	zone = page_zone(page);
+	zone->present_pages -= pageblock_nr_pages;
+
+	do {
+		__ClearPageReserved(p);
+		set_page_count(p, 0);
+
+		/* Steal pages from other zones */
+		set_page_links(p, ZONE_MOVABLE, nid, pfn);
+	} while (++p, ++pfn, --i);
+
+	zone = page_zone(page);
+	zone->present_pages += pageblock_nr_pages;
+
+	set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+
+	if (pageblock_order >= MAX_ORDER) {
+		i = pageblock_nr_pages;
+		p = page;
+		do {
+			set_page_refcounted(p);
+			__free_pages(p, MAX_ORDER - 1);
+			p += MAX_ORDER_NR_PAGES;
+		} while (i -= MAX_ORDER_NR_PAGES);
+	} else {
+		set_page_refcounted(page);
+		__free_pages(page, pageblock_order);
+	}
+
+	adjust_managed_page_count(page, pageblock_nr_pages);
+}
+
+static int __init zone_movable_activate_area(unsigned long start_pfn,
+					unsigned long end_pfn)
+{
+	unsigned long base_pfn = start_pfn, pfn = start_pfn;
+	struct zone *zone;
+	unsigned i = (end_pfn - start_pfn) >> pageblock_order;
+
+	zone = page_zone(pfn_to_page(base_pfn));
+	while (pfn < end_pfn) {
+		if (!pfn_valid(pfn))
+			goto err;
+
+		if (page_zone(pfn_to_page(pfn)) != zone)
+			goto err;
+		pfn++;
+	}
+
+	do {
+		mark_zone_movable(pfn_to_page(base_pfn));
+		base_pfn += pageblock_nr_pages;
+	} while (--i);
+
+	return 0;
+err:
+	pr_err("Zone movable could not be activated\n");
+	return -EINVAL;
+}
+
+/**
+ * zone_movable_init_reserved_mem() - create custom zone movable area from
+ *				      reserved memory
+ * @base: Base address of the reserved area
+ * @size: Size of the reserved area (in bytes),
+ *
+ * This function creates custom zone movable area from already reserved memory.
+ */
+int __init zone_movable_init_reserved_mem(phys_addr_t base, phys_addr_t size)
+{
+	struct zone *zone;
+	pg_data_t *pgdat;
+	unsigned long start_pfn = PHYS_PFN(base);
+	unsigned long end_pfn = PHYS_PFN(base + size);
+	phys_addr_t alignment;
+	int ret;
+
+	if (!size || !memblock_is_region_reserved(base, size))
+		return -EINVAL;
+
+	/* ensure minimal alignment required by mm core */
+	alignment = PAGE_SIZE <<
+			max_t(unsigned long, MAX_ORDER - 1, pageblock_order);
+
+	if (ALIGN(base, alignment) != base || ALIGN(size, alignment) != size)
+		return -EINVAL;
+
+	for_each_online_pgdat(pgdat) {
+		zone = &pgdat->node_zones[ZONE_MOVABLE];
+
+		/*
+		 * Continue if zone is already populated.
+		 * Should we at least bump up the zone->spanned_pages
+		 * for existing populated zone ?
+		 */
+		if (populated_zone(zone))
+			continue;
+
+		/*
+		 * Is it possible to allow memory region across nodes to
+		 * be marked as ZONE_MOVABLE ?
+		 */
+		if (pfn_to_nid(start_pfn) != pgdat->node_id)
+			continue;
+
+		/* Not sure if this is a right place to init empty zone. */
+		if (zone_is_empty(zone)) {
+			init_currently_empty_zone(zone, start_pfn,
+							end_pfn - start_pfn);
+			zone->spanned_pages = end_pfn - start_pfn;
+		}
+	}
+
+	ret = zone_movable_activate_area(start_pfn, end_pfn);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * Reserved pages for ZONE_MOVABLE are now activated and
+	 * this would change ZONE_MOVABLE's managed page counter and
+	 * the other zones' present counter. We need to re-calculate
+	 * various zone information that depends on this initialization.
+	 */
+	build_all_zonelists(NULL);
+	for_each_populated_zone(zone) {
+		if (zone_idx(zone) == ZONE_MOVABLE) {
+			zone_pcp_reset(zone);
+			setup_zone_pageset(zone);
+		} else
+			zone_pcp_update(zone);
+
+		set_zone_contiguous(zone);
+	}
+
+	return 0;
+}
+
 #if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
 
 static unsigned long pfn_max_align_down(unsigned long pfn)
