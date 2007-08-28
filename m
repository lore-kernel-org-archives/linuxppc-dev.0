Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e42d471774e63c410d2705b9eb6b2b260244b4e6.1188290811.git.michael@ellerman.id.au>
In-Reply-To: <460e86e8b5a08c23dcbedb5d4bd484a519246dd3.1188290811.git.michael@ellerman.id.au>
References: <460e86e8b5a08c23dcbedb5d4bd484a519246dd3.1188290811.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/5] Export virq mapping via debugfs
Date: Tue, 28 Aug 2007 18:47:57 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a debugfs file "powerpc/virq_mapping", which shows the virtual
to real mapping of irq numbers. Enable it with CONFIG_VIRQ_DEBUG.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Chen Gong <G.Chen@freescale.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug |   10 +++++++
 arch/powerpc/kernel/irq.c  |   63 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 22acece..c38bc22 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -124,6 +124,16 @@ config IRQSTACKS
 	  for handling hard and soft interrupts.  This can help avoid
 	  overflowing the process kernel stacks.
 
+config VIRQ_DEBUG
+	bool "Expose hardware/virtual IRQ mapping via debugfs"
+	depends on DEBUG_FS && PPC_MERGE
+	help
+	  This option will show the mapping relationship between hardware irq
+	  numbers and virtual irq numbers. The mapping is exposed via debugfs
+	  in the file powerpc/virq_mapping.
+
+	  If you don't know what this means you don't need it.
+
 config BDI_SWITCH
 	bool "Include BDI-2000 user context switcher"
 	depends on DEBUG_KERNEL && PPC32
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1339f32..0e47c8c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -52,6 +52,7 @@
 #include <linux/mutex.h>
 #include <linux/bootmem.h>
 #include <linux/pci.h>
+#include <linux/debugfs.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -1006,6 +1007,68 @@ static int irq_late_init(void)
 }
 arch_initcall(irq_late_init);
 
+#ifdef CONFIG_VIRQ_DEBUG
+static int virq_debug_show(struct seq_file *m, void *private)
+{
+	unsigned long flags;
+	irq_desc_t *desc;
+	const char *p;
+	char none[] = "none";
+	int i;
+
+	seq_printf(m, "%-5s  %-7s  %-15s  %s\n", "virq", "hwirq",
+		      "chip name", "host name");
+
+	for (i = 1; i < NR_IRQS; i++) {
+		desc = get_irq_desc(i);
+		spin_lock_irqsave(&desc->lock, flags);
+
+		if (desc->action && desc->action->handler) {
+			seq_printf(m, "%5d  ", i);
+			seq_printf(m, "0x%05lx  ", virq_to_hw(i));
+
+			if (desc->chip && desc->chip->typename)
+				p = desc->chip->typename;
+			else
+				p = none;
+			seq_printf(m, "%-15s  ", p);
+
+			if (irq_map[i].host && irq_map[i].host->of_node)
+				p = irq_map[i].host->of_node->full_name;
+			else
+				p = none;
+			seq_printf(m, "%s\n", p);
+		}
+
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
+
+	return 0;
+}
+
+static int virq_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, virq_debug_show, inode->i_private);
+}
+
+static const struct file_operations virq_debug_fops = {
+	.open = virq_debug_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int __init irq_debugfs_init(void)
+{
+	if (debugfs_create_file("virq_mapping", S_IRUGO, powerpc_debugfs_root,
+				 NULL, &virq_debug_fops))
+		return -ENOMEM;
+
+	return 0;
+}
+__initcall(irq_debugfs_init);
+#endif /* CONFIG_VIRQ_DEBUG */
+
 #endif /* CONFIG_PPC_MERGE */
 
 #ifdef CONFIG_PPC64
-- 
1.5.1.3.g7a33b
