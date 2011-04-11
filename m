Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <6141564d9ca995e3052dba5ea4dfc981efbb3a02.1302503336.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Dump chip data pointer in virq_mapping
Date: Mon, 11 Apr 2011 16:26:15 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This can be useful for differentiating interrupts on the same host
but with different chip data.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f621b7d..ac32ba1 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -1082,10 +1082,11 @@ static int virq_debug_show(struct seq_file *m, void *private)
 	struct irq_desc *desc;
 	const char *p;
 	static const char none[] = "none";
+	void *data;
 	int i;
 
-	seq_printf(m, "%-5s  %-7s  %-15s  %s\n", "virq", "hwirq",
-		      "chip name", "host name");
+	seq_printf(m, "%-5s  %-7s  %-15s  %-18s  %s\n", "virq", "hwirq",
+		      "chip name", "chip data", "host name");
 
 	for (i = 1; i < nr_irqs; i++) {
 		desc = irq_to_desc(i);
@@ -1107,6 +1108,9 @@ static int virq_debug_show(struct seq_file *m, void *private)
 				p = none;
 			seq_printf(m, "%-15s  ", p);
 
+			data = irq_desc_get_chip_data(desc);
+			seq_printf(m, "0x%16p  ", data);
+
 			if (irq_map[i].host && irq_map[i].host->of_node)
 				p = irq_map[i].host->of_node->full_name;
 			else
-- 
1.7.1
