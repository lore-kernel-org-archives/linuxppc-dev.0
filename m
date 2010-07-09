Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F78C100857
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:03 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696H1uL027099
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:01 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H2cD688168
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:02 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696H2Le011469
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:02 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/13] powerpc/book3e: Adjust the page sizes list based on MMU
	config
Date: Fri,  9 Jul 2010 16:16:54 +1000
Message-Id: <1278656215-24705-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-11-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-7-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-8-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-9-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-10-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-11-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the MMU config registers to scan for available direct and
indirect page sizes and print out the result. Will be needed
for future hugetlbfs implementation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu-book3e.h |    4 +
 arch/powerpc/include/asm/reg_booke.h  |    1 +
 arch/powerpc/mm/tlb_nohash.c          |  136 +++++++++++++++++++++++++--------
 3 files changed, 109 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 7469581..87a1d78 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -193,6 +193,10 @@ struct mmu_psize_def
 {
 	unsigned int	shift;	/* number of bits */
 	unsigned int	enc;	/* PTE encoding */
+	unsigned int    ind;    /* Corresponding indirect page size shift */
+	unsigned int	flags;
+#define MMU_PAGE_SIZE_DIRECT	0x1	/* Supported as a direct size */
+#define MMU_PAGE_SIZE_INDIRECT	0x2	/* Supported as an indirect size */
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 66dc6f0..667a498 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -62,6 +62,7 @@
 #define SPRN_TLB0PS	0x158	/* TLB 0 Page Size Register */
 #define SPRN_MAS5_MAS6	0x15c	/* MMU Assist Register 5 || 6 */
 #define SPRN_MAS8_MAS1	0x15d	/* MMU Assist Register 8 || 1 */
+#define SPRN_EPTCFG	0x15e	/* Embedded Page Table Config */
 #define SPRN_MAS7_MAS3	0x174	/* MMU Assist Register 7 || 3 */
 #define SPRN_MAS0_MAS1	0x175	/* MMU Assist Register 0 || 1 */
 #define SPRN_IVOR0	0x190	/* Interrupt Vector Offset Register 0 */
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 2ce42bf..3b10f80 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -46,6 +46,7 @@
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	[MMU_PAGE_4K] = {
 		.shift	= 12,
+		.ind	= 20,
 		.enc	= BOOK3E_PAGESZ_4K,
 	},
 	[MMU_PAGE_16K] = {
@@ -54,6 +55,7 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	},
 	[MMU_PAGE_64K] = {
 		.shift	= 16,
+		.ind	= 28,
 		.enc	= BOOK3E_PAGESZ_64K,
 	},
 	[MMU_PAGE_1M] = {
@@ -62,6 +64,7 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	},
 	[MMU_PAGE_16M] = {
 		.shift	= 24,
+		.ind	= 36,
 		.enc	= BOOK3E_PAGESZ_16M,
 	},
 	[MMU_PAGE_256M] = {
@@ -344,16 +347,108 @@ void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
 	}
 }
 
