Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF9651A0E4E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 19:25:39 +1000 (AEST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/powernv: fix construction of opal PRD messages
Message-Id: <1434360334.29351.605847485345.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 15 Jun 2015 17:25:34 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently have a bug in the PRD code, where the contents of an
incoming message (beyond the header) will be overwritten by the list
item manipulations when adding to to the prd_msg_queue.

This change reorders struct opal_prd_msg_queue_item, so that the
message body doesn't overlap the list_head.

We also clarify the memcpy of the message, as we're copying unnecessary
bytes at the end of the message data.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/powernv/opal-prd.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index 64694dd..ba2e388 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -32,9 +32,13 @@
 #include <asm/uaccess.h>
 
 
+/**
+ * The msg member must be at the end of the struct, as it's followed by the
+ * message data.
+ */
 struct opal_prd_msg_queue_item {
-	struct opal_prd_msg_header	msg;
 	struct list_head		list;
+	struct opal_prd_msg_header	msg;
 };
 
 static struct device_node *prd_node;
@@ -351,22 +355,23 @@ static int opal_prd_msg_notifier(struct notifier_block *nb,
 	struct opal_prd_msg_queue_item *item;
 	struct opal_prd_msg_header *hdr;
 	struct opal_msg *msg = _msg;
+	int msg_size, item_size;
 	unsigned long flags;
-	int size;
 
 	if (msg_type != OPAL_MSG_PRD)
 		return 0;
 
-	/* Calculate total size of the item we need to store. The 'size' field
-	 * in the header includes the header itself. */
+	/* Calculate total size of the message and item we need to store. The
+	 * 'size' field in the header includes the header itself. */
 	hdr = (void *)msg->params;
-	size = (sizeof(*item) - sizeof(item->msg)) + be16_to_cpu(hdr->size);
+	msg_size = be16_to_cpu(hdr->size);
+	item_size = msg_size + sizeof(*item) - sizeof(item->msg);
 
-	item = kzalloc(size, GFP_ATOMIC);
+	item = kzalloc(item_size, GFP_ATOMIC);
 	if (!item)
 		return -ENOMEM;
 
-	memcpy(&item->msg, msg->params, size);
+	memcpy(&item->msg, msg->params, msg_size);
 
 	spin_lock_irqsave(&opal_prd_msg_queue_lock, flags);
 	list_add_tail(&item->list, &opal_prd_msg_queue);
