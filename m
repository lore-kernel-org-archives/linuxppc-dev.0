Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Dec 2008 16:13:32 +1100
Subject: [PATCH 4/10] powerpc/mm: Introduce MMU features v3
In-Reply-To: <1229663599.904385.502157196243.qpush@grosgo>
Message-Id: <20081219051439.8094DDDF63@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
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

v2. Remove a spurrious character that broke 64-bit build
v3. HAS->USE and some comments about individual features

 arch/powerpc/include/asm/cputable.h       |   85 +++++++++-------------
 arch/powerpc/include/asm/feature-fixups.h |   30 +++++++
 arch/powerpc/include/asm/mmu.h            |   41 ++++++++++
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
 arch/powerpc/mm/ppc_mmu_32.c              |    2 
 arch/powerpc/platforms/powermac/sleep.S   |    5 -
 16 files changed, 268 insertions(+), 60 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/cputable.h	2008-12-17 12:30:52.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/cputable.h	2008-12-17 12:34:19.000000000 +1100
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
+++ linux-work/arch/powerpc/include/asm/feature-fixups.h	2008-12-17 12:34:19.000000000 +1100
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
+++ linux-work/arch/powerpc/include/asm/mmu.h	2008-12-17 12:34:19.000000000 +1100
@@ -2,6 +2,47 @@
 #define _ASM_POWERPC_MMU_H_
 #ifdef __KERNEL__
 
+#include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
+
+/*
+ * MMU features bit definitions
+ */
+
+/*
+ * First half is MMU families
+ */
+#define MMU_FTR_HPTE_TABLE		ASM_CONST(0x00000001)
+#define MMU_FTR_TYPE_8xx		ASM_CONST(0x00000002)
+#define MMU_FTR_TYPE_40x		ASM_CONST(0x00000004)
+#define MMU_FTR_TYPE_44x		ASM_CONST(0x00000008)
+#define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
+
+/*
+ * This is individual features
+ */
+
+/* Enable use of high BAT registers */
+#define MMU_FTR_USE_HIGH_BATS		ASM_CONST(0x00010000)
+
+/* Enable >32-bit physical addresses on 32-bit processor, only used
+ * by CONFIG_6xx currently as BookE supports that from day 1
+ */
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
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2008-12-17 12:30:52.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cputable.c	2008-12-17 12:34:19.000000000 +1100
@@ -19,6 +19,7 @@
 #include <asm/oprofile_impl.h>
 #include <asm/cputable.h>
 #include <asm/prom.h>		/* for PTRRELOC on ARCH=ppc */
+#include <asm/mmu.h>
 
 struct cpu_spec* cur_cpu_spec = NULL;
 EXPORT_SYMBOL(cur_cpu_spec);
@@ -94,6 +95,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER3 (630)",
 		.cpu_features		= CPU_FTRS_POWER3,
 		.cpu_user_features	= COMMON_USER_PPC64|PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -109,6 +111,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER3 (630+)",
 		.cpu_features		= CPU_FTRS_POWER3,
 		.cpu_user_features	= COMMON_USER_PPC64|PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -124,6 +127,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "RS64-II (northstar)",
 		.cpu_features		= CPU_FTRS_RS64,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -139,6 +143,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "RS64-III (pulsar)",
 		.cpu_features		= CPU_FTRS_RS64,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -154,6 +159,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "RS64-III (icestar)",
 		.cpu_features		= CPU_FTRS_RS64,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -169,6 +175,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "RS64-IV (sstar)",
 		.cpu_features		= CPU_FTRS_RS64,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -184,6 +191,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER4 (gp)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -199,6 +207,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER4+ (gq)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -215,6 +224,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -233,6 +243,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -251,6 +262,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -269,6 +281,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -287,6 +300,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -303,6 +317,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER5 (gr)",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -323,6 +338,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER5+ (gs)",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -339,6 +355,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER5+ (gs)",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -356,6 +373,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER5+",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
@@ -369,6 +387,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_POWER6,
 		.cpu_user_features	= COMMON_USER_POWER6 |
 			PPC_FEATURE_POWER6_EXT,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -388,6 +407,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER6 (architected)",
 		.cpu_features		= CPU_FTRS_POWER6,
 		.cpu_user_features	= COMMON_USER_POWER6,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
