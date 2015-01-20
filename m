Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 689DE1A0C72
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 20:57:43 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH v2 09/11] powerpc/8xx: dont save CR in SCRATCH registers
Message-Id: <20150120095736.055751A5E88@localhost.localdomain>
Date: Tue, 20 Jan 2015 10:57:36 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CR only needs to be preserved when checking if we are handling a kernel address.
So we can preserve CR in a register:
- In ITLBMiss, check is done only when CONFIG_MODULES is defined. Otherwise we
don't need to do anything at all with CR.
- We use r10, then we reload SRR0/MD_EPN into r10 when CR is restored

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: removed the CPU6 specific handling of CR which was saving (only) 1 cycle but
was making the code more difficult to maintain due to too many different cases

 arch/powerpc/kernel/head_8xx.S | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 27a9997..e803ad0 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -312,10 +312,6 @@ InstructionTLBMiss:
 	mtspr	SPRN_DAR, r3
 #endif
 	EXCEPTION_PROLOG_0
-	mfcr	r10
-	mtspr	SPRN_SPRG_SCRATCH2, r10
-	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
-	DO_8xx_CPU15(r11, r10)
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
@@ -323,13 +319,20 @@ InstructionTLBMiss:
 #ifdef CONFIG_MODULES
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
-	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
-#endif
+	mfspr	r11, SPRN_SRR0	/* Get effective address of fault */
+	DO_8xx_CPU15(r10, r11)
+	mfcr	r10
+	andis.	r11, r11, 0x8000	/* Address >= 0x80000000 */
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
-#ifdef CONFIG_MODULES
 	beq	3f
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
+	mtcr	r10
+	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
+#else
+	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
+	DO_8xx_CPU15(r11, r10)
+	mfspr	r11, SPRN_M_TW	/* Get level 1 table base address */
 #endif
 	/* Insert level 1 index */
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
@@ -362,8 +365,6 @@ InstructionTLBMiss:
 	mfspr	r3, SPRN_DAR
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 #endif
-	mfspr	r10, SPRN_SPRG_SCRATCH2
-	mtcr	r10
 	EXCEPTION_EPILOG_0
 	rfi
 
@@ -374,17 +375,19 @@ DataStoreTLBMiss:
 #endif
 	EXCEPTION_PROLOG_0
 	mfcr	r10
-	mtspr	SPRN_SPRG_SCRATCH2, r10
-	mfspr	r10, SPRN_MD_EPN
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	andis.	r11, r10, 0x8000
+	mfspr	r11, SPRN_MD_EPN
+	andis.	r11, r11, 0x8000
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 	beq	3f
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
+	mtcr	r10
+	mfspr	r10, SPRN_MD_EPN
+
 	/* Insert level 1 index */
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
@@ -441,8 +444,6 @@ DataStoreTLBMiss:
 	mfspr	r3, SPRN_DAR
 #endif
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
-	mfspr	r10, SPRN_SPRG_SCRATCH2
-	mtcr	r10
 	EXCEPTION_EPILOG_0
 	rfi
 
-- 
2.1.0
