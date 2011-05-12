Return-Path: <wad@chromium.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E353B6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 13:06:35 +1000 (EST)
Received: by iwc10 with SMTP id 10so1215239iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 20:06:31 -0700 (PDT)
From: Will Drewry <wad@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Date: Wed, 11 May 2011 22:02:56 -0500
Message-Id: <1305169376-2363-1-git-send-email-wad@chromium.org>
In-Reply-To: <1304017638.18763.205.camel@gandalf.stny.rr.com>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Eric Paris <eparis@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	jmorris@namei.org, Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@elte.hu>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, microblaze-uclinux@itee.uq.edu.au,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
	Roland McGrath <roland@redhat.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	Oleg Nesterov <oleg@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
	agl@chromium.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This change adds a new seccomp mode based on the work by
agl@chromium.org in [1]. This new mode, "filter mode", provides a hash
table of seccomp_filter objects.  When in the new mode (2), all system
calls are checked against the filters - first by system call number,
then by a filter string.  If an entry exists for a given system call and
all filter predicates evaluate to true, then the task may proceed.
Otherwise, the task is killed (as per seccomp_mode == 1).

Filter string parsing and evaluation  is handled by the ftrace filter
engine.  Related patches tweak to the perf filter trace and free allow
the call to be shared. Filters inherit their understanding of types and
arguments for each system call from the CONFIG_FTRACE_SYSCALLS subsystem
which already predefines this information in syscall_metadata associated
enter_event (and exit_event) structures. If CONFIG_FTRACE and
CONFIG_FTRACE_SYSCALLS are not compiled in, only "1" filter strings will
be allowed.

The net result is a process may have its system calls filtered using the
ftrace filter engine's inherent understanding of systems calls. A
logical ruleset for a process that only needs stdin/stdout may be:
  sys_read: fd == 0
  sys_write: fd == 1 || fd == 2
  sys_exit: 1

The set of filters is specified through the PR_SET_SECCOMP path in prctl().
For example:
  prctl(PR_SET_SECCOMP_FILTER, __NR_read, "fd == 0");
  prctl(PR_SET_SECCOMP_FILTER, __NR_write, "fd == 1 || fd == 2");
  prctl(PR_SET_SECCOMP_FILTER, __NR_exit, "1");
  prctl(PR_SET_SECCOMP, 2, 0);

v2: - changed to use the existing syscall number ABI.
    - prctl changes to minimize parsing in the kernel:
      prctl(PR_SET_SECCOMP, {0 | 1 | 2 }, { 0 | ON_EXEC });
      prctl(PR_SET_SECCOMP_FILTER, __NR_read, "fd == 5");
      prctl(PR_CLEAR_SECCOMP_FILTER, __NR_read);
      prctl(PR_GET_SECCOMP_FILTER, __NR_read, buf, bufsize);
    - defined PR_SECCOMP_MODE_STRICT and ..._FILTER
    - added flags
    - provide a default fail syscall_nr_to_meta in ftrace
    - provides fallback for unhooked system calls
    - use -ENOSYS and ERR_PTR(-ENOSYS) for stubbed functionality
    - added kernel/seccomp.h to share seccomp.c/seccomp_filter.c
    - moved to a hlist and 4 bit hash of linked lists
    - added support to operate without CONFIG_FTRACE_SYSCALLS
    - moved Kconfig support next to SECCOMP
      (should this be done in per-platform patches?)
    - made Kconfig entries dependent on EXPERIMENTAL
    - added macros to avoid ifdefs from kernel/fork.c
    - added compat task/filter matching
    - drop seccomp.h inclusion in sched.h and drop seccomp_t
    - added Filtering to "show" output
    - added on_exec state dup'ing when enabling after a fast-path accept.

Signed-off-by: Will Drewry <wad@chromium.org>
---
 arch/arm/Kconfig        |   10 +
 arch/microblaze/Kconfig |   10 +
 arch/mips/Kconfig       |   10 +
 arch/powerpc/Kconfig    |   10 +
 arch/s390/Kconfig       |   10 +
 arch/sh/Kconfig         |   10 +
 arch/sparc/Kconfig      |   10 +
 arch/x86/Kconfig        |   10 +
 include/linux/prctl.h   |    9 +
 include/linux/sched.h   |    5 +-
 include/linux/seccomp.h |  116 +++++++++-
 include/trace/syscall.h |    7 +
 kernel/Makefile         |    3 +
 kernel/fork.c           |    3 +
 kernel/seccomp.c        |  228 +++++++++++++++++-
 kernel/seccomp.h        |   74 ++++++
 kernel/seccomp_filter.c |  581 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sys.c            |   15 +-
 18 files changed, 1100 insertions(+), 21 deletions(-)
 create mode 100644 kernel/seccomp.h
 create mode 100644 kernel/seccomp_filter.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..22e1668 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1664,6 +1664,16 @@ config SECCOMP
 	  and the task is only allowed to execute a few safe syscalls
 	  defined by each seccomp mode.
 
+config SECCOMP_FILTER
+	bool "Enable seccomp-based system call filtering"
+	depends on SECCOMP && EXPERIMENTAL
+	help
+	  Per-process, inherited system call filtering using shared code
+	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
+	  is not available, enhanced filters will not be available.
+
+	  See Documentation/prctl/seccomp_filter.txt for more detail.
+
 config CC_STACKPROTECTOR
 	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index eccdefe..7641ee9 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -129,6 +129,16 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config SECCOMP_FILTER
+	bool "Enable seccomp-based system call filtering"
+	depends on SECCOMP && EXPERIMENTAL
+	help
+	  Per-process, inherited system call filtering using shared code
+	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
+	  is not available, enhanced filters will not be available.
+
+	  See Documentation/prctl/seccomp_filter.txt for more detail.
+
 endmenu
 
 menu "Advanced setup"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8e256cc..fe4cbda 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2245,6 +2245,16 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config SECCOMP_FILTER
