Return-Path: <dave@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A086CDDF33
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:21:47 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9IKFT0024034
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:20:15 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9ILYde117938
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:21:34 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9ILXxw007030
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:21:33 -0700
Subject: [PATCH 1/8] fix bootmem reservation on uninitialized node
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2008 10:21:30 -0800
References: <20081209182130.DB2150A2@kernel>
In-Reply-To: <20081209182130.DB2150A2@kernel>
Message-Id: <20081209182130.1E4C1438@kernel>
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


careful_allocation() was calling into the bootemem allocator for
nodes which had not been fully initialized and caused a previous
bug.  http://patchwork.ozlabs.org/patch/10528/  So, I merged a
few broken out loops in do_init_bootmem() to fix it.  That changed
the code ordering.

I think this bug is triggered by having reserved areas for a node
which are spanned by another node's contents.  In the
mark_reserved_regions_for_nid() code, we attempt to reserve the
area for a node before we have allocated the NODE_DATA() for that
nid.  We do this since I reordered that loop.  I suck.

This may only present on some systems that have 16GB pages
reserved.  But, it can probably happen on any system that is
trying to reserve large swaths of memory that happen to span other
nodes' contents.

This patch ensures that we do not touch bootmem for any node which
has not been initialized.

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff -puN arch/powerpc/mm/numa.c~fix-bad-node-reserve arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~fix-bad-node-reserve	2008-12-09 10:16:04.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-09 10:16:04.000000000 -0800
@@ -870,6 +870,7 @@ static void mark_reserved_regions_for_ni
 	struct pglist_data *node = NODE_DATA(nid);
 	int i;
 
+	dbg("mark_reserved_regions_for_nid(%d) NODE_DATA: %p\n", nid, node);
 	for (i = 0; i < lmb.reserved.cnt; i++) {
 		unsigned long physbase = lmb.reserved.region[i].base;
 		unsigned long size = lmb.reserved.region[i].size;
@@ -901,10 +902,14 @@ static void mark_reserved_regions_for_ni
 			if (end_pfn > node_ar.end_pfn)
 				reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
 					- (start_pfn << PAGE_SHIFT);
-			dbg("reserve_bootmem %lx %lx nid=%d\n", physbase,
-				reserve_size, node_ar.nid);
-			reserve_bootmem_node(NODE_DATA(node_ar.nid), physbase,
-						reserve_size, BOOTMEM_DEFAULT);
+			/*
+			 * Only worry about *this* node, others may not
+			 * yet have valid NODE_DATA().
+			 */
+			if (node_ar.nid == nid)
+				reserve_bootmem_node(NODE_DATA(node_ar.nid),
+						physbase, reserve_size,
+						BOOTMEM_DEFAULT);
 			/*
 			 * if reserved region is contained in the active region
 			 * then done.
_
