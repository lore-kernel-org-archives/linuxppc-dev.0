Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4xMN2Zj0zDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 03:12:32 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74H3wEW142824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 13:12:28 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24kkajquew-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 13:12:28 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 5 Aug 2016 03:12:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 328622BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 03:12:22 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74HCMPc28442710
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 03:12:22 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74HCLbw017904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 03:12:21 +1000
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Balbir Singh <bsingharora@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH V2 1/2] mm/page_alloc: Replace set_dma_reserve to
 set_memory_reserve
Date: Thu,  4 Aug 2016 22:42:08 +0530
Message-Id: <1470330729-6273-1-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Expand the scope of the existing dma_reserve to accommodate other memory
reserves too. Accordingly rename variable dma_reserve to
nr_memory_reserve.

set_memory_reserve also takes a new parameter that helps to identify if
the current value needs to be incremented.

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/x86/kernel/e820.c |  2 +-
 include/linux/mm.h     |  2 +-
 mm/page_alloc.c        | 20 ++++++++++++--------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 621b501..d935983 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1188,6 +1188,6 @@ void __init memblock_find_dma_reserve(void)
 			nr_free_pages += end_pfn - start_pfn;
 	}
 
-	set_dma_reserve(nr_pages - nr_free_pages);
+	set_memory_reserve(nr_pages - nr_free_pages, false);
 #endif
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f468e0..c884ffb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1886,7 +1886,7 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
 					struct mminit_pfnnid_cache *state);
 #endif
 
-extern void set_dma_reserve(unsigned long new_dma_reserve);
+extern void set_memory_reserve(unsigned long nr_reserve, bool inc);
 extern void memmap_init_zone(unsigned long, int, unsigned long,
 				unsigned long, enum memmap_context);
 extern void setup_per_zone_wmarks(void);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c1069ef..a154c2f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -253,7 +253,7 @@ int watermark_scale_factor = 10;
 
 static unsigned long __meminitdata nr_kernel_pages;
 static unsigned long __meminitdata nr_all_pages;
-static unsigned long __meminitdata dma_reserve;
+static unsigned long __meminitdata nr_memory_reserve;
 
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 static unsigned long __meminitdata arch_zone_lowest_possible_pfn[MAX_NR_ZONES];
@@ -5493,10 +5493,10 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 		}
 
 		/* Account for reserved pages */
-		if (j == 0 && freesize > dma_reserve) {
-			freesize -= dma_reserve;
+		if (j == 0 && freesize > nr_memory_reserve) {
+			freesize -= nr_memory_reserve;
 			printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
-					zone_names[0], dma_reserve);
+					zone_names[0], nr_memory_reserve);
 		}
 
 		if (!is_highmem_idx(j))
@@ -6186,8 +6186,9 @@ void __init mem_init_print_info(const char *str)
 }
 
 /**
- * set_dma_reserve - set the specified number of pages reserved in the first zone
- * @new_dma_reserve: The number of pages to mark reserved
+ * set_memory_reserve - set number of pages reserved in the first zone
+ * @nr_reserve: The number of pages to mark reserved
+ * @inc: true increment to existing value; false set new value.
  *
  * The per-cpu batchsize and zone watermarks are determined by managed_pages.
  * In the DMA zone, a significant percentage may be consumed by kernel image
@@ -6196,9 +6197,12 @@ void __init mem_init_print_info(const char *str)
  * first zone (e.g., ZONE_DMA). The effect will be lower watermarks and
  * smaller per-cpu batchsize.
  */
-void __init set_dma_reserve(unsigned long new_dma_reserve)
+void __init set_memory_reserve(unsigned long nr_reserve, bool inc)
 {
-	dma_reserve = new_dma_reserve;
+	if (inc)
+		nr_memory_reserve += nr_reserve;
+	else
+		nr_memory_reserve = nr_reserve;
 }
 
 void __init free_area_init(unsigned long *zones_size)
-- 
1.8.5.6
