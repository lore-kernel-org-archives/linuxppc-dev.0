Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Dec 2008 16:44:44 +1100
Subject: [PATCH 9/16] powerpc/mm: Introduce MMU features v2
In-Reply-To: <1229319836.100184.344640589620.qpush@grosgo>
Message-Id: <20081215054546.050BEDDFB3@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We're soon running out of CPU features and I need to add some new
ones for various MMU related bits, so this patch separates the MMU
features from the CPU features. I moved over the 32-bit MMU related
ones, added base features for MMU type families, but didn't move
over any 64-bit only feature yet.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Remove a spurrious character that broke 64-bit build

 arch/powerpc/include/asm/cputable.h       |   85 +++++++++-------------
 arch/powerpc/include/asm/feature-fixups.h |   30 +++++++
 arch/powerpc/include/asm/mmu.h            |   27 +++++++
 arch/powerpc/kernel/cputable.c            |  113 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_32.S             |    8 +-
 arch/powerpc/kernel/head_fsl_booke.S      |    4 -
 arch/powerpc/kernel/module.c              |    6 +
 arch/powerpc/kernel/setup_32.c            |    4 +
 arch/powerpc/kernel/setup_64.c            |    2 
 arch/powerpc/kernel/swsusp_32.S           |    6 -
 arch/powerpc/kernel/vdso.c                |   10 ++
 arch/powerpc/kernel/vdso32/vdso32.lds.S   |    3 
 arch/powerpc/kernel/vdso64/vdso64.lds.S   |    3 
 arch/powerpc/kernel/vmlinux.lds.S         |    6 +
 arch/powerpc/mm/mmu_decl.h                |    2 
 arch/powerpc/mm/ppc_mmu_32.c              |    2 
 arch/powerpc/platforms/powermac/sleep.S   |    5 -
 17 files changed, 255 insertions(+), 61 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/cputable.h	2008-12-09 16:42:03.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/cputable.h	2008-12-09 17:07:31.000000000 +1100
@@ -82,6 +82,7 @@ struct cpu_spec {
 	char		*cpu_name;
 	unsigned long	cpu_features;		/* Kernel features */
 	unsigned int	cpu_user_features;	/* Userland features */
+	unsigned int	mmu_features;		/* MMU features */
 
 	/* cache line sizes */
 	unsigned int	icache_bsize;
@@ -144,17 +145,14 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_USE_TB			ASM_CONST(0x0000000000000040)
 #define CPU_FTR_L2CSR			ASM_CONST(0x0000000000000080)
 #define CPU_FTR_601			ASM_CONST(0x0000000000000100)
-#define CPU_FTR_HPTE_TABLE		ASM_CONST(0x0000000000000200)
 #define CPU_FTR_CAN_NAP			ASM_CONST(0x0000000000000400)
 #define CPU_FTR_L3CR			ASM_CONST(0x0000000000000800)
 #define CPU_FTR_L3_DISABLE_NAP		ASM_CONST(0x0000000000001000)
 #define CPU_FTR_NAP_DISABLE_L2_PR	ASM_CONST(0x0000000000002000)
 #define CPU_FTR_DUAL_PLL_750FX		ASM_CONST(0x0000000000004000)
 #define CPU_FTR_NO_DPM			ASM_CONST(0x0000000000008000)
-#define CPU_FTR_HAS_HIGH_BATS		ASM_CONST(0x0000000000010000)
 #define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
 #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
-#define CPU_FTR_BIG_PHYS		ASM_CONST(0x0000000000080000)
 #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
 #define CPU_FTR_PPC_LE			ASM_CONST(0x0000000000200000)
 #define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
@@ -266,107 +264,99 @@ extern const char *powerpc_base_platform
 		     !defined(CONFIG_POWER3) && !defined(CONFIG_POWER4) && \
 		     !defined(CONFIG_BOOKE))
 
-#define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | CPU_FTR_HPTE_TABLE | \
+#define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | \
 	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE)
 #define CPU_FTRS_603	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
 #define CPU_FTRS_604	(CPU_FTR_COMMON | \
