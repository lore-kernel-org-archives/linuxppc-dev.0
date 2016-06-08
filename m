Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmB4pxJzDt2C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:43:54 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58Ed1tS135939
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:43:52 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3tus7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:43:52 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:43:52 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 05/16] powerpc/mm: Make MMU_FTR_RADIX a MMU family feature
Date: Wed,  8 Jun 2016 20:13:12 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/mmu.h |  3 +--
 arch/powerpc/include/asm/mmu.h           | 16 +++++++---------
 arch/powerpc/kernel/entry_64.S           |  2 +-
 arch/powerpc/kernel/exceptions-64s.S     |  8 ++++----
 arch/powerpc/kernel/prom.c               |  2 +-
 5 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index d4eda6420523..6d8306d9aa7a 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -24,12 +24,11 @@ struct mmu_psize_def {
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
 #ifdef CONFIG_PPC_RADIX_MMU
-#define radix_enabled() mmu_has_feature(MMU_FTR_RADIX)
+#define radix_enabled() mmu_has_feature(MMU_FTR_TYPE_RADIX)
 #else
 #define radix_enabled() (0)
 #endif
 
-
 #endif /* __ASSEMBLY__ */
 
 /* 64-bit classic hash table MMU */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 616575fcbcc7..21b71469e66b 100644
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
 /*
  * We need to clear top 16bits of va (from the remaining 64 bits )in
@@ -93,11 +96,6 @@
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
@@ -132,7 +130,7 @@ enum {
 		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
 		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
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
index 946e34ffeae9..44b4417804db 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -168,7 +168,7 @@ static struct ibm_pa_feature {
 	 */
 	{CPU_FTR_TM_COMP, 0, 0,
 	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
-	{0, MMU_FTR_RADIX, 0, 0,		40, 0, 0},
+	{0, MMU_FTR_TYPE_RADIX, 0, 0,		40, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
-- 
2.7.4
