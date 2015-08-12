Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 5E5451A1D13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:41:34 +1000 (AEST)
Message-Id: <0186a024a5d33e5b2f9284c943c17303d8394171.1439382638.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 19/20] powerpc/8xx: also use r3 in the ITLB miss in all
 situations
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:41:31 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are spending between 40 and 160 cycles with a mean of 65 cycles
in the TLB handling routines (measured with mftbl) so make it more
simple althought it adds one instruction

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 8d24a35..78e4bc3f 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -359,30 +359,25 @@ SystemCall:
 #endif
 
 InstructionTLBMiss:
-#ifdef CONFIG_8xx_CPU6
 	mtspr	SPRN_SPRG_SCRATCH2, r3
-#endif
 	EXCEPTION_PROLOG_0
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
+	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
+	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
 #ifdef CONFIG_MODULES
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
-	mfspr	r11, SPRN_SRR0	/* Get effective address of fault */
-	INVALIDATE_ADJACENT_PAGES_CPU15(r10, r11)
-	mfcr	r10
+	mfcr	r3
 	IS_KERNEL(r11, r11)
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 	BRANCH_UNLESS_KERNEL(3f)
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
-	mtcr	r10
-	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
+	mtcr	r3
 #else
-	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
-	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table base address */
 #endif
 	/* Insert level 1 index */
@@ -415,9 +410,7 @@ InstructionTLBMiss:
 	MTSPR_CPU6(SPRN_MI_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
-#ifdef CONFIG_8xx_CPU6
 	mfspr	r3, SPRN_SPRG_SCRATCH2
-#endif
 	EXCEPTION_EPILOG_0
 	rfi
 
-- 
2.1.0
