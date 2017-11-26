Return-Path: <debmc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylC5F5Gz9zDrMj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 01:30:24 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAQETbUG029433
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 09:30:22 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2efpxawbr2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 09:30:21 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <debmc@linux.vnet.ibm.com>;
 Sun, 26 Nov 2017 09:30:20 -0500
From: Deb McLemore <debmc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: jk@ozlabs.org, Deb McLemore <debmc@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Add queue mechanism for early messages
Date: Sun, 26 Nov 2017 08:30:15 -0600
Message-Id: <1511706615-7126-1-git-send-email-debmc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a check for do_notify to confirm that a message handler
has been registered before an attempt is made to call notifier
call chain.

If the message handler has not been registered queue up the message
to be replayed when the proper registration is called.

Signed-off-by: Deb McLemore <debmc@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c | 88 +++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 65c79ec..0e3b464 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -40,6 +40,16 @@
 
 #include "powernv.h"
 
+#define OPAL_MSG_QUEUE_MAX 16
+
+struct OpalMsgNode {
+	struct list_head	opal_queue_list_node;
+	struct opal_msg		msg;
+	uint32_t		queue_msg_type;
+};
+
+static LIST_HEAD(opal_msg_queue_pending);
+
 /* /sys/firmware/opal */
 struct kobject *opal_kobj;
 
@@ -55,11 +65,15 @@ struct mcheck_recoverable_range {
 	u64 recover_addr;
 };
 
+static unsigned long opal_msg_notify_reg_mask;
+static int opal_active_queue_elements;
+
 static struct mcheck_recoverable_range *mc_recoverable_range;
 static int mc_recoverable_range_len;
 
 struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
+static DEFINE_SPINLOCK(opal_msg_lock);
 static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static uint32_t opal_heartbeat;
 static struct task_struct *kopald_tsk;
@@ -238,14 +252,47 @@ machine_early_initcall(powernv, opal_register_exception_handlers);
 int opal_message_notifier_register(enum opal_msg_type msg_type,
 					struct notifier_block *nb)
 {
+	struct OpalMsgNode *msg_node, *tmp;
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&opal_msg_lock, flags);
+
+	opal_msg_notify_reg_mask |= 1 << msg_type;
+
+	spin_unlock_irqrestore(&opal_msg_lock, flags);
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
+	spin_lock_irqsave(&opal_msg_lock, flags);
+	list_for_each_entry_safe(msg_node,
+				tmp,
+				&opal_msg_queue_pending,
+				opal_queue_list_node) {
+		if (msg_node->queue_msg_type == msg_type) {
+			atomic_notifier_call_chain(
+				&opal_msg_notifier_head[msg_type],
+				msg_type,
+				&msg_node->msg);
+			list_del(&msg_node->opal_queue_list_node);
+			kfree(msg_node);
+			opal_active_queue_elements--;
+		}
+	}
+	spin_unlock_irqrestore(&opal_msg_lock, flags);
+
+	return ret;
+
 }
 EXPORT_SYMBOL_GPL(opal_message_notifier_register);
 
@@ -259,9 +306,40 @@ EXPORT_SYMBOL_GPL(opal_message_notifier_unregister);
 
 static void opal_message_do_notify(uint32_t msg_type, void *msg)
 {
-	/* notify subscribers */
-	atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
-					msg_type, msg);
+	struct OpalMsgNode *msg_node;
+
+	unsigned long flags;
+
+	spin_lock_irqsave(&opal_msg_lock, flags);
+
+	if (opal_msg_notify_reg_mask & (1 << msg_type)) {
+		/* notify subscribers */
+		atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
+						msg_type, msg);
+	} else {
+		if (opal_active_queue_elements < OPAL_MSG_QUEUE_MAX) {
+			msg_node = kzalloc(sizeof(*msg_node), GFP_ATOMIC);
+			if (msg_node) {
+				INIT_LIST_HEAD(&msg_node->opal_queue_list_node);
+				memcpy(&msg_node->msg,
+					msg,
+					sizeof(struct opal_msg));
+				msg_node->queue_msg_type = msg_type;
+				list_add_tail(&msg_node->opal_queue_list_node,
+						&opal_msg_queue_pending);
+				opal_active_queue_elements++;
+			}
+		}
+
+		if (opal_active_queue_elements >= OPAL_MSG_QUEUE_MAX) {
+			pr_warn_once("%s: Notifier Register Queue full at %i\n",
+					__func__,
+					opal_active_queue_elements);
+		}
+	}
+
+	spin_unlock_irqrestore(&opal_msg_lock, flags);
+
 }
 
 static void opal_handle_message(void)
-- 
2.7.4
