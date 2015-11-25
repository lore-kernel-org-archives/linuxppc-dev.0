Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AADF01A03A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 04:29:14 +1100 (AEDT)
In-Reply-To: <20151125172608.9588569260@newverein.lst.de>
References: <20151125172608.9588569260@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Wed, 25 Nov 2015 17:35:57 +0100
Subject: [PATCH v4 3/9] ppc use ftrace_modify_all_code default
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20151125172911.177E169260@newverein.lst.de>
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
index 310137f..e419c7b 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -511,20 +511,12 @@ void ftrace_replace_code(int enable)
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
