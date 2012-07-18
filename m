Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id F120A2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 08:35:32 +1000 (EST)
Message-ID: <1342650928.11900.20.camel@gandalf.stny.rr.com>
Subject: [PATCH] powerpc/ftrace: Trace function graph entry before updating
 index
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 18 Jul 2012 18:35:28 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Colin Cross <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Colin Cross ported my x86 change to ARM, he also pointed out that
powerpc is also behind in this fix.

The commit 722b3c746953 "ftrace/graph: Trace function entry before
updating index" fixes an issue with function graph tracing for x86,
where if the called entry function decides not to trace interrupts, it
can fail the check if an interrupt comes in just after the
curr_ret_stack is updated.

The solution is to call the entry function first, then update the
curr_ret_stack if the entry function wants to be traced.

Cc: Colin Cross <ccross@android.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 91b46b7..1fb7856 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -630,18 +630,17 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 		return;
 	}
 
-	if (ftrace_push_return_trace(old, self_addr, &trace.depth, 0) == -EBUSY) {
-		*parent = old;
-		return;
-	}
-
 	trace.func = self_addr;
+	trace.depth = current->curr_ret_stack + 1;
 
 	/* Only trace if the calling function expects to */
 	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
 		*parent = old;
+		return;
 	}
+
+	if (ftrace_push_return_trace(old, self_addr, &trace.depth, 0) == -EBUSY)
+		*parent = old;
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
