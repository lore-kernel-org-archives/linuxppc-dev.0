Return-Path: <jdl@jdl.com>
From: Jon Loeliger <linuxppc@jdl.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
In-Reply-To: Your message of "Sat, 17 Sep 2005 10:31:52 CDT."
	<E1EGefQ-00072D-34@jdl.com>
References: <E1EGefQ-00072D-34@jdl.com> 
Date: Sat, 17 Sep 2005 10:36:54 -0500
Message-Id: <E1EGekI-00072t-Hs@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: Re: PATCH powerpc: 02/04 Remove sections use from ppc64 and drivers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

diff --git a/arch/ppc64/kernel/pmac_feature.c b/arch/ppc64/kernel/pmac_feature.c
--- a/arch/ppc64/kernel/pmac_feature.c
+++ b/arch/ppc64/kernel/pmac_feature.c
@@ -53,7 +53,7 @@
  * We use a single global lock to protect accesses. Each driver has
  * to take care of its own locking
  */
-static DEFINE_SPINLOCK(feature_lock  __pmacdata);
+static DEFINE_SPINLOCK(feature_lock);
 
 #define LOCK(flags)	spin_lock_irqsave(&feature_lock, flags);
 #define UNLOCK(flags)	spin_unlock_irqrestore(&feature_lock, flags);
