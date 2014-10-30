Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 817711A0035
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 16:13:00 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: do_notify_resume can be called with bad thread_info
 flags argument
Date: Thu, 30 Oct 2014 16:12:58 +1100
Message-Id: <1414645978-21968-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Back in 7230c5644188 ("powerpc: Rework lazy-interrupt handling") we
added a call out to restore_interrupts() (written in c) before we
call do_notify_resume:

        bl      restore_interrupts
        addi    r3,r1,STACK_FRAME_OVERHEAD
        bl      do_notify_resume

Unfortunately do_notify_resume takes two arguments, the second one
being the thread_info flags:

void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)

We do populate r4 earlier, but restore_interrupts() is free to muck
it up all it wants. My guess is the gcc compiler gods shone down on
us and its register allocator never used r4. Sometimes, rarely, luck
is on our side.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/entry_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 9caab69..add42d0 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -661,6 +661,13 @@ _GLOBAL(ret_from_except_lite)
 	bl	save_nvgprs
 	bl	restore_interrupts
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+	/*
+	 * restore_interrupts() is written in c and could clobber all
+	 * volatile registers. We need to reload our thread_info flags
+	 * in r4 for do_notify_resume().
+	 */
+	CURRENT_THREAD_INFO(r9, r1)
+	ld	r4,TI_FLAGS(r9)
 	bl	do_notify_resume
 	b	ret_from_except
 
-- 
1.9.1