-	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_PPC_LE)
+	    CPU_FTR_USE_TB | CPU_FTR_PPC_LE)
 #define CPU_FTRS_740_NOTAU	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
 #define CPU_FTRS_740	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
+	    CPU_FTR_TAU | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_PPC_LE)
 #define CPU_FTRS_750	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
+	    CPU_FTR_TAU | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_PPC_LE)
-#define CPU_FTRS_750CL	(CPU_FTRS_750 | CPU_FTR_HAS_HIGH_BATS)
+#define CPU_FTRS_750CL	(CPU_FTRS_750)
 #define CPU_FTRS_750FX1	(CPU_FTRS_750 | CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM)
 #define CPU_FTRS_750FX2	(CPU_FTRS_750 | CPU_FTR_NO_DPM)
-#define CPU_FTRS_750FX	(CPU_FTRS_750 | CPU_FTR_DUAL_PLL_750FX | \
-		CPU_FTR_HAS_HIGH_BATS)
+#define CPU_FTRS_750FX	(CPU_FTRS_750 | CPU_FTR_DUAL_PLL_750FX)
 #define CPU_FTRS_750GX	(CPU_FTRS_750FX)
 #define CPU_FTRS_7400_NOTAU	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE | \
+	    CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7400	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE | \
+	    CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7450_20	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
+	    CPU_FTR_L3CR | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7450_21	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
+	    CPU_FTR_L3CR | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7450_23	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | CPU_FTR_NEED_PAIRED_STWCX | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
+	    CPU_FTR_L3CR | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7455_1	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | CPU_FTR_NEED_PAIRED_STWCX | \
 	    CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
+	    CPU_FTR_SPEC7450 | CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7455_20	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | CPU_FTR_NEED_PAIRED_STWCX | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
+	    CPU_FTR_L3CR | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP | \
-	    CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
+	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7455	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
-	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_L3CR | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7447_10	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
-	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_L3CR | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC | CPU_FTR_PPC_LE | \
 	    CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7447	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
-	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_L3CR | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7447A	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
-	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_7448	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
-	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR | \
 	    CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_82XX	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
 #define CPU_FTRS_G2_LE	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
-	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS)
+	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP)
 #define CPU_FTRS_E300	(CPU_FTR_MAYBE_CAN_DOZE | \
-	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_COMMON)
 #define CPU_FTRS_E300C2	(CPU_FTR_MAYBE_CAN_DOZE | \
-	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE)
-#define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | \
-	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE)
+#define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | CPU_FTR_USE_TB)
 #define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
 #define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
@@ -379,55 +369,54 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500_2	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
-	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | \
+	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500MC	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
-	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN | \
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
 #define CPU_FTRS_POWER3	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | CPU_FTR_PPC_LE)
+	    CPU_FTR_IABR | CPU_FTR_PPC_LE)
 #define CPU_FTRS_RS64	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | \
+	    CPU_FTR_IABR | \
 	    CPU_FTR_MMCRA | CPU_FTR_CTRL)
 #define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_CP_USE_DCBTZ)
 #define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA | \
 	    CPU_FTR_CP_USE_DCBTZ)
 #define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR)
 #define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | \
 	    CPU_FTR_CELL_TB_BUG | CPU_FTR_CP_USE_DCBTZ | \
 	    CPU_FTR_UNALIGNED_LD_STD)
 #define CPU_FTRS_PA6T (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
+	    CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
 	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_NO_SLBIE_B)
-#define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
+#define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2)
 
 #ifdef __powerpc64__
 #define CPU_FTRS_POSSIBLE	\
Index: linux-work/arch/powerpc/include/asm/feature-fixups.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/feature-fixups.h	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/feature-fixups.h	2008-12-09 16:42:03.000000000 +1100
@@ -81,6 +81,36 @@ label##5:					       	\
 #define ALT_FTR_SECTION_END_IFCLR(msk)	\
 	ALT_FTR_SECTION_END_NESTED_IFCLR(msk, 97)
 
