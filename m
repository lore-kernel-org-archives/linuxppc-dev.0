Return-Path: <cascardo@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vl95R03ygzDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 02:59:38 +1100 (AEDT)
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix /proc/self/stack
Date: Fri, 17 Mar 2017 12:59:21 -0300
Message-Id: <20170317155921.24369-1-cascardo@canonical.com>
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

This is also consistent with some other architectures.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 arch/powerpc/kernel/stacktrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 6671195..2446066 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -59,7 +59,12 @@ EXPORT_SYMBOL_GPL(save_stack_trace);
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
-	save_context_stack(trace, tsk->thread.ksp, tsk, 0);
+	unsigned long sp = tsk->thread.ksp;
+
+	if (tsk == current)
+		sp = current_stack_pointer();
+
+	save_context_stack(trace, sp, tsk, 0);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
-- 
2.9.3
