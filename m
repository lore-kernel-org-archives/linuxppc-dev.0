Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb5nr2PTgzDsZw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:02:39 +1000 (AEST)
Message-Id: <b0bbd2d1c7d40bf15035652b1ef28ec40dda40af.1474004638.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1474004638.git.christophe.leroy@c-s.fr>
References: <cover.1474004638.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/3] powerpc/8xx: use r3 to scratch CR in ITLBmiss
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 16 Sep 2016 08:42:04 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 8632515..fd5b53d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -323,7 +323,7 @@ SystemCall:
 #endif
 
 InstructionTLBMiss:
-#ifdef CONFIG_8xx_CPU6
+#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
 	mtspr	SPRN_SPRG_SCRATCH2, r3
 #endif
 	EXCEPTION_PROLOG_0
@@ -331,23 +331,20 @@ InstructionTLBMiss:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
+	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
+	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
 #if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
-	mfspr	r11, SPRN_SRR0	/* Get effective address of fault */
-	INVALIDATE_ADJACENT_PAGES_CPU15(r10, r11)
-	mfcr	r10
-	IS_KERNEL(r11, r11)
+	mfcr	r3
+	IS_KERNEL(r11, r10)
+#endif
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
+#if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
 	BRANCH_UNLESS_KERNEL(3f)
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
-	mtcr	r10
-	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
-#else
-	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
-	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
-	mfspr	r11, SPRN_M_TW	/* Get level 1 table base address */
+	mtcr	r3
 #endif
 	/* Insert level 1 index */
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
@@ -379,7 +376,7 @@ InstructionTLBMiss:
 	MTSPR_CPU6(SPRN_MI_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
-#ifdef CONFIG_8xx_CPU6
+#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
 	mfspr	r3, SPRN_SPRG_SCRATCH2
 #endif
 	EXCEPTION_EPILOG_0
-- 
2.1.0
