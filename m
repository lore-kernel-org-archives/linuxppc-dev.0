Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4N510XFzDrM9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:50:28 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 03/24] powerpc/6xx: Handle DABR match before calling
 do_page_fault
Date: Wed, 19 Jul 2017 14:49:25 +1000
Message-Id: <20170719044946.22030-3-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On legacy 6xx 32-bit procesors, we checked for the DABR match bit
in DSISR from do_page_fault(), in the middle of a pile of ifdef's
because all other CPU types do it in assembly prior to calling
do_page_fault. Fix that.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/entry_32.S | 11 +++++++++++
 arch/powerpc/mm/fault.c        |  9 ---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8587059ad848..7331df033804 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -586,6 +586,8 @@ ppc_swapcontext:
 handle_page_fault:
 	stw	r4,_DAR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+	andis.  r0,r5,DSISR_DABRMATCH@h
+	bne-    handle_dabr_fault
 	bl	do_page_fault
 	cmpwi	r3,0
 	beq+	ret_from_except
@@ -599,6 +601,15 @@ handle_page_fault:
 	bl	bad_page_fault
 	b	ret_from_except_full
 
+	/* We have a data breakpoint exception - handle it */
+handle_dabr_fault:
+	SAVE_NVGPRS(r1)
+	lwz	r0,_TRAP(r1)
+	clrrwi	r0,r0,1
+	stw	r0,_TRAP(r1)
+	bl      do_break
+	b	ret_from_except_full
+
 /*
  * This routine switches between two different tasks.  The process
  * state of one is saved on its kernel stack.  Then the state
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index f04bc9f6b134..f257965b54b5 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -242,15 +242,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		goto bail;
 	}
 
-#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE) || \
-      defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_8xx))
-  	if (error_code & DSISR_DABRMATCH) {
-		/* breakpoint match */
-		do_break(regs, address, error_code);
-		goto bail;
-	}
-#endif
-
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
-- 
2.13.3
