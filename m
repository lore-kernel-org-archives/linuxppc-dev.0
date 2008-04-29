Return-Path: <G.Chen@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B35E0DE0D9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 18:45:21 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3T8iSml022151
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:44:28 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3T8iO3e001020
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 03:44:27 -0500 (CDT)
From: Chen Gong <g.chen@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Watchdog on MPC85xx SMP system
Date: Tue, 29 Apr 2008 16:42:05 +0800
Message-Id: <1209458525-8041-2-git-send-email-g.chen@freescale.com>
In-Reply-To: <1209458525-8041-1-git-send-email-g.chen@freescale.com>
References: <1209458525-8041-1-git-send-email-g.chen@freescale.com>
Cc: wim@iguana.be, Chen Gong <g.chen@freescale.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Book-E SMP systems each core has its own private watchdog.
If only one watchdog is enabled, when the core that doesn't
enable the watchdog is hung, system can't reset because no
watchdog is running on it. That's bad. It means we must
enable watchdogs on both cores.

We can use smp_call_function() to send appropriate messages to
all the other cores to enable and update the watchdog.

Signed-off-by: Chen Gong <g.chen@freescale.com>
---
Now Tested on MPC8572DS platform.

 drivers/watchdog/booke_wdt.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index d362f5b..8a4e7f0 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -1,12 +1,12 @@
 /*
- * drivers/char/watchdog/booke_wdt.c
+ * drivers/watchdog/booke_wdt.c
  *
  * Watchdog timer for PowerPC Book-E systems
  *
  * Author: Matthew McClintock
  * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
- * Copyright 2005 Freescale Semiconductor Inc.
+ * Copyright 2005, 2008 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -16,6 +16,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/smp.h>
 #include <linux/miscdevice.h>
 #include <linux/notifier.h>
 #include <linux/watchdog.h>
@@ -47,23 +48,31 @@ u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
 #define WDTP(x)		(TCR_WP(x))
 #endif
 
+static DEFINE_SPINLOCK(booke_wdt_lock);
+
+static void __booke_wdt_ping(void *data)
+{
+	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
+}
+
 /*
  * booke_wdt_ping:
  */
 static __inline__ void booke_wdt_ping(void)
 {
-	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
+	smp_call_function(__booke_wdt_ping, NULL, 0, 0);
+	__booke_wdt_ping(NULL);
 }
 
 /*
- * booke_wdt_enable:
+ * __booke_wdt_enable:
  */
-static __inline__ void booke_wdt_enable(void)
+static inline void __booke_wdt_enable(void *data)
 {
 	u32 val;
 
 	/* clear status before enabling watchdog */
-	booke_wdt_ping();
+	__booke_wdt_ping(NULL);
 	val = mfspr(SPRN_TCR);
 	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(booke_wdt_period));
 
@@ -137,12 +146,15 @@ static int booke_wdt_ioctl (struct inode *inode, struct file *file,
  */
 static int booke_wdt_open (struct inode *inode, struct file *file)
 {
+	spin_lock(&booke_wdt_lock);
 	if (booke_wdt_enabled == 0) {
 		booke_wdt_enabled = 1;
-		booke_wdt_enable();
+		__booke_wdt_enable(NULL);
+		smp_call_function(__booke_wdt_enable, NULL, 0, 0);
 		printk (KERN_INFO "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
 				booke_wdt_period);
 	}
+	spin_unlock(&booke_wdt_lock);
 
 	return nonseekable_open(inode, file);
 }
@@ -183,11 +195,14 @@ static int __init booke_wdt_init(void)
 		return ret;
 	}
 
+	spin_lock(&booke_wdt_lock);
 	if (booke_wdt_enabled == 1) {
 		printk (KERN_INFO "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
 				booke_wdt_period);
-		booke_wdt_enable();
+		__booke_wdt_enable(NULL);
+		smp_call_function(__booke_wdt_enable, NULL, 0, 0);
 	}
+	spin_unlock(&booke_wdt_lock);
 
 	return ret;
 }
-- 
1.5.4
