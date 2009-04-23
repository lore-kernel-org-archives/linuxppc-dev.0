Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <676ebae6738ddcd5c36971a0e420ebbd3391ac8c.1240450296.git.michael@ellerman.id.au>
In-Reply-To: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/6] powerpc: Move stack overflow check into a separate
	function
Date: Thu, 23 Apr 2009 11:31:37 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Makes do_IRQ() shorter and clearer.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index bc08827..f725610 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -301,6 +301,22 @@ static inline void handle_one_irq(unsigned int irq)
 }
 #endif
 
+static inline void check_stack_overflow(void)
+{
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
+	long sp;
+
+	sp = __get_SP() & (THREAD_SIZE-1);
+
+	/* check for stack overflow: is there less than 2KB free? */
+	if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
+		printk("do_IRQ: stack overflow: %ld\n",
+			sp - sizeof(struct thread_info));
+		dump_stack();
+	}
+#endif
+}
+
 void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
@@ -308,20 +324,7 @@ void do_IRQ(struct pt_regs *regs)
 
 	irq_enter();
 
-#ifdef CONFIG_DEBUG_STACKOVERFLOW
-	/* Debugging check for stack overflow: is there less than 2KB free? */
-	{
-		long sp;
-
-		sp = __get_SP() & (THREAD_SIZE-1);
-
-		if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
-			printk("do_IRQ: stack overflow: %ld\n",
-				sp - sizeof(struct thread_info));
-			dump_stack();
-		}
-	}
-#endif
+	check_stack_overflow();
 
 	/*
 	 * Every platform is required to implement ppc_md.get_irq.
-- 
1.6.2.1
