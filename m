Return-Path: <dave@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26C15DDF36
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:21:51 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9ILDlO025225
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:13 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9ILiIF2297872
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:45 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9ILh9O008473
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:21:44 -0700
Subject: [PATCH 8/8] make free_bootmem_with_active_regions() take pgdat
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2008 10:21:41 -0800
References: <20081209182130.DB2150A2@kernel>
In-Reply-To: <20081209182130.DB2150A2@kernel>
Message-Id: <20081209182141.8343F5A9@kernel>
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


As I said earlier, I'm trying to restrict the use of NODE_DATA()
since it can easily be referenced too early otherwise.

free_bootmem_with_active_regions() does not in practice need to
deal with multiple nodes.  I already audited all of its callers.

This patch makes it take a pgdat instead of doing the NODE_DATA()
lookup internally.

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/mips/sgi-ip27/ip27-memory.c |    2 +-
 linux-2.6.git-dave/arch/powerpc/mm/mem.c            |    5 +++--
 linux-2.6.git-dave/arch/powerpc/mm/numa.c           |    3 +--
 linux-2.6.git-dave/arch/s390/kernel/setup.c         |    2 +-
 linux-2.6.git-dave/arch/sh/mm/numa.c                |    2 +-
 linux-2.6.git-dave/arch/sparc64/mm/init.c           |    6 +++---
 linux-2.6.git-dave/arch/x86/mm/init_32.c            |    2 +-
 linux-2.6.git-dave/arch/x86/mm/init_64.c            |    2 +-
 linux-2.6.git-dave/arch/x86/mm/numa_64.c            |    2 +-
 linux-2.6.git-dave/include/linux/mm.h               |    2 +-
 linux-2.6.git-dave/mm/page_alloc.c                  |    8 ++++----
 11 files changed, 18 insertions(+), 18 deletions(-)

diff -puN arch/mips/sgi-ip27/ip27-memory.c~make-free_bootmem_with_active_regions-take-pgdat arch/mips/sgi-ip27/ip27-memory.c
--- linux-2.6.git/arch/mips/sgi-ip27/ip27-memory.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/mips/sgi-ip27/ip27-memory.c	2008-12-09 10:16:08.000000000 -0800
@@ -412,7 +412,7 @@ static void __init node_mem_init(cnodeid
 
   	bootmap_size = init_bootmem_node(NODE_DATA(node), slot_freepfn,
 					start_pfn, end_pfn);
-	free_bootmem_with_active_regions(node, end_pfn);
+	free_bootmem_with_active_regions(NODE_DATA(node), end_pfn);
 	reserve_bootmem_node(NODE_DATA(node), slot_firstpfn << PAGE_SHIFT,
 		((slot_freepfn - slot_firstpfn) << PAGE_SHIFT) + bootmap_size,
 		BOOTMEM_DEFAULT);
diff -puN arch/powerpc/mm/mem.c~make-free_bootmem_with_active_regions-take-pgdat arch/powerpc/mm/mem.c
--- linux-2.6.git/arch/powerpc/mm/mem.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/mem.c	2008-12-09 10:16:08.000000000 -0800
@@ -212,7 +212,8 @@ void __init do_init_bootmem(void)
 	 * present.
 	 */
 #ifdef CONFIG_HIGHMEM
-	free_bootmem_with_active_regions(0, lowmem_end_addr >> PAGE_SHIFT);
+	free_bootmem_with_active_regions(NODE_DATA(0),
+					 lowmem_end_addr >> PAGE_SHIFT);
 
 	/* reserve the sections we're already using */
 	for (i = 0; i < lmb.reserved.cnt; i++) {
@@ -230,7 +231,7 @@ void __init do_init_bootmem(void)
 		}
 	}
 #else
-	free_bootmem_with_active_regions(0, max_pfn);
+	free_bootmem_with_active_regions(NODE_DATA(0), max_pfn);
 
 	/* reserve the sections we're already using */
 	for (i = 0; i < lmb.reserved.cnt; i++)
