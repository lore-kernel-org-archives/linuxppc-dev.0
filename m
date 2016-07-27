Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtY02CPzDrLf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 07/21] powerpc/mm: Make MMU_FTR_RADIX a MMU family feature
Date: Thu, 28 Jul 2016 00:18:03 +1000
Message-Id: <1469629097-30859-7-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

MMU feature bits are defined such that we use the lower half to
present MMU family features. Remove the strict split of half and
also move Radix to a mmu family feature. Radix introduce a new MMU
model and strictly speaking it is a new MMU family. This also free
up bits which can be used for individual features later.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  2 +-
 arch/powerpc/include/asm/mmu.h           | 15 +++++++--------
 arch/powerpc/kernel/entry_64.S           |  2 +-
 arch/powerpc/kernel/exceptions-64s.S     |  8 ++++----
 arch/powerpc/kernel/idle_book3s.S        |  2 +-
 arch/powerpc/kernel/prom.c               |  2 +-
 arch/powerpc/mm/init_64.c                |  2 +-
 7 files changed, 16 insertions(+), 17 deletions(-)

v3: Merged into this series.

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 9ee00c2576d0..ad2d501cddcf 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -24,7 +24,7 @@ struct mmu_psize_def {
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
 #ifdef CONFIG_PPC_RADIX_MMU
-#define radix_enabled() mmu_has_feature(MMU_FTR_RADIX)
+#define radix_enabled() mmu_has_feature(MMU_FTR_TYPE_RADIX)
 #else
 #define radix_enabled() (0)
 #endif
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 14220c5c12c9..599781e48552 100644
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
@@ -21,9 +21,13 @@
 #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
 #define MMU_FTR_TYPE_47x		ASM_CONST(0x00000020)
 
+/* Radix page table supported and enabled */
+#define MMU_FTR_TYPE_RADIX		ASM_CONST(0x00000040)
+
 /*
- * This is individual features
+ * Individual features below.
  */
+
 /*
  * We need to clear top 16bits of va (from the remaining 64 bits )in
  * tlbie* instructions
@@ -93,11 +97,6 @@
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
@@ -131,7 +130,7 @@ enum {
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
index 6200e4925d26..334c7fac7a4a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -938,7 +938,7 @@ BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
 	b	handle_page_fault
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 	.align  7
 	.globl  h_data_storage_common
@@ -969,7 +969,7 @@ BEGIN_MMU_FTR_SECTION
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
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 335eb6cedae5..4c2222cffbbc 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -570,7 +570,7 @@ common_exit:
 
 BEGIN_MMU_FTR_SECTION
 	b	no_segments
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	/* Restore SLB  from PACA */
 	ld	r8,PACA_SLBSHADOWPTR(r13)
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b4b6952e8991..b0245bed6f54 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -170,7 +170,7 @@ static struct ibm_pa_feature {
 	 */
 	{CPU_FTR_TM_COMP, 0, 0,
 	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
-	{0, MMU_FTR_RADIX, 0, 0,		40, 0, 0},
+	{0, MMU_FTR_TYPE_RADIX, 0, 0,		40, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index e0ab33d20a10..6259f5db525b 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -425,7 +425,7 @@ void __init mmu_early_init_devtree(void)
 {
 	/* Disable radix mode based on kernel command line. */
 	if (disable_radix)
-		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX;
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 
 	if (radix_enabled())
 		radix__early_init_devtree();
-- 
2.7.4
