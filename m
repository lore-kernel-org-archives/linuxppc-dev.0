Return-Path: <dgibson@ozlabs.org>
Date: Tue, 29 May 2007 14:38:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Merge CPU features pertaining to icache coherency
Message-ID: <20070529043827.GB30266@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the powerpc kernel has a 64-bit only feature,
COHERENT_ICACHE used for those CPUS which maintain icache/dcache
coherency in hardware (POWER5, essentially).  It also has a feature,
SPLIT_ID_CACHE, which is used on CPUs which have separate i and
d-caches, which is to say everything except 601 and Freescale E200.

In nearly all the places we check the SPLIT_ID_CACHE, what we actually
care about is whether the i and d-caches are coherent (which they will
be, trivially, if they're the same cache).

This patch tries to clarify the situation a little.  The
COHERENT_ICACHE feature becomes availble on 32-bit and is set for all
CPUs where i and d-cache are effectively coherent, whether this is due
to special logic (POWER5) or because they're unified.  We check this,
instead of SPLIT_ID_CACHE nearly everywhere.

The SPLIT_ID_CACHE feature itself is replaced by a UNIFIED_ID_CACHE
feature with reversed sense, set only on 601 and Freescale E200.  In
the two places (one Freescale BookE specific) where we really care
whether it's a unified cache, not whether they're coherent, we check
this feature.  The CPUs with unified cache are so few, we could
consider replacing this feature bit with explicit checks against the
PVR.

This patch will make unifying the 32-bit and 64-bit cache flush code a
little more straightforward.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

 arch/powerpc/kernel/cputable.c |    3 -
 arch/powerpc/kernel/misc_32.S  |   12 ++---
 arch/powerpc/kernel/misc_64.S  |    4 -
 arch/powerpc/kernel/setup_32.c |   12 ++---
 arch/ppc/kernel/misc.S         |   12 ++---
 arch/ppc/kernel/setup.c        |    2 
 include/asm-powerpc/cputable.h |   88 ++++++++++++++++++++---------------------
 7 files changed, 66 insertions(+), 67 deletions(-)

Index: working-2.6/include/asm-powerpc/cputable.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/cputable.h	2007-05-21 12:47:17.000000000 +1000
+++ working-2.6/include/asm-powerpc/cputable.h	2007-05-29 14:34:24.000000000 +1000
@@ -111,7 +111,7 @@ extern void do_feature_fixups(unsigned l
 /* CPU kernel features */
 
 /* Retain the 32b definitions all use bottom half of word */
-#define CPU_FTR_SPLIT_ID_CACHE		ASM_CONST(0x0000000000000001)
+#define CPU_FTR_COHERENT_ICACHE		ASM_CONST(0x0000000000000001)
 #define CPU_FTR_L2CR			ASM_CONST(0x0000000000000002)
 #define CPU_FTR_SPEC7450		ASM_CONST(0x0000000000000004)
 #define CPU_FTR_ALTIVEC			ASM_CONST(0x0000000000000008)
@@ -135,6 +135,7 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTR_PPC_LE			ASM_CONST(0x0000000000200000)
 #define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
 #define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x0000000000800000)
+#define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x0000000001000000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
@@ -154,7 +155,6 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000004000000000)
 #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000008000000000)
 #define CPU_FTR_SMT			LONG_ASM_CONST(0x0000010000000000)
-#define CPU_FTR_COHERENT_ICACHE		LONG_ASM_CONST(0x0000020000000000)
 #define CPU_FTR_LOCKLESS_TLBIE		LONG_ASM_CONST(0x0000040000000000)
 #define CPU_FTR_CI_LARGE_PAGE		LONG_ASM_CONST(0x0000100000000000)
 #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
@@ -206,164 +206,163 @@ extern void do_feature_fixups(unsigned l
 		     !defined(CONFIG_POWER3) && !defined(CONFIG_POWER4) && \
 		     !defined(CONFIG_BOOKE))
 
-#define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | CPU_FTR_HPTE_TABLE)
-#define CPU_FTRS_603	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | CPU_FTR_HPTE_TABLE | \
+	CPU_FTR_UNIFIED_ID_CACHE)
+#define CPU_FTRS_603	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
-#define CPU_FTRS_604	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_604	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE | \
 	    CPU_FTR_PPC_LE)