diff -puN arch/powerpc/mm/numa.c~make-free_bootmem_with_active_regions-take-pgdat arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-09 10:16:08.000000000 -0800
@@ -978,8 +978,6 @@ void do_init_bootmem_node(int nid)
 	init_bootmem_node(node, __pa(bootmem_vaddr) >> PAGE_SHIFT,
 			  start_pfn, end_pfn);
 
-	NODE_DATA(nid) = node;
-	/* this call needs NODE_DATA(), so initialize it above */
 	free_bootmem_with_active_regions(nid, end_pfn);
 	mark_reserved_regions_for_node(node);
 	/*
@@ -988,6 +986,7 @@ void do_init_bootmem_node(int nid)
 	 * careful_zallocation() depends on this getting set
 	 * now to tell from which nodes it must use bootmem.
 	 */
+	NODE_DATA(nid) = node;
 	sparse_memory_present_with_active_regions(nid);
 }
 
diff -puN arch/s390/kernel/setup.c~make-free_bootmem_with_active_regions-take-pgdat arch/s390/kernel/setup.c
--- linux-2.6.git/arch/s390/kernel/setup.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/s390/kernel/setup.c	2008-12-09 10:16:08.000000000 -0800
@@ -616,7 +616,7 @@ setup_memory(void)
 
 	psw_set_key(PAGE_DEFAULT_KEY);
 
