Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E900FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Mar 2022 08:03:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KPvjt3Fszz30Nj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Mar 2022 19:03:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KPvjR67V8z2yxS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2022 19:03:21 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4KPvjL23cSz9sRq;
 Fri, 25 Mar 2022 09:03:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bgz314D1biRI; Fri, 25 Mar 2022 09:03:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4KPvjL16jBz9sRn;
 Fri, 25 Mar 2022 09:03:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 11A508B780;
 Fri, 25 Mar 2022 09:03:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id W7T8NCjv481w; Fri, 25 Mar 2022 09:03:17 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DCF308B763;
 Fri, 25 Mar 2022 09:03:17 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22P838xt1938379
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Mar 2022 09:03:09 +0100
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22P838rI1938378;
 Fri, 25 Mar 2022 09:03:08 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2] ftrace: Make ftrace_graph_is_dead() a static branch
Date: Fri, 25 Mar 2022 09:03:08 +0100
Message-Id: <8628338322fa74287ca8d432d5c0c1964acd6f2a.1648195329.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648195387; l=3391; s=20211009;
 h=from:subject:message-id; bh=aDg2tLJ31D9Fssnue1+3mTD1ZvJRLunpzUIjiG3Tp+U=;
 b=6M11MNmE57VZlDVfkH/7QjX25JLUjqLLvueXJDxGpryW7KJXnECXnaDypvSTvOCukMz4Chc2GdqX
 pa1MChfWB8xFBthSd6ZauqKLw5XtIKW4i4ynxmv/dTv0m23Lq21x
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519;
 pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ftrace_graph_is_dead() is used on hot paths, it just reads a variable
in memory and is not worth suffering function call constraints.

For instance, at entry of prepare_ftrace_return(), inlining it avoids
saving prepare_ftrace_return() parameters to stack and restoring them
after calling ftrace_graph_is_dead().

While at it using a static branch is even more performant and is
rather well adapted considering that the returned value will almost
never change.

Inline ftrace_graph_is_dead() and replace 'kill_ftrace_graph' bool
by a static branch.

The performance improvement is noticeable.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Use a static branch instead of a global bool var.
---
 include/linux/ftrace.h | 16 +++++++++++++++-
 kernel/trace/fgraph.c  | 17 +++--------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9999e29187de..9e639e05666d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/jump_label.h>
 
 #include <asm/ftrace.h>
 
@@ -1006,7 +1007,20 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 extern int register_ftrace_graph(struct fgraph_ops *ops);
 extern void unregister_ftrace_graph(struct fgraph_ops *ops);
 
-extern bool ftrace_graph_is_dead(void);
+/**
+ * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
+ *
+ * ftrace_graph_stop() is called when a severe error is detected in
+ * the function graph tracing. This function is called by the critical
+ * paths of function graph to keep those paths from doing any more harm.
+ */
+DECLARE_STATIC_KEY_FALSE(kill_ftrace_graph);
+
+static inline bool ftrace_graph_is_dead(void)
+{
+	return static_branch_unlikely(&kill_ftrace_graph);
+}
+
 extern void ftrace_graph_stop(void);
 
 /* The current handlers in use */
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 22061d38fc00..15acd48f0718 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -10,6 +10,7 @@
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
 #include <linux/slab.h>
+#include <linux/jump_label.h>
 
 #include <trace/events/sched.h>
 
@@ -23,24 +24,12 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
-static bool kill_ftrace_graph;
+DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
-/**
- * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
- *
- * ftrace_graph_stop() is called when a severe error is detected in
- * the function graph tracing. This function is called by the critical
- * paths of function graph to keep those paths from doing any more harm.
- */
-bool ftrace_graph_is_dead(void)
-{
-	return kill_ftrace_graph;
-}
-
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
  *
@@ -51,7 +40,7 @@ bool ftrace_graph_is_dead(void)
  */
 void ftrace_graph_stop(void)
 {
-	kill_ftrace_graph = true;
+	static_branch_enable(&kill_ftrace_graph);
 }
 
 /* Add a function return address to the trace stack on thread info.*/
-- 
2.35.1

