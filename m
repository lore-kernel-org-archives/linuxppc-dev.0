Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9rcZ11gXzDr2W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 02:55:58 +1000 (AEST)
Message-Id: <4d466533adfd270c232bff42cd33743e9ef7e4bf.1471020647.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1471020646.git.christophe.leroy@c-s.fr>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/6] powerpc/8xx: make user addr DTLB miss the short path
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Aug 2016 18:55:54 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

User space DTLB miss represent approximatly 90% of TLB misses
so make it the shortest path.

Also remove an unneccessary double jump in FixupDAR

Before this patch, we spend 3.3 TB ticks in the handler for each
user address miss and 3.4 TB ticks for each kernel address miss
After this patch, we send 3.0 TB ticks in the handler for each
user address miss and 3.9 TB ticks for each kernel address miss
Taking into account that user misses represent 90% of the total,
this patch provides an improvement of approx. 9%

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 53 ++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 5f122e6..5ce67f2 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -383,30 +383,31 @@ InstructionTLBMiss:
 
 	. = 0x1200
 DataStoreTLBMiss:
+	mtspr	SPRN_SPRG_SCRATCH2, r3
 	EXCEPTION_PROLOG_0
-	mfcr	r10
+	mfcr	r3
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	mfspr	r11, SPRN_MD_EPN
-	rlwinm	r11, r11, 16, 0xfff8
+	mfspr	r10, SPRN_MD_EPN
+	rlwinm	r10, r10, 16, 0xfff8
+	cmpli	cr0, r10, PAGE_OFFSET@h
+	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
+	blt+	3f
 #ifndef CONFIG_PIN_TLB_IMMR
-	cmpli	cr0, r11, VIRT_IMMR_BASE@h
+	cmpli	cr0, r10, VIRT_IMMR_BASE@h
 #endif
-	cmpli	cr7, r11, PAGE_OFFSET@h
+_ENTRY(DTLBMiss_cmp)
+	cmpli	cr7, r10, (PAGE_OFFSET + 0x1800000)@h
+	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 #ifndef CONFIG_PIN_TLB_IMMR
 _ENTRY(DTLBMiss_jmp)
 	beq-	DTLBMissIMMR
 #endif
-	bge-	cr7, DTLBMissLinear
-
-	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
+	blt	cr7, DTLBMissLinear
 3:
-	mtcr	r10
-#ifdef CONFIG_8xx_CPU6
-	mtspr	SPRN_SPRG_SCRATCH2, r3
-#endif
+	mtcr	r3
 	mfspr	r10, SPRN_MD_EPN
 
 	/* Insert level 1 index */
@@ -459,9 +460,7 @@ _ENTRY(DTLBMiss_jmp)
 	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
-#ifdef CONFIG_8xx_CPU6
 	mfspr	r3, SPRN_SPRG_SCRATCH2
-#endif
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	EXCEPTION_EPILOG_0
 	rfi
@@ -532,7 +531,7 @@ DARFixed:/* Return from dcbx instruction bug workaround */
  * not enough space in the DataStoreTLBMiss area.
  */
 DTLBMissIMMR:
-	mtcr	r10
+	mtcr	r3
 	/* Set 512k byte guarded page and mark it valid */
 	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
 	MTSPR_CPU6(SPRN_MD_TWC, r10, r11)
@@ -544,27 +543,23 @@ DTLBMissIMMR:
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r3, SPRN_SPRG_SCRATCH2
 	EXCEPTION_EPILOG_0
 	rfi
 
 DTLBMissLinear:
-_ENTRY(DTLBMiss_cmp)
-	cmpli	cr0, r11, (PAGE_OFFSET + 0x1800000)@h
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
-	bge-	3b
-
-	mtcr	r10
+	mtcr	r3
 	/* Set 8M byte page and mark it valid */
-	li	r10, MD_PS8MEG | MD_SVALID
-	MTSPR_CPU6(SPRN_MD_TWC, r10, r11)
-	mfspr	r10, SPRN_MD_EPN
-	rlwinm	r10, r10, 0, 0x0f800000		/* 8xx supports max 256Mb RAM */
+	li	r11, MD_PS8MEG | MD_SVALID
+	MTSPR_CPU6(SPRN_MD_TWC, r11, r3)
+	rlwinm	r10, r10, 16, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
 			  _PAGE_PRESENT
 	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r3, SPRN_SPRG_SCRATCH2
 	EXCEPTION_EPILOG_0
 	rfi
 
@@ -584,7 +579,9 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	rlwinm	r11, r10, 16, 0xfff8
 _ENTRY(FixupDAR_cmp)
 	cmpli	cr7, r11, (PAGE_OFFSET + 0x1800000)@h
-	blt-	cr7, 200f
+	/* create physical page address from effective address */
+	tophys(r11, r10)
+	blt-	cr7, 201f
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 	/* Insert level 1 index */
 3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
@@ -614,10 +611,6 @@ _ENTRY(FixupDAR_cmp)
 141:	mfspr	r10,SPRN_SPRG_SCRATCH2
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
-	/* create physical page address from effective address */
-200:	tophys(r11, r10)
-	b	201b
-
 144:	mfspr	r10, SPRN_DSISR
 	rlwinm	r10, r10,0,7,5	/* Clear store bit for buggy dcbst insn */
 	mtspr	SPRN_DSISR, r10
-- 
2.1.0
