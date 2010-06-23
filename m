Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0C05B71A6
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:03 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA40Ln024944
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:00 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA432k1544194
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:03 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA42xl007111
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:03 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 01/40] ftrace syscalls: don't add events for unmapped syscalls
Date: Wed, 23 Jun 2010 20:02:42 +1000
Message-Id: <1277287401-28571-2-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

FTRACE_SYSCALLS would create events for each and every system call, even
if it had failed to map the system call's name with it's number. This
resulted in a number of events being created that would not behave as
expected.

This could happen, for example, on architectures who's symbol names are
unusual and will not match the system call name. It could also happen
with system calls which were mapped to sys_ni_syscall.

This patch changes the default system call number in the metadata to -1.
If the system call name from the metadata is not successfully mapped to
a system call number during boot, than the event initialisation routine
will now return an error, preventing the event from being created.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 include/linux/syscalls.h      |    2 ++
 kernel/trace/trace_syscalls.c |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7f614ce..86f082b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -159,6 +159,7 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 	  __attribute__((section("__syscalls_metadata")))	\
 	  __syscall_meta_##sname = {				\
 		.name 		= "sys"#sname,			\
+		.syscall_nr	= -1,	/* Filled in at boot */	\
 		.nb_args 	= nb,				\
 		.types		= types_##sname,		\
 		.args		= args_##sname,			\
@@ -176,6 +177,7 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 	  __attribute__((section("__syscalls_metadata")))	\
 	  __syscall_meta__##sname = {				\
 		.name 		= "sys_"#sname,			\
+		.syscall_nr	= -1,	/* Filled in at boot */	\
 		.nb_args 	= 0,				\
 		.enter_event	= &event_enter__##sname,	\
 		.exit_event	= &event_exit__##sname,		\
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 34e3580..82246ce 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -431,6 +431,14 @@ void unreg_event_syscall_exit(struct ftrace_event_call *call)
 int init_syscall_trace(struct ftrace_event_call *call)
 {
 	int id;
+	int num;
+
+	num = ((struct syscall_metadata *)call->data)->syscall_nr;
+	if (num < 0 || num >= NR_syscalls) {
+		pr_debug("syscall %s metadata not mapped, disabling ftrace event\n",
+				((struct syscall_metadata *)call->data)->name);
+		return -ENOSYS;
+	}
 
 	if (set_syscall_print_fmt(call) < 0)
 		return -ENOMEM;
-- 
1.7.1
