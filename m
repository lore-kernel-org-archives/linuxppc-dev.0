Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4DB55B751E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:19 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA4Ha6001216
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:17 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4IpT1720322
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:18 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4Gg2004760
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:18 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 10/40] tracing: add tracing support for compat syscalls
Date: Wed, 23 Jun 2010 20:02:51 +1000
Message-Id: <1277287401-28571-11-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Jason Baron <jbaron@redhat.com>, Li Zefan <lizf@cn.fujitsu.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jason Baron <jbaron@redhat.com>

Add core support to event tracing for compat syscalls. The basic idea is that we
check if we have a compat task via 'is_compat_task()'. If so, we lookup in the
new compat_syscalls_metadata table, the corresponding struct syscall_metadata, to
check syscall arguments and whether or not we are enabled.

Signed-off-by: Jason Baron <jbaron@redhat.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 include/linux/compat.h        |    2 +
 include/trace/syscall.h       |    4 ++
 kernel/trace/trace.h          |    2 +
 kernel/trace/trace_syscalls.c |   86 +++++++++++++++++++++++++++++++++++++----
 4 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index ab638e9..a94f13d 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -363,6 +363,8 @@ extern ssize_t compat_rw_copy_check_uvector(int type,
 
 #else /* CONFIG_COMPAT */
 
+#define NR_syscalls_compat 0
+
 static inline int is_compat_task(void)
 {
 	return 0;
diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 75f3dce..67d4e64 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -22,6 +22,7 @@
 struct syscall_metadata {
 	const char	*name;
 	int		syscall_nr;
+	int		compat_syscall_nr;
 	int		nb_args;
 	const char	**types;
 	const char	**args;
@@ -38,6 +39,9 @@ struct syscall_metadata {
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 extern unsigned long arch_syscall_addr(int nr);
+#ifdef CONFIG_COMPAT
+extern unsigned long arch_compat_syscall_addr(int nr);
+#endif
 extern int init_syscall_trace(struct ftrace_event_call *call);
 
 extern int reg_event_syscall_enter(struct ftrace_event_call *call);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 01ce088..53ace4b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -79,12 +79,14 @@ enum trace_type {
 struct syscall_trace_enter {
 	struct trace_entry	ent;
 	int			nr;
+	int			compat;
 	unsigned long		args[];
 };
 
 struct syscall_trace_exit {
 	struct trace_entry	ent;
 	int			nr;
+	int			compat;
 	long			ret;
 };
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f5ddb9c..d910cba 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
+#include <linux/compat.h>
 #include <asm/syscall.h>
 
 #include "trace_output.h"
@@ -65,6 +66,7 @@ extern unsigned long __start_syscalls_metadata[];
 extern unsigned long __stop_syscalls_metadata[];
 
 static struct syscall_metadata **syscalls_metadata;
+static struct syscall_metadata **compat_syscalls_metadata;
 
 static struct syscall_metadata *find_syscall_meta(unsigned long syscall)
 {
@@ -84,8 +86,14 @@ static struct syscall_metadata *find_syscall_meta(unsigned long syscall)
 	return NULL;
 }
 
-static struct syscall_metadata *syscall_nr_to_meta(int nr)
+static struct syscall_metadata *syscall_nr_to_meta(int nr, int compat)
 {
+	if (compat) {
+		if (!compat_syscalls_metadata || nr >= NR_syscalls_compat ||
+									nr < 0)
+			return NULL;
+		return compat_syscalls_metadata[nr];
+	}
 	if (!syscalls_metadata || nr >= NR_syscalls || nr < 0)
 		return NULL;
 
@@ -104,7 +112,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 
 	trace = (typeof(trace))ent;
 	syscall = trace->nr;
-	entry = syscall_nr_to_meta(syscall);
+	entry = syscall_nr_to_meta(syscall, trace->compat);
 
 	if (!entry)
 		goto end;
@@ -158,7 +166,7 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 
 	trace = (typeof(trace))ent;
 	syscall = trace->nr;
-	entry = syscall_nr_to_meta(syscall);
+	entry = syscall_nr_to_meta(syscall, trace->compat);
 
 	if (!entry) {
 		trace_seq_printf(s, "\n");
@@ -293,12 +301,16 @@ void ftrace_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	struct ring_buffer *buffer;
 	int size;
 	int syscall_nr;
+	int compat = 0;
 
 	syscall_nr = syscall_get_nr(current, regs);
 	if (syscall_nr < 0)
 		return;
 
-	sys_data = syscall_nr_to_meta(syscall_nr);
+	if (is_compat_task())
+		compat = 1;
+
+	sys_data = syscall_nr_to_meta(syscall_nr, compat);
 	if (!sys_data)
 		return;
 
@@ -314,6 +326,7 @@ void ftrace_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 	entry = ring_buffer_event_data(event);
 	entry->nr = syscall_nr;
+	entry->compat = compat;
 	syscall_get_arguments(current, regs, 0, sys_data->nb_args, entry->args);
 
 	if (!filter_current_check_discard(buffer, sys_data->enter_event,
@@ -328,12 +341,16 @@ void ftrace_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
 	int syscall_nr;
+	int compat = 0;
 
 	syscall_nr = syscall_get_nr(current, regs);
 	if (syscall_nr < 0)
 		return;
 
-	sys_data = syscall_nr_to_meta(syscall_nr);
+	if (is_compat_task())
+		compat = 1;
+
+	sys_data = syscall_nr_to_meta(syscall_nr, compat);
 	if (!sys_data)
 		return;
 
@@ -347,6 +364,7 @@ void ftrace_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 
 	entry = ring_buffer_event_data(event);
 	entry->nr = syscall_nr;
+	entry->compat = compat;
 	entry->ret = syscall_get_return_value(current, regs);
 
 	if (!filter_current_check_discard(buffer, sys_data->exit_event,
@@ -485,7 +503,49 @@ int __init init_ftrace_syscalls(void)
 		meta->syscall_nr = i;
 		syscalls_metadata[i] = meta;
 	}
-
+#ifdef __HAVE_ARCH_FTRACE_COMPAT_SYSCALLS
+	if (NR_syscalls_compat) {
+		int match;
+		struct ftrace_event_call *ftrace_event;
+
+		compat_syscalls_metadata = kzalloc(sizeof(*syscalls_metadata) *
+						NR_syscalls_compat, GFP_KERNEL);
+		if (!compat_syscalls_metadata) {
+			WARN_ON(1);
+			kfree(syscalls_metadata);
+			return -ENOMEM;
+		}
+		for (i = 0; i < NR_syscalls_compat; i++) {
+			addr = arch_compat_syscall_addr(i);
+			meta = find_syscall_meta(addr);
+			if (!meta)
+				continue;
+
+			meta->compat_syscall_nr = i;
+			compat_syscalls_metadata[i] = meta;
+		}
+		/* now check if any compat_syscalls are not referenced */
+		for (ftrace_event = __start_ftrace_events;
+			(unsigned long)ftrace_event <
+			(unsigned long)__stop_ftrace_events; ftrace_event++) {
+
+			match = 0;
+			if (!ftrace_event->name)
+				continue;
+			if (strcmp(ftrace_event->class->system, "compat_syscalls"))
+				continue;
+			for (i = 0; i < NR_syscalls_compat; i++) {
+				if (ftrace_event->data ==
+						compat_syscalls_metadata[i]) {
+					match = 1;
+					break;
+				}
+			}
+			if (!match)
+				ftrace_event->name = NULL;
+		}
+	}
+#endif
 	return 0;
 }
 core_initcall(init_ftrace_syscalls);
@@ -503,9 +563,13 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	int syscall_nr;
 	int rctx;
 	int size;
+	int compat = 0;
 
 	syscall_nr = syscall_get_nr(current, regs);
-	sys_data = syscall_nr_to_meta(syscall_nr);
+	if (is_compat_task())
+		compat = 1;
+
+	sys_data = syscall_nr_to_meta(syscall_nr, compat);
 	if (!sys_data)
 		return;
 
@@ -527,6 +591,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		return;
 
 	rec->nr = syscall_nr;
+	rec->compat = compat;
 	syscall_get_arguments(current, regs, 0, sys_data->nb_args,
 			       (unsigned long *)&rec->args);
 
@@ -577,9 +642,13 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	int syscall_nr;
 	int rctx;
 	int size;
+	int compat = 0;
 
 	syscall_nr = syscall_get_nr(current, regs);
-	sys_data = syscall_nr_to_meta(syscall_nr);
+	if (is_compat_task())
+		compat = 1;
+
+	sys_data = syscall_nr_to_meta(syscall_nr, compat);
 	if (!sys_data)
 		return;
 
@@ -604,6 +673,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 		return;
 
 	rec->nr = syscall_nr;
+	rec->compat = compat;
 	rec->ret = syscall_get_return_value(current, regs);
 
 	head = this_cpu_ptr(sys_data->exit_event->perf_events);
-- 
1.7.1
