Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0DAC1A00EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:29:31 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/9] powerpc: Remove MMU_FTR_SLB
Date: Thu, 10 Jul 2014 12:29:20 +1000
Message-Id: <1404959366-17664-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
References: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We now only support cpus that use an SLB, so we don't need an MMU
feature to indicate that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h    | 3 +--
 arch/powerpc/include/asm/mmu.h         | 8 ++------
 arch/powerpc/include/asm/mmu_context.h | 3 +--
 arch/powerpc/kernel/entry_64.S         | 8 ++------
 arch/powerpc/kernel/process.c          | 2 +-
 arch/powerpc/kernel/prom.c             | 1 -
 arch/powerpc/mm/hash_utils_64.c        | 6 ++----
 arch/powerpc/xmon/xmon.c               | 8 +-------
 8 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 2721946780df..ed17bc75b0a6 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -195,8 +195,7 @@ extern const char *powerpc_base_platform;
 
 #define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN)
 
-#define MMU_FTR_PPCAS_ARCH_V2 	(MMU_FTR_SLB | MMU_FTR_TLBIEL | \
-				 MMU_FTR_16M_PAGE)
+#define MMU_FTR_PPCAS_ARCH_V2 	(MMU_FTR_TLBIEL | MMU_FTR_16M_PAGE)
 
 /* We only set the altivec features if the kernel was compiled with altivec
  * support
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index f8d1d6dcf7db..c42945b3dbc3 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -65,9 +65,9 @@
  */
 #define MMU_FTR_USE_PAIRED_MAS		ASM_CONST(0x01000000)
 
-/* MMU is SLB-based
+/* Doesn't support the B bit (1T segment) in SLBIE
  */
-#define MMU_FTR_SLB			ASM_CONST(0x02000000)
+#define MMU_FTR_NO_SLBIE_B		ASM_CONST(0x02000000)
 
 /* Support 16M large pages
  */
@@ -89,10 +89,6 @@
  */
 #define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
 
-/* Doesn't support the B bit (1T segment) in SLBIE
- */
-#define MMU_FTR_NO_SLBIE_B		ASM_CONST(0x80000000)
-
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index f5690e2689c7..73382eba02dc 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -76,8 +76,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 * sub architectures.
 	 */
 #ifdef CONFIG_PPC_STD_MMU_64
-	if (mmu_has_feature(MMU_FTR_SLB))
-		switch_slb(tsk, next);
+	switch_slb(tsk, next);
 #else
 	/* Out of line for now */
 	switch_mmu_context(prev, next);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6528c5e2cc44..d6b22e8c8ee1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -482,16 +482,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_STCX_CHECKS_ADDRESS)
 	ld	r8,KSP(r4)	/* new stack pointer */
 #ifdef CONFIG_PPC_BOOK3S
 BEGIN_FTR_SECTION
-  BEGIN_FTR_SECTION_NESTED(95)
 	clrrdi	r6,r8,28	/* get its ESID */
 	clrrdi	r9,r1,28	/* get current sp ESID */
-  FTR_SECTION_ELSE_NESTED(95)
+FTR_SECTION_ELSE
 	clrrdi	r6,r8,40	/* get its 1T ESID */
 	clrrdi	r9,r1,40	/* get current sp 1T ESID */
-  ALT_MMU_FTR_SECTION_END_NESTED_IFCLR(MMU_FTR_1T_SEGMENT, 95)
-FTR_SECTION_ELSE
-	b	2f
-ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_SLB)
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_1T_SEGMENT)
 	clrldi.	r0,r6,2		/* is new ESID c00000000? */
 	cmpd	cr1,r6,r9	/* or is new ESID the same as current ESID? */
 	cror	eq,4*cr1+eq,eq
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index be99774d3f44..e39f388fc25c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1175,7 +1175,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 #endif
 
 #ifdef CONFIG_PPC_STD_MMU_64
-	if (mmu_has_feature(MMU_FTR_SLB)) {
+	{
 		unsigned long sp_vsid;
 		unsigned long llp = mmu_psize_defs[mmu_linear_psize].sllp;
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b694b0730971..1914791dd329 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -155,7 +155,6 @@ static struct ibm_pa_feature {
 } ibm_pa_features[] __initdata = {
 	{0, 0, PPC_FEATURE_HAS_MMU,	0, 0, 0},
 	{0, 0, PPC_FEATURE_HAS_FPU,	0, 1, 0},
-	{0, MMU_FTR_SLB, 0,		0, 2, 0},
 	{CPU_FTR_CTRL, 0, 0,		0, 3, 0},
 	{CPU_FTR_NOEXECUTE, 0, 0,	0, 6, 0},
 	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index fb8bea71327d..6b7c1c824cf9 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -828,8 +828,7 @@ void __init early_init_mmu(void)
 	htab_initialize();
 
 	/* Initialize SLB management */
-	if (mmu_has_feature(MMU_FTR_SLB))
-		slb_initialize();
+	slb_initialize();
 }
 
 #ifdef CONFIG_SMP
@@ -840,8 +839,7 @@ void early_init_mmu_secondary(void)
 		mtspr(SPRN_SDR1, _SDR1);
 
 	/* Initialize SLB */
-	if (mmu_has_feature(MMU_FTR_SLB))
-		slb_initialize();
+	slb_initialize();
 }
 #endif /* CONFIG_SMP */
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index dc8cf285c3ff..8d198b5e9e0a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2690,7 +2690,7 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 }
 
 #ifdef CONFIG_PPC_BOOK3S_64
-static void dump_slb(void)
+void dump_segments(void)
 {
 	int i;
 	unsigned long esid,vsid,valid;
@@ -2722,12 +2722,6 @@ static void dump_slb(void)
 		}
 	}
 }
-
-void dump_segments(void)
-{
-	if (mmu_has_feature(MMU_FTR_SLB))
-		dump_slb();
-}
 #endif
 
 #ifdef CONFIG_PPC_STD_MMU_32
-- 
1.9.1
