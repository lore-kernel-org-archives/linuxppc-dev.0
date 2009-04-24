Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56CC9DE0CD
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 16:24:32 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 24 Apr 2009 16:24:31 +1000
Subject: [PATCH 2/2] powerpc: Add 2.06 tlbie mnemonics
In-Reply-To: <1240554271.668632.486641775152.qpush@pale>
Message-Id: <20090424062431.D3803120E7@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Milton Miller <miltonm@bga.com>

This adds the PowerPC 2.06 tlbie mnemonics and keeps backwards
compatibilty for CPUs before 2.06.

Only useful for bare metal systems.  

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
As they say, better out than in....
---

 arch/powerpc/include/asm/cputable.h |    3 ++-
 arch/powerpc/mm/hash_native_64.c    |   13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/include/asm/cputable.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/cputable.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/cputable.h
@@ -195,6 +195,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
 #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
 #define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
+#define CPU_FTR_TLBIE_206		LONG_ASM_CONST(0x0100000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -409,7 +410,7 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR | CPU_FTR_SAO)
+	    CPU_FTR_DSCR | CPU_FTR_SAO | CPU_FTR_TLBIE_206)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
Index: linux-2.6-ozlabs/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/hash_native_64.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/hash_native_64.c
@@ -38,6 +38,9 @@
 
 static DEFINE_SPINLOCK(native_tlbie_lock);
 
+#define TLBIE(lp,a) \
+	stringify_in_c(.long 0x7c000264 | ((a) << 11) | ((lp) << 21))
+
 static inline void __tlbie(unsigned long va, int psize, int ssize)
 {
 	unsigned int penc;
@@ -49,14 +52,19 @@ static inline void __tlbie(unsigned long
 	case MMU_PAGE_4K:
 		va &= ~0xffful;
 		va |= ssize << 8;
-		asm volatile("tlbie %0,0" : : "r" (va) : "memory");
+ 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", TLBIE(%1,%0), %2)
+			     : : "r" (va), "r"(0), "i" (CPU_FTR_TLBIE_206)
+			     : "memory");
 		break;
 	default:
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
-		asm volatile("tlbie %0,1" : : "r" (va) : "memory");
+		va |= 1; /* L */
+ 		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", TLBIE(%1,%0), %2)
+			     : : "r" (va), "r"(0), "i" (CPU_FTR_TLBIE_206)
+			     : "memory");
 		break;
 	}
 }
@@ -80,6 +88,7 @@ static inline void __tlbiel(unsigned lon
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
+		va |= 1; /* L */
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
 			     : : "r"(va) : "memory");
 		break;