+	bool "Enable seccomp-based system call filtering"
+	depends on SECCOMP && EXPERIMENTAL
+	help
+	  Per-process, inherited system call filtering using shared code
+	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
+	  is not available, enhanced filters will not be available.
+
+	  See Documentation/prctl/seccomp_filter.txt for more detail.
+
 config USE_OF
 	bool "Flattened Device Tree support"
 	select OF
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8f4d50b..83499e4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -605,6 +605,16 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config SECCOMP_FILTER
+	bool "Enable seccomp-based system call filtering"
+	depends on SECCOMP && EXPERIMENTAL
+	help
+	  Per-process, inherited system call filtering using shared code
+	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
+	  is not available, enhanced filters will not be available.
+
+	  See Documentation/prctl/seccomp_filter.txt for more detail.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2508a6f..2777515 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -614,6 +614,16 @@ config SECCOMP
 
 	  If unsure, say Y.
 
+config SECCOMP_FILTER
+	bool "Enable seccomp-based system call filtering"
+	depends on SECCOMP && EXPERIMENTAL
+	help
+	  Per-process, inherited system call filtering using shared code
+	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
+	  is not available, enhanced filters will not be available.
+
+	  See Documentation/prctl/seccomp_filter.txt for more detail.
+
 endmenu
 
 menu "Power Management"
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 4b89da2..00c1521 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -676,6 +676,16 @@ config SECCOMP
 
 	  If unsure, say N.
 
+config SECCOMP_FILTER
+	bool "Enable seccomp-based system call filtering"
+	depends on SECCOMP && EXPERIMENTAL
+	help
+	  Per-process, inherited system call filtering using shared code
+	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
+	  is not available, enhanced filters will not be available.
+
+	  See Documentation/prctl/seccomp_filter.txt for more detail.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	depends on SYS_SUPPORTS_SMP
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e560d10..5b42255 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -270,6 +270,16 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config SECCOMP_FILTER
+	bool "Enable seccomp-based system call filtering"
+	depends on SECCOMP && EXPERIMENTAL
+	help
+	  Per-process, inherited system call filtering using shared code
+	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
+	  is not available, enhanced filters will not be available.
+
+	  See Documentation/prctl/seccomp_filter.txt for more detail.
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SPARC64 && SMP
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cc6c53a..d6d44d9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1485,6 +1485,16 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config SECCOMP_FILTER
+	bool "Enable seccomp-based system call filtering"
+	depends on SECCOMP && EXPERIMENTAL
+	help
+	  Per-process, inherited system call filtering using shared code
+	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
+	  is not available, enhanced filters will not be available.
+
+	  See Documentation/prctl/seccomp_filter.txt for more detail.
+
 config CC_STACKPROTECTOR
 	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
 	---help---
diff --git a/include/linux/prctl.h b/include/linux/prctl.h
index a3baeb2..379b391 100644
--- a/include/linux/prctl.h
+++ b/include/linux/prctl.h
@@ -63,6 +63,15 @@
 /* Get/set process seccomp mode */
 #define PR_GET_SECCOMP	21
 #define PR_SET_SECCOMP	22
