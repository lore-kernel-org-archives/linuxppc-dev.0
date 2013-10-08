Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C7DE82C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 18:46:51 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r987kjmx014283
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 02:46:46 -0500
Message-ID: <1381218400.645.204.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Add a debugfs file to read the firmware
 console
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 08 Oct 2013 18:46:40 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With OPALv3, the firmware can provide the address of it's internal console
to Linux, which we can then display using debugfs. This is handy for
diagnostics and debugging.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2911abe..10d7894 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -17,6 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
 
@@ -27,6 +29,21 @@ struct opal {
 	u64 entry;
 } opal;
 
+/* OPAL in-memory console */
+struct memcons {
+	uint64_t magic;
+#define MEMCONS_MAGIC	0x6630696567726173
+	uint64_t obuf_phys;
+	uint64_t ibuf_phys;
+	uint32_t obuf_size;
+	uint32_t ibuf_size;
+	uint32_t out_pos;
+#define MEMCONS_OUT_POS_WRAP	0x80000000u
+#define MEMCONS_OUT_POS_MASK	0x00ffffffu
+	uint32_t in_prod;
+	uint32_t in_cons;
+};
+
 static struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
 extern u64 opal_mc_secondary_handler[];
@@ -369,6 +386,90 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static ssize_t opal_memcons_read(struct file *file, char __user *to,
+				 size_t count, loff_t *ppos)
+{
+	struct memcons *mc = file->private_data;
+	size_t available, ret, chunk0, chunk1, lcount;
+	const char *start, *conbuf = __va(mc->obuf_phys);
+	loff_t opos, pos;
+
+	/*
+	 * Find out how much is in the buffer. If it has wrapped
+	 * the whole buffer, else just the beginning. It has wrapped
+	 * if the next character is not \0
+	 */
+	if (mc->out_pos & MEMCONS_OUT_POS_WRAP) {
+		available = mc->obuf_size;
+		chunk1 = mc->out_pos & MEMCONS_OUT_POS_MASK;
+		start = conbuf + chunk1;
+		chunk0 = mc->obuf_size - chunk1;
+	} else {
+		available = mc->out_pos;
+		start = conbuf;
+		chunk0 = available;
+		chunk1 = 0;
+	}
+
+	opos = pos = *ppos;
+
+	/* Sanity check arguments */
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available || !count)
+		return 0;
+	if (count > available - pos)
+		count = available - pos;
+
+	/* Handle first chunk */
+	if (pos < chunk0) {
+		lcount = min(count, chunk0 - (size_t)pos);
+		ret = copy_to_user(to, start + pos, lcount);
+		if (ret == lcount)
+			return -EFAULT;
+		lcount -= ret;
+		count -= lcount;
+		*ppos += lcount;
+		to += lcount;
+		pos = 0;
+	} else {
+		*ppos += chunk0;
+		pos -= chunk0;
+		ret = 0;
+	}
+
+	/* Handle second chunk */
+	if (count && chunk1 && ret == 0) {
+		lcount = min(count, chunk1 - (size_t)pos);
+		ret = copy_to_user(to, conbuf + pos, lcount);
+		if (ret == lcount)
+			return -EFAULT;
+		lcount -= ret;
+		*ppos += lcount;
+	}
+	return *ppos - opos;
+
+}
+
+static const struct file_operations opal_fops_memcons = {
+	.read =		opal_memcons_read,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+static void opal_init_debugfs(void)
+{
+	u64 mcaddr;
+
+	if (of_property_read_u64(opal_node, "ibm,opal-memcons", &mcaddr) == 0)
+		debugfs_create_file("opal-log", 0400, powerpc_debugfs_root,
+				    __va(mcaddr), &opal_fops_memcons);
+}
+#else
+static void opal_init_debugfs(void) { }
+#endif /* CONFIG_DEBUG_FS */
+
 static int __init opal_init(void)
 {
 	struct device_node *np, *consoles;
@@ -414,6 +515,9 @@ static int __init opal_init(void)
 				   " (0x%x)\n", rc, irq, hwirq);
 		opal_irqs[i] = irq;
 	}
+
+	opal_init_debugfs();
+
 	return 0;
 }
 subsys_initcall(opal_init);
