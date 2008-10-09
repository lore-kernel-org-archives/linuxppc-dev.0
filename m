Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4DB4ADE5B1
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 07:18:45 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m99KIbcT030021
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Oct 2008 16:18:37 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m99KIbXM288714
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Oct 2008 16:18:37 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m99KIbS4015899
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Oct 2008 16:18:37 -0400
Message-ID: <48EE6720.6010601@linux.vnet.ibm.com>
Date: Thu, 09 Oct 2008 15:18:40 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Adam Litke <agl@us.ibm.com>, Kumar Gala <galak@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3] powerpc: properly reserve in bootmem the lmb reserved
	regions that cross NUMA nodes
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If there are multiple reserved memory blocks via lmb_reserve() that are
contiguous addresses and on different NUMA nodes we are losing track of which 
address ranges to reserve in bootmem on which node.  I discovered this 
when I recently got to try 16GB huge pages on a system with more then 2 nodes.

When scanning the device tree in early boot we call lmb_reserve() with 
the addresses of the 16G pages that we find so that the memory doesn't 
get used for something else.  For example the addresses for the pages 
could be 4000000000, 4400000000, 4800000000, 4C00000000, etc - 8 pages, 
one on each of eight nodes.  In the lmb after all the pages have been 
reserved it will look something like the following:

lmb_dump_all:
    memory.cnt            = 0x2
    memory.size           = 0x3e80000000
    memory.region[0x0].base       = 0x0
                      .size     = 0x1e80000000
    memory.region[0x1].base       = 0x4000000000
                      .size     = 0x2000000000
    reserved.cnt          = 0x5
    reserved.size         = 0x3e80000000
    reserved.region[0x0].base       = 0x0
                      .size     = 0x7b5000
    reserved.region[0x1].base       = 0x2a00000
                      .size     = 0x78c000
    reserved.region[0x2].base       = 0x328c000
                      .size     = 0x43000
    reserved.region[0x3].base       = 0xf4e8000
                      .size     = 0xb18000
    reserved.region[0x4].base       = 0x4000000000
                      .size     = 0x2000000000


The reserved.region[0x4] contains the 16G pages.  In 
arch/powerpc/mm/num.c: do_init_bootmem() we loop through each of the 
node numbers looking for the reserved regions that belong to the 
particular node.  It is not able to identify region 0x4 as being a part 
of each of the 8 nodes.  It is assuming that a reserved region is only
on a single node.

This patch takes out the reserved region loop from inside
the loop that goes over each node.  It looks up the active region containing
the start of the reserved region.  If it extends past that active region then
it adjusts the size and gets the next active region containing it.

Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
---

Changes:
	v2:
	-style changes as suggested by Adam Litke
	v3:
	-moved helper function to powerpc code since it is the only user at present
	-made end_pfn consistently exclusive
	-other minor code cleanups

Please consider for 2.6.28.

 numa.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d9a1813..72447f1 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -89,6 +89,46 @@ static int __cpuinit fake_numa_create_new_node(unsigned long end_pfn,
 	return 0;
 }
 
