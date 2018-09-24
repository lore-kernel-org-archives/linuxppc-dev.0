Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JXwC6zdLzDrTQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 15:35:07 +1000 (AEST)
Message-Id: <f49e2e4ff1eacbad161eb6c1645cca7a281dcf3e.1537765881.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/traps: merge unrecoverable_exception() and
 nonrecoverable_exception()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 24 Sep 2018 05:35:03 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC32 uses nonrecoverable_exception() while PPC64 uses
unrecoverable_exception().

Both functions are doing almost the same thing.

This patch removes nonrecoverable_exception()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/asm-prototypes.h |  1 -
 arch/powerpc/kernel/entry_32.S            |  4 ++--
 arch/powerpc/kernel/traps.c               | 13 +++----------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 78ed3c3f879a..2741831482f4 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -63,7 +63,6 @@ void program_check_exception(struct pt_regs *regs);
 void alignment_exception(struct pt_regs *regs);
 void slb_miss_bad_addr(struct pt_regs *regs);
 void StackOverflow(struct pt_regs *regs);
-void nonrecoverable_exception(struct pt_regs *regs);
 void kernel_fp_unavailable_exception(struct pt_regs *regs);
 void altivec_unavailable_exception(struct pt_regs *regs);
 void vsx_unavailable_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e58c3f467db5..77decded1175 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -794,7 +794,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	lis	r10,MSR_KERNEL@h
 	ori	r10,r10,MSR_KERNEL@l
 	bl	transfer_to_handler_full
-	.long	nonrecoverable_exception
+	.long	unrecoverable_exception
 	.long	ret_from_except
 #endif
 
@@ -1297,7 +1297,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	rlwinm	r3,r3,0,0,30
 	stw	r3,_TRAP(r1)
 4:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	nonrecoverable_exception
+	bl	unrecoverable_exception
 	/* shouldn't return */
 	b	4b
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6ab66a88db14..4567eeb6524e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1547,14 +1547,6 @@ void StackOverflow(struct pt_regs *regs)
 	panic("kernel stack overflow");
 }
 
-void nonrecoverable_exception(struct pt_regs *regs)
-{
-	printk(KERN_ERR "Non-recoverable exception at PC=%lx MSR=%lx\n",
-	       regs->nip, regs->msr);
-	debugger(regs);
-	die("nonrecoverable exception", regs, SIGKILL);
-}
-
 void kernel_fp_unavailable_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
@@ -2090,8 +2082,9 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
  */
 void unrecoverable_exception(struct pt_regs *regs)
 {
-	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
-	       regs->trap, regs->nip);
+	pr_emerg("Unrecoverable exception %lx at %lx (msr=%lx)\n",
+		 regs->trap, regs->nip, regs->msr);
+	debugger(regs);
 	die("Unrecoverable exception", regs, SIGABRT);
 }
 NOKPROBE_SYMBOL(unrecoverable_exception);
-- 
2.13.3
