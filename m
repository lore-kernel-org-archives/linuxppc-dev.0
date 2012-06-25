Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 26 Jun 2012 09:33:18 +1000
Subject: [PATCH 11/18] powerpc: fixes for instructions not using correct
 register naming
In-Reply-To: <1340667187.357853.615199632713.qpush@ale>
Message-Id: <20120625233318.A7361D43683@localhost.localdomain>
Cc: mikey@neuling.org, matt@ozlabs.org, linuxppc-dev@ozlabs.org,
 schwab@linux-m68k.org, Anton Blanchard <anton@samba.org>,
 Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These macros are using integers where they could be using logical
names since they take registers.

We are going to enforce this soon, so fix these up now.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/exceptions-64e.S |    8 ++++----
 arch/powerpc/kernel/misc_64.S        |    4 ++--
 arch/powerpc/lib/ldstfp.S            |    4 ++--
 arch/powerpc/mm/tlb_nohash_low.S     |   10 +++++-----
 4 files changed, 13 insertions(+), 13 deletions(-)

Index: b/arch/powerpc/kernel/exceptions-64e.S
===================================================================
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -903,7 +903,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	bne	1b				/* If not, repeat */
 
 	/* Invalidate all TLBs */
-	PPC_TLBILX_ALL(0,0)
+	PPC_TLBILX_ALL(R0,R0)
 	sync
 	isync
 
@@ -961,7 +961,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	tlbwe
 
 	/* Invalidate TLB1 */
-	PPC_TLBILX_ALL(0,0)
+	PPC_TLBILX_ALL(R0,R0)
 	sync
 	isync
 
@@ -1020,7 +1020,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	tlbwe
 
 	/* Invalidate TLB1 */
-	PPC_TLBILX_ALL(0,0)
+	PPC_TLBILX_ALL(R0,R0)
 	sync
 	isync
 
@@ -1138,7 +1138,7 @@ a2_tlbinit_after_iprot_flush:
 	tlbwe
 #endif /* CONFIG_PPC_EARLY_DEBUG_WSP */
 
-	PPC_TLBILX(0,0,0)
+	PPC_TLBILX(0,R0,R0)
 	sync
 	isync
 
Index: b/arch/powerpc/kernel/misc_64.S
===================================================================
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -309,7 +309,7 @@ _GLOBAL(real_205_readb)
 	mtmsrd	r0
 	sync
 	isync
-	LBZCIX(R3,0,R3)
+	LBZCIX(R3,R0,R3)
 	isync
 	mtmsrd	r7
 	sync
@@ -324,7 +324,7 @@ _GLOBAL(real_205_writeb)
 	mtmsrd	r0
 	sync
 	isync
-	STBCIX(R3,0,R4)
+	STBCIX(R3,R0,R4)
 	isync
 	mtmsrd	r7
 	sync
Index: b/arch/powerpc/lib/ldstfp.S
===================================================================
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -332,7 +332,7 @@ _GLOBAL(do_lxvd2x)
 	beq	cr7,1f
 	STXVD2X(0,R1,R8)
 1:	li	r9,-EFAULT
-2:	LXVD2X(0,0,R4)
+2:	LXVD2X(0,R0,R4)
 	li	r9,0
 3:	beq	cr7,4f
 	bl	put_vsr
@@ -361,7 +361,7 @@ _GLOBAL(do_stxvd2x)
 	STXVD2X(0,R1,R8)
 	bl	get_vsr
 1:	li	r9,-EFAULT
-2:	STXVD2X(0,0,R4)
+2:	STXVD2X(0,R0,R4)
 	li	r9,0
 3:	beq	cr7,4f
 	LXVD2X(0,R1,R8)
Index: b/arch/powerpc/mm/tlb_nohash_low.S
===================================================================
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -266,7 +266,7 @@ BEGIN_MMU_FTR_SECTION
 	andi.	r3,r3,MMUCSR0_TLBFI@l
 	bne	1b
 MMU_FTR_SECTION_ELSE
-	PPC_TLBILX_ALL(0,0)
+	PPC_TLBILX_ALL(R0,R0)
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
 	msync
 	isync
@@ -279,7 +279,7 @@ BEGIN_MMU_FTR_SECTION
 	wrteei	0
 	mfspr	r4,SPRN_MAS6	/* save MAS6 */
 	mtspr	SPRN_MAS6,r3
-	PPC_TLBILX_PID(0,0)
+	PPC_TLBILX_PID(R0,R0)
 	mtspr	SPRN_MAS6,r4	/* restore MAS6 */
 	wrtee	r10
 MMU_FTR_SECTION_ELSE
@@ -331,7 +331,7 @@ _GLOBAL(_tlbil_pid)
 	mfmsr	r10
 	wrteei	0
 	mtspr	SPRN_MAS6,r4
-	PPC_TLBILX_PID(0,0)
+	PPC_TLBILX_PID(R0,R0)
 	wrtee	r10
 	msync
 	isync
@@ -343,14 +343,14 @@ _GLOBAL(_tlbil_pid_noind)
 	ori	r4,r4,MAS6_SIND
 	wrteei	0
 	mtspr	SPRN_MAS6,r4
-	PPC_TLBILX_PID(0,0)
+	PPC_TLBILX_PID(R0,R0)
 	wrtee	r10
 	msync
 	isync
 	blr
 
 _GLOBAL(_tlbil_all)
-	PPC_TLBILX_ALL(0,0)
+	PPC_TLBILX_ALL(R0,R0)
 	msync
 	isync
 	blr
