Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E47B5DDE27
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 07:20:16 +1100 (EST)
Message-ID: <45CA3471.6020109@am.sony.com>
Date: Wed, 07 Feb 2007 12:20:01 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3 v2] PS3: System manager support
References: <45C8FFF7.7090805@am.sony.com>
In-Reply-To: <45C8FFF7.7090805@am.sony.com>
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

Add PS3 system manager support and the ppc_md routines restart() and
power_off().

The system manager provides an event notification mechanism for reporting
events like thermal alert and button presses.  It also provides support to
control system shutdown and startup.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
Version 2.

I removed the half-cooked loadable module support as pointed out by Michael.
As suggested by Geert, I'll make a seperate patch sometime to move the
non-smp smp_send_stop() to include/linx/smp.h.

This patch set of three should be ready for inclusion in 2.6.21.

-Geoff


 arch/powerpc/platforms/ps3/Kconfig |   10 
 arch/powerpc/platforms/ps3/setup.c |   27 +
 drivers/ps3/Makefile               |    1 
 drivers/ps3/sys-manager.c          |  604 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/ps3.h          |    5 
 5 files changed, 643 insertions(+), 4 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/Kconfig
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/Kconfig
@@ -61,4 +61,14 @@ config PS3_PS3AV
 	  This support is required for graphics and sound. In
 	  general, all users will say Y or M.
 
+config PS3_SYS_MANAGER
+	bool "PS3 System Manager driver"
+	select PS3_VUART
+	default y
+	help
+	  Include support for the PS3 System Manager.
+
+	  This support is required for system control.  In
+	  general, all users will say Y.
+
 endmenu
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
@@ -42,6 +42,10 @@
 #define DBG(fmt...) do{if(0)printk(fmt);}while(0)
 #endif
 
+#if !defined(CONFIG_SMP)
+static void smp_send_stop(void) {}
+#endif
+
 int ps3_get_firmware_version(union ps3_firmware_version *v)
 {
 	int result = lv1_get_version_info(&v->raw);
@@ -66,22 +70,35 @@ static void ps3_power_save(void)
 	lv1_pause(0);
 }
 
+static void ps3_restart(char *cmd)
+{
+	DBG("%s:%d cmd '%s'\n", __func__, __LINE__, cmd);
+
+	smp_send_stop();
+	ps3_sys_manager_restart(); /* never returns */
+}
+
+static void ps3_power_off(void)
+{
+	DBG("%s:%d\n", __func__, __LINE__);
+
+	smp_send_stop();
+	ps3_sys_manager_power_off(); /* never returns */
+}
+
 static void ps3_panic(char *str)
 {
 	DBG("%s:%d %s\n", __func__, __LINE__, str);
 
-#ifdef CONFIG_SMP
 	smp_send_stop();
-#endif
 	printk("\n");
 	printk("   System does not reboot automatically.\n");
 	printk("   Please press POWER button.\n");
 	printk("\n");
 
-	for (;;) ;
+	while(1);
 }
 
