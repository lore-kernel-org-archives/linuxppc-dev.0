Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 05328DDFF5
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:46:53 +1000 (EST)
Message-Id: <20070423193912.309874084@arndb.de>
References: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:39 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 01/10] cell: add cbe_node_to_cpu function
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>

This patch adds code to deal with conversion of
logical cpu to cbe nodes. It removes code that
assummed there were two logical CPUs per CBE.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.c
@@ -38,8 +38,13 @@ static struct cbe_thread_map
 {
 	struct device_node *cpu_node;
 	struct cbe_regs_map *regs;
+	unsigned int thread_id;
+	unsigned int cbe_id;
 } cbe_thread_map[NR_CPUS];
 
+static cpumask_t cbe_local_mask[MAX_CBE] = { [0 ... MAX_CBE-1] = CPU_MASK_NONE };
+static cpumask_t cbe_first_online_cpu = CPU_MASK_NONE;
+
 static struct cbe_regs_map *cbe_find_map(struct device_node *np)
 {
 	int i;
@@ -130,31 +135,40 @@ struct cbe_mic_tm_regs __iomem *cbe_get_
 }
 EXPORT_SYMBOL_GPL(cbe_get_cpu_mic_tm_regs);
 
-/* FIXME
- * This is little more than a stub at the moment.  It should be
- * fleshed out so that it works for both SMT and non-SMT, no
- * matter if the passed cpu is odd or even.
- * For SMT enabled, returns 0 for even-numbered cpu; otherwise 1.
- * For SMT disabled, returns 0 for all cpus.
- */
 u32 cbe_get_hw_thread_id(int cpu)
 {
-	return (cpu & 1);
+	return cbe_thread_map[cpu].thread_id;
 }
 EXPORT_SYMBOL_GPL(cbe_get_hw_thread_id);
 
+u32 cbe_cpu_to_node(int cpu)
+{
+	return cbe_thread_map[cpu].cbe_id;
+}
+EXPORT_SYMBOL_GPL(cbe_cpu_to_node);
+
+u32 cbe_node_to_cpu(int node)
+{
+	return find_first_bit( (unsigned long *) &cbe_local_mask[node], sizeof(cpumask_t));
+}
+EXPORT_SYMBOL_GPL(cbe_node_to_cpu);
+
 void __init cbe_regs_init(void)
 {
 	int i;
+	unsigned int thread_id;
 	struct device_node *cpu;
 
 	/* Build local fast map of CPUs */
-	for_each_possible_cpu(i)
-		cbe_thread_map[i].cpu_node = of_get_cpu_node(i, NULL);
+	for_each_possible_cpu(i) {
+		cbe_thread_map[i].cpu_node = of_get_cpu_node(i, &thread_id);
+		cbe_thread_map[i].thread_id = thread_id;
+	}
 
 	/* Find maps for each device tree CPU */
 	for_each_node_by_type(cpu, "cpu") {
-		struct cbe_regs_map *map = &cbe_regs_maps[cbe_regs_map_count++];
+		struct cbe_regs_map *map;
+		unsigned int cbe_id;
 
 		/* That hack must die die die ! */
 		const struct address_prop {
@@ -162,6 +176,8 @@ void __init cbe_regs_init(void)
 			unsigned int len;
 		} __attribute__((packed)) *prop;
 
+		cbe_id = cbe_regs_map_count++;
+		map = &cbe_regs_maps[cbe_id];
 
 		if (cbe_regs_map_count > MAX_CBE) {
 			printk(KERN_ERR "cbe_regs: More BE chips than supported"
@@ -170,9 +186,18 @@ void __init cbe_regs_init(void)
 			return;
 		}
 		map->cpu_node = cpu;
-		for_each_possible_cpu(i)
-			if (cbe_thread_map[i].cpu_node == cpu)
-				cbe_thread_map[i].regs = map;
+
+		for_each_possible_cpu(i) {
+			struct cbe_thread_map *thread = &cbe_thread_map[i];
+
+			if (thread->cpu_node == cpu) {
+				thread->regs = map;
+				thread->cbe_id = cbe_id;
+				cpu_set(i, cbe_local_mask[cbe_id]);
+				if(thread->thread_id == 0)
+					cpu_set(i, cbe_first_online_cpu);
+			}
+		}
 
 		prop = of_get_property(cpu, "pervasive", NULL);
 		if (prop != NULL)
Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.h
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
@@ -255,6 +255,11 @@ struct cbe_mic_tm_regs {
 extern struct cbe_mic_tm_regs __iomem *cbe_get_mic_tm_regs(struct device_node *np);
 extern struct cbe_mic_tm_regs __iomem *cbe_get_cpu_mic_tm_regs(int cpu);
 
+/* some utility functions to deal with SMT */
+extern u32 cbe_get_hw_thread_id(int cpu);
+extern u32 cbe_cpu_to_node(int cpu);
+extern u32 cbe_node_to_cpu(int node);
+
 /* Init this module early */
 extern void cbe_regs_init(void);
 
Index: linux-2.6/arch/powerpc/oprofile/op_model_cell.c
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/op_model_cell.c
+++ linux-2.6/arch/powerpc/oprofile/op_model_cell.c
@@ -37,6 +37,7 @@
 #include <asm/system.h>
 
 #include "../platforms/cell/interrupt.h"
+#include "../platforms/cell/cbe_regs.h"
 
 #define PPU_CYCLES_EVENT_NUM 1	/*  event number for CYCLES */
 #define PPU_CYCLES_GRP_NUM   1  /* special group number for identifying
Index: linux-2.6/include/asm-powerpc/cell-pmu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/cell-pmu.h
+++ linux-2.6/include/asm-powerpc/cell-pmu.h
@@ -97,11 +97,6 @@ extern void cbe_disable_pm_interrupts(u3
 extern u32  cbe_get_and_clear_pm_interrupts(u32 cpu);
 extern void cbe_sync_irq(int node);
 
-/* Utility functions, macros */
-extern u32 cbe_get_hw_thread_id(int cpu);
-
-#define cbe_cpu_to_node(cpu) ((cpu) >> 1)
-
 #define CBE_COUNT_SUPERVISOR_MODE       0
 #define CBE_COUNT_HYPERVISOR_MODE       1
 #define CBE_COUNT_PROBLEM_MODE          2

--
