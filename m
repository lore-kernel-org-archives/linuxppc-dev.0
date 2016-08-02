Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Sxy0Xk7zDrKW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 17:48:54 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id q2so11442505pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:48:53 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com
Subject: [RFC] [PATCH 1/3] powernv/opal: Introduce new opal_oppanel interface
 to expose the op_panel
Date: Tue,  2 Aug 2016 17:48:35 +1000
Message-Id: <1470124117-24419-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IBM PowerNV machines with FSPs have an operator panel with a LCD display.
Currently this oppanel display can be accessed through the
powernv_op_panel kernel module. We would like to be able to access this
display easily from other places in the Kernel.

Add a new interface through which the operator panel display can be
accessed from within the kernel. The function opal_oppanel_write acts like
a print function and will respect newline and carriage return characters
while trying to print the input to the display. The function
opal_oppanel_read will provide access to what is currently in the display
buffer.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 MAINTAINERS                                   |   1 +
 arch/powerpc/include/asm/opal.h               |   7 +
 arch/powerpc/platforms/powernv/Kconfig        |   4 +
 arch/powerpc/platforms/powernv/Makefile       |   1 +
 arch/powerpc/platforms/powernv/opal-oppanel.c | 292 ++++++++++++++++++++++++++
 drivers/char/Kconfig                          |   1 +
 6 files changed, 306 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/opal-oppanel.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b1703ca..95841e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9218,6 +9218,7 @@ M:	Suraj Jitindar Singh <sjitindarsingh@gmail.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/char/powernv-op-panel.c
+F:	arch/powerpc/platforms/powernv/opal-oppanel.c
 
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ea9e7f4..2802e1f 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -286,6 +286,13 @@ static inline int opal_get_async_rc(struct opal_msg msg)
 		return be64_to_cpu(msg.params[1]);
 }
 
+#if defined(CONFIG_POWERNV_OP_PANEL) || defined(CONFIG_POWERNV_OP_PANEL_MODULE)
+extern int opal_oppanel_write(char *msg);
+extern void opal_oppanel_read(char *msg);
+extern void opal_oppanel_get_size(u32 *size);
+extern int opal_oppanel_init(void);
+#endif /* CONFIG_POWERNV_OP_PANEL */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 604190c..df325f7 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -26,3 +26,7 @@ config OPAL_PRD
 	help
 	  This enables the opal-prd driver, a facility to run processor
 	  recovery diagnostics on OpenPower machines
