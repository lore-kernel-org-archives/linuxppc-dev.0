Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C6EF72C0336
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 16:32:15 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 7 Mar 2014 15:32:11 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 387482BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 16:32:09 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s275CC9x5046538
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 16:12:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s275W855027186
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 16:32:08 +1100
Received: from neelegup-tp-t420.in.ibm.com ([9.124.88.165])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s275W5EX027158
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 16:32:07 +1100
Subject: [PATCH] powerpc/powernv: Infrastructure to support OPAL async
 completion
To: linuxppc-dev@lists.ozlabs.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Fri, 07 Mar 2014 11:00:24 +0530
Message-ID: <20140307053010.3365.28513.stgit@neelegup-tp-t420.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for notifying the clients of their request
completion. Clients request for the token before making OPAL call
and then wait for the response.

This patch uses messaging infrastructure to pull the data to linux
by registering itself for the message type OPAL_MSG_ASYNC_COMP.

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h             |   12 +-
 arch/powerpc/platforms/powernv/Makefile     |    2 
 arch/powerpc/platforms/powernv/opal-async.c |  203 +++++++++++++++++++++++++++
 3 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-async.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ed82142..90fad59 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -83,6 +83,8 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_INTERNAL_ERROR	-11
 #define OPAL_BUSY_EVENT		-12
 #define OPAL_HARDWARE_FROZEN	-13
+#define OPAL_WRONG_STATE	-14
+#define OPAL_ASYNC_COMPLETION	-15
 
 /* API Tokens (in r0) */
 #define OPAL_CONSOLE_WRITE			1
