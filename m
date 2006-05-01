Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 01 May 2006 10:53:44 +1000
Subject: [RFC/PATCH 3/4] powerpc: Convert DBG to pr_debug in
	arch/powerpc/platforms
In-Reply-To: <1146444821.660434.518701003988.qpush@concordia>
Message-Id: <20060501005347.53D1167B50@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert DBG to pr_debug in arch/powerpc/platforms.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/83xx/pci.c            |   14 ++-------
 arch/powerpc/platforms/85xx/pci.c            |   14 ++-------
 arch/powerpc/platforms/cell/setup.c          |   11 ++-----
 arch/powerpc/platforms/cell/smp.c            |   10 +-----
 arch/powerpc/platforms/iseries/setup.c       |   12 ++------
 arch/powerpc/platforms/maple/pci.c           |   12 ++------
 arch/powerpc/platforms/maple/setup.c         |   14 ++-------
 arch/powerpc/platforms/maple/time.c          |    6 ----
 arch/powerpc/platforms/powermac/cpufreq_64.c |   18 ++++--------
 arch/powerpc/platforms/powermac/feature.c    |   11 ++-----
 arch/powerpc/platforms/powermac/nvram.c      |   39 +++++++++++----------------
 arch/powerpc/platforms/powermac/pci.c        |   26 ++++++------------
 arch/powerpc/platforms/powermac/pfunc_base.c |   25 ++++++-----------
 arch/powerpc/platforms/powermac/pfunc_core.c |   29 ++++++++------------
 arch/powerpc/platforms/powermac/smp.c        |    6 ----
 arch/powerpc/platforms/powermac/time.c       |   11 ++-----
 arch/powerpc/platforms/pseries/firmware.c    |   10 +-----
 arch/powerpc/platforms/pseries/iommu.c       |   33 +++++++++++++---------
 arch/powerpc/platforms/pseries/lpar.c        |   26 ++++++------------
 arch/powerpc/platforms/pseries/setup.c       |   14 ++-------
 arch/powerpc/platforms/pseries/smp.c         |   11 +------
 21 files changed, 121 insertions(+), 231 deletions(-)

Index: to-merge/arch/powerpc/platforms/83xx/pci.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/83xx/pci.c
+++ to-merge/arch/powerpc/platforms/83xx/pci.c
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
@@ -26,14 +28,6 @@
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 int mpc83xx_pci2_busno;
 
 int mpc83xx_exclude_device(u_char bus, u_char devfn)
@@ -55,7 +49,7 @@ int __init add_bridge(struct device_node
 	int primary = 1, has_address = 0;
 	phys_addr_t immr = get_immrbase();
 
-	DBG("Adding PCI host bridge %s\n", dev->full_name);
+	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
 	/* Fetch host bridge registers address */
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
@@ -95,7 +89,7 @@ int __init add_bridge(struct device_node
 	       "Firmware bus number: %d->%d\n",
 	       rsrc.start, hose->first_busno, hose->last_busno);
 
-	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 	    hose, hose->cfg_addr, hose->cfg_data);
 
 	/* Interpret the "ranges" property */
Index: to-merge/arch/powerpc/platforms/85xx/pci.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/85xx/pci.c
+++ to-merge/arch/powerpc/platforms/85xx/pci.c
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
@@ -26,14 +28,6 @@
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 int mpc85xx_pci2_busno = 0;
 
 #ifdef CONFIG_PCI
@@ -46,7 +40,7 @@ int __init add_bridge(struct device_node
 	int primary = 1, has_address = 0;
 	phys_addr_t immr = get_immrbase();
 
-	DBG("Adding PCI host bridge %s\n", dev->full_name);
+	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
 	/* Fetch host bridge registers address */
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
@@ -83,7 +77,7 @@ int __init add_bridge(struct device_node
 	       "Firmware bus number: %d->%d\n",
 		rsrc.start, hose->first_busno, hose->last_busno);
 
-	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 		hose, hose->cfg_addr, hose->cfg_data);
 
 	/* Interpret the "ranges" property */
Index: to-merge/arch/powerpc/platforms/cell/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/cell/setup.c
+++ to-merge/arch/powerpc/platforms/cell/setup.c
@@ -12,6 +12,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+
 #undef DEBUG
 
 #include <linux/config.h>
@@ -51,12 +52,6 @@
 #include "iommu.h"
 #include "pervasive.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 static void cell_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
@@ -181,7 +176,7 @@ static void __init cell_setup_arch(void)
  */
 static void __init cell_init_early(void)
 {
-	DBG(" -> cell_init_early()\n");
+	pr_debug(" -> cell_init_early()\n");
 
 	hpte_init_native();
 
@@ -191,7 +186,7 @@ static void __init cell_init_early(void)
 
 	cell_spumem_init(1);
 
-	DBG(" <- cell_init_early()\n");
+	pr_debug(" <- cell_init_early()\n");
 }
 
 
Index: to-merge/arch/powerpc/platforms/cell/smp.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/cell/smp.c
+++ to-merge/arch/powerpc/platforms/cell/smp.c
@@ -46,12 +46,6 @@
 
 #include "interrupt.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /*
  * The primary thread of each non-boot processor is recorded here before
  * smp init.
