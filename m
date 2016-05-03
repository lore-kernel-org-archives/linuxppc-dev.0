Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzWWM5knvzDqnL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:23 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:30:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 52B3E2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u436UBC357344250
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:30:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u436Tkfs023028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:29:46 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [RFC 1/7] powerpc/mm: Make vmemmap_populate accommodate ZONE_DEVICE
 memory
Date: Tue,  3 May 2016 11:59:20 +0530
Message-Id: <1462256966-19321-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the vmemmap_populate function to detect device memory through
to_vmemmap_altmap and then call generic the __vmmemap_alloc_block_buf
function instead of vmemmap_alloc_block as the earlier can allocate
physical memory from the device range instead of the system RAM.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index ba65566..db73708 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -42,6 +42,7 @@
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
+#include <linux/memremap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -312,6 +313,7 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
+	unsigned long orig = start;
 
 	/* Align to the page size of the linear mapping. */
 	start = _ALIGN_DOWN(start, page_size);
@@ -319,13 +321,15 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
 
 	for (; start < end; start += page_size) {
+		struct vmem_altmap *altmap;
 		void *p;
 		int rc;
 
 		if (vmemmap_populated(start, page_size))
 			continue;
 
-		p = vmemmap_alloc_block(page_size, node);
+		altmap = to_vmem_altmap((unsigned long) orig);
+		p = __vmemmap_alloc_block_buf(page_size, node, altmap);
 		if (!p)
 			return -ENOMEM;
 
-- 
1.8.3.1
