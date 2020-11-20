Return-Path: <SRS0=wfc/=E2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3FEC5519F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 04:56:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3282236F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 04:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3282236F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ccklb28kLzDqxh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 15:56:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CckfM5jTqzDqw8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 15:51:39 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 508152A45D; Thu, 19 Nov 2020 23:51:37 -0500 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <0f0a25855391e7eaa53a50f651aea0124e8525dd.1605847196.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] macintosh/adb-iop: Always wait for reply message from IOP
Date: Fri, 20 Nov 2020 15:39:56 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A recent patch incorrectly altered the adb-iop state machine behaviour
and introduced a regression that can appear intermittently as a
malfunctioning ADB input device. This seems to be caused when reply
packets from different ADB commands become mixed up, especially during
the adb bus scan. Fix this by unconditionally entering the awaiting_reply
state after sending an explicit command, even when the ADB command won't
generate a reply from the ADB device.

Cc: Joshua Thompson <funaho@jurai.org>
Fixes: e2954e5f727f ("macintosh/adb-iop: Implement sending -> idle state transition")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index 6b26b6a2c463..0ee327249150 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -84,10 +84,7 @@ static void adb_iop_complete(struct iop_msg *msg)
 
 	local_irq_save(flags);
 
-	if (current_req->reply_expected)
-		adb_iop_state = awaiting_reply;
-	else
-		adb_iop_done();
+	adb_iop_state = awaiting_reply;
 
 	local_irq_restore(flags);
 }
@@ -95,8 +92,9 @@ static void adb_iop_complete(struct iop_msg *msg)
 /*
  * Listen for ADB messages from the IOP.
  *
- * This will be called when unsolicited messages (usually replies to TALK
- * commands or autopoll packets) are received.
+ * This will be called when unsolicited IOP messages are received.
+ * These IOP messages can carry ADB autopoll responses and also occur
+ * after explicit ADB commands.
  */
 
 static void adb_iop_listen(struct iop_msg *msg)
@@ -123,8 +121,10 @@ static void adb_iop_listen(struct iop_msg *msg)
 		if (adb_iop_state == awaiting_reply) {
 			struct adb_request *req = current_req;
 
-			req->reply_len = amsg->count + 1;
-			memcpy(req->reply, &amsg->cmd, req->reply_len);
+			if (req->reply_expected) {
+				req->reply_len = amsg->count + 1;
+				memcpy(req->reply, &amsg->cmd, req->reply_len);
+			}
 
 			req_done = true;
 		}
-- 
2.26.2