-
 static void prealloc(struct ps3_prealloc *p)
 {
 	if (!p->size)
@@ -219,6 +236,8 @@ define_machine(ps3) {
 	.get_rtc_time			= ps3_get_rtc_time,
 	.calibrate_decr			= ps3_calibrate_decr,
 	.progress			= ps3_progress,
+	.restart			= ps3_restart,
+	.power_off			= ps3_power_off,
 #if defined(CONFIG_KEXEC)
 	.kexec_cpu_down			= ps3_kexec_cpu_down,
 	.machine_kexec			= ps3_machine_kexec,
--- ps3-linux-dev.orig/drivers/ps3/Makefile
+++ ps3-linux-dev/drivers/ps3/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PS3_VUART) += vuart.o
 obj-$(CONFIG_PS3_PS3AV) += ps3av.o ps3av_cmd.o
+obj-$(CONFIG_PS3_SYS_MANAGER) += sys-manager.o
--- /dev/null
+++ ps3-linux-dev/drivers/ps3/sys-manager.c
@@ -0,0 +1,604 @@
+/*
+ *  PS3 System Manager.
+ *
+ *  Copyright (C) 2007 Sony Computer Entertainment Inc.
+ *  Copyright 2007 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/workqueue.h>
+#include <linux/reboot.h>
+#include <asm/ps3.h>
+#include "vuart.h"
+
+MODULE_AUTHOR("Sony Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("PS3 System Manager");
+
+/**
+ * ps3_sys_manager - PS3 system manager driver.
+ *
+ * The system manager provides an asyncronous system event notification
+ * mechanism for reporting events like thermal alert and button presses to
+ * guests.  It also provides support to control system shutdown and startup.
+ *
+ * The actual system manager is implemented as an application running in the
+ * system policy module in lpar_1.  Guests communicate with the system manager
+ * through port 2 of the vuart using a simple packet message protocol.
+ * Messages are comprised of a fixed field header followed by a message
+ * specific payload.
+ */
+
+/**
+ * struct ps3_sys_manager_header - System manager message header.
+ * @version: Header version, currently 1.
+ * @size: Header size in bytes, curently 16.
+ * @payload_size: Message payload size in bytes.
+ * @service_id: Message type, one of enum ps3_sys_manager_service_id.
+ */
+
+struct ps3_sys_manager_header {
+	/* version 1 */
+	u8 version;
+	u8 size;
+	u16 reserved_1;
+	u32 payload_size;
+	u16 service_id;
+	u16 reserved_2[3];
+};
+
+/**
+ * @PS3_SM_RX_MSG_LEN - System manager received message length.
+ *
+ * Currently all messages received from the system manager are the same length
+ * (16 bytes header + 16 bytes payload = 32 bytes).  This knowlege is used to
+ * simplify the logic.
+ */
+
+enum {
+	PS3_SM_RX_MSG_LEN = 32,
+};
+
+/**
+ * enum ps3_sys_manager_service_id - Message header service_id.
+ * @PS3_SM_SERVICE_ID_REQUEST:      guest --> sys_manager.
+ * @PS3_SM_SERVICE_ID_COMMAND:      guest <-- sys_manager.
+ * @PS3_SM_SERVICE_ID_RESPONSE:     guest --> sys_manager.
+ * @PS3_SM_SERVICE_ID_SET_ATTR:     guest --> sys_manager.
+ * @PS3_SM_SERVICE_ID_EXTERN_EVENT: guest <-- sys_manager.
+ * @PS3_SM_SERVICE_ID_SET_NEXT_OP:  guest --> sys_manager.
+ */
+
+enum ps3_sys_manager_service_id {
+	/* version 1 */
+	PS3_SM_SERVICE_ID_REQUEST = 1,
+	PS3_SM_SERVICE_ID_RESPONSE = 2,
+	PS3_SM_SERVICE_ID_COMMAND = 3,
+	PS3_SM_SERVICE_ID_EXTERN_EVENT = 4,
+	PS3_SM_SERVICE_ID_SET_NEXT_OP = 5,
+	PS3_SM_SERVICE_ID_SET_ATTR = 8,
+};
+
+/**
+ * enum ps3_sys_manager_attr - Notification attribute (bit position mask).
+ * @PS3_SM_ATTR_POWER: Power button.
+ * @PS3_SM_ATTR_RESET: Reset button, not available on retail console.
+ * @PS3_SM_ATTR_THERMAL: Sytem thermal alert.
+ * @PS3_SM_ATTR_CONTROLLER: Remote controller event.
+ * @PS3_SM_ATTR_ALL: Logical OR of all.
+ *
+ * The guest tells the system manager which events it is interested in receiving
+ * notice of by sending the system manager a logical OR of notification
+ * attributes via the ps3_sys_manager_send_attr() routine.
+ */
+
+enum ps3_sys_manager_attr {
+	/* version 1 */
+	PS3_SM_ATTR_POWER = 1,
+	PS3_SM_ATTR_RESET = 2,
+	PS3_SM_ATTR_THERMAL = 4,
+	PS3_SM_ATTR_CONTROLLER = 8, /* bogus? */
+	PS3_SM_ATTR_ALL = 0x0f,
+};
+
+/**
+ * enum ps3_sys_manager_event - External event type, reported by system manager.
+ * @PS3_SM_EVENT_POWER_PRESSED: payload.value not used.
+ * @PS3_SM_EVENT_POWER_RELEASED: payload.value = time pressed in millisec.
+ * @PS3_SM_EVENT_RESET_PRESSED: payload.value not used.
+ * @PS3_SM_EVENT_RESET_RELEASED: payload.value = time pressed in millisec.
+ * @PS3_SM_EVENT_THERMAL_ALERT: payload.value = thermal zone id.
+ * @PS3_SM_EVENT_THERMAL_CLEARED: payload.value = thermal zone id.
+ */
+
+enum ps3_sys_manager_event {
+	/* version 1 */
+	PS3_SM_EVENT_POWER_PRESSED = 3,
+	PS3_SM_EVENT_POWER_RELEASED = 4,
+	PS3_SM_EVENT_RESET_PRESSED = 5,
+	PS3_SM_EVENT_RESET_RELEASED = 6,
+	PS3_SM_EVENT_THERMAL_ALERT = 7,
+	PS3_SM_EVENT_THERMAL_CLEARED = 8,
+	/* no info on controller events */
+};
+
+/**
+ * enum ps3_sys_manager_next_op - Operation to perform after lpar is destroyed.
+ */
+
+enum ps3_sys_manager_next_op {
+	/* version 3 */
+	PS3_SM_NEXT_OP_SYS_SHUTDOWN = 1,
+	PS3_SM_NEXT_OP_SYS_REBOOT = 2,
+	PS3_SM_NEXT_OP_LPAR_REBOOT = 0x82,
+};
+
+/**
+ * enum ps3_sys_manager_wake_source - Next-op wakeup source (bit position mask).
+ * @PS3_SM_WAKE_DEFAULT: Disk insert, power button, eject button, IR
+ * controller, and bluetooth controller.
+ * @PS3_SM_WAKE_RTC:
+ * @PS3_SM_WAKE_RTC_ERROR:
+ * @PS3_SM_WAKE_P_O_R: Power on reset.
+ *
+ * Additional wakeup sources when specifying PS3_SM_NEXT_OP_SYS_SHUTDOWN.
+ * System will always wake from the PS3_SM_WAKE_DEFAULT sources.
+ */
+
+enum ps3_sys_manager_wake_source {
+	/* version 3 */
+	PS3_SM_WAKE_DEFAULT   = 0,
+	PS3_SM_WAKE_RTC       = 0x00000040,
+	PS3_SM_WAKE_RTC_ERROR = 0x00000080,
+	PS3_SM_WAKE_P_O_R     = 0x10000000,
+};
+
+/**
+ * enum ps3_sys_manager_cmd - Command from system manager to guest.
+ *
+ * The guest completes the actions needed, then acks or naks the command via
+ * ps3_sys_manager_send_response().  In the case of @PS3_SM_CMD_SHUTDOWN,
+ * the guest must be fully prepared for a system poweroff prior to acking the
+ * command.
+ */
+
+enum ps3_sys_manager_cmd {
+	/* version 1 */
+	PS3_SM_CMD_SHUTDOWN = 1, /* shutdown guest OS */
+};
+
+/**
+ * ps3_sys_manager_write - Helper to write a two part message to the vuart.
+ *
+ */
+
+static int ps3_sys_manager_write(struct ps3_vuart_port_device *dev,
+	const struct ps3_sys_manager_header *header, const void *payload)
+{
+	int result;
+
+	BUG_ON(header->version != 1);
+	BUG_ON(header->size != 16);
+	BUG_ON(header->payload_size != 8 && header->payload_size != 16);
+	BUG_ON(header->service_id > 8);
+
+	result = ps3_vuart_write(dev, header,
+		sizeof(struct ps3_sys_manager_header));
+
+	if (!result)
+		result = ps3_vuart_write(dev, payload, header->payload_size);
+
+	return result;
+}
+
+/**
+ * ps3_sys_manager_send_attr - Send a 'set attribute' to the system manager.
+ *
+ */
+
+static int ps3_sys_manager_send_attr(struct ps3_vuart_port_device *dev,
+	enum ps3_sys_manager_attr attr)
+{
+	static const struct ps3_sys_manager_header header = {
+		.version = 1,
+		.size = 16,
+		.payload_size = 16,
+		.service_id = PS3_SM_SERVICE_ID_SET_ATTR,
+	};
+	struct {
+		u8 version;
+		u8 reserved_1[3];
+		u32 attribute;
+	} payload;
+
+	BUILD_BUG_ON(sizeof(payload) != 8);
+
+	dev_dbg(&dev->core, "%s:%d: %xh\n", __func__, __LINE__, attr);
+
+	memset(&payload, 0, sizeof(payload));
+	payload.version = 1;
+	payload.attribute = attr;
+
+	return ps3_sys_manager_write(dev, &header, &payload);
+}
+
+/**
+ * ps3_sys_manager_send_next_op - Send a 'set next op' to the system manager.
+ *
+ * Tell the system manager what to do after this lpar is destroyed.
+ */
+
+static int ps3_sys_manager_send_next_op(struct ps3_vuart_port_device *dev,
+	enum ps3_sys_manager_next_op op,
+	enum ps3_sys_manager_wake_source wake_source)
+{
+	static const struct ps3_sys_manager_header header = {
+		.version = 1,
+		.size = 16,
+		.payload_size = 16,
+		.service_id = PS3_SM_SERVICE_ID_SET_NEXT_OP,
+	};
+	struct {
+		u8 version;
+		u8 type;
+		u8 gos_id;
+		u8 reserved_1;
+		u32 wake_source;
+		u8 reserved_2[8];
+	} payload;
+
+	BUILD_BUG_ON(sizeof(payload) != 16);
+
+	dev_dbg(&dev->core, "%s:%d: (%xh)\n", __func__, __LINE__, op);
+
+	memset(&payload, 0, sizeof(payload));
+	payload.version = 3;
+	payload.type = op;
+	payload.gos_id = 3; /* other os */
+	payload.wake_source = wake_source;
+
+	return ps3_sys_manager_write(dev, &header, &payload);
+}
+
+/**
+ * ps3_sys_manager_send_request_shutdown - Send 'request' to the system manager.
+ *
+ * The guest sends this message to request an operation or action of the system
+ * manager.  The reply is a command message from the system manager.  In the
+ * command handler the guest performs the requested operation.  The result of
+ * the command is then communicated back to the system manager with a response
+ * message.
+ *
+ * Currently, the only supported request it the 'shutdown self' request.
+ */
+
+static int ps3_sys_manager_send_request_shutdown(struct ps3_vuart_port_device *dev)
+{
+	static const struct ps3_sys_manager_header header = {
+		.version = 1,
+		.size = 16,
+		.payload_size = 16,
+		.service_id = PS3_SM_SERVICE_ID_REQUEST,
+	};
+	struct {
+		u8 version;
+		u8 type;
+		u8 gos_id;
+		u8 reserved_1[13];
+	} static const payload = {
+		.version = 1,
+		.type = 1, /* shutdown */
+		.gos_id = 0, /* self */
+	};
+
+	BUILD_BUG_ON(sizeof(payload) != 16);
+
+	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
+
+	return ps3_sys_manager_write(dev, &header, &payload);
+}
+
+/**
+ * ps3_sys_manager_send_response - Send a 'response' to the system manager.
+ * @status: zero = success, others fail.
+ *
+ * The guest sends this message to the system manager to acnowledge success or
+ * failure of a command sent by the system manager.
+ */
+
+static int ps3_sys_manager_send_response(struct ps3_vuart_port_device *dev,
+	u64 status)
+{
+	static const struct ps3_sys_manager_header header = {
+		.version = 1,
+		.size = 16,
+		.payload_size = 16,
+		.service_id = PS3_SM_SERVICE_ID_RESPONSE,
+	};
+	struct {
+		u8 version;
+		u8 reserved_1[3];
+		u8 status;
+		u8 reserved_2[11];
+	} payload;
+
+	BUILD_BUG_ON(sizeof(payload) != 16);
+
+	dev_dbg(&dev->core, "%s:%d: (%s)\n", __func__, __LINE__,
+		(status ? "nak" : "ack"));
+
+	memset(&payload, 0, sizeof(payload));
+	payload.version = 1;
+	payload.status = status;
+
+	return ps3_sys_manager_write(dev, &header, &payload);
+}
+
+/**
+ * ps3_sys_manager_handle_event - Second stage event msg handler.
+ *
+ */
+
+static int ps3_sys_manager_handle_event(struct ps3_vuart_port_device *dev)
+{
+	int result;
+	struct {
+		u8 version;
+		u8 type;
+		u8 reserved_1[2];
+		u32 value;
+		u8 reserved_2[8];
+	} event;
+
+	BUILD_BUG_ON(sizeof(event) != 16);
+
+	result = ps3_vuart_read(dev, &event, sizeof(event));
+	BUG_ON(result);
+
+	if (event.version != 1) {
+		dev_dbg(&dev->core, "%s:%d: unsupported event version (%u)\n",
+			__func__, __LINE__, event.version);
+		return -EIO;
+	}
+
+	switch (event.type) {
+	case PS3_SM_EVENT_POWER_PRESSED:
+		dev_dbg(&dev->core, "%s:%d: POWER_PRESSED\n",
+			__func__, __LINE__);
+		break;
+	case PS3_SM_EVENT_POWER_RELEASED:
+		dev_dbg(&dev->core, "%s:%d: POWER_RELEASED (%u ms)\n",
+			__func__, __LINE__, event.value);
+		kill_cad_pid(SIGINT, 1);
+		break;
+	case PS3_SM_EVENT_THERMAL_ALERT:
+		dev_dbg(&dev->core, "%s:%d: THERMAL_ALERT (zone %u)\n",
+			__func__, __LINE__, event.value);
+		printk(KERN_INFO "PS3 Thermal Alert Zone %u\n", event.value);
+		break;
+	case PS3_SM_EVENT_THERMAL_CLEARED:
+		dev_dbg(&dev->core, "%s:%d: THERMAL_CLEARED (zone %u)\n",
+			__func__, __LINE__, event.value);
+		break;
+	default:
+		dev_dbg(&dev->core, "%s:%d: unknown event (%u)\n",
+			__func__, __LINE__, event.type);
+		return -EIO;
+	}
+
+	return 0;
+}
+/**
+ * ps3_sys_manager_handle_cmd - Second stage command msg handler.
+ *
+ * The system manager sends this in reply to a 'request' message from the guest.
+ */
+
+static int ps3_sys_manager_handle_cmd(struct ps3_vuart_port_device *dev)
+{
+	int result;
+	struct {
+		u8 version;
+		u8 type;
+		u8 reserved_1[14];
+	} cmd;
+
+	BUILD_BUG_ON(sizeof(cmd) != 16);
+
+	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
+
+	result = ps3_vuart_read(dev, &cmd, sizeof(cmd));
+
+	if(result)
+		return result;
+
+	if (cmd.version != 1) {
+		dev_dbg(&dev->core, "%s:%d: unsupported cmd version (%u)\n",
+			__func__, __LINE__, cmd.version);
+		return -EIO;
+	}
+
+	if (cmd.type != PS3_SM_CMD_SHUTDOWN) {
+		dev_dbg(&dev->core, "%s:%d: unknown cmd (%u)\n",
+			__func__, __LINE__, cmd.type);
+		return -EIO;
+	}
+
+	ps3_sys_manager_send_response(dev, 0);
+	return 0;
+}
+
+/**
+ * ps3_sys_manager_handle_msg - First stage msg handler.
+ *
+ */
+
+static int ps3_sys_manager_handle_msg(struct ps3_vuart_port_device *dev)
+{
+	int result;
+	struct ps3_sys_manager_header header;
+
+	result = ps3_vuart_read(dev, &header,
+		sizeof(struct ps3_sys_manager_header));
+
+	if(result)
+		return result;
+
+	if (header.version != 1) {
+		dev_dbg(&dev->core, "%s:%d: unsupported header version (%u)\n",
+			__func__, __LINE__, header.version);
+		goto fail_header;
+	}
+
+	BUILD_BUG_ON(sizeof(header) != 16);
+	BUG_ON(header.size != 16);
+	BUG_ON(header.payload_size != 16);
+
+	switch (header.service_id) {
+	case PS3_SM_SERVICE_ID_EXTERN_EVENT:
+		dev_dbg(&dev->core, "%s:%d: EVENT\n", __func__, __LINE__);
+		return ps3_sys_manager_handle_event(dev);
+	case PS3_SM_SERVICE_ID_COMMAND:
+		dev_dbg(&dev->core, "%s:%d: COMMAND\n", __func__, __LINE__);
+		return ps3_sys_manager_handle_cmd(dev);
+	default:
+		dev_dbg(&dev->core, "%s:%d: unknown service_id (%u)\n",
+			__func__, __LINE__, header.service_id);
+		break;
+	}
+	goto fail_id;
+
+fail_header:
+	ps3_vuart_clear_rx_bytes(dev, 0);
+	return -EIO;
+fail_id:
+	ps3_vuart_clear_rx_bytes(dev, header.payload_size);
+	return -EIO;
+}
+
+/**
+ * ps3_sys_manager_work - Asyncronous read handler.
+ *
+ * Signaled when a complete message arrives at the vuart port.
+ */
+
+static void ps3_sys_manager_work(struct work_struct *work)
+{
+	struct ps3_vuart_port_device *dev = ps3_vuart_work_to_port_device(work);
+
+	ps3_sys_manager_handle_msg(dev);
+	ps3_vuart_read_async(dev, ps3_sys_manager_work, PS3_SM_RX_MSG_LEN);
+}
+
+struct {
+	struct ps3_vuart_port_device *dev;
+} static drv_priv;
+
+/**
+ * ps3_sys_manager_restart - The final platform machine_restart routine.
+ *
+ * This routine never returns.  The routine disables asyncronous vuart reads
+ * then spins calling ps3_sys_manager_handle_msg() to receive and acknowledge
+ * the shutdown command sent from the system manager.  Soon after the
+ * acknowledgement is sent the lpar is destroyed by the HV.  This routine
+ * should only be called from ps3_restart().
+ */
+
+void ps3_sys_manager_restart(void)
+{
+	struct ps3_vuart_port_device *dev = drv_priv.dev;
+
+	BUG_ON(!drv_priv.dev);
+
+	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
+
+	ps3_vuart_cancel_async(dev);
+
+	ps3_sys_manager_send_attr(dev, 0);
+	ps3_sys_manager_send_next_op(dev, PS3_SM_NEXT_OP_LPAR_REBOOT,
+		PS3_SM_WAKE_DEFAULT);
+	ps3_sys_manager_send_request_shutdown(dev);
+
+	printk(KERN_EMERG "System Halted, OK to turn off power\n");
+
+	while(1)
+		ps3_sys_manager_handle_msg(dev);
+}
+
+/**
+ * ps3_sys_manager_power_off - The final platform machine_power_off routine.
+ *
+ * This routine never returns.  The routine disables asyncronous vuart reads
+ * then spins calling ps3_sys_manager_handle_msg() to receive and acknowledge
+ * the shutdown command sent from the system manager.  Soon after the
+ * acknowledgement is sent the lpar is destroyed by the HV.  This routine
+ * should only be called from ps3_power_off().
+ */
+
+void ps3_sys_manager_power_off(void)
+{
+	struct ps3_vuart_port_device *dev = drv_priv.dev;
+
+	BUG_ON(!drv_priv.dev);
+
+	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
+
+	ps3_vuart_cancel_async(dev);
+
+	ps3_sys_manager_send_next_op(dev, PS3_SM_NEXT_OP_SYS_SHUTDOWN,
+		PS3_SM_WAKE_DEFAULT);
+	ps3_sys_manager_send_request_shutdown(dev);
+
+	printk(KERN_EMERG "System Halted, OK to turn off power\n");
+
+	while(1)
+		ps3_sys_manager_handle_msg(dev);
+}
+
+static int ps3_sys_manager_probe(struct ps3_vuart_port_device *dev)
+{
+	int result;
+
+	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
+
+	BUG_ON(drv_priv.dev);
+	drv_priv.dev = dev;
+
+	result = ps3_sys_manager_send_attr(dev, PS3_SM_ATTR_ALL);
+	BUG_ON(result);
+
+	result = ps3_vuart_read_async(dev, ps3_sys_manager_work,
+		PS3_SM_RX_MSG_LEN);
+	BUG_ON(result);
+
+	return result;
+}
+
+static struct ps3_vuart_port_driver ps3_sys_manager = {
+	.match_id = PS3_MATCH_ID_SYSTEM_MANAGER,
+	.core = {
+		.name = "ps3_sys_manager",
+	},
+	.probe = ps3_sys_manager_probe,
+};
+
+static int __init ps3_sys_manager_init(void)
+{
+	return ps3_vuart_port_driver_register(&ps3_sys_manager);
+}
+
+module_init(ps3_sys_manager_init);
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -370,6 +370,11 @@ struct ps3_vuart_port_device {
 
 int ps3_vuart_port_device_register(struct ps3_vuart_port_device *dev);
 
+/* system manager */
+
+void ps3_sys_manager_restart(void);
+void ps3_sys_manager_power_off(void);
+
 struct ps3_prealloc {
     const char *name;
     void *address;
