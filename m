Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 619D6DDE36
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 21:05:51 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6NB5k9S008278
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 04:05:46 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6NB5fFj008974
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 06:05:45 -0500 (CDT)
From: Chen Gong <g.chen@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 3/3] Add irq debugfs and virq_mapping for getting the virq
Date: Mon, 23 Jul 2007 19:13:50 +0800
Message-Id: <11851892333882-git-send-email-g.chen@freescale.com>
In-Reply-To: <11851892322112-git-send-email-g.chen@freescale.com>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<11851892322112-git-send-email-g.chen@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Chen Gong <g.chen@freescale.com>,
	Chen Gong <G.Chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds irq debugfs and virq_mapping for getting the virq.
The virq_mapping node is in powerpc/irq directory of the root debugfs.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Chen Gong <G.Chen@freescale.com>
---
 arch/powerpc/Kconfig.debug        |    7 ++
 arch/powerpc/kernel/Makefile      |    1 +
 arch/powerpc/kernel/irq_debugfs.c |  140 +++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/kernel/irq_debugfs.c

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 346cd3b..7ae8df1 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -2,6 +2,13 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config PPC_VIRQ_DEBUGFS
+	bool "Check virqs mapping"
+	depends on DEBUG_FS
+	help
+	  This option will show the mapping relationship between hardware irq
+	  and virtual irq based on debugfs
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 42c42ec..cc3e1e5 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -15,6 +15,7 @@ obj-y				:= semaphore.o cputable.o ptrace.o syscalls.o \
 				   init_task.o process.o systbl.o idle.o \
 				   signal.o
 obj-y				+= vdso32/
+obj-$(CONFIG_PPC_VIRQ_DEBUGFS)	+= irq_debugfs.o
 obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o cpu_setup_ppc970.o \
diff --git a/arch/powerpc/kernel/irq_debugfs.c b/arch/powerpc/kernel/irq_debugfs.c
new file mode 100644
index 0000000..53ac12e
--- /dev/null
+++ b/arch/powerpc/kernel/irq_debugfs.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Auther: Zhang Wei <wei.zhang@freescale.com>
+ *
+ * Description:
+ * This file is used for debug the irq. It will create 'irq' directory
+ * in the powerpc directory of debugfs.
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
+extern struct dentry *powerpc_debugfs_root;
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
+	if (!powerpc_debugfs_root)
+		return 1;
+
+	irq_root = debugfs_create_dir("irq", powerpc_debugfs_root);
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
1.5.1