@@ -241,7 +243,9 @@ enum OpalPendingState {
 };
 
 enum OpalMessageType {
-	OPAL_MSG_ASYNC_COMP		= 0,
+	OPAL_MSG_ASYNC_COMP = 0,	/* params[0] = token, params[1] = rc,
+					 * additional params function-specific
+					 */
 	OPAL_MSG_MEM_ERR,
 	OPAL_MSG_EPOW,
 	OPAL_MSG_SHUTDOWN,
@@ -853,6 +857,12 @@ extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
 
+extern int __opal_async_get_token(void);
+extern int opal_async_get_token_interruptible(void);
+extern int __opal_async_release_token(int token);
+extern int opal_async_release_token(int token);
+extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
+
 extern void hvc_opal_init_early(void);
 
 struct rtc_time;
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 8d767fd..c0f85ea 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,4 +1,4 @@
-obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o
+obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o
 
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
new file mode 100644
index 0000000..cd0c135
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -0,0 +1,203 @@
+/*
+ * PowerNV OPAL asynchronous completion interfaces
+ *
+ * Copyright 2013 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/semaphore.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/gfp.h>
+#include <linux/of.h>
+#include <asm/opal.h>
+
+#define N_ASYNC_COMPLETIONS	64
+
+static DECLARE_BITMAP(opal_async_complete_map, N_ASYNC_COMPLETIONS) = {~0UL};
+static DECLARE_BITMAP(opal_async_token_map, N_ASYNC_COMPLETIONS);
+static DECLARE_WAIT_QUEUE_HEAD(opal_async_wait);
+static DEFINE_SPINLOCK(opal_async_comp_lock);
+static struct semaphore opal_async_sem;
+static struct opal_msg *opal_async_responses;
+static unsigned int opal_max_async_tokens;
+
+int __opal_async_get_token(void)
+{
+	unsigned long flags;
+	int token;
+
+	spin_lock_irqsave(&opal_async_comp_lock, flags);
+	token = find_first_bit(opal_async_complete_map, opal_max_async_tokens);
+	if (token >= opal_max_async_tokens) {
+		token = -EBUSY;
+		goto out;
+	}
+
+	if (__test_and_set_bit(token, opal_async_token_map)) {
+		token = -EBUSY;
+		goto out;
+	}
+
+	__clear_bit(token, opal_async_complete_map);
+
+out:
+	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
+	return token;
+}
+
+int opal_async_get_token_interruptible(void)
+{
+	int token;
+
+	/* Wait until a token is available */
+	if (down_interruptible(&opal_async_sem))
+		return -ERESTARTSYS;
+
+	token = __opal_async_get_token();
+	if (token < 0)
+		up(&opal_async_sem);
+
+	return token;
+}
+
+int __opal_async_release_token(int token)
+{
+	unsigned long flags;
+
+	if (token < 0 || token >= opal_max_async_tokens) {
+		pr_err("%s: Passed token is out of range, token %d\n",
+				__func__, token);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&opal_async_comp_lock, flags);
+	__set_bit(token, opal_async_complete_map);
+	__clear_bit(token, opal_async_token_map);
+	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
+
+	return 0;
+}
+
+int opal_async_release_token(int token)
+{
+	int ret;
+
+	ret = __opal_async_release_token(token);
+	if (ret)
+		return ret;
+
+	up(&opal_async_sem);
+
+	return 0;
+}
+
+int opal_async_wait_response(uint64_t token, struct opal_msg *msg)
+{
+	if (token >= opal_max_async_tokens) {
+		pr_err("%s: Invalid token passed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!msg) {
+		pr_err("%s: Invalid message pointer passed\n", __func__);
+		return -EINVAL;
+	}
+
+	wait_event(opal_async_wait, test_bit(token, opal_async_complete_map));
+	memcpy(msg, &opal_async_responses[token], sizeof(*msg));
+
+	return 0;
+}
+
+static int opal_async_comp_event(struct notifier_block *nb,
+		unsigned long msg_type, void *msg)
+{
+	struct opal_msg *comp_msg = msg;
+	unsigned long flags;
+
+	if (msg_type != OPAL_MSG_ASYNC_COMP)
+		return 0;
+
+	memcpy(&opal_async_responses[comp_msg->params[0]], comp_msg,
+			sizeof(*comp_msg));
+	spin_lock_irqsave(&opal_async_comp_lock, flags);
+	__set_bit(comp_msg->params[0], opal_async_complete_map);
+	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
+
+	wake_up(&opal_async_wait);
+
+	return 0;
+}
+
+static struct notifier_block opal_async_comp_nb = {
+		.notifier_call	= opal_async_comp_event,
+		.next		= NULL,
+		.priority	= 0,
+};
+
+static int __init opal_async_comp_init(void)
+{
+	struct device_node *opal_node;
+	const __be32 *async;
+	int err;
+
+	opal_node = of_find_node_by_path("/ibm,opal");
+	if (!opal_node) {
+		pr_err("%s: Opal node not found\n", __func__);
+		err = -ENOENT;
+		goto out;
+	}
+
+	async = of_get_property(opal_node, "opal-msg-async-num", NULL);
+	if (!async) {
+		pr_err("%s: %s has no opal-msg-async-num\n",
+				__func__, opal_node->full_name);
+		err = -ENOENT;
+		goto out_opal_node;
+	}
+
+	opal_max_async_tokens = be32_to_cpup(async);
+	if (opal_max_async_tokens > N_ASYNC_COMPLETIONS)
+		opal_max_async_tokens = N_ASYNC_COMPLETIONS;
+
+	err = opal_message_notifier_register(OPAL_MSG_ASYNC_COMP,
+			&opal_async_comp_nb);
+	if (err) {
+		pr_err("%s: Can't register OPAL event notifier (%d)\n",
+				__func__, err);
+		goto out_opal_node;
+	}
+
+	opal_async_responses = kzalloc(
+			sizeof(*opal_async_responses) * opal_max_async_tokens,
+			GFP_KERNEL);
+	if (!opal_async_responses) {
+		pr_err("%s: Out of memory, failed to do asynchronous "
+				"completion init\n", __func__);
+		err = -ENOMEM;
+		goto out_opal_node;
+	}
+
+	/* Initialize to 1 less than the maximum tokens available, as we may
+	 * require to pop one during emergency through synchronous call to
+	 * __opal_async_get_token()
+	 */
+	sema_init(&opal_async_sem, opal_max_async_tokens - 1);
+
+out_opal_node:
+	of_node_put(opal_node);
+out:
+	return err;
+}
+subsys_initcall(opal_async_comp_init);
