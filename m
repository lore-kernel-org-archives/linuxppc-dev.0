Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE2511A0272
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 03:20:54 +1100 (AEDT)
In-Reply-To: <20160204161527.5F3AC692CD@newverein.lst.de>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Mon, 25 Jan 2016 16:29:08 +0100
Subject: [PATCH v7 03/10] ppc use ftrace_modify_all_code default
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20160204162048.76562692D7@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert ppc's arch_ftrace_update_code from its own function copy
to use the generic default functionality (without stop_machine --
our instructions are properly aligned and the replacements atomic ;)

With this we gain error checking and the much-needed function_trace_op
handling.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/kernel/ftrace.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 1fad1b3..ef8b916 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -531,20 +531,12 @@ void ftrace_replace_code(int enable)
 	}
 }
 
+/* Use the default ftrace_modify_all_code, but without
+ * stop_machine().
+ */
 void arch_ftrace_update_code(int command)
 {
-	if (command & FTRACE_UPDATE_CALLS)
-		ftrace_replace_code(1);
-	else if (command & FTRACE_DISABLE_CALLS)
-		ftrace_replace_code(0);
-
-	if (command & FTRACE_UPDATE_TRACE_FUNC)
-		ftrace_update_ftrace_func(ftrace_trace_function);
-
-	if (command & FTRACE_START_FUNC_RET)
-		ftrace_enable_ftrace_graph_caller();
-	else if (command & FTRACE_STOP_FUNC_RET)
-		ftrace_disable_ftrace_graph_caller();
+	ftrace_modify_all_code(command);
 }
 
 int __init ftrace_dyn_arch_init(void)
-- 
1.8.5.6
