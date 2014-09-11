Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE65C1A090A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 01:44:07 +1000 (EST)
From: Aaron Tomlin <atomlin@redhat.com>
To: peterz@infradead.org
Subject: [PATCH v3 2/3] sched: Add helper for task stack page overrun checking
Date: Thu, 11 Sep 2014 16:41:27 +0100
Message-Id: <1410450088-18236-3-git-send-email-atomlin@redhat.com>
In-Reply-To: <1410450088-18236-1-git-send-email-atomlin@redhat.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com, x86@kernel.org,
 akpm@linux-foundation.org, minchan@kernel.org, mingo@kernel.com,
 bmr@redhat.com, prarit@redhat.com, oleg@redhat.com, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mingo@redhat.com,
 aneesh.kumar@linux.vnet.ibm.com, akpm@google.com, atomlin@redhat.com,
 jgh@redhat.com, linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de,
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
a helper function to improve code readability.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 arch/powerpc/mm/fault.c    | 4 +---
 arch/x86/mm/fault.c        | 4 +---
 include/linux/sched.h      | 2 ++
 kernel/trace/trace_stack.c | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 35d0760c..99b2f27 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -507,7 +507,6 @@ bail:
 void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 {
 	const struct exception_table_entry *entry;
-	unsigned long *stackend;
 
 	/* Are we prepared to handle this fault?  */
 	if ((entry = search_exception_tables(regs->nip)) != NULL) {
@@ -536,8 +535,7 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
 		regs->nip);
 
-	stackend = end_of_stack(current);
-	if (*stackend != STACK_END_MAGIC)
+	if (task_stack_end_corrupted(current))
 		printk(KERN_ALERT "Thread overran stack, or stack corrupted\n");
 
 	die("Kernel access of bad area", regs, sig);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index bc23a70..6240bc7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -648,7 +648,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	   unsigned long address, int signal, int si_code)
 {
 	struct task_struct *tsk = current;
-	unsigned long *stackend;
 	unsigned long flags;
 	int sig;
 
@@ -708,8 +707,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 
 	show_fault_oops(regs, error_code, address);
 
-	stackend = end_of_stack(tsk);
-	if (*stackend != STACK_END_MAGIC)
+	if (task_stack_end_corrupted(tsk))
 		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
 
 	tsk->thread.cr2		= address;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7ef34b7..a80e35d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2615,6 +2615,8 @@ static inline unsigned long *end_of_stack(struct task_struct *p)
 }
 
 #endif
+#define task_stack_end_corrupted(task) \
+		(*(end_of_stack(task)) != STACK_END_MAGIC)
 
 static inline int object_is_on_stack(void *obj)
 {
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 1636e41..16eddb3 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -170,7 +170,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
-	if (*end_of_stack(current) != STACK_END_MAGIC) {
+	if (task_stack_end_corrupted(current)) {
 		print_max_stack();
 		BUG();
 	}
-- 
1.9.3
