Return-Path: <wei.zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F3A95DDEF4
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 15:33:17 +1100 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, benh@kernel.crashing.org, galak@kernel.crashing.org
Subject: [PATCH 4/4] Add irq debugfs and virq_mapping for getting the virq to
	irq host's hwirq mapping list.
Date: Fri, 16 Mar 2007 12:38:35 +0800
Message-Id: <11740199152381-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11740199154116-git-send-email-wei.zhang@freescale.com>
References: <11740199151814-git-send-email-wei.zhang@freescale.com>
	<11740199152595-git-send-email-wei.zhang@freescale.com>
	<11740199154116-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, r54964@freescale.com
Reply-To: Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds 'irq' directory into the root debugfs and virq_mapping for getting the virq to irq host's hwirq mapping list.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/kernel/Makefile      |    1 
 arch/powerpc/kernel/irq_debugfs.c |  135 +++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8120d42..9c56acd 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -14,6 +14,7 @@ obj-y				:= semaphore.o cputable.o ptrac
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   init_task.o process.o systbl.o idle.o
 obj-y				+= vdso32/
+obj-$(CONFIG_DEBUG_FS)		+= irq_debugfs.o
 obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o cpu_setup_ppc970.o \
diff --git a/arch/powerpc/kernel/irq_debugfs.c b/arch/powerpc/kernel/irq_debugfs.c
new file mode 100644
index 0000000..246bdce
--- /dev/null
+++ b/arch/powerpc/kernel/irq_debugfs.c
@@ -0,0 +1,135 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Zhang Wei <wei.zhang@freescale.com>
+ *
+ * Description:
+ * This file is used for debug the irq. It will create 'irq' directory
+ * in the root of debugfs.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/threads.h>
+#include <linux/kernel_stat.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+
+static void *irq_dbg_start(struct seq_file *m, loff_t *pos)
+{
+	return (*pos <= NR_IRQS) ? pos : NULL;
+}
+
+static void *irq_dbg_next(struct seq_file *m, void *p, loff_t * pos)
+{
+	(*pos)++;
+
+	return (*pos <= NR_IRQS) ? pos : NULL;
+}
+
+static void irq_dbg_stop(struct seq_file *m, void *p)
+{
+	/* Nothing to do */
+}
+
+static int irq_dbg_show(struct seq_file *m, void *p)
+{
+	int i = *(loff_t *)p;
+	struct irqaction *action;
+	irq_desc_t *desc;
+	unsigned long flags;
+
+	if (i == 0)
+		seq_puts(m, "VIRQ  HWIRQ  Chip Name   Host Name\n");
+
+	if (i < NR_IRQS) {
+		desc = get_irq_desc(i);
+		spin_lock_irqsave(&desc->lock, flags);
+		action = desc->action;
+		if (!action || !action->handler)
+			goto skip;
+		seq_printf(m, "%3d: ", i);
+
+		seq_printf(m, "  %3d ", (irq_map[i].host->revmap_type == IRQ_HOST_MAP_LEGACY) ? i : virq_to_hw(i));
+
+		if (desc->chip)
+			seq_printf(m, "  %s ", desc->chip->typename);
+		else
+			seq_puts(m, "  None      ");
+
+		seq_printf(m, " %s ", (irq_map[i].host->name) ? irq_map[i].host->name : "  None  ");
+		seq_putc(m, '\n');
+skip:
+		spin_unlock_irqrestore(&desc->lock, flags);
+	} else if (i == NR_IRQS) {
+#ifdef CONFIG_PPC32
+#ifdef CONFIG_TAU_INT
+		if (tau_initialized)
+			seq_puts(m, "TAU:   PowerPC             Thermal Assist (cpu temp)\n");
+#endif
+#endif /* CONFIG_PPC32 */
+	}
+
+	return 0;
+}
+
+static struct seq_operations irq_dbg_seq_ops = {
+	.start = irq_dbg_start,
+	.next  = irq_dbg_next,
+	.stop  = irq_dbg_stop,
+	.show  = irq_dbg_show
+};
+
+static int irq_dbg_seq_open(struct inode *inode, struct file *file)
+{
+	int rc;
+	struct seq_file *seq;
+
+	rc = seq_open(file, &irq_dbg_seq_ops);
+	seq = file->private_data;
+	seq->private = file->f_path.dentry->d_inode->i_private;
+
+	return rc;
+}
+
+static const struct file_operations irq_dbg_seq_fops = {
+	.open = irq_dbg_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int __init irq_debugfs_init(void)
+{
+	struct dentry *irq_root;
+	struct dentry *irq_file;
+
+	irq_root = debugfs_create_dir("irq", NULL);
+	if (!irq_root)
+		return -ENOMEM;
+
+	irq_file = debugfs_create_file("virq_mapping", S_IRUGO,
+			irq_root, NULL, &irq_dbg_seq_fops);
+	if (!irq_file)
+		return -ENOMEM;
+
+	return 0;
+}
+__initcall(irq_debugfs_init);
-- 
1.4.0