-/*
- * Early initialization of the MMU TLB code
- */
-static void __early_init_mmu(int boot_cpu)
+static void setup_page_sizes(void)
+{
+	unsigned int tlb0cfg = mfspr(SPRN_TLB0CFG);
+	unsigned int tlb0ps = mfspr(SPRN_TLB0PS);
+	unsigned int eptcfg = mfspr(SPRN_EPTCFG);
+	int i, psize;
+
+	/* Look for supported direct sizes */
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
+		struct mmu_psize_def *def = &mmu_psize_defs[psize];
+
+		if (tlb0ps & (1U << (def->shift - 10)))
+			def->flags |= MMU_PAGE_SIZE_DIRECT;
+	}
+
+	/* Indirect page sizes supported ? */
+	if ((tlb0cfg & TLBnCFG_IND) == 0)
+		goto no_indirect;
+
+	/* Now, we only deal with one IND page size for each
+	 * direct size. Hopefully all implementations today are
+	 * unambiguous, but we might want to be careful in the
+	 * future.
+	 */
+	for (i = 0; i < 3; i++) {
+		unsigned int ps, sps;
+
+		sps = eptcfg & 0x1f;
+		eptcfg >>= 5;
+		ps = eptcfg & 0x1f;
+		eptcfg >>= 5;
+		if (!ps || !sps)
+			continue;
+		for (psize = 0; psize < MMU_PAGE_COUNT; psize++) {
+			struct mmu_psize_def *def = &mmu_psize_defs[psize];
+
+			if (ps == (def->shift - 10))
+				def->flags |= MMU_PAGE_SIZE_INDIRECT;
+			if (sps == (def->shift - 10))
+				def->ind = ps + 10;
+		}
+	}
+ no_indirect:
+
+	/* Cleanup array and print summary */
+	pr_info("MMU: Supported page sizes\n");
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
+		struct mmu_psize_def *def = &mmu_psize_defs[psize];
+		const char *__page_type_names[] = {
+			"unsupported",
+			"direct",
+			"indirect",
+			"direct & indirect"
+		};
+		if (def->flags == 0) {
+			def->shift = 0;	
+			continue;
+		}
+		pr_info("  %8ld KB as %s\n", 1ul << (def->shift - 10),
+			__page_type_names[def->flags & 0x3]);
+	}
+}
+
+static void setup_mmu_htw(void)
 {
 	extern unsigned int interrupt_base_book3e;
 	extern unsigned int exc_data_tlb_miss_htw_book3e;
 	extern unsigned int exc_instruction_tlb_miss_htw_book3e;
 
 	unsigned int *ibase = &interrupt_base_book3e;
+
+	/* Check if HW tablewalk is present, and if yes, enable it by:
+	 *
+	 * - patching the TLB miss handlers to branch to the
+	 *   one dedicates to it
+	 *
+	 * - setting the global book3e_htw_enabled
+       	 */
+	unsigned int tlb0cfg = mfspr(SPRN_TLB0CFG);
+
+	if ((tlb0cfg & TLBnCFG_IND) &&
+	    (tlb0cfg & TLBnCFG_PT)) {
+		/* Our exceptions vectors start with a NOP and -then- a branch
+		 * to deal with single stepping from userspace which stops on
+		 * the second instruction. Thus we need to patch the second
+		 * instruction of the exception, not the first one
+		 */
+		patch_branch(ibase + (0x1c0 / 4) + 1,
+			     (unsigned long)&exc_data_tlb_miss_htw_book3e, 0);
+		patch_branch(ibase + (0x1e0 / 4) + 1,
+			     (unsigned long)&exc_instruction_tlb_miss_htw_book3e, 0);
+		book3e_htw_enabled = 1;
+	}
+	pr_info("MMU: Book3E Page Tables %s\n",
+		book3e_htw_enabled ? "Enabled" : "Disabled");
+}
+
+/*
+ * Early initialization of the MMU TLB code
+ */
+static void __early_init_mmu(int boot_cpu)
+{
 	unsigned int mas4;
 
 	/* XXX This will have to be decided at runtime, but right
@@ -370,40 +465,17 @@ static void __early_init_mmu(int boot_cpu)
 	 */
 	mmu_vmemmap_psize = MMU_PAGE_16M;
 
-	/* Check if HW tablewalk is present, and if yes, enable it by:
-	 *
-	 * - patching the TLB miss handlers to branch to the
-	 *   one dedicates to it
-	 *
-	 * - setting the global book3e_htw_enabled
-	 *
-	 * - Set MAS4:INDD and default page size
-	 */
-
 	/* XXX This code only checks for TLB 0 capabilities and doesn't
 	 *     check what page size combos are supported by the HW. It
 	 *     also doesn't handle the case where a separate array holds
 	 *     the IND entries from the array loaded by the PT.
 	 */
 	if (boot_cpu) {
-		unsigned int tlb0cfg = mfspr(SPRN_TLB0CFG);
-
-		/* Check if HW loader is supported */
-		if ((tlb0cfg & TLBnCFG_IND) &&
-		    (tlb0cfg & TLBnCFG_PT)) {
-			/* Our exceptions vectors start with a NOP and -then- a branch
-			 * to deal with single stepping from userspace which stops on
-			 * the second instruction. Thus we need to patch the second
-			 * instruction of the exception, not the first one
-			 */
-			patch_branch(ibase + (0x1c0 / 4) + 1,
-				(unsigned long)&exc_data_tlb_miss_htw_book3e, 0);
-			patch_branch(ibase + (0x1e0 / 4) + 1,
-				(unsigned long)&exc_instruction_tlb_miss_htw_book3e, 0);
-			book3e_htw_enabled = 1;
-		}
-		pr_info("MMU: Book3E Page Tables %s\n",
-			book3e_htw_enabled ? "Enabled" : "Disabled");
+		/* Look for supported page sizes */
+		setup_page_sizes();
+
+		/* Look for HW tablewalk support */
+		setup_mmu_htw();
 	}
 
 	/* Set MAS4 based on page table setting */
-- 
1.6.3.3
