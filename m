Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/tm: Remove interrupt disable in __switch_to()
Date: Wed,  2 Oct 2013 17:15:14 +1000
Message-Id: <1380698115-25841-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently turn IRQs off in __switch_to(0 but this is unnecessary as it's
already disabled in the caller.

This removes the IRQ disable but adds a check to make sure it is really off
in case this changes in future.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/process.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 96d2fdf..384c27e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -596,12 +596,13 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
 	struct thread_struct *new_thread, *old_thread;
-	unsigned long flags;
 	struct task_struct *last;
 #ifdef CONFIG_PPC_BOOK3S_64
 	struct ppc64_tlb_batch *batch;
 #endif
 
+	WARN_ON(!irqs_disabled());
+
 	/* Back up the TAR across context switches.
 	 * Note that the TAR is not available for use in the kernel.  (To
 	 * provide this, the TAR should be backed up/restored on exception
@@ -721,8 +722,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-	local_irq_save(flags);
-
 	/*
 	 * We can't take a PMU exception inside _switch() since there is a
 	 * window where the kernel stack SLB and the kernel stack are out
@@ -742,8 +741,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-	local_irq_restore(flags);
-
 	return last;
 }
 
-- 
1.8.1.2
