Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW3Tw2qF4zDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 22:04:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 3/6] livepatch: Allow architectures to specify an alternate
 ftrace location
Date: Thu, 24 Mar 2016 22:04:02 +1100
Message-Id: <1458817445-5855-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When livepatch tries to patch a function it takes the function address
and asks ftrace to install the livepatch handler at that location.
ftrace will look for an mcount call site at that exact address.

On powerpc the mcount location is not the first instruction of the
function, and in fact it's not at a constant offset from the start of
the function. To accommodate this add a hook which arch code can
override to customise the behaviour.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/livepatch/core.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index d68fbf63b083..b0476bb30f92 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -298,6 +298,19 @@ unlock:
 	rcu_read_unlock();
 }
 
+/*
+ * Convert a function address into the appropriate ftrace location.
+ *
+ * Usually this is just the address of the function, but on some architectures
+ * it's more complicated so allow them to provide a custom behaviour.
+ */
+#ifndef klp_get_ftrace_location
+static unsigned long klp_get_ftrace_location(unsigned long faddr)
+{
+	return faddr;
+}
+#endif
+
 static void klp_disable_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
@@ -312,8 +325,14 @@ static void klp_disable_func(struct klp_func *func)
 		return;
 
 	if (list_is_singular(&ops->func_stack)) {
+		unsigned long ftrace_loc;
+
+		ftrace_loc = klp_get_ftrace_location(func->old_addr);
+		if (WARN_ON(!ftrace_loc))
+			return;
+
 		WARN_ON(unregister_ftrace_function(&ops->fops));
-		WARN_ON(ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0));
+		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
 
 		list_del_rcu(&func->stack_node);
 		list_del(&ops->node);
@@ -338,6 +357,15 @@ static int klp_enable_func(struct klp_func *func)
 
 	ops = klp_find_ops(func->old_addr);
 	if (!ops) {
+		unsigned long ftrace_loc;
+
+		ftrace_loc = klp_get_ftrace_location(func->old_addr);
+		if (!ftrace_loc) {
+			pr_err("failed to find location for function '%s'\n",
+				func->old_name);
+			return -EINVAL;
+		}
+
 		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 		if (!ops)
 			return -ENOMEM;
@@ -352,7 +380,7 @@ static int klp_enable_func(struct klp_func *func)
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 
-		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
+		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
 		if (ret) {
 			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
 			       func->old_name, ret);
@@ -363,7 +391,7 @@ static int klp_enable_func(struct klp_func *func)
 		if (ret) {
 			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
 			       func->old_name, ret);
-			ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
+			ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0);
 			goto err;
 		}
 
-- 
2.5.0
