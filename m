Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 14 Jun 2012 16:15:54 +1000
Subject: [PATCH 18/18] powerpc: enforce usage of RA 0-R31 where possible
In-Reply-To: <1339654536.159274.140684871779.qpush@ale>
Message-Id: <20120614061554.92249D42BEA@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some macros use RA where when RA=R0 the values is 0, so make this
the enforced mnemonic in the macro.

Idea suggested by Andreas Schwab.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |   14 +++++++-------
 arch/powerpc/kernel/cpu_setup_a2.S    |    2 +-
 arch/powerpc/kernel/exceptions-64e.S  |    8 ++++----
 arch/powerpc/mm/tlb_low_64e.S         |   10 +++++-----
 arch/powerpc/mm/tlb_nohash_low.S      |   16 ++++++++--------
 5 files changed, 25 insertions(+), 25 deletions(-)

Index: powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
@@ -165,7 +165,7 @@
 #define PPC_RFDI		stringify_in_c(.long PPC_INST_RFDI)
 #define PPC_RFMCI		stringify_in_c(.long PPC_INST_RFMCI)
 #define PPC_TLBILX(t, a, b)	stringify_in_c(.long PPC_INST_TLBILX | \
-					__PPC_T_TLB(t) | __PPC_RA(a) | __PPC_RB(b))
+					__PPC_T_TLB(t) | __PPC_RA0(a) | __PPC_RB(b))
 #define PPC_TLBILX_ALL(a, b)	PPC_TLBILX(0, a, b)
 #define PPC_TLBILX_PID(a, b)	PPC_TLBILX(1, a, b)
 #define PPC_TLBILX_VA(a, b)	PPC_TLBILX(3, a, b)
@@ -174,23 +174,23 @@
 #define PPC_TLBIE(lp,a) 	stringify_in_c(.long PPC_INST_TLBIE | \
 					       ___PPC_RB(a) | ___PPC_RS(lp))
 #define PPC_TLBSRX_DOT(a,b)	stringify_in_c(.long PPC_INST_TLBSRX_DOT | \
-					__PPC_RA(a) | __PPC_RB(b))
+					__PPC_RA0(a) | __PPC_RB(b))
 #define PPC_TLBIVAX(a,b)	stringify_in_c(.long PPC_INST_TLBIVAX | \
-					__PPC_RA(a) | __PPC_RB(b))
+					__PPC_RA0(a) | __PPC_RB(b))
 
 #define PPC_ERATWE(s, a, w)	stringify_in_c(.long PPC_INST_ERATWE | \
 					__PPC_RS(s) | __PPC_RA(a) | __PPC_WS(w))
 #define PPC_ERATRE(s, a, w)	stringify_in_c(.long PPC_INST_ERATRE | \
 					__PPC_RS(s) | __PPC_RA(a) | __PPC_WS(w))
 #define PPC_ERATILX(t, a, b)	stringify_in_c(.long PPC_INST_ERATILX | \
-					__PPC_T_TLB(t) | __PPC_RA(a) | \
+					__PPC_T_TLB(t) | __PPC_RA0(a) | \
 					__PPC_RB(b))
 #define PPC_ERATIVAX(s, a, b)	stringify_in_c(.long PPC_INST_ERATIVAX | \
-					__PPC_RS(s) | __PPC_RA(a) | __PPC_RB(b))
+					__PPC_RS(s) | __PPC_RA0(a) | __PPC_RB(b))
 #define PPC_ERATSX(t, a, w)	stringify_in_c(.long PPC_INST_ERATSX | \
-					__PPC_RS(t) | __PPC_RA(a) | __PPC_RB(b))
+					__PPC_RS(t) | __PPC_RA0(a) | __PPC_RB(b))
 #define PPC_ERATSX_DOT(t, a, w)	stringify_in_c(.long PPC_INST_ERATSX_DOT | \