@@ -200,7 +194,7 @@ void __init smp_init_cell(void)
 {
 	int i;
 
-	DBG(" -> smp_init_cell()\n");
+	pr_debug(" -> smp_init_cell()\n");
 
 	smp_ops = &bpa_iic_smp_ops;
 
@@ -226,5 +220,5 @@ void __init smp_init_cell(void)
 		smp_ops->take_timebase = cell_take_timebase;
 	}
 
-	DBG(" <- smp_init_cell()\n");
+	pr_debug(" <- smp_init_cell()\n");
 }
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -65,12 +65,6 @@
 #include "call_sm.h"
 #include "call_hpt.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /* Function Prototypes */
 static unsigned long build_iSeries_Memory_Map(void);
 static void iseries_shared_idle(void);
@@ -298,7 +292,7 @@ static void __init iSeries_get_cmdline(v
 
 static void __init iSeries_init_early(void)
 {
-	DBG(" -> iSeries_init_early()\n");
+	pr_debug(" -> iSeries_init_early()\n");
 
 	ppc64_interrupt_controller = IC_ISERIES;
 
@@ -354,7 +348,7 @@ static void __init iSeries_init_early(vo
 		initrd_start = initrd_end = 0;
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-	DBG(" <- iSeries_init_early()\n");
+	pr_debug(" <- iSeries_init_early()\n");
 }
 
 struct mschunks_map mschunks_map = {
@@ -749,7 +743,7 @@ void dt_init(struct iseries_flat_dt *dt)
 void dt_check_blob(struct blob *b)
 {
 	if (b->next >= (unsigned long)&b->next) {
-		DBG("Ran out of space in flat device tree blob!\n");
+		pr_debug("Ran out of space in flat device tree blob!\n");
 		BUG();
 	}
 }
Index: to-merge/arch/powerpc/platforms/maple/pci.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/maple/pci.c
+++ to-merge/arch/powerpc/platforms/maple/pci.c
@@ -27,12 +27,6 @@
 
 #include "maple.h"
 
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 static struct pci_controller *u3_agp, *u3_ht;
 
 static int __init fixup_one_level_bus_range(struct device_node *node, int higher)
@@ -317,7 +311,7 @@ static int __init add_bridge(struct devi
 	int *bus_range;
 	int primary = 1;
 
-	DBG("Adding PCI host bridge %s\n", dev->full_name);
+	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
 	bus_range = (int *) get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
@@ -360,12 +354,12 @@ void __init maple_pcibios_fixup(void)
 {
 	struct pci_dev *dev = NULL;
 
-	DBG(" -> maple_pcibios_fixup\n");
+	pr_debug(" -> maple_pcibios_fixup\n");
 
 	for_each_pci_dev(dev)
 		pci_read_irq_line(dev);
 
-	DBG(" <- maple_pcibios_fixup\n");
+	pr_debug(" <- maple_pcibios_fixup\n");
 }
 
 static void __init maple_fixup_phb_resources(void)
Index: to-merge/arch/powerpc/platforms/maple/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/maple/setup.c
+++ to-merge/arch/powerpc/platforms/maple/setup.c
@@ -65,12 +65,6 @@
 
 #include "maple.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 static unsigned long maple_find_nvram_base(void)
 {
 	struct device_node *rtcs;
@@ -197,7 +191,7 @@ void __init maple_setup_arch(void)
  */
 static void __init maple_init_early(void)
 {
-	DBG(" -> maple_init_early\n");
+	pr_debug(" -> maple_init_early\n");
 
 	/* Initialize hash table, from now on, we can take hash faults
 	 * and call ioremap
@@ -209,7 +203,7 @@ static void __init maple_init_early(void
 
 	iommu_init_early_dart();
 
-	DBG(" <- maple_init_early\n");
+	pr_debug(" <- maple_init_early\n");
 }
 
 
@@ -222,7 +216,7 @@ static __init void maple_init_IRQ(void)
 	unsigned char senses[128];
 	int n;
 
-	DBG(" -> maple_init_IRQ\n");
+	pr_debug(" -> maple_init_IRQ\n");
 
 	/* XXX: Non standard, replace that with a proper openpic/mpic node
 	 * in the device-tree. Find the Open PIC if present */
@@ -247,7 +241,7 @@ static __init void maple_init_IRQ(void)
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
 
-	DBG(" <- maple_init_IRQ\n");
+	pr_debug(" <- maple_init_IRQ\n");
 }
 
 static void __init maple_progress(char *s, unsigned short hex)
Index: to-merge/arch/powerpc/platforms/maple/time.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/maple/time.c
+++ to-merge/arch/powerpc/platforms/maple/time.c
@@ -36,12 +36,6 @@
 
 #include "maple.h"
 
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 extern void GregorianDay(struct rtc_time * tm);
 
 static int maple_rtc_addr;
Index: to-merge/arch/powerpc/platforms/powermac/cpufreq_64.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/cpufreq_64.c
+++ to-merge/arch/powerpc/platforms/powermac/cpufreq_64.c
@@ -10,6 +10,8 @@
  * that is iMac G5 and latest single CPU desktop.
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -31,14 +33,6 @@
 #include <asm/smu.h>
 #include <asm/pmac_pfunc.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /* see 970FX user manual */
 
 #define SCOM_PCR 0x0aa001			/* PCR scom addr */
@@ -415,7 +409,7 @@ static int __init g5_neo2_cpufreq_init(s
 	/* Check 970FX for now */
 	valp = (u32 *)get_property(cpunode, "cpu-version", NULL);
 	if (!valp) {
-		DBG("No cpu-version property !\n");
+		pr_debug("No cpu-version property !\n");
 		goto bail_noprops;
 	}
 	pvr_hi = (*valp) >> 16;
@@ -427,7 +421,7 @@ static int __init g5_neo2_cpufreq_init(s
 	/* Look for the powertune data in the device-tree */
 	g5_pmode_data = (u32 *)get_property(cpunode, "power-mode-data",&psize);
 	if (!g5_pmode_data) {
-		DBG("No power-mode-data !\n");
+		pr_debug("No power-mode-data !\n");
 		goto bail_noprops;
 	}
 	g5_pmode_max = psize / sizeof(u32) - 1;
@@ -573,7 +567,7 @@ static int __init g5_pm72_cpufreq_init(s
 		goto bail;
 	}
 
-	DBG("cpufreq: i2c clock chip found: %s\n", hwclock->full_name);
+	pr_debug("cpufreq: i2c clock chip found: %s\n", hwclock->full_name);
 
 	/* Now get all the platform functions */
 	pfunc_cpu_getfreq =
@@ -704,7 +698,7 @@ static int __init g5_cpufreq_init(void)
 
 	cpus = of_find_node_by_path("/cpus");
 	if (cpus == NULL) {
-		DBG("No /cpus node !\n");
+		pr_debug("No /cpus node !\n");
 		return -ENODEV;
 	}
 
Index: to-merge/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/feature.c
+++ to-merge/arch/powerpc/platforms/powermac/feature.c
@@ -16,6 +16,9 @@
  *   - Split split split...
  *
  */
+
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -41,14 +44,6 @@
 #include <asm/pci-bridge.h>
 #include <asm/pmac_low_i2c.h>
 
-#undef DEBUG_FEATURE
-
-#ifdef DEBUG_FEATURE
-#define DBG(fmt...) printk(KERN_DEBUG fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 #ifdef CONFIG_6xx
 extern int powersave_lowspeed;
 #endif
Index: to-merge/arch/powerpc/platforms/powermac/nvram.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/nvram.c
+++ to-merge/arch/powerpc/platforms/powermac/nvram.c
@@ -8,6 +8,9 @@
  *
  *  Todo: - add support for the OF persistent properties
  */
+
+#define DEBUG
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -30,14 +33,6 @@
 #include <asm/machdep.h>
 #include <asm/nvram.h>
 
-#define DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 #define NVRAM_SIZE		0x2000	/* 8kB of non-volatile RAM */
 
 #define CORE99_SIGNATURE	0x5a
@@ -266,15 +261,15 @@ static u32 core99_check(u8* datas)
 	struct core99_header* hdr99 = (struct core99_header*)datas;
 
 	if (hdr99->hdr.signature != CORE99_SIGNATURE) {
-		DBG("Invalid signature\n");
+		pr_debug("Invalid signature\n");
 		return 0;
 	}
 	if (hdr99->hdr.cksum != chrp_checksum(&hdr99->hdr)) {
-		DBG("Invalid checksum\n");
+		pr_debug("Invalid checksum\n");
 		return 0;
 	}
 	if (hdr99->adler != core99_calc_adler(datas)) {
-		DBG("Invalid adler\n");
+		pr_debug("Invalid adler\n");
 		return 0;
 	}
 	return hdr99->generation;
@@ -287,7 +282,7 @@ static int sm_erase_bank(int bank)
 
 	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
 
-       	DBG("nvram: Sharp/Micron Erasing bank %d...\n", bank);
+       	pr_debug("nvram: Sharp/Micron Erasing bank %d...\n", bank);
 
 	out_8(base, SM_FLASH_CMD_ERASE_SETUP);
 	out_8(base, SM_FLASH_CMD_ERASE_CONFIRM);
@@ -319,7 +314,7 @@ static int sm_write_bank(int bank, u8* d
 
 	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
 
-       	DBG("nvram: Sharp/Micron Writing bank %d...\n", bank);
+       	pr_debug("nvram: Sharp/Micron Writing bank %d...\n", bank);
 
 	for (i=0; i<NVRAM_SIZE; i++) {
 		out_8(base+i, SM_FLASH_CMD_WRITE_SETUP);
@@ -354,7 +349,7 @@ static int amd_erase_bank(int bank)
 
 	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
 
-       	DBG("nvram: AMD Erasing bank %d...\n", bank);
+       	pr_debug("nvram: AMD Erasing bank %d...\n", bank);
 
 	/* Unlock 1 */
 	out_8(base+0x555, 0xaa);
@@ -401,7 +396,7 @@ static int amd_write_bank(int bank, u8* 
 
 	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
 
-       	DBG("nvram: AMD Writing bank %d...\n", bank);
+       	pr_debug("nvram: AMD Writing bank %d...\n", bank);
 
 	for (i=0; i<NVRAM_SIZE; i++) {
 		/* Unlock 1 */
@@ -470,9 +465,9 @@ static void __init lookup_partitions(voi
 		nvram_partitions[pmac_nvram_XPRAM] = 0x1300;
 		nvram_partitions[pmac_nvram_NR] = 0x1400;
 	}
-	DBG("nvram: OF partition at 0x%x\n", nvram_partitions[pmac_nvram_OF]);
-	DBG("nvram: XP partition at 0x%x\n", nvram_partitions[pmac_nvram_XPRAM]);
-	DBG("nvram: NR partition at 0x%x\n", nvram_partitions[pmac_nvram_NR]);
+	pr_debug("nvram: OF partition at 0x%x\n", nvram_partitions[pmac_nvram_OF]);
+	pr_debug("nvram: XP partition at 0x%x\n", nvram_partitions[pmac_nvram_XPRAM]);
+	pr_debug("nvram: NR partition at 0x%x\n", nvram_partitions[pmac_nvram_NR]);
 }
 
 static void core99_nvram_sync(void)
@@ -488,7 +483,7 @@ static void core99_nvram_sync(void)
 		NVRAM_SIZE))
 		goto bail;
 
-	DBG("Updating nvram...\n");
+	pr_debug("Updating nvram...\n");
 
 	hdr99 = (struct core99_header*)nvram_image;
 	hdr99->generation++;
@@ -529,14 +524,14 @@ static int __init core99_nvram_setup(str
 	nvram_data = ioremap(addr, NVRAM_SIZE*2);
 	nvram_naddrs = 1; /* Make sure we get the correct case */
 
-	DBG("nvram: Checking bank 0...\n");
+	pr_debug("nvram: Checking bank 0...\n");
 
 	gen_bank0 = core99_check((u8 *)nvram_data);
 	gen_bank1 = core99_check((u8 *)nvram_data + NVRAM_SIZE);
 	core99_bank = (gen_bank0 < gen_bank1) ? 1 : 0;
 
-	DBG("nvram: gen0=%d, gen1=%d\n", gen_bank0, gen_bank1);
-	DBG("nvram: Active bank is: %d\n", core99_bank);
+	pr_debug("nvram: gen0=%d, gen1=%d\n", gen_bank0, gen_bank1);
+	pr_debug("nvram: Active bank is: %d\n", core99_bank);
 
 	for (i=0; i<NVRAM_SIZE; i++)
 		nvram_image[i] = nvram_data[i + core99_bank*NVRAM_SIZE];
Index: to-merge/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/pci.c
+++ to-merge/arch/powerpc/platforms/powermac/pci.c
@@ -10,6 +10,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#undef DEBUG
+
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -29,14 +31,6 @@
 #include <asm/ppc-pci.h>
 #endif
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 static int add_bridge(struct device_node *dev);
 
 /* XXX Could be per-controller, but I don't think we risk anything by
@@ -626,7 +620,7 @@ static void __init init_p2pbridge(void)
 	    || strcmp(p2pbridge->parent->name, "pci") != 0)
 		return;
 	if (pci_device_from_OF_node(p2pbridge, &bus, &devfn) < 0) {
-		DBG("Can't find PCI infos for PCI<->PCI bridge\n");
+		pr_debug("Can't find PCI infos for PCI<->PCI bridge\n");
 		return;
 	}
 	/* Warning: At this point, we have not yet renumbered all busses.
@@ -634,7 +628,7 @@ static void __init init_p2pbridge(void)
 	 */
 	hose = pci_find_hose_for_OF_device(p2pbridge);
 	if (!hose) {
-		DBG("Can't find hose for PCI<->PCI bridge\n");
+		pr_debug("Can't find hose for PCI<->PCI bridge\n");
 		return;
 	}
 	if (early_read_config_word(hose, bus, devfn,
@@ -803,7 +797,7 @@ static void __init setup_u3_ht(struct pc
 		other = u4_pcie;
 
 	if (other == NULL) {
-		DBG("U3/4 has no AGP/PCIE, using full resource range\n");
+		pr_debug("U3/4 has no AGP/PCIE, using full resource range\n");
 		return;
 	}
 
@@ -828,14 +822,14 @@ static void __init setup_u3_ht(struct pc
 		 * direction
 		 */
 		if (hose->mem_resources[cur].start == res->start) {
-			DBG("U3/HT: shrink start of %d, %08lx -> %08lx\n",
+			pr_debug("U3/HT: shrink start of %d, %08lx -> %08lx\n",
 			    cur, hose->mem_resources[cur].start,
 			    res->end + 1);
 			hose->mem_resources[cur].start = res->end + 1;
 			continue;
 		}
 		if (hose->mem_resources[cur].end == res->end) {
-			DBG("U3/HT: shrink end of %d, %08lx -> %08lx\n",
+			pr_debug("U3/HT: shrink end of %d, %08lx -> %08lx\n",
 			    cur, hose->mem_resources[cur].end,
 			    res->start - 1);
 			hose->mem_resources[cur].end = res->start - 1;
@@ -852,7 +846,7 @@ static void __init setup_u3_ht(struct pc
 			continue;
 		}
 		cur++;
-		DBG("U3/HT: hole, %d end at %08lx, %d start at %08lx\n",
+		pr_debug("U3/HT: hole, %d end at %08lx, %d start at %08lx\n",
 		    cur-1, res->start - 1, cur, res->end + 1);
 		hose->mem_resources[cur].name = np->full_name;
 		hose->mem_resources[cur].flags = IORESOURCE_MEM;
@@ -877,7 +871,7 @@ static int __init add_bridge(struct devi
 	int *bus_range;
 	int primary = 1, has_address = 0;
 
-	DBG("Adding PCI host bridge %s\n", dev->full_name);
+	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
 	/* Fetch host bridge registers address */
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
@@ -944,7 +938,7 @@ static int __init add_bridge(struct devi
 		disp_name, rsrc.start, hose->first_busno, hose->last_busno);
 #endif /* CONFIG_PPC32 */
 
-	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 		hose, hose->cfg_addr, hose->cfg_data);
 
 	/* Interpret the "ranges" property */
Index: to-merge/arch/powerpc/platforms/powermac/pfunc_base.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/pfunc_base.c
+++ to-merge/arch/powerpc/platforms/powermac/pfunc_base.c
@@ -1,3 +1,5 @@
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -9,13 +11,6 @@
 #include <asm/pmac_feature.h>
 #include <asm/pmac_pfunc.h>
 
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...)	printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 static irqreturn_t macio_gpio_irq(int irq, void *data, struct pt_regs *regs)
 {
 	pmf_do_irq(data);
@@ -55,7 +50,7 @@ static int macio_do_gpio_write(PMF_STD_A
 	spin_lock_irqsave(&feature_lock, flags);
 	tmp = readb(addr);
 	tmp = (tmp & ~mask) | (value & mask);
-	DBG("Do write 0x%02x to GPIO %s (%p)\n",
+	pr_debug("Do write 0x%02x to GPIO %s (%p)\n",
 	    tmp, func->node->full_name, addr);
 	writeb(tmp, addr);
 	spin_unlock_irqrestore(&feature_lock, flags);
@@ -108,7 +103,7 @@ static void macio_gpio_init_one(struct m
 	if (gparent == NULL)
 		return;
 
-	DBG("Installing GPIO functions for macio %s\n",
+	pr_debug("Installing GPIO functions for macio %s\n",
 	    macio->of_node->full_name);
 
 	/*
@@ -130,7 +125,7 @@ static void macio_gpio_init_one(struct m
 		pmf_register_driver(gp, &macio_gpio_handlers, (void *)offset);
 	}
 
-	DBG("Calling initial GPIO functions for macio %s\n",
+	pr_debug("Calling initial GPIO functions for macio %s\n",
 	    macio->of_node->full_name);
 
 	/* And now we run all the init ones */
@@ -268,7 +263,7 @@ static struct pmf_handlers macio_mmio_ha
 
 static void macio_mmio_init_one(struct macio_chip *macio)
 {
-	DBG("Installing MMIO functions for macio %s\n",
+	pr_debug("Installing MMIO functions for macio %s\n",
 	    macio->of_node->full_name);
 
 	pmf_register_driver(macio->of_node, &macio_mmio_handlers, macio);
@@ -299,7 +294,7 @@ static void uninorth_install_pfunc(void)
 {
 	struct device_node *np;
 
-	DBG("Installing functions for UniN %s\n",
+	pr_debug("Installing functions for UniN %s\n",
 	    uninorth_node->full_name);
 
 	/*
@@ -318,7 +313,7 @@ static void uninorth_install_pfunc(void)
 			break;
 		}
 	if (unin_hwclock) {
-		DBG("Installing functions for UniN clock %s\n",
+		pr_debug("Installing functions for UniN clock %s\n",
 		    unin_hwclock->full_name);
 		pmf_register_driver(unin_hwclock, &unin_mmio_handlers, NULL);
 		pmf_do_functions(unin_hwclock, NULL, 0, PMF_FLAGS_ON_INIT,
@@ -339,7 +334,7 @@ int __init pmac_pfunc_base_install(void)
 	if (!machine_is(powermac))
 		return 0;
 
-	DBG("Installing base platform functions...\n");
+	pr_debug("Installing base platform functions...\n");
 
 	/*
 	 * Locate mac-io chips and install handlers
@@ -361,7 +356,7 @@ int __init pmac_pfunc_base_install(void)
 	if (uninorth_node && uninorth_base)
 		uninorth_install_pfunc();
 
-	DBG("All base functions installed\n");
+	pr_debug("All base functions installed\n");
 
 	return 0;
 }
Index: to-merge/arch/powerpc/platforms/powermac/pfunc_core.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/pfunc_core.c
+++ to-merge/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -5,6 +5,8 @@
  * FIXME: LOCKING !!!
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -21,13 +23,6 @@
 #define LOG_ERROR(fmt...)	printk(fmt)
 #define LOG_BLOB(t,b,c)
 
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...)		printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /* Command numbers */
 #define PMF_CMD_LIST			0
 #define PMF_CMD_WRITE_GPIO		1
@@ -639,7 +634,7 @@ static int pmf_add_function_prop(struct 
 	int count = 0;
 	struct pmf_function *func = NULL;
 
-	DBG("pmf: Adding functions for platform-do-%s\n", name);
+	pr_debug("pmf: Adding functions for platform-do-%s\n", name);
 
 	while (length >= 12) {
 		/* Allocate a structure */
@@ -658,7 +653,7 @@ static int pmf_add_function_prop(struct 
 		func->data = data;
 		func->length = length;
 		func->dev = dev;
-		DBG("pmf: idx %d: flags=%08x, phandle=%08x "
+		pr_debug("pmf: idx %d: flags=%08x, phandle=%08x "
 		    " %d bytes remaining, parsing...\n",
 		    count+1, func->flags, func->phandle, length);
 		if (pmf_parse_one(func, NULL, NULL, NULL)) {
@@ -672,7 +667,7 @@ static int pmf_add_function_prop(struct 
 		count++;
 	}
  bail:
-	DBG("pmf: Added %d functions\n", count);
+	pr_debug("pmf: Added %d functions\n", count);
 
 	return count;
 }
@@ -709,20 +704,20 @@ int pmf_register_driver(struct device_no
 	if (handlers == NULL)
 		return -EINVAL;
 
-	DBG("pmf: registering driver for node %s\n", np->full_name);
+	pr_debug("pmf: registering driver for node %s\n", np->full_name);
 
 	spin_lock_irqsave(&pmf_lock, flags);
 	dev = pmf_find_device(np);
 	spin_unlock_irqrestore(&pmf_lock, flags);
 	if (dev != NULL) {
-		DBG("pmf: already there !\n");
+		pr_debug("pmf: already there !\n");
 		pmf_put_device(dev);
 		return -EBUSY;
 	}
 
 	dev = kzalloc(sizeof(struct pmf_device), GFP_KERNEL);
 	if (dev == NULL) {
-		DBG("pmf: no memory !\n");
+		pr_debug("pmf: no memory !\n");
 		return -ENOMEM;
 	}
 	kref_init(&dev->ref);
@@ -732,7 +727,7 @@ int pmf_register_driver(struct device_no
 
 	rc = pmf_add_functions(dev, driverdata);
 	if (rc == 0) {
-		DBG("pmf: no functions, disposing.. \n");
+		pr_debug("pmf: no functions, disposing.. \n");
 		of_node_put(np);
 		kfree(dev);
 		return -ENODEV;
@@ -782,12 +777,12 @@ void pmf_unregister_driver(struct device
 	struct pmf_device *dev;
 	unsigned long flags;
 
-	DBG("pmf: unregistering driver for node %s\n", np->full_name);
+	pr_debug("pmf: unregistering driver for node %s\n", np->full_name);
 
 	spin_lock_irqsave(&pmf_lock, flags);
 	dev = pmf_find_device(np);
 	if (dev == NULL) {
-		DBG("pmf: not such driver !\n");
+		pr_debug("pmf: not such driver !\n");
 		spin_unlock_irqrestore(&pmf_lock, flags);
 		return;
 	}
@@ -921,7 +916,7 @@ int pmf_call_one(struct pmf_function *fu
 	void *instdata = NULL;
 	int rc = 0;
 
-	DBG(" ** pmf_call_one(%s/%s) **\n", dev->node->full_name, func->name);
+	pr_debug(" ** pmf_call_one(%s/%s) **\n", dev->node->full_name, func->name);
 
 	if (dev->handlers->begin)
 		instdata = dev->handlers->begin(func, args);
Index: to-merge/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/smp.c
+++ to-merge/arch/powerpc/platforms/powermac/smp.c
@@ -56,12 +56,6 @@
 
 #define DEBUG
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 extern void __secondary_start_pmac_0(void);
 extern int pmac_pfunc_base_install(void);
 
Index: to-merge/arch/powerpc/platforms/powermac/time.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/powermac/time.c
+++ to-merge/arch/powerpc/platforms/powermac/time.c
@@ -9,6 +9,9 @@
  * Copyright (C) 2003-2005 Benjamin Herrenschmidt.
  *
  */
+
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -35,14 +38,6 @@
 #include <asm/nvram.h>
 #include <asm/smu.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 /* Apparently the RTC stores seconds since 1 Jan 1904 */
 #define RTC_OFFSET	2082844800
 
Index: to-merge/arch/powerpc/platforms/pseries/firmware.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/firmware.c
+++ to-merge/arch/powerpc/platforms/pseries/firmware.c
@@ -26,12 +26,6 @@
 #include <asm/firmware.h>
 #include <asm/prom.h>
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 typedef struct {
     unsigned long val;
     char * name;
@@ -71,7 +65,7 @@ void __init fw_feature_init(void)
 	char *hypertas, *s;
 	int len, i;
 
-	DBG(" -> fw_feature_init()\n");
+	pr_debug(" -> fw_feature_init()\n");
 
 	dn = of_find_node_by_path("/rtas");
 	if (dn == NULL) {
@@ -99,5 +93,5 @@ void __init fw_feature_init(void)
 
 out:
 	of_node_put(dn);
-	DBG(" <- fw_feature_init()\n");
+	pr_debug(" <- fw_feature_init()\n");
 }
Index: to-merge/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/iommu.c
+++ to-merge/arch/powerpc/platforms/pseries/iommu.c
@@ -23,6 +23,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -47,8 +49,6 @@
 
 #include "plpar_wrappers.h"
 
-#define DBG(fmt...)
-
 static void tce_build_pSeries(struct iommu_table *tbl, long index, 
 			      long npages, unsigned long uaddr, 
 			      enum dma_data_direction direction)
@@ -334,7 +334,8 @@ static void iommu_bus_setup_pSeries(stru
 	struct pci_dn *pci;
 	int children;
 
-	DBG("iommu_bus_setup_pSeries, bus %p, bus->self %p\n", bus, bus->self);
+	pr_debug("iommu_bus_setup_pSeries, bus %p, bus->self %p\n",
+			bus, bus->self);
 
 	dn = pci_bus_to_OF_node(bus);
 	pci = PCI_DN(dn);
@@ -365,7 +366,7 @@ static void iommu_bus_setup_pSeries(stru
 		if (get_property(tmp, "class-code", NULL))
 			children++;
 
-	DBG("Children: %d\n", children);
+	pr_debug("Children: %d\n", children);
 
 	/* Calculate amount of DMA window per slot. Each window must be
 	 * a power of two (due to pci_alloc_consistent requirements).
@@ -379,7 +380,7 @@ static void iommu_bus_setup_pSeries(stru
 
 		while (pci->phb->dma_window_size * children > 0x80000000ul)
 			pci->phb->dma_window_size >>= 1;
-		DBG("No ISA/IDE, window size is 0x%lx\n",
+		pr_debug("No ISA/IDE, window size is 0x%lx\n",
 			pci->phb->dma_window_size);
 		pci->phb->dma_window_base_cur = 0;
 
@@ -404,7 +405,7 @@ static void iommu_bus_setup_pSeries(stru
 	while (pci->phb->dma_window_size * children > 0x70000000ul)
 		pci->phb->dma_window_size >>= 1;
 
-	DBG("ISA/IDE, window size is 0x%lx\n", pci->phb->dma_window_size);
+	pr_debug("ISA/IDE, window size is 0x%lx\n", pci->phb->dma_window_size);
 
 }
 
@@ -416,7 +417,8 @@ static void iommu_bus_setup_pSeriesLP(st
 	struct pci_dn *ppci;
 	unsigned int *dma_window = NULL;
 
-	DBG("iommu_bus_setup_pSeriesLP, bus %p, bus->self %p\n", bus, bus->self);
+	pr_debug("iommu_bus_setup_pSeriesLP, bus %p, bus->self %p\n",
+			bus, bus->self);
 
 	dn = pci_bus_to_OF_node(bus);
 
@@ -428,7 +430,8 @@ static void iommu_bus_setup_pSeriesLP(st
 	}
 
 	if (dma_window == NULL) {
-		DBG("iommu_bus_setup_pSeriesLP: bus %s seems to have no ibm,dma-window property\n", dn->full_name);
+		pr_debug("iommu_bus_setup_pSeriesLP: bus %s seems to have "
+				"no ibm,dma-window property\n", dn->full_name);
 		return;
 	}
 
@@ -458,7 +461,7 @@ static void iommu_dev_setup_pSeries(stru
 	struct device_node *dn, *mydn;
 	struct iommu_table *tbl;
 
-	DBG("iommu_dev_setup_pSeries, dev %p (%s)\n", dev, pci_name(dev));
+	pr_debug("iommu_dev_setup_pSeries, dev %p (%s)\n", dev, pci_name(dev));
 
 	mydn = dn = pci_device_to_OF_node(dev);
 
@@ -467,7 +470,7 @@ static void iommu_dev_setup_pSeries(stru
 	 * the window sizes already.
 	 */
 	if (!dev->bus->self) {
-		DBG(" --> first child, no bridge. Allocating iommu table.\n");
+		pr_debug("first child, no bridge. Allocating iommu table.\n");
 		tbl = kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
 		iommu_table_setparms(PCI_DN(dn)->phb, dn, tbl);
 		PCI_DN(mydn)->iommu_table = iommu_init_table(tbl);
@@ -485,7 +488,8 @@ static void iommu_dev_setup_pSeries(stru
 	if (dn && PCI_DN(dn)) {
 		PCI_DN(mydn)->iommu_table = PCI_DN(dn)->iommu_table;
 	} else {
-		DBG("iommu_dev_setup_pSeries, dev %p (%s) has no iommu table\n", dev, pci_name(dev));
+		pr_debug("iommu_dev_setup_pSeries, dev %p (%s) has no "
+				"iommu table\n", dev, pci_name(dev));
 	}
 }
 
@@ -519,7 +523,8 @@ static void iommu_dev_setup_pSeriesLP(st
 	int *dma_window = NULL;
 	struct pci_dn *pci;
 
-	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s)\n", dev, pci_name(dev));
+	pr_debug("iommu_dev_setup_pSeriesLP, dev %p (%s)\n",
+			dev, pci_name(dev));
 
 	/* dev setup for LPAR is a little tricky, since the device tree might
 	 * contain the dma-window properties per-device and not neccesarily
@@ -541,11 +546,11 @@ static void iommu_dev_setup_pSeriesLP(st
 	 * slots on POWER4 machines.
 	 */
 	if (dma_window == NULL || pdn->parent == NULL) {
-		DBG("No dma window for device, linking to parent\n");
+		pr_debug("No dma window for device, linking to parent\n");
 		PCI_DN(dn)->iommu_table = PCI_DN(pdn)->iommu_table;
 		return;
 	} else {
-		DBG("Found DMA window, allocating table\n");
+		pr_debug("Found DMA window, allocating table\n");
 	}
 
 	pci = PCI_DN(pdn);
Index: to-merge/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/lpar.c
+++ to-merge/arch/powerpc/platforms/pseries/lpar.c
@@ -19,7 +19,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#undef DEBUG_LOW
+#undef DEBUG	/* warning: leads to _lots_ of output */
 
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -43,12 +43,6 @@
 
 #include "plpar_wrappers.h"
 
-#ifdef DEBUG_LOW
-#define DBG_LOW(fmt...) do { udbg_printf(fmt); } while(0)
-#else
-#define DBG_LOW(fmt...) do { } while(0)
-#endif
-
 /* in pSeries_hvCall.S */
 EXPORT_SYMBOL(plpar_hcall);
 EXPORT_SYMBOL(plpar_hcall_4out);
@@ -281,7 +275,7 @@ long pSeries_lpar_hpte_insert(unsigned l
 	unsigned long dummy0, dummy1;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
+		pr_debug("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
 			"rflags=%lx, vflags=%lx, psize=%d)\n",
 		hpte_group, va, pa, rflags, vflags, psize);
 
@@ -289,7 +283,7 @@ long pSeries_lpar_hpte_insert(unsigned l
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
+		pr_debug(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
 
 	/* Now fill in the actual HPTE */
 	/* Set CEC cookie to 0         */
@@ -307,7 +301,7 @@ long pSeries_lpar_hpte_insert(unsigned l
 			      hpte_r, &slot, &dummy0, &dummy1);
 	if (unlikely(lpar_rc == H_PTEG_FULL)) {
 		if (!(vflags & HPTE_V_BOLTED))
-			DBG_LOW(" full\n");
+			pr_debug(" full\n");
 		return -1;
 	}
 
@@ -318,11 +312,11 @@ long pSeries_lpar_hpte_insert(unsigned l
 	 */
 	if (unlikely(lpar_rc != H_SUCCESS)) {
 		if (!(vflags & HPTE_V_BOLTED))
-			DBG_LOW(" lpar err %d\n", lpar_rc);
+			pr_debug(" lpar err %d\n", lpar_rc);
 		return -2;
 	}
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" -> slot: %d\n", slot & 7);
+		pr_debug(" -> slot: %d\n", slot & 7);
 
 	/* Because of iSeries, we have to pass down the secondary
 	 * bucket bit here as well
@@ -387,17 +381,17 @@ static long pSeries_lpar_hpte_updatepp(u
 
 	want_v = hpte_encode_v(va, psize);
 
-	DBG_LOW("    update: avpnv=%016lx, hash=%016lx, f=%x, psize: %d ... ",
+	pr_debug("    update: avpnv=%016lx, hash=%016lx, f=%x, psize: %d ... ",
 		want_v & HPTE_V_AVPN, slot, flags, psize);
 
 	lpar_rc = plpar_pte_protect(flags, slot, want_v & HPTE_V_AVPN);
 
 	if (lpar_rc == H_NOT_FOUND) {
-		DBG_LOW("not found !\n");
+		pr_debug("not found !\n");
 		return -1;
 	}
 
-	DBG_LOW("ok\n");
+	pr_debug("ok\n");
 
 	BUG_ON(lpar_rc != H_SUCCESS);
 
@@ -479,7 +473,7 @@ static void pSeries_lpar_hpte_invalidate
 	unsigned long lpar_rc;
 	unsigned long dummy1, dummy2;
 
-	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d",
+	pr_debug("    inval : slot=%lx, va=%016lx, psize: %d, local: %d",
 		slot, va, psize, local);
 
 	want_v = hpte_encode_v(va, psize);
Index: to-merge/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/setup.c
+++ to-merge/arch/powerpc/platforms/pseries/setup.c
@@ -71,12 +71,6 @@
 #include "ras.h"
 #include "firmware.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 extern void find_udbg_vterm(void);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
@@ -319,7 +313,7 @@ static int pseries_set_xdabr(unsigned lo
  */
 static void __init pSeries_init_early(void)
 {
-	DBG(" -> pSeries_init_early()\n");
+	pr_debug(" -> pSeries_init_early()\n");
 
 	fw_feature_init();
 	
@@ -340,7 +334,7 @@ static void __init pSeries_init_early(vo
 
 	pSeries_discover_pic();
 
-	DBG(" <- pSeries_init_early()\n");
+	pr_debug(" <- pSeries_init_early()\n");
 }
 
 
@@ -396,12 +390,12 @@ static int __init pSeries_probe(void)
  	if (strcmp(dtype, "chrp"))
 		return 0;
 
-	DBG("pSeries detected, looking for LPAR capability...\n");
+	pr_debug("pSeries detected, looking for LPAR capability...\n");
 
 	/* Now try to figure out if we are running on LPAR */
 	of_scan_flat_dt(pSeries_probe_hypertas, NULL);
 
-	DBG("Machine is%s LPAR !\n",
+	pr_debug("Machine is%s LPAR !\n",
 	    (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
 
 	return 1;
Index: to-merge/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/smp.c
+++ to-merge/arch/powerpc/platforms/pseries/smp.c
@@ -50,13 +50,6 @@
 
 #include "plpar_wrappers.h"
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /*
  * The primary thread of each non-boot processor is recorded here before
  * smp init.
@@ -421,7 +414,7 @@ void __init smp_init_pSeries(void)
 {
 	int i;
 
-	DBG(" -> smp_init_pSeries()\n");
+	pr_debug(" -> smp_init_pSeries()\n");
 
 	switch (ppc64_interrupt_controller) {
 #ifdef CONFIG_MPIC
@@ -469,6 +462,6 @@ void __init smp_init_pSeries(void)
 		smp_ops->take_timebase = pSeries_take_timebase;
 	}
 
-	DBG(" <- smp_init_pSeries()\n");
+	pr_debug(" <- smp_init_pSeries()\n");
 }
 
