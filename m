Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5EA0B7188
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:08 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA45cw024983
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:05 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA48Ci1204394
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:08 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA458V003980
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:07 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 03/40] ftrace syscalls: Allow arch specific syscall symbol
	matching
Date: Wed, 23 Jun 2010 20:02:44 +1000
Message-Id: <1277287401-28571-4-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-doc@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Randy Dunlap <rdunlap@xenotime.net>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
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

From: Ian Munsie <imunsie@au1.ibm.com>

Some architectures have unusual symbol names and the generic code to
match the symbol name with the function name for the syscall metadata
will fail. For example, symbols on PPC64 start with a period and the
generic code will fail to match them.

This patch splits out the match logic into a standalone weak function
that can be overridden on archs with unusual symbol names.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 Documentation/trace/ftrace-design.txt |    3 +++
 include/linux/ftrace.h                |    1 +
 kernel/trace/trace_syscalls.c         |   19 ++++++++++++-------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/trace/ftrace-design.txt b/Documentation/trace/ftrace-design.txt
index 8369a1c..3936d5f 100644
--- a/Documentation/trace/ftrace-design.txt
+++ b/Documentation/trace/ftrace-design.txt
@@ -247,6 +247,9 @@ You need very few things to get the syscalls tracing in an arch.
 - If the system call table on this arch is more complicated than a simple array
   of addresses of the system calls, implement an arch_syscall_addr to return
   the address of a given system call.
+- If the symbol names of the system calls do not match the function names on
+  this arch, implement an arch_syscall_match_sym_name with the appropriate
+  logic to return true if the function name corresponds with the symbol name.
 - Tag this arch as HAVE_SYSCALL_TRACEPOINTS.
 
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 41e4633..bb4914d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -522,6 +522,7 @@ extern enum ftrace_dump_mode ftrace_dump_on_oops;
 #ifdef CONFIG_FTRACE_SYSCALLS
 
 unsigned long arch_syscall_addr(int nr);
+bool arch_syscall_match_sym_name(const char *sym, const char *name);
 
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e2b657e..18f27bb 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -80,13 +80,7 @@ static struct syscall_metadata *find_syscall_meta(unsigned long syscall)
 	kallsyms_lookup(syscall, NULL, NULL, NULL, str);
 
 	for ( ; start < stop; start++) {
-		/*
-		 * Only compare after the "sys" prefix. Archs that use
-		 * syscall wrappers may have syscalls symbols aliases prefixed
-		 * with "SyS" instead of "sys", leading to an unwanted
-		 * mismatch.
-		 */
-		if (start->name && !strcmp(start->name + 3, str + 3))
+		if (start->name && arch_syscall_match_sym_name(str, start->name))
 			return start;
 	}
 	return NULL;
@@ -458,6 +452,17 @@ unsigned long __init __weak arch_syscall_addr(int nr)
 	return (unsigned long)sys_call_table[nr];
 }
 
+bool __weak arch_syscall_match_sym_name(const char *sym, const char *name)
+{
+	/*
+	 * Only compare after the "sys" prefix. Archs that use
+	 * syscall wrappers may have syscalls symbols aliases prefixed
+	 * with "SyS" instead of "sys", leading to an unwanted
+	 * mismatch.
+	 */
+	return (!strcmp(sym + 3, name + 3));
+}
+
 int __init init_ftrace_syscalls(void)
 {
 	struct syscall_metadata *meta;
-- 
1.7.1