+# define PR_SECCOMP_MODE_NONE	0
+# define PR_SECCOMP_MODE_STRICT	1
+# define PR_SECCOMP_MODE_FILTER	2
+# define PR_SECCOMP_FLAG_FILTER_ON_EXEC	(1 << 1)
+
+/* Get/set process seccomp filters */
+#define PR_GET_SECCOMP_FILTER	35
+#define PR_SET_SECCOMP_FILTER	36
+#define PR_CLEAR_SECCOMP_FILTER	37
 
 /* Get/set the capability bounding set (as per security/commoncap.c) */
 #define PR_CAPBSET_READ 23
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 18d63ce..27eacf9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -77,7 +77,6 @@ struct sched_param {
 #include <linux/percpu.h>
 #include <linux/topology.h>
 #include <linux/proportions.h>
-#include <linux/seccomp.h>
 #include <linux/rcupdate.h>
 #include <linux/rculist.h>
 #include <linux/rtmutex.h>
@@ -1190,6 +1189,8 @@ enum perf_event_task_context {
 	perf_nr_task_contexts,
 };
 
+struct seccomp_state;
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	void *stack;
@@ -1374,7 +1375,7 @@ struct task_struct {
 	uid_t loginuid;
 	unsigned int sessionid;
 #endif
-	seccomp_t seccomp;
+	struct seccomp_state *seccomp;
 
 /* Thread group tracking */
    	u32 parent_exec_id;
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 167c333..289c836 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -2,12 +2,34 @@
 #define _LINUX_SECCOMP_H
 
 
+/* Forward declare for proc interface */
+struct seq_file;
+
 #ifdef CONFIG_SECCOMP
 
+#include <linux/errno.h>
+#include <linux/list.h>
 #include <linux/thread_info.h>
+#include <linux/types.h>
 #include <asm/seccomp.h>
 
-typedef struct { int mode; } seccomp_t;
+/**
+ * struct seccomp_state - the state of a seccomp'ed process
+ *
+ * @mode:
+ *     if this is 1, the process is under standard seccomp rules
+ *             is 2, the process is only allowed to make system calls where
+ *                   associated filters evaluate successfully.
+ * @usage: number of references to the current instance.
+ * @flags: a bitmask of behavior altering flags.
+ * @filters: Hash table of filters if using CONFIG_SECCOMP_FILTER.
+ */
+struct seccomp_state {
+	uint16_t mode;
+	atomic_t usage;
+	long flags;
+	struct seccomp_filter_table *filters;
+};
 
 extern void __secure_computing(int);
 static inline void secure_computing(int this_syscall)
@@ -16,27 +38,113 @@ static inline void secure_computing(int this_syscall)
 		__secure_computing(this_syscall);
 }
 
+extern struct seccomp_state *seccomp_state_new(void);
+extern struct seccomp_state *seccomp_state_dup(const struct seccomp_state *);
+extern struct seccomp_state *get_seccomp_state(struct seccomp_state *);
+extern void put_seccomp_state(struct seccomp_state *);
+
+extern long prctl_set_seccomp(unsigned long, unsigned long);
 extern long prctl_get_seccomp(void);
-extern long prctl_set_seccomp(unsigned long);
+
+extern long prctl_set_seccomp_filter(unsigned long, char __user *);
+extern long prctl_get_seccomp_filter(unsigned long, char __user *,
+				     unsigned long);
+extern long prctl_clear_seccomp_filter(unsigned long);
+
+#define inherit_tsk_seccomp_state(_child, _orig) \
+	_child->seccomp = get_seccomp_state(_orig->seccomp);
+#define put_tsk_seccomp_state(_tsk) put_seccomp_state(_tsk->seccomp)
 
 #else /* CONFIG_SECCOMP */
 
 #include <linux/errno.h>
 
-typedef struct { } seccomp_t;
+struct seccomp_state { };
 
 #define secure_computing(x) do { } while (0)
+#define inherit_tsk_seccomp_state(_child, _orig) do { } while (0)
+#define put_tsk_seccomp_state(_tsk) do { } while (0)
 
 static inline long prctl_get_seccomp(void)
 {
 	return -EINVAL;
 }
 
-static inline long prctl_set_seccomp(unsigned long arg2)
+static inline long prctl_set_seccomp(unsigned long a2, unsigned long a3)
 {
 	return -EINVAL;
 }
 
+static inline long prctl_set_seccomp_filter(unsigned long a2, char __user *a3)
+{
+	return -ENOSYS;
+}
+
+static inline long prctl_clear_seccomp_filter(unsigned long a2)
+{
+	return -ENOSYS;
+}
+
+static inline long prctl_get_seccomp_filter(unsigned long a2, char __user *a3,
+					    unsigned long a4)
+{
+	return -ENOSYS;
+}
+
+static inline struct seccomp_state *seccomp_state_new(void)
+{
+	return NULL;
+}
+
+static inline struct seccomp_state *seccomp_state_dup(
+					const struct seccomp_state *state)
+{
+	return NULL;
+}
+
+static inline struct seccomp_state *get_seccomp_state(
+					struct seccomp_state *state)
+{
+	return NULL;
+}
+
+static inline void put_seccomp_state(struct seccomp_state *state)
+{
+}
+
 #endif /* CONFIG_SECCOMP */
 
+#ifdef CONFIG_SECCOMP_FILTER
+
+extern int seccomp_show_filters(struct seccomp_state *, struct seq_file *);
+extern long seccomp_set_filter(int, char *);
+extern long seccomp_clear_filter(int);
+extern long seccomp_get_filter(int, char *, unsigned long);
+
+#else  /* CONFIG_SECCOMP_FILTER */
+
+static inline int seccomp_show_filters(struct seccomp_state *state,
+				       struct seq_file *m)
+{
+	return -ENOSYS;
+}
+
+static inline long seccomp_set_filter(int syscall_nr, char *filter)
+{
+	return -ENOSYS;
+}
+
+static inline long seccomp_clear_filter(int syscall_nr)
+{
+	return -ENOSYS;
+}
+
+static inline long seccomp_get_filter(int syscall_nr,
+				      char *buf, unsigned long available)
+{
+	return -ENOSYS;
+}
+
+#endif  /* CONFIG_SECCOMP_FILTER */
+
 #endif /* _LINUX_SECCOMP_H */
diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 242ae04..e061ad0 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -35,6 +35,8 @@ struct syscall_metadata {
 extern unsigned long arch_syscall_addr(int nr);
 extern int init_syscall_trace(struct ftrace_event_call *call);
 
+extern struct syscall_metadata *syscall_nr_to_meta(int);
+
 extern int reg_event_syscall_enter(struct ftrace_event_call *call);
 extern void unreg_event_syscall_enter(struct ftrace_event_call *call);
 extern int reg_event_syscall_exit(struct ftrace_event_call *call);
@@ -49,6 +51,11 @@ enum print_line_t print_syscall_enter(struct trace_iterator *iter, int flags,
 				      struct trace_event *event);
 enum print_line_t print_syscall_exit(struct trace_iterator *iter, int flags,
 				     struct trace_event *event);
+#else
+static inline struct syscall_metadata *syscall_nr_to_meta(int nr)
+{
+	return NULL;
+}
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/Makefile b/kernel/Makefile
index 85cbfb3..84e7dfb 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -81,6 +81,9 @@ obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
+ifeq ($(CONFIG_SECCOMP_FILTER),y)
+obj-$(CONFIG_SECCOMP) += seccomp_filter.o
+endif
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_TREE_RCU) += rcutree.o
 obj-$(CONFIG_TREE_PREEMPT_RCU) += rcutree.o
diff --git a/kernel/fork.c b/kernel/fork.c
index e7548de..46987d4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -34,6 +34,7 @@
 #include <linux/cgroup.h>
 #include <linux/security.h>
 #include <linux/hugetlb.h>
+#include <linux/seccomp.h>
 #include <linux/swap.h>
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
@@ -169,6 +170,7 @@ void free_task(struct task_struct *tsk)
 	free_thread_info(tsk->stack);
 	rt_mutex_debug_task_free(tsk);
 	ftrace_graph_exit_task(tsk);
+	put_tsk_seccomp_state(tsk);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -280,6 +282,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig)
 	if (err)
 		goto out;
 
+	inherit_tsk_seccomp_state(tsk, orig);
 	setup_thread_stack(tsk, orig);
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 57d4b13..502ba04 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -6,12 +6,15 @@
  * This defines a simple but solid secure-computing mode.
  */
 
+#include <linux/err.h>
+#include <linux/prctl.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 #include <linux/compat.h>
+#include <linux/unistd.h>
 
