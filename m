Return-Path: <SRS0=0EC+=7N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D286C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 04:21:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEE42070B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 04:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEE42070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ZQ9m3Pb9zDqdZ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 14:21:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 49ZPw769LLzDqll
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2020 14:09:59 +1000 (AEST)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id A111127F9B; Sat, 30 May 2020 19:20:33 -0400 (EDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <bbe32b087c7e04d68e2425f6a2df4a414d167c32.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4/8] macintosh/adb-iop: Access current_req and adb_iop_state
 when inside lock
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

Drop the redundant local_irq_save/restore() from adb_iop_start() because
the caller has to do it anyway. This is the pattern used in via-macii.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index c3089dacf2e2..7ecc41bc7358 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -137,7 +137,6 @@ static void adb_iop_listen(struct iop_msg *msg)
 
 static void adb_iop_start(void)
 {
-	unsigned long flags;
 	struct adb_request *req;
 	struct adb_iopmsg amsg;
 
@@ -146,8 +145,6 @@ static void adb_iop_start(void)
 	if (!req)
 		return;
 
-	local_irq_save(flags);
-
 	/* The IOP takes MacII-style packets, so strip the initial
 	 * ADB_PACKET byte.
 	 */
@@ -161,7 +158,6 @@ static void adb_iop_start(void)
 
 	req->sent = 1;
 	adb_iop_state = sending;
-	local_irq_restore(flags);
 
 	/* Now send it. The IOP manager will call adb_iop_complete
 	 * when the message has been sent.
@@ -208,13 +204,13 @@ static int adb_iop_write(struct adb_request *req)
 		return -EINVAL;
 	}
 
-	local_irq_save(flags);
-
 	req->next = NULL;
 	req->sent = 0;
 	req->complete = 0;
 	req->reply_len = 0;
 
+	local_irq_save(flags);
+
 	if (current_req != 0) {
 		last_req->next = req;
 		last_req = req;
@@ -223,10 +219,11 @@ static int adb_iop_write(struct adb_request *req)
 		last_req = req;
 	}
 
-	local_irq_restore(flags);
-
 	if (adb_iop_state == idle)
 		adb_iop_start();
+
+	local_irq_restore(flags);
+
 	return 0;
 }
 
-- 
2.26.2

