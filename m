Return-Path: <cascardo@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsPLm3Z0WzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 06:32:47 +1100 (AEDT)
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc: make /proc/self/stack always print the current
 stack
Date: Mon, 27 Mar 2017 16:32:33 -0300
Message-Id: <20170327193233.25147-1-cascardo@canonical.com>
In-Reply-To: <20170317155921.24369-1-cascardo@canonical.com>
References: <20170317155921.24369-1-cascardo@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the current task, the kernel stack would only tell the last time the
process was rescheduled, if ever. Use the current stack pointer for the
current task.

Otherwise, every once in a while, the stacktrace printed when reading
/proc/self/stack would look like the process is running in userspace,
while it's not, which some may consider as a bug.

This is also consistent with some other architectures, like x86 and arm,
at least.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 arch/powerpc/kernel/stacktrace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 6671195..d534ed9 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -59,7 +59,14 @@ EXPORT_SYMBOL_GPL(save_stack_trace);
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
-	save_context_stack(trace, tsk->thread.ksp, tsk, 0);
+	unsigned long sp;
+
+	if (tsk == current)
+		sp = current_stack_pointer();
+	else
+		sp = tsk->thread.ksp;
+
+	save_context_stack(trace, sp, tsk, 0);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
-- 
2.9.3
