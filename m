Return-Path: <mbenes@suse.cz>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSlGz4NqqzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 20:48:27 +1000 (AEST)
From: Miroslav Benes <mbenes@suse.cz>
To: jpoimboe@redhat.com,
	jeyu@kernel.org,
	jikos@kernel.org
Cc: pmladek@suse.com, lpechacek@suse.cz, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v2 2/3] livepatch: send a fake signal to all blocking tasks
Date: Thu, 10 Aug 2017 12:48:14 +0200
Message-Id: <20170810104815.14727-3-mbenes@suse.cz>
In-Reply-To: <20170810104815.14727-1-mbenes@suse.cz>
References: <20170810104815.14727-1-mbenes@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Live patching consistency model is of LEAVE_PATCHED_SET and
SWITCH_THREAD. This means that all tasks in the system have to be marked
one by one as safe to call a new patched function. Safe means when a
task is not (sleeping) in a set of patched functions. That is, no
patched function is on the task's stack. Another clearly safe place is
the boundary between kernel and userspace. The patching waits for all
tasks to get outside of the patched set or to cross the boundary. The
transition is completed afterwards.

The problem is that a task can block the transition for quite a long
time, if not forever. It could sleep in a set of patched functions, for
example.  Luckily we can force the task to leave the set by sending it a
fake signal, that is a signal with no data in signal pending structures
(no handler, no sign of proper signal delivered). Suspend/freezer use
this to freeze the tasks as well. The task gets TIF_SIGPENDING set and
is woken up (if it has been sleeping in the kernel before) or kicked by
rescheduling IPI (if it was running on other CPU). This causes the task
to go to kernel/userspace boundary where the signal would be handled and
the task would be marked as safe in terms of live patching.

There are tasks which are not affected by this technique though. The
fake signal is not sent to kthreads. They should be handled in a
different way. They can be woken up so they leave the patched set and
their TIF_PATCH_PENDING can be cleared thanks to stack checking.

For the sake of completeness, if the task is in TASK_RUNNING state but
not currently running on some CPU it doesn't get the IPI, but it would
eventually handle the signal anyway. Second, if the task runs in the
kernel (in TASK_RUNNING state) it gets the IPI, but the signal is not
handled on return from the interrupt. It would be handled on return to
the userspace in the future when the fake signal is sent again. Stack
checking deals with these cases in a better way.

If the task was sleeping in a syscall it would be woken by our fake
signal, it would check if TIF_SIGPENDING is set (by calling
signal_pending() predicate) and return ERESTART* or EINTR. Syscalls with
ERESTART* return values are restarted in case of the fake signal (see
do_signal()). EINTR is propagated back to the userspace program. This
could disturb the program, but...

* each process dealing with signals should react accordingly to EINTR
  return values.
* syscalls returning EINTR happen to be quite common situation in the
  system even if no fake signal is sent.
* freezer sends the fake signal and does not deal with EINTR anyhow.
  Thus EINTR values are returned when the system is resumed.

The very safe marking is done in architectures' "entry" on syscall and
interrupt/exception exit paths, and in a stack checking functions of
livepatch.  TIF_PATCH_PENDING is cleared and the next
recalc_sigpending() drops TIF_SIGPENDING. In connection with this, also
call klp_update_patch_state() before do_signal(), so that
recalc_sigpending() in dequeue_signal() can clear TIF_PATCH_PENDING
immediately and thus prevent a double call of do_signal().

Note that the fake signal is not sent to stopped/traced tasks. Such task
prevents the patching to finish till it continues again (is not traced
anymore).

Last, sending the fake signal is not automatic. It is done only when
admin requests it by writing 1 to force sysfs attribute in livepatch
sysfs directory.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
---
 Documentation/ABI/testing/sysfs-kernel-livepatch |  4 ++-
 Documentation/livepatch/livepatch.txt            |  5 ++-
 arch/powerpc/kernel/signal.c                     |  6 ++--
 arch/x86/entry/common.c                          |  6 ++--
 kernel/livepatch/core.c                          |  9 ++++--
 kernel/livepatch/transition.c                    | 40 ++++++++++++++++++++++++
 kernel/livepatch/transition.h                    |  1 +
 kernel/signal.c                                  |  4 ++-
 8 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index b7a487ca8852..45f4e3551d27 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -16,9 +16,11 @@ Contact:	live-patching@vger.kernel.org
 		The attribute allows administrator to affect the course of an
 		existing transition.
 
-		Reading from the file returns all available operations.
+		Reading from the file returns all available operations, which
+		may be "signal" (signalling remaining tasks).
 
 		Writing one of the strings to the file executes the operation.
+		"signal" sends a signal to all remaining blocking tasks.
 
 What:		/sys/kernel/livepatch/<patch>
 Date:		Nov 2014
diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 9c9966be328d..343b0bfa1b9f 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -180,7 +180,10 @@ patched state.
 
 Administrator can also affect a transition through /sys/kernel/livepatch/force
 attribute. Reading from the file returns all available operations. Writing one
-of the strings to the file executes the operation.
+of the strings to the file executes the operation. "signal" is available for
+signalling all remaining blocking tasks. This is an alternative for
+SIGSTOP/SIGCONT approach mentioned in the previous paragraph. It should also be
+less harmful to the system.
 
 
 3.1 Adding consistency model support to new architectures
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index e9436c5e1e09..bf9c4e7792d1 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -153,6 +153,9 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	if (thread_info_flags & _TIF_UPROBE)
 		uprobe_notify_resume(regs);
 
+	if (thread_info_flags & _TIF_PATCH_PENDING)
+		klp_update_patch_state(current);
+
 	if (thread_info_flags & _TIF_SIGPENDING) {
 		BUG_ON(regs != current->thread.regs);
 		do_signal(current);
@@ -163,9 +166,6 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 		tracehook_notify_resume(regs);
 	}
 
-	if (thread_info_flags & _TIF_PATCH_PENDING)
-		klp_update_patch_state(current);
-
 	user_enter();
 }
 
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index cdefcfdd9e63..8e638dcd0822 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -152,6 +152,9 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (cached_flags & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
+		if (cached_flags & _TIF_PATCH_PENDING)
+			klp_update_patch_state(current);
+
 		/* deal with pending signal delivery */
 		if (cached_flags & _TIF_SIGPENDING)
 			do_signal(regs);
@@ -164,9 +167,6 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
 			fire_user_return_notifiers();
 
-		if (cached_flags & _TIF_PATCH_PENDING)
-			klp_update_patch_state(current);
-
 		/* Disable IRQs and retry */
 		local_irq_disable();
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 79022b7eca2c..a359340c924d 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -452,7 +452,7 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
 static ssize_t force_show(struct kobject *kobj,
 			  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "No operation is currently permitted.\n");
+	return sprintf(buf, "signal\n");
 }
 
 static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -468,7 +468,12 @@ static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
 		return -EINVAL;
 	}
 
-	return -EINVAL;
+	if (!memcmp("signal", buf, min(sizeof("signal")-1, count)))
+		klp_force_signals();
+	else
+		return -EINVAL;
+
+	return count;
 }
 
 static struct kobj_attribute force_kobj_attr = __ATTR_RW(force);
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index b004a1fb6032..0d8be69be8b1 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -577,3 +577,43 @@ void klp_copy_process(struct task_struct *child)
 
 	/* TIF_PATCH_PENDING gets copied in setup_thread_stack() */
 }
+
+/*
+ * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
+ * Kthreads with TIF_PATCH_PENDING set are woken up. Only admin can request this
+ * action currently.
+ */
+void klp_force_signals(void)
+{
+	struct task_struct *g, *task;
+
+	pr_notice("signalling remaining tasks\n");
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, task) {
+		if (!klp_patch_pending(task))
+			continue;
+
+		/*
+		 * There is a small race here. We could see TIF_PATCH_PENDING
+		 * set and decide to wake up a kthread or send a fake signal.
+		 * Meanwhile the task could migrate itself and the action
+		 * would be meaningless. It is not serious though.
+		 */
+		if (task->flags & PF_KTHREAD) {
+			/*
+			 * Wake up a kthread which still has not been migrated.
+			 */
+			wake_up_process(task);
+		} else {
+			/*
+			 * Send fake signal to all non-kthread tasks which are
+			 * still not migrated.
+			 */
+			spin_lock_irq(&task->sighand->siglock);
+			signal_wake_up(task, 0);
+			spin_unlock_irq(&task->sighand->siglock);
+		}
+	}
+	read_unlock(&tasklist_lock);
+}
diff --git a/kernel/livepatch/transition.h b/kernel/livepatch/transition.h
index ce09b326546c..6c480057539a 100644
--- a/kernel/livepatch/transition.h
+++ b/kernel/livepatch/transition.h
@@ -10,5 +10,6 @@ void klp_cancel_transition(void);
 void klp_start_transition(void);
 void klp_try_complete_transition(void);
 void klp_reverse_transition(void);
+void klp_force_signals(void);
 
 #endif /* _LIVEPATCH_TRANSITION_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index ca92bcfeb322..8a961dd943f4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -39,6 +39,7 @@
 #include <linux/compat.h>
 #include <linux/cn_proc.h>
 #include <linux/compiler.h>
+#include <linux/livepatch.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -162,7 +163,8 @@ void recalc_sigpending_and_wake(struct task_struct *t)
 
 void recalc_sigpending(void)
 {
-	if (!recalc_sigpending_tsk(current) && !freezing(current))
+	if (!recalc_sigpending_tsk(current) && !freezing(current) &&
+	    !klp_patch_pending(current))
 		clear_thread_flag(TIF_SIGPENDING);
 
 }
-- 
2.13.3
