Return-Path: <SRS0=0EC+=7N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2BDC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 04:18:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6A3207BC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 04:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6A3207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ZQ681BHhzDqtW
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 14:18:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 49ZPw76nP2zDqly
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2020 14:09:59 +1000 (AEST)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 5FCE927F1F; Sat, 30 May 2020 19:20:33 -0400 (EDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <996f835d2f3d90baaaf9ee954e252d06e8886c6f.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 2/8] macintosh/adb-iop: Correct comment text
Date: Sun, 31 May 2020 09:17:03 +1000
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
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch improves comment style and corrects some misunderstandings
in the text.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index ce28ff40fb9c..ca3b411b0742 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -101,11 +101,10 @@ static void adb_iop_listen(struct iop_msg *msg)
 
 	req = current_req;
 
-	/* Handle a timeout. Timeout packets seem to occur even after */
-	/* we've gotten a valid reply to a TALK, so I'm assuming that */
-	/* a "timeout" is actually more like an "end-of-data" signal. */
-	/* We need to send back a timeout packet to the IOP to shut   */
-	/* it up, plus complete the current request, if any.          */
+	/* Handle a timeout. Timeout packets seem to occur even after
+	 * we've gotten a valid reply to a TALK, presumably because of
+	 * autopolling.
+	 */
 
 	if (amsg->flags & ADB_IOP_TIMEOUT) {
 		msg->reply[0] = ADB_IOP_TIMEOUT | ADB_IOP_AUTOPOLL;
@@ -115,9 +114,6 @@ static void adb_iop_listen(struct iop_msg *msg)
 			adb_iop_end_req(req, idle);
 		}
 	} else {
-		/* TODO: is it possible for more than one chunk of data  */
-		/*       to arrive before the timeout? If so we need to */
-		/*       use reply_ptr here like the other drivers do.  */
 		if ((adb_iop_state == awaiting_reply) &&
 		    (amsg->flags & ADB_IOP_EXPLICIT)) {
 			req->reply_len = amsg->count + 1;
@@ -152,23 +148,24 @@ static void adb_iop_start(void)
 
 	local_irq_save(flags);
 
-	/* The IOP takes MacII-style packets, so */
-	/* strip the initial ADB_PACKET byte.    */
-
+	/* The IOP takes MacII-style packets, so strip the initial
+	 * ADB_PACKET byte.
+	 */
 	amsg.flags = ADB_IOP_EXPLICIT;
 	amsg.count = req->nbytes - 2;
 
-	/* amsg.data immediately follows amsg.cmd, effectively making */
-	/* amsg.cmd a pointer to the beginning of a full ADB packet.  */
+	/* amsg.data immediately follows amsg.cmd, effectively making
+	 * &amsg.cmd a pointer to the beginning of a full ADB packet.
+	 */
 	memcpy(&amsg.cmd, req->data + 1, req->nbytes - 1);
 
 	req->sent = 1;
 	adb_iop_state = sending;
 	local_irq_restore(flags);
 
-	/* Now send it. The IOP manager will call adb_iop_complete */
-	/* when the packet has been sent.                          */
-
+	/* Now send it. The IOP manager will call adb_iop_complete
+	 * when the message has been sent.
+	 */
 	iop_send_message(ADB_IOP, ADB_CHAN, req, sizeof(amsg), (__u8 *)&amsg,
 			 adb_iop_complete);
 }
-- 
2.26.2

