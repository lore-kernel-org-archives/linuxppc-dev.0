Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0DBA3DDF2D
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:25:57 +1000 (EST)
Message-ID: <4818F1DA.2030203@am.sony.com>
Date: Wed, 30 Apr 2008 15:25:30 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 4/5] PS3: Remove unsupported wakeup sources
References: <20080430215644.655638516@am.sony.com>
In-Reply-To: <20080430215644.655638516@am.sony.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Other OS wakeup is not supported from the IR controller,
the bluetooth controller nor the RTC.  Remove references
to these in the PS3 sys-manager source.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-sys-manager.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -184,10 +184,7 @@ enum ps3_sys_manager_next_op {
 
 /**
  * enum ps3_sys_manager_wake_source - Next-op wakeup source (bit position mask).
- * @PS3_SM_WAKE_DEFAULT: Disk insert, power button, eject button, IR
- * controller, and bluetooth controller.
- * @PS3_SM_WAKE_RTC:
- * @PS3_SM_WAKE_RTC_ERROR:
+ * @PS3_SM_WAKE_DEFAULT: Disk insert, power button, eject button.
  * @PS3_SM_WAKE_W_O_L: Ether or wireless LAN.
  * @PS3_SM_WAKE_P_O_R: Power on reset.
  *
@@ -200,8 +197,6 @@ enum ps3_sys_manager_next_op {
 enum ps3_sys_manager_wake_source {
 	/* version 3 */
 	PS3_SM_WAKE_DEFAULT   = 0,
-	PS3_SM_WAKE_RTC       = 0x00000040,
-	PS3_SM_WAKE_RTC_ERROR = 0x00000080,
 	PS3_SM_WAKE_W_O_L     = 0x00000400,
 	PS3_SM_WAKE_P_O_R     = 0x80000000,
 };

-- 
