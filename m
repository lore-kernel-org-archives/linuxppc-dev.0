Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A272B7618
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:24 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA4MZ4001291
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4OlM1060868
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:24 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4NAp005073
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:24 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 19/40] trace syscalls: Remove redundant syscall_nr checks
Date: Wed, 23 Jun 2010 20:03:00 +1000
Message-Id: <1277287401-28571-20-git-send-email-imunsie@au1.ibm.com>
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

With the ftrace events now checking if the syscall_nr is valid upon
initialisation, there is no need to verify it when registering and
unregistering the events, so remove the check.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 kernel/trace/trace_syscalls.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 6acba20..9010405 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -391,11 +391,7 @@ void ftrace_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 int reg_event_syscall_enter(struct ftrace_event_call *call)
 {
 	int ret = 0;
-	int num;
 
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
-	if (num < 0 || num >= NR_syscalls)
-		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_refcount_enter)
 		ret = register_trace_sys_enter(ftrace_syscall_enter, NULL);
@@ -409,11 +405,6 @@ int reg_event_syscall_enter(struct ftrace_event_call *call)
 
 void unreg_event_syscall_enter(struct ftrace_event_call *call)
 {
-	int num;
-
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
-	if (num < 0 || num >= NR_syscalls)
-		return;
 	mutex_lock(&syscall_trace_lock);
 	sys_refcount_enter--;
 	((struct syscall_metadata *)call->data)->ftrace_enter = 0;
@@ -425,11 +416,7 @@ void unreg_event_syscall_enter(struct ftrace_event_call *call)
 int reg_event_syscall_exit(struct ftrace_event_call *call)
 {
 	int ret = 0;
-	int num;
 
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
-	if (num < 0 || num >= NR_syscalls)
-		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_refcount_exit)
 		ret = register_trace_sys_exit(ftrace_syscall_exit, NULL);
@@ -443,11 +430,6 @@ int reg_event_syscall_exit(struct ftrace_event_call *call)
 
 void unreg_event_syscall_exit(struct ftrace_event_call *call)
 {
-	int num;
-
-	num = ((struct syscall_metadata *)call->data)->syscall_nr;
-	if (num < 0 || num >= NR_syscalls)
-		return;
 	mutex_lock(&syscall_trace_lock);
 	sys_refcount_exit--;
 	((struct syscall_metadata *)call->data)->ftrace_exit = 0;
-- 
1.7.1
