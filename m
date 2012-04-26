Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 8B2DDB6FAB
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2012 04:35:13 +1000 (EST)
Message-Id: <20120426183508.749515835@goodmis.org>
Date: Thu, 26 Apr 2012 14:31:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3][RFC] ftrace/ppc: Have PPC skip updating with
 stop_machine()
References: <20120426183116.857877522@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Steven Rostedt <srostedt@redhat.com>

PPC does not have the synchronization issues that x86 has with
modifying code on one CPU while another CPU is executing it.
The other CPU will either see the old or new code without any
issues, unlike x86 which may issue a GPF.

Instead of calling the heavy stop_machine, just update the code.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/kernel/ftrace.c |   52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index bf99cfa..84a5ddd 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -484,6 +484,58 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ret;
 }
 
+static int __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
+{
+	unsigned long ftrace_addr = (unsigned long)FTRACE_ADDR;
+	int ret;
+
+	ret = ftrace_update_record(rec, enable);
+
+	switch (ret) {
+	case FTRACE_UPDATE_IGNORE:
+		return 0;
+	case FTRACE_UPDATE_MAKE_CALL:
+		return ftrace_make_call(rec, ftrace_addr);
+	case FTRACE_UPDATE_MAKE_NOP:
+		return ftrace_make_nop(NULL, rec, ftrace_addr);
+	}
+
+	return 0;
+}
+
+static void ftrace_replace_code(int enable)
+{
+	struct ftrace_rec_iter *iter;
+	struct dyn_ftrace *rec;
+	int ret;
+
+	for (iter = ftrace_rec_iter_start(); iter;
+	     iter = ftrace_rec_iter_next(iter)) {
+		rec = ftrace_rec_iter_record(iter);
+		ret = __ftrace_replace_code(rec, enable);
+		if (ret) {
+			ftrace_bug(ret, rec->ip);
+			return;
+		}
+	}
+}
+
+void arch_ftrace_update_code(int command)
+{
+	if (command & FTRACE_UPDATE_CALLS)
+		ftrace_replace_code(1);
+	else if (command & FTRACE_DISABLE_CALLS)
+		ftrace_replace_code(0);
+
+	if (command & FTRACE_UPDATE_TRACE_FUNC)
+		ftrace_update_ftrace_func(ftrace_trace_function);
+
+	if (command & FTRACE_START_FUNC_RET)
+		ftrace_enable_ftrace_graph_caller();
+	else if (command & FTRACE_STOP_FUNC_RET)
+		ftrace_disable_ftrace_graph_caller();
+}
+
 int __init ftrace_dyn_arch_init(void *data)
 {
 	/* caller expects data to be zero */
-- 
1.7.9.5
