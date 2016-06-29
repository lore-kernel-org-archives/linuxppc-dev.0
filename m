Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfT1m6P1QzDqw0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:39:24 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id c74so3391231pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 20:39:24 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: arnd@arndb.de, robh@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 sjitindarsingh@gmail.com
Subject: [PATCH V5 3/3] powerpc/drivers: Add driver for operator panel on FSP
 machines
Date: Wed, 29 Jun 2016 13:38:39 +1000
Message-Id: <1467171519-19882-3-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1467171519-19882-1-git-send-email-sjitindarsingh@gmail.com>
References: <1467171519-19882-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement new character device driver to allow access from user space
to the operator panel display present on IBM Power Systems machines
with FSPs.

This will allow status information to be presented on the display which
is visible to a user.

The driver implements a character buffer which a user can read/write
by accessing the device (/dev/op_panel). This buffer is then displayed on
the operator panel display. Any attempt to write past the last character
position will have no effect and attempts to write more characters than
the size of the display will be truncated. The device may only be accessed
by a single process at a time.

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
V3 -> V4:
	- Various style changes and non-functional code updates
V4 -> V5:
	- Nothing
---
 MAINTAINERS                                    |   6 +
 arch/powerpc/configs/powernv_defconfig         |   1 +
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |   5 +
 drivers/char/Kconfig                           |  14 ++
 drivers/char/Makefile                          |   1 +
 drivers/char/powernv-op-panel.c                | 223 +++++++++++++++++++++++++
 8 files changed, 253 insertions(+)
 create mode 100644 drivers/char/powernv-op-panel.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 952fd2a..42ace38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9094,6 +9094,12 @@ F:	drivers/firmware/psci.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
+POWERNV OPERATOR PANEL LCD DISPLAY DRIVER
+M:	Suraj Jitindar Singh <sjitindarsingh@gmail.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	drivers/char/powernv-op-panel.c
+
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 S:	Maintained
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 0450310..959d32b 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -181,6 +181,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_JSM=m
 CONFIG_VIRTIO_CONSOLE=m
+CONFIG_POWERNV_OP_PANEL=m
 CONFIG_IPMI_HANDLER=y
 CONFIG_IPMI_DEVICE_INTERFACE=y
 CONFIG_IPMI_POWERNV=y
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0d4e690..ea9e7f4 100644
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
index 601f64f..fdb8f3e 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -178,6 +178,20 @@ config IBM_BSR
 	  of threads across a large system which avoids bouncing a cacheline
 	  between several cores on a system
 
+config POWERNV_OP_PANEL
+	tristate "IBM POWERNV Operator Panel Display support"
+	depends on PPC_POWERNV
+	default m
+	help
+	  If you say Y here, a special character device node, /dev/op_panel,
+	  will be created which exposes the operator panel display on IBM
+	  Power Systems machines with FSPs.
+
+	  If you don't require access to the operator panel display from user
+	  space, say N.
+
+	  If unsure, say M here to build it as a module called powernv-op-panel.
+
 source "drivers/char/ipmi/Kconfig"
 
 config DS1620
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index d8a7579..55d16bf 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -60,3 +60,4 @@ js-rtc-y = rtc.o
 
 obj-$(CONFIG_TILE_SROM)		+= tile-srom.o
 obj-$(CONFIG_XILLYBUS)		+= xillybus/
+obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
diff --git a/drivers/char/powernv-op-panel.c b/drivers/char/powernv-op-panel.c
new file mode 100644
index 0000000..a45dabc
--- /dev/null
+++ b/drivers/char/powernv-op-panel.c
@@ -0,0 +1,223 @@
+/*
+ * OPAL Operator Panel Display Driver
+ *
+ * Copyright 2016, Suraj Jitindar Singh, IBM Corporation.
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
+
+/*
+ * This driver creates a character device (/dev/op_panel) which exposes the
+ * operator panel (character LCD display) on IBM Power Systems machines
+ * with FSPs.
+ * A character buffer written to the device will be displayed on the
+ * operator panel.
+ */
+
+static DEFINE_MUTEX(oppanel_mutex);
+
+static u32		num_lines, oppanel_size;
+static oppanel_line_t	*oppanel_lines;
+static char		*oppanel_data;
+
+static loff_t oppanel_llseek(struct file *filp, loff_t offset, int whence)
+{
+	return fixed_size_llseek(filp, offset, whence, oppanel_size);
+}
+
+static ssize_t oppanel_read(struct file *filp, char __user *userbuf, size_t len,
+			    loff_t *f_pos)
+{
+	return simple_read_from_buffer(userbuf, len, f_pos, oppanel_data,
+			oppanel_size);
+}
+
+static int __op_panel_update_display(void)
+{
+	struct opal_msg msg;
+	int rc, token;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		if (token != -ERESTARTSYS)
+			pr_debug("Couldn't get OPAL async token [token=%d]\n",
+				token);
+		return token;
+	}
+
+	rc = opal_write_oppanel_async(token, oppanel_lines, num_lines);
+	switch (rc) {
+	case OPAL_ASYNC_COMPLETION:
+		rc = opal_async_wait_response(token, &msg);
+		if (rc) {
+			pr_debug("Failed to wait for async response [rc=%d]\n",
+				rc);
+			break;
+		}
+		rc = opal_get_async_rc(msg);
+		if (rc != OPAL_SUCCESS) {
+			pr_debug("OPAL async call returned failed [rc=%d]\n",
+				rc);
+			break;
+		}
+	case OPAL_SUCCESS:
+		break;
+	default:
+		pr_debug("OPAL write op-panel call failed [rc=%d]\n", rc);
+	}
+
+	opal_async_release_token(token);
+	return rc;
+}
+
+static ssize_t oppanel_write(struct file *filp, const char __user *userbuf,
+			     size_t len, loff_t *f_pos)
+{
+	loff_t f_pos_prev = *f_pos;
+	ssize_t ret;
+	int rc;
+
+	if (!*f_pos)
+		memset(oppanel_data, ' ', oppanel_size);
+	else if (*f_pos >= oppanel_size)
+		return -EFBIG;
+
+	ret = simple_write_to_buffer(oppanel_data, oppanel_size, f_pos, userbuf,
+			len);
+	if (ret > 0) {
+		rc = __op_panel_update_display();
+		if (rc != OPAL_SUCCESS) {
+			pr_err_ratelimited("OPAL call failed to write to op panel display [rc=%d]\n",
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
+	.name		= "op_panel",
+	.fops		= &oppanel_fops
+};
+
+static int oppanel_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 line_len;
+	int rc, i;
+
+	rc = of_property_read_u32(np, "#length", &line_len);
+	if (rc) {
+		pr_err_ratelimited("Operator panel length property not found\n");
+		return rc;
+	}
+	rc = of_property_read_u32(np, "#lines", &num_lines);
+	if (rc) {
+		pr_err_ratelimited("Operator panel lines property not found\n");
+		return rc;
+	}
+	oppanel_size = line_len * num_lines;
+
+	pr_devel("Operator panel of size %u found with %u lines of length %u\n",
+			oppanel_size, num_lines, line_len);
+
+	oppanel_data = kcalloc(oppanel_size, sizeof(*oppanel_data), GFP_KERNEL);
+	if (!oppanel_data)
+		return -ENOMEM;
+
+	oppanel_lines = kcalloc(num_lines, sizeof(oppanel_line_t), GFP_KERNEL);
+	if (!oppanel_lines) {
+		rc = -ENOMEM;
+		goto free_oppanel_data;
+	}
+
+	memset(oppanel_data, ' ', oppanel_size);
+	for (i = 0; i < num_lines; i++) {
+		oppanel_lines[i].line_len = cpu_to_be64(line_len);
+		oppanel_lines[i].line = cpu_to_be64(__pa(&oppanel_data[i *
+						line_len]));
+	}
+
+	rc = misc_register(&oppanel_dev);
+	if (rc) {
+		pr_err_ratelimited("Failed to register as misc device\n");
+		goto free_oppanel;
+	}
+
+	return 0;
+
+free_oppanel:
+	kfree(oppanel_lines);
+free_oppanel_data:
+	kfree(oppanel_data);
+	return rc;
+}
+
+static int oppanel_remove(struct platform_device *pdev)
+{
+	misc_deregister(&oppanel_dev);
+	kfree(oppanel_lines);
+	kfree(oppanel_data);
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
+		.name		= "powernv-op-panel",
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
2.5.5
