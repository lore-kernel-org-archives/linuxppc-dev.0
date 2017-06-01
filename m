Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdqd60PldzDqKd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 00:35:21 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51EU42J097473
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 10:35:19 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atm3qanhn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 10:35:19 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 08:35:18 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Hugh Dickins <hughd@google.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/4k: Limit 4k page size config to 64TB virtual
 address space
Date: Thu,  1 Jun 2017 20:05:04 +0530
Message-Id: <1496327704-8197-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Supporting 512TB requires us to do a order 3 allocation for level 1 page
table(pgd). This results in page allocation failures with certain workloads.
For now limit 4k linux page size config to 64TB.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h |  2 +-
 arch/powerpc/include/asm/processor.h         | 25 ++++++++++++-------------
 arch/powerpc/kernel/setup-common.c           |  2 +-
 arch/powerpc/mm/mmu_context_book3s64.c       |  2 +-
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index b4b5e6b671ca..0c4e470571ca 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -8,7 +8,7 @@
 #define H_PTE_INDEX_SIZE  9
 #define H_PMD_INDEX_SIZE  7
 #define H_PUD_INDEX_SIZE  9
-#define H_PGD_INDEX_SIZE  12
+#define H_PGD_INDEX_SIZE  9
 
 #ifndef __ASSEMBLY__
 #define H_PTE_TABLE_SIZE	(sizeof(pte_t) << H_PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index a2123f291ab0..bb99b651085a 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -110,13 +110,18 @@ void release_thread(struct task_struct *);
 #define TASK_SIZE_128TB (0x0000800000000000UL)
 #define TASK_SIZE_512TB (0x0002000000000000UL)
 
-#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * For now 512TB is only supported with book3s and 64K linux page size.
+ */
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
 /*
  * Max value currently used:
  */
-#define TASK_SIZE_USER64	TASK_SIZE_512TB
+#define TASK_SIZE_USER64		TASK_SIZE_512TB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
 #else
-#define TASK_SIZE_USER64	TASK_SIZE_64TB
+#define TASK_SIZE_USER64		TASK_SIZE_64TB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
 #endif
 
 /*
@@ -132,7 +137,7 @@ void release_thread(struct task_struct *);
  * space during mmap's.
  */
 #define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
-#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(TASK_SIZE_128TB / 4))
+#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64 / 4))
 
 #define TASK_UNMAPPED_BASE ((is_32bit_task()) ? \
 		TASK_UNMAPPED_BASE_USER32 : TASK_UNMAPPED_BASE_USER64 )
@@ -143,21 +148,15 @@ void release_thread(struct task_struct *);
  * with 128TB and conditionally enable upto 512TB
  */
 #ifdef CONFIG_PPC_BOOK3S_64
-#define DEFAULT_MAP_WINDOW	((is_32bit_task()) ? \
-				 TASK_SIZE_USER32 : TASK_SIZE_128TB)
+#define DEFAULT_MAP_WINDOW	((is_32bit_task()) ?			\
+				 TASK_SIZE_USER32 : DEFAULT_MAP_WINDOW_USER64)
 #else
 #define DEFAULT_MAP_WINDOW	TASK_SIZE
 #endif
 
 #ifdef __powerpc64__
 
-#ifdef CONFIG_PPC_BOOK3S_64
-/* Limit stack to 128TB */
-#define STACK_TOP_USER64 TASK_SIZE_128TB
-#else
-#define STACK_TOP_USER64 TASK_SIZE_USER64
-#endif
-
+#define STACK_TOP_USER64 DEFAULT_MAP_WINDOW_USER64
 #define STACK_TOP_USER32 TASK_SIZE_USER32
 
 #define STACK_TOP (is_32bit_task() ? \
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 8389ff5ac002..77062461c469 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -921,7 +921,7 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_PPC_MM_SLICES
 #ifdef CONFIG_PPC64
-	init_mm.context.addr_limit = TASK_SIZE_128TB;
+	init_mm.context.addr_limit = DEFAULT_MAP_WINDOW_USER64;
 #else
 #error	"context.addr_limit not initialized."
 #endif
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index c6dca2ae78ef..a3edf813d455 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -99,7 +99,7 @@ static int hash__init_new_context(struct mm_struct *mm)
 	 * mm->context.addr_limit. Default to max task size so that we copy the
 	 * default values to paca which will help us to handle slb miss early.
 	 */
-	mm->context.addr_limit = TASK_SIZE_128TB;
+	mm->context.addr_limit = DEFAULT_MAP_WINDOW_USER64;
 
 	/*
 	 * The old code would re-promote on fork, we don't do that when using
-- 
2.7.4
