Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwSTW6hnXzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 17:03:11 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id zy2so9191237pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 00:03:11 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH V3 2/2] powerpc/drivers: Add driver for operator panel on FSP
 machines
Date: Thu, 28 Apr 2016 17:02:38 +1000
Message-Id: <1461826958-3925-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1461826958-3925-1-git-send-email-sjitindarsingh@gmail.com>
References: <1461826958-3925-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement new character device driver to allow access from user space
to the 2x16 character operator panel display present on IBM Power Systems
machines with FSPs.

This will allow status information to be presented on the display which
is visible to a user.

The driver implements a 32 character buffer which a user can read/write
by accessing the device (/dev/oppanel). This buffer is then displayed on
the operator panel display. Any attempt to write past the 32nd position
will have no effect and attempts to write more than 32 characters will be
truncated. The device may only be accessed by a single process at a time.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Change Log:

V1 -> V2:
	- Replace "IBM pSeries machines" with "IBM Power Systems machines
	with FSPs" for improved clarity
	- Basic wording/grammar fixes
V2 -> V3:
	- Nothing
---
 MAINTAINERS                                    |   6 +
 arch/powerpc/configs/powernv_defconfig         |   1 +
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |   5 +
 drivers/char/Kconfig                           |  14 ++
 drivers/char/Makefile                          |   1 +
 drivers/char/op-panel-powernv.c                | 247 +++++++++++++++++++++++++
 8 files changed, 277 insertions(+)
 create mode 100644 drivers/char/op-panel-powernv.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 40eb1db..dbacb12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8817,6 +8817,12 @@ F:	drivers/firmware/psci.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
+POWERNV OPERATOR PANEL LCD DISPLAY DRIVER
+M:	Suraj Jitindar Singh <sjitindarsingh@gmail.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	drivers/char/op-panel-powernv.c
+
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 S:	Maintained
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 0450310..8f9f4ce 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -181,6 +181,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_JSM=m
 CONFIG_VIRTIO_CONSOLE=m
+CONFIG_IBM_OP_PANEL=m
 CONFIG_IPMI_HANDLER=y
 CONFIG_IPMI_DEVICE_INTERFACE=y
 CONFIG_IPMI_POWERNV=y
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9d86c66..b33e349 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -178,6 +178,8 @@ int64_t opal_dump_ack(uint32_t dump_id);
 int64_t opal_dump_resend_notification(void);
 
 int64_t opal_get_msg(uint64_t buffer, uint64_t size);
