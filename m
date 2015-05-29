Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0850F1A05C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:21:33 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 May 2015 18:21:31 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6C94D357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:21:28 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8LKG250135120
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:21:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8Ktmn016837
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:20:56 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2] powerpc/mm: Limit the max memory we can support
Date: Fri, 29 May 2015 13:50:18 +0530
Message-Id: <1432887618-23666-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1432871692-707-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1432871692-707-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to limit the max memory based on Linux page table format.
Add checks to limit memory based on pte size. Also limit the memory
based on MAX_PHSYSMEM_BITS.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V1:
* Update commit message. 4K can handle 64TB
* Also limit based on MAX_PHSYSMEM_BITS

 arch/powerpc/include/asm/mmu.h       |  8 ++++++++
 arch/powerpc/include/asm/sparsemem.h |  2 --
 arch/powerpc/kernel/prom.c           | 25 ++++++++++++++++++++++---
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 3d5abfe6ba67..d44d49093c8d 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -200,6 +200,14 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 #  include <asm/mmu-8xx.h>
 #endif
 
+#ifdef CONFIG_PHYS_64BIT
+/*
+ * Max supported memory on 64bit system is 64TB.
+ */
+#define MAX_PHYSMEM_BITS        46
+#else
+#define MAX_PHYSMEM_BITS        32
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index f6fc0ee813d7..fc3808378893 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -11,8 +11,6 @@
 #define SECTION_SIZE_BITS       24
 
 #define MAX_PHYSADDR_BITS       46
-#define MAX_PHYSMEM_BITS        46
-
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 308c5e15676b..c09315b32ca7 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -698,9 +698,28 @@ void __init early_init_devtree(void *params)
 #endif
 		reserve_crashkernel();
 	early_reserve_mem();
-
-	/* Ensure that total memory size is page-aligned. */
-	limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
+	/*
+	 * if not specified limit the memory based on the pfn count that
+	 * we can fit in pte_t. Also ensure that total memory size is
+	 * page-aligned.
+	 */
+	if (!memory_limit) {
+		int bit_count;
+		phys_addr_t pte_mem_limit;
+
+		limit = memblock_phys_mem_size();
+		if (limit >= (1ULL << MAX_PHYSMEM_BITS))
+			limit = (1ULL << MAX_PHYSMEM_BITS) - 1;
+
+		BUILD_BUG_ON(sizeof(pte_basic_t) > 8);
+		bit_count = (sizeof(pte_basic_t) * 8) - PTE_RPN_SHIFT + PAGE_SHIFT;
+		pte_mem_limit = ~0ULL >> (64 - bit_count);
+		if (limit > pte_mem_limit)
+			limit = pte_mem_limit;
+	} else
+		limit = memory_limit;
+
+	limit = ALIGN(limit, PAGE_SIZE);
 	memblock_enforce_memory_limit(limit);
 
 	memblock_allow_resize();
-- 
2.1.4
