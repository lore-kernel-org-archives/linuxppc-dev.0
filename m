Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90857B75C9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:26 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA4Mhn025191
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:22 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4PcO458826
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:25 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4N3h027929
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:25 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 20/40] trace syscalls: Considder compat_syscall_nr when
	verifying syscall_nr
Date: Wed, 23 Jun 2010 20:03:01 +1000
Message-Id: <1277287401-28571-21-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
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

With the new compat syscall tracing, either syscall_nr or
compat_syscall_nr may be set, so test both before assuming that the
initialisation failed.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 kernel/trace/trace_syscalls.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 9010405..264441e 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -441,10 +441,12 @@ void unreg_event_syscall_exit(struct ftrace_event_call *call)
 int init_syscall_trace(struct ftrace_event_call *call)
 {
 	int id;
-	int num;
+	int num, compat_num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
-	if (num < 0 || num >= NR_syscalls) {
+	compat_num = ((struct syscall_metadata *)call->data)->compat_syscall_nr;
+	if ((       num < 0 ||        num >= NR_syscalls) &&
+	    (compat_num < 0 || compat_num >= NR_syscalls)) {
 		pr_debug("syscall %s metadata not mapped, disabling ftrace event\n",
 				((struct syscall_metadata *)call->data)->name);
 		return -ENOSYS;
-- 
1.7.1
