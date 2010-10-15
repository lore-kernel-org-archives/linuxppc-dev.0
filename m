Return-Path: <shaggy@linux.vnet.ibm.com>
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH v3] 476: Set CCR2[DSTI] to prevent isync from flushing
	shadow TLB
Date: Fri, 15 Oct 2010 12:33:36 -0500
Message-Id: <1287164016-5184-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 Josh, don't pick this up yet.  It needs a bit more testing, but I think I
 got it right this time.

When the DSTI (Disable Shadow TLB Invalidate) bit is set in the CCR2
register, the isync command does not flush the shadow TLB (iTLB & dTLB).

However, since the shadow TLB does not contain context information, we
want the shadow TLB flushed in situations where we are switching context.
In those situations, we explicitly clear the DSTI bit before performing
isync, and set it again afterward.  We also need to do the same when we
perform isync after explicitly flushing the TLB.

The 476 requires an isync following a write to certain SPRs in order for
their changes to be effective.  Such is the case with the DSTI bit, so
the first isync may not be affected by an immediate change to CCR2, but
a second isync instruction will repect the setting.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg_booke.h  |    4 ++++
 arch/powerpc/kernel/head_44x.S        |   28 ++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb_nohash_low.S      |   24 +++++++++++++++++++++++-
 arch/powerpc/platforms/44x/misc_44x.S |   28 ++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 667a498..a7ecbfe 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -120,6 +120,7 @@
 #define SPRN_TLB3CFG	0x2B3	/* TLB 3 Config Register */
 #define SPRN_EPR	0x2BE	/* External Proxy Register */
 #define SPRN_CCR1	0x378	/* Core Configuration Register 1 */
+#define SPRN_CCR2_476	0x379	/* Core Configuration Register 2 (476)*/
 #define SPRN_ZPR	0x3B0	/* Zone Protection Register (40x) */
 #define SPRN_MAS7	0x3B0	/* MMU Assist Register 7 */
 #define SPRN_MMUCR	0x3B2	/* MMU Control Register */
@@ -188,6 +189,9 @@
 #define	CCR1_DPC	0x00000100 /* Disable L1 I-Cache/D-Cache parity checking */
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
+/* Bit definitions for CCR2. */
+#define CCR2_476_DSTI	0x08000000 /* Disable Shadow TLB Invalidate */
+
 /* Bit definitions for the MCSR. */
 #define MCSR_MCS	0x80000000 /* Machine Check Summary */
 #define MCSR_IB		0x40000000 /* Instruction PLB Error */
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 562305b..df1ef80 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -38,6 +38,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/synch.h>
+#include <asm/bug.h>
 #include "head_booke.h"
 
 
@@ -703,8 +704,29 @@ _GLOBAL(set_context)
 	stw	r4, 0x4(r5)
 #endif
 	mtspr	SPRN_PID,r3
+BEGIN_MMU_FTR_SECTION
+	b	1f
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	isync			/* Force context change */
 	blr
+1:
+#ifdef CONFIG_PPC_47x
+	mfspr	r10,SPRN_CCR2_476
+	rlwinm	r11,r10,0,~CCR2_476_DSTI
+	mtspr	SPRN_CCR2_476,r11
+	/*
+	 * The first isync may not respect the change to CCR2, but its
+	 * completion will ensure that the second isync does.
+	 */
+	isync
+	isync			/* Force context change */
+	mtspr	SPRN_CCR2_476,r10
+	isync
+#else /* CONFIG_PPC_47x */
+2:	trap
+	EMIT_BUG_ENTRY 2b,__FILE__,__LINE__,0;
+#endif /* CONFIG_PPC_47x */
+	blr
 
 /*
  * Init CPU state. This is called at boot time or for secondary CPUs
@@ -1083,6 +1105,12 @@ clear_utlb_entry:
 	isync
 #endif /* CONFIG_PPC_EARLY_DEBUG_44x */
 
+	mfspr   r3,SPRN_CCR2_476
+	/* With CCR2(DSTI) set, isync does not invalidate the shadow TLB */
+	oris	r3,r3,CCR2_476_DSTI@h
+	mtspr   SPRN_CCR2_476,r3
+	isync
+
 	/* Establish the interrupt vector offsets */
 	SET_IVOR(0,  CriticalInput);
 	SET_IVOR(1,  MachineCheckA);
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index b9d9fed..8e318ed 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -112,6 +112,16 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	clrrwi	r4,r3,12	/* get an EPN for the hashing with V = 0 */
 	ori	r4,r4,PPC47x_TLBE_SIZE
 	tlbwe   r4,r7,0		/* write it */
