Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7170B7E74
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 17:44:05 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4D7iHR0000409
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2010 17:44:17 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4D7aucp1306710
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2010 17:36:56 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4D7i3Xa001669
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2010 17:44:04 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ftrace syscalls: Make arch_syscall_addr weak
Date: Thu, 13 May 2010 17:43:12 +1000
Message-Id: <1273736594-19320-3-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1273736594-19320-1-git-send-email-imunsie@au1.ibm.com>
References: <1273736594-19320-1-git-send-email-imunsie@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Some architectures use non-trivial system call tables and will not work
with the generic arch_syscall_addr code. For example, PowerPC64 uses a
table of twin long longs.

This patch makes the generic arch_syscall_addr weak to allow
architectures with non-trivial system call tables to override it.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 Documentation/trace/ftrace-design.txt |    3 +++
 kernel/trace/trace_syscalls.c         |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/trace/ftrace-design.txt b/Documentation/trace/ftrace-design.txt
index f1f81af..8369a1c 100644
--- a/Documentation/trace/ftrace-design.txt
+++ b/Documentation/trace/ftrace-design.txt
@@ -244,6 +244,9 @@ You need very few things to get the syscalls tracing in an arch.
 - Support the TIF_SYSCALL_TRACEPOINT thread flags.
 - Put the trace_sys_enter() and trace_sys_exit() tracepoints calls from ptrace
   in the ptrace syscalls tracing path.
+- If the system call table on this arch is more complicated than a simple array
+  of addresses of the system calls, implement an arch_syscall_addr to return
+  the address of a given system call.
 - Tag this arch as HAVE_SYSCALL_TRACEPOINTS.
 
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 732f021..1c231d0 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -403,7 +403,7 @@ int init_syscall_trace(struct ftrace_event_call *call)
 	return id;
 }
 
-unsigned long __init arch_syscall_addr(int nr)
+unsigned long __init __weak arch_syscall_addr(int nr)
 {
 	return (unsigned long)sys_call_table[nr];
 }
-- 
1.7.1
