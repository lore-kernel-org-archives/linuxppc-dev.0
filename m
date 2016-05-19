Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Ndj5LL5zDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:55:05 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:25:02 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 628C0E005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:04 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7sluS13435172
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:47 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7smwV031675
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 5/6] powerpc/mm: Make MMU_FTR_RADIX a MMU family feature
Date: Thu, 19 May 2016 13:24:31 +0530
Message-Id: <1463644472-10158-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MMU feature bits are defined such that we use the lower half to
present MMU family features. Remove the strict split of half and
also move Radix to a mmu family feature. Radix introduce a new MMU
model and strictly speaking it is a new MMU family. This also free
up bits which can be used for individual features later.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  2 +-
 arch/powerpc/include/asm/mmu.h           | 16 +++++++---------
 arch/powerpc/kernel/entry_64.S           |  2 +-
 arch/powerpc/kernel/exceptions-64s.S     |  8 ++++----
 arch/powerpc/kernel/prom.c               |  2 +-
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 5854263d4d6e..c6b1ff795632 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -23,7 +23,7 @@ struct mmu_psize_def {
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
-#define radix_enabled() mmu_has_feature(MMU_FTR_RADIX)
+#define radix_enabled() mmu_has_feature(MMU_FTR_TYPE_RADIX)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e53ebebff474..4ad66a547d4c 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -12,7 +12,7 @@
  */
 
 /*
- * First half is MMU families
+ * MMU families
  */
 #define MMU_FTR_HPTE_TABLE		ASM_CONST(0x00000001)
 #define MMU_FTR_TYPE_8xx		ASM_CONST(0x00000002)
@@ -20,9 +20,12 @@
 #define MMU_FTR_TYPE_44x		ASM_CONST(0x00000008)
 #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
 #define MMU_FTR_TYPE_47x		ASM_CONST(0x00000020)
-
 /*
- * This is individual features
+ * Radix page table available
+ */
+#define MMU_FTR_TYPE_RADIX		ASM_CONST(0x00000040)
+/*
+ * individual features
  */
 
 /* Enable use of high BAT registers */
@@ -88,11 +91,6 @@
  */
 #define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
 
-/*
- * Radix page table available
- */
-#define MMU_FTR_RADIX			ASM_CONST(0x80000000)
-
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
@@ -126,7 +124,7 @@ enum {
 		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
 		MMU_FTR_1T_SEGMENT |
 #ifdef CONFIG_PPC_RADIX_MMU
-		MMU_FTR_RADIX |
+		MMU_FTR_TYPE_RADIX |
 #endif
 		0,
 };
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 73e461a3dfbb..dd26d4ed7513 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -532,7 +532,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 #ifdef CONFIG_PPC_STD_MMU_64
 BEGIN_MMU_FTR_SECTION
 	b	2f
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 BEGIN_FTR_SECTION
 	clrrdi	r6,r8,28	/* get its ESID */
 	clrrdi	r9,r1,28	/* get current sp ESID */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c9440629128..f2bd375b9a4e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -945,7 +945,7 @@ BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
 	b	handle_page_fault
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 	.align  7
 	.globl  h_data_storage_common
@@ -976,7 +976,7 @@ BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
 	b	handle_page_fault
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, unknown_exception)
 
@@ -1390,7 +1390,7 @@ slb_miss_realmode:
 #ifdef CONFIG_PPC_STD_MMU_64
 BEGIN_MMU_FTR_SECTION
 	bl	slb_allocate_realmode
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 #endif
 	/* All done -- return from exception. */
 
@@ -1401,7 +1401,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
 	mtlr	r10
 BEGIN_MMU_FTR_SECTION
 	b	2f
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
 	beq-	2f
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d924cd60fc8e..8d5579b5b6c8 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -166,7 +166,7 @@ static struct ibm_pa_feature {
 	 * which is 0 if the kernel doesn't support TM.
 	 */
 	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
-	{0, MMU_FTR_RADIX, 0,		40, 0, 0},
+	{0, MMU_FTR_TYPE_RADIX, 0,	40, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
-- 
2.7.4
