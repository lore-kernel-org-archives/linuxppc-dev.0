Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33C32DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 16:58:02 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 30 Apr 2009 16:58:01 +1000
Subject: [PATCH 4/4] powerpc: Add 2.06 tlbie mnemonics
In-Reply-To: <1241074681.528764.881549582503.qpush@pale>
Message-Id: <20090430065801.BD8191222A@localhost.localdomain>
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

 arch/powerpc/include/asm/mmu.h        |    5 +++++
 arch/powerpc/include/asm/ppc-opcode.h |    4 ++++
 arch/powerpc/kernel/cputable.c        |    6 ++++--
 arch/powerpc/mm/hash_native_64.c      |   13 +++++++++++--
 4 files changed, 24 insertions(+), 4 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/include/asm/mmu.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/mmu.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/mmu.h
@@ -52,6 +52,11 @@
  */
 #define MMU_FTR_NEED_DTLB_SW_LRU	ASM_CONST(0x00200000)
 
+/* This indicates that the processor uses the ISA 2.06 server tlbie
+ * mnemonics
+ */
+#define MMU_FTR_TLBIE_206		ASM_CONST(0x00400000)
+
 #ifndef __ASSEMBLY__
 #include <asm/cputable.h>
 
Index: linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
@@ -45,12 +45,14 @@
 #define PPC_INST_STSWI			0x7c0005aa
 #define PPC_INST_STSWX			0x7c00052a
 #define PPC_INST_STXVD2X		0x7c000798
+#define PPC_INST_TLBIE			0x7c000264
 #define PPC_INST_TLBILX			0x7c000024
 #define PPC_INST_WAIT			0x7c00007c
 
 /* macros to insert fields into opcodes */
 #define __PPC_RA(a)	(((a) & 0x1f) << 16)
 #define __PPC_RB(b)	(((b) & 0x1f) << 11)
+#define __PPC_RS(s)	(((s) & 0x1f) << 21)
 #define __PPC_XS(s)	((((s) & 0x1f) << 21) | (((s) & 0x20) >> 5))
 #define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
 #define __PPC_WC(w)	(((w) & 0x3) << 21)
@@ -72,6 +74,8 @@
 #define PPC_TLBILX_VA(a, b)	PPC_TLBILX(3, a, b)
 #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
 					__PPC_WC(w))
+#define PPC_TLBIE(lp,a) 	stringify_in_c(.long PPC_INST_TLBIE | \
+					       __PPC_RB(a) | __PPC_RS(lp))
 
 /*
  * Define what the VSX XX1 form instructions will look like, then add
Index: linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
@@ -425,7 +425,8 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER7 (architected)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE |
+			MMU_FTR_TLBIE_206,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
@@ -438,7 +439,8 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_name		= "POWER7 (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE |
+			MMU_FTR_TLBIE_206,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
Index: linux-2.6-ozlabs/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/hash_native_64.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/hash_native_64.c
@@ -27,6 +27,7 @@
 #include <asm/cputable.h>
 #include <asm/udbg.h>
 #include <asm/kexec.h>
+#include <asm/ppc-opcode.h>
 
 #ifdef DEBUG_LOW
 #define DBG_LOW(fmt...) udbg_printf(fmt)
@@ -49,14 +50,21 @@ static inline void __tlbie(unsigned long
 	case MMU_PAGE_4K:
 		va &= ~0xffful;
 		va |= ssize << 8;
-		asm volatile("tlbie %0,0" : : "r" (va) : "memory");
+ 		asm volatile(ASM_MMU_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0),
+					       %2)
+			     : : "r" (va), "r"(0), "i" (MMU_FTR_TLBIE_206)
+			     : "memory");
 		break;
 	default:
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
-		asm volatile("tlbie %0,1" : : "r" (va) : "memory");
+		va |= 1; /* L */
+ 		asm volatile(ASM_MMU_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0),
+					       %2)
+			     : : "r" (va), "r"(0), "i" (MMU_FTR_TLBIE_206)
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
