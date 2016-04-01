Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbmv10G0DzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 14:23:56 +1100 (AEDT)
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 00:23:52 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 79C133520070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 23:23:38 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u312NrJa29557104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 23:23:54 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u313NmI2014336
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 23:23:48 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] ftrace: filter: Match dot symbols when searching functions on
 ppc64.
Date: Fri,  1 Apr 2016 00:22:52 -0300
Message-Id: <1459480972-20238-1-git-send-email-bauerman@linux.vnet.ibm.com>
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
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ftrace.h |  9 +++++++++
 kernel/trace/ftrace.c             | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 50ca7585abe2..68f1858796c6 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -58,6 +58,15 @@ struct dyn_arch_ftrace {
 	struct module *mod;
 };
 #endif /*  CONFIG_DYNAMIC_FTRACE */
+
+#if CONFIG_PPC64 && (!defined(_CALL_ELF) || _CALL_ELF != 2)
+#define ARCH_HAS_FTRACE_MATCH_ADJUST
+static inline void arch_ftrace_match_adjust(char **str, char *search)
+{
+	if ((*str)[0] == '.' && search[0] != '.')
+		(*str)++;
+}
+#endif /* CONFIG_PPC64 && (!defined(_CALL_ELF) || _CALL_ELF != 2) */
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b1870fbd2b67..e806c2a3b7a8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3444,11 +3444,24 @@ struct ftrace_glob {
 	int type;
 };
 
+#ifndef ARCH_HAS_FTRACE_MATCH_ADJUST
+/*
+ * If symbols in an architecture don't correspond exactly to the user-visible
+ * name of what they represent, it is possible to define this function to
+ * perform the necessary adjustments.
+*/
+static inline void arch_ftrace_match_adjust(char **str, char *search)
+{
+}
+#endif
+
 static int ftrace_match(char *str, struct ftrace_glob *g)
 {
 	int matched = 0;
 	int slen;
 
+	arch_ftrace_match_adjust(&str, g->search);
+
 	switch (g->type) {
 	case MATCH_FULL:
 		if (strcmp(str, g->search) == 0)
-- 
1.9.1
