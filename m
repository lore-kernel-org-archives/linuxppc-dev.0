Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BD7DDDDEC4
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 10:46:06 +1100 (EST)
Message-ID: <47ACDD4D.5040409@am.sony.com>
Date: Fri, 08 Feb 2008 14:53:01 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 5/6] PS3: Sys-manager code cleanup
References: <20080208224723.029462363@am.sony.com>
In-Reply-To: <20080208224723.029462363@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

General code cleanups for PS3 system-manager:
 o Move all MODULE_ macros to bottom.
 o Correct PS3_SM_WAKE_P_O_R value.
 o Enhance comment on wakeup source values.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-sys-manager.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -28,10 +28,6 @@
 
 #include "vuart.h"
 
-MODULE_AUTHOR("Sony Corporation");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("PS3 System Manager");
-
 /**
  * ps3_sys_manager - PS3 system manager driver.
  *
@@ -181,7 +177,9 @@ enum ps3_sys_manager_next_op {
  * @PS3_SM_WAKE_P_O_R: Power on reset.
  *
  * Additional wakeup sources when specifying PS3_SM_NEXT_OP_SYS_SHUTDOWN.
- * System will always wake from the PS3_SM_WAKE_DEFAULT sources.
+ * The system will always wake from the PS3_SM_WAKE_DEFAULT sources.
+ * Sources listed here are the only ones available to guests in the
+ * other-os lpar.
  */
 
 enum ps3_sys_manager_wake_source {
@@ -189,7 +187,7 @@ enum ps3_sys_manager_wake_source {
 	PS3_SM_WAKE_DEFAULT   = 0,
 	PS3_SM_WAKE_RTC       = 0x00000040,
 	PS3_SM_WAKE_RTC_ERROR = 0x00000080,
-	PS3_SM_WAKE_P_O_R     = 0x10000000,
+	PS3_SM_WAKE_P_O_R     = 0x80000000,
 };
 
 /**
@@ -699,4 +697,7 @@ static int __init ps3_sys_manager_init(v
 module_init(ps3_sys_manager_init);
 /* Module remove not supported. */
 
+MODULE_AUTHOR("Sony Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("PS3 System Manager");
 MODULE_ALIAS(PS3_MODULE_ALIAS_SYSTEM_MANAGER);

-- 