-#define CPU_FTRS_740_NOTAU	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_740_NOTAU	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
-#define CPU_FTRS_740	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_740	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_PPC_LE)
-#define CPU_FTRS_750	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_750	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_PPC_LE)
-#define CPU_FTRS_750CL	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_750CL	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
-#define CPU_FTRS_750FX1	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_750FX1	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM | CPU_FTR_PPC_LE)
-#define CPU_FTRS_750FX2	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_750FX2	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_NO_DPM | CPU_FTR_PPC_LE)
-#define CPU_FTRS_750FX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_750FX	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
-#define CPU_FTRS_750GX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_750GX	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7400_NOTAU	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7400_NOTAU	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7400	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7400	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7450_20	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7450_20	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7450_21	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7450_21	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7450_23	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7450_23	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7455_1	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7455_1	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7455_20	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7455_20	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7455	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7455	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7447_10	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7447_10	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7447	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7447	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7447A	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7447A	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
-#define CPU_FTRS_7448	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_7448	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_PPC_LE)
-#define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_82XX	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
-#define CPU_FTRS_G2_LE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
+#define CPU_FTRS_G2_LE	(CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS)
-#define CPU_FTRS_E300	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
+#define CPU_FTRS_E300	(CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_COMMON)
-#define CPU_FTRS_E300C2	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
+#define CPU_FTRS_E300C2	(CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE)
-#define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+#define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE)
-#define CPU_FTRS_8XX	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB)
-#define CPU_FTRS_40X	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_44X	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_E500	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_E500_2	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
+#define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
+#define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
+#define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN \
+	    CPU_FTR_UNIFIED_ID_CACHE)
+#define CPU_FTRS_E500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
+#define CPU_FTRS_E500_2	(CPU_FTR_USE_TB | \
 	    CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
-#define CPU_FTRS_POWER3	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_POWER3	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | CPU_FTR_PPC_LE)
-#define CPU_FTRS_RS64	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_RS64	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | \
 	    CPU_FTR_MMCRA | CPU_FTR_CTRL)
-#define CPU_FTRS_POWER4	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA)
-#define CPU_FTRS_PPC970	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA)
-#define CPU_FTRS_POWER5	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR)
-#define CPU_FTRS_POWER6 (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR)
-#define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_CELL	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_CELL_TB_BUG)
-#define CPU_FTRS_PA6T (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_PA6T (CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
 	    CPU_FTR_PURR | CPU_FTR_REAL_LE)
-#define CPU_FTRS_COMPATIBLE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+#define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 
 #ifdef __powerpc64__
Index: working-2.6/arch/powerpc/kernel/misc_32.S
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/misc_32.S	2007-04-19 10:59:55.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/misc_32.S	2007-05-29 14:32:33.000000000 +1000
@@ -392,7 +392,7 @@ BEGIN_FTR_SECTION
 	mtspr   SPRN_L1CSR0,r3
 	isync
 	blr
-END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
+END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
 	mfspr	r3,SPRN_L1CSR1
 	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
 	mtspr	SPRN_L1CSR1,r3