+/* MMU feature dependent sections */
+#define BEGIN_MMU_FTR_SECTION_NESTED(label)	START_FTR_SECTION(label)
+#define BEGIN_MMU_FTR_SECTION			START_FTR_SECTION(97)
+
+#define END_MMU_FTR_SECTION_NESTED(msk, val, label) 		\
+	FTR_SECTION_ELSE_NESTED(label)				\
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __mmu_ftr_fixup)
+
+#define END_MMU_FTR_SECTION(msk, val)		\
+	END_MMU_FTR_SECTION_NESTED(msk, val, 97)
+
+#define END_MMU_FTR_SECTION_IFSET(msk)	END_MMU_FTR_SECTION((msk), (msk))
+#define END_MMU_FTR_SECTION_IFCLR(msk)	END_MMU_FTR_SECTION((msk), 0)
+
+/* MMU feature sections with alternatives, use BEGIN_FTR_SECTION to start */
+#define MMU_FTR_SECTION_ELSE_NESTED(label)	FTR_SECTION_ELSE_NESTED(label)
+#define MMU_FTR_SECTION_ELSE	MMU_FTR_SECTION_ELSE_NESTED(97)
+#define ALT_MMU_FTR_SECTION_END_NESTED(msk, val, label)	\
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __mmu_ftr_fixup)
+#define ALT_MMU_FTR_SECTION_END_NESTED_IFSET(msk, label)	\
+	ALT_MMU_FTR_SECTION_END_NESTED(msk, msk, label)
+#define ALT_MMU_FTR_SECTION_END_NESTED_IFCLR(msk, label)	\
+	ALT_MMU_FTR_SECTION_END_NESTED(msk, 0, label)
+#define ALT_MMU_FTR_SECTION_END(msk, val)	\
+	ALT_MMU_FTR_SECTION_END_NESTED(msk, val, 97)
+#define ALT_MMU_FTR_SECTION_END_IFSET(msk)	\
+	ALT_MMU_FTR_SECTION_END_NESTED_IFSET(msk, 97)
+#define ALT_MMU_FTR_SECTION_END_IFCLR(msk)	\
+	ALT_MMU_FTR_SECTION_END_NESTED_IFCLR(msk, 97)
+
 /* Firmware feature dependent sections */
 #define BEGIN_FW_FTR_SECTION_NESTED(label)	START_FTR_SECTION(label)
 #define BEGIN_FW_FTR_SECTION			START_FTR_SECTION(97)
Index: linux-work/arch/powerpc/include/asm/mmu.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu.h	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu.h	2008-12-09 17:07:34.000000000 +1100
@@ -2,6 +2,33 @@
 #define _ASM_POWERPC_MMU_H_
 #ifdef __KERNEL__
 
+#include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
+
+/*
+ * MMU features bit definitions
+ */
+#define MMU_FTR_HPTE_TABLE		ASM_CONST(0x00000001)
+#define MMU_FTR_TYPE_8xx		ASM_CONST(0x00000002)
+#define MMU_FTR_TYPE_40x		ASM_CONST(0x00000004)
+#define MMU_FTR_TYPE_44x		ASM_CONST(0x00000008)
+#define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
+#define MMU_FTR_HAS_HIGH_BATS		ASM_CONST(0x00010000)
+#define MMU_FTR_BIG_PHYS		ASM_CONST(0x00020000)
+
+#ifndef __ASSEMBLY__
+#include <asm/cputable.h>
+
+static inline int mmu_has_feature(unsigned long feature)
+{
+	return (cur_cpu_spec->mmu_features & feature);
+}
+
+extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
+
+#endif /* !__ASSEMBLY__ */
+
+
 #ifdef CONFIG_PPC64
 /* 64-bit classic hash table MMU */
 #  include <asm/mmu-hash64.h>
