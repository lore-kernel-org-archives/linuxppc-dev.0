Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB80EB7503
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:18 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA0laP020301
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:00:47 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4IIc1319084
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:18 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4GRv027741
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:18 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 11/40] syscalls: add ARCH_COMPAT_SYSCALL_DEFINE()
Date: Wed, 23 Jun 2010 20:02:52 +1000
Message-Id: <1277287401-28571-12-git-send-email-imunsie@au1.ibm.com>
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

Add ARCH_COMPAT_SYSCALL_DEFINE#N() macro which prepends "sys32_" to
arch specific compat syscall names. Identifies the 'compat' syscalls.

Signed-off-by: Jason Baron <jbaron@redhat.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 include/linux/syscalls.h |   50 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 755d05b..d7096ab 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -131,7 +131,7 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 	  __attribute__((__aligned__(4)))				\
 	  __attribute__((section("_ftrace_events")))			\
 	  event_enter_##sname = {					\
-		.name                   = "sys_enter"#sname,		\
+		.name                   = "enter_"#sname,		\
 		.class			= &event_class_syscall_enter,	\
 		.event.funcs            = &enter_syscall_print_funcs,	\
 		.data			= (void *)&__syscall_meta_##sname,\
@@ -145,20 +145,20 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 	  __attribute__((__aligned__(4)))				\
 	  __attribute__((section("_ftrace_events")))			\
 	  event_exit_##sname = {					\
-		.name                   = "sys_exit"#sname,		\
+		.name                   = "exit_"#sname,		\
 		.class			= &event_class_syscall_exit,	\
 		.event.funcs		= &exit_syscall_print_funcs,	\
 		.data			= (void *)&__syscall_meta_##sname,\
 	}
 
-#define SYSCALL_METADATA(sname, nb)				\
+#define SYSCALL_METADATA(rname, sname, nb)			\
 	SYSCALL_TRACE_ENTER_EVENT(sname);			\
 	SYSCALL_TRACE_EXIT_EVENT(sname);			\
 	static struct syscall_metadata __used			\
 	  __attribute__((__aligned__(4)))			\
 	  __attribute__((section("__syscalls_metadata")))	\
 	  __syscall_meta_##sname = {				\
-		.name 		= "sys"#sname,			\
+		.name 		= #rname,			\
 		.syscall_nr	= -1,	/* Filled in at boot */	\
 		.nb_args 	= nb,				\
 		.types		= types_##sname,		\
@@ -174,12 +174,12 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 	};
 
 #define SYSCALL_DEFINE0(sname)					\
-	SYSCALL_TRACE_ENTER_EVENT(_##sname);			\
-	SYSCALL_TRACE_EXIT_EVENT(_##sname);			\
+	SYSCALL_TRACE_ENTER_EVENT(sys_##sname);			\
+	SYSCALL_TRACE_EXIT_EVENT(sys_##sname);			\
 	static struct syscall_metadata __used			\
 	  __attribute__((__aligned__(4)))			\
 	  __attribute__((section("__syscalls_metadata")))	\
-	  __syscall_meta__##sname = {				\
+	  __syscall_meta_sys_##sname = {			\
 		.name 		= "sys_"#sname,			\
 		.syscall_nr	= -1,	/* Filled in at boot */	\
 		.nb_args 	= 0,				\
@@ -187,8 +187,8 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 		.ftrace_exit	= 0,				\
 		.perf_enter	= 0,				\
 		.perf_exit	= 0,				\
-		.enter_event	= &event_enter__##sname,	\
-		.exit_event	= &event_exit__##sname,		\
+		.enter_event	= &event_enter_sys_##sname,	\
+		.exit_event	= &event_exit_sys_##sname,	\
 		.enter_fields	= LIST_HEAD_INIT(__syscall_meta__##sname.enter_fields), \
 		.exit_fields	= LIST_HEAD_INIT(__syscall_meta__##sname.exit_fields), \
 	};							\
@@ -204,6 +204,32 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
 
+#ifdef CONFIG_COMPAT
+
+#define ARCH_COMPAT_SYSCALL_DEFINE1(name, ...) COMPAT_SYSCALL_DEFINEx(1, sys32_##name, name, __VA_ARGS__)
+#define ARCH_COMPAT_SYSCALL_DEFINE2(name, ...) COMPAT_SYSCALL_DEFINEx(2, sys32_##name, name, __VA_ARGS__)
+#define ARCH_COMPAT_SYSCALL_DEFINE3(name, ...) COMPAT_SYSCALL_DEFINEx(3, sys32_##name, name, __VA_ARGS__)
+#define ARCH_COMPAT_SYSCALL_DEFINE4(name, ...) COMPAT_SYSCALL_DEFINEx(4, sys32_##name, name, __VA_ARGS__)
+#define ARCH_COMPAT_SYSCALL_DEFINE5(name, ...) COMPAT_SYSCALL_DEFINEx(5, sys32_##name, name, __VA_ARGS__)
+#define ARCH_COMPAT_SYSCALL_DEFINE6(name, ...) COMPAT_SYSCALL_DEFINEx(6, sys32_##name, name, __VA_ARGS__)
+
+#ifdef CONFIG_FTRACE_SYSCALLS
+#define COMPAT_SYSCALL_DEFINEx(x, syscall, sname, ...)		\
+	static const char *types_compat_sys_##sname[] = {	\
+		__SC_STR_TDECL##x(__VA_ARGS__)			\
+	};							\
+	static const char *args_compat_sys_##sname[] = {	\
+		__SC_STR_ADECL##x(__VA_ARGS__)			\
+	};							\
+	SYSCALL_METADATA(syscall, compat_sys_##sname, x);	\
+	asmlinkage long syscall(__SC_DECL##x(__VA_ARGS__))
+#else
+#define COMPAT_SYSCALL_DEFINEx(x, syscall, sname, ...)		\
+	asmlinkage long syscall(__SC_DECL##x(__VA_ARGS__))
+#endif
+
+#endif
+
 #ifdef CONFIG_PPC64
 #define SYSCALL_ALIAS(alias, name)					\
 	asm ("\t.globl " #alias "\n\t.set " #alias ", " #name "\n"	\
@@ -220,13 +246,13 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define SYSCALL_DEFINEx(x, sname, ...)				\
-	static const char *types_##sname[] = {			\
+	static const char *types_sys##sname[] = {		\
 		__SC_STR_TDECL##x(__VA_ARGS__)			\
 	};							\
-	static const char *args_##sname[] = {			\
+	static const char *args_sys##sname[] = {		\
 		__SC_STR_ADECL##x(__VA_ARGS__)			\
 	};							\
-	SYSCALL_METADATA(sname, x);				\
+	SYSCALL_METADATA(sys##sname, sys##sname, x);		\
 	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
 #else
 #define SYSCALL_DEFINEx(x, sname, ...)				\
-- 
1.7.1
