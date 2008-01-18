Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail197-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6F78EDDF7C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:13 +1100 (EST)
Message-ID: <47910CCE.1010708@am.sony.com>
Date: Fri, 18 Jan 2008 12:32:14 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 08/16] PS3: Checkpatch cleanups for
	drivers/ps3/ps3-sys-manager.c
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Cleanup coding errors in drivers/ps3/ps3-sys-manager.c as reported
by checkpatch.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-sys-manager.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -452,7 +452,7 @@ static int ps3_sys_manager_handle_event(
 	case PS3_SM_EVENT_THERMAL_ALERT:
 		dev_dbg(&dev->core, "%s:%d: THERMAL_ALERT (zone %u)\n",
 			__func__, __LINE__, event.value);
-		printk(KERN_INFO "PS3 Thermal Alert Zone %u\n", event.value);
+		pr_info("PS3 Thermal Alert Zone %u\n", event.value);
 		break;
 	case PS3_SM_EVENT_THERMAL_CLEARED:
 		dev_dbg(&dev->core, "%s:%d: THERMAL_CLEARED (zone %u)\n",
@@ -488,7 +488,7 @@ static int ps3_sys_manager_handle_cmd(st
 	result = ps3_vuart_read(dev, &cmd, sizeof(cmd));
 	BUG_ON(result && "need to retry here");
 
-	if(result)
+	if (result)
 		return result;
 
 	if (cmd.version != 1) {
@@ -521,7 +521,7 @@ static int ps3_sys_manager_handle_msg(st
 	result = ps3_vuart_read(dev, &header,
 		sizeof(struct ps3_sys_manager_header));
 
-	if(result)
+	if (result)
 		return result;
 
 	if (header.version != 1) {
@@ -589,9 +589,9 @@ static void ps3_sys_manager_final_power_
 		PS3_SM_WAKE_DEFAULT);
 	ps3_sys_manager_send_request_shutdown(dev);
 
-	printk(KERN_EMERG "System Halted, OK to turn off power\n");
+	pr_emerg("System Halted, OK to turn off power\n");
 
-	while(1)
+	while (1)
 		ps3_sys_manager_handle_msg(dev);
 }
 
@@ -626,9 +626,9 @@ static void ps3_sys_manager_final_restar
 		PS3_SM_WAKE_DEFAULT);
 	ps3_sys_manager_send_request_shutdown(dev);
 
-	printk(KERN_EMERG "System Halted, OK to turn off power\n");
+	pr_emerg("System Halted, OK to turn off power\n");
 
-	while(1)
+	while (1)
 		ps3_sys_manager_handle_msg(dev);
 }
 

-- 
