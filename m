Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5963F1A01B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 14:23:36 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: do_notify_resume can be called with bad thread_info
 flags argument
Date: Fri, 31 Oct 2014 14:23:34 +1100
Message-Id: <1414725814-29964-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Back in 7230c5644188 ("powerpc: Rework lazy-interrupt handling") we
added a call out to restore_interrupts() (written in c) before calling
do_notify_resume:

        bl      restore_interrupts
        addi    r3,r1,STACK_FRAME_OVERHEAD
        bl      do_notify_resume

Unfortunately do_notify_resume takes two arguments, the second one
being the thread_info flags:

void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)

We do populate r4 (the second argument) earlier, but
restore_interrupts() is free to muck it up all it wants. My guess is
the gcc compiler gods shone down on us and its register allocator
never used r4. Sometimes, rarely, luck is on our side.

LLVM on the other hand did trample r4.

To avoid having to reload the flags, pass it through
restore_interrupts, suggested by benh.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/entry_64.S | 6 ++++++
 arch/powerpc/kernel/irq.c      | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 9caab69..086c566 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -659,7 +659,13 @@ _GLOBAL(ret_from_except_lite)
 3:
 #endif
 	bl	save_nvgprs
+	/*
+	 * restore_interrupts takes an argument and returns it unmodified
+	 * so we can get the thread_info flags into do_notify_resume.
+	 */
+	mr	r3,r4
 	bl	restore_interrupts
+	mr	r4,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_notify_resume
 	b	ret_from_except
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 6dbae00..44b0530 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -283,16 +283,22 @@ EXPORT_SYMBOL(arch_local_irq_restore);
  * schedule() or do_signal() when returning to userspace. We do it
  * in C to avoid the burden of dealing with lockdep etc...
  *
+ * We are passed the current thread_info flags which we return. This
+ * is useful in the exception exit code where we already have loaded
+ * the flags and need to use them again after calling restore_interrupts.
+ *
  * NOTE: This is called with interrupts hard disabled but not marked
  * as such in paca->irq_happened, so we need to resync this.
  */
-void notrace restore_interrupts(void)
+unsigned long notrace restore_interrupts(unsigned long thread_info_flags)
 {
 	if (irqs_disabled()) {
 		local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
 		local_irq_enable();
 	} else
 		__hard_irq_enable();
+
+	return thread_info_flags;
 }
 
 /*
-- 
1.9.1