-					__PPC_RS(t) | __PPC_RA(a) | __PPC_RB(b))
+					__PPC_RS(t) | __PPC_RA0(a) | __PPC_RB(b))
 #define PPC_SLBFEE_DOT(t, b)	stringify_in_c(.long PPC_INST_SLBFEE | \
 					__PPC_RT(t) | __PPC_RB(b))
 /* PASemi instructions */
Index: powerpc-test/arch/powerpc/kernel/cpu_setup_a2.S
===================================================================
--- powerpc-test.orig/arch/powerpc/kernel/cpu_setup_a2.S
+++ powerpc-test/arch/powerpc/kernel/cpu_setup_a2.S
@@ -112,7 +112,7 @@ _icswx_skip_guest:
 	 * a bolted entry though it will be in LRU and so will go away eventually
 	 * but let's not bother for now
 	 */
-	PPC_ERATILX(0,R0,R0)
+	PPC_ERATILX(0,0,R0)
 1:
 	blr
 
Index: powerpc-test/arch/powerpc/kernel/exceptions-64e.S
===================================================================
--- powerpc-test.orig/arch/powerpc/kernel/exceptions-64e.S
+++ powerpc-test/arch/powerpc/kernel/exceptions-64e.S
@@ -903,7 +903,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	bne	1b				/* If not, repeat */
 
 	/* Invalidate all TLBs */
-	PPC_TLBILX_ALL(R0,R0)
+	PPC_TLBILX_ALL(0,R0)
 	sync
 	isync
 
@@ -961,7 +961,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	tlbwe
 
 	/* Invalidate TLB1 */
-	PPC_TLBILX_ALL(R0,R0)
+	PPC_TLBILX_ALL(0,R0)
 	sync
 	isync
 
@@ -1020,7 +1020,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	tlbwe
 
 	/* Invalidate TLB1 */
-	PPC_TLBILX_ALL(R0,R0)
+	PPC_TLBILX_ALL(0,R0)
 	sync
 	isync
 
@@ -1138,7 +1138,7 @@ a2_tlbinit_after_iprot_flush:
 	tlbwe
 #endif /* CONFIG_PPC_EARLY_DEBUG_WSP */
 
-	PPC_TLBILX(0,R0,R0)
+	PPC_TLBILX(0,0,R0)
 	sync
 	isync
 
Index: powerpc-test/arch/powerpc/mm/tlb_low_64e.S
===================================================================
--- powerpc-test.orig/arch/powerpc/mm/tlb_low_64e.S
+++ powerpc-test/arch/powerpc/mm/tlb_low_64e.S
@@ -126,7 +126,7 @@ BEGIN_MMU_FTR_SECTION
 	/* Set the TLB reservation and search for existing entry. Then load
 	 * the entry.
 	 */
-	PPC_TLBSRX_DOT(R0,R16)
+	PPC_TLBSRX_DOT(0,R16)
 	ldx	r14,r14,r15		/* grab pgd entry */
 	beq	normal_tlb_miss_done	/* tlb exists already, bail */
 MMU_FTR_SECTION_ELSE
@@ -395,7 +395,7 @@ BEGIN_MMU_FTR_SECTION
 	/* Set the TLB reservation and search for existing entry. Then load
 	 * the entry.
 	 */
-	PPC_TLBSRX_DOT(R0,R16)
+	PPC_TLBSRX_DOT(0,R16)
 	ld	r14,0(r10)
 	beq	normal_tlb_miss_done
 MMU_FTR_SECTION_ELSE
@@ -528,7 +528,7 @@ BEGIN_MMU_FTR_SECTION
 	/* Search if we already have a TLB entry for that virtual address, and
 	 * if we do, bail out.
 	 */
-	PPC_TLBSRX_DOT(R0,R16)
+	PPC_TLBSRX_DOT(0,R16)
 	beq	virt_page_table_tlb_miss_done
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_TLBRSRV)
 