+	mfspr	r8,SPRN_CCR2_476
+	rlwinm	r9,r8,0,~CCR2_476_DSTI
+	mtspr	SPRN_CCR2_476,r9
+	/*
+	 * The first isync may not respect the change to CCR2, but its
+	 * completion will ensure that the second isync does.
+	 */
+	isync
+	isync
+	mtspr	SPRN_CCR2_476,r8
 	isync
 	wrtee	r10
 	blr
@@ -180,7 +190,13 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	lwz	r8,0(r10)	/* Load boltmap entry */
 	addi	r10,r10,4	/* Next word */
 	b	1b		/* Then loop */
-1:	isync			/* Sync shadows */
+1:	mfspr	r9,SPRN_CCR2_476
+	rlwinm	r10,r9,0,~CCR2_476_DSTI
+	mtspr	SPRN_CCR2_476,r10
+	isync
+	isync			/* Sync shadows */
+	mtspr	SPRN_CCR2_476,r9
+	isync
 	wrtee	r11
 #else /* CONFIG_PPC_47x */
 1:	trap
@@ -203,6 +219,12 @@ _GLOBAL(_tlbivax_bcast)
 	isync
 /*	tlbivax	0,r3 - use .long to avoid binutils deps */
 	.long 0x7c000624 | (r3 << 11)
+	mfspr	r8,SPRN_CCR2_476
+	rlwinm	r9,r8,0,~CCR2_476_DSTI
+	mtspr	SPRN_CCR2_476,r9
+	isync
+	isync
+	mtspr	SPRN_CCR2_476,r8
 	isync
 	eieio
 	tlbsync
diff --git a/arch/powerpc/platforms/44x/misc_44x.S b/arch/powerpc/platforms/44x/misc_44x.S
index dc12b80..2422dd3 100644
--- a/arch/powerpc/platforms/44x/misc_44x.S
+++ b/arch/powerpc/platforms/44x/misc_44x.S
@@ -9,15 +9,40 @@
  *
  */
 
+#include <asm/mmu.h>
 #include <asm/reg.h>
 #include <asm/ppc_asm.h>
 
 	.text
 
+#ifdef CONFIG_PPC_47x
+
+#define LOAD_CLEAR_CCR2_DSTI(REG1, REG2)	\
+BEGIN_MMU_FTR_SECTION				\
+	mfspr REG1,SPRN_CCR2_476;		\
+	rlwinm	REG2,REG1,0,~CCR2_476_DSTI;	\
+	mtspr	SPRN_CCR2_476,REG2;		\
+	isync;					\
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
+
+#define RESTORE_CCR2_DSTI(REG)			\
+BEGIN_MMU_FTR_SECTION				\
+	mtspr	SPRN_CCR2_476,REG;		\
+	isync;					\
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
+
+#else	/* CONFIG_PPC_47x */
+
+#define LOAD_CLEAR_CCR2_DSTI(REG1, REG2)
+#define RESTORE_CCR2_DSTI(REG)
+
+#endif	/* CONFIG_PPC_47x */
+
 /*
  * Do an IO access in AS1
  */
 _GLOBAL(as1_readb)
+	LOAD_CLEAR_CCR2_DSTI(r8, r9)
 	mfmsr	r7
 	ori	r0,r7,MSR_DS
 	sync
@@ -29,9 +54,11 @@ _GLOBAL(as1_readb)
 	mtmsr	r7
 	sync
 	isync
+	RESTORE_CCR2_DSTI(r8)
 	blr
 
 _GLOBAL(as1_writeb)
+	LOAD_CLEAR_CCR2_DSTI(r8, r9)
 	mfmsr	r7
 	ori	r0,r7,MSR_DS
 	sync
@@ -43,4 +70,5 @@ _GLOBAL(as1_writeb)
 	mtmsr	r7
 	sync
 	isync
+	RESTORE_CCR2_DSTI(r8)
 	blr
-- 
1.7.2.2
