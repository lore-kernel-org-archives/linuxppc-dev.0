Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qv0Sn4FwJzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 07:57:29 +1000 (AEST)
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 25 Apr 2016 18:57:25 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 661EA352005C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 17:57:07 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3PKvF8e25100642
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 17:57:16 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3PLvIPl010335
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 18:57:19 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] ftrace: Match dot symbols when searching functions on ppc64
Date: Mon, 25 Apr 2016 18:56:14 -0300
Message-Id: <1461621374-14408-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the ppc64 big endian ABI, function symbols point to function
descriptors. The symbols which point to the function entry points
have a dot in front of the function name. Consequently, when the
ftrace filter mechanism searches for the symbol corresponding to
an entry point address, it gets the dot symbol.

As a result, ftrace filter users have to be aware of this ABI detail on
ppc64 and prepend a dot to the function name when setting the filter.

The perf probe command insulates the user from this by ignoring the dot
in front of the symbol name when matching function names to symbols,
but the sysfs interface does not. This patch makes the ftrace filter
mechanism do the same when searching symbols.

Fixes the following failure in ftracetest's kprobe_ftrace.tc:

  .../kprobe_ftrace.tc: line 9: echo: write error: Invalid argument

That failure is on this line of kprobe_ftrace.tc:

  echo _do_fork > set_ftrace_filter

This is because there's no _do_fork entry in the functions list:

  # cat available_filter_functions | grep _do_fork
  ._do_fork

This change introduces no regressions on the perf and ftracetest
testsuite results.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---

Notes:
    Changes from v1 to v2:
    - Use __weak mechanism instead of #ifdef.
    - Return modified pointer instead of changing it in the argument.

 arch/powerpc/kernel/ftrace.c | 10 ++++++++++
 kernel/trace/ftrace.c        | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 9dac18dabd03..1123a4d8d8dd 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -607,3 +607,13 @@ unsigned long __init arch_syscall_addr(int nr)
 	return sys_call_table[nr*2];
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_PPC64 */
+
+#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF != 2)
+char *arch_ftrace_match_adjust(char *str, const char *search)
+{
+	if (str[0] == '.' && search[0] != '.')
+		return str + 1;
+	else
+		return str;
+}
+#endif /* defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF != 2) */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b1870fbd2b67..a28322e3fed3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3444,11 +3444,23 @@ struct ftrace_glob {
 	int type;
 };
 
+/*
+ * If symbols in an architecture don't correspond exactly to the user-visible
+ * name of what they represent, it is possible to define this function to
+ * perform the necessary adjustments.
+*/
+char * __weak arch_ftrace_match_adjust(char *str, const char *search)
+{
+	return str;
+}
+
 static int ftrace_match(char *str, struct ftrace_glob *g)
 {
 	int matched = 0;
 	int slen;
 
+	str = arch_ftrace_match_adjust(str, g->search);
+
 	switch (g->type) {
 	case MATCH_FULL:
 		if (strcmp(str, g->search) == 0)
-- 
1.9.1
