Return-Path: <dave@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57015DDF92
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:21:45 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9IL63a025047
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:06 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9ILfZt189278
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:41 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9ILeY6030198
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:41 -0500
Subject: [PATCH 6/8] cleanup do_init_bootmem()
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2008 10:21:38 -0800
References: <20081209182130.DB2150A2@kernel>
In-Reply-To: <20081209182130.DB2150A2@kernel>
Message-Id: <20081209182138.12F61BBF@kernel>
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


I'm debating whether this is worth it. It makes this a bit more clean
looking, but doesn't seriously enhance readability.  But, I do think
it helps a bit.

Thoughts?

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |  104 +++++++++++++++---------------
 1 file changed, 55 insertions(+), 49 deletions(-)

diff -puN arch/powerpc/mm/numa.c~cleanup-careful_allocation3 arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~cleanup-careful_allocation3	2008-12-09 10:16:07.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-09 10:16:07.000000000 -0800
@@ -938,6 +938,59 @@ static void mark_reserved_regions_for_ni
 	}
 }
 
+void do_init_bootmem_node(int node)
+{
+	unsigned long start_pfn, end_pfn;
+	void *bootmem_vaddr;
+	unsigned long bootmap_pages;
+
+	dbg("node %d is online\n", nid);
+	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+
+	/*
+	 * Allocate the node structure node local if possible
+	 *
+	 * Be careful moving this around, as it relies on all
+	 * previous nodes' bootmem to be initialized and have
+	 * all reserved areas marked.
+	 */
+	NODE_DATA(nid) = careful_zallocation(nid,
+				sizeof(struct pglist_data),
+				SMP_CACHE_BYTES, end_pfn);
+
+	dbg("node %d\n", nid);
+	dbg("NODE_DATA() = %p\n", NODE_DATA(nid));
+
+	NODE_DATA(nid)->bdata = &bootmem_node_data[nid];
+	NODE_DATA(nid)->node_start_pfn = start_pfn;
+	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
+
+	if (NODE_DATA(nid)->node_spanned_pages == 0)
+		return;
+
+	dbg("start_paddr = %lx\n", start_pfn << PAGE_SHIFT);
+	dbg("end_paddr = %lx\n", end_pfn << PAGE_SHIFT);
+
+	bootmap_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
+	bootmem_vaddr = careful_zallocation(nid,
+				bootmap_pages << PAGE_SHIFT,
+				PAGE_SIZE, end_pfn);
+
+	dbg("bootmap_vaddr = %p\n", bootmem_vaddr);
+
+	init_bootmem_node(NODE_DATA(nid),
+			  __pa(bootmem_vaddr) >> PAGE_SHIFT,
+			  start_pfn, end_pfn);
+
+	free_bootmem_with_active_regions(nid, end_pfn);
+	/*
+	 * Be very careful about moving this around.  Future
+	 * calls to careful_zallocation() depend on this getting
+	 * done correctly.
+	 */
+	mark_reserved_regions_for_nid(nid);
+	sparse_memory_present_with_active_regions(nid);
+}
 
 void __init do_init_bootmem(void)
 {
@@ -958,55 +1011,8 @@ void __init do_init_bootmem(void)
 			  (void *)(unsigned long)boot_cpuid);
 
 	for_each_online_node(nid) {
-		unsigned long start_pfn, end_pfn;
-		void *bootmem_vaddr;
-		unsigned long bootmap_pages;
-
-		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
-
-		/*
-		 * Allocate the node structure node local if possible
-		 *
-		 * Be careful moving this around, as it relies on all
-		 * previous nodes' bootmem to be initialized and have
-		 * all reserved areas marked.
-		 */
-		NODE_DATA(nid) = careful_zallocation(nid,
-					sizeof(struct pglist_data),
-					SMP_CACHE_BYTES, end_pfn);
-
-  		dbg("node %d\n", nid);
-		dbg("NODE_DATA() = %p\n", NODE_DATA(nid));
-
-		NODE_DATA(nid)->bdata = &bootmem_node_data[nid];
-		NODE_DATA(nid)->node_start_pfn = start_pfn;
-		NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
-
-		if (NODE_DATA(nid)->node_spanned_pages == 0)
-  			continue;
-
-  		dbg("start_paddr = %lx\n", start_pfn << PAGE_SHIFT);
-  		dbg("end_paddr = %lx\n", end_pfn << PAGE_SHIFT);
-
-		bootmap_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-		bootmem_vaddr = careful_zallocation(nid,
-					bootmap_pages << PAGE_SHIFT,
-					PAGE_SIZE, end_pfn);
-
-		dbg("bootmap_vaddr = %p\n", bootmem_vaddr);
-
-		init_bootmem_node(NODE_DATA(nid),
-				  __pa(bootmem_vaddr) >> PAGE_SHIFT,
-				  start_pfn, end_pfn);
-
-		free_bootmem_with_active_regions(nid, end_pfn);
-		/*
-		 * Be very careful about moving this around.  Future
-		 * calls to careful_zallocation() depend on this getting
-		 * done correctly.
-		 */
-		mark_reserved_regions_for_nid(nid);
-		sparse_memory_present_with_active_regions(nid);
+		dbg("node %d: marked online, initializing bootmem\n", nid);
+		do_init_bootmem_node(nid);
 	}
 }
 
_
