Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43100B7519
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:19 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA0UW7022008
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:00:30 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4INd1478840
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:18 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4H5Q007401
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:18 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 13/40] syscalls: add new COMPAT_SYSCALL_DEFINE#N() macro
Date: Wed, 23 Jun 2010 20:02:54 +1000
Message-Id: <1277287401-28571-14-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jason Baron <jbaron@redhat.com>

Add COMPAT_SYSCALL_DEFINE#N() macro define common compat syscalls that
are not arch specific. Prepends "compat_sys_" to the syscall name to identify
it.

Signed-off-by: Jason Baron <jbaron@redhat.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 include/linux/syscalls.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d7096ab..a7d1114 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -213,6 +213,13 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 #define ARCH_COMPAT_SYSCALL_DEFINE5(name, ...) COMPAT_SYSCALL_DEFINEx(5, sys32_##name, name, __VA_ARGS__)
 #define ARCH_COMPAT_SYSCALL_DEFINE6(name, ...) COMPAT_SYSCALL_DEFINEx(6, sys32_##name, name, __VA_ARGS__)
 
+#define COMPAT_SYSCALL_DEFINE1(name, ...) COMPAT_SYSCALL_DEFINEx(1, compat_sys_##name, name, __VA_ARGS__)
+#define COMPAT_SYSCALL_DEFINE2(name, ...) COMPAT_SYSCALL_DEFINEx(2, compat_sys_##name, name, __VA_ARGS__)
+#define COMPAT_SYSCALL_DEFINE3(name, ...) COMPAT_SYSCALL_DEFINEx(3, compat_sys_##name, name, __VA_ARGS__)
+#define COMPAT_SYSCALL_DEFINE4(name, ...) COMPAT_SYSCALL_DEFINEx(4, compat_sys_##name, name, __VA_ARGS__)
+#define COMPAT_SYSCALL_DEFINE5(name, ...) COMPAT_SYSCALL_DEFINEx(5, compat_sys_##name, name, __VA_ARGS__)
+#define COMPAT_SYSCALL_DEFINE6(name, ...) COMPAT_SYSCALL_DEFINEx(6, compat_sys_##name, name, __VA_ARGS__)
+
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define COMPAT_SYSCALL_DEFINEx(x, syscall, sname, ...)		\
 	static const char *types_compat_sys_##sname[] = {	\
-- 
1.7.1
