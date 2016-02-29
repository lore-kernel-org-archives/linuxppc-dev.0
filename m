Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FD391A033A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 20:26:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH v2 5/8] powerpc/ftrace: Use generic ftrace_modify_all_code()
Date: Mon, 29 Feb 2016 20:26:26 +1100
Message-Id: <1456737989-8755-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
References: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Torsten Duwe <duwe@lst.de>

Convert powerpc's arch_ftrace_update_code() from its own version to use
the generic default functionality (without stop_machine -- our
instructions are properly aligned and the replacements atomic).

With this we gain error checking and the much-needed function_trace_op
handling.

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

v2: No change.

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 4505cbfd0e13..62899fbae703 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -449,20 +449,13 @@ void ftrace_replace_code(int enable)
 	}
 }
 
+/*
+ * Use the default ftrace_modify_all_code, but without
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
2.5.0
