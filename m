Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 111C61A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 14:37:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Subject: [PATCH] powerpc: Re-enable dynticks
Date: Mon, 13 Apr 2015 14:37:45 +1000
Message-Id: <1428899865-29258-1-git-send-email-mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Clarke <pc@us.ibm.com>

Commit fea559f303567e558bfab9c8ba4a2af5b309205a upstream, for 3.19.

Implement arch_irq_work_has_interrupt() for powerpc

Commit 9b01f5bf3 introduced a dependency on "IRQ work self-IPIs" for
full dynamic ticks to be enabled, by expecting architectures to
implement a suitable arch_irq_work_has_interrupt() routine.

Several arches have implemented this routine, including x86 (3010279f)
and arm (09f6edd4), but powerpc was omitted.

This patch implements this routine for powerpc.

The symptom, at boot (on powerpc systems) with "nohz_full=<CPU list>"
is displayed:

     NO_HZ: Can't run full dynticks because arch doesn't support irq work self-IPIs

after this patch:

     NO_HZ: Full dynticks CPUs: <CPU list>.

Tested against 3.19.

powerpc implements "IRQ work self-IPIs" by setting the decrementer to 1 in
arch_irq_work_raise(), which causes a decrementer exception on the next
timebase tick. We then handle the work in __timer_interrupt().

CC: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[mpe: Flesh out change log, fix ws & include guards, remove include of processor.h]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/irq_work.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 arch/powerpc/include/asm/irq_work.h

diff --git a/arch/powerpc/include/asm/irq_work.h b/arch/powerpc/include/asm/irq_work.h
new file mode 100644
index 000000000000..744fd54de374
--- /dev/null
+++ b/arch/powerpc/include/asm/irq_work.h
@@ -0,0 +1,9 @@
+#ifndef _ASM_POWERPC_IRQ_WORK_H
+#define _ASM_POWERPC_IRQ_WORK_H
+
+static inline bool arch_irq_work_has_interrupt(void)
+{
+	return true;
+}
+
+#endif /* _ASM_POWERPC_IRQ_WORK_H */
-- 
2.1.0
