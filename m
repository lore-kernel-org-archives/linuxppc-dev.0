Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4292Sl1QQYzF37c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 10:18:47 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
 <linux-kernel@vger.kernel.org>
Message-Id: <30034259b0c6af499b51fbb489efd17f4895fbd2.1536709753.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1536709753.git.fthain@telegraphics.com.au>
References: <cover.1536709753.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 5/7] macintosh/via-macii: Simplify locking
Date: Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modifying the request queue or changing the current state requires
mutual exclusion. Use local_irq_disable() consistently for this
rather than disabling the ADB interrupt. This simplifies the locking
scheme and brings via-macii into line with the other ADB drivers.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 7e0e32fa7eb2..6ed9ac91aca1 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -216,22 +216,23 @@ static void macii_queue_poll(void)
 static int macii_send_request(struct adb_request *req, int sync)
 {
 	int err;
-	unsigned long flags;
 
-	local_irq_save(flags);
 	err = macii_write(req);
-	local_irq_restore(flags);
+	if (err)
+		return err;
 
-	if (!err && sync)
+	if (sync)
 		while (!req->complete)
 			macii_poll();
 
-	return err;
+	return 0;
 }
 
 /* Send an ADB request (append to request queue) */
 static int macii_write(struct adb_request *req)
 {
+	unsigned long flags;
+
 	if (req->nbytes < 2 || req->data[0] != ADB_PACKET || req->nbytes > 15) {
 		req->complete = 1;
 		return -EINVAL;
@@ -242,6 +243,8 @@ static int macii_write(struct adb_request *req)
 	req->complete = 0;
 	req->reply_len = 0;
 
+	local_irq_save(flags);
+
 	if (current_req != NULL) {
 		last_req->next = req;
 		last_req = req;
@@ -250,6 +253,9 @@ static int macii_write(struct adb_request *req)
 		last_req = req;
 		if (macii_state == idle) macii_start();
 	}
+
+	local_irq_restore(flags);
+
 	return 0;
 }
 
@@ -293,9 +299,7 @@ static inline int need_autopoll(void) {
 /* Prod the chip without interrupts */
 static void macii_poll(void)
 {
-	disable_irq(IRQ_MAC_ADB);
 	macii_interrupt(0, NULL);
-	enable_irq(IRQ_MAC_ADB);
 }
 
 /* Reset the bus */
@@ -358,13 +362,18 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 {
 	int x;
 	struct adb_request *req;
+	unsigned long flags;
+
+	local_irq_save(flags);
 
 	if (!arg) {
 		/* Clear the SR IRQ flag when polling. */
 		if (via[IFR] & SR_INT)
 			via[IFR] = SR_INT;
-		else
+		else {
+			local_irq_restore(flags);
 			return IRQ_NONE;
+		}
 	}
 
 	last_status = status;
@@ -512,5 +521,6 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 		break;
 	}
 
+	local_irq_restore(flags);
 	return IRQ_HANDLED;
 }
-- 
2.16.4
