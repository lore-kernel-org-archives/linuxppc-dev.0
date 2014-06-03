Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2999C1A0840
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 20:07:52 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8089C14009F
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2014 20:07:51 +1000 (EST)
Message-ID: <1401790059.3247.16.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Provide debugfs access to the LPC bus via
 OPAL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Tue, 03 Jun 2014 20:07:39 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Rob Lippert <rlippert@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This provides debugfs files to access the LPC bus on Power8
non-virtualized using the appropriate OPAL firmware calls.

The usage is simple: one file per space (IO, MEM and FW),
lseek to the address and read/write the data. IO and MEM always
generate series of byte accesses. FW can generate word and dword
accesses if aligned properly.

Based on an original patch from Rob Lippert and reworked.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal-lpc.c |  150 +++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index 79d83ca..70eff22 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -12,12 +12,16 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/bug.h>
+#include <linux/debugfs.h>
+#include <linux/io.h>
+#include <linux/slab.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/xics.h>
 #include <asm/opal.h>
 #include <asm/prom.h>
+#include <asm/uaccess.h>
 
 static int opal_lpc_chip_id = -1;
 
@@ -176,6 +180,152 @@ static const struct ppc_pci_io opal_lpc_io = {
 	.outsl	= opal_lpc_outsl,
 };
 
+#ifdef CONFIG_DEBUG_FS
+struct lpc_debugfs_entry {
+	enum OpalLPCAddressType lpc_type;
+};
+
+static ssize_t lpc_debug_read(struct file *filp, char __user *ubuf,
+			      size_t count, loff_t *ppos)
+{
+	struct lpc_debugfs_entry *lpc = filp->private_data;
+	u32 data, pos, len, todo;
+	int rc;
+
+	if (!access_ok(VERIFY_WRITE, ubuf, count))
+		return -EFAULT;
+
+	todo = count;
+	while (todo) {
+		pos = *ppos;
+
+		/*
+		 * Select access size based on count and alignment and
+		 * access type. IO and MEM only support byte acceses,
+		 * FW supports all 3.
+		 */
+		len = 1;
+		if (lpc->lpc_type == OPAL_LPC_FW) {
+			if (todo > 3 && (pos & 3) == 0)
+				len = 4;
+			else if (todo > 1 && (pos & 1) == 0)
+				len = 2;
+		}
+		rc = opal_lpc_read(opal_lpc_chip_id, lpc->lpc_type, pos,
+				   &data, len);
+		if (rc)
+			return -ENXIO;
+		switch(len) {
+		case 4:
+			rc = __put_user((u32)data, (u32 __user *)ubuf);
+			break;
+		case 2:
+			rc = __put_user((u16)data, (u16 __user *)ubuf);
+			break;
+		default:
+			rc = __put_user((u8)data, (u8 __user *)ubuf);
+			break;
+		}
+		if (rc)
+			return -EFAULT;
+		*ppos += len;
+		ubuf += len;
+		todo -= len;
+	}
+
+	return count;
+}
+
+static ssize_t lpc_debug_write(struct file *filp, const char __user *ubuf,
+			       size_t count, loff_t *ppos)
+{
+	struct lpc_debugfs_entry *lpc = filp->private_data;
+	u32 data, pos, len, todo;
+	int rc;
+
+	if (!access_ok(VERIFY_READ, ubuf, count))
+		return -EFAULT;
+
+	todo = count;
+	while (todo) {
+		pos = *ppos;
+
+		/*
+		 * Select access size based on count and alignment and
+		 * access type. IO and MEM only support byte acceses,
+		 * FW supports all 3.
+		 */
+		len = 1;
+		if (lpc->lpc_type == OPAL_LPC_FW) {
+			if (todo > 3 && (pos & 3) == 0)
+				len = 4;
+			else if (todo > 1 && (pos & 1) == 0)
+				len = 2;
+		}
+		switch(len) {
+		case 4:
+			rc = __get_user(data, (u32 __user *)ubuf);
+			break;
+		case 2:
+			rc = __get_user(data, (u16 __user *)ubuf);
+			break;
+		default:
+			rc = __get_user(data, (u8 __user *)ubuf);
+			break;
+		}
+		if (rc)
+			return -EFAULT;
+
+		rc = opal_lpc_write(opal_lpc_chip_id, lpc->lpc_type, pos,
+				    data, len);
+		if (rc)
+			return -ENXIO;
+		*ppos += len;
+		ubuf += len;
+		todo -= len;
+	}
+
+	return count;
+}
+
+static const struct file_operations lpc_fops = {
+	.read =		lpc_debug_read,
+	.write =	lpc_debug_write,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+static int opal_lpc_debugfs_create_type(struct dentry *folder,
+					const char *fname,
+					enum OpalLPCAddressType type)
+{
+	struct lpc_debugfs_entry *entry;
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	entry->lpc_type = type;
+	debugfs_create_file(fname, 0600, folder, entry, &lpc_fops);
+	return 0;
+}
+
+static int opal_lpc_init_debugfs(void)
+{
+	struct dentry *root;
+	int rc = 0;
+
+	if (opal_lpc_chip_id < 0)
+		return -ENODEV;
+
+	root = debugfs_create_dir("lpc", powerpc_debugfs_root);
+
+	rc |= opal_lpc_debugfs_create_type(root, "io", OPAL_LPC_IO);
+	rc |= opal_lpc_debugfs_create_type(root, "mem", OPAL_LPC_MEM);
+	rc |= opal_lpc_debugfs_create_type(root, "fw", OPAL_LPC_FW);
+	return rc;
+}
+device_initcall(opal_lpc_init_debugfs);
+#endif  /* CONFIG_DEBUG_FS */
+
 void opal_lpc_init(void)
 {
 	struct device_node *np;