@@ -62,9 +62,9 @@ static DEFINE_SPINLOCK(feature_lock  __p
 /*
  * Instance of some macio stuffs
  */
-struct macio_chip macio_chips[MAX_MACIO_CHIPS]  __pmacdata;
+struct macio_chip macio_chips[MAX_MACIO_CHIPS] ;
 
-struct macio_chip* __pmac macio_find(struct device_node* child, int type)
+struct macio_chip* macio_find(struct device_node* child, int type)
 {
 	while(child) {
 		int	i;
@@ -79,7 +79,7 @@ struct macio_chip* __pmac macio_find(str
 }
 EXPORT_SYMBOL_GPL(macio_find);
 
-static const char* macio_names[] __pmacdata =
+static const char* macio_names[] =
 {
 	"Unknown",
 	"Grand Central",
@@ -106,9 +106,9 @@ static const char* macio_names[] __pmacd
 #define UN_BIS(r,v)	(UN_OUT((r), UN_IN(r) | (v)))
 #define UN_BIC(r,v)	(UN_OUT((r), UN_IN(r) & ~(v)))
 
-static struct device_node* uninorth_node __pmacdata;
-static u32* uninorth_base __pmacdata;
-static u32 uninorth_rev __pmacdata;
+static struct device_node* uninorth_node;
+static u32* uninorth_base;
+static u32 uninorth_rev;
 static void *u3_ht;
 
 extern struct device_node *k2_skiplist[2];
@@ -133,14 +133,14 @@ struct pmac_mb_def
 	struct feature_table_entry* 	features;
 	unsigned long			board_flags;
 };
-static struct pmac_mb_def pmac_mb __pmacdata;
+static struct pmac_mb_def pmac_mb;
 
 /*
  * Here are the chip specific feature functions
  */
 
 
-static long __pmac g5_read_gpio(struct device_node* node, long param, long value)
+static long g5_read_gpio(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio = &macio_chips[0];
 
@@ -148,7 +148,7 @@ static long __pmac g5_read_gpio(struct d
 }
 
 
-static long __pmac g5_write_gpio(struct device_node* node, long param, long value)
+static long g5_write_gpio(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio = &macio_chips[0];
 
@@ -156,7 +156,7 @@ static long __pmac g5_write_gpio(struct 
 	return 0;
 }
 
-static long __pmac g5_gmac_enable(struct device_node* node, long param, long value)
+static long g5_gmac_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio = &macio_chips[0];
 	unsigned long flags;
@@ -181,7 +181,7 @@ static long __pmac g5_gmac_enable(struct
 	return 0;
 }
 
-static long __pmac g5_fw_enable(struct device_node* node, long param, long value)
+static long g5_fw_enable(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio = &macio_chips[0];
 	unsigned long flags;
@@ -206,7 +206,7 @@ static long __pmac g5_fw_enable(struct d
 	return 0;
 }
 
-static long __pmac g5_mpic_enable(struct device_node* node, long param, long value)
+static long g5_mpic_enable(struct device_node* node, long param, long value)
 {
 	unsigned long flags;
 
@@ -220,7 +220,7 @@ static long __pmac g5_mpic_enable(struct
 	return 0;
 }
 
-static long __pmac g5_eth_phy_reset(struct device_node* node, long param, long value)
+static long g5_eth_phy_reset(struct device_node* node, long param, long value)
 {
 	struct macio_chip* macio = &macio_chips[0];
 	struct device_node *phy;
@@ -250,7 +250,7 @@ static long __pmac g5_eth_phy_reset(stru
 	return 0;
 }
 
-static long __pmac g5_i2s_enable(struct device_node *node, long param, long value)
+static long g5_i2s_enable(struct device_node *node, long param, long value)
 {
 	/* Very crude implementation for now */
 	struct macio_chip* macio = &macio_chips[0];
@@ -275,7 +275,7 @@ static long __pmac g5_i2s_enable(struct 
 
 
 #ifdef CONFIG_SMP
-static long __pmac g5_reset_cpu(struct device_node* node, long param, long value)
+static long g5_reset_cpu(struct device_node* node, long param, long value)
 {
 	unsigned int reset_io = 0;
 	unsigned long flags;
@@ -320,12 +320,12 @@ static long __pmac g5_reset_cpu(struct d
  * This takes the second CPU off the bus on dual CPU machines
  * running UP
  */
-void __pmac g5_phy_disable_cpu1(void)
+void g5_phy_disable_cpu1(void)
 {
 	UN_OUT(U3_API_PHY_CONFIG_1, 0);
 }
 
-static long __pmac generic_get_mb_info(struct device_node* node, long param, long value)
+static long generic_get_mb_info(struct device_node* node, long param, long value)
 {
 	switch(param) {
 		case PMAC_MB_INFO_MODEL:
@@ -347,14 +347,14 @@ static long __pmac generic_get_mb_info(s
 
 /* Used on any machine
  */
-static struct feature_table_entry any_features[]  __pmacdata = {
+static struct feature_table_entry any_features[] = {
 	{ PMAC_FTR_GET_MB_INFO,		generic_get_mb_info },
 	{ 0, NULL }
 };
 
 /* G5 features
  */
-static struct feature_table_entry g5_features[]  __pmacdata = {
+static struct feature_table_entry g5_features[] = {
 	{ PMAC_FTR_GMAC_ENABLE,		g5_gmac_enable },
 	{ PMAC_FTR_1394_ENABLE,		g5_fw_enable },
 	{ PMAC_FTR_ENABLE_MPIC,		g5_mpic_enable },
@@ -368,7 +368,7 @@ static struct feature_table_entry g5_fea
 	{ 0, NULL }
 };
 
-static struct pmac_mb_def pmac_mb_defs[] __pmacdata = {
+static struct pmac_mb_def pmac_mb_defs[] = {
 	{	"PowerMac7,2",			"PowerMac G5",
 		PMAC_TYPE_POWERMAC_G5,		g5_features,
 		0,
@@ -394,7 +394,7 @@ static struct pmac_mb_def pmac_mb_defs[]
 /*
  * The toplevel feature_call callback
  */
-long __pmac pmac_do_feature_call(unsigned int selector, ...)
+long pmac_do_feature_call(unsigned int selector, ...)
 {
 	struct device_node* node;
 	long param, value;
@@ -706,8 +706,8 @@ void __init pmac_check_ht_link(void)
  * Early video resume hook
  */
 
-static void (*pmac_early_vresume_proc)(void *data) __pmacdata;
-static void *pmac_early_vresume_data __pmacdata;
+static void (*pmac_early_vresume_proc)(void *data);
+static void *pmac_early_vresume_data;
 
 void pmac_set_early_video_resume(void (*proc)(void *data), void *data)
 {
@@ -725,11 +725,11 @@ EXPORT_SYMBOL(pmac_set_early_video_resum
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
@@ -746,7 +746,7 @@ void __pmac pmac_register_agp_pm(struct 
 }
 EXPORT_SYMBOL(pmac_register_agp_pm);
 
-void __pmac pmac_suspend_agp_for_card(struct pci_dev *dev)
+void pmac_suspend_agp_for_card(struct pci_dev *dev)
 {
 	if (pmac_agp_bridge == NULL || pmac_agp_suspend == NULL)
 		return;
@@ -756,7 +756,7 @@ void __pmac pmac_suspend_agp_for_card(st
 }
 EXPORT_SYMBOL(pmac_suspend_agp_for_card);
 
-void __pmac pmac_resume_agp_for_card(struct pci_dev *dev)
+void pmac_resume_agp_for_card(struct pci_dev *dev)
 {
 	if (pmac_agp_bridge == NULL || pmac_agp_resume == NULL)
 		return;
diff --git a/arch/ppc64/kernel/pmac_nvram.c b/arch/ppc64/kernel/pmac_nvram.c
--- a/arch/ppc64/kernel/pmac_nvram.c
+++ b/arch/ppc64/kernel/pmac_nvram.c
@@ -82,10 +82,10 @@ extern int system_running;
 static int (*core99_write_bank)(int bank, u8* datas);
 static int (*core99_erase_bank)(int bank);
 
-static char *nvram_image __pmacdata;
+static char *nvram_image;
 
 
-static ssize_t __pmac core99_nvram_read(char *buf, size_t count, loff_t *index)
+static ssize_t core99_nvram_read(char *buf, size_t count, loff_t *index)
 {
 	int i;
 
@@ -103,7 +103,7 @@ static ssize_t __pmac core99_nvram_read(
 	return count;
 }
 
-static ssize_t __pmac core99_nvram_write(char *buf, size_t count, loff_t *index)
+static ssize_t core99_nvram_write(char *buf, size_t count, loff_t *index)
 {
 	int i;
 
@@ -121,14 +121,14 @@ static ssize_t __pmac core99_nvram_write
 	return count;
 }
 
-static ssize_t __pmac core99_nvram_size(void)
+static ssize_t core99_nvram_size(void)
 {
 	if (nvram_image == NULL)
 		return -ENODEV;
 	return NVRAM_SIZE;
 }
 
-static u8 __pmac chrp_checksum(struct chrp_header* hdr)
+static u8 chrp_checksum(struct chrp_header* hdr)
 {
 	u8 *ptr;
 	u16 sum = hdr->signature;
@@ -139,7 +139,7 @@ static u8 __pmac chrp_checksum(struct ch
 	return sum;
 }
 
-static u32 __pmac core99_calc_adler(u8 *buffer)
+static u32 core99_calc_adler(u8 *buffer)
 {
 	int cnt;
 	u32 low, high;
@@ -161,7 +161,7 @@ static u32 __pmac core99_calc_adler(u8 *
 	return (high << 16) | low;
 }
 
-static u32 __pmac core99_check(u8* datas)
+static u32 core99_check(u8* datas)
 {
 	struct core99_header* hdr99 = (struct core99_header*)datas;
 
@@ -180,7 +180,7 @@ static u32 __pmac core99_check(u8* datas
 	return hdr99->generation;
 }
 
-static int __pmac sm_erase_bank(int bank)
+static int sm_erase_bank(int bank)
 {
 	int stat, i;
 	unsigned long timeout;
@@ -212,7 +212,7 @@ static int __pmac sm_erase_bank(int bank
 	return 0;
 }
 
-static int __pmac sm_write_bank(int bank, u8* datas)
+static int sm_write_bank(int bank, u8* datas)
 {
 	int i, stat = 0;
 	unsigned long timeout;
@@ -247,7 +247,7 @@ static int __pmac sm_write_bank(int bank
 	return 0;
 }
 
-static int __pmac amd_erase_bank(int bank)
+static int amd_erase_bank(int bank)
 {
 	int i, stat = 0;
 	unsigned long timeout;
@@ -294,7 +294,7 @@ static int __pmac amd_erase_bank(int ban
 	return 0;
 }
 
-static int __pmac amd_write_bank(int bank, u8* datas)
+static int amd_write_bank(int bank, u8* datas)
 {
 	int i, stat = 0;
 	unsigned long timeout;
@@ -341,7 +341,7 @@ static int __pmac amd_write_bank(int ban
 }
 
 
-static int __pmac core99_nvram_sync(void)
+static int core99_nvram_sync(void)
 {
 	struct core99_header* hdr99;
 	unsigned long flags;
@@ -431,7 +431,7 @@ int __init pmac_nvram_init(void)
 	return 0;
 }
 
-int __pmac pmac_get_partition(int partition)
+int pmac_get_partition(int partition)
 {
 	struct nvram_partition *part;
 	const char *name;
@@ -459,7 +459,7 @@ int __pmac pmac_get_partition(int partit
 	return part->index;
 }
 
-u8 __pmac pmac_xpram_read(int xpaddr)
+u8 pmac_xpram_read(int xpaddr)
 {
 	int offset = pmac_get_partition(pmac_nvram_XPRAM);
 	loff_t index;
@@ -476,7 +476,7 @@ u8 __pmac pmac_xpram_read(int xpaddr)
 	return buf;
 }
 
-void __pmac pmac_xpram_write(int xpaddr, u8 data)
+void pmac_xpram_write(int xpaddr, u8 data)
 {
 	int offset = pmac_get_partition(pmac_nvram_XPRAM);
 	loff_t index;
diff --git a/arch/ppc64/kernel/pmac_pci.c b/arch/ppc64/kernel/pmac_pci.c
--- a/arch/ppc64/kernel/pmac_pci.c
+++ b/arch/ppc64/kernel/pmac_pci.c
@@ -121,7 +121,7 @@ static void __init fixup_bus_range(struc
 	|(((unsigned long)(off)) & 0xFCUL) \
 	|1UL)
 
-static unsigned long __pmac macrisc_cfg_access(struct pci_controller* hose,
+static unsigned long macrisc_cfg_access(struct pci_controller* hose,
 					       u8 bus, u8 dev_fn, u8 offset)
 {
 	unsigned int caddr;
@@ -142,7 +142,7 @@ static unsigned long __pmac macrisc_cfg_
 	return ((unsigned long)hose->cfg_data) + offset;
 }
 
-static int __pmac macrisc_read_config(struct pci_bus *bus, unsigned int devfn,
+static int macrisc_read_config(struct pci_bus *bus, unsigned int devfn,
 				      int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
@@ -173,7 +173,7 @@ static int __pmac macrisc_read_config(st
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int __pmac macrisc_write_config(struct pci_bus *bus, unsigned int devfn,
+static int macrisc_write_config(struct pci_bus *bus, unsigned int devfn,
 				       int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
@@ -265,7 +265,7 @@ static int u3_ht_skip_device(struct pci_
 		+ (((unsigned long)bus) << 16) \
 		+ 0x01000000UL)
 
-static unsigned long __pmac u3_ht_cfg_access(struct pci_controller* hose,
+static unsigned long u3_ht_cfg_access(struct pci_controller* hose,
 					     u8 bus, u8 devfn, u8 offset)
 {
 	if (bus == hose->first_busno) {
@@ -277,7 +277,7 @@ static unsigned long __pmac u3_ht_cfg_ac
 		return ((unsigned long)hose->cfg_data) + U3_HT_CFA1(bus, devfn, offset);
 }
 
-static int __pmac u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
+static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
 				    int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
@@ -327,7 +327,7 @@ static int __pmac u3_ht_read_config(stru
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int __pmac u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
+static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
 				     int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
diff --git a/arch/ppc64/kernel/pmac_setup.c b/arch/ppc64/kernel/pmac_setup.c
--- a/arch/ppc64/kernel/pmac_setup.c
+++ b/arch/ppc64/kernel/pmac_setup.c
@@ -98,7 +98,7 @@ EXPORT_SYMBOL(smu_cmdbuf_abs);
 
 extern void udbg_init_scc(struct device_node *np);
 
-static void __pmac pmac_show_cpuinfo(struct seq_file *m)
+static void pmac_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *np;
 	char *pp;
@@ -210,7 +210,7 @@ static int pmac_late_init(void)
 late_initcall(pmac_late_init);
 
 /* can't be __init - can be called whenever a disk is first accessed */
-void __pmac note_bootable_part(dev_t dev, int part, int goodness)
+void note_bootable_part(dev_t dev, int part, int goodness)
 {
 	extern dev_t boot_dev;
 	char *p;
@@ -231,7 +231,7 @@ void __pmac note_bootable_part(dev_t dev
 	}
 }
 
-static void __pmac pmac_restart(char *cmd)
+static void pmac_restart(char *cmd)
 {
 	switch(sys_ctrler) {
 #ifdef CONFIG_ADB_PMU
@@ -250,7 +250,7 @@ static void __pmac pmac_restart(char *cm
 	}
 }
 
-static void __pmac pmac_power_off(void)
+static void pmac_power_off(void)
 {
 	switch(sys_ctrler) {
 #ifdef CONFIG_ADB_PMU
@@ -268,7 +268,7 @@ static void __pmac pmac_power_off(void)
 	}
 }
 
-static void __pmac pmac_halt(void)
+static void pmac_halt(void)
 {
 	pmac_power_off();
 }
diff --git a/arch/ppc64/kernel/pmac_smp.c b/arch/ppc64/kernel/pmac_smp.c
--- a/arch/ppc64/kernel/pmac_smp.c
+++ b/arch/ppc64/kernel/pmac_smp.c
@@ -310,7 +310,7 @@ static void __init smp_core99_setup_cpu(
 	}
 }
 
-struct smp_ops_t core99_smp_ops __pmacdata = {
+struct smp_ops_t core99_smp_ops = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_core99_probe,
 	.kick_cpu	= smp_core99_kick_cpu,
diff --git a/arch/ppc64/kernel/pmac_time.c b/arch/ppc64/kernel/pmac_time.c
--- a/arch/ppc64/kernel/pmac_time.c
+++ b/arch/ppc64/kernel/pmac_time.c
@@ -51,7 +51,7 @@
 extern struct timezone sys_tz;
 extern void to_tm(int tim, struct rtc_time * tm);
 
-void __pmac pmac_get_rtc_time(struct rtc_time *tm)
+void pmac_get_rtc_time(struct rtc_time *tm)
 {
 	switch(sys_ctrler) {
 #ifdef CONFIG_ADB_PMU
@@ -92,7 +92,7 @@ void __pmac pmac_get_rtc_time(struct rtc
 	}
 }
 
-int __pmac pmac_set_rtc_time(struct rtc_time *tm)
+int pmac_set_rtc_time(struct rtc_time *tm)
 {
 	switch(sys_ctrler) {
 #ifdef CONFIG_ADB_PMU
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -81,7 +81,7 @@ typedef struct pmac_ide_hwif {
 	
 } pmac_ide_hwif_t;
 
-static pmac_ide_hwif_t pmac_ide[MAX_HWIFS] __pmacdata;
+static pmac_ide_hwif_t pmac_ide[MAX_HWIFS];
 static int pmac_ide_count;
 
 enum {
@@ -242,7 +242,7 @@ struct mdma_timings_t {
 	int	cycleTime;
 };
 
-struct mdma_timings_t mdma_timings_33[] __pmacdata =
+struct mdma_timings_t mdma_timings_33[] =
 {
     { 240, 240, 480 },
     { 180, 180, 360 },
@@ -255,7 +255,7 @@ struct mdma_timings_t mdma_timings_33[] 
     {   0,   0,   0 }
 };
 
-struct mdma_timings_t mdma_timings_33k[] __pmacdata =
+struct mdma_timings_t mdma_timings_33k[] =
 {
     { 240, 240, 480 },
     { 180, 180, 360 },
@@ -268,7 +268,7 @@ struct mdma_timings_t mdma_timings_33k[]
     {   0,   0,   0 }
 };
 
-struct mdma_timings_t mdma_timings_66[] __pmacdata =
+struct mdma_timings_t mdma_timings_66[] =
 {
     { 240, 240, 480 },
     { 180, 180, 360 },
@@ -286,7 +286,7 @@ struct {
 	int	addrSetup; /* ??? */
 	int	rdy2pause;
 	int	wrDataSetup;
-} kl66_udma_timings[] __pmacdata =
+} kl66_udma_timings[] =
 {
     {   0, 180,  120 },	/* Mode 0 */
     {   0, 150,  90 },	/*      1 */
@@ -301,7 +301,7 @@ struct kauai_timing {
 	u32	timing_reg;
 };
 
-static struct kauai_timing	kauai_pio_timings[] __pmacdata =
+static struct kauai_timing	kauai_pio_timings[] =
 {
 	{ 930	, 0x08000fff },
 	{ 600	, 0x08000a92 },
@@ -316,7 +316,7 @@ static struct kauai_timing	kauai_pio_tim
 	{ 120	, 0x04000148 }
 };
 
-static struct kauai_timing	kauai_mdma_timings[] __pmacdata =
+static struct kauai_timing	kauai_mdma_timings[] =
 {
 	{ 1260	, 0x00fff000 },
 	{ 480	, 0x00618000 },
@@ -330,7 +330,7 @@ static struct kauai_timing	kauai_mdma_ti
 	{ 0	, 0 },
 };
 
-static struct kauai_timing	kauai_udma_timings[] __pmacdata =
+static struct kauai_timing	kauai_udma_timings[] =
 {
 	{ 120	, 0x000070c0 },
 	{ 90	, 0x00005d80 },
@@ -341,7 +341,7 @@ static struct kauai_timing	kauai_udma_ti
 	{ 0	, 0 },
 };
 
-static struct kauai_timing	shasta_pio_timings[] __pmacdata =
+static struct kauai_timing	shasta_pio_timings[] =
 {
 	{ 930	, 0x08000fff },
 	{ 600	, 0x0A000c97 },
@@ -356,7 +356,7 @@ static struct kauai_timing	shasta_pio_ti
 	{ 120	, 0x0400010a }
 };
 
-static struct kauai_timing	shasta_mdma_timings[] __pmacdata =
+static struct kauai_timing	shasta_mdma_timings[] =
 {
 	{ 1260	, 0x00fff000 },
 	{ 480	, 0x00820800 },
@@ -370,7 +370,7 @@ static struct kauai_timing	shasta_mdma_t
 	{ 0	, 0 },
 };
 
-static struct kauai_timing	shasta_udma133_timings[] __pmacdata =
+static struct kauai_timing	shasta_udma133_timings[] =
 {
 	{ 120   , 0x00035901, },
 	{ 90    , 0x000348b1, },
@@ -522,7 +522,7 @@ pmu_hd_blink_init(void)
  * N.B. this can't be an initfunc, because the media-bay task can
  * call ide_[un]register at any time.
  */
-void __pmac
+void
 pmac_ide_init_hwif_ports(hw_regs_t *hw,
 			      unsigned long data_port, unsigned long ctrl_port,
 			      int *irq)
@@ -559,7 +559,7 @@ pmac_ide_init_hwif_ports(hw_regs_t *hw,
  * timing register when selecting that unit. This version is for
  * ASICs with a single timing register
  */
-static void __pmac
+static void
 pmac_ide_selectproc(ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
@@ -579,7 +579,7 @@ pmac_ide_selectproc(ide_drive_t *drive)
  * timing register when selecting that unit. This version is for
  * ASICs with a dual timing register (Kauai)
  */
-static void __pmac
+static void
 pmac_ide_kauai_selectproc(ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
@@ -600,7 +600,7 @@ pmac_ide_kauai_selectproc(ide_drive_t *d
 /*
  * Force an update of controller timing values for a given drive
  */
-static void __pmac
+static void
 pmac_ide_do_update_timings(ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
@@ -633,7 +633,7 @@ pmac_outbsync(ide_drive_t *drive, u8 val
  * to sort that out sooner or later and see if I can finally get the
  * common version to work properly in all cases
  */
-static int __pmac
+static int
 pmac_ide_do_setfeature(ide_drive_t *drive, u8 command)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -710,7 +710,7 @@ out:
 /*
  * Old tuning functions (called on hdparm -p), sets up drive PIO timings
  */
-static void __pmac
+static void
 pmac_ide_tuneproc(ide_drive_t *drive, u8 pio)
 {
 	ide_pio_data_t d;
@@ -801,7 +801,7 @@ pmac_ide_tuneproc(ide_drive_t *drive, u8
 /*
  * Calculate KeyLargo ATA/66 UDMA timings
  */
-static int __pmac
+static int
 set_timings_udma_ata4(u32 *timings, u8 speed)
 {
 	unsigned rdyToPauseTicks, wrDataSetupTicks, addrTicks;
@@ -829,7 +829,7 @@ set_timings_udma_ata4(u32 *timings, u8 s
 /*
  * Calculate Kauai ATA/100 UDMA timings
  */
-static int __pmac
+static int
 set_timings_udma_ata6(u32 *pio_timings, u32 *ultra_timings, u8 speed)
 {
 	struct ide_timing *t = ide_timing_find_mode(speed);
@@ -849,7 +849,7 @@ set_timings_udma_ata6(u32 *pio_timings, 
 /*
  * Calculate Shasta ATA/133 UDMA timings
  */
-static int __pmac
+static int
 set_timings_udma_shasta(u32 *pio_timings, u32 *ultra_timings, u8 speed)
 {
 	struct ide_timing *t = ide_timing_find_mode(speed);
@@ -869,7 +869,7 @@ set_timings_udma_shasta(u32 *pio_timings
 /*
  * Calculate MDMA timings for all cells
  */
-static int __pmac
+static int
 set_timings_mdma(ide_drive_t *drive, int intf_type, u32 *timings, u32 *timings2,
 			u8 speed, int drive_cycle_time)
 {
@@ -1014,7 +1014,7 @@ set_timings_mdma(ide_drive_t *drive, int
  * our dedicated function is more precise as it uses the drive provided
  * cycle time value. We should probably fix this one to deal with that too...
  */
-static int __pmac
+static int
 pmac_ide_tune_chipset (ide_drive_t *drive, byte speed)
 {
 	int unit = (drive->select.b.unit & 0x01);
@@ -1092,7 +1092,7 @@ pmac_ide_tune_chipset (ide_drive_t *driv
  * Blast some well known "safe" values to the timing registers at init or
  * wakeup from sleep time, before we do real calculation
  */
-static void __pmac
+static void
 sanitize_timings(pmac_ide_hwif_t *pmif)
 {
 	unsigned int value, value2 = 0;
@@ -1123,13 +1123,13 @@ sanitize_timings(pmac_ide_hwif_t *pmif)
 	pmif->timings[2] = pmif->timings[3] = value2;
 }
 
-unsigned long __pmac
+unsigned long
 pmac_ide_get_base(int index)
 {
 	return pmac_ide[index].regbase;
 }
 
-int __pmac
+int
 pmac_ide_check_base(unsigned long base)
 {
 	int ix;
@@ -1140,7 +1140,7 @@ pmac_ide_check_base(unsigned long base)
 	return -1;
 }
 
-int __pmac
+int
 pmac_ide_get_irq(unsigned long base)
 {
 	int ix;
@@ -1151,7 +1151,7 @@ pmac_ide_get_irq(unsigned long base)
 	return 0;
 }
 
-static int ide_majors[]  __pmacdata = { 3, 22, 33, 34, 56, 57 };
+static int ide_majors[] = { 3, 22, 33, 34, 56, 57 };
 
 dev_t __init
 pmac_find_ide_boot(char *bootdevice, int n)
@@ -1701,7 +1701,7 @@ pmac_ide_probe(void)
  * pmac_ide_build_dmatable builds the DBDMA command list
  * for a transfer and sets the DBDMA channel to point to it.
  */
-static int __pmac
+static int
 pmac_ide_build_dmatable(ide_drive_t *drive, struct request *rq)
 {
 	struct dbdma_cmd *table;
@@ -1785,7 +1785,7 @@ pmac_ide_build_dmatable(ide_drive_t *dri
 }
 
 /* Teardown mappings after DMA has completed.  */
-static void __pmac
+static void
 pmac_ide_destroy_dmatable (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -1802,7 +1802,7 @@ pmac_ide_destroy_dmatable (ide_drive_t *
 /*
  * Pick up best MDMA timing for the drive and apply it
  */
-static int __pmac
+static int
 pmac_ide_mdma_enable(ide_drive_t *drive, u16 mode)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -1859,7 +1859,7 @@ pmac_ide_mdma_enable(ide_drive_t *drive,
 /*
  * Pick up best UDMA timing for the drive and apply it
  */
-static int __pmac
+static int
 pmac_ide_udma_enable(ide_drive_t *drive, u16 mode)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -1915,7 +1915,7 @@ pmac_ide_udma_enable(ide_drive_t *drive,
  * Check what is the best DMA timing setting for the drive and
  * call appropriate functions to apply it.
  */
-static int __pmac
+static int
 pmac_ide_dma_check(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -1967,7 +1967,7 @@ pmac_ide_dma_check(ide_drive_t *drive)
  * Prepare a DMA transfer. We build the DMA table, adjust the timings for
  * a read on KeyLargo ATA/66 and mark us as waiting for DMA completion
  */
-static int __pmac
+static int
 pmac_ide_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -1997,7 +1997,7 @@ pmac_ide_dma_setup(ide_drive_t *drive)
 	return 0;
 }
 
-static void __pmac
+static void
 pmac_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	/* issue cmd to drive */
@@ -2008,7 +2008,7 @@ pmac_ide_dma_exec_cmd(ide_drive_t *drive
  * Kick the DMA controller into life after the DMA command has been issued
  * to the drive.
  */
-static void __pmac
+static void
 pmac_ide_dma_start(ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
@@ -2024,7 +2024,7 @@ pmac_ide_dma_start(ide_drive_t *drive)
 /*
  * After a DMA transfer, make sure the controller is stopped
  */
-static int __pmac
+static int
 pmac_ide_dma_end (ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
@@ -2052,7 +2052,7 @@ pmac_ide_dma_end (ide_drive_t *drive)
  * that's not implemented yet), on the other hand, we don't have shared interrupts
  * so it's not really a problem
  */
-static int __pmac
+static int
 pmac_ide_dma_test_irq (ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
@@ -2108,19 +2108,19 @@ pmac_ide_dma_test_irq (ide_drive_t *driv
 	return 1;
 }
 
-static int __pmac
+static int
 pmac_ide_dma_host_off (ide_drive_t *drive)
 {
 	return 0;
 }
 
-static int __pmac
+static int
 pmac_ide_dma_host_on (ide_drive_t *drive)
 {
 	return 0;
 }
 
-static int __pmac
+static int
 pmac_ide_dma_lostirq (ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -27,7 +27,7 @@ static volatile unsigned char __iomem *a
 
 #undef DEBUG
 
-static void __pmac
+static void
 anslcd_write_byte_ctrl ( unsigned char c )
 {
 #ifdef DEBUG
@@ -43,14 +43,14 @@ anslcd_write_byte_ctrl ( unsigned char c
 	}
 }
 
-static void __pmac
+static void
 anslcd_write_byte_data ( unsigned char c )
 {
 	out_8(anslcd_ptr + ANSLCD_DATA_IX, c);
 	udelay(anslcd_short_delay);
 }
 
-static ssize_t __pmac
+static ssize_t
 anslcd_write( struct file * file, const char __user * buf, 
 				size_t count, loff_t *ppos )
 {
@@ -73,7 +73,7 @@ anslcd_write( struct file * file, const 
 	return p - buf;
 }
 
-static int __pmac
+static int
 anslcd_ioctl( struct inode * inode, struct file * file,
 				unsigned int cmd, unsigned long arg )
 {
@@ -115,7 +115,7 @@ anslcd_ioctl( struct inode * inode, stru
 	}
 }
 
-static int __pmac
+static int
 anslcd_open( struct inode * inode, struct file * file )
 {
 	return 0;
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -167,19 +167,19 @@ enum {
  * Functions for polling content of media bay
  */
  
-static u8 __pmac
+static u8
 ohare_mb_content(struct media_bay_info *bay)
 {
 	return (MB_IN32(bay, OHARE_MBCR) >> 12) & 7;
 }
 
-static u8 __pmac
+static u8
 heathrow_mb_content(struct media_bay_info *bay)
 {
 	return (MB_IN32(bay, HEATHROW_MBCR) >> 12) & 7;
 }
 
-static u8 __pmac
+static u8
 keylargo_mb_content(struct media_bay_info *bay)
 {
 	int new_gpio;
@@ -205,7 +205,7 @@ keylargo_mb_content(struct media_bay_inf
  * into reset state as well
  */
 
-static void __pmac
+static void
 ohare_mb_power(struct media_bay_info* bay, int on_off)
 {
 	if (on_off) {
@@ -224,7 +224,7 @@ ohare_mb_power(struct media_bay_info* ba
 	MB_BIC(bay, OHARE_MBCR, 0x00000F00);
 }
 
-static void __pmac
+static void
 heathrow_mb_power(struct media_bay_info* bay, int on_off)
 {
 	if (on_off) {
@@ -243,7 +243,7 @@ heathrow_mb_power(struct media_bay_info*
 	MB_BIC(bay, HEATHROW_MBCR, 0x00000F00);
 }
 
-static void __pmac
+static void
 keylargo_mb_power(struct media_bay_info* bay, int on_off)
 {
 	if (on_off) {
@@ -267,7 +267,7 @@ keylargo_mb_power(struct media_bay_info*
  * enable the related busses
  */
 
-static int __pmac
+static int
 ohare_mb_setup_bus(struct media_bay_info* bay, u8 device_id)
 {
 	switch(device_id) {
@@ -287,7 +287,7 @@ ohare_mb_setup_bus(struct media_bay_info
 	return -ENODEV;
 }
 
-static int __pmac
+static int
 heathrow_mb_setup_bus(struct media_bay_info* bay, u8 device_id)
 {
 	switch(device_id) {
@@ -307,7 +307,7 @@ heathrow_mb_setup_bus(struct media_bay_i
 	return -ENODEV;
 }
 
-static int __pmac
+static int
 keylargo_mb_setup_bus(struct media_bay_info* bay, u8 device_id)
 {
 	switch(device_id) {
@@ -330,43 +330,43 @@ keylargo_mb_setup_bus(struct media_bay_i
  * Functions for tweaking resets
  */
 
-static void __pmac
+static void
 ohare_mb_un_reset(struct media_bay_info* bay)
 {
 	MB_BIS(bay, OHARE_FCR, OH_BAY_RESET_N);
 }
 
-static void __pmac keylargo_mb_init(struct media_bay_info *bay)
+static void keylargo_mb_init(struct media_bay_info *bay)
 {
 	MB_BIS(bay, KEYLARGO_MBCR, KL_MBCR_MB0_ENABLE);
 }
 
-static void __pmac heathrow_mb_un_reset(struct media_bay_info* bay)
+static void heathrow_mb_un_reset(struct media_bay_info* bay)
 {
 	MB_BIS(bay, HEATHROW_FCR, HRW_BAY_RESET_N);
 }
 
-static void __pmac keylargo_mb_un_reset(struct media_bay_info* bay)
+static void keylargo_mb_un_reset(struct media_bay_info* bay)
 {
 	MB_BIS(bay, KEYLARGO_MBCR, KL_MBCR_MB0_DEV_RESET);
 }
 
-static void __pmac ohare_mb_un_reset_ide(struct media_bay_info* bay)
+static void ohare_mb_un_reset_ide(struct media_bay_info* bay)
 {
 	MB_BIS(bay, OHARE_FCR, OH_IDE1_RESET_N);
 }
 
-static void __pmac heathrow_mb_un_reset_ide(struct media_bay_info* bay)
+static void heathrow_mb_un_reset_ide(struct media_bay_info* bay)
 {
 	MB_BIS(bay, HEATHROW_FCR, HRW_IDE1_RESET_N);
 }
 
-static void __pmac keylargo_mb_un_reset_ide(struct media_bay_info* bay)
+static void keylargo_mb_un_reset_ide(struct media_bay_info* bay)
 {
 	MB_BIS(bay, KEYLARGO_FCR1, KL1_EIDE0_RESET_N);
 }
 
-static inline void __pmac set_mb_power(struct media_bay_info* bay, int onoff)
+static inline void set_mb_power(struct media_bay_info* bay, int onoff)
 {
 	/* Power up up and assert the bay reset line */
 	if (onoff) {
@@ -382,7 +382,7 @@ static inline void __pmac set_mb_power(s
 	bay->timer = msecs_to_jiffies(MB_POWER_DELAY);
 }
 
-static void __pmac poll_media_bay(struct media_bay_info* bay)
+static void poll_media_bay(struct media_bay_info* bay)
 {
 	int id = bay->ops->content(bay);
 
@@ -415,7 +415,7 @@ static void __pmac poll_media_bay(struct
 	}
 }
 
-int __pmac check_media_bay(struct device_node *which_bay, int what)
+int check_media_bay(struct device_node *which_bay, int what)
 {
 #ifdef CONFIG_BLK_DEV_IDE
 	int	i;
@@ -432,7 +432,7 @@ int __pmac check_media_bay(struct device
 }
 EXPORT_SYMBOL(check_media_bay);
 
-int __pmac check_media_bay_by_base(unsigned long base, int what)
+int check_media_bay_by_base(unsigned long base, int what)
 {
 #ifdef CONFIG_BLK_DEV_IDE
 	int	i;
@@ -449,7 +449,7 @@ int __pmac check_media_bay_by_base(unsig
 	return -ENODEV;
 }
 
-int __pmac media_bay_set_ide_infos(struct device_node* which_bay, unsigned long base,
+int media_bay_set_ide_infos(struct device_node* which_bay, unsigned long base,
 	int irq, int index)
 {
 #ifdef CONFIG_BLK_DEV_IDE
@@ -489,7 +489,7 @@ int __pmac media_bay_set_ide_infos(struc
 	return -ENODEV;
 }
 
-static void __pmac media_bay_step(int i)
+static void media_bay_step(int i)
 {
 	struct media_bay_info* bay = &media_bays[i];
 
@@ -619,7 +619,7 @@ static void __pmac media_bay_step(int i)
  * with the IDE driver.  It needs to be a thread because
  * ide_register can't be called from interrupt context.
  */
-static int __pmac media_bay_task(void *x)
+static int media_bay_task(void *x)
 {
 	int	i;
 
@@ -704,7 +704,7 @@ static int __devinit media_bay_attach(st
 
 }
 
-static int __pmac media_bay_suspend(struct macio_dev *mdev, pm_message_t state)
+static int media_bay_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
@@ -719,7 +719,7 @@ static int __pmac media_bay_suspend(stru
 	return 0;
 }
 
-static int __pmac media_bay_resume(struct macio_dev *mdev)
+static int media_bay_resume(struct macio_dev *mdev)
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
@@ -760,7 +760,7 @@ static int __pmac media_bay_resume(struc
 
 /* Definitions of "ops" structures.
  */
-static struct mb_ops ohare_mb_ops __pmacdata = {
+static struct mb_ops ohare_mb_ops = {
 	.name		= "Ohare",
 	.content	= ohare_mb_content,
 	.power		= ohare_mb_power,
@@ -769,7 +769,7 @@ static struct mb_ops ohare_mb_ops __pmac
 	.un_reset_ide	= ohare_mb_un_reset_ide,
 };
 
-static struct mb_ops heathrow_mb_ops __pmacdata = {
+static struct mb_ops heathrow_mb_ops = {
 	.name		= "Heathrow",
 	.content	= heathrow_mb_content,
 	.power		= heathrow_mb_power,
@@ -778,7 +778,7 @@ static struct mb_ops heathrow_mb_ops __p
 	.un_reset_ide	= heathrow_mb_un_reset_ide,
 };
 
-static struct mb_ops keylargo_mb_ops __pmacdata = {
+static struct mb_ops keylargo_mb_ops = {
 	.name		= "KeyLargo",
 	.init		= keylargo_mb_init,
 	.content	= keylargo_mb_content,
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -37,7 +37,6 @@ static DEFINE_SPINLOCK(cuda_lock);
 
 #ifdef CONFIG_MAC
 #define CUDA_IRQ IRQ_MAC_ADB
-#define __openfirmware
 #define eieio()
 #else
 #define CUDA_IRQ vias->intrs[0].line
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -244,7 +244,7 @@ int pmu_wink(struct adb_request *req);
  * - the number of response bytes which the PMU will return, or
  *   -1 if it will send a length byte.
  */
-static const s8 pmu_data_len[256][2] __openfirmwaredata = {
+static const s8 pmu_data_len[256][2] = {
 /*	   0	   1	   2	   3	   4	   5	   6	   7  */
 /*00*/	{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
 /*08*/	{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
@@ -295,7 +295,7 @@ static struct backlight_controller pmu_b
 };
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
-int __openfirmware
+int
 find_via_pmu(void)
 {
 	if (via != 0)
@@ -374,7 +374,7 @@ find_via_pmu(void)
 }
 
 #ifdef CONFIG_ADB
-static int __openfirmware
+static int
 pmu_probe(void)
 {
 	return vias == NULL? -ENODEV: 0;
@@ -520,7 +520,7 @@ static int __init via_pmu_dev_init(void)
 
 device_initcall(via_pmu_dev_init);
 
-static int __openfirmware
+static int
 init_pmu(void)
 {
 	int timeout;
@@ -625,7 +625,7 @@ static void pmu_set_server_mode(int serv
 /* This new version of the code for 2400/3400/3500 powerbooks
  * is inspired from the implementation in gkrellm-pmu
  */
-static void __pmac
+static void
 done_battery_state_ohare(struct adb_request* req)
 {
 	/* format:
@@ -713,7 +713,7 @@ done_battery_state_ohare(struct adb_requ
 	clear_bit(0, &async_req_locks);
 }
 
-static void __pmac
+static void
 done_battery_state_smart(struct adb_request* req)
 {
 	/* format:
@@ -791,7 +791,7 @@ done_battery_state_smart(struct adb_requ
 	clear_bit(0, &async_req_locks);
 }
 
-static void __pmac
+static void
 query_battery_state(void)
 {
 	if (test_and_set_bit(0, &async_req_locks))
@@ -804,7 +804,7 @@ query_battery_state(void)
 			2, PMU_SMART_BATTERY_STATE, pmu_cur_battery+1);
 }
 
-static int __pmac
+static int
 proc_get_info(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
 {
@@ -819,7 +819,7 @@ proc_get_info(char *page, char **start, 
 	return p - page;
 }
 
-static int __pmac
+static int
 proc_get_irqstats(char *page, char **start, off_t off,
 		  int count, int *eof, void *data)
 {
@@ -846,7 +846,7 @@ proc_get_irqstats(char *page, char **sta
 	return p - page;
 }
 
-static int __pmac
+static int
 proc_get_batt(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
 {
@@ -870,7 +870,7 @@ proc_get_batt(char *page, char **start, 
 	return p - page;
 }
 
-static int __pmac
+static int
 proc_read_options(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
@@ -887,7 +887,7 @@ proc_read_options(char *page, char **sta
 	return p - page;
 }
 			
-static int __pmac
+static int
 proc_write_options(struct file *file, const char __user *buffer,
 			unsigned long count, void *data)
 {
@@ -934,7 +934,7 @@ proc_write_options(struct file *file, co
 
 #ifdef CONFIG_ADB
 /* Send an ADB command */
-static int __pmac
+static int
 pmu_send_request(struct adb_request *req, int sync)
 {
 	int i, ret;
@@ -1014,7 +1014,7 @@ pmu_send_request(struct adb_request *req
 }
 
 /* Enable/disable autopolling */
-static int __pmac
+static int
 pmu_adb_autopoll(int devs)
 {
 	struct adb_request req;
@@ -1037,7 +1037,7 @@ pmu_adb_autopoll(int devs)
 }
 
 /* Reset the ADB bus */
-static int __pmac
+static int
 pmu_adb_reset_bus(void)
 {
 	struct adb_request req;
@@ -1072,7 +1072,7 @@ pmu_adb_reset_bus(void)
 #endif /* CONFIG_ADB */
 
 /* Construct and send a pmu request */
-int __openfirmware
+int
 pmu_request(struct adb_request *req, void (*done)(struct adb_request *),
 	    int nbytes, ...)
 {
@@ -1098,7 +1098,7 @@ pmu_request(struct adb_request *req, voi
 	return pmu_queue_request(req);
 }
 
-int __pmac
+int
 pmu_queue_request(struct adb_request *req)
 {
 	unsigned long flags;
@@ -1190,7 +1190,7 @@ pmu_done(struct adb_request *req)
 		(*done)(req);
 }
 
-static void __pmac
+static void
 pmu_start(void)
 {
 	struct adb_request *req;
@@ -1214,7 +1214,7 @@ pmu_start(void)
 	send_byte(req->data[0]);
 }
 
-void __openfirmware
+void
 pmu_poll(void)
 {
 	if (!via)
@@ -1224,7 +1224,7 @@ pmu_poll(void)
 	via_pmu_interrupt(0, NULL, NULL);
 }
 
-void __openfirmware
+void
 pmu_poll_adb(void)
 {
 	if (!via)
@@ -1239,7 +1239,7 @@ pmu_poll_adb(void)
 		|| req_awaiting_reply));
 }
 
-void __openfirmware
+void
 pmu_wait_complete(struct adb_request *req)
 {
 	if (!via)
@@ -1253,7 +1253,7 @@ pmu_wait_complete(struct adb_request *re
  * This is done to avoid spurrious shutdowns when we know we'll have
  * interrupts switched off for a long time
  */
-void __openfirmware
+void
 pmu_suspend(void)
 {
 	unsigned long flags;
@@ -1293,7 +1293,7 @@ pmu_suspend(void)
 	} while (1);
 }
 
-void __openfirmware
+void
 pmu_resume(void)
 {
 	unsigned long flags;
@@ -1323,7 +1323,7 @@ pmu_resume(void)
 }
 
 /* Interrupt data could be the result data from an ADB cmd */
-static void __pmac
+static void
 pmu_handle_data(unsigned char *data, int len, struct pt_regs *regs)
 {
 	unsigned char ints, pirq;
@@ -1435,7 +1435,7 @@ next:
 	goto next;
 }
 
-static struct adb_request* __pmac
+static struct adb_request*
 pmu_sr_intr(struct pt_regs *regs)
 {
 	struct adb_request *req;
@@ -1541,7 +1541,7 @@ pmu_sr_intr(struct pt_regs *regs)
 	return NULL;
 }
 
-static irqreturn_t __pmac
+static irqreturn_t
 via_pmu_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
 	unsigned long flags;
@@ -1629,7 +1629,7 @@ no_free_slot:			
 	return IRQ_RETVAL(handled);
 }
 
-void __pmac
+void
 pmu_unlock(void)
 {
 	unsigned long flags;
@@ -1642,7 +1642,7 @@ pmu_unlock(void)
 }
 
 
-static irqreturn_t __pmac
+static irqreturn_t
 gpio1_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
 	unsigned long flags;
@@ -1663,12 +1663,12 @@ gpio1_interrupt(int irq, void *arg, stru
 }
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight_to_bright[] __pmacdata = {
+static int backlight_to_bright[] = {
 	0x7f, 0x46, 0x42, 0x3e, 0x3a, 0x36, 0x32, 0x2e,
 	0x2a, 0x26, 0x22, 0x1e, 0x1a, 0x16, 0x12, 0x0e
 };
  
-static int __openfirmware
+static int
 pmu_set_backlight_enable(int on, int level, void* data)
 {
 	struct adb_request req;
@@ -1688,7 +1688,7 @@ pmu_set_backlight_enable(int on, int lev
 	return 0;
 }
 
-static void __openfirmware
+static void
 pmu_bright_complete(struct adb_request *req)
 {
 	if (req == &bright_req_1)
@@ -1697,7 +1697,7 @@ pmu_bright_complete(struct adb_request *
 		clear_bit(2, &async_req_locks);
 }
 
-static int __openfirmware
+static int
 pmu_set_backlight_level(int level, void* data)
 {
 	if (vias == NULL)
@@ -1717,7 +1717,7 @@ pmu_set_backlight_level(int level, void*
 }
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
-void __pmac
+void
 pmu_enable_irled(int on)
 {
 	struct adb_request req;
@@ -1732,7 +1732,7 @@ pmu_enable_irled(int on)
 	pmu_wait_complete(&req);
 }
 
-void __pmac
+void
 pmu_restart(void)
 {
 	struct adb_request req;
@@ -1757,7 +1757,7 @@ pmu_restart(void)
 		;
 }
 
-void __pmac
+void
 pmu_shutdown(void)
 {
 	struct adb_request req;
@@ -2076,7 +2076,7 @@ pmu_unregister_sleep_notifier(struct pmu
 }
 
 /* Sleep is broadcast last-to-first */
-static int __pmac
+static int
 broadcast_sleep(int when, int fallback)
 {
 	int ret = PBOOK_SLEEP_OK;
@@ -2101,7 +2101,7 @@ broadcast_sleep(int when, int fallback)
 }
 
 /* Wake is broadcast first-to-last */
-static int __pmac
+static int
 broadcast_wake(void)
 {
 	int ret = PBOOK_SLEEP_OK;
@@ -2132,7 +2132,7 @@ static struct pci_save {
 } *pbook_pci_saves;
 static int pbook_npci_saves;
 
-static void __pmac
+static void
 pbook_alloc_pci_save(void)
 {
 	int npci;
@@ -2149,7 +2149,7 @@ pbook_alloc_pci_save(void)
 	pbook_npci_saves = npci;
 }
 
-static void __pmac
+static void
 pbook_free_pci_save(void)
 {
 	if (pbook_pci_saves == NULL)
@@ -2159,7 +2159,7 @@ pbook_free_pci_save(void)
 	pbook_npci_saves = 0;
 }
 
-static void __pmac
+static void
 pbook_pci_save(void)
 {
 	struct pci_save *ps = pbook_pci_saves;
@@ -2190,7 +2190,7 @@ pbook_pci_save(void)
  * during boot, it will be in the pci dev list. If it's disabled at this point
  * (and it will probably be), then you can't access it's config space.
  */
-static void __pmac
+static void
 pbook_pci_restore(void)
 {
 	u16 cmd;
@@ -2238,7 +2238,7 @@ pbook_pci_restore(void)
 
 #ifdef DEBUG_SLEEP
 /* N.B. This doesn't work on the 3400 */
-void  __pmac
+void 
 pmu_blink(int n)
 {
 	struct adb_request req;
@@ -2277,9 +2277,9 @@ pmu_blink(int n)
  * Put the powerbook to sleep.
  */
  
-static u32 save_via[8] __pmacdata;
+static u32 save_via[8];
 
-static void __pmac
+static void
 save_via_state(void)
 {
 	save_via[0] = in_8(&via[ANH]);
@@ -2291,7 +2291,7 @@ save_via_state(void)
 	save_via[6] = in_8(&via[T1CL]);
 	save_via[7] = in_8(&via[T1CH]);
 }
-static void __pmac
+static void
 restore_via_state(void)
 {
 	out_8(&via[ANH], save_via[0]);
@@ -2307,7 +2307,7 @@ restore_via_state(void)
 	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
 }
 
-static int __pmac
+static int
 pmac_suspend_devices(void)
 {
 	int ret;
@@ -2397,7 +2397,7 @@ pmac_suspend_devices(void)
 	return 0;
 }
 
-static int __pmac
+static int
 pmac_wakeup_devices(void)
 {
 	mdelay(100);
@@ -2436,7 +2436,7 @@ pmac_wakeup_devices(void)
 #define	GRACKLE_NAP	(1<<4)
 #define	GRACKLE_SLEEP	(1<<3)
 
-int __pmac
+int
 powerbook_sleep_grackle(void)
 {
 	unsigned long save_l2cr;
@@ -2520,7 +2520,7 @@ powerbook_sleep_grackle(void)
 	return 0;
 }
 
-static int __pmac
+static int
 powerbook_sleep_Core99(void)
 {
 	unsigned long save_l2cr;
@@ -2620,7 +2620,7 @@ powerbook_sleep_Core99(void)
 #define PB3400_MEM_CTRL		0xf8000000
 #define PB3400_MEM_CTRL_SLEEP	0x70
 
-static int __pmac
+static int
 powerbook_sleep_3400(void)
 {
 	int ret, i, x;
@@ -2720,9 +2720,9 @@ struct pmu_private {
 };
 
 static LIST_HEAD(all_pmu_pvt);
-static DEFINE_SPINLOCK(all_pvt_lock __pmacdata);
+static DEFINE_SPINLOCK(all_pvt_lock);
 
-static void __pmac
+static void
 pmu_pass_intr(unsigned char *data, int len)
 {
 	struct pmu_private *pp;
@@ -2751,7 +2751,7 @@ pmu_pass_intr(unsigned char *data, int l
 	spin_unlock_irqrestore(&all_pvt_lock, flags);
 }
 
-static int __pmac
+static int
 pmu_open(struct inode *inode, struct file *file)
 {
 	struct pmu_private *pp;
@@ -2773,7 +2773,7 @@ pmu_open(struct inode *inode, struct fil
 	return 0;
 }
 
-static ssize_t  __pmac
+static ssize_t 
 pmu_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
@@ -2825,14 +2825,14 @@ pmu_read(struct file *file, char __user 
 	return ret;
 }
 
-static ssize_t __pmac
+static ssize_t
 pmu_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
 	return 0;
 }
 
-static unsigned int __pmac
+static unsigned int
 pmu_fpoll(struct file *filp, poll_table *wait)
 {
 	struct pmu_private *pp = filp->private_data;
@@ -2849,7 +2849,7 @@ pmu_fpoll(struct file *filp, poll_table 
 	return mask;
 }
 
-static int __pmac
+static int
 pmu_release(struct inode *inode, struct file *file)
 {
 	struct pmu_private *pp = file->private_data;
@@ -2874,8 +2874,7 @@ pmu_release(struct inode *inode, struct 
 	return 0;
 }
 
-/* Note: removed __openfirmware here since it causes link errors */
-static int __pmac
+static int
 pmu_ioctl(struct inode * inode, struct file *filp,
 		     u_int cmd, u_long arg)
 {
@@ -2957,7 +2956,7 @@ pmu_ioctl(struct inode * inode, struct f
 	return error;
 }
 
-static struct file_operations pmu_device_fops __pmacdata = {
+static struct file_operations pmu_device_fops = {
 	.read		= pmu_read,
 	.write		= pmu_write,
 	.poll		= pmu_fpoll,
@@ -2966,7 +2965,7 @@ static struct file_operations pmu_device
 	.release	= pmu_release,
 };
 
-static struct miscdevice pmu_device __pmacdata = {
+static struct miscdevice pmu_device = {
 	PMU_MINOR, "pmu", &pmu_device_fops
 };
 
@@ -2982,7 +2981,7 @@ device_initcall(pmu_device_init);
 
 
 #ifdef DEBUG_SLEEP
-static inline void  __pmac
+static inline void 
 polled_handshake(volatile unsigned char __iomem *via)
 {
 	via[B] &= ~TREQ; eieio();
@@ -2993,7 +2992,7 @@ polled_handshake(volatile unsigned char 
 		;
 }
 
-static inline void  __pmac
+static inline void 
 polled_send_byte(volatile unsigned char __iomem *via, int x)
 {
 	via[ACR] |= SR_OUT | SR_EXT; eieio();
@@ -3001,7 +3000,7 @@ polled_send_byte(volatile unsigned char 
 	polled_handshake(via);
 }
 
-static inline int __pmac
+static inline int
 polled_recv_byte(volatile unsigned char __iomem *via)
 {
 	int x;
@@ -3013,7 +3012,7 @@ polled_recv_byte(volatile unsigned char 
 	return x;
 }
 
-int __pmac
+int
 pmu_polled_request(struct adb_request *req)
 {
 	unsigned long flags;
diff --git a/drivers/macintosh/via-pmu68k.c b/drivers/macintosh/via-pmu68k.c
--- a/drivers/macintosh/via-pmu68k.c
+++ b/drivers/macintosh/via-pmu68k.c
@@ -835,7 +835,7 @@ static struct pci_save {
 } *pbook_pci_saves;
 static int n_pbook_pci_saves;
 
-static inline void __openfirmware
+static inline void
 pbook_pci_save(void)
 {
 	int npci;
@@ -863,7 +863,7 @@ pbook_pci_save(void)
 	}
 }
 
-static inline void __openfirmware
+static inline void
 pbook_pci_restore(void)
 {
 	u16 cmd;
@@ -902,7 +902,7 @@ pbook_pci_restore(void)
 #define IRQ_ENABLE	((unsigned int *)0xf3000024)
 #define MEM_CTRL	((unsigned int *)0xf8000070)
 
-int __openfirmware powerbook_sleep(void)
+int powerbook_sleep(void)
 {
 	int ret, i, x;
 	static int save_backlight;
@@ -1001,25 +1001,24 @@ int __openfirmware powerbook_sleep(void)
 /*
  * Support for /dev/pmu device
  */
-static int __openfirmware pmu_open(struct inode *inode, struct file *file)
+static int pmu_open(struct inode *inode, struct file *file)
 {
 	return 0;
 }
 
-static ssize_t __openfirmware pmu_read(struct file *file, char *buf,
+static ssize_t pmu_read(struct file *file, char *buf,
 			size_t count, loff_t *ppos)
 {
 	return 0;
 }
 
-static ssize_t __openfirmware pmu_write(struct file *file, const char *buf,
+static ssize_t pmu_write(struct file *file, const char *buf,
 			 size_t count, loff_t *ppos)
 {
 	return 0;
 }
 
-/* Note: removed __openfirmware here since it causes link errors */
-static int /*__openfirmware*/ pmu_ioctl(struct inode * inode, struct file *filp,
+static int pmu_ioctl(struct inode * inode, struct file *filp,
 		     u_int cmd, u_long arg)
 {
 	int error;