+/*
+ * get_active_region_work_fn - A helper function for get_node_active_region
+ *	Returns datax set to the start_pfn and end_pfn if they contain
+ *	the initial value of datax->start_pfn between them
+ * @start_pfn: start page(inclusive) of region to check
+ * @end_pfn: end page(exclusive) of region to check
+ * @datax: comes in with ->start_pfn set to value to search for and
+ *	goes out with active range if it contains it
+ * Returns 1 if search value is in range else 0
+ */
+static int __init get_active_region_work_fn(unsigned long start_pfn,
+					unsigned long end_pfn, void *datax)
+{
+	struct node_active_region *data;
+	data = (struct node_active_region *)datax;
+
+	if (start_pfn <= data->start_pfn && end_pfn > data->start_pfn) {
+		data->start_pfn = start_pfn;
+		data->end_pfn = end_pfn;
+		return 1;
+	}
+	return 0;
+
+}
+
+/*
+ * get_node_active_region - Return active region containing start_pfn
+ * @start_pfn: The page to return the region for.
+ * @node_ar: Returned set to the active region containing start_pfn
+ */
+static void __init get_node_active_region(unsigned long start_pfn,
+		       struct node_active_region *node_ar)
+{
+	int nid = early_pfn_to_nid(start_pfn);
+
+	node_ar->nid = nid;
+	node_ar->start_pfn = start_pfn;
+	work_with_active_regions(nid, get_active_region_work_fn, node_ar);
+}
+
 static void __cpuinit map_cpu_to_node(int cpu, int node)
 {
 	numa_cpu_lookup_table[cpu] = node;
@@ -837,38 +877,50 @@ void __init do_init_bootmem(void)
 				  start_pfn, end_pfn);
 
 		free_bootmem_with_active_regions(nid, end_pfn);
+	}
 
-		/* Mark reserved regions on this node */
-		for (i = 0; i < lmb.reserved.cnt; i++) {
-			unsigned long physbase = lmb.reserved.region[i].base;
-			unsigned long size = lmb.reserved.region[i].size;
-			unsigned long start_paddr = start_pfn << PAGE_SHIFT;
-			unsigned long end_paddr = end_pfn << PAGE_SHIFT;
-
-			if (early_pfn_to_nid(physbase >> PAGE_SHIFT) != nid &&
-			    early_pfn_to_nid((physbase+size-1) >> PAGE_SHIFT) != nid)
-				continue;
-
-			if (physbase < end_paddr &&
-			    (physbase+size) > start_paddr) {
-				/* overlaps */
-				if (physbase < start_paddr) {
-					size -= start_paddr - physbase;
-					physbase = start_paddr;
-				}
-
-				if (size > end_paddr - physbase)
-					size = end_paddr - physbase;
-
-				dbg("reserve_bootmem %lx %lx\n", physbase,
-				    size);
-				reserve_bootmem_node(NODE_DATA(nid), physbase,
-						     size, BOOTMEM_DEFAULT);
-			}
+	/* Mark reserved regions */
+	for (i = 0; i < lmb.reserved.cnt; i++) {
+		unsigned long physbase = lmb.reserved.region[i].base;
+		unsigned long size = lmb.reserved.region[i].size;
+		unsigned long start_pfn = physbase >> PAGE_SHIFT;
+		unsigned long end_pfn = ((physbase + size) >> PAGE_SHIFT);
+		struct node_active_region node_ar;
+
+		get_node_active_region(start_pfn, &node_ar);
+		while (start_pfn < end_pfn) {
+			/*
+			 * if reserved region extends past active region
+			 * then trim size to active region
+			 */
+			if (end_pfn > node_ar.end_pfn)
+				size = (node_ar.end_pfn << PAGE_SHIFT)
+					- (start_pfn << PAGE_SHIFT);
+			dbg("reserve_bootmem %lx %lx nid=%d\n", physbase, size,
+				node_ar.nid);
+			reserve_bootmem_node(NODE_DATA(node_ar.nid), physbase,
+						size, BOOTMEM_DEFAULT);
+			/*
+			 * if reserved region is contained in the active region
+			 * then done.
+			 */
+			if (end_pfn <= node_ar.end_pfn)
+				break;
+
+			/*
+			 * reserved region extends past the active region
+			 *   get next active region that contains this
+			 *   reserved region
+			 */
+			start_pfn = node_ar.end_pfn;
+			physbase = start_pfn << PAGE_SHIFT;
+			get_node_active_region(start_pfn, &node_ar);
 		}
 
-		sparse_memory_present_with_active_regions(nid);
 	}
+
+	for_each_online_node(nid)
+		sparse_memory_present_with_active_regions(nid);
 }
 
 void __init paging_init(void)
