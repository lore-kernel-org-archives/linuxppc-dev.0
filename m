Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CD711A115A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 20:45:06 +1100 (AEDT)
Date: Thu, 10 Dec 2015 20:44:39 +1100
From: Anton Blanchard <anton@samba.org>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 cyrilbur@gmail.com, scottwood@freescale.com, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org, Rashmica <rashmicy@gmail.com>
Subject: [PATCH v2] powerpc: Call restore_sprs() before _switch()
Message-ID: <20151210204439.393ce017@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 152d523e6307 ("powerpc: Create context switch helpers save_sprs()
and restore_sprs()") moved the restore of SPRs after the call to _switch().

There is an issue with this approach - new tasks do not return through
_switch(), they are set up by copy_thread() to directly return through
ret_from_fork() or ret_from_kernel_thread(). This means restore_sprs() is
not getting called for new tasks.

Fix this by moving restore_sprs() before _switch().

Signed-off-by: Anton Blanchard <anton@samba.org>
Fixes: 152d523e6307 ("powerpc: Create context switch helpers save_sprs() and restore_sprs()")

fold
---
 arch/powerpc/kernel/process.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 58194c3..6f5c392 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -964,14 +964,17 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	tm_recheckpoint_new_task(new);
 
-	last = _switch(old_thread, new_thread);
-
-	/* Need to recalculate these after calling _switch() */
-	old_thread = &last->thread;
-	new_thread = &current->thread;
-
+	/*
+	 * Call restore_sprs() before calling _switch(). If we move it after
+	 * _switch() then we miss out on calling it for new tasks. The reason
+	 * for this is we manually create a stack frame for new tasks that
+	 * directly returns through ret_from_fork() or
+	 * ret_from_kernel_thread(). See copy_thread() for details.
+	 */
 	restore_sprs(old_thread, new_thread);
 
+	last = _switch(old_thread, new_thread);
+
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
 		current_thread_info()->local_flags &= ~_TLF_LAZY_MMU;
-- 
2.5.0
