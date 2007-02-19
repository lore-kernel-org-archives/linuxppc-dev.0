Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17880.62082.820011.992072@cargo.ozlabs.ibm.com>
Date: Mon, 19 Feb 2007 11:42:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Harden validate_sp against stack corruption
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If something has overflowed or corrupted the stack and causes an oops,
and we try to print a stack trace, that will call validate_sp, which
can itself cause an oops if the cpu field of the thread_info struct at
the bottom of the stack has been corrupted (if CONFIG_IRQSTACKS is
set).  This makes debugging harder.

To avoid the second oops, this adds a check to make sure that the cpu
number is reasonable before using it to check whether the stack is on
the softirq or hardirq stack.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f3d4dd5..3712fd5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -818,6 +818,35 @@ out:
 	return error;
 }
 
+#ifdef CONFIG_IRQSTACKS
+static inline int valid_irq_stack(unsigned long sp, struct task_struct *p,
+				  unsigned long nbytes)
+{
+	unsigned long stack_page;
+	unsigned long cpu = task_cpu(p);
+
+	/*
+	 * Avoid crashing if the stack has overflowed and corrupted
+	 * task_cpu(p), which is in the thread_info struct.
+	 */
+	if (cpu < NR_IRQS && cpu_possible(cpu)) {
+		stack_page = (unsigned long) hardirq_ctx[cpu];
+		if (sp >= stack_page + sizeof(struct thread_struct)
+		    && sp <= stack_page + THREAD_SIZE - nbytes)
+			return 1;
+
+		stack_page = (unsigned long) softirq_ctx[cpu];
+		if (sp >= stack_page + sizeof(struct thread_struct)
+		    && sp <= stack_page + THREAD_SIZE - nbytes)
+			return 1;
+	}
+	return 0;
+}
+
+#else
+#define valid_irq_stack(sp, p, nb)	0
+#endif /* CONFIG_IRQSTACKS */
+
 int validate_sp(unsigned long sp, struct task_struct *p,
 		       unsigned long nbytes)
 {
@@ -827,19 +856,7 @@ int validate_sp(unsigned long sp, struct task_struct *p,
 	    && sp <= stack_page + THREAD_SIZE - nbytes)
 		return 1;
 
-#ifdef CONFIG_IRQSTACKS
-	stack_page = (unsigned long) hardirq_ctx[task_cpu(p)];
-	if (sp >= stack_page + sizeof(struct thread_struct)
-	    && sp <= stack_page + THREAD_SIZE - nbytes)
-		return 1;
-
-	stack_page = (unsigned long) softirq_ctx[task_cpu(p)];
-	if (sp >= stack_page + sizeof(struct thread_struct)
-	    && sp <= stack_page + THREAD_SIZE - nbytes)
-		return 1;
-#endif
-
-	return 0;
+	return valid_irq_stack(sp, p, nbytes);
 }
 
 #ifdef CONFIG_PPC64
