Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] minor POWER6 cputable cleanup
Date: Mon, 22 Jan 2007 13:21:26 +1100
Message-ID: <9201.1169432486@neuling.org>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Merge CPU_FTR_POWER6 and CPU_FTR_POWER6X definitions.
---
 include/asm-powerpc/cputable.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Paulus, I'm not sure if it makes sense to define a CPU_FTR_POWER6_BASE
then create POWER6 and POWER6X from this or, base POWER6X off POWER6 (as
I've done here).

Either way, this is for the 2.6.21 merge window.

Index: kernel/include/asm-powerpc/cputable.h
===================================================================
--- kernel.orig/include/asm-powerpc/cputable.h
+++ kernel/include/asm-powerpc/cputable.h
@@ -337,12 +337,7 @@ extern void do_feature_fixups(unsigned l
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR)
-#define CPU_FTRS_POWER6X (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
-	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE | \
-	    CPU_FTR_SPURR | CPU_FTR_REAL_LE | CPU_FTR_DSCR)
+#define CPU_FTRS_POWER6X (CPU_FTRS_POWER6 | CPU_FTR_CI_LARGE_PAGE)
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