@@ -779,7 +779,7 @@ htw_tlb_miss:
 	 *
 	 * MAS1:IND should be already set based on MAS4
 	 */
-	PPC_TLBSRX_DOT(R0,R16)
+	PPC_TLBSRX_DOT(0,R16)
 	beq	htw_tlb_miss_done
 
 	/* Now, we need to walk the page tables. First check if we are in
@@ -919,7 +919,7 @@ tlb_load_linear:
 	mtspr	SPRN_MAS1,r15
 
 	/* Already somebody there ? */
-	PPC_TLBSRX_DOT(R0,R16)
+	PPC_TLBSRX_DOT(0,R16)
 	beq	tlb_load_linear_done
 
 	/* Now we build the remaining MAS. MAS0 and 2 should be fine
Index: powerpc-test/arch/powerpc/mm/tlb_nohash_low.S
===================================================================
--- powerpc-test.orig/arch/powerpc/mm/tlb_nohash_low.S
+++ powerpc-test/arch/powerpc/mm/tlb_nohash_low.S
@@ -266,7 +266,7 @@ BEGIN_MMU_FTR_SECTION
 	andi.	r3,r3,MMUCSR0_TLBFI@l
 	bne	1b
 MMU_FTR_SECTION_ELSE
-	PPC_TLBILX_ALL(R0,R0)
+	PPC_TLBILX_ALL(0,R0)
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
 	msync
 	isync
@@ -279,7 +279,7 @@ BEGIN_MMU_FTR_SECTION
 	wrteei	0
 	mfspr	r4,SPRN_MAS6	/* save MAS6 */
 	mtspr	SPRN_MAS6,r3
-	PPC_TLBILX_PID(R0,R0)
+	PPC_TLBILX_PID(0,R0)
 	mtspr	SPRN_MAS6,r4	/* restore MAS6 */
 	wrtee	r10
 MMU_FTR_SECTION_ELSE
@@ -313,7 +313,7 @@ BEGIN_MMU_FTR_SECTION
 	mtspr	SPRN_MAS1,r4
 	tlbwe
 MMU_FTR_SECTION_ELSE
-	PPC_TLBILX_VA(R0,R3)
+	PPC_TLBILX_VA(0,R3)
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
 	msync
 	isync
@@ -331,7 +331,7 @@ _GLOBAL(_tlbil_pid)
 	mfmsr	r10
 	wrteei	0
 	mtspr	SPRN_MAS6,r4
-	PPC_TLBILX_PID(R0,R0)
+	PPC_TLBILX_PID(0,R0)
 	wrtee	r10
 	msync
 	isync
@@ -343,14 +343,14 @@ _GLOBAL(_tlbil_pid_noind)
 	ori	r4,r4,MAS6_SIND
 	wrteei	0
 	mtspr	SPRN_MAS6,r4
-	PPC_TLBILX_PID(R0,R0)
+	PPC_TLBILX_PID(0,R0)
 	wrtee	r10
 	msync
 	isync
 	blr
 
 _GLOBAL(_tlbil_all)
-	PPC_TLBILX_ALL(R0,R0)
+	PPC_TLBILX_ALL(0,R0)
 	msync
 	isync
 	blr
@@ -364,7 +364,7 @@ _GLOBAL(_tlbil_va)
 	beq	1f
 	rlwimi	r4,r6,MAS6_SIND_SHIFT,MAS6_SIND
 1:	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
-	PPC_TLBILX_VA(R0,R3)
+	PPC_TLBILX_VA(0,R3)
 	msync
 	isync
 	wrtee	r10
@@ -379,7 +379,7 @@ _GLOBAL(_tlbivax_bcast)
 	beq	1f
 	rlwimi	r4,r6,MAS6_SIND_SHIFT,MAS6_SIND
 1:	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
-	PPC_TLBIVAX(R0,R3)
+	PPC_TLBIVAX(0,R3)
 	eieio
 	tlbsync
 	sync
