Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 08 Dec 2008 16:39:52 +1100
Subject: [PATCH 1/9] powerpc: Fix bogus cache flushing on all 40x and BookE
	processors v2
In-Reply-To: <1228714789.103940.266501677728.qpush@grosgo>
Message-Id: <20081208054038.20368DDE1F@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We were missing the CPU_FTR_NOEXECUTE bit in our cputable for all
these processors. The result is that update_mmu_cache() would flush
the cache for all pages mapped to userspace which is totally
unnecessary on those processors since we already handle flushing
on execute in the page fault path.

This should provide a nice speed up ;-)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This one fixes the E500 definition and uses a bit that works
for 32-bit processors

 arch/powerpc/include/asm/cputable.h |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/cputable.h	2008-12-03 13:32:53.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/cputable.h	2008-12-08 15:42:13.000000000 +1100
@@ -163,6 +163,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
 #define CPU_FTR_NEED_PAIRED_STWCX	ASM_CONST(0x0000000004000000)
 #define CPU_FTR_LWSYNC			ASM_CONST(0x0000000008000000)
+#define CPU_FTR_NOEXECUTE		ASM_CONST(0x0000000010000000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
@@ -177,7 +178,6 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_SLB			LONG_ASM_CONST(0x0000000100000000)
 #define CPU_FTR_16M_PAGE		LONG_ASM_CONST(0x0000000200000000)
 #define CPU_FTR_TLBIEL			LONG_ASM_CONST(0x0000000400000000)
-#define CPU_FTR_NOEXECUTE		LONG_ASM_CONST(0x0000000800000000)
 #define CPU_FTR_IABR			LONG_ASM_CONST(0x0000002000000000)
 #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000004000000000)
 #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000008000000000)
@@ -367,19 +367,20 @@ extern const char *powerpc_base_platform
 #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | \
 	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE)
 #define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
-#define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
+#define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
+#define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
-	    CPU_FTR_UNIFIED_ID_CACHE)
+	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
-	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN)
+	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
+	    CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500_2	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | \
-	    CPU_FTR_NODSISRALIGN)
+	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500MC	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN | \
-	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC)
+	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
