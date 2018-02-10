Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdpm70cfnzF0gw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 21:57:10 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1AAsMpv016972
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 05:57:09 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1vx73epy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 05:57:08 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 10 Feb 2018 05:57:07 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 5/5] powerpc/mm/hash64: Increase the VA range
Date: Sat, 10 Feb 2018 16:26:43 +0530
In-Reply-To: <20180210105643.11857-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180210105643.11857-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180210105643.11857-6-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 2 +-
 arch/powerpc/include/asm/processor.h          | 9 ++++++++-
 arch/powerpc/mm/init_64.c                     | 6 ------
 arch/powerpc/mm/pgtable_64.c                  | 5 -----
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index d21ff0372f19..3377de7d6207 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -4,7 +4,7 @@
 
 #define H_PTE_INDEX_SIZE  8
 #define H_PMD_INDEX_SIZE  10
-#define H_PUD_INDEX_SIZE  7
+#define H_PUD_INDEX_SIZE  10
 #define H_PGD_INDEX_SIZE  8
 /*
  * No of address bits below which we use the default context
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 01299cdc9806..73050cb412b4 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -109,6 +109,13 @@ void release_thread(struct task_struct *);
 #define TASK_SIZE_64TB  (0x0000400000000000UL)
 #define TASK_SIZE_128TB (0x0000800000000000UL)
 #define TASK_SIZE_512TB (0x0002000000000000UL)
+#define TASK_SIZE_1PB   (0x0004000000000000UL)
+#define TASK_SIZE_2PB   (0x0008000000000000UL)
+/*
+ * With 52 bits in the address we can support
+ * upto 4PB of range.
+ */
+#define TASK_SIZE_4PB   (0x0010000000000000UL)
 
 /*
  * For now 512TB is only supported with book3s and 64K linux page size.
@@ -117,7 +124,7 @@ void release_thread(struct task_struct *);
 /*
  * Max value currently used:
  */
-#define TASK_SIZE_USER64		TASK_SIZE_512TB
+#define TASK_SIZE_USER64		TASK_SIZE_4PB
 #define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
 #else
 #define TASK_SIZE_USER64		TASK_SIZE_64TB
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index f6eb7e8f4c93..624ef8e3e064 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -68,12 +68,6 @@
 
 #include "mmu_decl.h"
 
-#ifdef CONFIG_PPC_BOOK3S_64
-#if H_PGTABLE_RANGE > USER_VSID_RANGE
-#warning Limited user VSID range means pagetable space is wasted
-#endif
-#endif /* CONFIG_PPC_BOOK3S_64 */
-
 phys_addr_t memstart_addr = ~0;
 EXPORT_SYMBOL_GPL(memstart_addr);
 phys_addr_t kernstart_addr;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index a0f8928c0b86..8c9f98771589 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -57,11 +57,6 @@
 
 #include "mmu_decl.h"
 
-#ifdef CONFIG_PPC_BOOK3S_64
-#if TASK_SIZE_USER64 > (1UL << (ESID_BITS + SID_SHIFT))
-#error TASK_SIZE_USER64 exceeds user VSID range
-#endif
-#endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
 /*
-- 
2.14.3
