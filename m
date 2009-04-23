Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f2b2aa06b5713b0c2bc5f4933f502be9bef5750d.1240450296.git.michael@ellerman.id.au>
In-Reply-To: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/6] powerpc: Remove fallback to __do_IRQ()
Date: Thu, 23 Apr 2009 11:31:43 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should no longer have any irq code that needs __do_IRQ(), so
remove the fallback to __do_IRQ().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index b8f09bd..7d46e5d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -254,7 +254,6 @@ static inline void handle_one_irq(unsigned int irq)
 	struct thread_info *curtp, *irqtp;
 	unsigned long saved_sp_limit;
 	struct irq_desc *desc;
-	void *handler;
 
 	/* Switch to the irq stack to handle this */
 	curtp = current_thread_info();
@@ -269,10 +268,6 @@ static inline void handle_one_irq(unsigned int irq)
 	desc = irq_desc + irq;
 	saved_sp_limit = current->thread.ksp_limit;
 
-	handler = desc->handler;
-	if (handler == NULL)
-		handler = &__do_IRQ;
-
 	irqtp->task = curtp->task;
 	irqtp->flags = 0;
 
@@ -284,7 +279,7 @@ static inline void handle_one_irq(unsigned int irq)
 	current->thread.ksp_limit = (unsigned long)irqtp +
 		_ALIGN_UP(sizeof(struct thread_info), 16);
 
-	call_handle_irq(irq, desc, irqtp, handler);
+	call_handle_irq(irq, desc, irqtp, desc->handle_irq);
 	current->thread.ksp_limit = saved_sp_limit;
 	irqtp->task = NULL;
 
-- 
1.6.2.1
