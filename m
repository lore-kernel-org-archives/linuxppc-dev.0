Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svfPg43T5zDsy2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 16:27:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: [PATCH] powerpc/mm: Drop dump_numa_memory_topology()
Date: Thu, 13 Oct 2016 16:27:30 +1100
Message-Id: <1476336450-27862-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At boot we dump the NUMA memory topology in dump_numa_memory_topology(),
at KERN_DEBUG level, resulting in output like:

  Node 0 Memory: 0x0-0x100000000
  Node 1 Memory: 0x100000000-0x200000000

Which is nice enough, but immediately after that we iterate over each
node and call setup_node_data(), which also prints out the node ranges,
at KERN_INFO, giving eg:

  numa: Initmem setup node 0 [mem 0x00000000-0xffffffff]
  numa: Initmem setup node 1 [mem 0x100000000-0x1ffffffff]

So drop dump_numa_memory_topology() as superfluous chatter.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/numa.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 75b9cd6150cc..db5fc2b54c5a 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -871,40 +871,6 @@ void __init dump_numa_cpu_topology(void)
 	}
 }
 
-static void __init dump_numa_memory_topology(void)
-{
-	unsigned int node;
-	unsigned int count;
-
-	if (min_common_depth == -1 || !numa_enabled)
-		return;
-
-	for_each_online_node(node) {
-		unsigned long i;
-
-		printk(KERN_DEBUG "Node %d Memory:", node);
-
-		count = 0;
-
-		for (i = 0; i < memblock_end_of_DRAM();
-		     i += (1 << SECTION_SIZE_BITS)) {
-			if (early_pfn_to_nid(i >> PAGE_SHIFT) == node) {
-				if (count == 0)
-					printk(" 0x%lx", i);
-				++count;
-			} else {
-				if (count > 0)
-					printk("-0x%lx", i);
-				count = 0;
-			}
-		}
-
-		if (count > 0)
-			printk("-0x%lx", i);
-		printk("\n");
-	}
-}
-
 /* Initialize NODE_DATA for a node on the local memory */
 static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 {
@@ -947,8 +913,6 @@ void __init initmem_init(void)
 
 	if (parse_numa_properties())
 		setup_nonnuma();
-	else
-		dump_numa_memory_topology();
 
 	memblock_dump_all();
 
-- 
2.7.4