+int64_t opal_write_oppanel_async(uint64_t token, oppanel_line_t *lines,
+					uint64_t num_lines);
 int64_t opal_check_completion(uint64_t buffer, uint64_t size, uint64_t token);
 int64_t opal_sync_host_reboot(void);
 int64_t opal_get_param(uint64_t token, uint32_t param_id, uint64_t buffer,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e45b88a..ddba8bf 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -278,6 +278,7 @@ OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
 OPAL_CALL(opal_dump_read,			OPAL_DUMP_READ);
 OPAL_CALL(opal_dump_ack,			OPAL_DUMP_ACK);
 OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
+OPAL_CALL(opal_write_oppanel_async,		OPAL_WRITE_OPPANEL_ASYNC);
 OPAL_CALL(opal_check_completion,		OPAL_CHECK_ASYNC_COMPLETION);
 OPAL_CALL(opal_dump_resend_notification,	OPAL_DUMP_RESEND);
 OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 0256d07..228751a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -751,6 +751,9 @@ static int __init opal_init(void)
 	opal_pdev_init(opal_node, "ibm,opal-flash");
 	opal_pdev_init(opal_node, "ibm,opal-prd");
 
+	/* Initialise platform device: oppanel interface */
+	opal_pdev_init(opal_node, "ibm,opal-oppanel");
+
 	/* Initialise OPAL kmsg dumper for flushing console on panic */
 	opal_kmsg_init();
 
@@ -885,3 +888,5 @@ EXPORT_SYMBOL_GPL(opal_i2c_request);
 /* Export these symbols for PowerNV LED class driver */
 EXPORT_SYMBOL_GPL(opal_leds_get_ind);
 EXPORT_SYMBOL_GPL(opal_leds_set_ind);
+/* Export this symbol for PowerNV Operator Panel class driver */
+EXPORT_SYMBOL_GPL(opal_write_oppanel_async);
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 3ec0766..c1d354d 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -178,6 +178,20 @@ config IBM_BSR
 	  of threads across a large system which avoids bouncing a cacheline
 	  between several cores on a system
 
+config IBM_OP_PANEL
+	tristate "IBM POWER Operator Panel Display support"
+	depends on PPC_POWERNV
+	default m
+	help
+	  If you say Y here, a special character device node, /dev/oppanel,
+	  will be created which exposes the operator panel display on IBM
+	  Power Systems machines with FSPs.
+
+	  If you don't require access to the operator panel display from user
+	  space, say N.
+
+	  If unsure, say M here to build it as a module called op-panel-powernv.
+
 source "drivers/char/ipmi/Kconfig"
 
 config DS1620
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index d8a7579..a02c61b 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -60,3 +60,4 @@ js-rtc-y = rtc.o
 
 obj-$(CONFIG_TILE_SROM)		+= tile-srom.o
 obj-$(CONFIG_XILLYBUS)		+= xillybus/
+obj-$(CONFIG_IBM_OP_PANEL)	+= op-panel-powernv.o
diff --git a/drivers/char/op-panel-powernv.c b/drivers/char/op-panel-powernv.c
new file mode 100644
index 0000000..90b74b7
--- /dev/null
+++ b/drivers/char/op-panel-powernv.c
@@ -0,0 +1,247 @@
+/*
+ * OPAL Operator Panel Display Driver
+ *
+ * (C) Copyright IBM Corp. 2016
+ *
+ * Author: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+
+#include <asm/opal.h>
+#include <asm/opal-api.h>
+
+/*
+ * This driver creates a character device (/dev/oppanel) which exposes the
+ * operator panel (2x16 character LCD display) on IBM Power Systems machines
+ * with FSPs.
+ * A 32 character buffer written to the device will be displayed on the
+ * operator panel.
+ */
+
+static DEFINE_MUTEX(oppanel_mutex);
+
+static oppanel_line_t	*oppanel_lines;
+static char		*oppanel_data;
+static u32		line_length, num_lines;
+
+static loff_t oppanel_llseek(struct file *filp, loff_t offset, int whence)
+{
+	return fixed_size_llseek(filp, offset, whence, num_lines *
+		line_length);
+}
+
+static ssize_t oppanel_read(struct file *filp, char __user *userbuf, size_t len,
+		loff_t *f_pos)
+{
+	return simple_read_from_buffer(userbuf, len, f_pos, oppanel_data,
+		(num_lines * line_length));
+}
+
+static int __op_panel_write(void)
+{
+	int rc, token;
+	struct opal_msg msg;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		if (token != -ERESTARTSYS)
+			pr_err("Couldn't get OPAL async token [token=%d]\n",
+				token);
+		return token;
+	}
+
+	rc = opal_write_oppanel_async(token, oppanel_lines, (u64) num_lines);
+	switch (rc) {
+	case OPAL_ASYNC_COMPLETION:
+		rc = opal_async_wait_response(token, &msg);
+		if (rc) {
+			pr_err("Failed to wait for async response [rc=%d]\n",
+				rc);
+			goto out_token;
+		}
+		rc = be64_to_cpu(msg.params[1]);
+		if (rc != OPAL_SUCCESS) {
+			pr_err("OPAL async call returned failed [rc=%d]\n", rc);
+			goto out_token;
+		}
+	case OPAL_SUCCESS:
+		break;
+	default:
+		pr_err("OPAL write op-panel call failed [rc=%d]\n", rc);
+	}
+
+out_token:
+	opal_async_release_token(token);
+	return rc;
+}
+
+static ssize_t oppanel_write(struct file *filp, const char __user *userbuf,
+		size_t len, loff_t *f_pos)
+{
+	ssize_t ret;
+	loff_t f_pos_prev = *f_pos;
+	int rc;
+
+	if (*f_pos >= (num_lines * line_length))
+		return -EFBIG;
+
+	ret = simple_write_to_buffer(oppanel_data, (num_lines *
+			line_length), f_pos, userbuf, len);
+	if (ret > 0) {
+		rc = __op_panel_write();
+		if (rc != OPAL_SUCCESS) {
+			pr_err("OPAL call failed to write to op panel display [rc=%d]\n",
+				rc);
+			*f_pos = f_pos_prev;
+			return -EIO;
+		}
+	}
+	return ret;
+}
+
+static int oppanel_open(struct inode *inode, struct file *filp)
+{
+	if (!mutex_trylock(&oppanel_mutex)) {
+		pr_debug("Device Busy\n");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static int oppanel_release(struct inode *inode, struct file *filp)
+{
+	mutex_unlock(&oppanel_mutex);
+	return 0;
+}
+
+static const struct file_operations oppanel_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= oppanel_llseek,
+	.read		= oppanel_read,
+	.write		= oppanel_write,
+	.open		= oppanel_open,
+	.release	= oppanel_release
+};
+
+static struct miscdevice oppanel_dev = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "oppanel",
+	.fops		= &oppanel_fops
+};
+
+static int oppanel_probe(struct platform_device *pdev)
+{
+	int rc, i;
+	struct device_node *dev_node = pdev->dev.of_node;
+	const u32 *length_val, *lines_val;
+
+	if (strncmp(dev_node->name, "oppanel", 7)) {
+		pr_err("Operator panel not found\n");
+		return -1;
+	}
+
+	length_val = of_get_property(dev_node, "#length", NULL);
+	if (!length_val) {
+		pr_err("Operator panel length property not found\n");
+		return -1;
+	}
+	line_length = be32_to_cpu(*length_val);
+	lines_val = of_get_property(dev_node, "#lines", NULL);
+	if (!lines_val) {
+		pr_err("Operator panel lines property not found\n");
+		return -1;
+	}
+	num_lines = be32_to_cpu(*lines_val);
+
+	pr_debug("Operator panel found with %u lines of length %u\n",
+			num_lines, line_length);
+
+	oppanel_data = kcalloc((num_lines * line_length), sizeof(char),
+		GFP_KERNEL);
+	if (!oppanel_data)
+		return -ENOMEM;
+
+	oppanel_lines = kcalloc(num_lines, sizeof(oppanel_line_t), GFP_KERNEL);
+	if (!oppanel_lines) {
+		kfree(oppanel_data);
+		return -ENOMEM;
+	}
+
+	memset(oppanel_data, ' ', (num_lines * line_length));
+	for (i = 0; i < num_lines; i++) {
+		oppanel_lines[i].line_len = cpu_to_be64((u64) line_length);
+		oppanel_lines[i].line = cpu_to_be64((u64) &oppanel_data[i *
+						line_length]);
+	}
+
+	mutex_init(&oppanel_mutex);
+
+	rc = misc_register(&oppanel_dev);
+	if (rc) {
+		pr_err("Failed to register as misc device\n");
+		goto remove_mutex;
+	}
+
+	pr_info("Device Successfully Initialised\n");
+	return 0;
+
+remove_mutex:
+	mutex_destroy(&oppanel_mutex);
+	kfree(oppanel_lines);
+	kfree(oppanel_data);
+	return rc;
+}
+
+static int oppanel_remove(struct platform_device *pdev)
+{
+	misc_deregister(&oppanel_dev);
+	mutex_destroy(&oppanel_mutex);
+	kfree(oppanel_lines);
+	kfree(oppanel_data);
+	pr_info("Device Successfully Removed\n");
+	return 0;
+}
+
+static const struct of_device_id oppanel_match[] = {
+	{ .compatible = "ibm,opal-oppanel" },
+	{ },
+};
+
+static struct platform_driver oppanel_driver = {
+	.driver	= {
+		.name		= "op-panel-powernv",
+		.of_match_table	= oppanel_match,
+	},
+	.probe	= oppanel_probe,
+	.remove	= oppanel_remove,
+};
+
+module_platform_driver(oppanel_driver);
+
+MODULE_DEVICE_TABLE(of, oppanel_match);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("PowerNV Operator Panel LCD Display Driver");
+MODULE_AUTHOR("Suraj Jitindar Singh <sjitindarsingh@gmail.com>");
-- 
2.5.0
