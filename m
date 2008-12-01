Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 01 Dec 2008 17:01:18 +1100
Subject: [PATCH] powerpc: Fix bogus cache flushing on all 40x and BookE
	processors
Message-Id: <20081201060152.00DCCDDDE3@ozlabs.org>
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

 arch/powerpc/include/asm/cputable.h |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/cputable.h	2008-12-01 16:55:53.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/cputable.h	2008-12-01 16:56:32.000000000 +1100
@@ -366,19 +366,20 @@ extern const char *powerpc_base_platform
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
+	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN \
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