Index: linux-work/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2008-12-09 16:42:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cputable.c	2008-12-09 17:07:44.000000000 +1100
@@ -19,6 +19,7 @@
 #include <asm/oprofile_impl.h>
 #include <asm/cputable.h>
 #include <asm/prom.h>		/* for PTRRELOC on ARCH=ppc */
+#include <asm/mmu.h>
 
 struct cpu_spec* cur_cpu_spec = NULL;
 EXPORT_SYMBOL(cur_cpu_spec);
@@ -93,6 +94,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER3 (630)",
 		.cpu_features		= CPU_FTRS_POWER3,
 		.cpu_user_features	= COMMON_USER_PPC64|PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -108,6 +110,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER3 (630+)",
 		.cpu_features		= CPU_FTRS_POWER3,
 		.cpu_user_features	= COMMON_USER_PPC64|PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -123,6 +126,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "RS64-II (northstar)",
 		.cpu_features		= CPU_FTRS_RS64,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -138,6 +142,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "RS64-III (pulsar)",
 		.cpu_features		= CPU_FTRS_RS64,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -153,6 +158,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "RS64-III (icestar)",
 		.cpu_features		= CPU_FTRS_RS64,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -168,6 +174,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "RS64-IV (sstar)",
 		.cpu_features		= CPU_FTRS_RS64,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -183,6 +190,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER4 (gp)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -198,6 +206,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER4+ (gq)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -214,6 +223,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -232,6 +242,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -250,6 +261,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -268,6 +280,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -286,6 +299,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -302,6 +316,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER5 (gr)",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -322,6 +337,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER5+ (gs)",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -338,6 +354,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER5+ (gs)",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -355,6 +372,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER5+",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
@@ -368,6 +386,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_POWER6,
 		.cpu_user_features	= COMMON_USER_POWER6 |
 			PPC_FEATURE_POWER6_EXT,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -387,6 +406,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER6 (architected)",
 		.cpu_features		= CPU_FTRS_POWER6,
 		.cpu_user_features	= COMMON_USER_POWER6,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