-	free_bootmem_with_active_regions(0, max_pfn);
+	free_bootmem_with_active_regions(NODE_DATA(0), max_pfn);
 
 	/*
 	 * Reserve memory used for lowcore/command line/kernel image.
diff -puN arch/sh/mm/numa.c~make-free_bootmem_with_active_regions-take-pgdat arch/sh/mm/numa.c
--- linux-2.6.git/arch/sh/mm/numa.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/sh/mm/numa.c	2008-12-09 10:16:08.000000000 -0800
@@ -75,7 +75,7 @@ void __init setup_bootmem_node(int nid, 
 	bootmap_size = init_bootmem_node(NODE_DATA(nid), free_pfn, start_pfn,
 				    end_pfn);
 
-	free_bootmem_with_active_regions(nid, end_pfn);
+	free_bootmem_with_active_regions(NODE_DATA(nid), end_pfn);
 
 	/* Reserve the pgdat and bootmap space with the bootmem allocator */
 	reserve_bootmem_node(NODE_DATA(nid), start_pfn << PAGE_SHIFT,
diff -puN arch/sparc64/mm/init.c~make-free_bootmem_with_active_regions-take-pgdat arch/sparc64/mm/init.c
--- linux-2.6.git/arch/sparc64/mm/init.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/sparc64/mm/init.c	2008-12-09 10:16:08.000000000 -0800
@@ -1353,9 +1353,9 @@ static void __init bootmem_init_one_node
 		init_bootmem_node(p, paddr >> PAGE_SHIFT,
 				  p->node_start_pfn, end_pfn);
 
-		numadbg("  free_bootmem_with_active_regions(%d, %lx)\n",
-			nid, end_pfn);
-		free_bootmem_with_active_regions(nid, end_pfn);
+		numadbg("  free_bootmem_with_active_regions(%p, %lx)\n",
+			p, end_pfn);
+		free_bootmem_with_active_regions(p, end_pfn);
 
 		trim_reserved_in_node(nid);
 
diff -puN arch/x86/mm/init_32.c~make-free_bootmem_with_active_regions-take-pgdat arch/x86/mm/init_32.c
--- linux-2.6.git/arch/x86/mm/init_32.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/x86/mm/init_32.c	2008-12-09 10:16:08.000000000 -0800
@@ -768,7 +768,7 @@ void __init setup_bootmem_allocator(void
 	printk(KERN_INFO "  bootmap %08lx - %08lx\n",
 		 bootmap, bootmap + bootmap_size);
 	for_each_online_node(i)
-		free_bootmem_with_active_regions(i, max_low_pfn);
+		free_bootmem_with_active_regions(NODE_DATA(i), max_low_pfn);
 	early_res_to_bootmem(0, max_low_pfn<<PAGE_SHIFT);
 
 	after_init_bootmem = 1;
diff -puN arch/x86/mm/init_64.c~make-free_bootmem_with_active_regions-take-pgdat arch/x86/mm/init_64.c
--- linux-2.6.git/arch/x86/mm/init_64.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/x86/mm/init_64.c	2008-12-09 10:16:08.000000000 -0800
@@ -817,7 +817,7 @@ void __init initmem_init(unsigned long s
 	bootmap_size = init_bootmem_node(NODE_DATA(0), bootmap >> PAGE_SHIFT,
 					 0, end_pfn);
 	e820_register_active_regions(0, start_pfn, end_pfn);
-	free_bootmem_with_active_regions(0, end_pfn);
+	free_bootmem_with_active_regions(NODE_DATA(0), end_pfn);
 	early_res_to_bootmem(0, end_pfn<<PAGE_SHIFT);
 	reserve_bootmem(bootmap, bootmap_size, BOOTMEM_DEFAULT);
 }
diff -puN arch/x86/mm/numa_64.c~make-free_bootmem_with_active_regions-take-pgdat arch/x86/mm/numa_64.c
--- linux-2.6.git/arch/x86/mm/numa_64.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/x86/mm/numa_64.c	2008-12-09 10:16:08.000000000 -0800
@@ -235,7 +235,7 @@ void __init setup_node_bootmem(int nodei
 		 bootmap_start, bootmap_start + bootmap_size - 1,
 		 bootmap_pages);
 
-	free_bootmem_with_active_regions(nodeid, end);
+	free_bootmem_with_active_regions(NODE_DATA(nodeid), end);
 
 	/*
 	 * convert early reserve to bootmem reserve earlier
diff -puN include/linux/mm.h~make-free_bootmem_with_active_regions-take-pgdat include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/include/linux/mm.h	2008-12-09 10:16:08.000000000 -0800
@@ -1023,7 +1023,7 @@ extern unsigned long absent_pages_in_ran
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
 extern unsigned long find_min_pfn_with_active_regions(void);
-extern void free_bootmem_with_active_regions(int nid,
+extern void free_bootmem_with_active_regions(struct pglist_data *node,
 						unsigned long max_low_pfn);
 typedef int (*work_fn_t)(unsigned long, unsigned long, void *);
 extern void work_with_active_regions(int nid, work_fn_t work_fn, void *data);
diff -puN mm/page_alloc.c~make-free_bootmem_with_active_regions-take-pgdat mm/page_alloc.c
--- linux-2.6.git/mm/page_alloc.c~make-free_bootmem_with_active_regions-take-pgdat	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/mm/page_alloc.c	2008-12-09 10:16:08.000000000 -0800
@@ -2997,16 +2997,17 @@ int __meminit early_pfn_to_nid(unsigned 
 
 /**
  * free_bootmem_with_active_regions - Call free_bootmem_node for each active range
- * @nid: The node to free memory on. If MAX_NUMNODES, all nodes are freed.
+ * @node: The node on which to free memory.
  * @max_low_pfn: The highest PFN that will be passed to free_bootmem_node
  *
  * If an architecture guarantees that all ranges registered with
  * add_active_ranges() contain no holes and may be freed, this
  * this function may be used instead of calling free_bootmem() manually.
  */
-void __init free_bootmem_with_active_regions(int nid,
+void __init free_bootmem_with_active_regions(struct pglist_data *node,
 						unsigned long max_low_pfn)
 {
+	int nid = node->node_id;
 	int i;
 
 	for_each_active_range_index_in_nid(i, nid) {
@@ -3020,8 +3021,7 @@ void __init free_bootmem_with_active_reg
 			end_pfn = max_low_pfn;
 
 		size_pages = end_pfn - early_node_map[i].start_pfn;
-		free_bootmem_node(NODE_DATA(early_node_map[i].nid),
-				PFN_PHYS(early_node_map[i].start_pfn),
+		free_bootmem_node(node,	PFN_PHYS(early_node_map[i].start_pfn),
 				size_pages << PAGE_SHIFT);
 	}
 }
_
