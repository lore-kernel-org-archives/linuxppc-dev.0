Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 13A2D67A73
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 15:08:05 +1000 (EST)
Date: Thu, 29 Jun 2006 15:07:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] Make lparcfg.c work when both iseries and pseries are selected
Message-Id: <20060629150742.0c438c49.sfr@canb.auug.org.au>
In-Reply-To: <20060628072928.GX16029@localdomain>
References: <20060628115728.17f1a04d.sfr@canb.auug.org.au>
	<20060628040539.GW16029@localdomain>
	<20060628161903.7767131f.sfr@canb.auug.org.au>
	<20060628072928.GX16029@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This also consolidates the initial bits of lparcfg_data() and adds the
partition number to the iSeries flattened device tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/lparcfg.c       |  147 ++++++++++++++++++-----------------
 arch/powerpc/platforms/iseries/dt.c |    2 
 2 files changed, 78 insertions(+), 71 deletions(-)

Built and run on iSeries, built on pSeries.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index c02deaa..73edc3c 100644
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
@@ -57,48 +55,31 @@ static unsigned long get_purr(void)
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
-	unsigned long pool_id, lp_index;
+	unsigned long pool_id;
 	int shared, entitled_capacity, max_entitled_capacity;
 	int processors, max_processors;
 	unsigned long purr = get_purr();
 
-	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
-
 	shared = (int)(get_lppaca()->shared_proc);
-	seq_printf(m, "serial_number=%c%c%c%c%c%c%c\n",
-		   e2a(xItExtVpdPanel.mfgID[2]),
-		   e2a(xItExtVpdPanel.mfgID[3]),
-		   e2a(xItExtVpdPanel.systemSerial[1]),
-		   e2a(xItExtVpdPanel.systemSerial[2]),
-		   e2a(xItExtVpdPanel.systemSerial[3]),
-		   e2a(xItExtVpdPanel.systemSerial[4]),
-		   e2a(xItExtVpdPanel.systemSerial[5]));
-
-	seq_printf(m, "system_type=%c%c%c%c\n",
-		   e2a(xItExtVpdPanel.machineType[0]),
-		   e2a(xItExtVpdPanel.machineType[1]),
-		   e2a(xItExtVpdPanel.machineType[2]),
-		   e2a(xItExtVpdPanel.machineType[3]));
-
-	lp_index = HvLpConfig_getLpIndex();
-	seq_printf(m, "partition_id=%d\n", (int)lp_index);
 
 	seq_printf(m, "system_active_processors=%d\n",
 		   (int)HvLpConfig_getSystemPhysicalProcessors());
@@ -137,6 +118,14 @@ static int lparcfg_data(struct seq_file 
 
 	return 0;
 }
+
+#else				/* CONFIG_PPC_ISERIES */
+
+static int iseries_lparcfg_data(struct seq_file *m, void *v)
+{
+	return 0;
+}
+
 #endif				/* CONFIG_PPC_ISERIES */
 
 #ifdef CONFIG_PPC_PSERIES
@@ -213,22 +202,6 @@ static void h_pic(unsigned long *pool_id
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
 
@@ -333,35 +306,13 @@ #endif
 	return count;
 }
 
