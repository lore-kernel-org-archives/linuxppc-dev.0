Return-Path: <SRS0=0EC+=7N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C95DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 04:11:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C012070E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 04:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C012070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ZPyD51zCzDqmX
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 14:11:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 49ZPw53NVkzDqll
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2020 14:09:57 +1000 (AEST)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id A668428009; Sat, 30 May 2020 19:20:34 -0400 (EDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <0fb7fdcd99d7820bb27faf1f27f7f6f1923914ef.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 8/8] macintosh/adb-iop: Implement SRQ autopolling
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The adb_driver.autopoll method is needed during ADB bus scan and device
address assignment. Implement this method so that the IOP's list of
device addresses can be updated. When the list is empty, disable SRQ
autopolling.

Cc: Joshua Thompson <funaho@jurai.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/include/asm/adb_iop.h |  1 +
 drivers/macintosh/adb-iop.c     | 32 ++++++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/include/asm/adb_iop.h b/arch/m68k/include/asm/adb_iop.h
index 195d7fb1268c..6aecd020e2fc 100644
--- a/arch/m68k/include/asm/adb_iop.h
+++ b/arch/m68k/include/asm/adb_iop.h
@@ -29,6 +29,7 @@
 
 #define ADB_IOP_EXPLICIT	0x80	/* nonzero if explicit command */
 #define ADB_IOP_AUTOPOLL	0x40	/* auto/SRQ polling enabled    */
+#define ADB_IOP_SET_AUTOPOLL	0x20	/* set autopoll device list    */
 #define ADB_IOP_SRQ		0x04	/* SRQ detected                */
 #define ADB_IOP_TIMEOUT		0x02	/* nonzero if timeout          */
 
diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index 8594e4f9a830..f3d1a460fbce 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -7,10 +7,6 @@
  * 1999-07-01 (jmt) - First implementation for new driver architecture.
  *
  * 1999-07-31 (jmt) - First working version.
- *
- * TODO:
- *
- * o Implement SRQ handling.
  */
 
 #include <linux/types.h>
@@ -28,6 +24,7 @@
 
 static struct adb_request *current_req;
 static struct adb_request *last_req;
+static unsigned int autopoll_devs;
 
 static enum adb_iop_state {
 	idle,
@@ -123,7 +120,7 @@ static void adb_iop_listen(struct iop_msg *msg)
 			  amsg->flags & ADB_IOP_AUTOPOLL);
 	}
 
-	msg->reply[0] = ADB_IOP_AUTOPOLL;
+	msg->reply[0] = autopoll_devs ? ADB_IOP_AUTOPOLL : 0;
 	iop_complete_message(msg);
 
 	if (req_done)
@@ -231,9 +228,32 @@ static int adb_iop_write(struct adb_request *req)
 	return 0;
 }
 
+static void adb_iop_set_ap_complete(struct iop_msg *msg)
+{
+	struct adb_iopmsg *amsg = (struct adb_iopmsg *)msg->message;
+
+	autopoll_devs = (amsg->data[1] << 8) | amsg->data[0];
+}
+
 static int adb_iop_autopoll(int devs)
 {
-	/* TODO: how do we enable/disable autopoll? */
+	struct adb_iopmsg amsg;
+	unsigned long flags;
+	unsigned int mask = (unsigned int)devs & 0xFFFE;
+
+	local_irq_save(flags);
+
+	amsg.flags = ADB_IOP_SET_AUTOPOLL | (mask ? ADB_IOP_AUTOPOLL : 0);
+	amsg.count = 2;
+	amsg.cmd = 0;
+	amsg.data[0] = mask & 0xFF;
+	amsg.data[1] = (mask >> 8) & 0xFF;
+
+	iop_send_message(ADB_IOP, ADB_CHAN, NULL, sizeof(amsg), (__u8 *)&amsg,
+			 adb_iop_set_ap_complete);
+
+	local_irq_restore(flags);
+
 	return 0;
 }
 
-- 
2.26.2