@@ -399,6 +419,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER7 (architected)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
@@ -411,6 +432,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER7 (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -433,6 +455,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_PPC64 |
 			PPC_FEATURE_CELL | PPC_FEATURE_HAS_ALTIVEC_COMP |
 			PPC_FEATURE_SMT,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 4,
@@ -448,6 +471,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "PA6T",
 		.cpu_features		= CPU_FTRS_PA6T,
 		.cpu_user_features	= COMMON_USER_PA6T,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 6,
@@ -465,6 +489,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER4 (compatible)",
 		.cpu_features		= CPU_FTRS_COMPATIBLE,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -482,6 +507,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC601,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_601_INSTR |
 			PPC_FEATURE_UNIFIED_CACHE | PPC_FEATURE_NO_TB,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_generic,
@@ -493,6 +519,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "603",
 		.cpu_features		= CPU_FTRS_603,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= 0,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -505,6 +532,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "603e",
 		.cpu_features		= CPU_FTRS_603,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= 0,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -517,6 +545,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "603ev",
 		.cpu_features		= CPU_FTRS_603,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= 0,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -529,6 +558,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "604",
 		.cpu_features		= CPU_FTRS_604,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 2,
@@ -542,6 +572,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "604e",
 		.cpu_features		= CPU_FTRS_604,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -555,6 +586,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "604r",
 		.cpu_features		= CPU_FTRS_604,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -568,6 +600,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "604ev",
 		.cpu_features		= CPU_FTRS_604,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -581,6 +614,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "740/750",
 		.cpu_features		= CPU_FTRS_740_NOTAU,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -594,6 +628,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CX",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -607,6 +642,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CX",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -621,6 +657,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CXe",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -635,6 +672,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CXe",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -649,6 +687,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CL",
 		.cpu_features		= CPU_FTRS_750CL,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -663,6 +702,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "745/755",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -677,6 +717,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750FX",
 		.cpu_features		= CPU_FTRS_750FX1,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -691,6 +732,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750FX",
 		.cpu_features		= CPU_FTRS_750FX2,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -705,6 +747,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750FX",
 		.cpu_features		= CPU_FTRS_750FX,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -719,6 +762,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750GX",
 		.cpu_features		= CPU_FTRS_750GX,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -733,6 +777,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "740/750",
 		.cpu_features		= CPU_FTRS_740,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -748,6 +793,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7400_NOTAU,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -763,6 +809,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7400,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -778,6 +825,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7400,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -793,6 +841,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7450_20,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -810,6 +859,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7450_21,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -827,6 +877,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7450_23,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -844,6 +895,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7455_1,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -861,6 +913,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7455_20,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -878,6 +931,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7455,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -895,6 +949,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7447_10,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -912,6 +967,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7447_10,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -928,6 +984,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "7447/7457",
 		.cpu_features		= CPU_FTRS_7447,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -945,6 +1002,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7447A,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -962,6 +1020,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7448,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -978,6 +1037,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "82xx",
 		.cpu_features		= CPU_FTRS_82XX,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= 0,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -990,6 +1050,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "G2_LE",
 		.cpu_features		= CPU_FTRS_G2_LE,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1002,6 +1063,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e300c1",
 		.cpu_features		= CPU_FTRS_E300,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1014,6 +1076,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e300c2",
 		.cpu_features		= CPU_FTRS_E300C2,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1026,6 +1089,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e300c3",
 		.cpu_features		= CPU_FTRS_E300,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1040,6 +1104,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e300c4",
 		.cpu_features		= CPU_FTRS_E300,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_HAS_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1055,6 +1120,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "(generic PPC)",
 		.cpu_features		= CPU_FTRS_CLASSIC32,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_generic,
@@ -1070,6 +1136,7 @@ static struct cpu_spec __initdata cpu_sp
 		 * if the 8xx code is there.... */
 		.cpu_features		= CPU_FTRS_8XX,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_TYPE_8xx,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 		.platform		= "ppc823",
@@ -1082,6 +1149,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "403GC",
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 		.machine_check		= machine_check_4xx,
@@ -1094,6 +1162,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 		 	PPC_FEATURE_HAS_MMU | PPC_FEATURE_NO_TB,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 		.machine_check		= machine_check_4xx,
@@ -1105,6 +1174,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "403G ??",
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 		.machine_check		= machine_check_4xx,
@@ -1117,6 +1187,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1129,6 +1200,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1141,6 +1213,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1153,6 +1226,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1165,6 +1239,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1177,6 +1252,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1189,6 +1265,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1201,6 +1278,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1212,6 +1290,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "405LP",
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1224,6 +1303,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1236,6 +1316,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1248,6 +1329,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1260,6 +1342,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1272,6 +1355,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1285,6 +1369,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1297,6 +1382,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1311,6 +1397,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GR Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1322,6 +1409,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440EP Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440ep,
@@ -1334,6 +1422,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GR Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1345,6 +1434,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440EP Rev. C",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440ep,
@@ -1357,6 +1447,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440EP Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440ep,
@@ -1369,6 +1460,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GRX",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440grx,
@@ -1381,6 +1473,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440EPX",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440epx,
@@ -1393,6 +1486,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GP Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1404,6 +1498,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GP Rev. C",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1415,6 +1510,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GX Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440gx,
@@ -1427,6 +1523,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GX Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440gx,
@@ -1439,6 +1536,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GX Rev. C",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440gx,
@@ -1451,6 +1549,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GX Rev. F",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440gx,
@@ -1463,6 +1562,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440SP Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1474,6 +1574,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name               = "440SPe Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features      = COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize           = 32,
 		.dcache_bsize           = 32,
 		.cpu_setup		= __setup_cpu_440spe,
@@ -1486,6 +1587,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440SPe Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440spe,
@@ -1498,6 +1600,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440 in Virtex-5 FXT",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.platform		= "ppc440",
@@ -1508,6 +1611,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "460EX",
 		.cpu_features		= CPU_FTRS_440x6,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_460ex,
@@ -1520,6 +1624,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "460GT",
 		.cpu_features		= CPU_FTRS_440x6,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_460gt,
@@ -1532,6 +1637,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "(generic 44x PPC)",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1548,6 +1654,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_EFP_SINGLE |
 			PPC_FEATURE_UNIFIED_CACHE,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
@@ -1562,6 +1669,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_SPE_COMP |
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP |
 			PPC_FEATURE_UNIFIED_CACHE,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
@@ -1574,6 +1682,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_EFP_SINGLE |
 			PPC_FEATURE_UNIFIED_CACHE,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
@@ -1588,6 +1697,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_SPE_COMP |
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -1605,6 +1715,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_SPE_COMP |
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP |
 			PPC_FEATURE_HAS_EFP_DOUBLE_COMP,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -1619,6 +1730,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e500mc",
 		.cpu_features		= CPU_FTRS_E500MC,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS,
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 4,
@@ -1635,6 +1747,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_SPE_COMP |
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_e500,
Index: linux-work/arch/powerpc/kernel/module.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/module.c	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/kernel/module.c	2008-12-09 16:42:03.000000000 +1100
@@ -78,6 +78,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
 
+	sect = find_section(hdr, sechdrs, "__mmu_ftr_fixup");
+	if (sect != NULL)
+		do_feature_fixups(cur_cpu_spec->mmu_features,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
+
 #ifdef CONFIG_PPC64
 	sect = find_section(hdr, sechdrs, "__fw_ftr_fixup");
 	if (sect != NULL)
Index: linux-work/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_32.c	2008-11-24 14:48:55.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_32.c	2008-12-09 17:07:34.000000000 +1100
@@ -97,6 +97,10 @@ notrace unsigned long __init early_init(
 			  PTRRELOC(&__start___ftr_fixup),
 			  PTRRELOC(&__stop___ftr_fixup));
 
+	do_feature_fixups(spec->mmu_features,
+			  PTRRELOC(&__start___mmu_ftr_fixup),
+			  PTRRELOC(&__stop___mmu_ftr_fixup));
+
 	do_lwsync_fixups(spec->cpu_features,
 			 PTRRELOC(&__start___lwsync_fixup),
 			 PTRRELOC(&__stop___lwsync_fixup));
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2008-12-08 15:40:33.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_64.c	2008-12-09 16:42:03.000000000 +1100
@@ -362,6 +362,8 @@ void __init setup_system(void)
 	 */
 	do_feature_fixups(cur_cpu_spec->cpu_features,
 			  &__start___ftr_fixup, &__stop___ftr_fixup);
+	do_feature_fixups(cur_cpu_spec->mmu_features,
+			  &__start___mmu_ftr_fixup, &__stop___mmu_ftr_fixup);
 	do_feature_fixups(powerpc_firmware_features,
 			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
 	do_lwsync_fixups(cur_cpu_spec->cpu_features,
Index: linux-work/arch/powerpc/kernel/vdso.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso.c	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vdso.c	2008-12-09 16:42:03.000000000 +1100
@@ -567,6 +567,11 @@ static __init int vdso_fixup_features(st
 		do_feature_fixups(cur_cpu_spec->cpu_features,
 				  start64, start64 + size64);
 
+	start64 = find_section64(v64->hdr, "__mmu_ftr_fixup", &size64);
+	if (start64)
+		do_feature_fixups(cur_cpu_spec->mmu_features,
+				  start64, start64 + size64);
+
 	start64 = find_section64(v64->hdr, "__fw_ftr_fixup", &size64);
 	if (start64)
 		do_feature_fixups(powerpc_firmware_features,
@@ -583,6 +588,11 @@ static __init int vdso_fixup_features(st
 		do_feature_fixups(cur_cpu_spec->cpu_features,
 				  start32, start32 + size32);
 
+	start32 = find_section32(v32->hdr, "__mmu_ftr_fixup", &size32);
+	if (start32)
+		do_feature_fixups(cur_cpu_spec->mmu_features,
+				  start32, start32 + size32);
+
 #ifdef CONFIG_PPC64
 	start32 = find_section32(v32->hdr, "__fw_ftr_fixup", &size32);
 	if (start32)
Index: linux-work/arch/powerpc/kernel/vdso32/vdso32.lds.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso32/vdso32.lds.S	2008-09-29 10:17:03.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vdso32/vdso32.lds.S	2008-12-09 16:42:03.000000000 +1100
@@ -34,6 +34,9 @@ SECTIONS
 	__ftr_fixup	: { *(__ftr_fixup) }
 
 	. = ALIGN(8);
+	__mmu_ftr_fixup	: { *(__mmu_ftr_fixup) }
+
+	. = ALIGN(8);
 	__lwsync_fixup	: { *(__lwsync_fixup) }
 
 #ifdef CONFIG_PPC64
Index: linux-work/arch/powerpc/kernel/vdso64/vdso64.lds.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso64/vdso64.lds.S	2008-09-29 10:17:03.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vdso64/vdso64.lds.S	2008-12-09 16:42:03.000000000 +1100
@@ -35,6 +35,9 @@ SECTIONS
 	__ftr_fixup	: { *(__ftr_fixup) }
 
 	. = ALIGN(8);
+	__mmu_ftr_fixup	: { *(__mmu_ftr_fixup) }
+
+	. = ALIGN(8);
 	__lwsync_fixup	: { *(__lwsync_fixup) }
 
 	. = ALIGN(8);
Index: linux-work/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vmlinux.lds.S	2008-11-24 16:35:11.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vmlinux.lds.S	2008-12-09 16:42:03.000000000 +1100
@@ -152,6 +152,12 @@ SECTIONS
 		__stop___ftr_fixup = .;
 	}
 	. = ALIGN(8);
+	__mmu_ftr_fixup : AT(ADDR(__mmu_ftr_fixup) - LOAD_OFFSET) {
+		__start___mmu_ftr_fixup = .;
+		*(__mmu_ftr_fixup)
+		__stop___mmu_ftr_fixup = .;
+	}
+	. = ALIGN(8);
 	__lwsync_fixup : AT(ADDR(__lwsync_fixup) - LOAD_OFFSET) {
 		__start___lwsync_fixup = .;
 		*(__lwsync_fixup)
Index: linux-work/arch/powerpc/mm/mmu_decl.h
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2008-09-29 10:17:03.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_decl.h	2008-12-09 16:42:03.000000000 +1100
@@ -86,7 +86,7 @@ static inline void flush_HPTE(unsigned c
 			      unsigned long pdval)
 {
 	if ((Hash != 0) &&
-	    cpu_has_feature(CPU_FTR_HPTE_TABLE))
+	    mmu_has_feature(MMU_FTR_HPTE_TABLE))
 		flush_hash_pages(0, va, pdval, 1);
 	else
 		_tlbie(va);
Index: linux-work/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/ppc_mmu_32.c	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/mm/ppc_mmu_32.c	2008-12-09 16:42:03.000000000 +1100
@@ -192,7 +192,7 @@ void __init MMU_init_hw(void)
 	extern unsigned int hash_page[];
 	extern unsigned int flush_hash_patch_A[], flush_hash_patch_B[];
 
-	if (!cpu_has_feature(CPU_FTR_HPTE_TABLE)) {
+	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
 		/*
 		 * Put a blr (procedure return) instruction at the
 		 * start of hash_page, since we can still get DSI
Index: linux-work/arch/powerpc/kernel/head_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_32.S	2008-12-09 16:42:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_32.S	2008-12-09 16:42:03.000000000 +1100
@@ -990,12 +990,12 @@ load_up_mmu:
 	LOAD_BAT(1,r3,r4,r5)
 	LOAD_BAT(2,r3,r4,r5)
 	LOAD_BAT(3,r3,r4,r5)
-BEGIN_FTR_SECTION
+BEGIN_MMU_FTR_SECTION
 	LOAD_BAT(4,r3,r4,r5)
 	LOAD_BAT(5,r3,r4,r5)
 	LOAD_BAT(6,r3,r4,r5)
 	LOAD_BAT(7,r3,r4,r5)
-END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HAS_HIGH_BATS)
 	blr
 
 /*
@@ -1141,7 +1141,7 @@ clear_bats:
 	mtspr	SPRN_IBAT2L,r10
 	mtspr	SPRN_IBAT3U,r10
 	mtspr	SPRN_IBAT3L,r10
-BEGIN_FTR_SECTION
+BEGIN_MMU_FTR_SECTION
 	/* Here's a tweak: at this point, CPU setup have
 	 * not been called yet, so HIGH_BAT_EN may not be
 	 * set in HID0 for the 745x processors. However, it
@@ -1164,7 +1164,7 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_IBAT6L,r10
 	mtspr	SPRN_IBAT7U,r10
 	mtspr	SPRN_IBAT7L,r10
-END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HAS_HIGH_BATS)
 	blr
 
 flush_tlbs:
Index: linux-work/arch/powerpc/kernel/swsusp_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/swsusp_32.S	2008-07-07 13:45:04.000000000 +1000
+++ linux-work/arch/powerpc/kernel/swsusp_32.S	2008-12-09 16:42:03.000000000 +1100
@@ -5,7 +5,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
-
+#include <asm/mmu.h>
 
 /*
  * Structure for storing CPU registers on the save area.
@@ -279,7 +279,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	mtibatl	3,r4
 #endif
 
-BEGIN_FTR_SECTION
+BEGIN_MMU_FTR_SECTION
 	li	r4,0
 	mtspr	SPRN_DBAT4U,r4
 	mtspr	SPRN_DBAT4L,r4
@@ -297,7 +297,7 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_IBAT6L,r4
 	mtspr	SPRN_IBAT7U,r4
 	mtspr	SPRN_IBAT7L,r4
-END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HAS_HIGH_BATS)
 
 	/* Flush all TLBs */
 	lis	r4,0x1000
Index: linux-work/arch/powerpc/platforms/powermac/sleep.S
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/sleep.S	2008-07-07 13:45:04.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/sleep.S	2008-12-09 16:42:03.000000000 +1100
@@ -17,6 +17,7 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
+#include <asm/mmu.h>
 
 #define MAGIC	0x4c617273	/* 'Lars' */
 
@@ -323,7 +324,7 @@ grackle_wake_up:
 	lwz	r4,SL_IBAT3+4(r1)
 	mtibatl	3,r4
 
-BEGIN_FTR_SECTION
+BEGIN_MMU_FTR_SECTION
 	li	r4,0
 	mtspr	SPRN_DBAT4U,r4
 	mtspr	SPRN_DBAT4L,r4
@@ -341,7 +342,7 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_IBAT6L,r4
 	mtspr	SPRN_IBAT7U,r4
 	mtspr	SPRN_IBAT7L,r4
-END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HAS_HIGH_BATS)
 
 	/* Flush all TLBs */
 	lis	r4,0x1000
Index: linux-work/arch/powerpc/kernel/head_fsl_booke.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_fsl_booke.S	2008-12-08 15:40:33.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_fsl_booke.S	2008-12-09 16:42:03.000000000 +1100
@@ -767,10 +767,10 @@ finish_tlb_load:
 	rlwimi	r12, r13, 24, 0, 7	/* grab RPN[32:39] */
 	rlwimi	r12, r11, 24, 8, 19	/* grab RPN[40:51] */
 	mtspr	SPRN_MAS3, r12
-BEGIN_FTR_SECTION
+BEGIN_MMU_FTR_SECTION
 	srwi	r10, r13, 8		/* grab RPN[8:31] */
 	mtspr	SPRN_MAS7, r10
-END_FTR_SECTION_IFSET(CPU_FTR_BIG_PHYS)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 #else
 	rlwimi	r11, r12, 0, 20, 31	/* Extract RPN from PTE and merge with perms */
 	mtspr	SPRN_MAS3, r11
