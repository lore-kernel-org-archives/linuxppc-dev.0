Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id BEFE21A074C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:57 +1000 (AEST)
Message-Id: <94728e239cad2224383db7ddc1c57df7d11561eb.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 13/25] powerpc/8xx: also use r3 in the ITLB miss in all
 situations
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:54 +0200 (CEST)
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
No change in v2

 arch/powerpc/kernel/head_8xx.S | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 1238fbe..6c991e9 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -352,30 +352,25 @@ SystemCall:
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
@@ -408,9 +403,7 @@ InstructionTLBMiss:
 	MTSPR_CPU6(SPRN_MI_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
-#ifdef CONFIG_8xx_CPU6
 	mfspr	r3, SPRN_SPRG_SCRATCH2
-#endif
 	EXCEPTION_EPILOG_0
 	rfi
 
-- 
2.1.0
