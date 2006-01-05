Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 18:03:14 +1100
Message-Id: <1136444594.4840.69.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH] powerpc: Add cpufreq for various G5 machines (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch uses the platform function patch posted earlier to implement
cpu frequency switching on various G5 models. For now, this should work
with all PowerMac7,2 and 7,3 (in addition to the code that was already
there for iMac G5 and PowerMac9,1), that is desktop modeles with an AGP
slot and the desktop PCI Express ones (like the Quad G5). At this point,
the only models still not supported are the iMac G5 iSight
(PowerMac12,1) and the Xserve G5 (RackMac3,1)

I tested it on the dual 2.5 Ghz here (pulsar clock chip) and the Quad g5
but I haven't had a chance to test it on other models using other
frequencies or other clock chips. It's also not hooked to the thermal
control code at all yet, this will happen once I port therm_pm72 to the
windfarm architecture.

I didn't found a nice & clear way to "know" what the low frequency value
is on the PowerMac7,2 and 7,3 models. (I only know how to tell the clock
chip to slew to "low speed", not what "low speed" really is).
I think I found a way to figure it out, but it might not work on all
models, thus you might end up with a slightly incorrect value when
running low speed in /proc/cpuinfo, though that should have no other
effect since the kernel doesn't rely on the CPU core frequency for it's
timekeeping. If you want to verify, you can use the little hack at
http://gate.crashing.org/~benh/cpufreq_g5.c which attempts to "measure"
the cpu frequency (970 only).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/powermac/cpufreq_64.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/cpufreq_64.c	2006-01-05 15:11:16.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/cpufreq_64.c	2006-01-05 17:49:33.000000000 +1100
@@ -28,6 +28,7 @@
 #include <asm/cputable.h>
 #include <asm/time.h>
 #include <asm/smu.h>
+#include <asm/pmac_pfunc.h>
 
 #undef DEBUG
 
@@ -85,6 +86,10 @@
 static int g5_pmode_max;
 static int g5_pmode_cur;
 
+static void (*g5_switch_volt)(int speed_mode);
+static int (*g5_switch_freq)(int speed_mode);
+static int (*g5_query_freq)(void);
+
 static DECLARE_MUTEX(g5_switch_mutex);
 
 
@@ -92,9 +97,11 @@
 static int g5_fvt_count;			/* number of op. points */
 static int g5_fvt_cur;				/* current op. point */
 
-/* ----------------- real hardware interface */
+/*
+ * SMU based voltage switching for Neo2 platforms
+ */
 
-static void g5_switch_volt(int speed_mode)
+static void g5_smu_switch_volt(int speed_mode)
 {
 	struct smu_simple_cmd	cmd;
 
@@ -105,26 +112,57 @@
 	wait_for_completion(&comp);
 }
 
-static int g5_switch_freq(int speed_mode)
-{
-	struct cpufreq_freqs freqs;
-	int to;
+/*
+ * Platform function based voltage/vdnap switching for Neo2
+ */
 
-	if (g5_pmode_cur == speed_mode)
-		return 0;
+static struct pmf_function *pfunc_set_vdnap0;
+static struct pmf_function *pfunc_vdnap0_complete;
 
-	down(&g5_switch_mutex);
+static void g5_vdnap_switch_volt(int speed_mode)
+{
+	struct pmf_args args;
+	u32 slew, done = 0;
+	unsigned long timeout;
+
+	slew = (speed_mode == CPUFREQ_LOW) ? 1 : 0;
+	args.count = 1;
+	args.u[0].p = &slew;
+
+	pmf_call_one(pfunc_set_vdnap0, &args);
+
+	/* It's an irq GPIO so we should be able to just block here,
+	 * I'll do that later after I've properly tested the IRQ code for
+	 * platform functions
+	 */
+	timeout = jiffies + HZ/10;
+	while(!time_after(jiffies, timeout)) {
+		args.count = 1;
+		args.u[0].p = &done;
+		pmf_call_one(pfunc_vdnap0_complete, &args);
+		if (done)
+			break;
+		msleep(1);
+	}
+	if (done == 0)
+		printk(KERN_WARNING "cpufreq: Timeout in clock slewing !\n");
+}
 
-	freqs.old = g5_cpu_freqs[g5_pmode_cur].frequency;
-	freqs.new = g5_cpu_freqs[speed_mode].frequency;
-	freqs.cpu = 0;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+/*
+ * SCOM based frequency switching for 970FX rev3
+ */
+static int g5_scom_switch_freq(int speed_mode)
+{
+	unsigned long flags;
+	int to;
 
 	/* If frequency is going up, first ramp up the voltage */
 	if (speed_mode < g5_pmode_cur)
 		g5_switch_volt(speed_mode);
 
+	local_irq_save(flags);
+
 	/* Clear PCR high */
 	scom970_write(SCOM_PCR, 0);
 	/* Clear PCR low */
@@ -147,6 +185,8 @@
 		udelay(100);
 	}
 
+	local_irq_restore(flags);
+
 	/* If frequency is going down, last ramp the voltage */
 	if (speed_mode > g5_pmode_cur)
 		g5_switch_volt(speed_mode);
@@ -154,14 +194,10 @@
 	g5_pmode_cur = speed_mode;
 	ppc_proc_freq = g5_cpu_freqs[speed_mode].frequency * 1000ul;
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-
-	up(&g5_switch_mutex);
-
 	return 0;
 }
 
-static int g5_query_freq(void)
+static int g5_scom_query_freq(void)
 {
 	unsigned long psr = scom970_read(SCOM_PSR);
 	int i;
@@ -173,7 +209,104 @@
 	return i;
 }
 
-/* ----------------- cpufreq bookkeeping */
+/*
+ * Platform function based voltage switching for PowerMac7,2 & 7,3
+ */
+
+static struct pmf_function *pfunc_cpu0_volt_high;
+static struct pmf_function *pfunc_cpu0_volt_low;
+static struct pmf_function *pfunc_cpu1_volt_high;
+static struct pmf_function *pfunc_cpu1_volt_low;
+
+static void g5_pfunc_switch_volt(int speed_mode)
+{
+	if (speed_mode == CPUFREQ_HIGH) {
+		if (pfunc_cpu0_volt_high)
+			pmf_call_one(pfunc_cpu0_volt_high, NULL);
+		if (pfunc_cpu1_volt_high)
+			pmf_call_one(pfunc_cpu1_volt_high, NULL);
+	} else {
+		if (pfunc_cpu0_volt_low)
+			pmf_call_one(pfunc_cpu0_volt_low, NULL);
+		if (pfunc_cpu1_volt_low)
+			pmf_call_one(pfunc_cpu1_volt_low, NULL);
+	}
+	msleep(10); /* should be faster , to fix */
+}
+
+/*
+ * Platform function based frequency switching for PowerMac7,2 & 7,3
+ */
+
+static struct pmf_function *pfunc_cpu_setfreq_high;
+static struct pmf_function *pfunc_cpu_setfreq_low;
+static struct pmf_function *pfunc_cpu_getfreq;
+static struct pmf_function *pfunc_slewing_done;;
+
+static int g5_pfunc_switch_freq(int speed_mode)
+{
+	struct pmf_args args;
+	u32 done = 0;
+	unsigned long timeout;
+
+	/* If frequency is going up, first ramp up the voltage */
+	if (speed_mode < g5_pmode_cur)
+		g5_switch_volt(speed_mode);
+
+	/* Do it */
+	if (speed_mode == CPUFREQ_HIGH)
+		pmf_call_one(pfunc_cpu_setfreq_high, NULL);
+	else
+		pmf_call_one(pfunc_cpu_setfreq_low, NULL);
+
+	/* It's an irq GPIO so we should be able to just block here,
+	 * I'll do that later after I've properly tested the IRQ code for
+	 * platform functions
+	 */
+	timeout = jiffies + HZ/10;
+	while(!time_after(jiffies, timeout)) {
+		args.count = 1;
+		args.u[0].p = &done;
+		pmf_call_one(pfunc_slewing_done, &args);
+		if (done)
+			break;
+		msleep(1);
+	}
+	if (done == 0)
+		printk(KERN_WARNING "cpufreq: Timeout in clock slewing !\n");
+
+	/* If frequency is going down, last ramp the voltage */
+	if (speed_mode > g5_pmode_cur)
+		g5_switch_volt(speed_mode);
+
+	g5_pmode_cur = speed_mode;
+	ppc_proc_freq = g5_cpu_freqs[speed_mode].frequency * 1000ul;
+
+	return 0;
+}
+
+static int g5_pfunc_query_freq(void)
+{
+	struct pmf_args args;
+	u32 val = 0;
+
+	args.count = 1;
+	args.u[0].p = &val;
+	pmf_call_one(pfunc_cpu_getfreq, &args);
+	return val ? CPUFREQ_HIGH : CPUFREQ_LOW;
+}
+
+/*
+ * Fake voltage switching for platforms with missing support
+ */
+
+static void g5_dummy_switch_volt(int speed_mode)
+{
+}
+
+/*
+ * Common interface to the cpufreq core
+ */
 
 static int g5_cpufreq_verify(struct cpufreq_policy *policy)
 {
@@ -183,13 +316,30 @@
 static int g5_cpufreq_target(struct cpufreq_policy *policy,
 	unsigned int target_freq, unsigned int relation)
 {
-	unsigned int    newstate = 0;
+	unsigned int newstate = 0;
+	struct cpufreq_freqs freqs;
+	int rc;
 
 	if (cpufreq_frequency_table_target(policy, g5_cpu_freqs,
 			target_freq, relation, &newstate))
 		return -EINVAL;
 
-	return g5_switch_freq(newstate);
+	if (g5_pmode_cur == newstate)
+		return 0;
+
+	down(&g5_switch_mutex);
+
+	freqs.old = g5_cpu_freqs[g5_pmode_cur].frequency;
+	freqs.new = g5_cpu_freqs[newstate].frequency;
+	freqs.cpu = 0;
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	rc = g5_switch_freq(newstate);
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	up(&g5_switch_mutex);
+
+	return rc;
 }
 
 static unsigned int g5_cpufreq_get_speed(unsigned int cpu)
@@ -205,6 +355,7 @@
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	policy->cur = g5_cpu_freqs[g5_query_freq()].frequency;
+	policy->cpus = cpu_possible_map;
 	cpufreq_frequency_table_get_attr(g5_cpu_freqs, policy->cpu);
 
 	return cpufreq_frequency_table_cpuinfo(policy,
@@ -224,19 +375,39 @@
 };
 
 
-static int __init g5_cpufreq_init(void)
+static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 {
 	struct device_node *cpunode;
 	unsigned int psize, ssize;
-	struct smu_sdbp_header *shdr;
 	unsigned long max_freq;
-	u32 *valp;
+	char *freq_method, *volt_method;
+	u32 *valp, pvr_hi;
+	int use_volts_vdnap = 0;
+	int use_volts_smu = 0;
 	int rc = -ENODEV;
 
-	/* Look for CPU and SMU nodes */
-	cpunode = of_find_node_by_type(NULL, "cpu");
-	if (!cpunode) {
-		DBG("No CPU node !\n");
+	/* Check supported platforms */
+	if (machine_is_compatible("PowerMac8,1") ||
+	    machine_is_compatible("PowerMac8,2") ||
+	    machine_is_compatible("PowerMac9,1"))
+		use_volts_smu = 1;
+	else if (machine_is_compatible("PowerMac11,2"))
+		use_volts_vdnap = 1;
+	else
+		return -ENODEV;
+
+	/* Get first CPU node */
+	for (cpunode = NULL;
+	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
+		u32 *reg =
+			(u32 *)get_property(cpunode, "reg", NULL);
+		if (reg == NULL || (*reg) != 0)
+			continue;
+		if (!strcmp(cpunode->type, "cpu"))
+			break;
+	}
+	if (cpunode == NULL) {
+		printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
 		return -ENODEV;
 	}
 
@@ -246,8 +417,9 @@
 		DBG("No cpu-version property !\n");
 		goto bail_noprops;
 	}
-	if (((*valp) >> 16) != 0x3c) {
-		DBG("Wrong CPU version: %08x\n", *valp);
+	pvr_hi = (*valp) >> 16;
+	if (pvr_hi != 0x3c && pvr_hi != 0x44) {
+		printk(KERN_ERR "cpufreq: Unsupported CPU version\n");
 		goto bail_noprops;
 	}
 
@@ -259,18 +431,50 @@
 	}
 	g5_pmode_max = psize / sizeof(u32) - 1;
 
-	/* Look for the FVT table */
-	shdr = smu_get_sdb_partition(SMU_SDB_FVT_ID, NULL);
-	if (!shdr)
-		goto bail_noprops;
-	g5_fvt_table = (struct smu_sdbp_fvt *)&shdr[1];
-	ssize = (shdr->len * sizeof(u32)) - sizeof(struct smu_sdbp_header);
-	g5_fvt_count = ssize / sizeof(struct smu_sdbp_fvt);
-	g5_fvt_cur = 0;
+	if (use_volts_smu) {
+		struct smu_sdbp_header *shdr;
 
-	/* Sanity checking */
-	if (g5_fvt_count < 1 || g5_pmode_max < 1)
-		goto bail_noprops;
+		/* Look for the FVT table */
+		shdr = smu_get_sdb_partition(SMU_SDB_FVT_ID, NULL);
+		if (!shdr)
+			goto bail_noprops;
+		g5_fvt_table = (struct smu_sdbp_fvt *)&shdr[1];
+		ssize = (shdr->len * sizeof(u32)) -
+			sizeof(struct smu_sdbp_header);
+		g5_fvt_count = ssize / sizeof(struct smu_sdbp_fvt);
+		g5_fvt_cur = 0;
+
+		/* Sanity checking */
+		if (g5_fvt_count < 1 || g5_pmode_max < 1)
+			goto bail_noprops;
+
+		g5_switch_volt = g5_smu_switch_volt;
+		volt_method = "SMU";
+	} else if (use_volts_vdnap) {
+		struct device_node *root;
+
+		root = of_find_node_by_path("/");
+		if (root == NULL) {
+			printk(KERN_ERR "cpufreq: Can't find root of "
+			       "device tree\n");
+			goto bail_noprops;
+		}
+		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
+		pfunc_vdnap0_complete =
+			pmf_find_function(root, "slewing-done");
+		if (pfunc_set_vdnap0 == NULL ||
+		    pfunc_vdnap0_complete == NULL) {
+			printk(KERN_ERR "cpufreq: Can't find required "
+			       "platform function\n");
+			goto bail_noprops;
+		}
+
+		g5_switch_volt = g5_vdnap_switch_volt;
+		volt_method = "GPIO";
+	} else {
+		g5_switch_volt = g5_dummy_switch_volt;
+		volt_method = "none";
+	}
 
 	/*
 	 * From what I see, clock-frequency is always the maximal frequency.
@@ -286,19 +490,23 @@
 	g5_cpu_freqs[0].frequency = max_freq;
 	g5_cpu_freqs[1].frequency = max_freq/2;
 
-	/* Check current frequency */
-	g5_pmode_cur = g5_query_freq();
-	if (g5_pmode_cur > 1)
-		/* We don't support anything but 1:1 and 1:2, fixup ... */
-		g5_pmode_cur = 1;
+	/* Set callbacks */
+	g5_switch_freq = g5_scom_switch_freq;
+	g5_query_freq = g5_scom_query_freq;
+	freq_method = "SCOM";
 
 	/* Force apply current frequency to make sure everything is in
 	 * sync (voltage is right for example). Firmware may leave us with
 	 * a strange setting ...
 	 */
-	g5_switch_freq(g5_pmode_cur);
+	g5_switch_volt(CPUFREQ_HIGH);
+	msleep(10);
+	g5_pmode_cur = -1;
+	g5_switch_freq(g5_query_freq());
 
 	printk(KERN_INFO "Registering G5 CPU frequency driver\n");
+	printk(KERN_INFO "Frequency method: %s, Voltage method: %s\n",
+	       freq_method, volt_method);
 	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
 		g5_cpu_freqs[1].frequency/1000,
 		g5_cpu_freqs[0].frequency/1000,
@@ -317,6 +525,201 @@
 	return rc;
 }
 
+static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
+{
+	struct device_node *cpuid = NULL, *hwclock = NULL, *cpunode = NULL;
+	u8 *eeprom = NULL;
+	u32 *valp;
+	u64 max_freq, min_freq, ih, il;
+	int has_volt = 1, rc = 0;
+
+	/* Get first CPU node */
+	for (cpunode = NULL;
+	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
+		if (!strcmp(cpunode->type, "cpu"))
+			break;
+	}
+	if (cpunode == NULL) {
+		printk(KERN_ERR "cpufreq: Can't find any CPU node\n");
+		return -ENODEV;
+	}
+
+	/* Lookup the cpuid eeprom node */
+        cpuid = of_find_node_by_path("/u3@0,f8000000/i2c@f8001000/cpuid@a0");
+	if (cpuid != NULL)
+		eeprom = (u8 *)get_property(cpuid, "cpuid", NULL);
+	if (eeprom == NULL) {
+		printk(KERN_ERR "cpufreq: Can't find cpuid EEPROM !\n");
+		rc = -ENODEV;
+		goto bail;
+	}
+
+	/* Lookup the i2c hwclock */
+	for (hwclock = NULL;
+	     (hwclock = of_find_node_by_name(hwclock, "i2c-hwclock")) != NULL;){
+		char *loc = get_property(hwclock, "hwctrl-location", NULL);
+		if (loc == NULL)
+			continue;
+		if (strcmp(loc, "CPU CLOCK"))
+			continue;
+		if (!get_property(hwclock, "platform-get-frequency", NULL))
+			continue;
+		break;
+	}
+	if (hwclock == NULL) {
+		printk(KERN_ERR "cpufreq: Can't find i2c clock chip !\n");
+		rc = -ENODEV;
+		goto bail;
+	}
+
+	DBG("cpufreq: i2c clock chip found: %s\n", hwclock->full_name);
+
+	/* Now get all the platform functions */
+	pfunc_cpu_getfreq =
+		pmf_find_function(hwclock, "get-frequency");
+	pfunc_cpu_setfreq_high =
+		pmf_find_function(hwclock, "set-frequency-high");
+	pfunc_cpu_setfreq_low =
+		pmf_find_function(hwclock, "set-frequency-low");
+	pfunc_slewing_done =
+		pmf_find_function(hwclock, "slewing-done");
+	pfunc_cpu0_volt_high =
+		pmf_find_function(hwclock, "set-voltage-high-0");
+	pfunc_cpu0_volt_low =
+		pmf_find_function(hwclock, "set-voltage-low-0");
+	pfunc_cpu1_volt_high =
+		pmf_find_function(hwclock, "set-voltage-high-1");
+	pfunc_cpu1_volt_low =
+		pmf_find_function(hwclock, "set-voltage-low-1");
+
+	/* Check we have minimum requirements */
+	if (pfunc_cpu_getfreq == NULL || pfunc_cpu_setfreq_high == NULL ||
+	    pfunc_cpu_setfreq_low == NULL || pfunc_slewing_done == NULL) {
+		printk(KERN_ERR "cpufreq: Can't find platform functions !\n");
+		rc = -ENODEV;
+		goto bail;
+	}
+
+	/* Check that we have complete sets */
+	if (pfunc_cpu0_volt_high == NULL || pfunc_cpu0_volt_low == NULL) {
+		pmf_put_function(pfunc_cpu0_volt_high);
+		pmf_put_function(pfunc_cpu0_volt_low);
+		pfunc_cpu0_volt_high = pfunc_cpu0_volt_low = NULL;
+		has_volt = 0;
+	}
+	if (!has_volt ||
+	    pfunc_cpu1_volt_high == NULL || pfunc_cpu1_volt_low == NULL) {
+		pmf_put_function(pfunc_cpu1_volt_high);
+		pmf_put_function(pfunc_cpu1_volt_low);
+		pfunc_cpu1_volt_high = pfunc_cpu1_volt_low = NULL;
+	}
+
+	/* Note: The device tree also contains a "platform-set-values"
+	 * function for which I haven't quite figured out the usage. It
+	 * might have to be called on init and/or wakeup, I'm not too sure
+	 * but things seem to work fine without it so far ...
+	 */
+
+	/* Get max frequency from device-tree */
+	valp = (u32 *)get_property(cpunode, "clock-frequency", NULL);
+	if (!valp) {
+		printk(KERN_ERR "cpufreq: Can't find CPU frequency !\n");
+		rc = -ENODEV;
+		goto bail;
+	}
+
+	max_freq = (*valp)/1000;
+
+	/* Now calculate reduced frequency by using the cpuid input freq
+	 * ratio. This requires 64 bits math unless we are willing to lose
+	 * some precision
+	 */
+	      
+	ih = *((u32 *)(eeprom + 0x10));
+	il = *((u32 *)(eeprom + 0x20));
+	min_freq = 0;
+	if (ih != 0 && il != 0)
+		min_freq = (max_freq * il) / ih;
+
+	/* Sanity check */
+	if (min_freq >= max_freq || min_freq < 1000) {
+		printk(KERN_ERR "cpufreq: Can't calculate low frequency !\n");
+		rc = -ENODEV;
+		goto bail;
+	}
+	g5_cpu_freqs[0].frequency = max_freq;
+	g5_cpu_freqs[1].frequency = min_freq;
+
+	/* Set callbacks */
+	g5_switch_volt = g5_pfunc_switch_volt;
+	g5_switch_freq = g5_pfunc_switch_freq;
+	g5_query_freq = g5_pfunc_query_freq;
+
+	/* Force apply current frequency to make sure everything is in
+	 * sync (voltage is right for example). Firmware may leave us with
+	 * a strange setting ...
+	 */
+	g5_switch_volt(CPUFREQ_HIGH);
+	msleep(10);
+	g5_pmode_cur = -1;
+	g5_switch_freq(g5_query_freq());
+
+	printk(KERN_INFO "Registering G5 CPU frequency driver\n");
+	printk(KERN_INFO "Frequency method: i2c/pfunc, "
+	       "Voltage method: %s\n", has_volt ? "i2c/pfunc" : "none");
+	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
+		g5_cpu_freqs[1].frequency/1000,
+		g5_cpu_freqs[0].frequency/1000,
+		g5_cpu_freqs[g5_pmode_cur].frequency/1000);
+
+	rc = cpufreq_register_driver(&g5_cpufreq_driver);
+ bail:
+	if (rc != 0) {
+		pmf_put_function(pfunc_cpu_getfreq);
+		pmf_put_function(pfunc_cpu_setfreq_high);
+		pmf_put_function(pfunc_cpu_setfreq_low);
+		pmf_put_function(pfunc_slewing_done);
+		pmf_put_function(pfunc_cpu0_volt_high);
+		pmf_put_function(pfunc_cpu0_volt_low);
+		pmf_put_function(pfunc_cpu1_volt_high);
+		pmf_put_function(pfunc_cpu1_volt_low);
+	}
+	of_node_put(hwclock);
+	of_node_put(cpuid);
+	of_node_put(cpunode);
+
+	return rc;
+}
+
+static int __init g5_rm31_cpufreq_init(struct device_node *cpus)
+{
+	/* NYI */
+	return 0;
+}
+
+static int __init g5_cpufreq_init(void)
+{
+	struct device_node *cpus;
+	int rc;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (cpus == NULL) {
+		DBG("No /cpus node !\n");
+		return -ENODEV;
+	}
+
+	if (machine_is_compatible("PowerMac7,2") ||
+	    machine_is_compatible("PowerMac7,3"))
+		rc = g5_pm72_cpufreq_init(cpus);
+	else if (machine_is_compatible("RackMac3,1"))
+		rc = g5_rm31_cpufreq_init(cpus);
+	else
+		rc = g5_neo2_cpufreq_init(cpus);
+
+	of_node_put(cpus);
+	return rc;
+}
+
 module_init(g5_cpufreq_init);
 
 
