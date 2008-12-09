Return-Path: <dave@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C5ACDDF77
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:21:45 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9ILFdq031901
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:15 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9ILdwM189702
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:39 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9ILdwC032431
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:39 -0500
Subject: [PATCH 5/8] cleanup careful_allocation(): consolidate memset()
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2008 10:21:36 -0800
References: <20081209182130.DB2150A2@kernel>
In-Reply-To: <20081209182130.DB2150A2@kernel>
Message-Id: <20081209182136.0D1397F7@kernel>
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


Both users of careful_allocation() immediately memset() the
result.  So, just do it in one place.

Also give careful_allocation() a 'z' prefix to bring it in
line with kzmalloc() and friends.

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff -puN arch/powerpc/mm/numa.c~cleanup-careful_allocation2 arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~cleanup-careful_allocation2	2008-12-09 10:16:06.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-09 10:16:06.000000000 -0800
@@ -824,7 +824,7 @@ static void __init dump_numa_memory_topo
  *
  * Returns the virtual address of the memory.
  */
-static void __init *careful_allocation(int nid, unsigned long size,
+static void __init *careful_zallocation(int nid, unsigned long size,
 				       unsigned long align,
 				       unsigned long end_pfn)
 {
@@ -864,6 +864,7 @@ static void __init *careful_allocation(i
 		dbg("alloc_bootmem %p %lx\n", ret, size);
 	}
 
+	memset(ret, 0, size);
 	return ret;
 }
 
@@ -970,10 +971,9 @@ void __init do_init_bootmem(void)
 		 * previous nodes' bootmem to be initialized and have
 		 * all reserved areas marked.
 		 */
-		NODE_DATA(nid) = careful_allocation(nid,
+		NODE_DATA(nid) = careful_zallocation(nid,
 					sizeof(struct pglist_data),
 					SMP_CACHE_BYTES, end_pfn);
-		memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
 
   		dbg("node %d\n", nid);
 		dbg("NODE_DATA() = %p\n", NODE_DATA(nid));
@@ -989,10 +989,9 @@ void __init do_init_bootmem(void)
   		dbg("end_paddr = %lx\n", end_pfn << PAGE_SHIFT);
 
 		bootmap_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-		bootmem_vaddr = careful_allocation(nid,
+		bootmem_vaddr = careful_zallocation(nid,
 					bootmap_pages << PAGE_SHIFT,
 					PAGE_SIZE, end_pfn);
-		memset(bootmem_vaddr, 0, bootmap_pages << PAGE_SHIFT);
 
 		dbg("bootmap_vaddr = %p\n", bootmem_vaddr);
 
@@ -1003,7 +1002,7 @@ void __init do_init_bootmem(void)
 		free_bootmem_with_active_regions(nid, end_pfn);
 		/*
 		 * Be very careful about moving this around.  Future
-		 * calls to careful_allocation() depend on this getting
+		 * calls to careful_zallocation() depend on this getting
 		 * done correctly.
 		 */
 		mark_reserved_regions_for_nid(nid);
_
