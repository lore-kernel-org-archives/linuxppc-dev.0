Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDJ923vWzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:37:13 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YDO5140064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:37:11 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243ent3h0s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:37:11 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:37:10 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 05/13] powerpc/mm: Make MMU_FTR_RADIX a MMU family
 feature
Date: Wed, 13 Jul 2016 15:06:36 +0530
In-Reply-To: <1468402604-5130-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402604-5130-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402604-5130-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/prom.c               |  4 ++--
 5 files changed, 15 insertions(+), 18 deletions(-)

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
index 54471228f7b8..0e7c1a262075 100644
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
@@ -131,7 +129,7 @@ enum {
 		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
 		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
 #ifdef CONFIG_PPC_RADIX_MMU
-		MMU_FTR_RADIX |
+		MMU_FTR_TYPE_RADIX |
 #endif
 		0,
 };
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2e0c565754aa..0bdceef11e75 100644
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
index 8bcc1b457115..2747e901fb99 100644
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
 
@@ -1404,7 +1404,7 @@ BEGIN_MMU_FTR_SECTION
 	beq-	2f
 FTR_SECTION_ELSE
 	b	2f
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 .machine	push
 .machine	"power4"
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 022540b9366d..60572c9cda43 100644
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
@@ -751,7 +751,7 @@ void __init early_init_devtree(void *params)
 	 * now fixup radix MMU mode based on kernel command line
 	 */
 	if (disable_radix)
-		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX;
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 
 	DBG(" <- early_init_devtree()\n");
 }
-- 
2.7.4
