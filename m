Return-Path: <SRS0=0EC+=7N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8811C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 04:20:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D5A207BC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 04:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D5A207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ZQ7q60gRzDqtK
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 14:20:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 49ZPw769PFzDqlr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2020 14:09:59 +1000 (AEST)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 80AD027F9A; Sat, 30 May 2020 19:20:33 -0400 (EDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <b63d56ecb6e75f11a0bf02231f3b2db656a528a3.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 3/8] macintosh/adb-iop: Adopt bus reset algorithm from
 via-macii driver
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

This algorithm is slightly shorter and avoids the surprising
adb_iop_start() call in adb_iop_poll().

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index ca3b411b0742..c3089dacf2e2 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -238,24 +238,19 @@ int adb_iop_autopoll(int devs)
 
 void adb_iop_poll(void)
 {
-	if (adb_iop_state == idle)
-		adb_iop_start();
 	iop_ism_irq_poll(ADB_IOP);
 }
 
 int adb_iop_reset_bus(void)
 {
-	struct adb_request req = {
-		.reply_expected = 0,
-		.nbytes = 2,
-		.data = { ADB_PACKET, 0 },
-	};
-
-	adb_iop_write(&req);
-	while (!req.complete) {
-		adb_iop_poll();
-		schedule();
-	}
+	struct adb_request req;
+
+	/* Command = 0, Address = ignored */
+	adb_request(&req, NULL, ADBREQ_NOSEND, 1, ADB_BUSRESET);
+	adb_iop_send_request(&req, 1);
+
+	/* Don't want any more requests during the Global Reset low time. */
+	mdelay(3);
 
 	return 0;
 }
-- 
2.26.2

