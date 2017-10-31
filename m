Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR8lR2LB2zDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 22:49:23 +1100 (AEDT)
From: Miroslav Benes <mbenes@suse.cz>
To: jpoimboe@redhat.com,
	jeyu@kernel.org,
	jikos@kernel.org
Cc: pmladek@suse.com, lpechacek@suse.cz, pavel@ucw.cz,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Miroslav Benes <mbenes@suse.cz>, Oleg Nesterov <oleg@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v3 1/2] livepatch: send a fake signal to all blocking tasks
Date: Tue, 31 Oct 2017 12:48:52 +0100
Message-Id: <20171031114853.841-2-mbenes@suse.cz>
In-Reply-To: <20171031114853.841-1-mbenes@suse.cz>
References: <20171031114853.841-1-mbenes@suse.cz>
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
fake signal is not sent to kthreads. They should be handled differently.
They can be woken up so they leave the patched set and their
TIF_PATCH_PENDING can be cleared thanks to stack checking.

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
admin requests it by writing 1 to signal sysfs attribute in livepatch
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
 Documentation/ABI/testing/sysfs-kernel-livepatch |  9 ++++++
 Documentation/livepatch/livepatch.txt            |  9 ++++++
 arch/powerpc/kernel/signal.c                     |  6 ++--
 arch/x86/entry/common.c                          |  6 ++--
 kernel/livepatch/core.c                          | 27 ++++++++++++++++
 kernel/livepatch/transition.c                    | 40 ++++++++++++++++++++++++
 kernel/livepatch/transition.h                    |  1 +
 kernel/signal.c                                  |  4 ++-
 8 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index d5d39748382f..22f6267836c2 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -33,6 +33,15 @@ Contact:	live-patching@vger.kernel.org
 		An attribute which indicates whether the patch is currently in
 		transition.
 
+What:		/sys/kernel/livepatch/<patch>/signal
+Date:		Oct 2017
+KernelVersion:	4.15.0
+Contact:	live-patching@vger.kernel.org
+Description:
+		A writable attribute that allows administrator to affect the
+		course of an existing transition. Writing 1 sends a signal to
+		all remaining blocking tasks.
+
 What:		/sys/kernel/livepatch/<patch>/<object>
 Date:		Nov 2014
 KernelVersion:	3.19.0
diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index ecdb18104ab0..6694530d0894 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -178,6 +178,12 @@ transition, it shows -1.  Any tasks which are blocking the transition
 can be signaled with SIGSTOP and SIGCONT to force them to change their
 patched state.
 
+Administrator can also affect a transition through
+/sys/kernel/livepatch/<patch>/signal attribute. Writing 1 to the attribute sends
+a signal to all remaining blocking tasks. This is an alternative for
+SIGSTOP/SIGCONT approach mentioned in the previous paragraph. It should also be
+less harmful to the system.
+
 
 3.1 Adding consistency model support to new architectures
 ---------------------------------------------------------
@@ -435,6 +441,9 @@ Information about the registered patches can be found under
 /sys/kernel/livepatch. The patches could be enabled and disabled
 by writing there.
 
+/sys/kernel/livepatch/<patch>/signal attribute allows administrator to affect a
+patching operation.
+
 See Documentation/ABI/testing/sysfs-kernel-livepatch for more details.
 
 
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
index 03505ffbe1b6..fb90bdb3602f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -153,6 +153,9 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (cached_flags & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
+		if (cached_flags & _TIF_PATCH_PENDING)
+			klp_update_patch_state(current);
+
 		/* deal with pending signal delivery */
 		if (cached_flags & _TIF_SIGPENDING)
 			do_signal(regs);
@@ -165,9 +168,6 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
 			fire_user_return_notifiers();
 
-		if (cached_flags & _TIF_PATCH_PENDING)
-			klp_update_patch_state(current);
-
 		/* Disable IRQs and retry */
 		local_irq_disable();
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index bf8c8fd72589..b7c60662baf3 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -440,6 +440,7 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
  * /sys/kernel/livepatch/<patch>
  * /sys/kernel/livepatch/<patch>/enabled
  * /sys/kernel/livepatch/<patch>/transition
+ * /sys/kernel/livepatch/<patch>/signal
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
  */
@@ -514,11 +515,37 @@ static ssize_t transition_show(struct kobject *kobj,
 			patch == klp_transition_patch);
 }
 
+static ssize_t signal_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	int ret;
+	bool val;
+
+	/*
+	 * klp_mutex lock is not grabbed here intentionally. It is not really
+	 * needed. The race window is harmless and grabbing the lock would only
+	 * hold the action back.
+	 */
+	if (!klp_transition_patch)
+		return -EINVAL;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	if (val)
+		klp_force_signals();
+
+	return count;
+}
+
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
 static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
+static struct kobj_attribute signal_kobj_attr = __ATTR_WO(signal);
 static struct attribute *klp_patch_attrs[] = {
 	&enabled_kobj_attr.attr,
 	&transition_kobj_attr.attr,
+	&signal_kobj_attr.attr,
 	NULL
 };
 
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index b004a1fb6032..6700d3b22615 100644
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
+	pr_notice("signaling remaining tasks\n");
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
index 800a18f77732..9009b8e77bc3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -40,6 +40,7 @@
 #include <linux/cn_proc.h>
 #include <linux/compiler.h>
 #include <linux/posix-timers.h>
+#include <linux/livepatch.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -163,7 +164,8 @@ void recalc_sigpending_and_wake(struct task_struct *t)
 
 void recalc_sigpending(void)
 {
-	if (!recalc_sigpending_tsk(current) && !freezing(current))
+	if (!recalc_sigpending_tsk(current) && !freezing(current) &&
+	    !klp_patch_pending(current))
 		clear_thread_flag(TIF_SIGPENDING);
 
 }
-- 
2.14.3
