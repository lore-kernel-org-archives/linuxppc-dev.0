Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A183067A0E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 11:57:53 +1000 (EST)
Date: Wed, 28 Jun 2006 11:57:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] Make lparcfg.c work when both iseries and pseries are selected
Message-Id: <20060628115728.17f1a04d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/lparcfg.c |   69 +++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 37 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index c02deaa..bcc358d 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -45,11 +45,9 @@ #define MODULE_NAME "lparcfg"
 static struct proc_dir_entry *proc_ppc64_lparcfg;
 #define LPARCFG_BUFF_SIZE 4096
 
-#ifdef CONFIG_PPC_ISERIES
-
 /*
- * For iSeries legacy systems, the PPA purr function is available from the
- * emulated_time_base field in the paca.
+ * Track sum of all purrs across all processors. This is used to further
+ * calculate usage values by different applications
  */
 static unsigned long get_purr(void)
 {
@@ -57,30 +55,30 @@ static unsigned long get_purr(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		sum_purr += lppaca[cpu].emulated_time_base;
+		if (firmware_has_feature(FW_FEATURE_ISERIES))
+			sum_purr += lppaca[cpu].emulated_time_base;
+		else {
+			struct cpu_usage *cu;
 
-#ifdef PURR_DEBUG
-		printk(KERN_INFO "get_purr for cpu (%d) has value (%ld) \n",
-			cpu, lppaca[cpu].emulated_time_base);
-#endif
+			cu = &per_cpu(cpu_usage_array, cpu);
+			sum_purr += cu->current_tb;
+		}
 	}
 	return sum_purr;
 }
 
-#define lparcfg_write NULL
+#ifdef CONFIG_PPC_ISERIES
 
 /*
  * Methods used to fetch LPAR data when running on an iSeries platform.
  */
-static int lparcfg_data(struct seq_file *m, void *v)
+static int iseries_lparcfg_data(struct seq_file *m, void *v)
 {
 	unsigned long pool_id, lp_index;
 	int shared, entitled_capacity, max_entitled_capacity;
 	int processors, max_processors;
 	unsigned long purr = get_purr();
 
-	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
-
 	shared = (int)(get_lppaca()->shared_proc);
 	seq_printf(m, "serial_number=%c%c%c%c%c%c%c\n",
 		   e2a(xItExtVpdPanel.mfgID[2]),
@@ -213,22 +211,6 @@ static void h_pic(unsigned long *pool_id
 		log_plpar_hcall_return(rc, "H_PIC");
 }
 
-/* Track sum of all purrs across all processors. This is used to further */
-/* calculate usage values by different applications                       */
-
-static unsigned long get_purr(void)
-{
-	unsigned long sum_purr = 0;
-	int cpu;
-	struct cpu_usage *cu;
-
-	for_each_possible_cpu(cpu) {
-		cu = &per_cpu(cpu_usage_array, cpu);
-		sum_purr += cu->current_tb;
-	}
-	return sum_purr;
-}
-
 #define SPLPAR_CHARACTERISTICS_TOKEN 20
 #define SPLPAR_MAXLENGTH 1026*(sizeof(char))
 
@@ -333,7 +315,7 @@ #endif
 	return count;
 }
 
-static int lparcfg_data(struct seq_file *m, void *v)
+static int pseries_lparcfg_data(struct seq_file *m, void *v)
 {
 	int partition_potential_processors;
 	int partition_active_processors;
@@ -354,8 +336,6 @@ static int lparcfg_data(struct seq_file 
 			lp_index = *lp_index_ptr;
 	}
 
-	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
-
 	seq_printf(m, "serial_number=%s\n", system_id);
 
 	seq_printf(m, "system_type=%s\n", model);
@@ -456,6 +436,21 @@ static int lparcfg_data(struct seq_file 
 	return 0;
 }
 
+#endif				/* CONFIG_PPC_PSERIES */
+
+static int lparcfg_data(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
+
+#ifdef CONFIG_PPC_ISERIES
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return iseries_lparcfg_data(m, v);
+#endif
+#ifdef CONFIG_PPC_PSERIES
+	return pseries_lparcfg_data(m, v);
+#endif
+}
+
 /*
  * Interface for changing system parameters (variable capacity weight
  * and entitled capacity).  Format of input is "param_name=value";
@@ -469,6 +464,8 @@ static int lparcfg_data(struct seq_file 
 static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 			     size_t count, loff_t * off)
 {
+	ssize_t retval = -ENOMEM;
+#ifdef CONFIG_PPC_PSERIES
 	char *kbuf;
 	char *tmp;
 	u64 new_entitled, *new_entitled_ptr = &new_entitled;
@@ -479,8 +476,6 @@ static ssize_t lparcfg_write(struct file
 	unsigned long resource;
 	u8 current_weight;
 
-	ssize_t retval = -ENOMEM;
-
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		goto out;
@@ -546,11 +541,10 @@ static ssize_t lparcfg_write(struct file
 
 out:
 	kfree(kbuf);
+#endif				/* CONFIG_PPC_PSERIES */
 	return retval;
 }
 
-#endif				/* CONFIG_PPC_PSERIES */
-
 static int lparcfg_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, lparcfg_data, NULL);
@@ -569,7 +563,8 @@ int __init lparcfg_init(void)
 	mode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
 
 	/* Allow writing if we have FW_FEATURE_SPLPAR */
-	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
+	if (firmware_has_feature(FW_FEATURE_SPLPAR) &&
+			!firmware_has_feature(FW_FEATURE_ISERIES)) {
 		lparcfg_fops.write = lparcfg_write;
 		mode |= S_IWUSR;
 	}
-- 
1.4.0
