Return-Path: <dave@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0457EDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 09:02:46 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAOM2AOs024892
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 15:02:10 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAOM2fRg096814
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 15:02:41 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAOM2emV004451
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 15:02:41 -0700
Subject: [PATCH] Fix boot freeze on machine with empty memory node
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 24 Nov 2008 14:02:35 -0800
Message-Id: <1227564155.22243.45.camel@nimitz>
Mime-Version: 1.0
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, nacc <nacc@linux.vnet.ibm.com>,
	Milton Miller <miltonm@bga.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Nathan Lynch <ntl@pobox.com>, anton <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I got a bug report about a distro kernel not booting on a particular
machine.  It would freeze during boot:

> ...
> Could not find start_pfn for node 1
> [boot]0015 Setup Done
> Built 2 zonelists in Node order, mobility grouping on.  Total pages: 123783
> Policy zone: DMA
> Kernel command line:
> [boot]0020 XICS Init
> [boot]0021 XICS Done
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> clocksource: timebase mult[7d0000] shift[22] registered
> Console: colour dummy device 80x25
> console handover: boot [udbg0] -> real [hvc0]
> Dentry cache hash table entries: 1048576 (order: 7, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 6, 4194304 bytes)
> freeing bootmem node 0

I've reproduced this on 2.6.27.7.  I'm pretty sure it is caused by this
patch:

http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8f64e1f2d1e09267ac926e15090fd505c1c0cbcb

The problem is that Jon took a loop which was (in psuedocode):

	for_each_node(nid)
		NODE_DATA(nid) = careful_alloc(nid);
		setup_bootmem(nid);
		reserve_node_bootmem(nid);

and broke it up into:

	for_each_node(nid)
		NODE_DATA(nid) = careful_alloc(nid);
		setup_bootmem(nid);
	for_each_node(nid)
		reserve_node_bootmem(nid);

The issue comes in when the 'careful_alloc()' is called on a node with
no memory.  It falls back to using bootmem from a previously-initialized
node.  But, bootmem has not yet been reserved when Jon's patch is
applied.  It gives back bogus memory (0xc000000000000000) and pukes
later in boot.

The following patch collapses the loop back together.  It also breaks
the mark_reserved_regions_for_nid() code out into a function and adds
some comments.  I think a huge part of introducing this bug is because
for loop was too long and hard to read.

The actual bug fix here is the:

+		if (end_pfn <= node->node_start_pfn ||
+		    start_pfn >= node_end_pfn)
+			continue;

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>

diff -ru linux-2.6.27.7.orig/arch/powerpc//mm/numa.c linux-2.6.27.7/arch/powerpc//mm/numa.c
--- linux-2.6.27.7.orig/arch/powerpc//mm/numa.c	2008-11-20 17:02:37.000000000 -0600
+++ linux-2.6.27.7/arch/powerpc//mm/numa.c	2008-11-24 15:53:35.000000000 -0600
@@ -822,6 +822,67 @@
 	.priority = 1 /* Must run before sched domains notifier. */
 };
 
+static void mark_reserved_regions_for_nid(int nid)
+{
+	struct pglist_data *node = NODE_DATA(nid);
+	int i;
+
+	for (i = 0; i < lmb.reserved.cnt; i++) {
+		unsigned long physbase = lmb.reserved.region[i].base;
+		unsigned long size = lmb.reserved.region[i].size;
+		unsigned long start_pfn = physbase >> PAGE_SHIFT;
+		unsigned long end_pfn = ((physbase + size) >> PAGE_SHIFT);
+		struct node_active_region node_ar;
+		unsigned long node_end_pfn = node->node_start_pfn +
+					     node->node_spanned_pages;
+
+		/*
+		 * Check to make sure that this lmb.reserved area is
+		 * within the bounds of the node that we care about.
+		 * Checking the nid of the start and end points is not
+		 * sufficient because the reserved area could span the
+		 * entire node.
+		 */
+		if (end_pfn <= node->node_start_pfn ||
+		    start_pfn >= node_end_pfn)
+			continue;
+
+		get_node_active_region(start_pfn, &node_ar);
+		while (start_pfn < end_pfn &&
+			node_ar.start_pfn < node_ar.end_pfn) {
+			unsigned long reserve_size = size;
+			/*
+			 * if reserved region extends past active region
+			 * then trim size to active region
+			 */
+			if (end_pfn > node_ar.end_pfn)
+				reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
+					- (start_pfn << PAGE_SHIFT);
+			dbg("reserve_bootmem %lx %lx nid=%d\n", physbase,
+				reserve_size, node_ar.nid);
+			reserve_bootmem_node(NODE_DATA(node_ar.nid), physbase,
+						reserve_size, BOOTMEM_DEFAULT);
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
+			size = size - reserve_size;
+			get_node_active_region(start_pfn, &node_ar);
+		}
+	}
+}
+
+
 void __init do_init_bootmem(void)
 {
 	int nid;
@@ -847,7 +908,13 @@
 
 		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 
-		/* Allocate the node structure node local if possible */
+		/*
+		 * Allocate the node structure node local if possible
+		 *
+		 * Be careful moving this around, as it relies on all
+		 * previous nodes' bootmem to be initialized and have
+		 * all reserved areas marked.
+		 */
 		NODE_DATA(nid) = careful_allocation(nid,
 					sizeof(struct pglist_data),
 					SMP_CACHE_BYTES, end_pfn);
@@ -879,53 +946,14 @@
 				  start_pfn, end_pfn);
 
 		free_bootmem_with_active_regions(nid, end_pfn);
-	}
-
-	/* Mark reserved regions */
-	for (i = 0; i < lmb.reserved.cnt; i++) {
-		unsigned long physbase = lmb.reserved.region[i].base;
-		unsigned long size = lmb.reserved.region[i].size;
-		unsigned long start_pfn = physbase >> PAGE_SHIFT;
-		unsigned long end_pfn = ((physbase + size) >> PAGE_SHIFT);
-		struct node_active_region node_ar;
-
-		get_node_active_region(start_pfn, &node_ar);
-		while (start_pfn < end_pfn &&
-			node_ar.start_pfn < node_ar.end_pfn) {
-			unsigned long reserve_size = size;
-			/*
-			 * if reserved region extends past active region
-			 * then trim size to active region
-			 */
-			if (end_pfn > node_ar.end_pfn)
-				reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
-					- (start_pfn << PAGE_SHIFT);
-			dbg("reserve_bootmem %lx %lx nid=%d\n", physbase,
-				reserve_size, node_ar.nid);
-			reserve_bootmem_node(NODE_DATA(node_ar.nid), physbase,
-						reserve_size, BOOTMEM_DEFAULT);
-			/*
-			 * if reserved region is contained in the active region
-			 * then done.
-			 */
-			if (end_pfn <= node_ar.end_pfn)
-				break;
-
-			/*
-			 * reserved region extends past the active region
-			 *   get next active region that contains this
-			 *   reserved region
-			 */
-			start_pfn = node_ar.end_pfn;
-			physbase = start_pfn << PAGE_SHIFT;
-			size = size - reserve_size;
-			get_node_active_region(start_pfn, &node_ar);
-		}
-
-	}
-
-	for_each_online_node(nid)
+		/*
+		 * Be very careful about moving this around.  Future
+		 * calls to careful_allocation() depend on this getting
+		 * done correctly.
+		 */
+		mark_reserved_regions_for_nid(nid);
 		sparse_memory_present_with_active_regions(nid);
+	}
 }
 
 void __init paging_init(void)


-- Dave
