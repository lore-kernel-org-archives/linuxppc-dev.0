Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: add new CPU feature: CPU_FTR_CP_USE_DCBTZ
Date: Fri, 22 Aug 2008 14:36:19 +1000
References: <200808141617.32033.markn@au1.ibm.com>
In-Reply-To: <200808141617.32033.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808221436.19517.markn@au1.ibm.com>
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a new CPU feature bit, CPU_FTR_CP_USE_DCBTZ, to be added to the
64bit powerpc chips that benefit from having dcbt and dcbz
instructions used in their memory copy routines.

This will be used in a subsequent patch that updates copy_4K_page().
The new bit is added to Cell, PPC970 and Power4 because they show
better performance with the new copy_4K_page() when dcbt and dcbz
instructions are used.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/include/asm/cputable.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

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
