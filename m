Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 91892DDED0
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 09:56:58 +1100 (EST)
Message-ID: <47ACDD53.4060708@am.sony.com>
Date: Fri, 08 Feb 2008 14:53:07 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 6/6] PS3: Update sys-manager button events
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

PS3 firmware 1.94 added the source of power and reset events to the
payload of the system manager POWER_PRESSED and RESET_PRESSED events.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-sys-manager.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -138,9 +138,11 @@ enum ps3_sys_manager_attr {
 
 /**
  * enum ps3_sys_manager_event - External event type, reported by system manager.
- * @PS3_SM_EVENT_POWER_PRESSED: payload.value not used.
+ * @PS3_SM_EVENT_POWER_PRESSED: payload.value =
+ *  enum ps3_sys_manager_button_event.
  * @PS3_SM_EVENT_POWER_RELEASED: payload.value = time pressed in millisec.
- * @PS3_SM_EVENT_RESET_PRESSED: payload.value not used.
+ * @PS3_SM_EVENT_RESET_PRESSED: payload.value =
+ *  enum ps3_sys_manager_button_event.
  * @PS3_SM_EVENT_RESET_RELEASED: payload.value = time pressed in millisec.
  * @PS3_SM_EVENT_THERMAL_ALERT: payload.value = thermal zone id.
  * @PS3_SM_EVENT_THERMAL_CLEARED: payload.value = thermal zone id.
@@ -158,6 +160,17 @@ enum ps3_sys_manager_event {
 };
 
 /**
+ * enum ps3_sys_manager_button_event - Button event payload values.
+ * @PS3_SM_BUTTON_EVENT_HARD: Hardware generated event.
+ * @PS3_SM_BUTTON_EVENT_SOFT: Software generated event.
+ */
+
+enum ps3_sys_manager_button_event {
+	PS3_SM_BUTTON_EVENT_HARD = 0,
+	PS3_SM_BUTTON_EVENT_SOFT = 1,
+};
+
+/**
  * enum ps3_sys_manager_next_op - Operation to perform after lpar is destroyed.
  */
 
@@ -416,8 +429,10 @@ static int ps3_sys_manager_handle_event(
 
 	switch (event.type) {
 	case PS3_SM_EVENT_POWER_PRESSED:
-		dev_dbg(&dev->core, "%s:%d: POWER_PRESSED\n",
-			__func__, __LINE__);
+		dev_dbg(&dev->core, "%s:%d: POWER_PRESSED (%s)\n",
+			__func__, __LINE__,
+			(event.value == PS3_SM_BUTTON_EVENT_SOFT ? "soft"
+			: "hard"));
 		ps3_sm_force_power_off = 1;
 		/*
 		 * A memory barrier is use here to sync memory since
@@ -432,8 +447,10 @@ static int ps3_sys_manager_handle_event(
 			__func__, __LINE__, event.value);
 		break;
 	case PS3_SM_EVENT_RESET_PRESSED:
-		dev_dbg(&dev->core, "%s:%d: RESET_PRESSED\n",
-			__func__, __LINE__);
+		dev_dbg(&dev->core, "%s:%d: RESET_PRESSED (%s)\n",
+			__func__, __LINE__,
+			(event.value == PS3_SM_BUTTON_EVENT_SOFT ? "soft"
+			: "hard"));
 		ps3_sm_force_power_off = 0;
 		/*
 		 * A memory barrier is use here to sync memory since

-- 
