Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzWWN5WFpzDqwx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:24 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:30:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6E4843578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u436UETZ3539340
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:30:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u436Tn7T023223
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:29:49 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [RFC 3/7] powerpc/mm: Define TOP_ZONE as a constant
Date: Tue,  3 May 2016 11:59:22 +0530
Message-Id: <1462256966-19321-4-git-send-email-khandual@linux.vnet.ibm.com>
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

From: Oliver O'Halloran <oohall@gmail.com>

The zone that contains the top of the memory will be either ZONE_NORMAL
or ZONE_HIGHMEM depending on the kernel config. There are two functions
in there which require this information and both of them use an #ifdef
to set a local variable (top_zone). This is a little nuts, so lets just
make it a constant.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/mm/mem.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index ac79dbd..bcaede4 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -61,6 +61,12 @@
 #define CPU_FTR_NOEXECUTE	0
 #endif
 
+#ifdef CONFIG_HIGHMEM
+#define TOP_ZONE ZONE_HIGHMEM
+#else
+#define TOP_ZONE ZONE_NORMAL
+#endif
+
 unsigned long long memory_limit;
 
 #ifdef CONFIG_HIGHMEM
@@ -267,14 +273,9 @@ void __init limit_zone_pfn(enum zone_type zone, unsigned long pfn_limit)
  */
 int dma_pfn_limit_to_zone(u64 pfn_limit)
 {
-	enum zone_type top_zone = ZONE_NORMAL;
 	int i;
 
-#ifdef CONFIG_HIGHMEM
-	top_zone = ZONE_HIGHMEM;
-#endif
-
-	for (i = top_zone; i >= 0; i--) {
+	for (i = TOP_ZONE; i >= 0; i--) {
 		if (max_zone_pfns[i] <= pfn_limit)
 			return i;
 	}
@@ -289,7 +290,6 @@ void __init paging_init(void)
 {
 	unsigned long long total_ram = memblock_phys_mem_size();
 	phys_addr_t top_of_ram = memblock_end_of_DRAM();
-	enum zone_type top_zone;
 
 #ifdef CONFIG_PPC32
 	unsigned long v = __fix_to_virt(__end_of_fixed_addresses - 1);
@@ -313,13 +313,9 @@ void __init paging_init(void)
 	       (long int)((top_of_ram - total_ram) >> 20));
 
 #ifdef CONFIG_HIGHMEM
-	top_zone = ZONE_HIGHMEM;
 	limit_zone_pfn(ZONE_NORMAL, lowmem_end_addr >> PAGE_SHIFT);
-#else
-	top_zone = ZONE_NORMAL;
 #endif
-
-	limit_zone_pfn(top_zone, top_of_ram >> PAGE_SHIFT);
+	limit_zone_pfn(TOP_ZONE, top_of_ram >> PAGE_SHIFT);
 	zone_limits_final = true;
 	free_area_init_nodes(max_zone_pfns);
 
-- 
1.8.3.1
