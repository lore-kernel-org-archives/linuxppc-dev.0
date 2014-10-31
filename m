Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D30DF1A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 16:50:58 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: do_notify_resume can be called with bad thread_info
 flags argument
Date: Fri, 31 Oct 2014 16:50:57 +1100
Message-Id: <1414734657-5004-1-git-send-email-anton@samba.org>
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

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/entry_64.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 9caab69..194e46d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -659,7 +659,13 @@ _GLOBAL(ret_from_except_lite)
 3:
 #endif
 	bl	save_nvgprs
+	/*
+	 * Use a non volatile GPR to save and restore our thread_info flags
+	 * across the call to restore_interrupts.
+	 */
+	mr	r30,r4
 	bl	restore_interrupts
+	mr	r4,r30
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_notify_resume
 	b	ret_from_except
-- 
1.9.1
