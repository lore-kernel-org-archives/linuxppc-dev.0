Return-Path: <dave@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37174DDF7D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:21:45 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9ILGdc031936
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:16 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9ILfnj190844
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:41 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9ILAPU031504
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:11 -0500
Subject: [PATCH 4/8] make careful_allocation() return vaddrs
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2008 10:21:35 -0800
References: <20081209182130.DB2150A2@kernel>
In-Reply-To: <20081209182130.DB2150A2@kernel>
Message-Id: <20081209182135.1B5C1504@kernel>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	Dave Hansen <dave@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	"Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Since we memset() the result in both of the uses here,
just make careful_alloc() return a virtual address.
Also, add a separate variable to store the physial
address that comes back from the lmb_alloc() functions.
This makes it less likely that someone will screw it up
forgetting to convert before returning since the vaddr
is always in a void* and the paddr is always in an
unsigned long.

I admit this is arbitrary since one of its users needs
a paddr and one a vaddr, but it does remove a good
number of casts.

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |   37 ++++++++++++++++--------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff -puN arch/powerpc/mm/numa.c~cleanup-careful_allocation1 arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~cleanup-careful_allocation1	2008-12-09 10:16:06.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-09 10:16:06.000000000 -0800
@@ -822,23 +822,28 @@ static void __init dump_numa_memory_topo
  * required. nid is the preferred node and end is the physical address of
  * the highest address in the node.
  *
- * Returns the physical address of the memory.
+ * Returns the virtual address of the memory.
  */
 static void __init *careful_allocation(int nid, unsigned long size,
 				       unsigned long align,
 				       unsigned long end_pfn)
 {
+	void *ret;
 	int new_nid;
-	unsigned long ret = __lmb_alloc_base(size, align, end_pfn << PAGE_SHIFT);
+	unsigned long ret_paddr;
+
+	ret_paddr = __lmb_alloc_base(size, align, end_pfn << PAGE_SHIFT);
 
 	/* retry over all memory */
-	if (!ret)
-		ret = __lmb_alloc_base(size, align, lmb_end_of_DRAM());
+	if (!ret_paddr)
+		ret_paddr = __lmb_alloc_base(size, align, lmb_end_of_DRAM());
 
-	if (!ret)
+	if (!ret_paddr)
 		panic("numa.c: cannot allocate %lu bytes for node %d",
 		      size, nid);
 
+	ret = __va(ret_paddr);
+
 	/*
 	 * We initialize the nodes in numeric order: 0, 1, 2...
 	 * and hand over control from the LMB allocator to the
@@ -851,17 +856,15 @@ static void __init *careful_allocation(i
 	 * instead of the LMB.  We don't free the LMB memory
 	 * since it would be useless.
 	 */
-	new_nid = early_pfn_to_nid(ret >> PAGE_SHIFT);
+	new_nid = early_pfn_to_nid(ret_paddr >> PAGE_SHIFT);
 	if (new_nid < nid) {
-		ret = (unsigned long)__alloc_bootmem_node(NODE_DATA(new_nid),
+		ret = __alloc_bootmem_node(NODE_DATA(new_nid),
 				size, align, 0);
 
-		ret = __pa(ret);
-
-		dbg("alloc_bootmem %lx %lx\n", ret, size);
+		dbg("alloc_bootmem %p %lx\n", ret, size);
 	}
 
-	return (void *)ret;
+	return ret;
 }
 
 static struct notifier_block __cpuinitdata ppc64_numa_nb = {
@@ -955,7 +958,7 @@ void __init do_init_bootmem(void)
 
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
-		unsigned long bootmem_paddr;
+		void *bootmem_vaddr;
 		unsigned long bootmap_pages;
 
 		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
@@ -970,7 +973,6 @@ void __init do_init_bootmem(void)
 		NODE_DATA(nid) = careful_allocation(nid,
 					sizeof(struct pglist_data),
 					SMP_CACHE_BYTES, end_pfn);
-		NODE_DATA(nid) = __va(NODE_DATA(nid));
 		memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
 
   		dbg("node %d\n", nid);
@@ -987,14 +989,15 @@ void __init do_init_bootmem(void)
   		dbg("end_paddr = %lx\n", end_pfn << PAGE_SHIFT);
 
 		bootmap_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-		bootmem_paddr = (unsigned long)careful_allocation(nid,
+		bootmem_vaddr = careful_allocation(nid,
 					bootmap_pages << PAGE_SHIFT,
 					PAGE_SIZE, end_pfn);
-		memset(__va(bootmem_paddr), 0, bootmap_pages << PAGE_SHIFT);
+		memset(bootmem_vaddr, 0, bootmap_pages << PAGE_SHIFT);
 
-		dbg("bootmap_paddr = %lx\n", bootmem_paddr);
+		dbg("bootmap_vaddr = %p\n", bootmem_vaddr);
 
-		init_bootmem_node(NODE_DATA(nid), bootmem_paddr >> PAGE_SHIFT,
+		init_bootmem_node(NODE_DATA(nid),
+				  __pa(bootmem_vaddr) >> PAGE_SHIFT,
 				  start_pfn, end_pfn);
 
 		free_bootmem_with_active_regions(nid, end_pfn);
_
