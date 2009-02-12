Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4994A454.4080207@am.sony.com>
Date: Thu, 12 Feb 2009 14:36:04 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch] powerpc: fix numa reserve bootmem page selection
References: <48EE6720.6010601@linux.vnet.ibm.com>
	<49924348.5050702@am.sony.com>
In-Reply-To: <49924348.5050702@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dave Hansen <dave@linux.vnet.ibm.com>

Fix the powerpc NUMA reserve bootmem page selection logic.

commit 8f64e1f2d1e09267ac926e15090fd505c1c0cbcb (powerpc: Reserve
in bootmem lmb reserved regions that cross NUMA nodes) changed
the logic for how the powerpc LMB reserved regions were converted
to bootmen reserved regions.  As the folowing discussion reports,
the new logic was not correct.


mark_reserved_regions_for_nid() goes through each LMB on the
system that specifies a reserved area.  It searches for
active regions that intersect with that LMB and are on the
specified node.  It attempts to bootmem-reserve only the area
where the active region and the reserved LMB intersect.  We
can not reserve things on other nodes as they may not have
bootmem structures allocated, yet.

We base the size of the bootmem reservation on two possible
things.  Normally, we just make the reservation start and
stop exactly at the start and end of the LMB.

However, the LMB reservations are not aware of NUMA nodes and
on occasion a single LMB may cross into several adjacent
active regions.  Those may even be on different NUMA nodes
and will require separate calls to the bootmem reserve
functions.  So, the bootmem reservation must be trimmed to
fit inside the current active region.

That's all fine and dandy, but we trim the reservation
in a page-aligned fashion.  That's bad because we start the
reservation at a non-page-aligned address: physbase.

The reservation may only span 2 bytes, but that those bytes
may span two pfns and cause a reserve_size of 2*PAGE_SIZE.

Take the case where you reserve 0x2 bytes at 0x0fff and
where the active region ends at 0x1000.  You'll jump into
that if() statment, but node_ar.end_pfn=0x1 and
start_pfn=0x0.  You'll end up with a reserve_size=0x1000,
and then call

  reserve_bootmem_node(node, physbase=0xfff, size=0x1000);

0x1000 may not be on the same node as 0xfff.  Oops.

In almost all the vm code, end_<anything> is not inclusive.
If you have an end_pfn of 0x1234, page 0x1234 is not
included in the range.  Using PFN_UP instead of the 
(>> >> PAGE_SHIFT) will make this consistent with the other VM
code.

We also need to do math for the reserved size with physbase
instead of start_pfn.  node_ar.end_pfn << PAGE_SHIFT is
*precisely* the end of the node.  However,
(start_pfn << PAGE_SHIFT) is *NOT* precisely the beginning
of the reserved area.  That is, of course, physbase.
If we don't use physbase here, the reserve_size can be
made too large.

From: Dave Hansen <dave@linux.vnet.ibm.com>
Tested-by: Geoff Levand <geoffrey.levand@am.sony.com>  Tested on PS3.
---

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -puN arch/powerpc/mm/numa.c~reserve-over-fix arch/powerpc/mm/numa.c
--- a/arch/powerpc/mm/numa.c~reserve-over-fix
+++ b/arch/powerpc/mm/numa.c
@@ -19,6 +19,7 @@
 #include <linux/notifier.h>
 #include <linux/lmb.h>
 #include <linux/of.h>
+#include <linux/pfn.h>
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
 #include <asm/system.h>
@@ -882,7 +883,7 @@ static void mark_reserved_regions_for_ni
 		unsigned long physbase = lmb.reserved.region[i].base;
 		unsigned long size = lmb.reserved.region[i].size;
 		unsigned long start_pfn = physbase >> PAGE_SHIFT;
-		unsigned long end_pfn = ((physbase + size) >> PAGE_SHIFT);
+		unsigned long end_pfn = PFN_UP(physbase + size);
 		struct node_active_region node_ar;
 		unsigned long node_end_pfn = node->node_start_pfn +
 					     node->node_spanned_pages;
@@ -908,7 +909,7 @@ static void mark_reserved_regions_for_ni
 			 */
 			if (end_pfn > node_ar.end_pfn)
 				reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
-					- (start_pfn << PAGE_SHIFT);
+					- physbase;
 			/*
 			 * Only worry about *this* node, others may not
 			 * yet have valid NODE_DATA().