+
+config POWERNV_OP_PANEL_BASE
+	bool
+	default n
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index cd9711e..0565351 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
+obj-$(CONFIG_POWERNV_OP_PANEL_BASE)	+= opal-oppanel.o
diff --git a/arch/powerpc/platforms/powernv/opal-oppanel.c b/arch/powerpc/platforms/powernv/opal-oppanel.c
new file mode 100644
index 0000000..1ddf414
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-oppanel.c
@@ -0,0 +1,292 @@
+/*
+ * OPAL PowerNV Operator Panel Display Code
+ *
+ * Copyright 2016, Suraj Jitindar Singh, IBM Corporation.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#include <asm/opal.h>
+
+enum {
+	MODE_LF,
+	MODE_CR,
+	MODE_NC,
+};
+
+static DEFINE_MUTEX(opal_oppanel_mutex);
+
+static u32		num_lines, line_len, buf_len;
+static char		*buf;
+static oppanel_line_t	*lines;
+static int		cursor;
+
+static inline int last_line_index(void)
+{
+	return buf_len - line_len;
+}
+
+/*
+ * oppanel_write_to_display
+ * Write the contents of buf to the physical operator panel LCD display
+ *
+ * @return:	OPAL_SUCCESS on successful write
+ *		else write failed
+ */
+static int oppanel_write_to_display(void)
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
+	rc = opal_write_oppanel_async(token, lines, num_lines);
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
+/*
+ * oppanel_shift_up
+ * Shift the lines in buf up by one
+ */
+static void oppanel_shift_up(void)
+{
+	int i;
+
+	/* Shift line lengths */
+	for (i = 0; i < (num_lines - 1); i++)
+		lines[i].line_len = lines[i+1].line_len;
+
+	/* i = num_lines - 1 -> last line */
+	lines[i].line_len = 0;
+	memcpy(buf, &buf[line_len], line_len * i);
+	memset(&buf[i*line_len], '\0', line_len);
+}
+
+/*
+ * oppanel_update_display
+ * Update the oppanel display based on the current buf and cursor values
+ *
+ * @param:	mode, operation to perform
+ * @return:	OPAL_SUCCESS on success
+ *		else update failed
+ */
+static int oppanel_update_display(int mode)
+{
+	int rc;
+
+	lines[num_lines-1].line_len = cpu_to_be64(cursor + line_len - buf_len);
+	rc = oppanel_write_to_display();
+	/* May still be busy from last write call, if so we should retry */
+	while (rc != OPAL_SUCCESS) {
+		if (rc == OPAL_BUSY_EVENT || rc == -ERESTARTSYS)
+			rc = oppanel_write_to_display();
+		else
+			break;
+	}
+	switch (mode) {
+	case MODE_LF:
+		oppanel_shift_up();
+	case MODE_CR:
+		cursor = last_line_index();
+		break;
+	default:
+		break;
+	}
+
+	return rc;
+}
+
+/*
+ * opal_oppanel_write
+ * Write a message (msg) to the operator panel LCD display present on IBM
+ * powernv machines
+ *
+ * @param:	msg, the message buffer to be written to the display
+ * @return:	0		Success
+ *		-EIO		Opal call failed
+ *		-EBUSY		Resource currently in use
+ *		-ENODEV		Required resources not initialised,
+ *				either init function not called yet
+ *				or init failed likely due to no oppanel
+ */
+int opal_oppanel_write(char *msg)
+{
+	int rc = OPAL_SUCCESS;
+
+	if (!msg || !*msg)
+		return 0;
+	if (!buf || !buf_len || !lines)
+		return -ENODEV;
+
+	if (mutex_trylock(&opal_oppanel_mutex)) {
+		int i, prev_cursor = cursor;
+		char prev_buf[buf_len];
+
+		memcpy(prev_buf, buf, buf_len);
+
+		for (i = 0; msg[i] && rc == OPAL_SUCCESS; i++) {
+			char c = msg[i];
+
+			switch (c) {
+			case '\n':
+				rc = oppanel_update_display(MODE_LF);
+				break;
+			case '\r':
+				if (cursor != last_line_index())
+					rc = oppanel_update_display(MODE_CR);
+				break;
+			default:
+				buf[cursor++] = c;
+				/* End of display line */
+				if (cursor >= buf_len)
+					rc = oppanel_update_display(MODE_LF);
+				/* End of input buffer */
+				else if (!msg[i+1])
+					rc = oppanel_update_display(MODE_NC);
+				break;
+			}
+		}
+
+		if (rc != OPAL_SUCCESS) {
+			cursor = prev_cursor;
+			memcpy(buf, prev_buf, buf_len);
+			rc = -EIO;
+		}
+		mutex_unlock(&opal_oppanel_mutex);
+	} else
+		rc = -EBUSY;
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(opal_oppanel_write);
+
+/*
+ * opal_oppanel_read
+ * Read the operator panel message buffer and copy it to msg
+ *
+ * @param:	msg, a char buffer of size atleast buf_len,
+ *		as obtained by calling opal_oppanel_get_size.
+ */
+void opal_oppanel_read(char *msg)
+{
+	memcpy(msg, buf, buf_len);
+}
+EXPORT_SYMBOL_GPL(opal_oppanel_read);
+
+/*
+ * opal_oppanel_get_size
+ * Get the size of the physical operator panel display
+ *
+ * @param:	size, u32 pointer to where the size value should be stored.
+ */
+void opal_oppanel_get_size(u32 *size)
+{
+	*size = buf_len;
+}
+EXPORT_SYMBOL_GPL(opal_oppanel_get_size);
+
+/*
+ * opal_oppanel_init
+ * Initalise the operator panel, this must be called before any other
+ * function in this file
+ */
+int __init opal_oppanel_init(void)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	int rc, i;
+
+	np = of_find_node_by_path("/ibm,opal/oppanel");
+	if (!np) {
+		pr_err("Opal node 'oppanel' not found\n");
+		rc = -ENODEV;
+		goto np_put;
+	}
+
+	/* Read length and number of lines device tree properties */
+	rc = of_property_read_u32(np, "#length", &line_len);
+	if (rc) {
+		pr_err("Opal node 'oppanel', '#length' property not found\n");
+		goto np_put;
+	}
+	rc = of_property_read_u32(np, "#lines", &num_lines);
+	if (rc) {
+		pr_err("Opal node 'oppanel', '#lines' property not found\n");
+		goto np_put;
+	}
+	buf_len = line_len * num_lines;
+
+	/* Allocate Memory */
+	buf = kcalloc(buf_len, sizeof(*buf), GFP_KERNEL);
+	if (!buf) {
+		rc = -ENOMEM;
+		goto np_put;
+	}
+	lines = kcalloc(num_lines, sizeof(*lines), GFP_KERNEL);
+	if (!lines) {
+		rc = -ENOMEM;
+		goto free_buf;
+	}
+
+	/* Setup lines structure */
+	for (i = 0; i < num_lines; i++) {
+		lines[i].line_len = 0;
+		lines[i].line = cpu_to_be64(__pa(&buf[i * line_len]));
+	}
+	cursor = last_line_index();
+
+	/* Create platform device */
+	pdev = of_platform_device_create(np, NULL, NULL);
+	rc = PTR_ERR_OR_ZERO(pdev);
+	if (rc)
+		goto free_lines;
+
+	/* We still need to node_put on success */
+	rc = 0;
+	goto np_put;
+
+free_lines:
+	kfree(lines);
+free_buf:
+	kfree(buf);
+np_put:
+	of_node_put(np);
+	return rc;
+}
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 5fcb797..95f6885 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -181,6 +181,7 @@ config IBM_BSR
 config POWERNV_OP_PANEL
 	tristate "IBM POWERNV Operator Panel Display support"
 	depends on PPC_POWERNV
+	select POWERNV_OP_PANEL_BASE
 	help
 	  If you say Y here, a special character device node, /dev/op_panel,
 	  will be created which exposes the operator panel display on IBM
-- 
2.5.5
