Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 778E51A006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:32 +1000 (AEST)
Message-Id: <2d35de4435e873f23d37e3b5b5fb34c64421f136.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 01/25] powerpc/8xx: Save r3 all the time in DTLB miss
 handler
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:29 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are spending between 40 and 160 cycles with a mean of 65 cycles in
the TLB handling routines (measured with mftbl) so make it more
simple althought it adds one instruction.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
No change in v2

 arch/powerpc/kernel/head_8xx.S | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 78c1eba..1557926 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -385,23 +385,20 @@ InstructionTLBMiss:
 
 	. = 0x1200
 DataStoreTLBMiss:
-#ifdef CONFIG_8xx_CPU6
 	mtspr	SPRN_SPRG_SCRATCH2, r3
-#endif
 	EXCEPTION_PROLOG_0
-	mfcr	r10
+	mfcr	r3
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	mfspr	r11, SPRN_MD_EPN
-	IS_KERNEL(r11, r11)
+	mfspr	r10, SPRN_MD_EPN
+	IS_KERNEL(r11, r10)
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 	BRANCH_UNLESS_KERNEL(3f)
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
-	mtcr	r10
-	mfspr	r10, SPRN_MD_EPN
+	mtcr	r3
 
 	/* Insert level 1 index */
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
@@ -453,9 +450,7 @@ DataStoreTLBMiss:
 	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
-#ifdef CONFIG_8xx_CPU6
 	mfspr	r3, SPRN_SPRG_SCRATCH2
-#endif
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	EXCEPTION_EPILOG_0
 	rfi
-- 
2.1.0
