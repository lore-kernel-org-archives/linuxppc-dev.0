Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Jun 2006 18:47:26 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: support ibm,extended-*-frequency properties
Message-ID: <20060620084726.GC30974@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Support the ibm,extended-*-frequency properties found in recent POWER5
firmware:

cpus/PowerPC,POWER5@0/clock-frequency
                 59aa5880 (1504336000)
cpus/PowerPC,POWER5@0/ibm,extended-clock-frequency
                 00000000 59aa5880
cpus/PowerPC,POWER5@0/timebase-frequency
                 0b354b10 (188042000)
cpus/PowerPC,POWER5@0/ibm,extended-timebase-frequency
                 00000000 0b354b10

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/time.c
===================================================================
--- build.orig/arch/powerpc/kernel/time.c	2006-06-20 11:55:34.000000000 +1000
+++ build/arch/powerpc/kernel/time.c	2006-06-20 18:25:35.000000000 +1000
@@ -857,42 +857,50 @@ int do_settimeofday(struct timespec *tv)
 
 EXPORT_SYMBOL(do_settimeofday);
 
-void __init generic_calibrate_decr(void)
+static int __init get_freq(char *name, int cells, unsigned long *val)
 {
 	struct device_node *cpu;
 	unsigned int *fp;
-	int node_found;
+	int found = 0;
 
-	/*
-	 * The cpu node should have a timebase-frequency property
-	 * to tell us the rate at which the decrementer counts.
-	 */
+	/* The cpu node should have timebase and clock frequency properties */
 	cpu = of_find_node_by_type(NULL, "cpu");
 
-	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
-	node_found = 0;
 	if (cpu) {
-		fp = (unsigned int *)get_property(cpu, "timebase-frequency",
-						  NULL);
+		fp = (unsigned int *)get_property(cpu, name, NULL);
 		if (fp) {
-			node_found = 1;
-			ppc_tb_freq = *fp;
+			found = 1;
+			*val = 0;
+			while (cells--)
+				*val = (*val << 32) | *fp++;
 		}
+
+		of_node_put(cpu);
 	}
-	if (!node_found)
+
+	return found;
+}
+
+void __init generic_calibrate_decr(void)
+{
+	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
+
+	if (!get_freq("ibm,extended-timebase-frequency", 2, &ppc_tb_freq) &&
+	    !get_freq("timebase-frequency", 1, &ppc_tb_freq)) {
+
 		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
 				"(not found)\n");
+	}
 
-	ppc_proc_freq = DEFAULT_PROC_FREQ;
-	node_found = 0;
-	if (cpu) {
-		fp = (unsigned int *)get_property(cpu, "clock-frequency",
-						  NULL);
-		if (fp) {
-			node_found = 1;
-			ppc_proc_freq = *fp;
-		}
+	ppc_proc_freq = DEFAULT_PROC_FREQ;	/* hardcoded default */
+
+	if (!get_freq("ibm,extended-clock-frequency", 2, &ppc_proc_freq) &&
+	    !get_freq("clock-frequency", 1, &ppc_proc_freq)) {
+
+		printk(KERN_ERR "WARNING: Estimating processor frequency "
+				"(not found)\n");
 	}
+
 #ifdef CONFIG_BOOKE
 	/* Set the time base to zero */
 	mtspr(SPRN_TBWL, 0);
@@ -904,11 +912,6 @@ void __init generic_calibrate_decr(void)
 	/* Enable decrementer interrupt */
 	mtspr(SPRN_TCR, TCR_DIE);
 #endif
-	if (!node_found)
-		printk(KERN_ERR "WARNING: Estimating processor frequency "
-				"(not found)\n");
-
-	of_node_put(cpu);
 }
 
 unsigned long get_boot_time(void)
