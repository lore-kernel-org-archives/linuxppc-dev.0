Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A416BB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 15:08:39 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3E7EDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 15:08:38 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] powerpc/mm: Add MMU features for TLB reservation & Paired
	MAS registers
Date: Wed, 19 Aug 2009 00:08:29 -0500
Message-Id: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support for TLB reservation (or TLB Write Conditional) and Paired MAS
registers are optional for a processor implementation so we handle
them via MMU feature sections.

We currently only used paired MAS registers to access the full RPN + perm
bits that are kept in MAS7||MAS3.  We assume that if an implementation has
hardware page table at this time it also implements in TLB reservations.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu.h |    9 +++++++++
 arch/powerpc/mm/tlb_low_64e.S  |   36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 2fcfefc..7ffbb65 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -58,6 +58,15 @@
  */
 #define MMU_FTR_TLBIE_206		ASM_CONST(0x00400000)
 
+/* Enable use of TLB reservation.  Processor should support tlbsrx.
+ * instruction and MAS0[WQ].
+ */
+#define MMU_FTR_USE_TLBRSRV		ASM_CONST(0x00800000)
+
+/* Use paired MAS registers (MAS7||MAS3, etc.)
+ */
+#define MMU_FTR_USE_PAIRED_MAS		ASM_CONST(0x01000000)
+
 #ifndef __ASSEMBLY__
 #include <asm/cputable.h>
 
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 10d524d..5b8e274 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -189,12 +189,16 @@ normal_tlb_miss:
 	clrrdi	r14,r14,3
 	or	r10,r15,r14
 
+BEGIN_MMU_FTR_SECTION
 	/* Set the TLB reservation and seach for existing entry. Then load
 	 * the entry.
 	 */
 	PPC_TLBSRX_DOT(0,r16)
 	ld	r14,0(r10)
 	beq	normal_tlb_miss_done
+MMU_FTR_SECTION_ELSE
+	ld	r14,0(r10)
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
 
 finish_normal_tlb_miss:
 	/* Check if required permissions are met */
@@ -241,7 +245,14 @@ finish_normal_tlb_miss:
 	bne	1f
 	li	r11,MAS3_SW|MAS3_UW
 	andc	r15,r15,r11
-1:	mtspr	SPRN_MAS7_MAS3,r15
+1:
+BEGIN_MMU_FTR_SECTION
+	srdi	r16,r15,32
+	mtspr	SPRN_MAS3,r15
+	mtspr	SPRN_MAS7,r16
+MMU_FTR_SECTION_ELSE
+	mtspr	SPRN_MAS7_MAS3,r15
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_PAIRED_MAS)
 
 	tlbwe
 
@@ -311,11 +322,13 @@ virt_page_table_tlb_miss:
 	rlwinm	r10,r10,0,16,1			/* Clear TID */
 	mtspr	SPRN_MAS1,r10
 1:
+BEGIN_MMU_FTR_SECTION
 	/* Search if we already have a TLB entry for that virtual address, and
 	 * if we do, bail out.
 	 */
 	PPC_TLBSRX_DOT(0,r16)
 	beq	virt_page_table_tlb_miss_done
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_TLBRSRV)
 
 	/* Now, we need to walk the page tables. First check if we are in
 	 * range.
@@ -367,7 +380,14 @@ virt_page_table_tlb_miss:
 	 */
 	clrldi	r11,r15,4		/* remove region ID from RPN */
 	ori	r10,r11,1		/* Or-in SR */
+
+BEGIN_MMU_FTR_SECTION
+	srdi	r16,r10,32
+	mtspr	SPRN_MAS3,r10
+	mtspr	SPRN_MAS7,r16
+MMU_FTR_SECTION_ELSE
 	mtspr	SPRN_MAS7_MAS3,r10
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_PAIRED_MAS)
 
 	tlbwe
 
@@ -618,7 +638,14 @@ htw_tlb_miss:
 #else
 	ori	r10,r15,(BOOK3E_PAGESZ_4K << MAS3_SPSIZE_SHIFT)
 #endif
+
+BEGIN_MMU_FTR_SECTION
+	srdi	r16,r10,32
+	mtspr	SPRN_MAS3,r10
+	mtspr	SPRN_MAS7,r16
+MMU_FTR_SECTION_ELSE
 	mtspr	SPRN_MAS7_MAS3,r10
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_PAIRED_MAS)
 
 	tlbwe
 
@@ -700,7 +727,14 @@ tlb_load_linear:
 	clrrdi	r10,r16,30		/* 1G page index */
 	clrldi	r10,r10,4		/* clear region bits */
 	ori	r10,r10,MAS3_SR|MAS3_SW|MAS3_SX
+
+BEGIN_MMU_FTR_SECTION
+	srdi	r16,r10,32
+	mtspr	SPRN_MAS3,r10
+	mtspr	SPRN_MAS7,r16
+MMU_FTR_SECTION_ELSE
 	mtspr	SPRN_MAS7_MAS3,r10
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_PAIRED_MAS)
 
 	tlbwe
 
-- 
1.6.0.6
