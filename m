Return-Path: <b10716@zro03-ws408.ea.freescale.net>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4552E2C032B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 02:53:02 +1100 (EST)
Received: from mail96-db8 (localhost [127.0.0.1])	by mail96-db8-R.bigfish.com
 (Postfix) with ESMTP id 3C580CC00B4	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Mar 2013 15:52:56 +0000 (UTC)
Received: from DB8EHSMHS002.bigfish.com (unknown [10.174.8.252])	by
 mail96-db8.bigfish.com (Postfix) with ESMTP id 2A183B80240	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 15:52:53 +0000 (UTC)
From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/watchdog: Don't enable interrupt on PPC64 BookE
Date: Tue, 5 Mar 2013 17:52:49 +0200
Message-ID: <1362498769-438-1-git-send-email-Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tudor Laurentiu <laurentiu.tudor@freescale.com>

Critical interrupts are not handled on PPC64 BookE machines,
so when the first watchdog interrupt fires the machine will
freeze without a warning until it's rebooted by the second
watchdog trigger.
Plus, the interrupt isn't used anyway since the driver
expects a usermode app to ping the watchdog periodically.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
---
 drivers/watchdog/booke_wdt.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index c0bc92d..5eb2040 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -122,6 +122,14 @@ static void __booke_wdt_enable(void *data)
 	val &= ~WDTP_MASK;
 	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(booke_wdt_period));
 
+#ifdef CONFIG_PPC_BOOK3E_64
+	/*
+	 * Crit ints are currently broken on PPC64 Book-E, so
+	 * just disable them for now.
+	 */
+	val &= ~TCR_WIE;
+#endif
+
 	mtspr(SPRN_TCR, val);
 }
 
-- 
1.7.6.5
