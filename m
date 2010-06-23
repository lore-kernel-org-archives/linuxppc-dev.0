Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C69EB70ED
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:43 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA4lAA006752
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:47 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4g591298682
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:42 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4e70005687
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:42 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 36/40] trace syscalls: Early terminate search for
	sys_ni_syscall
Date: Wed, 23 Jun 2010 20:03:17 +1000
Message-Id: <1277287401-28571-37-git-send-email-imunsie@au1.ibm.com>
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

Many system calls are unimplemented and mapped to sys_ni_syscall, but at
boot ftrace would still search through every syscall metadata entry for
a match which wouldn't be there.

This patch adds causes the search to terminate early if the system call
is not mapped.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 kernel/trace/trace_syscalls.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 264441e..58ef002 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -95,6 +95,9 @@ static struct syscall_metadata *find_syscall_meta(unsigned long syscall)
 	stop = (struct syscall_metadata *)__stop_syscalls_metadata;
 	kallsyms_lookup(syscall, NULL, NULL, NULL, str);
 
+	if (arch_syscall_match_sym_name(str, "sys_ni_syscall"))
+		return NULL;
+
 	for ( ; start < stop; start++) {
 		if (start->name && arch_syscall_match_sym_name(str, start->name))
 			return start;
-- 
1.7.1
