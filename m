From: John Steele Scott <toojays@toojays.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: nearly-working support for cpufreq on 2004 iBook G4 with 7447A cpu
Date: Sun, 30 May 2004 23:31:14 +0930
Cc: Christiaan Welvaart <cjw@daneel.dyndns.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200405302331.35357.toojays@toojays.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi all,

I have written a patch against kernel 2.6.6 which lets the pmac cpufreq driver
support dynamic frequency scaling on the 7447A cpu in my new iBook. It also
fixes the incorrect clock speed reporting (i.e. on boot 2.6.6 reports cpu is
running at 1066 MHz when really it is 533 MHz).

Unfortunately, if I use this to set my cpu frequency up to 1 GHz, my system
locks up hard when I try and do something cpu-intensive. Christiaan Welvaart
has tested the previous version of this patch (functionally the same, but a
bit messier), and on his system it works fine. Yet even if I use the exact
same kernel as him, my system locks up. Both systems are 1 GHz, 12" iBooks.

Does anyone have any ideas on why this might not work on my system? Is there
something else that needs to be looked at when increasing the frequency after
booting?

cheers,

John

diff -ru /usr/src/linux-2.6.6-bak/arch/ppc/kernel/misc.S ../kernel/misc.S
- --- /usr/src/linux-2.6.6-bak/arch/ppc/kernel/misc.S	2004-05-13
22:59:00.000000000 +0930
+++ ../kernel/misc.S	2004-05-28 12:47:22.000000000 +0930
@@ -253,6 +253,24 @@
 	mtmsr	r7
 	blr

+_GLOBAL(choose_7447a_dfs)
+	/* Clear MSR:EE */
+	mfmsr	r7
+	rlwinm	r0,r7,0,17,15
+	mtmsr	r0
+
+	/* Calc new HID1 value */
+	mfspr	r4,SPRN_HID1
+	insrwi	r4,r3,1,9	/* insert parameter into bit 9 */
+	sync
+	mtspr	SPRN_HID1,r4
+	sync
+	isync
+
+	/* Return */
+	mtmsr	r7
+	blr
+
 #endif /* CONFIG_CPU_FREQ_PMAC && CONFIG_6xx */

 /* void local_save_flags_ptr(unsigned long *flags) */
diff
- -ru /usr/src/linux-2.6.6-bak/arch/ppc/platforms/pmac_cpufreq.c ../platforms/pmac_cpufreq.c
- --- /usr/src/linux-2.6.6-bak/arch/ppc/platforms/pmac_cpufreq.c	2004-05-13
22:59:00.000000000 +0930
+++ ../platforms/pmac_cpufreq.c	2004-05-30 22:56:07.369451720 +0930
@@ -47,6 +47,7 @@
 #warning "WARNING, CPUFREQ not recommended on SMP kernels"
 #endif

+extern void choose_7447a_dfs(int dfs);
 extern void low_choose_750fx_pll(int pll);
 extern void low_sleep_handler(void);
 extern void openpic_suspend(struct sys_device *sysdev, u32 state);
@@ -61,6 +62,7 @@
 /* Clean that up some day ... use a func ptr or at least an enum... */
 static int cpufreq_uses_pmu;
 static int cpufreq_uses_gpios;
+static int cpufreq_uses_dfs;

 static u32 voltage_gpio;
 static u32 frequency_gpio;
@@ -273,6 +275,10 @@
 		rc = pmu_set_cpu_speed(speed_mode);
 	else if (cpufreq_uses_gpios)
 		rc = gpios_set_cpu_speed(speed_mode);
+	else if (cpufreq_uses_dfs){
+		choose_7447a_dfs(speed_mode);
+		rc = 0;
+	}
 	else
 		rc = cpu_750fx_cpu_speed(speed_mode);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
@@ -346,6 +352,7 @@
  *  - iBook2 500 (PMU based, 400Mhz & 500Mhz)
  *  - iBook2 700 (CPU based, 400Mhz & 700Mhz, support low voltage)
  *  - Recent MacRISC3 machines
+ *  - iBook G4s with 7447A CPUs (experimental, unstable)
  */
 static int __init pmac_cpufreq_setup(void)
 {
@@ -371,6 +378,20 @@
 	if (machine_is_compatible("PowerBook3,4") ||
 	    machine_is_compatible("PowerBook3,5") ||
 	    machine_is_compatible("MacRISC3")) {
+
+		/*  Check for 7447A based iBook G4 */
+		if (machine_is_compatible("PowerBook6,5")) {
+			cur_freq /= 2;	/* OF reports wrong frequency */
+			hi_freq = cur_freq*2;
+			low_freq = cur_freq;
+			has_freq_ctl = 1;
+			cpufreq_uses_pmu = 0;
+			cpufreq_uses_gpios = 0;
+			cpufreq_uses_dfs = 1;
+			has_freq_ctl = 1;
+			goto out;
+		}
+
 		struct device_node *volt_gpio_np = of_find_node_by_name(NULL,
"voltage-gpio");
 		struct device_node *freq_gpio_np = of_find_node_by_name(NULL,
"frequency-gpio");
 		struct device_node *slew_done_gpio_np = of_find_node_by_name(NULL,
"slewing-done");
@@ -487,6 +508,7 @@
 		cpufreq_uses_pmu = 0;
 		has_freq_ctl = 1;
 	}
+
 out:
 	if (!has_freq_ctl)
 		return -ENODEV;
@@ -497,7 +519,7 @@
 	printk(KERN_INFO "Registering PowerMac CPU frequency driver\n");
 	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Boot: %d Mhz, switch method:
%s\n",
 	       low_freq/1000, hi_freq/1000, cur_freq/1000,
- -	       cpufreq_uses_pmu ? "PMU" : (cpufreq_uses_gpios ? "GPIOs" : "CPU"));
+	       cpufreq_uses_pmu ? "PMU" : (cpufreq_uses_gpios ? "GPIOs" :
(cpufreq_uses_dfs ? "DFS" : "CPU")));

 	return cpufreq_register_driver(&pmac_cpufreq_driver);
 }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
