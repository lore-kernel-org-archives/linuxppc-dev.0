Return-Path: <debmc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q2Ct5gl0zDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 12:04:54 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4L23SlY040782
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 22:04:51 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j3hvawpkv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 22:04:51 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <debmc@linux.vnet.ibm.com>;
 Sun, 20 May 2018 20:04:51 -0600
From: Deb McLemore <debmc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Deb McLemore <debmc@linux.vnet.ibm.com>
Subject: [PATCH v3] powerpc/powernv: Add queue mechanism for early messages
Date: Sun, 20 May 2018 21:04:38 -0500
In-Reply-To: <87bmdfoh8x.fsf@concordia.ellerman.id.au>
References: <87bmdfoh8x.fsf@concordia.ellerman.id.au>
Message-Id: <1526868278-4204-1-git-send-email-debmc@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/opal.c | 89 ++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 48fbb41..b8cae0d 100644
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
+	/* msg_list_lock held in register to allow operation to complete */
+	/* prior to any subsequent messages                              */
+
+	struct opal_msg_node *msg_node, *tmp;
+
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
+}
+
 /*
  * Opal message notifier based on message type. Allow subscribers to get
  * notified for specific messgae type.
@@ -238,14 +288,32 @@ machine_early_initcall(powernv, opal_register_exception_handlers);
 int opal_message_notifier_register(enum opal_msg_type msg_type,
 					struct notifier_block *nb)
 {
+	int ret;
+	unsigned long flags;
+
 	if (!nb || msg_type >= OPAL_MSG_TYPE_MAX) {
 		pr_warn("%s: Invalid arguments, msg_type:%d\n",
 			__func__, msg_type);
 		return -EINVAL;
 	}
 
-	return atomic_notifier_chain_register(
-				&opal_msg_notifier_head[msg_type], nb);
+	spin_lock_irqsave(&msg_list_lock, flags);
+	ret = atomic_notifier_chain_register(
+		&opal_msg_notifier_head[msg_type], nb);
+
+	if (ret) {
+		spin_unlock_irqrestore(&msg_list_lock, flags);
+		return ret;
+	}
+
+	/* Replay any queued messages that came in      */
+	/* prior to the notifier chain registration     */
+	/* msg_list_lock held here to assure completion */
+
+	dequeue_replay_msg(msg_type);
+	spin_unlock_irqrestore(&msg_list_lock, flags);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(opal_message_notifier_register);
 
@@ -259,6 +327,23 @@ EXPORT_SYMBOL_GPL(opal_message_notifier_unregister);
 
 static void opal_message_do_notify(uint32_t msg_type, void *msg)
 {
+	unsigned long flags;
+	bool queued = false;
+
+	spin_lock_irqsave(&msg_list_lock, flags);
+	if (opal_msg_notifier_head[msg_type].head == NULL) {
+		/*
+		 * Queue up the msg since no notifiers have registered
+		 * yet for this msg_type.
+		 */
+		queue_replay_msg(msg);
+		queued = true;
+	}
+	spin_unlock_irqrestore(&msg_list_lock, flags);
+
+	if (queued)
+		return;
+
 	/* notify subscribers */
 	atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
 					msg_type, msg);
-- 
2.7.4
