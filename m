Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWp605Gv7zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 03:04:40 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 26 Mar 2016 02:04:39 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A9D6A2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 03:04:36 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2PG4SS73866978
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 03:04:36 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2PG43ob029198
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 03:04:04 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: zhlcindy@linux.vnet.ibm.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH RFC] powerpc/mm: Support bootmem for PPC64 again
Date: Sat, 26 Mar 2016 03:03:41 +1100
Message-Id: <1458921821-14960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_NO_BOOTMEM is enabled on PPC platforms by default. However,
user might disable that to have bootmem for other purpose. So it's
resonable to support it.

This implements setup_bootmem() which is called by initmem_init()
to setup bootmem node and its free bitmap. In the meantime, the
free pages frames tracked by memblock are released to bootmem.
In theory, we also need similar thing for PPC32 platforms. However,
I don't have machine for testing. So that would be something later
when I have hardware to test.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 669a15e..288b1b5 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -951,6 +951,41 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
 }
 
+#ifndef CONFIG_NO_BOOTMEM
+static void __init setup_bootmem(struct pglist_data *pgdat,
+				 unsigned long start_pfn,
+				 unsigned long end_pfn)
+{
+	unsigned long map_size, addr;
+	phys_addr_t cur[2], range[2];
+	u64 i;
+
+	/* Memory required for bootmem bitmap */
+	map_size = bootmem_bootmap_pages(end_pfn - start_pfn);
+	map_size <<= PAGE_SHIFT;
+	addr = memblock_alloc_try_nid(map_size,
+				      SMP_CACHE_BYTES, pgdat->node_id);
+
+	/* Initialize bootmem allocator */
+	pgdat->bdata = &bootmem_node_data[pgdat->node_id];
+	init_bootmem_node(pgdat, PHYS_PFN(addr), start_pfn, end_pfn);
+
+	/* Release free pages in memblock */
+	range[0] = PFN_PHYS(start_pfn);
+	range[1] = PFN_PHYS(end_pfn);
+	for_each_free_mem_range(i, pgdat->node_id, MEMBLOCK_NONE,
+				&cur[0], &cur[1], NULL) {
+		cur[0] = clamp(cur[0], range[0], range[1]);
+		cur[1] = clamp(cur[1], range[0], range[1]);
+		if (cur[0] >= cur[1])
+			continue;
+
+		memblock_free_early_nid(cur[0], cur[1] - cur[0],
+					pgdat->node_id);
+	}
+}
+#endif /* !CONFIG_NO_BOOTMEM */
+
 void __init initmem_init(void)
 {
 	int nid, cpu;
@@ -977,6 +1012,9 @@ void __init initmem_init(void)
 
 		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 		setup_node_data(nid, start_pfn, end_pfn);
+#ifndef CONFIG_NO_BOOTMEM
+		setup_bootmem(NODE_DATA(nid), start_pfn, end_pfn);
+#endif
 		sparse_memory_present_with_active_regions(nid);
 	}
 
-- 
2.1.0
