Return-Path: <dave@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5947ADDFB0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 05:36:18 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBBIVPNN007857
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 13:31:25 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBBIaF34116940
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 13:36:15 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBBJaKcV002334
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 14:36:25 -0500
Subject: [PATCH 2/2] fix bootmem reservation on uninitialized node
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Thu, 11 Dec 2008 10:36:06 -0800
References: <20081211183603.981E651D@kernel>
In-Reply-To: <20081211183603.981E651D@kernel>
Message-Id: <20081211183606.1E011B66@kernel>
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

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff -puN arch/powerpc/mm/numa.c~fix-bad-node-reserve arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~fix-bad-node-reserve	2008-12-10 14:54:18.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-10 14:55:33.000000000 -0800
@@ -901,10 +901,17 @@ static void mark_reserved_regions_for_ni
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
+			if (node_ar.nid == nid) {
+				dbg("reserve_bootmem %lx %lx nid=%d\n",
+					physbase, reserve_size, node_ar.nid);
+				reserve_bootmem_node(NODE_DATA(node_ar.nid),
+						physbase, reserve_size,
+						BOOTMEM_DEFAULT);
+			}
 			/*
 			 * if reserved region is contained in the active region
 			 * then done.
_