-/* #define SECCOMP_DEBUG 1 */
-#define NR_SECCOMP_MODES 1
+#include "seccomp.h"
 
 /*
  * Secure computing mode 1 allows only read/write/exit/sigreturn.
@@ -32,11 +35,13 @@ static int mode1_syscalls_32[] = {
 
 void __secure_computing(int this_syscall)
 {
-	int mode = current->seccomp.mode;
+	int mode = -1;
+	long ret = 0;
 	int * syscall;
-
+	if (current->seccomp)
+		mode = current->seccomp->mode;
 	switch (mode) {
-	case 1:
+	case PR_SECCOMP_MODE_STRICT:
 		syscall = mode1_syscalls;
 #ifdef CONFIG_COMPAT
 		if (is_compat_task())
@@ -47,6 +52,20 @@ void __secure_computing(int this_syscall)
 				return;
 		} while (*++syscall);
 		break;
+	case PR_SECCOMP_MODE_FILTER:
+		if (this_syscall >= NR_syscalls || this_syscall < 0)
+			break;
+		ret = seccomp_test_filters(current->seccomp, this_syscall);
+		if (!ret)
+			return;
+		/* Only check for an override if an access failure occurred. */
+		if (ret != -EACCES)
+			break;
+		ret = seccomp_maybe_apply_filters(current, this_syscall);
+		if (!ret)
+			return;
+		seccomp_filter_log_failure(this_syscall);
+		break;
 	default:
 		BUG();
 	}
@@ -57,30 +76,213 @@ void __secure_computing(int this_syscall)
 	do_exit(SIGKILL);
 }
 
