Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D249DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 17:56:47 +1000 (EST)
Date: Thu, 27 Sep 2007 16:56:31 +0900 (JST)
Message-Id: <20070927.165631.-1300533671.kouish@swc.toshiba.co.jp>
Subject: [PATCH 5/7] Celleb: Supports VFD on Celleb 2
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a patch to support VFD on Celleb 2.
VFD is a small LCD to show miscellaneous messages.

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/Kconfig
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/Kconfig
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/Kconfig
@@ -7,3 +7,9 @@ config PPC_CELLEB
 	select PPC_UDBG_BEAT
 	select USB_OHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select PPC_RTAS
+
+config PPC_CELLEB2_INDICATOR
+	tristate "Support for Toshiba's Cell Reference Set 'Celleb 2's VFD"
+	default m
+	depends on PPC_CELLEB
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/Makefile
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
 obj-$(CONFIG_SERIAL_TXX9)	+= scc_sio.o
 obj-$(CONFIG_SPU_BASE)		+= spu_priv1.o
+obj-$(CONFIG_PPC_CELLEB2_INDICATOR)	+= indicator.o
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/indicator.c
===================================================================
--- /dev/null
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/indicator.c
@@ -0,0 +1,202 @@
+/*
+ * LED/VFD support for Celleb
+ *
+ * (C) Copyright 2007 TOSHIBA CORPORATION
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
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/uaccess.h>
+
+#include <asm/rtas.h>
+#include <asm/machdep.h>
+#include <asm/semaphore.h>
+
+static const u32 *display_cols;
+static u32 display_width, display_lines;
+static u32 token_display_character, token_set_indicator;
+static DECLARE_MUTEX(display_lock);
+static DECLARE_MUTEX(indicator_lock);
+
+static int celleb_display_show(struct seq_file *m, void *v)
+{
+	u32 i;
+
+	seq_printf(m, "--- Celleb Subdisplay ---\n");
+	seq_printf(m, "Lines: %u\n", display_lines);
+	if (display_cols)
+		for (i = 0; i < display_lines; i++)
+			seq_printf(m, "Columns(%u): %u\n", i, display_cols[i]);
+	else
+		seq_printf(m, "Columns(All): %u\n", display_width);
+	return 0;
+}
+
+static ssize_t celleb_display_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	int rc;
+	size_t i;
+	char d;
+
+	rc = down_interruptible(&indicator_lock);
+	if (rc != 0)
+		return rc;
+	for (i = 0; i < count; i++) {
+		rc = get_user(d, &buf[i]);
+		if (rc != 0) {
+			up(&display_lock);
+			return rc;
+		}
+		do {
+			rc = rtas_call(token_display_character, 1, 1, NULL, d);
+		} while (rtas_busy_delay(rc));
+	}
+	up(&display_lock);
+	return i;
+}
+
+static int celleb_display_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, celleb_display_show, NULL);
+}
+
+static int celleb_indicator_show(struct seq_file *m, void *v)
+{
+	return 0;
+}
+
+static ssize_t celleb_indicator_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	int rc;
+	size_t i;
+	char d;
+
+	rc = down_interruptible(&indicator_lock);
+	if (rc != 0)
+		return rc;
+	for (i = 0; i < count; i++) {
+		rc = get_user(d, &buf[i]);
+		if (rc != 0) {
+			up(&indicator_lock);
+			return rc;
+		}
+		do {
+			rc = rtas_call(token_set_indicator, 1, 1, NULL, d);
+		} while (rtas_busy_delay(rc));
+	}
+	up(&indicator_lock);
+	return i;
+}
+
+static int celleb_indicator_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, celleb_indicator_show, NULL);
+}
+
+const struct file_operations celleb_display_operations = {
+	.open		= celleb_display_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.write		= celleb_display_write,
+	.release	= single_release,
+};
+
+const struct file_operations celleb_indicator_operations = {
+	.open		= celleb_indicator_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.write		= celleb_indicator_write,
+	.release	= single_release,
+};
+
+static int __init celleb_indicator_init(void)
+{
+	struct device_node *rtas_node = NULL;
+	struct proc_dir_entry *entry;
+	const u32 *p;
+
+	if (!machine_is(celleb))
+		return -ENODEV;
+
+	rtas_node = of_find_node_by_name(NULL, "rtas");
+	if (rtas_node == NULL)
+		return -ENODEV;
+
+	display_cols = of_get_property(rtas_node,
+		"ibm,display-truncation-length", NULL);
+	if ((p = of_get_property(rtas_node,
+		"ibm,display-line-length", NULL)) != NULL)
+		display_width = *p;
+	else
+		display_width = 0;
+	if ((p = of_get_property(rtas_node,
+		"ibm,display-number-of-lines", NULL)) != NULL)
+		display_lines = *p;
+	else
+		display_lines = 0;
+
+	if ((p = of_get_property(rtas_node,
+		"display-character", NULL)) != NULL)
+		token_display_character = *p;
+	else
+		token_display_character = 0;
+
+	if ((p = of_get_property(rtas_node,
+		"set-indicator", NULL)) != NULL)
+		token_set_indicator = *p;
+	else
+		token_set_indicator = 0;
+
+	if (token_display_character != 0
+		&& display_lines != 0
+		&& (display_width != 0 || display_cols)) {
+		entry = create_proc_entry("ppc64/rtas/toshiba,display",
+			S_IRUGO|S_IWUSR, NULL);
+		if (entry)
+			entry->proc_fops = &celleb_display_operations;
+	}
+
+	if (token_set_indicator != 0) {
+		entry = create_proc_entry("ppc64/rtas/toshiba,indicator",
+			S_IRUGO|S_IWUSR, NULL);
+		if (entry)
+			entry->proc_fops = &celleb_indicator_operations;
+	}
+	of_node_put(rtas_node);
+
+	return 0;
+}
+
+static void __exit celleb_indicator_exit(void)
+{
+	remove_proc_entry("ppc64/rtas/toshiba,display", NULL);
+	remove_proc_entry("ppc64/rtas/toshiba,indicator", NULL);
+}
+
+module_init(celleb_indicator_init);
+module_exit(celleb_indicator_exit);
+MODULE_AUTHOR("Toshiba Corporation");
+MODULE_DESCRIPTION("VFD/LED support for Toshiba Cell Reference Set");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
