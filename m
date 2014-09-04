Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 343FF1A0213
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 00:52:55 +1000 (EST)
From: Aaron Tomlin <atomlin@redhat.com>
To: peterz@infradead.org
Subject: [PATCH 1/2] sched: Add helper for task stack page overrun checking
Date: Thu,  4 Sep 2014 15:50:23 +0100
Message-Id: <1409842224-11847-2-git-send-email-atomlin@redhat.com>
In-Reply-To: <1409842224-11847-1-git-send-email-atomlin@redhat.com>
References: <1409842224-11847-1-git-send-email-atomlin@redhat.com>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com,
 minchan@kernel.org, bmr@redhat.com, x86@kernel.org, oleg@redhat.com,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
 mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, atomlin@redhat.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 pzijlstr@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This facility is used in a few places so let's introduce
a helper function to improve readability.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 arch/powerpc/mm/fault.c    | 6 ++----
 arch/x86/mm/fault.c        | 5 +----
 include/linux/sched.h      | 3 +++
 kernel/trace/trace_stack.c | 5 ++---
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 51ab9e7..5cffc7c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -30,7 +30,6 @@
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/perf_event.h>
-#include <linux/magic.h>
 #include <linux/ratelimit.h>
 #include <linux/context_tracking.h>
 
@@ -508,7 +507,6 @@ bail:
 void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 {
 	const struct exception_table_entry *entry;
-	unsigned long *stackend;
 
 	/* Are we prepared to handle this fault?  */
 	if ((entry = search_exception_tables(regs->nip)) != NULL) {
@@ -537,8 +535,8 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
 		regs->nip);
 
-	stackend = end_of_stack(current);
-	if (current != &init_task && *stackend != STACK_END_MAGIC)
+	if (current != &init_task &&
+		task_stack_end_corrupted(current))
 		printk(KERN_ALERT "Thread overran stack, or stack corrupted\n");
 
 	die("Kernel access of bad area", regs, sig);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a241946..b5b9c09 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -3,7 +3,6 @@
  *  Copyright (C) 2001, 2002 Andi Kleen, SuSE Labs.
  *  Copyright (C) 2008-2009, Red Hat Inc., Ingo Molnar
  */
-#include <linux/magic.h>		/* STACK_END_MAGIC		*/
 #include <linux/sched.h>		/* test_thread_flag(), ...	*/
 #include <linux/kdebug.h>		/* oops_begin/end, ...		*/
 #include <linux/module.h>		/* search_exception_table	*/
@@ -649,7 +648,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	   unsigned long address, int signal, int si_code)
 {
 	struct task_struct *tsk = current;
-	unsigned long *stackend;
 	unsigned long flags;
 	int sig;
 
@@ -709,8 +707,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 
 	show_fault_oops(regs, error_code, address);
 
-	stackend = end_of_stack(tsk);
-	if (tsk != &init_task && *stackend != STACK_END_MAGIC)
+	if (tsk != &init_task && task_stack_end_corrupted(tsk))
 		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
 
 	tsk->thread.cr2		= address;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5c2c885..36d93aa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -57,6 +57,7 @@ struct sched_param {
 #include <linux/llist.h>
 #include <linux/uidgid.h>
 #include <linux/gfp.h>
+#include <linux/magic.h>
 
 #include <asm/processor.h>
 
@@ -2614,6 +2615,8 @@ static inline unsigned long *end_of_stack(struct task_struct *p)
 }
 
 #endif
+#define task_stack_end_corrupted(task) \
+		(*(end_of_stack(task)) != STACK_END_MAGIC)
 
 static inline int object_is_on_stack(void *obj)
 {
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 8a4e5cb..06c7390 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -13,7 +13,6 @@
 #include <linux/sysctl.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/magic.h>
 
 #include <asm/setup.h>
 
@@ -171,8 +170,8 @@ check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
-	if ((current != &init_task &&
-		*(end_of_stack(current)) != STACK_END_MAGIC)) {
+	if (current != &init_task &&
+		task_stack_end_corrupted(current)) {
 		print_max_stack();
 		BUG();
 	}
-- 
1.9.3
