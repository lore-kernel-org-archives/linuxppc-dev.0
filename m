Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4292Sj4TyGzF37m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 10:18:45 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
 <linux-kernel@vger.kernel.org>
Message-Id: <40e706689c8fb6e2adfed4a4d2794f5f8ff384d1.1536709753.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1536709753.git.fthain@telegraphics.com.au>
References: <cover.1536709753.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4/7] macintosh/via-macii: Remove BUG_ON assertions
Date: Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The BUG_ON assertions I added to the via-macii driver over a decade ago
haven't fired AFAIK. Some can never fire (by inspection). One assertion
checks for a NULL pointer, but that would merely substitute a BUG crash
for an Oops crash. Remove the pointless BUG_ON assertions and replace
the others with a WARN_ON and an array bounds check.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 49 +++++++------------------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 36a4f49e79b5..7e0e32fa7eb2 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -120,23 +120,6 @@ static int srq_asserted;     /* have to poll for the device that asserted it */
 static int command_byte;         /* the most recent command byte transmitted */
 static int autopoll_devs;      /* bits set are device addresses to be polled */
 
-/* Sanity check for request queue. Doesn't check for cycles. */
-static int request_is_queued(struct adb_request *req) {
-	struct adb_request *cur;
-	unsigned long flags;
-	local_irq_save(flags);
-	cur = current_req;
-	while (cur) {
-		if (cur == req) {
-			local_irq_restore(flags);
-			return 1;
-		}
-		cur = cur->next;
-	}
-	local_irq_restore(flags);
-	return 0;
-}
-
 /* Check for MacII style ADB */
 static int macii_probe(void)
 {
@@ -213,8 +196,6 @@ static void macii_queue_poll(void)
 	else
 		next_device = ffs(autopoll_devs) - 1;
 
-	BUG_ON(request_is_queued(&req));
-
 	adb_request(&req, NULL, ADBREQ_NOSEND, 1,
 	            ADB_READREG(next_device, 0));
 
@@ -237,18 +218,13 @@ static int macii_send_request(struct adb_request *req, int sync)
 	int err;
 	unsigned long flags;
 
-	BUG_ON(request_is_queued(req));
-
 	local_irq_save(flags);
 	err = macii_write(req);
 	local_irq_restore(flags);
 
-	if (!err && sync) {
-		while (!req->complete) {
+	if (!err && sync)
+		while (!req->complete)
 			macii_poll();
-		}
-		BUG_ON(request_is_queued(req));
-	}
 
 	return err;
 }
@@ -327,9 +303,6 @@ static int macii_reset_bus(void)
 {
 	static struct adb_request req;
 	
-	if (request_is_queued(&req))
-		return 0;
-
 	/* Command = 0, Address = ignored */
 	adb_request(&req, NULL, ADBREQ_NOSEND, 1, ADB_BUSRESET);
 	macii_send_request(&req, 1);
@@ -347,10 +320,6 @@ static void macii_start(void)
 
 	req = current_req;
 
-	BUG_ON(req == NULL);
-
-	BUG_ON(macii_state != idle);
-
 	/* Now send it. Be careful though, that first byte of the request
 	 * is actually ADB_PACKET; the real data begins at index 1!
 	 * And req->nbytes is the number of bytes of real data plus one.
@@ -388,7 +357,6 @@ static void macii_start(void)
 static irqreturn_t macii_interrupt(int irq, void *arg)
 {
 	int x;
-	static int entered;
 	struct adb_request *req;
 
 	if (!arg) {
@@ -399,8 +367,6 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 			return IRQ_NONE;
 	}
 
-	BUG_ON(entered++);
-
 	last_status = status;
 	status = via[B] & (ST_MASK|CTLR_IRQ);
 
@@ -409,7 +375,7 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 			if (reading_reply) {
 				reply_ptr = current_req->reply;
 			} else {
-				BUG_ON(current_req != NULL);
+				WARN_ON(current_req);
 				reply_ptr = reply_buf;
 			}
 
@@ -474,8 +440,8 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 
 		case reading:
 			x = via[SR];
-			BUG_ON((status & ST_MASK) == ST_CMD ||
-			       (status & ST_MASK) == ST_IDLE);
+			WARN_ON((status & ST_MASK) == ST_CMD ||
+				(status & ST_MASK) == ST_IDLE);
 
 			/* Bus timeout with SRQ sequence:
 			 *     data is "XX FF"      while CTLR_IRQ is "L L"
@@ -502,8 +468,8 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 				}
 			}
 
-			if (macii_state == reading) {
-				BUG_ON(reply_len > 15);
+			if (macii_state == reading &&
+			    reply_len < ARRAY_SIZE(reply_buf)) {
 				reply_ptr++;
 				*reply_ptr = x;
 				reply_len++;
@@ -546,6 +512,5 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 		break;
 	}
 
-	entered--;
 	return IRQ_HANDLED;
 }
-- 
2.16.4
