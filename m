Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ED14B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 13:17:37 +1000 (EST)
Subject: [PATCH] powerpc: Copy back TIF flags on return from softirq stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 13:17:22 +1000
Message-ID: <1311045442.25044.361.camel@pasglop>
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We already did it for hard IRQs but it looks like we forgot
to do it for softirqs. Without this, we would lose flags
such as TIF_NEED_RESCHED set using current_thread_info()
by something running of a softirq.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/irq.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 164fb6c..4e7f1aa 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -451,11 +451,18 @@ static inline void do_softirq_onstack(void)
 	curtp = current_thread_info();
 	irqtp = softirq_ctx[smp_processor_id()];
 	irqtp->task = curtp->task;
+	irqtp->flags = 0;
 	current->thread.ksp_limit = (unsigned long)irqtp +
 				    _ALIGN_UP(sizeof(struct thread_info), 16);
 	call_do_softirq(irqtp);
 	current->thread.ksp_limit = saved_sp_limit;
 	irqtp->task = NULL;
+
+	/* Set any flag that may have been set on the
+	 * alternate stack
+	 */
+	if (irqtp->flags)
+		set_bits(irqtp->flags, &curtp->flags);
 }
 
 void do_softirq(void)
