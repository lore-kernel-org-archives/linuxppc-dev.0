Return-Path: <jdl@jdl.com>
From: Jon Loeliger <linuxppc@jdl.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
In-Reply-To: Your message of "Sat, 17 Sep 2005 10:31:52 CDT."
	<E1EGefQ-00072D-34@jdl.com>
References: <E1EGefQ-00072D-34@jdl.com> 
Date: Sat, 17 Sep 2005 10:35:08 -0500
Message-Id: <E1EGeia-00072b-5p@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH powerpc: 01/04 Remove sections use from ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -644,7 +644,7 @@ pcibios_alloc_controller(void)
 /*
  * Functions below are used on OpenFirmware machines.
  */
-static void __openfirmware
+static void
 make_one_node_map(struct device_node* node, u8 pci_bus)
 {
 	int *bus_range;
@@ -678,7 +678,7 @@ make_one_node_map(struct device_node* no
 	}
 }
 	
-void __openfirmware
+void
 pcibios_make_OF_bus_map(void)
 {
 	int i;
@@ -720,7 +720,7 @@ pcibios_make_OF_bus_map(void)
 
 typedef int (*pci_OF_scan_iterator)(struct device_node* node, void* data);
 
-static struct device_node* __openfirmware
+static struct device_node*
 scan_OF_pci_childs(struct device_node* node, pci_OF_scan_iterator filter, void* data)
 {
 	struct device_node* sub_node;
@@ -761,7 +761,7 @@ scan_OF_pci_childs_iterator(struct devic
 	return 0;
 }
 
-static struct device_node* __openfirmware
+static struct device_node*
 scan_OF_childs_for_device(struct device_node* node, u8 bus, u8 dev_fn)
 {
 	u8 filter_data[2] = {bus, dev_fn};
@@ -842,7 +842,7 @@ pci_find_hose_for_OF_device(struct devic
 	return NULL;
 }
 
-static int __openfirmware
+static int
 find_OF_pci_device_filter(struct device_node* node, void* data)
 {
 	return ((void *)node == data);
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -339,7 +339,7 @@ early_init(int r3, int r4, int r5)
  * Assume here that all clock rates are the same in a
  * smp system.  -- Cort
  */
-int __openfirmware
+int
 of_show_percpuinfo(struct seq_file *m, int i)
 {
 	struct device_node *cpu_node;
diff --git a/arch/ppc/platforms/chrp_pci.c b/arch/ppc/platforms/chrp_pci.c
--- a/arch/ppc/platforms/chrp_pci.c
+++ b/arch/ppc/platforms/chrp_pci.c
@@ -29,7 +29,7 @@ void __iomem *gg2_pci_config_base;
  * limit the bus number to 3 bits
  */
 
-int __chrp gg2_read_config(struct pci_bus *bus, unsigned int devfn, int off,
+int gg2_read_config(struct pci_bus *bus, unsigned int devfn, int off,
 			   int len, u32 *val)
 {
 	volatile void __iomem *cfg_data;
@@ -56,7 +56,7 @@ int __chrp gg2_read_config(struct pci_bu
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int __chrp gg2_write_config(struct pci_bus *bus, unsigned int devfn, int off,
+int gg2_write_config(struct pci_bus *bus, unsigned int devfn, int off,
 			    int len, u32 val)
 {
 	volatile void __iomem *cfg_data;
@@ -92,7 +92,7 @@ static struct pci_ops gg2_pci_ops =
 /*
  * Access functions for PCI config space using RTAS calls.
  */
-int __chrp
+int
 rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		 int len, u32 *val)
 {
@@ -108,7 +108,7 @@ rtas_read_config(struct pci_bus *bus, un
 	return rval? PCIBIOS_DEVICE_NOT_FOUND: PCIBIOS_SUCCESSFUL;
 }
 
-int __chrp
+int
 rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		  int len, u32 val)
 {
diff --git a/arch/ppc/platforms/chrp_setup.c b/arch/ppc/platforms/chrp_setup.c
--- a/arch/ppc/platforms/chrp_setup.c
+++ b/arch/ppc/platforms/chrp_setup.c
@@ -105,7 +105,7 @@ static const char *gg2_cachemodes[4] = {
 	"Disabled", "Write-Through", "Copy-Back", "Transparent Mode"
 };
 
-int __chrp
+int
 chrp_show_cpuinfo(struct seq_file *m)
 {
 	int i, sdramen;
@@ -303,7 +303,7 @@ void __init chrp_setup_arch(void)
 	pci_create_OF_bus_map();
 }
 
-void __chrp
+void
 chrp_event_scan(void)
 {
 	unsigned char log[1024];
@@ -314,7 +314,7 @@ chrp_event_scan(void)
 	ppc_md.heartbeat_count = ppc_md.heartbeat_reset;
 }
 
-void __chrp
+void
 chrp_restart(char *cmd)
 {
 	printk("RTAS system-reboot returned %d\n",
@@ -322,7 +322,7 @@ chrp_restart(char *cmd)
 	for (;;);
 }
 
-void __chrp
+void
 chrp_power_off(void)
 {
 	/* allow power on only with power button press */
@@ -331,13 +331,13 @@ chrp_power_off(void)
 	for (;;);
 }
 
-void __chrp
+void
 chrp_halt(void)
 {
 	chrp_power_off();
 }
 
-u_int __chrp
+u_int
 chrp_irq_canonicalize(u_int irq)
 {
 	if (irq == 2)
@@ -572,7 +572,7 @@ chrp_init(unsigned long r3, unsigned lon
 	if (ppc_md.progress) ppc_md.progress("Linux/PPC "UTS_RELEASE"\n", 0x0);
 }
 
-void __chrp
+void
 rtas_display_progress(char *s, unsigned short hex)
 {
 	int width;
@@ -599,7 +599,7 @@ rtas_display_progress(char *s, unsigned 
 	call_rtas( "display-character", 1, 1, NULL, ' ' );
 }
 
-void __chrp
+void
 rtas_indicator_progress(char *s, unsigned short hex)
 {
 	call_rtas("set-indicator", 3, 1, NULL, 6, 0, hex);
diff --git a/arch/ppc/platforms/chrp_smp.c b/arch/ppc/platforms/chrp_smp.c
--- a/arch/ppc/platforms/chrp_smp.c
+++ b/arch/ppc/platforms/chrp_smp.c
@@ -88,7 +88,7 @@ smp_chrp_take_timebase(void)
 }
 
 /* CHRP with openpic */
-struct smp_ops_t chrp_smp_ops __chrpdata = {
+struct smp_ops_t chrp_smp_ops = {
 	.message_pass = smp_openpic_message_pass,
 	.probe = smp_chrp_probe,
 	.kick_cpu = smp_chrp_kick_cpu,
diff --git a/arch/ppc/platforms/chrp_time.c b/arch/ppc/platforms/chrp_time.c
--- a/arch/ppc/platforms/chrp_time.c
+++ b/arch/ppc/platforms/chrp_time.c
@@ -52,7 +52,7 @@ long __init chrp_time_init(void)
 	return 0;
 }
 
-int __chrp chrp_cmos_clock_read(int addr)
+int chrp_cmos_clock_read(int addr)
 {
 	if (nvram_as1 != 0)
 		outb(addr>>8, nvram_as1);
@@ -60,7 +60,7 @@ int __chrp chrp_cmos_clock_read(int addr
 	return (inb(nvram_data));
 }
 
-void __chrp chrp_cmos_clock_write(unsigned long val, int addr)
+void chrp_cmos_clock_write(unsigned long val, int addr)
 {
 	if (nvram_as1 != 0)
 		outb(addr>>8, nvram_as1);
@@ -72,7 +72,7 @@ void __chrp chrp_cmos_clock_write(unsign
 /*
  * Set the hardware clock. -- Cort
  */
-int __chrp chrp_set_rtc_time(unsigned long nowtime)
+int chrp_set_rtc_time(unsigned long nowtime)
 {
 	unsigned char save_control, save_freq_select;
 	struct rtc_time tm;
@@ -118,7 +118,7 @@ int __chrp chrp_set_rtc_time(unsigned lo
 	return 0;
 }
 
-unsigned long __chrp chrp_get_rtc_time(void)
+unsigned long chrp_get_rtc_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	int uip, i;
diff --git a/arch/ppc/platforms/pmac_backlight.c b/arch/ppc/platforms/pmac_backlight.c
--- a/arch/ppc/platforms/pmac_backlight.c
+++ b/arch/ppc/platforms/pmac_backlight.c
@@ -37,7 +37,7 @@ static int backlight_req_enable = -1;
 static void backlight_callback(void *);
 static DECLARE_WORK(backlight_work, backlight_callback, NULL);
 
-void __pmac register_backlight_controller(struct backlight_controller *ctrler,
+void register_backlight_controller(struct backlight_controller *ctrler,
 					  void *data, char *type)
 {
 	struct device_node* bk_node;
@@ -99,7 +99,7 @@ void __pmac register_backlight_controlle
 }
 EXPORT_SYMBOL(register_backlight_controller);
 
-void __pmac unregister_backlight_controller(struct backlight_controller
+void unregister_backlight_controller(struct backlight_controller
 					    *ctrler, void *data)
 {
 	/* We keep the current backlight level (for now) */
@@ -108,7 +108,7 @@ void __pmac unregister_backlight_control
 }
 EXPORT_SYMBOL(unregister_backlight_controller);
 
-static int __pmac __set_backlight_enable(int enable)
+static int __set_backlight_enable(int enable)
 {
 	int rc;
 
@@ -122,7 +122,7 @@ static int __pmac __set_backlight_enable
 	release_console_sem();
 	return rc;
 }
-int __pmac set_backlight_enable(int enable)
+int set_backlight_enable(int enable)
 {
 	if (!backlighter)
 		return -ENODEV;
@@ -133,7 +133,7 @@ int __pmac set_backlight_enable(int enab
 
 EXPORT_SYMBOL(set_backlight_enable);
 
-int __pmac get_backlight_enable(void)
+int get_backlight_enable(void)
 {
 	if (!backlighter)
 		return -ENODEV;
@@ -141,7 +141,7 @@ int __pmac get_backlight_enable(void)
 }
 EXPORT_SYMBOL(get_backlight_enable);
 
-static int __pmac __set_backlight_level(int level)
+static int __set_backlight_level(int level)
 {
 	int rc = 0;
 
@@ -165,7 +165,7 @@ static int __pmac __set_backlight_level(
 	}
 	return rc;
 }
-int __pmac set_backlight_level(int level)
+int set_backlight_level(int level)
 {
 	if (!backlighter)
 		return -ENODEV;
@@ -176,7 +176,7 @@ int __pmac set_backlight_level(int level
 
 EXPORT_SYMBOL(set_backlight_level);
 
-int __pmac get_backlight_level(void)
+int get_backlight_level(void)
 {
 	if (!backlighter)
 		return -ENODEV;
diff --git a/arch/ppc/platforms/pmac_cpufreq.c b/arch/ppc/platforms/pmac_cpufreq.c
--- a/arch/ppc/platforms/pmac_cpufreq.c
+++ b/arch/ppc/platforms/pmac_cpufreq.c
@@ -136,7 +136,7 @@ static inline void debug_calc_bogomips(v
 
 /* Switch CPU speed under 750FX CPU control
  */
-static int __pmac cpu_750fx_cpu_speed(int low_speed)
+static int cpu_750fx_cpu_speed(int low_speed)
 {
 	u32 hid2;
 
@@ -172,7 +172,7 @@ static int __pmac cpu_750fx_cpu_speed(in
 	return 0;
 }
 
-static unsigned int __pmac cpu_750fx_get_cpu_speed(void)
+static unsigned int cpu_750fx_get_cpu_speed(void)
 {
 	if (mfspr(SPRN_HID1) & HID1_PS)
 		return low_freq;
@@ -181,7 +181,7 @@ static unsigned int __pmac cpu_750fx_get
 }
 
 /* Switch CPU speed using DFS */
-static int __pmac dfs_set_cpu_speed(int low_speed)
+static int dfs_set_cpu_speed(int low_speed)
 {
 	if (low_speed == 0) {
 		/* ramping up, set voltage first */
@@ -205,7 +205,7 @@ static int __pmac dfs_set_cpu_speed(int 
 	return 0;
 }
 
-static unsigned int __pmac dfs_get_cpu_speed(void)
+static unsigned int dfs_get_cpu_speed(void)
 {
 	if (mfspr(SPRN_HID1) & HID1_DFS)
 		return low_freq;
@@ -216,7 +216,7 @@ static unsigned int __pmac dfs_get_cpu_s
 
 /* Switch CPU speed using slewing GPIOs
  */
-static int __pmac gpios_set_cpu_speed(int low_speed)
+static int gpios_set_cpu_speed(int low_speed)
 {
 	int gpio, timeout = 0;
 
@@ -258,7 +258,7 @@ static int __pmac gpios_set_cpu_speed(in
 
 /* Switch CPU speed under PMU control
  */
-static int __pmac pmu_set_cpu_speed(int low_speed)
+static int pmu_set_cpu_speed(int low_speed)
 {
 	struct adb_request req;
 	unsigned long save_l2cr;
@@ -354,7 +354,7 @@ static int __pmac pmu_set_cpu_speed(int 
 	return 0;
 }
 
-static int __pmac do_set_cpu_speed(int speed_mode, int notify)
+static int do_set_cpu_speed(int speed_mode, int notify)
 {
 	struct cpufreq_freqs freqs;
 	unsigned long l3cr;
@@ -391,17 +391,17 @@ static int __pmac do_set_cpu_speed(int s
 	return 0;
 }
 
-static unsigned int __pmac pmac_cpufreq_get_speed(unsigned int cpu)
+static unsigned int pmac_cpufreq_get_speed(unsigned int cpu)
 {
 	return cur_freq;
 }
 
-static int __pmac pmac_cpufreq_verify(struct cpufreq_policy *policy)
+static int pmac_cpufreq_verify(struct cpufreq_policy *policy)
 {
 	return cpufreq_frequency_table_verify(policy, pmac_cpu_freqs);
 }
 
-static int __pmac pmac_cpufreq_target(	struct cpufreq_policy *policy,
+static int pmac_cpufreq_target(	struct cpufreq_policy *policy,
 					unsigned int target_freq,
 					unsigned int relation)
 {
@@ -414,13 +414,13 @@ static int __pmac pmac_cpufreq_target(	s
 	return do_set_cpu_speed(newstate, 1);
 }
 
-unsigned int __pmac pmac_get_one_cpufreq(int i)
+unsigned int pmac_get_one_cpufreq(int i)
 {
 	/* Supports only one CPU for now */
 	return (i == 0) ? cur_freq : 0;
 }
 
-static int __pmac pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
+static int pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -ENODEV;
@@ -433,7 +433,7 @@ static int __pmac pmac_cpufreq_cpu_init(
 	return cpufreq_frequency_table_cpuinfo(policy, pmac_cpu_freqs);
 }
 
-static u32 __pmac read_gpio(struct device_node *np)
+static u32 read_gpio(struct device_node *np)
 {
 	u32 *reg = (u32 *)get_property(np, "reg", NULL);
 	u32 offset;
@@ -452,7 +452,7 @@ static u32 __pmac read_gpio(struct devic
 	return offset;
 }
 
-static int __pmac pmac_cpufreq_suspend(struct cpufreq_policy *policy, pm_message_t pmsg)
+static int pmac_cpufreq_suspend(struct cpufreq_policy *policy, pm_message_t pmsg)
 {
 	/* Ok, this could be made a bit smarter, but let's be robust for now. We
 	 * always force a speed change to high speed before sleep, to make sure
@@ -468,7 +468,7 @@ static int __pmac pmac_cpufreq_suspend(s
 	return 0;
 }
 
-static int __pmac pmac_cpufreq_resume(struct cpufreq_policy *policy)
+static int pmac_cpufreq_resume(struct cpufreq_policy *policy)
 {
 	/* If we resume, first check if we have a get() function */
 	if (get_speed_proc)
@@ -501,7 +501,7 @@ static struct cpufreq_driver pmac_cpufre
 };
 
 
-static int __pmac pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
+static int pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
 {
 	struct device_node *volt_gpio_np = of_find_node_by_name(NULL,
 								"voltage-gpio");
@@ -593,7 +593,7 @@ static int __pmac pmac_cpufreq_init_MacR
 	return 0;
 }
 
-static int __pmac pmac_cpufreq_init_7447A(struct device_node *cpunode)
+static int pmac_cpufreq_init_7447A(struct device_node *cpunode)
 {
 	struct device_node *volt_gpio_np;
 
@@ -620,7 +620,7 @@ static int __pmac pmac_cpufreq_init_7447
 	return 0;
 }
 
-static int __pmac pmac_cpufreq_init_750FX(struct device_node *cpunode)
+static int pmac_cpufreq_init_750FX(struct device_node *cpunode)
 {
 	struct device_node *volt_gpio_np;
 	u32 pvr, *value;
diff --git a/arch/ppc/platforms/pmac_feature.c b/arch/ppc/platforms/pmac_feature.c
--- a/arch/ppc/platforms/pmac_feature.c
+++ b/arch/ppc/platforms/pmac_feature.c
@@ -63,7 +63,7 @@ extern struct device_node *k2_skiplist[2
  * We use a single global lock to protect accesses. Each driver has
  * to take care of its own locking
  */
-static DEFINE_SPINLOCK(feature_lock  __pmacdata);
+static DEFINE_SPINLOCK(feature_lock);
 
 #define LOCK(flags)	spin_lock_irqsave(&feature_lock, flags);
 #define UNLOCK(flags)	spin_unlock_irqrestore(&feature_lock, flags);
@@ -72,9 +72,9 @@ static DEFINE_SPINLOCK(feature_lock  __p
 /*
  * Instance of some macio stuffs
  */
-struct macio_chip macio_chips[MAX_MACIO_CHIPS]  __pmacdata;
+struct macio_chip macio_chips[MAX_MACIO_CHIPS];
 
-struct macio_chip* __pmac macio_find(struct device_node* child, int type)
+struct macio_chip* macio_find(struct device_node* child, int type)
 {
 	while(child) {
 		int	i;
@@ -89,7 +89,7 @@ struct macio_chip* __pmac macio_find(str
 }
 EXPORT_SYMBOL_GPL(macio_find);
 
-static const char* macio_names[] __pmacdata =
+static const char* macio_names[] =
 {
 	"Unknown",
 	"Grand Central",
@@ -116,10 +116,10 @@ static const char* macio_names[] __pmacd
 #define UN_BIS(r,v)	(UN_OUT((r), UN_IN(r) | (v)))
 #define UN_BIC(r,v)	(UN_OUT((r), UN_IN(r) & ~(v)))
 
-static struct device_node* uninorth_node __pmacdata;
-static u32 __iomem * uninorth_base __pmacdata;
-static u32 uninorth_rev __pmacdata;
-static int uninorth_u3 __pmacdata;
+static struct device_node* uninorth_node;
+static u32 __iomem * uninorth_base;
+static u32 uninorth_rev;
+static int uninorth_u3;
 static void __iomem *u3_ht;
 
 /*
@@ -142,13 +142,13 @@ struct pmac_mb_def
 	struct feature_table_entry* 	features;
 	unsigned long			board_flags;
 };
-static struct pmac_mb_def pmac_mb __pmacdata;
+static struct pmac_mb_def pmac_mb;
 
 /*
  * Here are the chip specific feature functions
  */
 
-static inline int __pmac
+static inline int
 simple_feature_tweak(struct device_node* node, int type, int reg, u32 mask, int value)
 {
 	struct macio_chip*	macio;
@@ -170,7 +170,7 @@ simple_feature_tweak(struct device_node*
 
 #ifndef CONFIG_POWER4
 
-static long __pmac
+static long
 ohare_htw_scc_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -263,21 +263,21 @@ ohare_htw_scc_enable(struct device_node*
 	return 0;
 }
 
-static long __pmac
+static long
 ohare_floppy_enable(struct device_node* node, long param, long value)
 {
 	return simple_feature_tweak(node, macio_ohare,
 		OHARE_FCR, OH_FLOPPY_ENABLE, value);
 }
 
-static long __pmac
+static long
 ohare_mesh_enable(struct device_node* node, long param, long value)
 {
 	return simple_feature_tweak(node, macio_ohare,
 		OHARE_FCR, OH_MESH_ENABLE, value);
 }
 
-static long __pmac
+static long
 ohare_ide_enable(struct device_node* node, long param, long value)
 {
 	switch(param) {
@@ -298,7 +298,7 @@ ohare_ide_enable(struct device_node* nod
 	}
 }
 
-static long __pmac
+static long
 ohare_ide_reset(struct device_node* node, long param, long value)
 {
 	switch(param) {
@@ -313,7 +313,7 @@ ohare_ide_reset(struct device_node* node
 	}
 }
 
-static long __pmac
+static long
 ohare_sleep_state(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio = &macio_chips[0];
@@ -329,7 +329,7 @@ ohare_sleep_state(struct device_node* no
 	return 0;
 }
 
-static long __pmac
+static long
 heathrow_modem_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -373,7 +373,7 @@ heathrow_modem_enable(struct device_node
 	return 0;
 }
 
-static long __pmac
+static long
 heathrow_floppy_enable(struct device_node* node, long param, long value)
 {
 	return simple_feature_tweak(node, macio_unknown,
@@ -382,7 +382,7 @@ heathrow_floppy_enable(struct device_nod
 		value);
 }
 
-static long __pmac
+static long
 heathrow_mesh_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -411,7 +411,7 @@ heathrow_mesh_enable(struct device_node*
 	return 0;
 }
 
-static long __pmac
+static long
 heathrow_ide_enable(struct device_node* node, long param, long value)
 {
 	switch(param) {
@@ -426,7 +426,7 @@ heathrow_ide_enable(struct device_node* 
 	}
 }
 
-static long __pmac
+static long
 heathrow_ide_reset(struct device_node* node, long param, long value)
 {
 	switch(param) {
@@ -441,7 +441,7 @@ heathrow_ide_reset(struct device_node* n
 	}
 }
 
-static long __pmac
+static long
 heathrow_bmac_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -470,7 +470,7 @@ heathrow_bmac_enable(struct device_node*
 	return 0;
 }
 
-static long __pmac
+static long
 heathrow_sound_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -501,16 +501,16 @@ heathrow_sound_enable(struct device_node
 	return 0;
 }
 
-static u32 save_fcr[6] __pmacdata;
-static u32 save_mbcr __pmacdata;
-static u32 save_gpio_levels[2] __pmacdata;
-static u8 save_gpio_extint[KEYLARGO_GPIO_EXTINT_CNT] __pmacdata;
-static u8 save_gpio_normal[KEYLARGO_GPIO_CNT] __pmacdata;
-static u32 save_unin_clock_ctl __pmacdata;
-static struct dbdma_regs save_dbdma[13] __pmacdata;
-static struct dbdma_regs save_alt_dbdma[13] __pmacdata;
+static u32 save_fcr[6];
+static u32 save_mbcr;
+static u32 save_gpio_levels[2];
+static u8 save_gpio_extint[KEYLARGO_GPIO_EXTINT_CNT];
+static u8 save_gpio_normal[KEYLARGO_GPIO_CNT];
+static u32 save_unin_clock_ctl;
+static struct dbdma_regs save_dbdma[13];
+static struct dbdma_regs save_alt_dbdma[13];
 
-static void __pmac
+static void
 dbdma_save(struct macio_chip* macio, struct dbdma_regs* save)
 {
 	int i;
@@ -527,7 +527,7 @@ dbdma_save(struct macio_chip* macio, str
 	}
 }
 
-static void __pmac
+static void
 dbdma_restore(struct macio_chip* macio, struct dbdma_regs* save)
 {
 	int i;
@@ -547,7 +547,7 @@ dbdma_restore(struct macio_chip* macio, 
 	}
 }
 
-static void __pmac
+static void
 heathrow_sleep(struct macio_chip* macio, int secondary)
 {
 	if (secondary) {
@@ -580,7 +580,7 @@ heathrow_sleep(struct macio_chip* macio,
 	(void)MACIO_IN32(HEATHROW_FCR);
 }
 
-static void __pmac
+static void
 heathrow_wakeup(struct macio_chip* macio, int secondary)
 {
 	if (secondary) {
@@ -605,7 +605,7 @@ heathrow_wakeup(struct macio_chip* macio
 	}
 }
 
-static long __pmac
+static long
 heathrow_sleep_state(struct device_node* node, long param, long value)
 {
 	if ((pmac_mb.board_flags & PMAC_MB_CAN_SLEEP) == 0)
@@ -622,7 +622,7 @@ heathrow_sleep_state(struct device_node*
 	return 0;
 }
 
-static long __pmac
+static long
 core99_scc_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -723,7 +723,7 @@ core99_scc_enable(struct device_node* no
 	return 0;
 }
 
-static long __pmac
+static long
 core99_modem_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -775,7 +775,7 @@ core99_modem_enable(struct device_node* 
 	return 0;
 }
 
-static long __pmac
+static long
 pangea_modem_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -830,7 +830,7 @@ pangea_modem_enable(struct device_node* 
 	return 0;
 }
 
-static long __pmac
+static long
 core99_ata100_enable(struct device_node* node, long value)
 {
 	unsigned long flags;
@@ -860,7 +860,7 @@ core99_ata100_enable(struct device_node*
     	return 0;
 }
 
-static long __pmac
+static long
 core99_ide_enable(struct device_node* node, long param, long value)
 {
 	/* Bus ID 0 to 2 are KeyLargo based IDE, busID 3 is U2
@@ -883,7 +883,7 @@ core99_ide_enable(struct device_node* no
 	}
 }
 
-static long __pmac
+static long
 core99_ide_reset(struct device_node* node, long param, long value)
 {
 	switch(param) {
@@ -901,7 +901,7 @@ core99_ide_reset(struct device_node* nod
 	}
 }
 
-static long __pmac
+static long
 core99_gmac_enable(struct device_node* node, long param, long value)
 {
 	unsigned long flags;
@@ -918,7 +918,7 @@ core99_gmac_enable(struct device_node* n
 	return 0;
 }
 
-static long __pmac
+static long
 core99_gmac_phy_reset(struct device_node* node, long param, long value)
 {
 	unsigned long flags;
@@ -943,7 +943,7 @@ core99_gmac_phy_reset(struct device_node
 	return 0;
 }
 
-static long __pmac
+static long
 core99_sound_chip_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -973,7 +973,7 @@ core99_sound_chip_enable(struct device_n
 	return 0;
 }
 
-static long __pmac
+static long
 core99_airport_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip*	macio;
@@ -1060,7 +1060,7 @@ core99_airport_enable(struct device_node
 }
 
 #ifdef CONFIG_SMP
-static long __pmac
+static long
 core99_reset_cpu(struct device_node* node, long param, long value)
 {
 	unsigned int reset_io = 0;
@@ -1104,7 +1104,7 @@ core99_reset_cpu(struct device_node* nod
 }
 #endif /* CONFIG_SMP */
 
-static long __pmac
+static long
 core99_usb_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio;
@@ -1257,7 +1257,7 @@ core99_usb_enable(struct device_node* no
 	return 0;
 }
 
-static long __pmac
+static long
 core99_firewire_enable(struct device_node* node, long param, long value)
 {
 	unsigned long flags;
@@ -1284,7 +1284,7 @@ core99_firewire_enable(struct device_nod
 	return 0;
 }
 
-static long __pmac
+static long
 core99_firewire_cable_power(struct device_node* node, long param, long value)
 {
 	unsigned long flags;
@@ -1315,7 +1315,7 @@ core99_firewire_cable_power(struct devic
 	return 0;
 }
 
-static long __pmac
+static long
 intrepid_aack_delay_enable(struct device_node* node, long param, long value)
 {
 	unsigned long flags;
@@ -1336,7 +1336,7 @@ intrepid_aack_delay_enable(struct device
 
 #endif /* CONFIG_POWER4 */
 
-static long __pmac
+static long
 core99_read_gpio(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio = &macio_chips[0];
@@ -1345,7 +1345,7 @@ core99_read_gpio(struct device_node* nod
 }
 
 
-static long __pmac
+static long
 core99_write_gpio(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio = &macio_chips[0];
@@ -1356,7 +1356,7 @@ core99_write_gpio(struct device_node* no
 
 #ifdef CONFIG_POWER4
 
-static long __pmac
+static long
 g5_gmac_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio = &macio_chips[0];
@@ -1380,7 +1380,7 @@ g5_gmac_enable(struct device_node* node,
 	return 0;
 }
 
-static long __pmac
+static long
 g5_fw_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio = &macio_chips[0];
@@ -1403,7 +1403,7 @@ g5_fw_enable(struct device_node* node, l
 	return 0;
 }
 
-static long __pmac
+static long
 g5_mpic_enable(struct device_node* node, long param, long value)
 {
 	unsigned long flags;
@@ -1419,7 +1419,7 @@ g5_mpic_enable(struct device_node* node,
 }
 
 #ifdef CONFIG_SMP
-static long __pmac
+static long
 g5_reset_cpu(struct device_node* node, long param, long value)
 {
 	unsigned int reset_io = 0;
@@ -1465,7 +1465,7 @@ g5_reset_cpu(struct device_node* node, l
  * This takes the second CPU off the bus on dual CPU machines
  * running UP
  */
-void __pmac g5_phy_disable_cpu1(void)
+void g5_phy_disable_cpu1(void)
 {
 	UN_OUT(U3_API_PHY_CONFIG_1, 0);
 }
@@ -1474,7 +1474,7 @@ void __pmac g5_phy_disable_cpu1(void)
 
 #ifndef CONFIG_POWER4
 
-static void __pmac
+static void
 keylargo_shutdown(struct macio_chip* macio, int sleep_mode)
 {
 	u32 temp;
@@ -1528,7 +1528,7 @@ keylargo_shutdown(struct macio_chip* mac
 	(void)MACIO_IN32(KEYLARGO_FCR0); mdelay(1);
 }
 
-static void __pmac
+static void
 pangea_shutdown(struct macio_chip* macio, int sleep_mode)
 {
 	u32 temp;
@@ -1562,7 +1562,7 @@ pangea_shutdown(struct macio_chip* macio
 	(void)MACIO_IN32(KEYLARGO_FCR0); mdelay(1);
 }
 
-static void __pmac
+static void
 intrepid_shutdown(struct macio_chip* macio, int sleep_mode)
 {
 	u32 temp;
@@ -1591,7 +1591,7 @@ intrepid_shutdown(struct macio_chip* mac
 }
 
 
-void __pmac pmac_tweak_clock_spreading(int enable)
+void pmac_tweak_clock_spreading(int enable)
 {
 	struct macio_chip* macio = &macio_chips[0];
 
@@ -1698,7 +1698,7 @@ void __pmac pmac_tweak_clock_spreading(i
 }
 
 
-static int __pmac
+static int
 core99_sleep(void)
 {
 	struct macio_chip* macio;
@@ -1791,7 +1791,7 @@ core99_sleep(void)
 	return 0;
 }
 
-static int __pmac
+static int
 core99_wake_up(void)
 {
 	struct macio_chip* macio;
@@ -1854,7 +1854,7 @@ core99_wake_up(void)
 	return 0;
 }
 
-static long __pmac
+static long
 core99_sleep_state(struct device_node* node, long param, long value)
 {
 	/* Param == 1 means to enter the "fake sleep" mode that is
@@ -1884,7 +1884,7 @@ core99_sleep_state(struct device_node* n
 
 #endif /* CONFIG_POWER4 */
 
-static long __pmac
+static long
 generic_dev_can_wake(struct device_node* node, long param, long value)
 {
 	/* Todo: eventually check we are really dealing with on-board
@@ -1896,7 +1896,7 @@ generic_dev_can_wake(struct device_node*
 	return 0;
 }
 
-static long __pmac
+static long
 generic_get_mb_info(struct device_node* node, long param, long value)
 {
 	switch(param) {
@@ -1919,7 +1919,7 @@ generic_get_mb_info(struct device_node* 
 
 /* Used on any machine
  */
-static struct feature_table_entry any_features[]  __pmacdata = {
+static struct feature_table_entry any_features[] = {
 	{ PMAC_FTR_GET_MB_INFO,		generic_get_mb_info },
 	{ PMAC_FTR_DEVICE_CAN_WAKE,	generic_dev_can_wake },
 	{ 0, NULL }
@@ -1931,7 +1931,7 @@ static struct feature_table_entry any_fe
  * 2400,3400 and 3500 series powerbooks. Some older desktops seem
  * to have issues with turning on/off those asic cells
  */
-static struct feature_table_entry ohare_features[]  __pmacdata = {
+static struct feature_table_entry ohare_features[] = {
 	{ PMAC_FTR_SCC_ENABLE,		ohare_htw_scc_enable },
 	{ PMAC_FTR_SWIM3_ENABLE,	ohare_floppy_enable },
 	{ PMAC_FTR_MESH_ENABLE,		ohare_mesh_enable },
@@ -1945,7 +1945,7 @@ static struct feature_table_entry ohare_
  * Separated as some features couldn't be properly tested
  * and the serial port control bits appear to confuse it.
  */
-static struct feature_table_entry heathrow_desktop_features[]  __pmacdata = {
+static struct feature_table_entry heathrow_desktop_features[] = {
 	{ PMAC_FTR_SWIM3_ENABLE,	heathrow_floppy_enable },
 	{ PMAC_FTR_MESH_ENABLE,		heathrow_mesh_enable },
 	{ PMAC_FTR_IDE_ENABLE,		heathrow_ide_enable },
@@ -1957,7 +1957,7 @@ static struct feature_table_entry heathr
 /* Heathrow based laptop, that is the Wallstreet and mainstreet
  * powerbooks.
  */
-static struct feature_table_entry heathrow_laptop_features[]  __pmacdata = {
+static struct feature_table_entry heathrow_laptop_features[] = {
 	{ PMAC_FTR_SCC_ENABLE,		ohare_htw_scc_enable },
 	{ PMAC_FTR_MODEM_ENABLE,	heathrow_modem_enable },
 	{ PMAC_FTR_SWIM3_ENABLE,	heathrow_floppy_enable },
@@ -1973,7 +1973,7 @@ static struct feature_table_entry heathr
 /* Paddington based machines
  * The lombard (101) powerbook, first iMac models, B&W G3 and Yikes G4.
  */
-static struct feature_table_entry paddington_features[]  __pmacdata = {
+static struct feature_table_entry paddington_features[] = {
 	{ PMAC_FTR_SCC_ENABLE,		ohare_htw_scc_enable },
 	{ PMAC_FTR_MODEM_ENABLE,	heathrow_modem_enable },
 	{ PMAC_FTR_SWIM3_ENABLE,	heathrow_floppy_enable },
@@ -1991,7 +1991,7 @@ static struct feature_table_entry paddin
  * chipset. The pangea chipset is the "combo" UniNorth/KeyLargo
  * used on iBook2 & iMac "flow power".
  */
-static struct feature_table_entry core99_features[]  __pmacdata = {
+static struct feature_table_entry core99_features[] = {
 	{ PMAC_FTR_SCC_ENABLE,		core99_scc_enable },
 	{ PMAC_FTR_MODEM_ENABLE,	core99_modem_enable },
 	{ PMAC_FTR_IDE_ENABLE,		core99_ide_enable },
@@ -2014,7 +2014,7 @@ static struct feature_table_entry core99
 
 /* RackMac
  */
-static struct feature_table_entry rackmac_features[]  __pmacdata = {
+static struct feature_table_entry rackmac_features[] = {
 	{ PMAC_FTR_SCC_ENABLE,		core99_scc_enable },
 	{ PMAC_FTR_IDE_ENABLE,		core99_ide_enable },
 	{ PMAC_FTR_IDE_RESET,		core99_ide_reset },
@@ -2034,7 +2034,7 @@ static struct feature_table_entry rackma
 
 /* Pangea features
  */
-static struct feature_table_entry pangea_features[]  __pmacdata = {
+static struct feature_table_entry pangea_features[] = {
 	{ PMAC_FTR_SCC_ENABLE,		core99_scc_enable },
 	{ PMAC_FTR_MODEM_ENABLE,	pangea_modem_enable },
 	{ PMAC_FTR_IDE_ENABLE,		core99_ide_enable },
@@ -2054,7 +2054,7 @@ static struct feature_table_entry pangea
 
 /* Intrepid features
  */
-static struct feature_table_entry intrepid_features[]  __pmacdata = {
+static struct feature_table_entry intrepid_features[] = {
 	{ PMAC_FTR_SCC_ENABLE,		core99_scc_enable },
 	{ PMAC_FTR_MODEM_ENABLE,	pangea_modem_enable },
 	{ PMAC_FTR_IDE_ENABLE,		core99_ide_enable },
@@ -2077,7 +2077,7 @@ static struct feature_table_entry intrep
 
 /* G5 features
  */
-static struct feature_table_entry g5_features[]  __pmacdata = {
+static struct feature_table_entry g5_features[] = {
 	{ PMAC_FTR_GMAC_ENABLE,		g5_gmac_enable },
 	{ PMAC_FTR_1394_ENABLE,		g5_fw_enable },
 	{ PMAC_FTR_ENABLE_MPIC,		g5_mpic_enable },
@@ -2091,7 +2091,7 @@ static struct feature_table_entry g5_fea
 
 #endif /* CONFIG_POWER4 */
 
-static struct pmac_mb_def pmac_mb_defs[] __pmacdata = {
+static struct pmac_mb_def pmac_mb_defs[] = {
 #ifndef CONFIG_POWER4
 	/*
 	 * Desktops
@@ -2352,7 +2352,7 @@ static struct pmac_mb_def pmac_mb_defs[]
 /*
  * The toplevel feature_call callback
  */
-long __pmac
+long
 pmac_do_feature_call(unsigned int selector, ...)
 {
 	struct device_node* node;
@@ -2935,8 +2935,8 @@ void __init pmac_check_ht_link(void)
  * Early video resume hook
  */
 
-static void (*pmac_early_vresume_proc)(void *data) __pmacdata;
-static void *pmac_early_vresume_data __pmacdata;
+static void (*pmac_early_vresume_proc)(void *data);
+static void *pmac_early_vresume_data;
 
 void pmac_set_early_video_resume(void (*proc)(void *data), void *data)
 {
@@ -2949,7 +2949,7 @@ void pmac_set_early_video_resume(void (*
 }
 EXPORT_SYMBOL(pmac_set_early_video_resume);
 
-void __pmac pmac_call_early_video_resume(void)
+void pmac_call_early_video_resume(void)
 {
 	if (pmac_early_vresume_proc)
 		pmac_early_vresume_proc(pmac_early_vresume_data);
@@ -2959,11 +2959,11 @@ void __pmac pmac_call_early_video_resume
  * AGP related suspend/resume code
  */
 
-static struct pci_dev *pmac_agp_bridge __pmacdata;
-static int (*pmac_agp_suspend)(struct pci_dev *bridge) __pmacdata;
-static int (*pmac_agp_resume)(struct pci_dev *bridge) __pmacdata;
+static struct pci_dev *pmac_agp_bridge;
+static int (*pmac_agp_suspend)(struct pci_dev *bridge);
+static int (*pmac_agp_resume)(struct pci_dev *bridge);
 
-void __pmac pmac_register_agp_pm(struct pci_dev *bridge,
+void pmac_register_agp_pm(struct pci_dev *bridge,
 				 int (*suspend)(struct pci_dev *bridge),
 				 int (*resume)(struct pci_dev *bridge))
 {
@@ -2980,7 +2980,7 @@ void __pmac pmac_register_agp_pm(struct 
 }
 EXPORT_SYMBOL(pmac_register_agp_pm);
 
-void __pmac pmac_suspend_agp_for_card(struct pci_dev *dev)
+void pmac_suspend_agp_for_card(struct pci_dev *dev)
 {
 	if (pmac_agp_bridge == NULL || pmac_agp_suspend == NULL)
 		return;
@@ -2990,7 +2990,7 @@ void __pmac pmac_suspend_agp_for_card(st
 }
 EXPORT_SYMBOL(pmac_suspend_agp_for_card);
 
-void __pmac pmac_resume_agp_for_card(struct pci_dev *dev)
+void pmac_resume_agp_for_card(struct pci_dev *dev)
 {
 	if (pmac_agp_bridge == NULL || pmac_agp_resume == NULL)
 		return;
diff --git a/arch/ppc/platforms/pmac_nvram.c b/arch/ppc/platforms/pmac_nvram.c
--- a/arch/ppc/platforms/pmac_nvram.c
+++ b/arch/ppc/platforms/pmac_nvram.c
@@ -88,17 +88,17 @@ extern int system_running;
 static int (*core99_write_bank)(int bank, u8* datas);
 static int (*core99_erase_bank)(int bank);
 
-static char *nvram_image __pmacdata;
+static char *nvram_image;
 
 
-static unsigned char __pmac core99_nvram_read_byte(int addr)
+static unsigned char core99_nvram_read_byte(int addr)
 {
 	if (nvram_image == NULL)
 		return 0xff;
 	return nvram_image[addr];
 }
 
-static void __pmac core99_nvram_write_byte(int addr, unsigned char val)
+static void core99_nvram_write_byte(int addr, unsigned char val)
 {
 	if (nvram_image == NULL)
 		return;
@@ -106,18 +106,18 @@ static void __pmac core99_nvram_write_by
 }
 
 
-static unsigned char __openfirmware direct_nvram_read_byte(int addr)
+static unsigned char direct_nvram_read_byte(int addr)
 {
 	return in_8(&nvram_data[(addr & (NVRAM_SIZE - 1)) * nvram_mult]);
 }
 
-static void __openfirmware direct_nvram_write_byte(int addr, unsigned char val)
+static void direct_nvram_write_byte(int addr, unsigned char val)
 {
 	out_8(&nvram_data[(addr & (NVRAM_SIZE - 1)) * nvram_mult], val);
 }
 
 
-static unsigned char __pmac indirect_nvram_read_byte(int addr)
+static unsigned char indirect_nvram_read_byte(int addr)
 {
 	unsigned char val;
 	unsigned long flags;
@@ -130,7 +130,7 @@ static unsigned char __pmac indirect_nvr
 	return val;
 }
 
-static void __pmac indirect_nvram_write_byte(int addr, unsigned char val)
+static void indirect_nvram_write_byte(int addr, unsigned char val)
 {
 	unsigned long flags;
 
@@ -143,13 +143,13 @@ static void __pmac indirect_nvram_write_
 
 #ifdef CONFIG_ADB_PMU
 
-static void __pmac pmu_nvram_complete(struct adb_request *req)
+static void pmu_nvram_complete(struct adb_request *req)
 {
 	if (req->arg)
 		complete((struct completion *)req->arg);
 }
 
-static unsigned char __pmac pmu_nvram_read_byte(int addr)
+static unsigned char pmu_nvram_read_byte(int addr)
 {
 	struct adb_request req;
 	DECLARE_COMPLETION(req_complete); 
@@ -165,7 +165,7 @@ static unsigned char __pmac pmu_nvram_re
 	return req.reply[0];
 }
 
-static void __pmac pmu_nvram_write_byte(int addr, unsigned char val)
+static void pmu_nvram_write_byte(int addr, unsigned char val)
 {
 	struct adb_request req;
 	DECLARE_COMPLETION(req_complete); 
@@ -183,7 +183,7 @@ static void __pmac pmu_nvram_write_byte(
 #endif /* CONFIG_ADB_PMU */
 
 
-static u8 __pmac chrp_checksum(struct chrp_header* hdr)
+static u8 chrp_checksum(struct chrp_header* hdr)
 {
 	u8 *ptr;
 	u16 sum = hdr->signature;
@@ -194,7 +194,7 @@ static u8 __pmac chrp_checksum(struct ch
 	return sum;
 }
 
-static u32 __pmac core99_calc_adler(u8 *buffer)
+static u32 core99_calc_adler(u8 *buffer)
 {
 	int cnt;
 	u32 low, high;
@@ -216,7 +216,7 @@ static u32 __pmac core99_calc_adler(u8 *
 	return (high << 16) | low;
 }
 
-static u32 __pmac core99_check(u8* datas)
+static u32 core99_check(u8* datas)
 {
 	struct core99_header* hdr99 = (struct core99_header*)datas;
 
@@ -235,7 +235,7 @@ static u32 __pmac core99_check(u8* datas
 	return hdr99->generation;
 }
 
-static int __pmac sm_erase_bank(int bank)
+static int sm_erase_bank(int bank)
 {
 	int stat, i;
 	unsigned long timeout;
@@ -267,7 +267,7 @@ static int __pmac sm_erase_bank(int bank
 	return 0;
 }
 
-static int __pmac sm_write_bank(int bank, u8* datas)
+static int sm_write_bank(int bank, u8* datas)
 {
 	int i, stat = 0;
 	unsigned long timeout;
@@ -302,7 +302,7 @@ static int __pmac sm_write_bank(int bank
 	return 0;
 }
 
-static int __pmac amd_erase_bank(int bank)
+static int amd_erase_bank(int bank)
 {
 	int i, stat = 0;
 	unsigned long timeout;
@@ -349,7 +349,7 @@ static int __pmac amd_erase_bank(int ban
 	return 0;
 }
 
-static int __pmac amd_write_bank(int bank, u8* datas)
+static int amd_write_bank(int bank, u8* datas)
 {
 	int i, stat = 0;
 	unsigned long timeout;
@@ -430,7 +430,7 @@ static void __init lookup_partitions(voi
 	DBG("nvram: NR partition at 0x%x\n", nvram_partitions[pmac_nvram_NR]);
 }
 
-static void __pmac core99_nvram_sync(void)
+static void core99_nvram_sync(void)
 {
 	struct core99_header* hdr99;
 	unsigned long flags;
@@ -554,12 +554,12 @@ void __init pmac_nvram_init(void)
 	lookup_partitions();
 }
 
-int __pmac pmac_get_partition(int partition)
+int pmac_get_partition(int partition)
 {
 	return nvram_partitions[partition];
 }
 
-u8 __pmac pmac_xpram_read(int xpaddr)
+u8 pmac_xpram_read(int xpaddr)
 {
 	int offset = nvram_partitions[pmac_nvram_XPRAM];
 
@@ -569,7 +569,7 @@ u8 __pmac pmac_xpram_read(int xpaddr)
 	return ppc_md.nvram_read_val(xpaddr + offset);
 }
 
-void __pmac pmac_xpram_write(int xpaddr, u8 data)
+void pmac_xpram_write(int xpaddr, u8 data)
 {
 	int offset = nvram_partitions[pmac_nvram_XPRAM];
 
diff --git a/arch/ppc/platforms/pmac_pci.c b/arch/ppc/platforms/pmac_pci.c
--- a/arch/ppc/platforms/pmac_pci.c
+++ b/arch/ppc/platforms/pmac_pci.c
@@ -141,7 +141,7 @@ fixup_bus_range(struct device_node *brid
 	|(((unsigned long)(off)) & 0xFCUL) \
 	|1UL)
 
-static void volatile __iomem * __pmac
+static void volatile __iomem *
 macrisc_cfg_access(struct pci_controller* hose, u8 bus, u8 dev_fn, u8 offset)
 {
 	unsigned int caddr;
@@ -162,7 +162,7 @@ macrisc_cfg_access(struct pci_controller
 	return hose->cfg_data + offset;
 }
 
-static int __pmac
+static int
 macrisc_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		    int len, u32 *val)
 {
@@ -190,7 +190,7 @@ macrisc_read_config(struct pci_bus *bus,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int __pmac
+static int
 macrisc_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		     int len, u32 val)
 {
@@ -230,7 +230,7 @@ static struct pci_ops macrisc_pci_ops =
 /*
  * Verifiy that a specific (bus, dev_fn) exists on chaos
  */
-static int __pmac
+static int
 chaos_validate_dev(struct pci_bus *bus, int devfn, int offset)
 {
 	struct device_node *np;
@@ -252,7 +252,7 @@ chaos_validate_dev(struct pci_bus *bus, 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int __pmac
+static int
 chaos_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		  int len, u32 *val)
 {
@@ -264,7 +264,7 @@ chaos_read_config(struct pci_bus *bus, u
 	return macrisc_read_config(bus, devfn, offset, len, val);
 }
 
-static int __pmac
+static int
 chaos_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		   int len, u32 val)
 {
@@ -294,7 +294,7 @@ static struct pci_ops chaos_pci_ops =
 		+ (((unsigned long)bus) << 16) \
 		+ 0x01000000UL)
 
-static void volatile __iomem * __pmac
+static void volatile __iomem *
 u3_ht_cfg_access(struct pci_controller* hose, u8 bus, u8 devfn, u8 offset)
 {
 	if (bus == hose->first_busno) {
@@ -307,7 +307,7 @@ u3_ht_cfg_access(struct pci_controller* 
 		return hose->cfg_data + U3_HT_CFA1(bus, devfn, offset);
 }
 
-static int __pmac
+static int
 u3_ht_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		    int len, u32 *val)
 {
@@ -357,7 +357,7 @@ u3_ht_read_config(struct pci_bus *bus, u
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int __pmac
+static int
 u3_ht_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		     int len, u32 val)
 {
@@ -899,7 +899,7 @@ pmac_pcibios_fixup(void)
 	pcibios_fixup_OF_interrupts();
 }
 
-int __pmac
+int
 pmac_pci_enable_device_hook(struct pci_dev *dev, int initial)
 {
 	struct device_node* node;
@@ -1096,7 +1096,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_
  * Disable second function on K2-SATA, it's broken
  * and disable IO BARs on first one
  */
-void __pmac pmac_pci_fixup_k2_sata(struct pci_dev* dev)
+void pmac_pci_fixup_k2_sata(struct pci_dev* dev)
 {
 	int i;
 	u16 cmd;
diff --git a/arch/ppc/platforms/pmac_pic.c b/arch/ppc/platforms/pmac_pic.c
--- a/arch/ppc/platforms/pmac_pic.c
+++ b/arch/ppc/platforms/pmac_pic.c
@@ -53,7 +53,7 @@ struct pmac_irq_hw {
 };
 
 /* Default addresses */
-static volatile struct pmac_irq_hw *pmac_irq_hw[4] __pmacdata = {
+static volatile struct pmac_irq_hw *pmac_irq_hw[4] = {
         (struct pmac_irq_hw *) 0xf3000020,
         (struct pmac_irq_hw *) 0xf3000010,
         (struct pmac_irq_hw *) 0xf4000020,
@@ -64,22 +64,22 @@ static volatile struct pmac_irq_hw *pmac
 #define OHARE_LEVEL_MASK	0x1ff00000
 #define HEATHROW_LEVEL_MASK	0x1ff00000
 
-static int max_irqs __pmacdata;
-static int max_real_irqs __pmacdata;
-static u32 level_mask[4] __pmacdata;
+static int max_irqs;
+static int max_real_irqs;
+static u32 level_mask[4];
 
-static DEFINE_SPINLOCK(pmac_pic_lock __pmacdata);
+static DEFINE_SPINLOCK(pmac_pic_lock);
 
 
 #define GATWICK_IRQ_POOL_SIZE        10
-static struct interrupt_info gatwick_int_pool[GATWICK_IRQ_POOL_SIZE] __pmacdata;
+static struct interrupt_info gatwick_int_pool[GATWICK_IRQ_POOL_SIZE];
 
 /*
  * Mark an irq as "lost".  This is only used on the pmac
  * since it can lose interrupts (see pmac_set_irq_mask).
  * -- Cort
  */
-void __pmac
+void
 __set_lost(unsigned long irq_nr, int nokick)
 {
 	if (!test_and_set_bit(irq_nr, ppc_lost_interrupts)) {
@@ -89,7 +89,7 @@ __set_lost(unsigned long irq_nr, int nok
 	}
 }
 
-static void __pmac
+static void
 pmac_mask_and_ack_irq(unsigned int irq_nr)
 {
         unsigned long bit = 1UL << (irq_nr & 0x1f);
@@ -114,7 +114,7 @@ pmac_mask_and_ack_irq(unsigned int irq_n
 	spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
-static void __pmac pmac_set_irq_mask(unsigned int irq_nr, int nokicklost)
+static void pmac_set_irq_mask(unsigned int irq_nr, int nokicklost)
 {
         unsigned long bit = 1UL << (irq_nr & 0x1f);
         int i = irq_nr >> 5;
@@ -147,7 +147,7 @@ static void __pmac pmac_set_irq_mask(uns
 /* When an irq gets requested for the first client, if it's an
  * edge interrupt, we clear any previous one on the controller
  */
-static unsigned int __pmac pmac_startup_irq(unsigned int irq_nr)
+static unsigned int pmac_startup_irq(unsigned int irq_nr)
 {
         unsigned long bit = 1UL << (irq_nr & 0x1f);
         int i = irq_nr >> 5;
@@ -160,20 +160,20 @@ static unsigned int __pmac pmac_startup_
 	return 0;
 }
 
-static void __pmac pmac_mask_irq(unsigned int irq_nr)
+static void pmac_mask_irq(unsigned int irq_nr)
 {
         clear_bit(irq_nr, ppc_cached_irq_mask);
         pmac_set_irq_mask(irq_nr, 0);
         mb();
 }
 
-static void __pmac pmac_unmask_irq(unsigned int irq_nr)
+static void pmac_unmask_irq(unsigned int irq_nr)
 {
         set_bit(irq_nr, ppc_cached_irq_mask);
         pmac_set_irq_mask(irq_nr, 0);
 }
 
-static void __pmac pmac_end_irq(unsigned int irq_nr)
+static void pmac_end_irq(unsigned int irq_nr)
 {
 	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
 	    && irq_desc[irq_nr].action) {
diff --git a/arch/ppc/platforms/pmac_setup.c b/arch/ppc/platforms/pmac_setup.c
--- a/arch/ppc/platforms/pmac_setup.c
+++ b/arch/ppc/platforms/pmac_setup.c
@@ -123,7 +123,7 @@ extern struct smp_ops_t psurge_smp_ops;
 extern struct smp_ops_t core99_smp_ops;
 #endif /* CONFIG_SMP */
 
-static int __pmac
+static int
 pmac_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *np;
@@ -227,7 +227,7 @@ pmac_show_cpuinfo(struct seq_file *m)
 	return 0;
 }
 
-static int __openfirmware
+static int
 pmac_show_percpuinfo(struct seq_file *m, int i)
 {
 #ifdef CONFIG_CPU_FREQ_PMAC
@@ -486,7 +486,7 @@ static int pmac_late_init(void)
 late_initcall(pmac_late_init);
 
 /* can't be __init - can be called whenever a disk is first accessed */
-void __pmac
+void
 note_bootable_part(dev_t dev, int part, int goodness)
 {
 	static int found_boot = 0;
@@ -512,7 +512,7 @@ note_bootable_part(dev_t dev, int part, 
 	}
 }
 
-static void __pmac
+static void
 pmac_restart(char *cmd)
 {
 #ifdef CONFIG_ADB_CUDA
@@ -537,7 +537,7 @@ pmac_restart(char *cmd)
 	}
 }
 
-static void __pmac
+static void
 pmac_power_off(void)
 {
 #ifdef CONFIG_ADB_CUDA
@@ -562,7 +562,7 @@ pmac_power_off(void)
 	}
 }
 
-static void __pmac
+static void
 pmac_halt(void)
 {
    pmac_power_off();
diff --git a/arch/ppc/platforms/pmac_smp.c b/arch/ppc/platforms/pmac_smp.c
--- a/arch/ppc/platforms/pmac_smp.c
+++ b/arch/ppc/platforms/pmac_smp.c
@@ -186,7 +186,7 @@ static inline void psurge_clr_ipi(int cp
  */
 static unsigned long psurge_smp_message[NR_CPUS];
 
-void __pmac psurge_smp_message_recv(struct pt_regs *regs)
+void psurge_smp_message_recv(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 	int msg;
@@ -203,13 +203,13 @@ void __pmac psurge_smp_message_recv(stru
 			smp_message_recv(msg, regs);
 }
 
-irqreturn_t __pmac psurge_primary_intr(int irq, void *d, struct pt_regs *regs)
+irqreturn_t psurge_primary_intr(int irq, void *d, struct pt_regs *regs)
 {
 	psurge_smp_message_recv(regs);
 	return IRQ_HANDLED;
 }
 
-static void __pmac smp_psurge_message_pass(int target, int msg, unsigned long data,
+static void smp_psurge_message_pass(int target, int msg, unsigned long data,
 					   int wait)
 {
 	int i;
@@ -629,7 +629,7 @@ void smp_core99_give_timebase(void)
 
 
 /* PowerSurge-style Macs */
-struct smp_ops_t psurge_smp_ops __pmacdata = {
+struct smp_ops_t psurge_smp_ops = {
 	.message_pass	= smp_psurge_message_pass,
 	.probe		= smp_psurge_probe,
 	.kick_cpu	= smp_psurge_kick_cpu,
@@ -639,7 +639,7 @@ struct smp_ops_t psurge_smp_ops __pmacda
 };
 
 /* Core99 Macs (dual G4s) */
-struct smp_ops_t core99_smp_ops __pmacdata = {
+struct smp_ops_t core99_smp_ops = {
 	.message_pass	= smp_openpic_message_pass,
 	.probe		= smp_core99_probe,
 	.kick_cpu	= smp_core99_kick_cpu,
diff --git a/arch/ppc/platforms/pmac_time.c b/arch/ppc/platforms/pmac_time.c
--- a/arch/ppc/platforms/pmac_time.c
+++ b/arch/ppc/platforms/pmac_time.c
@@ -77,7 +77,7 @@ pmac_time_init(void)
 #endif
 }
 
-unsigned long __pmac
+unsigned long
 pmac_get_rtc_time(void)
 {
 #if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU)
@@ -118,7 +118,7 @@ pmac_get_rtc_time(void)
 	return 0;
 }
 
-int __pmac
+int
 pmac_set_rtc_time(unsigned long nowtime)
 {
 #if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU)
@@ -210,7 +210,7 @@ via_calibrate_decr(void)
 /*
  * Reset the time after a sleep.
  */
-static int __pmac
+static int
 time_sleep_notify(struct pmu_sleep_notifier *self, int when)
 {
 	static unsigned long time_diff;
@@ -235,7 +235,7 @@ time_sleep_notify(struct pmu_sleep_notif
 	return PBOOK_SLEEP_OK;
 }
 
-static struct pmu_sleep_notifier time_sleep_notifier __pmacdata = {
+static struct pmu_sleep_notifier time_sleep_notifier = {
 	time_sleep_notify, SLEEP_LEVEL_MISC,
 };
 #endif /* CONFIG_PM */
diff --git a/arch/ppc/platforms/prep_pci.c b/arch/ppc/platforms/prep_pci.c
--- a/arch/ppc/platforms/prep_pci.c
+++ b/arch/ppc/platforms/prep_pci.c
@@ -43,7 +43,7 @@ static unsigned long	*ProcInfo;
 /* Tables for known hardware */
 
 /* Motorola PowerStackII - Utah */
-static char Utah_pci_IRQ_map[23] __prepdata =
+static char Utah_pci_IRQ_map[23] =
 {
         0,   /* Slot 0  - unused */
         0,   /* Slot 1  - unused */
@@ -72,7 +72,7 @@ static char Utah_pci_IRQ_map[23] __prepd
         0,   /* Slot 22 - unused */
 };
 
-static char Utah_pci_IRQ_routes[] __prepdata =
+static char Utah_pci_IRQ_routes[] =
 {
         0,   /* Line 0 - Unused */
         9,   /* Line 1 */
@@ -84,7 +84,7 @@ static char Utah_pci_IRQ_routes[] __prep
 
 /* Motorola PowerStackII - Omaha */
 /* no integrated SCSI or ethernet */
-static char Omaha_pci_IRQ_map[23] __prepdata =
+static char Omaha_pci_IRQ_map[23] =
 {
         0,   /* Slot 0  - unused */
         0,   /* Slot 1  - unused */
@@ -111,7 +111,7 @@ static char Omaha_pci_IRQ_map[23] __prep
         0,
 };
 
-static char Omaha_pci_IRQ_routes[] __prepdata =
+static char Omaha_pci_IRQ_routes[] =
 {
         0,   /* Line 0 - Unused */
         9,   /* Line 1 */
@@ -121,7 +121,7 @@ static char Omaha_pci_IRQ_routes[] __pre
 };
 
 /* Motorola PowerStack */
-static char Blackhawk_pci_IRQ_map[19] __prepdata =
+static char Blackhawk_pci_IRQ_map[19] =
 {
   	0,	/* Slot 0  - unused */
   	0,	/* Slot 1  - unused */
@@ -144,7 +144,7 @@ static char Blackhawk_pci_IRQ_map[19] __
  	3,	/* Slot P5 */
 };
 
-static char Blackhawk_pci_IRQ_routes[] __prepdata =
+static char Blackhawk_pci_IRQ_routes[] =
 {
    	0,	/* Line 0 - Unused */
    	9,	/* Line 1 */
@@ -154,7 +154,7 @@ static char Blackhawk_pci_IRQ_routes[] _
 };
 
 /* Motorola Mesquite */
-static char Mesquite_pci_IRQ_map[23] __prepdata =
+static char Mesquite_pci_IRQ_map[23] =
 {
 	0,	/* Slot 0  - unused */
 	0,	/* Slot 1  - unused */
@@ -182,7 +182,7 @@ static char Mesquite_pci_IRQ_map[23] __p
 };
 
 /* Motorola Sitka */
-static char Sitka_pci_IRQ_map[21] __prepdata =
+static char Sitka_pci_IRQ_map[21] =
 {
 	0,      /* Slot 0  - unused */
 	0,      /* Slot 1  - unused */
@@ -208,7 +208,7 @@ static char Sitka_pci_IRQ_map[21] __prep
 };
 
 /* Motorola MTX */
-static char MTX_pci_IRQ_map[23] __prepdata =
+static char MTX_pci_IRQ_map[23] =
 {
 	0,	/* Slot 0  - unused */
 	0,	/* Slot 1  - unused */
@@ -237,7 +237,7 @@ static char MTX_pci_IRQ_map[23] __prepda
 
 /* Motorola MTX Plus */
 /* Secondary bus interrupt routing is not supported yet */
-static char MTXplus_pci_IRQ_map[23] __prepdata =
+static char MTXplus_pci_IRQ_map[23] =
 {
         0,      /* Slot 0  - unused */
         0,      /* Slot 1  - unused */
@@ -264,13 +264,13 @@ static char MTXplus_pci_IRQ_map[23] __pr
         0,      /* Slot 22 - unused */
 };
 
-static char Raven_pci_IRQ_routes[] __prepdata =
+static char Raven_pci_IRQ_routes[] =
 {
    	0,	/* This is a dummy structure */
 };
 
 /* Motorola MVME16xx */
-static char Genesis_pci_IRQ_map[16] __prepdata =
+static char Genesis_pci_IRQ_map[16] =
 {
   	0,	/* Slot 0  - unused */
   	0,	/* Slot 1  - unused */
@@ -290,7 +290,7 @@ static char Genesis_pci_IRQ_map[16] __pr
   	0,	/* Slot 15 - unused */
 };
 
-static char Genesis_pci_IRQ_routes[] __prepdata =
+static char Genesis_pci_IRQ_routes[] =
 {
    	0,	/* Line 0 - Unused */
    	10,	/* Line 1 */
@@ -299,7 +299,7 @@ static char Genesis_pci_IRQ_routes[] __p
    	15	/* Line 4 */
 };
 
-static char Genesis2_pci_IRQ_map[23] __prepdata =
+static char Genesis2_pci_IRQ_map[23] =
 {
 	0,	/* Slot 0  - unused */
 	0,	/* Slot 1  - unused */
@@ -327,7 +327,7 @@ static char Genesis2_pci_IRQ_map[23] __p
 };
 
 /* Motorola Series-E */
-static char Comet_pci_IRQ_map[23] __prepdata =
+static char Comet_pci_IRQ_map[23] =
 {
   	0,	/* Slot 0  - unused */
   	0,	/* Slot 1  - unused */
@@ -354,7 +354,7 @@ static char Comet_pci_IRQ_map[23] __prep
 	0,
 };
 
-static char Comet_pci_IRQ_routes[] __prepdata =
+static char Comet_pci_IRQ_routes[] =
 {
    	0,	/* Line 0 - Unused */
    	10,	/* Line 1 */
@@ -364,7 +364,7 @@ static char Comet_pci_IRQ_routes[] __pre
 };
 
 /* Motorola Series-EX */
-static char Comet2_pci_IRQ_map[23] __prepdata =
+static char Comet2_pci_IRQ_map[23] =
 {
 	0,	/* Slot 0  - unused */
 	0,	/* Slot 1  - unused */
@@ -391,7 +391,7 @@ static char Comet2_pci_IRQ_map[23] __pre
 	0,
 };
 
-static char Comet2_pci_IRQ_routes[] __prepdata =
+static char Comet2_pci_IRQ_routes[] =
 {
 	0,	/* Line 0 - Unused */
 	10,	/* Line 1 */
@@ -405,7 +405,7 @@ static char Comet2_pci_IRQ_routes[] __pr
  * This is actually based on the Carolina motherboard
  * -- Cort
  */
-static char ibm8xx_pci_IRQ_map[23] __prepdata = {
+static char ibm8xx_pci_IRQ_map[23] = {
         0, /* Slot 0  - unused */
         0, /* Slot 1  - unused */
         0, /* Slot 2  - unused */
@@ -431,7 +431,7 @@ static char ibm8xx_pci_IRQ_map[23] __pre
         2, /* Slot 22 - PCI slot 1 PCIINTx# (See below) */
 };
 
-static char ibm8xx_pci_IRQ_routes[] __prepdata = {
+static char ibm8xx_pci_IRQ_routes[] = {
         0,      /* Line 0 - unused */
         15,     /* Line 1 */
         15,     /* Line 2 */
@@ -443,7 +443,7 @@ static char ibm8xx_pci_IRQ_routes[] __pr
  * a 6015 ibm board
  * -- Cort
  */
-static char ibm6015_pci_IRQ_map[23] __prepdata = {
+static char ibm6015_pci_IRQ_map[23] = {
         0, /* Slot 0  - unused */
         0, /* Slot 1  - unused */
         0, /* Slot 2  - unused */
@@ -469,7 +469,7 @@ static char ibm6015_pci_IRQ_map[23] __pr
         2, /* Slot 22 -  */
 };
 
-static char ibm6015_pci_IRQ_routes[] __prepdata = {
+static char ibm6015_pci_IRQ_routes[] = {
         0,      /* Line 0 - unused */
         13,     /* Line 1 */
         15,     /* Line 2 */
@@ -479,7 +479,7 @@ static char ibm6015_pci_IRQ_routes[] __p
 
 
 /* IBM Nobis and Thinkpad 850 */
-static char Nobis_pci_IRQ_map[23] __prepdata ={
+static char Nobis_pci_IRQ_map[23] ={
         0, /* Slot 0  - unused */
         0, /* Slot 1  - unused */
         0, /* Slot 2  - unused */
@@ -498,7 +498,7 @@ static char Nobis_pci_IRQ_map[23] __prep
         0, /* Slot 15 - unused */
 };
 
-static char Nobis_pci_IRQ_routes[] __prepdata = {
+static char Nobis_pci_IRQ_routes[] = {
         0, /* Line 0 - Unused */
         13, /* Line 1 */
         13, /* Line 2 */
@@ -510,7 +510,7 @@ static char Nobis_pci_IRQ_routes[] __pre
  * IBM RS/6000 43p/140  -- paulus
  * XXX we should get all this from the residual data
  */
-static char ibm43p_pci_IRQ_map[23] __prepdata = {
+static char ibm43p_pci_IRQ_map[23] = {
         0, /* Slot 0  - unused */
         0, /* Slot 1  - unused */
         0, /* Slot 2  - unused */
@@ -536,7 +536,7 @@ static char ibm43p_pci_IRQ_map[23] __pre
         1, /* Slot 22 - PCI slot 1 PCIINTx# (See below) */
 };
 
-static char ibm43p_pci_IRQ_routes[] __prepdata = {
+static char ibm43p_pci_IRQ_routes[] = {
         0,      /* Line 0 - unused */
         15,     /* Line 1 */
         15,     /* Line 2 */
@@ -559,7 +559,7 @@ struct powerplus_irq_list
  * are routed to OpenPIC inputs 5-8.  These values are offset by
  * 16 in the table to reflect the Linux kernel interrupt value.
  */
-struct powerplus_irq_list Powerplus_pci_IRQ_list __prepdata =
+struct powerplus_irq_list Powerplus_pci_IRQ_list =
 {
 	{25, 26, 27, 28},
 	{21, 22, 23, 24}
@@ -572,7 +572,7 @@ struct powerplus_irq_list Powerplus_pci_
  * are routed to OpenPIC inputs 12-15. These values are offset by
  * 16 in the table to reflect the Linux kernel interrupt value.
  */
-struct powerplus_irq_list Mesquite_pci_IRQ_list __prepdata =
+struct powerplus_irq_list Mesquite_pci_IRQ_list =
 {
 	{24, 25, 26, 27},
 	{28, 29, 30, 31}
@@ -582,7 +582,7 @@ struct powerplus_irq_list Mesquite_pci_I
  * This table represents the standard PCI swizzle defined in the
  * PCI bus specification.
  */
-static unsigned char prep_pci_intpins[4][4] __prepdata =
+static unsigned char prep_pci_intpins[4][4] =
 {
 	{ 1, 2, 3, 4},  /* Buses 0, 4, 8, ... */
 	{ 2, 3, 4, 1},  /* Buses 1, 5, 9, ... */
@@ -622,7 +622,7 @@ static unsigned char prep_pci_intpins[4]
 #define MIN_DEVNR	11
 #define MAX_DEVNR	22
 
-static int __prep
+static int
 prep_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		 int len, u32 *val)
 {
@@ -652,7 +652,7 @@ prep_read_config(struct pci_bus *bus, un
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int __prep
+static int
 prep_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		  int len, u32 val)
 {
@@ -804,7 +804,7 @@ struct mot_info {
 	void            (*map_non0_bus)(struct pci_dev *);      /* For boards with more than bus 0 devices. */
 	struct powerplus_irq_list *pci_irq_list; /* List of PCI MPIC inputs */
 	unsigned char   secondary_bridge_devfn; /* devfn of secondary bus transparent bridge */
-} mot_info[] __prepdata = {
+} mot_info[] = {
 	{0x300, 0x00, 0x00, "MVME 2400",			Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes, Powerplus_Map_Non0, &Powerplus_pci_IRQ_list, 0xFF},
 	{0x010, 0x00, 0x00, "Genesis",				Genesis_pci_IRQ_map,	Genesis_pci_IRQ_routes, Powerplus_Map_Non0, &Powerplus_pci_IRQ_list, 0x00},
 	{0x020, 0x00, 0x00, "Powerstack (Series E)",		Comet_pci_IRQ_map,	Comet_pci_IRQ_routes, NULL, NULL, 0x00},
diff --git a/arch/ppc/platforms/prep_setup.c b/arch/ppc/platforms/prep_setup.c
--- a/arch/ppc/platforms/prep_setup.c
+++ b/arch/ppc/platforms/prep_setup.c
@@ -173,7 +173,7 @@ prep_carolina_enable_l2(void)
 }
 
 /* cpuinfo code common to all IBM PReP */
-static void __prep
+static void
 prep_ibm_cpuinfo(struct seq_file *m)
 {
 	unsigned int equip_reg = inb(PREP_IBM_EQUIPMENT);
@@ -209,14 +209,14 @@ prep_ibm_cpuinfo(struct seq_file *m)
 	}
 }
 
-static int __prep
+static int
 prep_gen_cpuinfo(struct seq_file *m)
 {
 	prep_ibm_cpuinfo(m);
 	return 0;
 }
 
-static int __prep
+static int
 prep_sandalfoot_cpuinfo(struct seq_file *m)
 {
 	unsigned int equip_reg = inb(PREP_IBM_EQUIPMENT);
@@ -243,7 +243,7 @@ prep_sandalfoot_cpuinfo(struct seq_file 
 	return 0;
 }
 
-static int __prep
+static int
 prep_thinkpad_cpuinfo(struct seq_file *m)
 {
 	unsigned int equip_reg = inb(PREP_IBM_EQUIPMENT);
@@ -314,7 +314,7 @@ prep_thinkpad_cpuinfo(struct seq_file *m
 	return 0;
 }
 
-static int __prep
+static int
 prep_carolina_cpuinfo(struct seq_file *m)
 {
 	unsigned int equip_reg = inb(PREP_IBM_EQUIPMENT);
@@ -350,7 +350,7 @@ prep_carolina_cpuinfo(struct seq_file *m
 	return 0;
 }
 
-static int __prep
+static int
 prep_tiger1_cpuinfo(struct seq_file *m)
 {
 	unsigned int l2_reg = inb(PREP_IBM_L2INFO);
@@ -393,7 +393,7 @@ prep_tiger1_cpuinfo(struct seq_file *m)
 
 
 /* Used by all Motorola PReP */
-static int __prep
+static int
 prep_mot_cpuinfo(struct seq_file *m)
 {
 	unsigned int cachew = *((unsigned char *)CACHECRBA);
@@ -454,7 +454,7 @@ no_l2:
 	return 0;
 }
 
-static void __prep
+static void
 prep_restart(char *cmd)
 {
 #define PREP_SP92	0x92	/* Special Port 92 */
@@ -473,7 +473,7 @@ prep_restart(char *cmd)
 #undef PREP_SP92
 }
 
-static void __prep
+static void
 prep_halt(void)
 {
 	local_irq_disable(); /* no interrupts */
@@ -488,7 +488,7 @@ prep_halt(void)
 /* Carrera is the power manager in the Thinkpads. Unfortunately not much is
  * known about it, so we can't power down.
  */
-static void __prep
+static void
 prep_carrera_poweroff(void)
 {
 	prep_halt();
@@ -501,7 +501,7 @@ prep_carrera_poweroff(void)
  * somewhat in the IBM Carolina Technical Specification.
  * -Hollis
  */
-static void __prep
+static void
 utah_sig87c750_setbit(unsigned int bytenum, unsigned int bitnum, int value)
 {
 	/*
@@ -539,7 +539,7 @@ utah_sig87c750_setbit(unsigned int byten
 	udelay(100);				/* important: let controller recover */
 }
 
-static void __prep
+static void
 prep_sig750_poweroff(void)
 {
 	/* tweak the power manager found in most IBM PRePs (except Thinkpads) */
@@ -554,7 +554,7 @@ prep_sig750_poweroff(void)
 	/* not reached */
 }
 
-static int __prep
+static int
 prep_show_percpuinfo(struct seq_file *m, int i)
 {
 	/* PREP's without residual data will give incorrect values here */
@@ -700,12 +700,12 @@ prep_set_bat(void)
 /*
  * IBM 3-digit status LED
  */
-static unsigned int ibm_statusled_base __prepdata;
+static unsigned int ibm_statusled_base;
 
-static void __prep
+static void
 ibm_statusled_progress(char *s, unsigned short hex);
 
-static int __prep
+static int
 ibm_statusled_panic(struct notifier_block *dummy1, unsigned long dummy2,
 		    void * dummy3)
 {
@@ -713,13 +713,13 @@ ibm_statusled_panic(struct notifier_bloc
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block ibm_statusled_block __prepdata = {
+static struct notifier_block ibm_statusled_block = {
 	ibm_statusled_panic,
 	NULL,
 	INT_MAX /* try to do it first */
 };
 
-static void __prep
+static void
 ibm_statusled_progress(char *s, unsigned short hex)
 {
 	static int notifier_installed;
@@ -945,7 +945,7 @@ prep_calibrate_decr(void)
 		todc_calibrate_decr();
 }
 
-static unsigned int __prep
+static unsigned int
 prep_irq_canonicalize(u_int irq)
 {
 	if (irq == 2)
@@ -996,7 +996,7 @@ prep_init_IRQ(void)
 /*
  * IDE stuff.
  */
-static int __prep
+static int
 prep_ide_default_irq(unsigned long base)
 {
 	switch (base) {
@@ -1010,7 +1010,7 @@ prep_ide_default_irq(unsigned long base)
 	}
 }
 
-static unsigned long __prep
+static unsigned long
 prep_ide_default_io_base(int index)
 {
 	switch (index) {
@@ -1055,7 +1055,7 @@ smp_prep_setup_cpu(int cpu_nr)
 		do_openpic_setup_cpu();
 }
 
-static struct smp_ops_t prep_smp_ops __prepdata = {
+static struct smp_ops_t prep_smp_ops = {
 	smp_openpic_message_pass,
 	smp_prep_probe,
 	smp_prep_kick_cpu,
diff --git a/arch/ppc/platforms/residual.c b/arch/ppc/platforms/residual.c
--- a/arch/ppc/platforms/residual.c
+++ b/arch/ppc/platforms/residual.c
@@ -47,7 +47,7 @@
 #include <asm/ide.h>
 
 
-unsigned char __res[sizeof(RESIDUAL)] __prepdata = {0,};
+unsigned char __res[sizeof(RESIDUAL)] = {0,};
 RESIDUAL *res = (RESIDUAL *)&__res;
 
 char * PnP_BASE_TYPES[] __initdata = {
diff --git a/arch/ppc/syslib/btext.c b/arch/ppc/syslib/btext.c
--- a/arch/ppc/syslib/btext.c
+++ b/arch/ppc/syslib/btext.c
@@ -53,8 +53,8 @@ extern char *klimit;
  * chrp only uses it during early boot.
  */
 #ifdef CONFIG_XMON
-#define BTEXT	__pmac
-#define BTDATA	__pmacdata
+#define BTEXT
+#define BTDATA
 #else
 #define BTEXT	__init
 #define BTDATA	__initdata
@@ -187,7 +187,7 @@ btext_setup_display(int width, int heigh
  *    changes.
  */
 
-void __openfirmware
+void
 map_boot_text(void)
 {
 	unsigned long base, offset, size;
diff --git a/arch/ppc/syslib/prep_nvram.c b/arch/ppc/syslib/prep_nvram.c
--- a/arch/ppc/syslib/prep_nvram.c
+++ b/arch/ppc/syslib/prep_nvram.c
@@ -22,14 +22,14 @@
 static char nvramData[MAX_PREP_NVRAM];
 static NVRAM_MAP *nvram=(NVRAM_MAP *)&nvramData[0];
 
-unsigned char __prep prep_nvram_read_val(int addr)
+unsigned char prep_nvram_read_val(int addr)
 {
 	outb(addr, PREP_NVRAM_AS0);
 	outb(addr>>8, PREP_NVRAM_AS1);
 	return inb(PREP_NVRAM_DATA);
 }
 
-void __prep prep_nvram_write_val(int           addr,
+void prep_nvram_write_val(int           addr,
 			  unsigned char val)
 {
 	outb(addr, PREP_NVRAM_AS0);
@@ -81,8 +81,7 @@ void __init init_prep_nvram(void)
 	}
 }
 
-__prep
-char __prep *prep_nvram_get_var(const char *name)
+char *prep_nvram_get_var(const char *name)
 {
 	char *cp;
 	int  namelen;
@@ -101,8 +100,7 @@ char __prep *prep_nvram_get_var(const ch
 	return NULL;
 }
 
-__prep
-char __prep *prep_nvram_first_var(void)
+char *prep_nvram_first_var(void)
 {
         if (nvram->Header.GELength == 0) {
 		return NULL;
@@ -112,8 +110,7 @@ char __prep *prep_nvram_first_var(void)
 	}
 }
 
-__prep
-char __prep *prep_nvram_next_var(char *name)
+char *prep_nvram_next_var(char *name)
 {
 	char *cp;
 
diff --git a/arch/ppc/syslib/prom.c b/arch/ppc/syslib/prom.c
--- a/arch/ppc/syslib/prom.c
+++ b/arch/ppc/syslib/prom.c
@@ -89,7 +89,7 @@ extern char cmd_line[512];	/* XXX */
 extern boot_infos_t *boot_infos;
 unsigned long dev_tree_size;
 
-void __openfirmware
+void
 phys_call_rtas(int service, int nargs, int nret, ...)
 {
 	va_list list;
@@ -862,7 +862,7 @@ find_type_devices(const char *type)
 /*
  * Returns all nodes linked together
  */
-struct device_node * __openfirmware
+struct device_node *
 find_all_nodes(void)
 {
 	struct device_node *head, **prevp, *np;
@@ -1165,7 +1165,7 @@ get_property(struct device_node *np, con
 /*
  * Add a property to a node
  */
-void __openfirmware
+void
 prom_add_property(struct device_node* np, struct property* prop)
 {
 	struct property **next = &np->properties;
@@ -1177,7 +1177,7 @@ prom_add_property(struct device_node* np
 }
 
 /* I quickly hacked that one, check against spec ! */
-static inline unsigned long __openfirmware
+static inline unsigned long
 bus_space_to_resource_flags(unsigned int bus_space)
 {
 	u8 space = (bus_space >> 24) & 0xf;
@@ -1194,7 +1194,7 @@ bus_space_to_resource_flags(unsigned int
 	}
 }
 
-static struct resource* __openfirmware
+static struct resource*
 find_parent_pci_resource(struct pci_dev* pdev, struct address_range *range)
 {
 	unsigned long mask;
@@ -1224,7 +1224,7 @@ find_parent_pci_resource(struct pci_dev*
  * or other nodes attached to the root node. Ultimately, put some
  * link to resources in the OF node.
  */
-struct resource* __openfirmware
+struct resource*
 request_OF_resource(struct device_node* node, int index, const char* name_postfix)
 {
 	struct pci_dev* pcidev;
@@ -1280,7 +1280,7 @@ fail:
 	return NULL;
 }
 
-int __openfirmware
+int
 release_OF_resource(struct device_node* node, int index)
 {
 	struct pci_dev* pcidev;
@@ -1346,7 +1346,7 @@ release_OF_resource(struct device_node* 
 }
 
 #if 0
-void __openfirmware
+void
 print_properties(struct device_node *np)
 {
 	struct property *pp;
@@ -1400,7 +1400,7 @@ print_properties(struct device_node *np)
 static DEFINE_SPINLOCK(rtas_lock);
 
 /* this can be called after setup -- Cort */
-int __openfirmware
+int
 call_rtas(const char *service, int nargs, int nret,
 	  unsigned long *outputs, ...)
 {
