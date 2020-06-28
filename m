Return-Path: <SRS0=llFo=AJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D921C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jun 2020 04:47:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA83620773
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jun 2020 04:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA83620773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49vdQQ6f4tzDqVn
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jun 2020 14:47:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 49vd4P25vKzDr0p
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2020 14:31:48 +1000 (AEST)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 4625629708; Sun, 28 Jun 2020 00:31:44 -0400 (EDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <0253194363af4426f9788796811a6a29fb87c713.1593318192.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1593318192.git.fthain@telegraphics.com.au>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4/9] macintosh/via-macii: Remove read_done state
Date: Sun, 28 Jun 2020 14:23:12 +1000
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The driver state machine may enter the 'read_done' state when leaving the
'idle' or 'reading' state. This transition is pointless, as is the extra
interrupt it requires. The interrupt is produced by the transceiver
(even when it has no data to send) because an extra EVEN/ODD toggle
was signalled by the driver. Drop the extra state to simplify the code.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2") # v5.0+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 70 ++++++++++++++---------------------
 1 file changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 6a5cd7de05baf..d29c87943ca46 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -110,7 +110,6 @@ static enum macii_state {
 	idle,
 	sending,
 	reading,
-	read_done,
 } macii_state;
 
 static struct adb_request *current_req; /* first request struct in the queue */
@@ -411,8 +410,8 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 			reply_len = 1;
 		} else {
 			/* bus timeout */
-			macii_state = read_done;
 			reply_len = 0;
+			break;
 		}
 
 		/* set ADB state = even for first data byte */
@@ -471,20 +470,6 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 				current_req = req->next;
 				if (req->done)
 					(*req->done)(req);
-
-				if (!current_req)
-					macii_queue_poll();
-
-				if (current_req && macii_state == idle)
-					macii_start();
-
-				if (macii_state == idle) {
-					/* reset to shift in */
-					via[ACR] &= ~SR_OUT;
-					x = via[SR];
-					/* set ADB state idle - might get SRQ */
-					via[B] = (via[B] & ~ST_MASK) | ST_IDLE;
-				}
 				break;
 			}
 		} else {
@@ -511,12 +496,28 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 			} else if (status == ST_ODD && reply_len == 2) {
 				srq_asserted = true;
 			} else {
-				macii_state = read_done;
+				macii_state = idle;
+
+				if (bus_timeout)
+					reply_len = 0;
+
+				if (reading_reply) {
+					struct adb_request *req = current_req;
+
+					req->reply_len = reply_len;
+
+					req->complete = 1;
+					current_req = req->next;
+					if (req->done)
+						(*req->done)(req);
+				} else if (reply_len && autopoll_devs) {
+					adb_input(reply_buf, reply_len, 0);
+				}
+				break;
 			}
 		}
 
-		if (macii_state == reading &&
-		    reply_len < ARRAY_SIZE(reply_buf)) {
+		if (reply_len < ARRAY_SIZE(reply_buf)) {
 			reply_ptr++;
 			*reply_ptr = x;
 			reply_len++;
@@ -526,37 +527,22 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 		via[B] ^= ST_MASK;
 		break;
 
-	case read_done:
-		x = via[SR];
-
-		if (bus_timeout)
-			reply_len = 0;
-
-		if (reading_reply) {
-			reading_reply = 0;
-			req = current_req;
-			req->reply_len = reply_len;
-			req->complete = 1;
-			current_req = req->next;
-			if (req->done)
-				(*req->done)(req);
-		} else if (reply_len && autopoll_devs)
-			adb_input(reply_buf, reply_len, 0);
-
-		macii_state = idle;
+	default:
+		break;
+	}
 
+	if (macii_state == idle) {
 		if (!current_req)
 			macii_queue_poll();
 
 		if (current_req)
 			macii_start();
 
-		if (macii_state == idle)
+		if (macii_state == idle) {
+			via[ACR] &= ~SR_OUT;
+			x = via[SR];
 			via[B] = (via[B] & ~ST_MASK) | ST_IDLE;
-		break;
-
-	default:
-		break;
+		}
 	}
 
 	local_irq_restore(flags);
-- 
2.26.2

