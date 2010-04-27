Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.277400577@samba.org>
Date: Tue, 27 Apr 2010 11:32:39 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 08/15] powerpc: cpumask: Refactor /proc/cpuinfo code
References: <20100427013231.510168034@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This separates the per cpu output from the summary output at the end of the
file, making it easier to convert to the new cpumask API in a subsequent
patch.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/setup-common.c	2010-04-08 19:46:03.999199713 +1000
+++ linux-cpumask/arch/powerpc/kernel/setup-common.c	2010-04-22 13:03:19.866696740 +1000
@@ -161,43 +161,47 @@ extern u32 cpu_temp_both(unsigned long c
 DEFINE_PER_CPU(unsigned int, cpu_pvr);
 #endif
 
-static int show_cpuinfo(struct seq_file *m, void *v)
+static void show_cpuinfo_summary(struct seq_file *m)
 {
-	unsigned long cpu_id = (unsigned long)v - 1;
-	unsigned int pvr;
-	unsigned short maj;
-	unsigned short min;
-
-	if (cpu_id == NR_CPUS) {
-		struct device_node *root;
-		const char *model = NULL;
+	struct device_node *root;
+	const char *model = NULL;
 #if defined(CONFIG_SMP) && defined(CONFIG_PPC32)
-		unsigned long bogosum = 0;
-		int i;
-		for_each_online_cpu(i)
-			bogosum += loops_per_jiffy;
-		seq_printf(m, "total bogomips\t: %lu.%02lu\n",
-			   bogosum/(500000/HZ), bogosum/(5000/HZ) % 100);
+	unsigned long bogosum = 0;
+	int i;
+	for_each_online_cpu(i)
+		bogosum += loops_per_jiffy;
+	seq_printf(m, "total bogomips\t: %lu.%02lu\n",
+		   bogosum/(500000/HZ), bogosum/(5000/HZ) % 100);
 #endif /* CONFIG_SMP && CONFIG_PPC32 */
-		seq_printf(m, "timebase\t: %lu\n", ppc_tb_freq);
-		if (ppc_md.name)
-			seq_printf(m, "platform\t: %s\n", ppc_md.name);
-		root = of_find_node_by_path("/");
-		if (root)
-			model = of_get_property(root, "model", NULL);
-		if (model)
-			seq_printf(m, "model\t\t: %s\n", model);
-		of_node_put(root);
+	seq_printf(m, "timebase\t: %lu\n", ppc_tb_freq);
+	if (ppc_md.name)
+		seq_printf(m, "platform\t: %s\n", ppc_md.name);
+	root = of_find_node_by_path("/");
+	if (root)
+		model = of_get_property(root, "model", NULL);
+	if (model)
+		seq_printf(m, "model\t\t: %s\n", model);
+	of_node_put(root);
 
-		if (ppc_md.show_cpuinfo != NULL)
-			ppc_md.show_cpuinfo(m);
+	if (ppc_md.show_cpuinfo != NULL)
+		ppc_md.show_cpuinfo(m);
 
 #ifdef CONFIG_PPC32
-		/* Display the amount of memory */
-		seq_printf(m, "Memory\t\t: %d MB\n",
-			   (unsigned int)(total_memory / (1024 * 1024)));
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n",
+		   (unsigned int)(total_memory / (1024 * 1024)));
 #endif
+}
 
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	unsigned long cpu_id = (unsigned long)v - 1;
+	unsigned int pvr;
+	unsigned short maj;
+	unsigned short min;
+
+	if (cpu_id == NR_CPUS) {
+		show_cpuinfo_summary(m);
 		return 0;
 	}
 
