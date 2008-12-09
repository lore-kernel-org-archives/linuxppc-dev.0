Return-Path: <dave@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C3E4DDF13
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:21:50 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9IL7dx026514
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:07 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9ILhM62101342
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:43 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9ILgiG005249
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:21:42 -0700
Subject: [PATCH 7/8] less use of NODE_DATA()
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2008 10:21:39 -0800
References: <20081209182130.DB2150A2@kernel>
In-Reply-To: <20081209182130.DB2150A2@kernel>
Message-Id: <20081209182139.4FF468F1@kernel>
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


The use of NODE_DATA() in the ppc init code is fragile.  We use
it for some nodes as we are initializing others.  As the loop
initializing them has gotten more complex and broken out into
several functions it gets harder and harder to remember how
this goes.

This was recently the cause of a bug

	http://patchwork.ozlabs.org/patch/10528/

in which I also created a new regression for machines with large
memory reservations in the LMB structures (most likely 16GB
pages).

This patch reduces the references to NODE_DATA() and also keeps
it unitialized for as long as possible.  Hopefully, the delay
in initialization will help its use from spreading too much,
reducing the chances for future bugs.

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |   63 ++++++++++++++----------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff -puN arch/powerpc/mm/numa.c~less-use-of-NODE_DATA arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~less-use-of-NODE_DATA	2008-12-09 10:16:08.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-09 10:16:08.000000000 -0800
@@ -847,17 +847,16 @@ static void __init *careful_zallocation(
 	/*
 	 * We initialize the nodes in numeric order: 0, 1, 2...
 	 * and hand over control from the LMB allocator to the
-	 * bootmem allocator.  If this function is called for
-	 * node 5, then we know that all nodes <5 are using the
-	 * bootmem allocator instead of the LMB allocator.
+	 * bootmem allocator.
 	 *
-	 * So, check the nid from which this allocation came
-	 * and double check to see if we need to use bootmem
-	 * instead of the LMB.  We don't free the LMB memory
-	 * since it would be useless.
+	 * We must not call into the bootmem allocator for any node
+	 * which has not had bootmem initialized and had all of the
+	 * reserved areas set up.  In do_init_bootmem_node(), we do
+	 * not set NODE_DATA(nid) up until that is done.  Use that
+	 * property here.
 	 */
 	new_nid = early_pfn_to_nid(ret_paddr >> PAGE_SHIFT);
-	if (new_nid < nid) {
+	if (NODE_DATA(new_nid)) {
 		ret = __alloc_bootmem_node(NODE_DATA(new_nid),
 				size, align, 0);
 
@@ -873,12 +872,12 @@ static struct notifier_block __cpuinitda
 	.priority = 1 /* Must run before sched domains notifier. */
 };
 
-static void mark_reserved_regions_for_nid(int nid)
+static void mark_reserved_regions_for_node(struct pglist_data *node)
 {
-	struct pglist_data *node = NODE_DATA(nid);
+	int nid = node->node_id;
 	int i;
 
-	dbg("mark_reserved_regions_for_nid(%d) NODE_DATA: %p\n", nid, node);
+	dbg("%s(%d) NODE_DATA: %p\n", __func__, nid, node);
 	for (i = 0; i < lmb.reserved.cnt; i++) {
 		unsigned long physbase = lmb.reserved.region[i].base;
 		unsigned long size = lmb.reserved.region[i].size;
@@ -915,9 +914,8 @@ static void mark_reserved_regions_for_ni
 			 * yet have valid NODE_DATA().
 			 */
 			if (node_ar.nid == nid)
-				reserve_bootmem_node(NODE_DATA(node_ar.nid),
-						physbase, reserve_size,
-						BOOTMEM_DEFAULT);
+				reserve_bootmem_node(node, physbase,
+						reserve_size, BOOTMEM_DEFAULT);
 			/*
 			 * if reserved region is contained in the active region
 			 * then done.
@@ -938,8 +936,9 @@ static void mark_reserved_regions_for_ni
 	}
 }
 
-void do_init_bootmem_node(int node)
+void do_init_bootmem_node(int nid)
 {
+	struct pglist_data *node;
 	unsigned long start_pfn, end_pfn;
 	void *bootmem_vaddr;
 	unsigned long bootmap_pages;
@@ -954,18 +953,16 @@ void do_init_bootmem_node(int node)
 	 * previous nodes' bootmem to be initialized and have
 	 * all reserved areas marked.
 	 */
-	NODE_DATA(nid) = careful_zallocation(nid,
-				sizeof(struct pglist_data),
-				SMP_CACHE_BYTES, end_pfn);
-
-	dbg("node %d\n", nid);
-	dbg("NODE_DATA() = %p\n", NODE_DATA(nid));
-
-	NODE_DATA(nid)->bdata = &bootmem_node_data[nid];
-	NODE_DATA(nid)->node_start_pfn = start_pfn;
-	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
+	node = careful_zallocation(nid, sizeof(struct pglist_data),
+				   SMP_CACHE_BYTES, end_pfn);
 
-	if (NODE_DATA(nid)->node_spanned_pages == 0)
+	dbg("node %d pgkist_data: %p\n", nid, node);
+
+	node->bdata = &bootmem_node_data[nid];
+	node->node_start_pfn = start_pfn;
+	node->node_spanned_pages = end_pfn - start_pfn;
+
+	if (node->node_spanned_pages == 0)
 		return;
 
 	dbg("start_paddr = %lx\n", start_pfn << PAGE_SHIFT);
@@ -978,17 +975,19 @@ void do_init_bootmem_node(int node)
 
 	dbg("bootmap_vaddr = %p\n", bootmem_vaddr);
 
-	init_bootmem_node(NODE_DATA(nid),
-			  __pa(bootmem_vaddr) >> PAGE_SHIFT,
+	init_bootmem_node(node, __pa(bootmem_vaddr) >> PAGE_SHIFT,
 			  start_pfn, end_pfn);
 
+	NODE_DATA(nid) = node;
+	/* this call needs NODE_DATA(), so initialize it above */
 	free_bootmem_with_active_regions(nid, end_pfn);
+	mark_reserved_regions_for_node(node);
 	/*
-	 * Be very careful about moving this around.  Future
-	 * calls to careful_zallocation() depend on this getting
-	 * done correctly.
+	 * We wait to set NODE_DATA() until after the bootmem
+	 * allocator on this node is up and ready to go.
+	 * careful_zallocation() depends on this getting set
+	 * now to tell from which nodes it must use bootmem.
 	 */
-	mark_reserved_regions_for_nid(nid);
 	sparse_memory_present_with_active_regions(nid);
 }
 
_
