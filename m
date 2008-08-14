Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Subject: [RFC 2/2] powerpc: copy_4K_page tweaked for Cell - add CPU feature
Date: Thu, 14 Aug 2008 16:18:23 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808141618.23818.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a new CPU feature, CPU_FTR_CP_USE_DCBTZ, to be added to the CPUs that benefit
from having dcbt and dcbz instructions used in copy_4K_page(). So far Cell, PPC970
and Power4 benefit.

This way all the other 64bit powerpc chips will have the whole prefetching loop
nop'ed out.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/include/asm/cputable.h |    9 ++++++---
 arch/powerpc/lib/copypage_64.S      |    3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

Index: upstream/arch/powerpc/include/asm/cputable.h
===================================================================
--- upstream.orig/arch/powerpc/include/asm/cputable.h
+++ upstream/arch/powerpc/include/asm/cputable.h
@@ -192,6 +192,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
 #define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
 #define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
+#define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -387,10 +388,11 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_MMCRA | CPU_FTR_CTRL)
 #define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
-	    CPU_FTR_MMCRA)
+	    CPU_FTR_MMCRA | CPU_FTR_CP_USE_DCBTZ)
 #define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
-	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA)
+	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA | \
+	    CPU_FTR_CP_USE_DCBTZ)
 #define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -411,7 +413,8 @@ extern const char *powerpc_base_platform
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_CELL_TB_BUG)
+	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | \
+	    CPU_FTR_CELL_TB_BUG | CPU_FTR_CP_USE_DCBTZ)
 #define CPU_FTRS_PA6T (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
Index: upstream/arch/powerpc/lib/copypage_64.S
===================================================================
--- upstream.orig/arch/powerpc/lib/copypage_64.S
+++ upstream/arch/powerpc/lib/copypage_64.S
@@ -18,6 +18,7 @@ PPC64_CACHES:
 
 _GLOBAL(copy_4K_page)
 	li	r5,4096		/* 4K page size */
+BEGIN_FTR_SECTION
 	ld      r10,PPC64_CACHES@toc(r2)
 	lwz	r11,DCACHEL1LOGLINESIZE(r10)	/* log2 of cache line size */
 	lwz     r12,DCACHEL1LINESIZE(r10)	/* Get cache line size */
@@ -30,7 +31,7 @@ setup:
 	dcbz	r9,r3
 	add	r9,r9,r12
 	bdnz	setup
-
+END_FTR_SECTION_IFSET(CPU_FTR_CP_USE_DCBTZ)
 	addi	r3,r3,-8
 	srdi    r8,r5,7		/* page is copied in 128 byte strides */
 	addi	r8,r8,-1	/* one stride copied outside loop */
