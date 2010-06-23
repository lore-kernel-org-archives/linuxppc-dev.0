Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 16465100801
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:43 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA4dI0025383
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:39 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4gGx1347822
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:42 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4fOr018056
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:42 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 38/40] trace syscalls: Remove redundant test for unmapped
	compat syscalls
Date: Wed, 23 Jun 2010 20:03:19 +1000
Message-Id: <1277287401-28571-39-git-send-email-imunsie@au1.ibm.com>
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

Since the ftrace event initialisation routine now verifies that either
the syscall number or the compat syscall number is valid and will not
create events for unmapped syscalls, it is unnecessary to explicitly
search for them, so remove it.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 kernel/trace/trace_syscalls.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index c0041e3..108c2eb 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -528,26 +528,6 @@ int __init init_ftrace_syscalls(void)
 			meta->compat_syscall_nr = i;
 			compat_syscalls_metadata[i] = meta;
 		}
-		/* now check if any compat_syscalls are not referenced */
-		for (ftrace_event = __start_ftrace_events;
-			(unsigned long)ftrace_event <
-			(unsigned long)__stop_ftrace_events; ftrace_event++) {
-
-			match = 0;
-			if (!ftrace_event->name)
-				continue;
-			if (strcmp(ftrace_event->class->system, "compat_syscalls"))
-				continue;
-			for (i = 0; i < NR_syscalls_compat; i++) {
-				if (ftrace_event->data ==
-						compat_syscalls_metadata[i]) {
-					match = 1;
-					break;
-				}
-			}
-			if (!match)
-				ftrace_event->name = NULL;
-		}
 	}
 #endif
 	return 0;
-- 
1.7.1