-static int lparcfg_data(struct seq_file *m, void *v)
+static int pseries_lparcfg_data(struct seq_file *m, void *v)
 {
 	int partition_potential_processors;
 	int partition_active_processors;
-	struct device_node *rootdn;
-	const char *model = "";
-	const char *system_id = "";
-	unsigned int *lp_index_ptr, lp_index = 0;
 	struct device_node *rtas_node;
 	int *lrdrp = NULL;
 
-	rootdn = find_path_device("/");
-	if (rootdn) {
-		model = get_property(rootdn, "model", NULL);
-		system_id = get_property(rootdn, "system-id", NULL);
-		lp_index_ptr = (unsigned int *)
-		    get_property(rootdn, "ibm,partition-no", NULL);
-		if (lp_index_ptr)
-			lp_index = *lp_index_ptr;
-	}
-
-	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
-
-	seq_printf(m, "serial_number=%s\n", system_id);
-
-	seq_printf(m, "system_type=%s\n", model);
-
-	seq_printf(m, "partition_id=%d\n", (int)lp_index);
-
 	rtas_node = find_path_device("/rtas");
 	if (rtas_node)
 		lrdrp = (int *)get_property(rtas_node, "ibm,lrdr-capacity",
@@ -549,8 +500,61 @@ out:
 	return retval;
 }
 
+#else				/* CONFIG_PPC_PSERIES */
+
+static int pseries_lparcfg_data(struct seq_file *m, void *v)
+{
+	return 0;
+}
+
+static ssize_t lparcfg_write(struct file *file, const char __user * buf,
+			     size_t count, loff_t * off)
+{
+	return count;
+}
+
 #endif				/* CONFIG_PPC_PSERIES */
 
+static int lparcfg_data(struct seq_file *m, void *v)
+{
+	struct device_node *rootdn;
+	const char *model = "";
+	const char *system_id = "";
+	const char *tmp;
+	unsigned int *lp_index_ptr, lp_index = 0;
+
+	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
+
+	rootdn = find_path_device("/");
+	if (rootdn) {
+		tmp = get_property(rootdn, "model", NULL);
+		if (tmp) {
+			model = tmp;
+			/* Skip "IBM," - see platforms/iseries/dt.c */
+			if (firmware_has_feature(FW_FEATURE_ISERIES))
+				model += 4;
+		}
+		tmp = get_property(rootdn, "system-id", NULL);
+		if (tmp) {
+			system_id = tmp;
+			/* Skip "IBM," - see platforms/iseries/dt.c */
+			if (firmware_has_feature(FW_FEATURE_ISERIES))
+				system_id += 4;
+		}
+		lp_index_ptr = (unsigned int *)
+			get_property(rootdn, "ibm,partition-no", NULL);
+		if (lp_index_ptr)
+			lp_index = *lp_index_ptr;
+	}
+	seq_printf(m, "serial_number=%s\n", system_id);
+	seq_printf(m, "system_type=%s\n", model);
+	seq_printf(m, "partition_id=%d\n", (int)lp_index);
+
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return iseries_lparcfg_data(m, v);
+	return pseries_lparcfg_data(m, v);
+}
+
 static int lparcfg_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, lparcfg_data, NULL);
@@ -569,7 +573,8 @@ int __init lparcfg_init(void)
 	mode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
 
 	/* Allow writing if we have FW_FEATURE_SPLPAR */
-	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
+	if (firmware_has_feature(FW_FEATURE_SPLPAR) &&
+			!firmware_has_feature(FW_FEATURE_ISERIES)) {
 		lparcfg_fops.write = lparcfg_write;
 		mode |= S_IWUSR;
 	}
diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index d3444aa..d194140 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -252,6 +252,7 @@ static void __init dt_model(struct iseri
 {
 	char buf[16] = "IBM,";
 
+	/* N.B. lparcfg.c knows about the "IBM," prefixes ... */
 	/* "IBM," + mfgId[2:3] + systemSerial[1:5] */
 	strne2a(buf + 4, xItExtVpdPanel.mfgID + 2, 2);
 	strne2a(buf + 6, xItExtVpdPanel.systemSerial + 1, 5);
@@ -264,6 +265,7 @@ static void __init dt_model(struct iseri
 	dt_prop_str(dt, "model", buf);
 
 	dt_prop_str(dt, "compatible", "IBM,iSeries");
+	dt_prop_u32(dt, "ibm,partition-no", HvLpConfig_getLpIndex());
 }
 
 static void __init dt_do_vdevice(struct iseries_flat_dt *dt,
-- 
1.4.0
