Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D6163DE161
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 11:40:05 +1100 (EST)
Message-ID: <47EAECA8.5030707@am.sony.com>
Date: Wed, 26 Mar 2008 17:39:04 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 5/6] PS3: Sys-manager Wake-on-LAN support
References: <20080327001821.827672589@am.sony.com>
In-Reply-To: <20080327001821.827672589@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add Wake-on-LAN support to the PS3 system-manager.  Other OS WOL
support was introduced in PS3 system firmware 2.20.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-sys-manager.c |   46 ++++++++++++++++++++++++++++++++++++++++--
 include/asm-powerpc/ps3.h     |    2 +
 2 files changed, 46 insertions(+), 2 deletions(-)

--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -188,6 +188,7 @@ enum ps3_sys_manager_next_op {
  * controller, and bluetooth controller.
  * @PS3_SM_WAKE_RTC:
  * @PS3_SM_WAKE_RTC_ERROR:
+ * @PS3_SM_WAKE_W_O_L: Ether or wireless LAN.
  * @PS3_SM_WAKE_P_O_R: Power on reset.
  *
  * Additional wakeup sources when specifying PS3_SM_NEXT_OP_SYS_SHUTDOWN.
@@ -201,10 +202,19 @@ enum ps3_sys_manager_wake_source {
 	PS3_SM_WAKE_DEFAULT   = 0,
 	PS3_SM_WAKE_RTC       = 0x00000040,
 	PS3_SM_WAKE_RTC_ERROR = 0x00000080,
+	PS3_SM_WAKE_W_O_L     = 0x00000400,
 	PS3_SM_WAKE_P_O_R     = 0x80000000,
 };
 
 /**
+ * user_wake_sources - User specified wakeup sources.
+ *
+ * Logical OR of enum ps3_sys_manager_wake_source types.
+ */
+
+static u32 user_wake_sources = PS3_SM_WAKE_DEFAULT;
+
+/**
  * enum ps3_sys_manager_cmd - Command from system manager to guest.
  *
  * The guest completes the actions needed, then acks or naks the command via
@@ -619,7 +629,7 @@ static void ps3_sys_manager_final_power_
 	ps3_vuart_cancel_async(dev);
 
 	ps3_sys_manager_send_next_op(dev, PS3_SM_NEXT_OP_SYS_SHUTDOWN,
-		PS3_SM_WAKE_DEFAULT);
+		user_wake_sources);
 
 	ps3_sys_manager_fin(dev);
 }
@@ -652,12 +662,44 @@ static void ps3_sys_manager_final_restar
 
 	ps3_sys_manager_send_attr(dev, 0);
 	ps3_sys_manager_send_next_op(dev, PS3_SM_NEXT_OP_SYS_REBOOT,
-		PS3_SM_WAKE_DEFAULT);
+		user_wake_sources);
 
 	ps3_sys_manager_fin(dev);
 }
 
 /**
+ * ps3_sys_manager_get_wol - Get wake-on-lan setting.
+ */
+
+int ps3_sys_manager_get_wol(void)
+{
+	pr_debug("%s:%d\n", __func__, __LINE__);
+
+	return (user_wake_sources & PS3_SM_WAKE_W_O_L) != 0;
+}
+EXPORT_SYMBOL_GPL(ps3_sys_manager_get_wol);
+
+/**
+ * ps3_sys_manager_set_wol - Set wake-on-lan setting.
+ */
+
+void ps3_sys_manager_set_wol(int state)
+{
+	static DEFINE_MUTEX(mutex);
+
+	mutex_lock(&mutex);
+
+	pr_debug("%s:%d: %d\n", __func__, __LINE__, state);
+
+	if (state)
+		user_wake_sources |= PS3_SM_WAKE_W_O_L;
+	else
+		user_wake_sources &= ~PS3_SM_WAKE_W_O_L;
+	mutex_unlock(&mutex);
+}
+EXPORT_SYMBOL_GPL(ps3_sys_manager_set_wol);
+
+/**
  * ps3_sys_manager_work - Asynchronous read handler.
  *
  * Signaled when PS3_SM_RX_MSG_LEN_MIN bytes arrive at the vuart port.
--- a/include/asm-powerpc/ps3.h
+++ b/include/asm-powerpc/ps3.h
@@ -437,6 +437,8 @@ void ps3_sys_manager_register_ops(const 
 void __noreturn ps3_sys_manager_power_off(void);
 void __noreturn ps3_sys_manager_restart(void);
 void __noreturn ps3_sys_manager_halt(void);
+int ps3_sys_manager_get_wol(void);
+void ps3_sys_manager_set_wol(int state);
 
 struct ps3_prealloc {
     const char *name;

-- 
