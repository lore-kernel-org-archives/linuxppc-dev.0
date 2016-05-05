Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0v0X4lkCzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 22:11:56 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 5 May 2016 17:41:52 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 242B3E005E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 17:44:50 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u45CBtEo24904048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 17:41:55 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u45CBjxZ022679
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 17:41:47 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [PATCH 1/2] powerpc/mm: Make vmemmap_populate accommodate ZONE_DEVICE
 memory
Date: Thu,  5 May 2016 17:41:43 +0530
Message-Id: <1462450304-19173-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
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
 arch/powerpc/mm/init_64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index ba65566..9ae3cdc 100644
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
+	struct vmem_altmap *altmap = to_vmem_altmap((unsigned long) start);
 
 	/* Align to the page size of the linear mapping. */
 	start = _ALIGN_DOWN(start, page_size);
@@ -325,7 +327,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 		if (vmemmap_populated(start, page_size))
 			continue;
 
-		p = vmemmap_alloc_block(page_size, node);
+		p = __vmemmap_alloc_block_buf(page_size, node, altmap);
 		if (!p)
 			return -ENOMEM;
 
-- 
1.9.3