@@ -419,7 +419,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_C
 _GLOBAL(__flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
-END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
+END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	li	r5,L1_CACHE_BYTES-1
 	andc	r3,r3,r5
 	subf	r4,r3,r4
@@ -514,8 +514,8 @@ _GLOBAL(invalidate_dcache_range)
  */
 _GLOBAL(__flush_dcache_icache)
 BEGIN_FTR_SECTION
-	blr					/* for 601, do nothing */
-END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
+	blr
+END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	rlwinm	r3,r3,0,0,19			/* Get page base address */
 	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
 	mtctr	r4
@@ -543,7 +543,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_C
 _GLOBAL(__flush_dcache_icache_phys)
 BEGIN_FTR_SECTION
 	blr					/* for 601, do nothing */
-END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
+END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	mfmsr	r10
 	rlwinm	r0,r10,0,28,26			/* clear DR */
 	mtmsr	r0
Index: working-2.6/arch/powerpc/kernel/setup_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/setup_32.c	2007-04-26 13:57:24.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/setup_32.c	2007-05-29 14:32:33.000000000 +1000
@@ -262,13 +262,11 @@ void __init setup_arch(char **cmdline_p)
 	 * Systems with OF can look in the properties on the cpu node(s)
 	 * for a possibly more accurate value.
 	 */
-	if (cpu_has_feature(CPU_FTR_SPLIT_ID_CACHE)) {
-		dcache_bsize = cur_cpu_spec->dcache_bsize;
-		icache_bsize = cur_cpu_spec->icache_bsize;
-		ucache_bsize = 0;
-	} else
-		ucache_bsize = dcache_bsize = icache_bsize
-			= cur_cpu_spec->dcache_bsize;
+	dcache_bsize = cur_cpu_spec->dcache_bsize;
+	icache_bsize = cur_cpu_spec->icache_bsize;
+	ucache_bsize = 0;
+	if (cpu_has_feature(CPU_FTR_UNIFIED_ID_CACHE))
+		ucache_bsize = icache_bsize = dcache_bsize;
 
 	/* reboot on panic */
 	panic_timeout = 180;
Index: working-2.6/arch/ppc/kernel/misc.S
===================================================================
--- working-2.6.orig/arch/ppc/kernel/misc.S	2007-01-24 12:01:17.000000000 +1100
+++ working-2.6/arch/ppc/kernel/misc.S	2007-05-29 14:32:33.000000000 +1000
@@ -328,7 +328,7 @@ BEGIN_FTR_SECTION
 	mtspr   SPRN_L1CSR0,r3
 	isync
 	blr
-END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
+END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
 	mfspr	r3,SPRN_L1CSR1
 	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
 	mtspr	SPRN_L1CSR1,r3
@@ -355,7 +355,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_C
 _GLOBAL(__flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
-END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
+END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	li	r5,L1_CACHE_BYTES-1
 	andc	r3,r3,r5
 	subf	r4,r3,r4
@@ -472,7 +472,7 @@ _GLOBAL(flush_dcache_all)
 _GLOBAL(__flush_dcache_icache)
 BEGIN_FTR_SECTION
 	blr					/* for 601, do nothing */
-END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
+END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	rlwinm	r3,r3,0,0,19			/* Get page base address */
 	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
 	mtctr	r4
@@ -500,7 +500,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_C
 _GLOBAL(__flush_dcache_icache_phys)
 BEGIN_FTR_SECTION
 	blr					/* for 601, do nothing */
-END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
+END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	mfmsr	r10
 	rlwinm	r0,r10,0,28,26			/* clear DR */
 	mtmsr	r0
Index: working-2.6/arch/ppc/kernel/setup.c
===================================================================
--- working-2.6.orig/arch/ppc/kernel/setup.c	2007-02-14 10:58:22.000000000 +1100
+++ working-2.6/arch/ppc/kernel/setup.c	2007-05-29 14:32:33.000000000 +1000
@@ -526,7 +526,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Systems with OF can look in the properties on the cpu node(s)
 	 * for a possibly more accurate value.
 	 */
-	if (cpu_has_feature(CPU_FTR_SPLIT_ID_CACHE)) {
+	if (! cpu_has_feature(CPU_FTR_UNIFIED_ID_CACHE)) {
 		dcache_bsize = cur_cpu_spec->dcache_bsize;
 		icache_bsize = cur_cpu_spec->icache_bsize;
 		ucache_bsize = 0;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
