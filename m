Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Use new CPU feature bit to select 2.06 tlbie
In-reply-to: <1301986248.2549.141.camel@pasglop>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
	<1301984051-18413-5-git-send-email-benh@kernel.crashing.org>
	<22009.1301985041@neuling.org> <1301986248.2549.141.camel@pasglop>
Date: Thu, 07 Apr 2011 14:23:29 +1000
Message-ID: <19302.1302150209@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes MMU_FTR_TLBIE_206 as we can now use CPU_FTR_HVMODE_206.  It
also changes the logic to select which tlbie to use to be based on this
new CPU feature bit.

This also duplicates the ASM_FTR_IF/SET/CLR defines for CPU features
(copied from MMU features).

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Subject: Re: [PATCH 04/15] powerpc: Define CPU feature for Architected 2.06 HV mode
> > > +#define CPU_FTR_HVMODE_206		LONG_ASM_CONST(0x00000008000000
00)
> > 
> > FYI With this patch we could remove MMU_FTR_TLBIE_206.
> 
> We could... care to send a patch ? :-)

Sure... How about this?

Mikey

 arch/powerpc/include/asm/feature-fixups.h |   13 +++++++++++++
 arch/powerpc/include/asm/mmu.h            |    5 -----
 arch/powerpc/kernel/cputable.c            |    9 +++------
 arch/powerpc/mm/hash_native_64.c          |    8 ++++----
 4 files changed, 20 insertions(+), 15 deletions(-)

Index: clone1/arch/powerpc/include/asm/feature-fixups.h
===================================================================
--- clone1.orig/arch/powerpc/include/asm/feature-fixups.h
+++ clone1/arch/powerpc/include/asm/feature-fixups.h
@@ -146,6 +146,19 @@
 
 #ifndef __ASSEMBLY__
 
+#define ASM_FTR_IF(section_if, section_else, msk, val)	\
+	stringify_in_c(BEGIN_FTR_SECTION)			\
+	section_if "; "						\
+	stringify_in_c(FTR_SECTION_ELSE)			\
+	section_else "; "					\
+	stringify_in_c(ALT_FTR_SECTION_END((msk), (val)))
+
+#define ASM_FTR_IFSET(section_if, section_else, msk)	\
+	ASM_FTR_IF(section_if, section_else, (msk), (msk))
+
+#define ASM_FTR_IFCLR(section_if, section_else, msk)	\
+	ASM_FTR_IF(section_if, section_else, (msk), 0)
+
 #define ASM_MMU_FTR_IF(section_if, section_else, msk, val)	\
 	stringify_in_c(BEGIN_MMU_FTR_SECTION)			\
 	section_if "; "						\
Index: clone1/arch/powerpc/include/asm/mmu.h
===================================================================
--- clone1.orig/arch/powerpc/include/asm/mmu.h
+++ clone1/arch/powerpc/include/asm/mmu.h
@@ -56,11 +56,6 @@
  */
 #define MMU_FTR_NEED_DTLB_SW_LRU	ASM_CONST(0x00200000)
 
-/* This indicates that the processor uses the ISA 2.06 server tlbie
- * mnemonics
- */
-#define MMU_FTR_TLBIE_206		ASM_CONST(0x00400000)
-
 /* Enable use of TLB reservation.  Processor should support tlbsrx.
  * instruction and MAS0[WQ].
  */
Index: clone1/arch/powerpc/kernel/cputable.c
===================================================================
--- clone1.orig/arch/powerpc/kernel/cputable.c
+++ clone1/arch/powerpc/kernel/cputable.c
@@ -417,8 +417,7 @@
 		.cpu_name		= "POWER7 (architected)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
-		.mmu_features		= MMU_FTR_HPTE_TABLE |
-			MMU_FTR_TLBIE_206,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.oprofile_type		= PPC_OPROFILE_POWER4,
@@ -433,8 +432,7 @@
 		.cpu_name		= "POWER7 (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
-		.mmu_features		= MMU_FTR_HPTE_TABLE |
-			MMU_FTR_TLBIE_206,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -451,8 +449,7 @@
 		.cpu_name		= "POWER7+ (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
-		.mmu_features		= MMU_FTR_HPTE_TABLE |
-			MMU_FTR_TLBIE_206,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
Index: clone1/arch/powerpc/mm/hash_native_64.c
===================================================================
--- clone1.orig/arch/powerpc/mm/hash_native_64.c
+++ clone1/arch/powerpc/mm/hash_native_64.c
@@ -50,9 +50,9 @@
 	case MMU_PAGE_4K:
 		va &= ~0xffful;
 		va |= ssize << 8;
-		asm volatile(ASM_MMU_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0),
+		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0),
 					       %2)
-			     : : "r" (va), "r"(0), "i" (MMU_FTR_TLBIE_206)
+			     : : "r" (va), "r"(0), "i" (CPU_FTR_HVMODE_206)
 			     : "memory");
 		break;
 	default:
@@ -61,9 +61,9 @@
 		va |= penc << 12;
 		va |= ssize << 8;
 		va |= 1; /* L */
-		asm volatile(ASM_MMU_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0),
+		asm volatile(    ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0),
 					       %2)
-			     : : "r" (va), "r"(0), "i" (MMU_FTR_TLBIE_206)
+			     : : "r" (va), "r"(0), "i" (CPU_FTR_HVMODE_206)
 			     : "memory");
 		break;
 	}
