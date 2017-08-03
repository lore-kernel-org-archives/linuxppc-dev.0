Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNjlD5N1BzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 07:25:28 +1000 (AEST)
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org
Subject: [v5 13/15] mm: stop zeroing memory during allocation in vmemmap
Date: Thu,  3 Aug 2017 17:23:51 -0400
Message-Id: <1501795433-982645-14-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1501795433-982645-1-git-send-email-pasha.tatashin@oracle.com>
References: <1501795433-982645-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace allocators in sprase-vmemmap to use the non-zeroing version. So,
we will get the performance improvement by zeroing the memory in parallel
when struct pages are zeroed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 mm/sparse-vmemmap.c | 6 +++---
 mm/sparse.c         | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index d40c721ab19f..3b646b5ce1b6 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -41,7 +41,7 @@ static void * __ref __earlyonly_bootmem_alloc(int node,
 				unsigned long align,
 				unsigned long goal)
 {
-	return memblock_virt_alloc_try_nid(size, align, goal,
+	return memblock_virt_alloc_try_nid_raw(size, align, goal,
 					    BOOTMEM_ALLOC_ACCESSIBLE, node);
 }
 
@@ -56,11 +56,11 @@ void * __meminit vmemmap_alloc_block(unsigned long size, int node)
 
 		if (node_state(node, N_HIGH_MEMORY))
 			page = alloc_pages_node(
-				node, GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL,
+				node, GFP_KERNEL | __GFP_RETRY_MAYFAIL,
 				get_order(size));
 		else
 			page = alloc_pages(
-				GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL,
+				GFP_KERNEL | __GFP_RETRY_MAYFAIL,
 				get_order(size));
 		if (page)
 			return page_address(page);
diff --git a/mm/sparse.c b/mm/sparse.c
index 7b4be3fd5cac..0e315766ad11 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -441,9 +441,9 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 	}
 
 	size = PAGE_ALIGN(size);
-	map = memblock_virt_alloc_try_nid(size * map_count,
-					  PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
-					  BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
+	map = memblock_virt_alloc_try_nid_raw(size * map_count,
+					      PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
+					      BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
 	if (map) {
 		for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
 			if (!present_section_nr(pnum))
-- 
2.13.4