+/* seccomp_state_new - allocate a new state object. */
+struct seccomp_state *seccomp_state_new()
+{
+	struct seccomp_state *new = kzalloc(sizeof(struct seccomp_state),
+					    GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	new->flags = 0;
+#ifdef CONFIG_COMPAT
+	/* Annotate if this filterset is being created by a compat task. */
+	if (is_compat_task())
+		new->flags |= SECCOMP_FLAG_COMPAT;
+#endif
+
+	atomic_set(&new->usage, 1);
+	new->filters = seccomp_filter_table_new();
+	/* Not supported errors are fine, others are a problem. */
+	if (IS_ERR(new->filters) && PTR_ERR(new->filters) != -ENOSYS) {
+		kfree(new);
+		new = NULL;
+	}
+	return new;
+}
+
+/* seccomp_state_dup - copies an existing state object. */
+struct seccomp_state *seccomp_state_dup(const struct seccomp_state *orig)
+{
+	int err;
+	struct seccomp_state *new_state = seccomp_state_new();
+
+	err = -ENOMEM;
+	if (!new_state)
+		goto fail;
+	new_state->mode = orig->mode;
+	/* Flag copying will hide if the new process is a compat task.  However,
+	 * if the rule was compat/non-compat and the process is the opposite,
+	 * enforcement will terminate it.
+	 */
+	new_state->flags = orig->flags;
+	err = seccomp_copy_all_filters(new_state->filters,
+				       orig->filters);
+	if (err)
+		goto fail;
+
+	return new_state;
+fail:
+	put_seccomp_state(new_state);
+	return NULL;
+}
+
+/* get_seccomp_state - increments the reference count of @orig */
+struct seccomp_state *get_seccomp_state(struct seccomp_state *orig)
+{
+	if (!orig)
+		return NULL;
+	atomic_inc(&orig->usage);
+	return orig;
+}
+
+static void __put_seccomp_state(struct seccomp_state *orig)
+{
+	WARN_ON(atomic_read(&orig->usage));
+	seccomp_drop_all_filters(orig);
+	kfree(orig);
+}
+
+/* put_seccomp_state - decrements the reference count of @orig and may free. */
+void put_seccomp_state(struct seccomp_state *orig)
+{
+	if (!orig)
+		return;
+
+	if (atomic_dec_and_test(&orig->usage))
+		__put_seccomp_state(orig);
+}
+
 long prctl_get_seccomp(void)
 {
-	return current->seccomp.mode;
+	if (!current->seccomp)
+		return 0;
+	return current->seccomp->mode;
 }
 
-long prctl_set_seccomp(unsigned long seccomp_mode)
+long prctl_set_seccomp(unsigned long seccomp_mode, unsigned long flags)
 {
 	long ret;
+	struct seccomp_state *state, *cur_state;
 
+	cur_state = get_seccomp_state(current->seccomp);
 	/* can set it only once to be even more secure */
 	ret = -EPERM;
-	if (unlikely(current->seccomp.mode))
+	if (cur_state && unlikely(cur_state->mode))
 		goto out;
 
 	ret = -EINVAL;
-	if (seccomp_mode && seccomp_mode <= NR_SECCOMP_MODES) {
-		current->seccomp.mode = seccomp_mode;
-		set_thread_flag(TIF_SECCOMP);
+	if (seccomp_mode <= 0 || seccomp_mode > NR_SECCOMP_MODES)
+		goto out;
+
+	ret = -ENOMEM;
+	state = (cur_state ? seccomp_state_dup(cur_state) :
+			     seccomp_state_new());
+	if (!state)
+		goto out;
+
+	if (seccomp_mode == PR_SECCOMP_MODE_STRICT) {
 #ifdef TIF_NOTSC
 		disable_TSC();
 #endif
-		ret = 0;
 	}
 
- out:
+	rcu_assign_pointer(current->seccomp, state);
+	synchronize_rcu();
+	put_seccomp_state(cur_state);	/* For the task */
+
+	/* Convert the ABI flag to the internal flag value. */
+	if (seccomp_mode == PR_SECCOMP_MODE_FILTER &&
+	    (flags & PR_SECCOMP_FLAG_FILTER_ON_EXEC))
+		state->flags |= SECCOMP_FLAG_ON_EXEC;
+	/* Encourage flag values to stay synchronized explicitly. */
+	BUILD_BUG_ON(PR_SECCOMP_FLAG_FILTER_ON_EXEC != SECCOMP_FLAG_ON_EXEC);
+
+	/* Only set the thread flag once after the new state is in place. */
+	state->mode = seccomp_mode;
+	set_thread_flag(TIF_SECCOMP);
+	ret = 0;
+
+out:
+	put_seccomp_state(cur_state);	/* for the get */
+	return ret;
+}
+
+long prctl_set_seccomp_filter(unsigned long syscall_nr,
+			      char __user *user_filter)
+{
+	int nr;
+	long ret;
+	char filter[SECCOMP_MAX_FILTER_LENGTH];
+
+	ret = -EINVAL;
+	if (syscall_nr >= NR_syscalls || syscall_nr < 0)
+		goto out;
+
+	ret = -EFAULT;
+	if (!user_filter ||
+	    strncpy_from_user(filter, user_filter,
+			      sizeof(filter) - 1) < 0)
+		goto out;
+
+	nr = (int) syscall_nr;
+	ret = seccomp_set_filter(nr, filter);
+
+out:
+	return ret;
+}
+
+long prctl_clear_seccomp_filter(unsigned long syscall_nr)
+{
+	int nr = -1;
+	long ret;
+
+	ret = -EINVAL;
+	if (syscall_nr >= NR_syscalls || syscall_nr < 0)
+		goto out;
+
+	nr = (int) syscall_nr;
+	ret = seccomp_clear_filter(nr);
+
+out:
+	return ret;
+}
+
+long prctl_get_seccomp_filter(unsigned long syscall_nr, char __user *dst,
+			      unsigned long available)
+{
+	int ret, nr;
+	unsigned long copied;
+	char *buf = NULL;
+	ret = -EINVAL;
+	if (!available)
+		goto out;
+	/* Ignore extra buffer space. */
+	if (available > SECCOMP_MAX_FILTER_LENGTH)
+		available = SECCOMP_MAX_FILTER_LENGTH;
+
+	ret = -EINVAL;
+	if (syscall_nr >= NR_syscalls || syscall_nr < 0)
+		goto out;
+	nr = (int) syscall_nr;
+
+	ret = -ENOMEM;
+	buf = kmalloc(available, GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	ret = seccomp_get_filter(nr, buf, available);
+	if (ret < 0)
+		goto out;
+
+	/* Include the NUL byte in the copy. */
+	copied = copy_to_user(dst, buf, ret + 1);
+	ret = -ENOSPC;
+	if (copied)
+		goto out;
+
+	ret = 0;
+out:
+	kfree(buf);
 	return ret;
 }
diff --git a/kernel/seccomp.h b/kernel/seccomp.h
new file mode 100644
index 0000000..5abd219
--- /dev/null
+++ b/kernel/seccomp.h
@@ -0,0 +1,74 @@
+/*
+ * seccomp/seccomp_filter shared internal prototypes and state.
+ *
+ * Copyright (C) 2011 Chromium OS Authors.
+ */
+
+#ifndef __KERNEL_SECCOMP_H
+#define __KERNEL_SECCOMP_H
+
+#include <linux/ftrace_event.h>
+#include <linux/seccomp.h>
+
+/* #define SECCOMP_DEBUG 1 */
+#define NR_SECCOMP_MODES 2
+
+/* Inherit the max filter length from the filtering engine. */
+#define SECCOMP_MAX_FILTER_LENGTH MAX_FILTER_STR_VAL
+
+/* Presently, flags only affect SECCOMP_FILTER. */
+#define _SECCOMP_FLAG_COMPAT	0
+#define _SECCOMP_FLAG_ON_EXEC	1
+
+#define SECCOMP_FLAG_COMPAT	(1 << (_SECCOMP_FLAG_COMPAT))
+#define SECCOMP_FLAG_ON_EXEC	(1 << (_SECCOMP_FLAG_ON_EXEC))
+
+
+#ifdef CONFIG_SECCOMP_FILTER
+
+#define SECCOMP_FILTER_HASH_BITS 4
+#define SECCOMP_FILTER_HASH_SIZE (1 << SECCOMP_FILTER_HASH_BITS)
+
+struct seccomp_filter_table;
+extern struct seccomp_filter_table *seccomp_filter_table_new(void);
+extern int seccomp_copy_all_filters(struct seccomp_filter_table *,
+				    const struct seccomp_filter_table *);
+extern void seccomp_drop_all_filters(struct seccomp_state *);
+
+extern int seccomp_test_filters(struct seccomp_state *, int);
+extern int seccomp_maybe_apply_filters(struct task_struct *, int);
+extern void seccomp_filter_log_failure(int);
+
+#else /* CONFIG_SECCOMP_FILTER */
+
+static inline void seccomp_filter_log_failure(int syscall)
+{
+}
+
+static inline int seccomp_maybe_apply_filters(struct task_struct *tsk,
+					      int syscall_nr)
+{
+	return -ENOSYS;
+}
+
+static inline struct seccomp_filter_table *seccomp_filter_table_new(void)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline int seccomp_test_filters(struct seccomp_state *state, int nr)
+{
+	return -ENOSYS;
+}
+
+extern inline int seccomp_copy_all_filters(struct seccomp_filter_table *dst,
+					const struct seccomp_filter_table *src)
+{
+	return 0;
+}
+
+static inline void seccomp_drop_all_filters(struct seccomp_state *state) { }
+
+#endif /* CONFIG_SECCOMP_FILTER */
+
+#endif /* __KERNEL_SECCOMP_H */
diff --git a/kernel/seccomp_filter.c b/kernel/seccomp_filter.c
new file mode 100644
index 0000000..ff4e055
--- /dev/null
+++ b/kernel/seccomp_filter.c
@@ -0,0 +1,581 @@
+/* filter engine-based seccomp system call filtering.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) 2011 The Chromium OS Authors <chromium-os-dev@chromium.org>
+ */
+
+#include <linux/compat.h>
+#include <linux/errno.h>
+#include <linux/hash.h>
+#include <linux/prctl.h>
+#include <linux/seccomp.h>
+#include <linux/seq_file.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <asm/syscall.h>
+#include <trace/syscall.h>
+
+#include "seccomp.h"
+
+#define SECCOMP_MAX_FILTER_COUNT 512
+#define SECCOMP_WILDCARD_FILTER "1"
+
+struct seccomp_filter {
+	struct hlist_node node;
+	int syscall_nr;
+	struct syscall_metadata *data;
+	struct event_filter *event_filter;
+};
+
+struct seccomp_filter_table {
+	struct hlist_head heads[SECCOMP_FILTER_HASH_SIZE];
+	int count;
+};
+
+struct seccomp_filter_table *seccomp_filter_table_new(void)
+{
+	struct seccomp_filter_table *t =
+		kzalloc(sizeof(struct seccomp_filter_table), GFP_KERNEL);
+	if (!t)
+		return ERR_PTR(-ENOMEM);
+	return t;
+}
+
+static inline u32 syscall_hash(int syscall_nr)
+{
+	return hash_32(syscall_nr, SECCOMP_FILTER_HASH_BITS);
+}
+
+static const char *get_filter_string(struct seccomp_filter *f)
+{
+	const char *str = SECCOMP_WILDCARD_FILTER;
+	if (!f)
+		return NULL;
+
+	/* Missing event filters qualify as wildcard matches. */
+	if (!f->event_filter)
+		return str;
+
+#ifdef CONFIG_FTRACE_SYSCALLS
+	str = ftrace_get_filter_string(f->event_filter);
+#endif
+	return str;
+}
+
+static struct seccomp_filter *alloc_seccomp_filter(int syscall_nr,
+						   const char *filter_string)
+{
+	int err = -ENOMEM;
+	struct seccomp_filter *filter = kzalloc(sizeof(struct seccomp_filter),
+						GFP_KERNEL);
+	if (!filter)
+		goto fail;
+
+	INIT_HLIST_NODE(&filter->node);
+	filter->syscall_nr = syscall_nr;
+	filter->data = syscall_nr_to_meta(syscall_nr);
+
+	/* Treat a filter of SECCOMP_WILDCARD_FILTER as a wildcard and skip
+	 * using a predicate at all.
+	 */
+	if (!strcmp(SECCOMP_WILDCARD_FILTER, filter_string))
+		goto out;
+
+	/* Argument-based filtering only works on ftrace-hooked syscalls. */
+	if (!filter->data) {
+		err = -ENOSYS;
+		goto fail;
+	}
+
+#ifdef CONFIG_FTRACE_SYSCALLS
+	err = ftrace_parse_filter(&filter->event_filter,
+				  filter->data->enter_event->event.type,
+				  filter_string);
+	if (err)
+		goto fail;
+#endif
+
+out:
+	return filter;
+
+fail:
+	kfree(filter);
+	return ERR_PTR(err);
+}
+
+static void free_seccomp_filter(struct seccomp_filter *filter)
+{
+#ifdef CONFIG_FTRACE_SYSCALLS
+	ftrace_free_filter(filter->event_filter);
+#endif
+	kfree(filter);
+}
+
+static struct seccomp_filter *copy_seccomp_filter(struct seccomp_filter *orig)
+{
+	return alloc_seccomp_filter(orig->syscall_nr, get_filter_string(orig));
+}
+
+/* Returns the matching filter or NULL */
+static struct seccomp_filter *find_filter(struct seccomp_state *state,
+					  int syscall)
+{
+	struct hlist_node *this, *pos;
+	struct seccomp_filter *filter = NULL;
+
+	u32 head = syscall_hash(syscall);
+	if (head >= SECCOMP_FILTER_HASH_SIZE)
+		goto out;
+
+	hlist_for_each_safe(this, pos, &state->filters->heads[head]) {
+		filter = hlist_entry(this, struct seccomp_filter, node);
+		if (filter->syscall_nr == syscall)
+			goto out;
+	}
+
+	filter = NULL;
+
+out:
+	return filter;
+}
+
+/* Safely drops all filters for a given syscall. This should only be called
+ * on unattached seccomp_state objects.
+ */
+static void drop_filter(struct seccomp_state *state, int syscall_nr)
+{
+	struct seccomp_filter *filter = find_filter(state, syscall_nr);
+	if (!filter)
+		return;
+
+	WARN_ON(state->filters->count == 0);
+	state->filters->count--;
+	hlist_del(&filter->node);
+	free_seccomp_filter(filter);
+}
+
+/* This should only be called on unattached seccomp_state objects. */
+static int add_filter(struct seccomp_state *state, int syscall_nr,
+		      char *filter_string)
+{
+	struct seccomp_filter *filter;
+	struct hlist_head *head;
+	char merged[SECCOMP_MAX_FILTER_LENGTH];
+	int ret;
+	u32 hash = syscall_hash(syscall_nr);
+
+	ret = -EINVAL;
+	if (state->filters->count == SECCOMP_MAX_FILTER_COUNT - 1)
+		goto out;
+
+	filter_string = strstrip(filter_string);
+
+	/* Disallow empty strings. */
+	if (filter_string[0] == 0)
+		goto out;
+
+	/* Get the right list head. */
+	head = &state->filters->heads[hash];
+
+	/* Find out if there is an existing entry to append to and
+	 * build the resultant filter string.  The original filter can be
+	 * destroyed here since the caller should be operating on a copy.
+	 */
+	filter = find_filter(state, syscall_nr);
+	if (filter) {
+		int expected = snprintf(merged, sizeof(merged), "(%s) && %s",
+					get_filter_string(filter),
+					filter_string);
+		ret = -E2BIG;
+		if (expected >= sizeof(merged) || expected < 0)
+			goto out;
+		filter_string = merged;
+		hlist_del(&filter->node);
+		free_seccomp_filter(filter);
+	}
+
+	/* When in seccomp filtering mode, only allow additions. */
+	ret = -EACCES;
+	if (filter == NULL && state->mode == PR_SECCOMP_MODE_FILTER)
+		goto out;
+
+	ret = 0;
+	filter = alloc_seccomp_filter(syscall_nr, filter_string);
+	if (IS_ERR(filter)) {
+		ret = PTR_ERR(filter);
+		goto out;
+	}
+
+	state->filters->count++;
+	hlist_add_head(&filter->node, head);
+out:
+	return ret;
+}
+
+/* Wrap optional ftrace syscall support. Returns 1 on match or if ftrace is not
+ * supported.
+ */
+static int do_ftrace_syscall_match(struct event_filter *event_filter)
+{
+	int err = 1;
+#ifdef CONFIG_FTRACE_SYSCALLS
+	uint8_t syscall_state[64];
+
+	memset(syscall_state, 0, sizeof(syscall_state));
+
+	/* The generic tracing entry can remain zeroed. */
+	err = ftrace_syscall_enter_state(syscall_state, sizeof(syscall_state),
+					 NULL);
+	if (err)
+		return 0;
+
+	err = filter_match_preds(event_filter, syscall_state);
+#endif
+	return err;
+}
+
+/* 1 on match, 0 otherwise. */
+static int filter_match_current(struct seccomp_filter *filter)
+{
+	/* If no event filter exists, we assume a wildcard match. */
+	if (!filter->event_filter)
+		return 1;
+
+	return do_ftrace_syscall_match(filter->event_filter);
+}
+
+#ifndef KSTK_EIP
+#define KSTK_EIP(x) 0L
+#endif
+
+static const char *syscall_nr_to_name(int syscall)
+{
+	const char *syscall_name = "unknown";
+	struct syscall_metadata *data = syscall_nr_to_meta(syscall);
+	if (data)
+		syscall_name = data->name;
+	return syscall_name;
+}
+
+void seccomp_filter_log_failure(int syscall)
+{
+	printk(KERN_INFO
+		"%s[%d]: system call %d (%s) blocked at ip:%lx\n",
+		current->comm, task_pid_nr(current), syscall,
+		syscall_nr_to_name(syscall), KSTK_EIP(current));
+}
+
+/**
+ * seccomp_drop_all_filters - cleans up the filter list and frees the table
+ * @state: the seccomp_state to destroy the filters in.
+ */
+void seccomp_drop_all_filters(struct seccomp_state *state)
+{
+	struct hlist_node *this, *pos;
+	int head;
+	if (!state->filters)
+		return;
+	for (head = 0; head < SECCOMP_FILTER_HASH_SIZE; ++head) {
+		hlist_for_each_safe(this, pos, &state->filters->heads[head]) {
+			struct seccomp_filter *f = hlist_entry(this,
+						struct seccomp_filter, node);
+			WARN_ON(state->filters->count == 0);
+			hlist_del(this);
+			free_seccomp_filter(f);
+			state->filters->count--;
+		}
+	}
+	kfree(state->filters);
+}
+
+/**
+ * seccomp_copy_all_filters - copies all filters from src to dst.
+ *
+ * @dst: seccomp_filter_table to populate.
+ * @src: table to read from.
+ * Returns non-zero on failure.
+ * Both the source and the destination should have no simultaneous
+ * writers, and dst should be exclusive to the caller.
+ */
+int seccomp_copy_all_filters(struct seccomp_filter_table *dst,
+			     const struct seccomp_filter_table *src)
+{
+	struct seccomp_filter *filter;
+	int head, ret = 0;
+	BUG_ON(!dst || !src);
+	for (head = 0; head < SECCOMP_FILTER_HASH_SIZE; ++head) {
+		struct hlist_node *pos;
+		hlist_for_each_entry(filter, pos, &src->heads[head], node) {
+			struct seccomp_filter *new_filter =
+				copy_seccomp_filter(filter);
+			if (IS_ERR(new_filter)) {
+				ret = PTR_ERR(new_filter);
+				goto done;
+			}
+			hlist_add_head(&new_filter->node,
+				       &dst->heads[head]);
+			dst->count++;
+		}
+	}
+
+done:
+	return ret;
+}
+
+/**
+ * seccomp_show_filters - prints the filter state to a seq_file
+ * @state: the seccomp_state to enumerate the filter and bitmask of
+ * @m: the prepared seq_file to receive the data
+ *
+ * Returns 0 on a successful write.
+ */
+int seccomp_show_filters(struct seccomp_state *state, struct seq_file *m)
+{
+	int head;
+	struct hlist_node *pos;
+	struct seccomp_filter *filter;
+	int filtering = 0;
+	if (!state)
+		return 0;
+	if (!state->filters)
+		return 0;
+
+	filtering = (state->mode == 2);
+	filtering &= !(state->flags & SECCOMP_FLAG_ON_EXEC);
+	seq_printf(m, "Filtering: %d\n", filtering);
+	seq_printf(m, "FilterCount: %d\n", state->filters->count);
+	for (head = 0; head < SECCOMP_FILTER_HASH_SIZE; ++head) {
+		hlist_for_each_entry(filter, pos, &state->filters->heads[head],
+				     node) {
+			seq_printf(m, "SystemCall: %d (%s)\n",
+				      filter->syscall_nr,
+				      syscall_nr_to_name(filter->syscall_nr));
+			seq_printf(m, "Filter: %s\n",
+				      get_filter_string(filter));
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(seccomp_show_filters);
+
+/**
+ * seccomp_maybe_apply_filters - conditionally applies seccomp filters
+ * @tsk: task to update
+ * @syscall_nr: current system call in progress
+ * tsk must already be in seccomp filter mode.
+ *
+ * Returns 0 if the call should be allowed or state has been updated.
+ * This call is only reach if no filters matched the current system call.
+ * In some cases, such as when the ON_EXEC flag is set, failure should
+ * not be terminal.
+ */
+int seccomp_maybe_apply_filters(struct task_struct *tsk, int syscall_nr)
+{
+	struct seccomp_state *state, *new_state = NULL;
+	int ret = -EACCES;
+
+	/* There's no question of application if ON_EXEC is not set. */
+	state = get_seccomp_state(tsk->seccomp);
+	if ((state->flags & SECCOMP_FLAG_ON_EXEC) == 0)
+		goto out;
+
+	ret = 0;
+	if (syscall_nr != __NR_execve)
+		goto out;
+
+	new_state = seccomp_state_dup(state);
+	ret = -ENOMEM;
+	if (!new_state)
+		goto out;
+
+	ret = 0;
+	new_state->flags &= ~(SECCOMP_FLAG_ON_EXEC);
+	rcu_assign_pointer(tsk->seccomp, new_state);
+	synchronize_rcu();
+	put_seccomp_state(state); /* for the task */
+
+out:
+	put_seccomp_state(state); /* for the get */
+	return ret;
+}
+
+/**
+ * seccomp_test_filters - tests 'current' against the given syscall
+ * @state: seccomp_state of current to use.
+ * @syscall: number of the system call to test
+ *
+ * Returns 0 on ok and non-zero on error/failure.
+ */
+int seccomp_test_filters(struct seccomp_state *state, int syscall)
+{
+	struct seccomp_filter *filter = NULL;
+	int ret;
+
+#ifdef CONFIG_COMPAT
+	ret = -EPERM;
+	if (is_compat_task() == !!(state->flags & SECCOMP_FLAG_COMPAT)) {
+		printk(KERN_INFO "%s[%d]: seccomp filter compat() mismatch.\n",
+		       current->comm, task_pid_nr(current));
+		goto out;
+	}
+#endif
+
+	ret = 0;
+	filter = find_filter(state, syscall);
+	if (filter && filter_match_current(filter))
+		goto out;
+
+	ret = -EACCES;
+out:
+	return ret;
+}
+
+/**
+ * seccomp_get_filter - copies the filter_string into "buf"
+ * @syscall_nr: system call number to look up
+ * @buf: destination buffer
+ * @bufsize: available space in the buffer.
+ *
+ * Looks up the filter for the given system call number on current.  If found,
+ * the string length of the NUL-terminated buffer is returned and < 0 is
+ * returned on error. The NUL byte is not included in the length.
+ */
+long seccomp_get_filter(int syscall_nr, char *buf, unsigned long bufsize)
+{
+	struct seccomp_state *state;
+	struct seccomp_filter *filter;
+	long ret = -ENOENT;
+
+	if (bufsize > SECCOMP_MAX_FILTER_LENGTH)
+		bufsize = SECCOMP_MAX_FILTER_LENGTH;
+
+	state = get_seccomp_state(current->seccomp);
+	if (!state)
+		goto out;
+
+	filter = find_filter(state, syscall_nr);
+	if (!filter)
+		goto out;
+
+	ret = strlcpy(buf, get_filter_string(filter), bufsize);
+	if (ret >= bufsize) {
+		ret = -ENOSPC;
+		goto out;
+	}
+	/* Zero out any remaining buffer, just in case. */
+	memset(buf + ret, 0, bufsize - ret);
+out:
+	put_seccomp_state(state);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(seccomp_get_filter);
+
+/**
+ * seccomp_clear_filter: clears the seccomp filter for a syscall.
+ * @syscall_nr: the system call number to clear filters for.
+ *
+ * (acts as a frontend for seccomp_set_filter. All restrictions
+ *  apply)
+ *
+ * Returns 0 on success.
+ */
+long seccomp_clear_filter(int syscall_nr)
+{
+	return seccomp_set_filter(syscall_nr, NULL);
+}
+EXPORT_SYMBOL_GPL(seccomp_clear_filter);
+
+/**
+ * seccomp_set_filter: - Adds/extends a seccomp filter for a syscall.
+ * @syscall_nr: system call number to apply the filter to.
+ * @filter: ftrace filter string to apply.
+ *
+ * Context: User context only. This function may sleep on allocation and
+ *          operates on current. current must be attempting a system call
+ *          when this is called.
+ *
+ * New filters may be added for system calls when the current task is
+ * not in a secure computing mode (seccomp).  Otherwise, filters may only
+ * be added to already filtered system call entries.  Any additions will
+ * be &&'d with the existing filter string to ensure no expansion of privileges
+ * will be possible.
+ *
+ * Returns 0 on success or an errno on failure.
+ */
+long seccomp_set_filter(int syscall_nr, char *filter)
+{
+	struct seccomp_state *state, *orig_state;
+	long ret = -EINVAL;
+
+	orig_state = get_seccomp_state(current->seccomp);
+
+	/* Prior to mutating the state, create a duplicate to avoid modifying
+	 * the behavior of other instances sharing the state and ensure
+	 * consistency.
+	 */
+	state = (orig_state ? seccomp_state_dup(orig_state) :
+			      seccomp_state_new());
+	if (!state) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* A NULL filter doubles as a drop value, but the exposed prctl
+	 * interface requires a trip through seccomp_clear_filter().
+	 * Filter dropping is allowed across the is_compat_task() barrier.
+	 */
+	ret = 0;
+	if (filter == NULL) {
+		drop_filter(state, syscall_nr);
+		goto assign;
+	}
+
+	/* Avoid amiguous filters which may have been inherited from a parent
+	 * with different syscall numbers for the logically same calls.
+	 */
+#ifdef CONFIG_COMPAT
+	ret = -EACCES;
+	if (is_compat_task() != !!(state->flags & SECCOMP_FLAG_COMPAT)) {
+		if (state->filters->count)
+			goto free_state;
+		/* It's safe to add if there are no existing ambiguous rules.*/
+		if (is_compat_task())
+			state->flags |= SECCOMP_FLAG_COMPAT;
+		else
+			state->flags &= ~(SECCOMP_FLAG_COMPAT);
+	}
+#endif
+
+	ret = add_filter(state, syscall_nr, filter);
+	if (ret)
+		goto free_state;
+
+assign:
+	rcu_assign_pointer(current->seccomp, state);
+	synchronize_rcu();
+	put_seccomp_state(orig_state);  /* for the task */
+out:
+	put_seccomp_state(orig_state);  /* for the get */
+	return ret;
+
+free_state:
+	put_seccomp_state(orig_state);  /* for the get */
+	put_seccomp_state(state);  /* drop the dup/new */
+	return ret;
+}
+EXPORT_SYMBOL_GPL(seccomp_set_filter);
diff --git a/kernel/sys.c b/kernel/sys.c
index af468ed..d29003a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1698,12 +1698,23 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		case PR_SET_ENDIAN:
 			error = SET_ENDIAN(me, arg2);
 			break;
-
 		case PR_GET_SECCOMP:
 			error = prctl_get_seccomp();
 			break;
 		case PR_SET_SECCOMP:
-			error = prctl_set_seccomp(arg2);
+			error = prctl_set_seccomp(arg2, arg3);
+			break;
+		case PR_SET_SECCOMP_FILTER:
+			error = prctl_set_seccomp_filter(arg2,
+							 (char __user *) arg3);
+			break;
+		case PR_CLEAR_SECCOMP_FILTER:
+			error = prctl_clear_seccomp_filter(arg2);
+			break;
+		case PR_GET_SECCOMP_FILTER:
+			error = prctl_get_seccomp_filter(arg2,
+							 (char __user *) arg3,
+							 arg4);
 			break;
 		case PR_GET_TSC:
 			error = GET_TSC_CTL(arg2);
-- 
1.7.0.4