@@ -400,6 +420,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER7 (architected)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
@@ -412,6 +433,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER7 (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -434,6 +456,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_PPC64 |
 			PPC_FEATURE_CELL | PPC_FEATURE_HAS_ALTIVEC_COMP |
 			PPC_FEATURE_SMT,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 4,
@@ -449,6 +472,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "PA6T",
 		.cpu_features		= CPU_FTRS_PA6T,
 		.cpu_user_features	= COMMON_USER_PA6T,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 6,
@@ -466,6 +490,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER4 (compatible)",
 		.cpu_features		= CPU_FTRS_COMPATIBLE,
 		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -483,6 +508,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_PPC601,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_601_INSTR |
 			PPC_FEATURE_UNIFIED_CACHE | PPC_FEATURE_NO_TB,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_generic,
@@ -494,6 +520,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "603",
 		.cpu_features		= CPU_FTRS_603,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= 0,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -506,6 +533,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "603e",
 		.cpu_features		= CPU_FTRS_603,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= 0,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -518,6 +546,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "603ev",
 		.cpu_features		= CPU_FTRS_603,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= 0,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -530,6 +559,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "604",
 		.cpu_features		= CPU_FTRS_604,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 2,
@@ -543,6 +573,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "604e",
 		.cpu_features		= CPU_FTRS_604,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -556,6 +587,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "604r",
 		.cpu_features		= CPU_FTRS_604,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -569,6 +601,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "604ev",
 		.cpu_features		= CPU_FTRS_604,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -582,6 +615,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "740/750",
 		.cpu_features		= CPU_FTRS_740_NOTAU,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -595,6 +629,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CX",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -608,6 +643,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CX",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -622,6 +658,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CXe",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -636,6 +673,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CXe",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -650,6 +688,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750CL",
 		.cpu_features		= CPU_FTRS_750CL,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -664,6 +703,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "745/755",
 		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -678,6 +718,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750FX",
 		.cpu_features		= CPU_FTRS_750FX1,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -692,6 +733,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750FX",
 		.cpu_features		= CPU_FTRS_750FX2,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -706,6 +748,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750FX",
 		.cpu_features		= CPU_FTRS_750FX,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -720,6 +763,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "750GX",
 		.cpu_features		= CPU_FTRS_750GX,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -734,6 +778,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "740/750",
 		.cpu_features		= CPU_FTRS_740,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -749,6 +794,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7400_NOTAU,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -764,6 +810,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7400,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -779,6 +826,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7400,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -794,6 +842,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7450_20,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -811,6 +860,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7450_21,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -828,6 +878,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7450_23,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -845,6 +896,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7455_1,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -862,6 +914,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7455_20,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -879,6 +932,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7455,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -896,6 +950,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7447_10,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -913,6 +968,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7447_10,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -929,6 +985,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "7447/7457",
 		.cpu_features		= CPU_FTRS_7447,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -946,6 +1003,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7447A,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -963,6 +1021,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_7448,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
@@ -979,6 +1038,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "82xx",
 		.cpu_features		= CPU_FTRS_82XX,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= 0,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -991,6 +1051,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "G2_LE",
 		.cpu_features		= CPU_FTRS_G2_LE,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1003,6 +1064,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e300c1",
 		.cpu_features		= CPU_FTRS_E300,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1015,6 +1077,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e300c2",
 		.cpu_features		= CPU_FTRS_E300C2,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1027,6 +1090,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e300c3",
 		.cpu_features		= CPU_FTRS_E300,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1041,6 +1105,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e300c4",
 		.cpu_features		= CPU_FTRS_E300,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1056,6 +1121,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "(generic PPC)",
 		.cpu_features		= CPU_FTRS_CLASSIC32,
 		.cpu_user_features	= COMMON_USER,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_generic,
@@ -1071,6 +1137,7 @@ static struct cpu_spec __initdata cpu_sp
 		 * if the 8xx code is there.... */
 		.cpu_features		= CPU_FTRS_8XX,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_TYPE_8xx,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 		.platform		= "ppc823",
@@ -1083,6 +1150,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "403GC",
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 		.machine_check		= machine_check_4xx,
@@ -1095,6 +1163,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 		 	PPC_FEATURE_HAS_MMU | PPC_FEATURE_NO_TB,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 		.machine_check		= machine_check_4xx,
@@ -1106,6 +1175,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "403G ??",
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 		.machine_check		= machine_check_4xx,
@@ -1118,6 +1188,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1130,6 +1201,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1142,6 +1214,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1154,6 +1227,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1166,6 +1240,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1178,6 +1253,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1190,6 +1266,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1202,6 +1279,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1213,6 +1291,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "405LP",
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1225,6 +1304,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1237,6 +1317,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1249,6 +1330,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1261,6 +1343,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1273,6 +1356,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1286,6 +1370,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1298,6 +1383,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1312,6 +1398,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GR Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1323,6 +1410,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440EP Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440ep,
@@ -1335,6 +1423,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GR Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1346,6 +1435,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440EP Rev. C",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440ep,
@@ -1358,6 +1448,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440EP Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440ep,
@@ -1370,6 +1461,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GRX",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440grx,
@@ -1382,6 +1474,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440EPX",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440epx,
@@ -1394,6 +1487,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GP Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1405,6 +1499,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GP Rev. C",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1416,6 +1511,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GX Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440gx,
@@ -1428,6 +1524,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GX Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440gx,
@@ -1440,6 +1537,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GX Rev. C",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440gx,
@@ -1452,6 +1550,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440GX Rev. F",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440gx,
@@ -1464,6 +1563,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440SP Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1475,6 +1575,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name               = "440SPe Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features      = COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize           = 32,
 		.dcache_bsize           = 32,
 		.cpu_setup		= __setup_cpu_440spe,
@@ -1487,6 +1588,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440SPe Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440spe,
@@ -1499,6 +1601,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "440 in Virtex-5 FXT",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440x5,
@@ -1511,6 +1614,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "460EX",
 		.cpu_features		= CPU_FTRS_440x6,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_460ex,
@@ -1523,6 +1627,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "460GT",
 		.cpu_features		= CPU_FTRS_440x6,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_460gt,
@@ -1535,6 +1640,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "(generic 44x PPC)",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_44x,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_4xx,
@@ -1551,6 +1657,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_EFP_SINGLE |
 			PPC_FEATURE_UNIFIED_CACHE,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
@@ -1565,6 +1672,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_SPE_COMP |
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP |
 			PPC_FEATURE_UNIFIED_CACHE,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
@@ -1577,6 +1685,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_EFP_SINGLE |
 			PPC_FEATURE_UNIFIED_CACHE,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.dcache_bsize		= 32,
 		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
@@ -1591,6 +1700,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_SPE_COMP |
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -1608,6 +1718,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_SPE_COMP |
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP |
 			PPC_FEATURE_HAS_EFP_DOUBLE_COMP,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -1622,6 +1733,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "e500mc",
 		.cpu_features		= CPU_FTRS_E500MC,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS,
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 4,
@@ -1638,6 +1750,7 @@ static struct cpu_spec __initdata cpu_sp
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
+++ linux-work/arch/powerpc/kernel/module.c	2008-12-17 12:34:19.000000000 +1100
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
--- linux-work.orig/arch/powerpc/kernel/setup_32.c	2008-12-17 12:28:23.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_32.c	2008-12-17 12:34:19.000000000 +1100
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
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2008-12-17 12:28:23.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_64.c	2008-12-17 12:34:19.000000000 +1100
@@ -361,6 +361,8 @@ void __init setup_system(void)
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
+++ linux-work/arch/powerpc/kernel/vdso.c	2008-12-17 12:34:19.000000000 +1100
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
+++ linux-work/arch/powerpc/kernel/vdso32/vdso32.lds.S	2008-12-17 12:34:19.000000000 +1100
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
+++ linux-work/arch/powerpc/kernel/vdso64/vdso64.lds.S	2008-12-17 12:34:19.000000000 +1100
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
+++ linux-work/arch/powerpc/kernel/vmlinux.lds.S	2008-12-17 12:34:19.000000000 +1100
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
Index: linux-work/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/ppc_mmu_32.c	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/mm/ppc_mmu_32.c	2008-12-17 12:34:19.000000000 +1100
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
--- linux-work.orig/arch/powerpc/kernel/head_32.S	2008-12-17 12:31:28.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_32.S	2008-12-17 12:34:19.000000000 +1100
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
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
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
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 	blr
 
 flush_tlbs:
Index: linux-work/arch/powerpc/kernel/swsusp_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/swsusp_32.S	2008-07-07 13:45:04.000000000 +1000
+++ linux-work/arch/powerpc/kernel/swsusp_32.S	2008-12-17 12:34:19.000000000 +1100
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
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 
 	/* Flush all TLBs */
 	lis	r4,0x1000
Index: linux-work/arch/powerpc/platforms/powermac/sleep.S
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/sleep.S	2008-07-07 13:45:04.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/sleep.S	2008-12-17 12:34:19.000000000 +1100
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
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 
 	/* Flush all TLBs */
 	lis	r4,0x1000
Index: linux-work/arch/powerpc/kernel/head_fsl_booke.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_fsl_booke.S	2008-12-08 15:40:33.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_fsl_booke.S	2008-12-17 12:34:19.000000000 +1100
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
