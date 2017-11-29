Return-Path: <debmc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynCkN0y0TzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 08:06:03 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vATL4XU6150105
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 16:06:01 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ej1pbqdg7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 16:06:01 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <debmc@linux.vnet.ibm.com>;
 Wed, 29 Nov 2017 16:06:00 -0500
From: Deb McLemore <debmc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: jk@ozlabs.org, Deb McLemore <debmc@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/powernv: Add queue mechanism for early messages
Date: Wed, 29 Nov 2017 15:05:53 -0600
In-Reply-To: <cc9d63a2-c548-0669-4abc-f816dc99b8cc@linux.vnet.ibm.com>
References: <cc9d63a2-c548-0669-4abc-f816dc99b8cc@linux.vnet.ibm.com>
Message-Id: <1511989553-16198-1-git-send-email-debmc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Problem being solved is when issuing a BMC soft poweroff during IPL,
the poweroff was being lost so the machine would not poweroff.

Opal messages were being received before the opal-power code
registered its notifiers.

Alternatives discussed (option #3 was chosen):

1 - Have opal_message_init() explicitly call opal_power_control_init()
before it dequeues any OPAL messages (i.e. before we register the
opal-msg IRQ handler).

2 - Introduce concept of critical message types and when we register
handlers we track which message types have a registered handler,
then defer the opal-msg IRQ registration until we have a handler
registered for all the critical types.

3 - Buffering messages, if we receive a message and do not yet
have a handler for that type, store the message and replay when
a handler for that type is registered.

Signed-off-by: Deb McLemore <debmc@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c | 83 ++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 65c79ec..46d7604 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -40,6 +40,16 @@
 
 #include "powernv.h"
 
+#define OPAL_MSG_QUEUE_MAX 16
+
+struct opal_msg_node {
+	struct list_head	list;
+	struct opal_msg		msg;
+};
+
+static DEFINE_SPINLOCK(msg_list_lock);
+static LIST_HEAD(msg_list);
+
 /* /sys/firmware/opal */
 struct kobject *opal_kobj;
 
@@ -55,6 +65,8 @@ struct mcheck_recoverable_range {
 	u64 recover_addr;
 };
 
+static int msg_list_size;
+
 static struct mcheck_recoverable_range *mc_recoverable_range;
 static int mc_recoverable_range_len;
 
@@ -231,6 +243,44 @@ static int __init opal_register_exception_handlers(void)
 }
 machine_early_initcall(powernv, opal_register_exception_handlers);
 
+static void queue_replay_msg(void *msg)
+{
+	struct opal_msg_node *msg_node;
+
+	if (msg_list_size < OPAL_MSG_QUEUE_MAX) {
+		msg_node = kzalloc(sizeof(*msg_node), GFP_ATOMIC);
+		if (msg_node) {
+			INIT_LIST_HEAD(&msg_node->list);
+			memcpy(&msg_node->msg, msg, sizeof(struct opal_msg));
+			list_add_tail(&msg_node->list, &msg_list);
+			msg_list_size++;
+		} else
+			pr_warn_once("message queue no memory\n");
+
+		if (msg_list_size >= OPAL_MSG_QUEUE_MAX)
+			pr_warn_once("message queue full\n");
+	}
+}
+
+static void dequeue_replay_msg(enum opal_msg_type msg_type)
+{
+	struct opal_msg_node *msg_node, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&msg_list_lock, flags);
+	list_for_each_entry_safe(msg_node, tmp, &msg_list, list) {
+		if (be32_to_cpu(msg_node->msg.msg_type) != msg_type)
+			continue;
+		atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
+					msg_type,
+					&msg_node->msg);
+		list_del(&msg_node->list);
+		kfree(msg_node);
+		msg_list_size--;
+		}
+	spin_unlock_irqrestore(&msg_list_lock, flags);
+}
+
 /*
  * Opal message notifier based on message type. Allow subscribers to get
  * notified for specific messgae type.
@@ -238,14 +288,25 @@ machine_early_initcall(powernv, opal_register_exception_handlers);
 int opal_message_notifier_register(enum opal_msg_type msg_type,
 					struct notifier_block *nb)
 {
+	int ret;
+
 	if (!nb || msg_type >= OPAL_MSG_TYPE_MAX) {
 		pr_warning("%s: Invalid arguments, msg_type:%d\n",
 			   __func__, msg_type);
 		return -EINVAL;
 	}
 
-	return atomic_notifier_chain_register(
-				&opal_msg_notifier_head[msg_type], nb);
+	ret = atomic_notifier_chain_register(
+		&opal_msg_notifier_head[msg_type], nb);
+
+	if (ret)
+		return ret;
+
+	/* Replay any queued messages that came in  */
+	/* prior to the notifier chain registration */
+	dequeue_replay_msg(msg_type);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(opal_message_notifier_register);
 
@@ -259,9 +320,21 @@ EXPORT_SYMBOL_GPL(opal_message_notifier_unregister);
 
 static void opal_message_do_notify(uint32_t msg_type, void *msg)
 {
-	/* notify subscribers */
-	atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
-					msg_type, msg);
+	unsigned long flags;
+
+	spin_lock_irqsave(&msg_list_lock, flags);
+
+	if (opal_msg_notifier_head[msg_type].head != NULL) {
+		/* notify subscribers */
+		atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
+						msg_type, msg);
+	} else {
+		/* Queue up the msg since no notifiers have */
+		/* registered yet for this msg_type         */
+		queue_replay_msg(msg);
+	}
+
+	spin_unlock_irqrestore(&msg_list_lock, flags);
 }
 
 static void opal_handle_message(void)
-- 
2.7.4
