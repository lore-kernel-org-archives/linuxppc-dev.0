Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8ACD42C00A2
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 21:15:20 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 20:15:19 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4AF7C2BB0052
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 21:15:18 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0E9uGpj52101212
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 20:56:16 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0EAFHRG022632
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 21:15:17 +1100
Subject: [PATCH v2] Move precessing of MCE queued event out from syscall exit
 path.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 15:45:09 +0530
Message-ID: <20140114101450.32385.65506.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Hugh Dickins <hughd@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Huge Dickins reported an issue that b5ff4211a829
"powerpc/book3s: Queue up and process delayed MCE events" breaks the
PowerMac G5 boot. This patch fixes it by moving the mce even processing
away from syscall exit, which was wrong to do that in first place, and
using irq work framework to delay processing of mce event.

Reported-by: Hugh Dickins <hughd@google.com
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h |    1 -
 arch/powerpc/kernel/entry_64.S |    5 -----
 arch/powerpc/kernel/mce.c      |   13 ++++++++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 2257d1e..f97d8cb 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -192,7 +192,6 @@ extern void save_mce_event(struct pt_regs *regs, long handled,
 extern int get_mce_event(struct machine_check_event *mce, bool release);
 extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
-extern void machine_check_process_queued_event(void);
 extern void machine_check_print_event_info(struct machine_check_event *evt);
 extern uint64_t get_mce_fault_addr(struct machine_check_event *evt);
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 770d6d6..bbfb029 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -184,11 +184,6 @@ syscall_exit:
 	bl	.do_show_syscall_exit
 	ld	r3,RESULT(r1)
 #endif
-#ifdef CONFIG_PPC_BOOK3S_64
-BEGIN_FTR_SECTION
-	bl	.machine_check_process_queued_event
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
-#endif
 	CURRENT_THREAD_INFO(r12, r1)
 
 	ld	r8,_MSR(r1)
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index d6edf2b..a7fd4cb 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -26,6 +26,7 @@
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
 #include <linux/export.h>
+#include <linux/irq_work.h>
 #include <asm/mce.h>
 
 static DEFINE_PER_CPU(int, mce_nest_count);
@@ -35,6 +36,11 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event);
 static DEFINE_PER_CPU(int, mce_queue_count);
 static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event_queue);
 
+static void machine_check_process_queued_event(struct irq_work *work);
+struct irq_work mce_event_process_work = {
+        .func = machine_check_process_queued_event,
+};
+
 static void mce_set_error_info(struct machine_check_event *mce,
 			       struct mce_error_info *mce_err)
 {
@@ -185,17 +191,19 @@ void machine_check_queue_event(void)
 		return;
 	}
 	__get_cpu_var(mce_event_queue[index]) = evt;
+
+	/* Queue irq work to process this event later. */
+	irq_work_queue(&mce_event_process_work);
 }
 
 /*
  * process pending MCE event from the mce event queue. This function will be
  * called during syscall exit.
  */
-void machine_check_process_queued_event(void)
+static void machine_check_process_queued_event(struct irq_work *work)
 {
 	int index;
 
-	preempt_disable();
 	/*
 	 * For now just print it to console.
 	 * TODO: log this error event to FSP or nvram.
@@ -206,7 +214,6 @@ void machine_check_process_queued_event(void)
 				&__get_cpu_var(mce_event_queue[index]));
 		__get_cpu_var(mce_queue_count)--;
 	}
-	preempt_enable();
 }
 
 void machine_check_print_event_info(struct machine_check_event *evt)
