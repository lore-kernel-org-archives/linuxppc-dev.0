Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a9a933bc30f3e13c1ea451f277bb176f3c369c46.1209013992.git.michael@ellerman.id.au>
In-Reply-To: <c01702547f6296b2c18e5ff7504ad52cb0402664.1209013992.git.michael@ellerman.id.au>
References: <c01702547f6296b2c18e5ff7504ad52cb0402664.1209013992.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/5] Convert from DBG() to pr_debug() in platforms/pseries/
Date: Thu, 24 Apr 2008 15:13:19 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In pseries/lpar.c, fix some printf specifier mismatches, and add
a newline to one printk.

In pseries/rtasd.c add "rtasd" to some messages to make it clear
where they're coming from.

In pseries/scanlog.c remove the hand-rolled runtime debugging support
in there. This file has been largely unchanged for eons, if we need to
debug it in future we can recompile.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/firmware.c |    9 +-----
 arch/powerpc/platforms/pseries/iommu.c    |   39 ++++++++++++++---------------
 arch/powerpc/platforms/pseries/lpar.c     |   34 +++++++++++--------------
 arch/powerpc/platforms/pseries/rtasd.c    |   14 +++------
 arch/powerpc/platforms/pseries/scanlog.c  |   23 ++++++-----------
 arch/powerpc/platforms/pseries/setup.c    |   15 +++-------
 arch/powerpc/platforms/pseries/smp.c      |   10 +------
 7 files changed, 56 insertions(+), 88 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index b765b7c..743d494 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -27,11 +27,6 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
 
 typedef struct {
     unsigned long val;
@@ -72,7 +67,7 @@ void __init fw_feature_init(const char *hypertas, unsigned long len)
 	const char *s;
 	int i;
 
-	DBG(" -> fw_feature_init()\n");
+	pr_debug(" -> fw_feature_init()\n");
 
 	for (s = hypertas; s < hypertas + len; s += strlen(s) + 1) {
 		for (i = 0; i < FIRMWARE_MAX_FEATURES; i++) {
@@ -88,5 +83,5 @@ void __init fw_feature_init(const char *hypertas, unsigned long len)
 		}
 	}
 
-	DBG(" <- fw_feature_init()\n");
+	pr_debug(" <- fw_feature_init()\n");
 }
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a65c763..176f1f3 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -47,7 +47,6 @@
 
 #include "plpar_wrappers.h"
 
-#define DBG(fmt...)
 
 static void tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
@@ -322,7 +321,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 	dn = pci_bus_to_OF_node(bus);
 
-	DBG("pci_dma_bus_setup_pSeries: setting up bus %s\n", dn->full_name);
+	pr_debug("pci_dma_bus_setup_pSeries: setting up bus %s\n", dn->full_name);
 
 	if (bus->self) {
 		/* This is not a root bus, any setup will be done for the
@@ -347,7 +346,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	for (children = 0, tmp = dn->child; tmp; tmp = tmp->sibling)
 		children++;
 
-	DBG("Children: %d\n", children);
+	pr_debug("Children: %d\n", children);
 
 	/* Calculate amount of DMA window per slot. Each window must be
 	 * a power of two (due to pci_alloc_consistent requirements).
@@ -361,8 +360,8 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 		while (pci->phb->dma_window_size * children > 0x80000000ul)
 			pci->phb->dma_window_size >>= 1;
-		DBG("No ISA/IDE, window size is 0x%lx\n",
-			pci->phb->dma_window_size);
+		pr_debug("No ISA/IDE, window size is 0x%lx\n",
+			 pci->phb->dma_window_size);
 		pci->phb->dma_window_base_cur = 0;
 
 		return;
@@ -387,8 +386,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	while (pci->phb->dma_window_size * children > 0x70000000ul)
 		pci->phb->dma_window_size >>= 1;
 
-	DBG("ISA/IDE, window size is 0x%lx\n", pci->phb->dma_window_size);
-
+	pr_debug("ISA/IDE, window size is 0x%lx\n", pci->phb->dma_window_size);
 }
 
 
@@ -401,7 +399,8 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 
 	dn = pci_bus_to_OF_node(bus);
 
-	DBG("pci_dma_bus_setup_pSeriesLP: setting up bus %s\n", dn->full_name);
+	pr_debug("pci_dma_bus_setup_pSeriesLP: setting up bus %s\n",
+		 dn->full_name);
 
 	/* Find nearest ibm,dma-window, walking up the device tree */
 	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
@@ -411,14 +410,14 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	}
 
 	if (dma_window == NULL) {
-		DBG("  no ibm,dma-window property !\n");
+		pr_debug("  no ibm,dma-window property !\n");
 		return;
 	}
 
 	ppci = PCI_DN(pdn);
 
-	DBG("  parent is %s, iommu_table: 0x%p\n",
-	    pdn->full_name, ppci->iommu_table);
+	pr_debug("  parent is %s, iommu_table: 0x%p\n",
+		 pdn->full_name, ppci->iommu_table);
 
 	if (!ppci->iommu_table) {
 		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
@@ -426,7 +425,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window,
 			bus->number);
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
-		DBG("  created table: %p\n", ppci->iommu_table);
+		pr_debug("  created table: %p\n", ppci->iommu_table);
 	}
 
 	if (pdn != dn)
@@ -439,7 +438,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	struct device_node *dn;
 	struct iommu_table *tbl;
 
-	DBG("pci_dma_dev_setup_pSeries: %s\n", pci_name(dev));
+	pr_debug("pci_dma_dev_setup_pSeries: %s\n", pci_name(dev));
 
 	dn = dev->dev.archdata.of_node;
 
@@ -450,7 +449,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	if (!dev->bus->self) {
 		struct pci_controller *phb = PCI_DN(dn)->phb;
 
-		DBG(" --> first child, no bridge. Allocating iommu table.\n");
+		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
 		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   phb->node);
 		iommu_table_setparms(phb, dn, tbl);
@@ -480,7 +479,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	const void *dma_window = NULL;
 	struct pci_dn *pci;
 
-	DBG("pci_dma_dev_setup_pSeriesLP: %s\n", pci_name(dev));
+	pr_debug("pci_dma_dev_setup_pSeriesLP: %s\n", pci_name(dev));
 
 	/* dev setup for LPAR is a little tricky, since the device tree might
 	 * contain the dma-window properties per-device and not neccesarily
@@ -489,7 +488,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	 * already allocated.
 	 */
 	dn = pci_device_to_OF_node(dev);
-	DBG("  node is %s\n", dn->full_name);
+	pr_debug("  node is %s\n", dn->full_name);
 
 	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
 	     pdn = pdn->parent) {
@@ -504,13 +503,13 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 				 pci_name(dev), dn? dn->full_name : "<null>");
 		return;
 	}
-	DBG("  parent is %s\n", pdn->full_name);
+	pr_debug("  parent is %s\n", pdn->full_name);
 
 	/* Check for parent == NULL so we don't try to setup the empty EADS
 	 * slots on POWER4 machines.
 	 */
 	if (dma_window == NULL || pdn->parent == NULL) {
-		DBG("  no dma window for device, linking to parent\n");
+		pr_debug("  no dma window for device, linking to parent\n");
 		dev->dev.archdata.dma_data = PCI_DN(pdn)->iommu_table;
 		return;
 	}
@@ -522,9 +521,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window,
 			pci->phb->bus->number);
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-		DBG("  created table: %p\n", pci->iommu_table);
+		pr_debug("  created table: %p\n", pci->iommu_table);
 	} else {
-		DBG("  found DMA window, table: %p\n", pci->iommu_table);
+		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
 	}
 
 	dev->dev.archdata.dma_data = pci->iommu_table;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index c34789f..2cbaedb 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -19,7 +19,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#undef DEBUG_LOW
+/* Enables debugging of low-level hash table routines - careful! */
+#undef DEBUG
 
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
@@ -42,11 +43,6 @@
 #include "plpar_wrappers.h"
 #include "pseries.h"
 
-#ifdef DEBUG_LOW
-#define DBG_LOW(fmt...) do { udbg_printf(fmt); } while(0)
-#else
-#define DBG_LOW(fmt...) do { } while(0)
-#endif
 
 /* in hvCall.S */
 EXPORT_SYMBOL(plpar_hcall);
@@ -290,15 +286,15 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	unsigned long hpte_v, hpte_r;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
-			"rflags=%lx, vflags=%lx, psize=%d)\n",
-		hpte_group, va, pa, rflags, vflags, psize);
+		pr_debug("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
+			 "rflags=%lx, vflags=%lx, psize=%d)\n",
+			 hpte_group, va, pa, rflags, vflags, psize);
 
 	hpte_v = hpte_encode_v(va, psize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
+		pr_debug(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
 
 	/* Now fill in the actual HPTE */
 	/* Set CEC cookie to 0         */
@@ -315,7 +311,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);
 	if (unlikely(lpar_rc == H_PTEG_FULL)) {
 		if (!(vflags & HPTE_V_BOLTED))
-			DBG_LOW(" full\n");
+			pr_debug(" full\n");
 		return -1;
 	}
 
@@ -326,11 +322,11 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	 */
 	if (unlikely(lpar_rc != H_SUCCESS)) {
 		if (!(vflags & HPTE_V_BOLTED))
-			DBG_LOW(" lpar err %d\n", lpar_rc);
+			pr_debug(" lpar err %lu\n", lpar_rc);
 		return -2;
 	}
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" -> slot: %d\n", slot & 7);
+		pr_debug(" -> slot: %lu\n", slot & 7);
 
 	/* Because of iSeries, we have to pass down the secondary
 	 * bucket bit here as well
@@ -422,17 +418,17 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 
 	want_v = hpte_encode_avpn(va, psize, ssize);
 
-	DBG_LOW("    update: avpnv=%016lx, hash=%016lx, f=%x, psize: %d ... ",
-		want_v, slot, flags, psize);
+	pr_debug("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
+		 want_v, slot, flags, psize);
 
 	lpar_rc = plpar_pte_protect(flags, slot, want_v);
 
 	if (lpar_rc == H_NOT_FOUND) {
-		DBG_LOW("not found !\n");
+		pr_debug("not found !\n");
 		return -1;
 	}
 
-	DBG_LOW("ok\n");
+	pr_debug("ok\n");
 
 	BUG_ON(lpar_rc != H_SUCCESS);
 
@@ -507,8 +503,8 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
 	unsigned long lpar_rc;
 	unsigned long dummy1, dummy2;
 
-	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d",
-		slot, va, psize, local);
+	pr_debug("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
+		 slot, va, psize, local);
 
 	want_v = hpte_encode_avpn(va, psize, ssize);
 	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v, &dummy1, &dummy2);
diff --git a/arch/powerpc/platforms/pseries/rtasd.c b/arch/powerpc/platforms/pseries/rtasd.c
index e3078ce..befadd4 100644
--- a/arch/powerpc/platforms/pseries/rtasd.c
+++ b/arch/powerpc/platforms/pseries/rtasd.c
@@ -29,11 +29,6 @@
 #include <asm/atomic.h>
 #include <asm/machdep.h>
 
-#if 0
-#define DEBUG(A...)	printk(KERN_ERR A)
-#else
-#define DEBUG(A...)
-#endif
 
 static DEFINE_SPINLOCK(rtasd_log_lock);
 
@@ -198,7 +193,7 @@ void pSeries_log_error(char *buf, unsigned int err_type, int fatal)
 	unsigned long s;
 	int len = 0;
 
-	DEBUG("logging event\n");
+	pr_debug("rtasd: logging event\n");
 	if (buf == NULL)
 		return;
 
@@ -409,7 +404,8 @@ static int rtasd(void *unused)
 	daemonize("rtasd");
 
 	printk(KERN_DEBUG "RTAS daemon started\n");
-	DEBUG("will sleep for %d milliseconds\n", (30000/rtas_event_scan_rate));
+	pr_debug("rtasd: will sleep for %d milliseconds\n",
+		 (30000 / rtas_event_scan_rate));
 
 	/* See if we have any error stored in NVRAM */
 	memset(logdata, 0, rtas_error_log_max);
@@ -428,9 +424,9 @@ static int rtasd(void *unused)
 	do_event_scan_all_cpus(1000);
 
 	if (surveillance_timeout != -1) {
-		DEBUG("enabling surveillance\n");
+		pr_debug("rtasd: enabling surveillance\n");
 		enable_surveillance(surveillance_timeout);
-		DEBUG("surveillance enabled\n");
+		pr_debug("rtasd: surveillance enabled\n");
 	}
 
 	/* Delay should be at least one second since some
diff --git a/arch/powerpc/platforms/pseries/scanlog.c b/arch/powerpc/platforms/pseries/scanlog.c
index e5b0ea8..bec3803 100644
--- a/arch/powerpc/platforms/pseries/scanlog.c
+++ b/arch/powerpc/platforms/pseries/scanlog.c
@@ -38,9 +38,7 @@
 #define SCANLOG_HWERROR -1
 #define SCANLOG_CONTINUE 1
 
-#define DEBUG(A...) do { if (scanlog_debug) printk(KERN_ERR "scanlog: " A); } while (0)
 
-static int scanlog_debug;
 static unsigned int ibm_scan_log_dump;			/* RTAS token */
 static struct proc_dir_entry *proc_ppc64_scan_log_dump;	/* The proc file */
 
@@ -86,14 +84,14 @@ static ssize_t scanlog_read(struct file *file, char __user *buf,
 		memcpy(data, rtas_data_buf, RTAS_DATA_BUF_SIZE);
 		spin_unlock(&rtas_data_buf_lock);
 
-		DEBUG("status=%d, data[0]=%x, data[1]=%x, data[2]=%x\n",
-		      status, data[0], data[1], data[2]);
+		pr_debug("scanlog: status=%d, data[0]=%x, data[1]=%x, " \
+			 "data[2]=%x\n", status, data[0], data[1], data[2]);
 		switch (status) {
 		    case SCANLOG_COMPLETE:
-			DEBUG("hit eof\n");
+			pr_debug("scanlog: hit eof\n");
 			return 0;
 		    case SCANLOG_HWERROR:
-			DEBUG("hardware error reading scan log data\n");
+			pr_debug("scanlog: hardware error reading data\n");
 			return -EIO;
 		    case SCANLOG_CONTINUE:
 			/* We may or may not have data yet */
@@ -110,7 +108,8 @@ static ssize_t scanlog_read(struct file *file, char __user *buf,
 			/* Assume extended busy */
 			wait_time = rtas_busy_delay_time(status);
 			if (!wait_time) {
-				printk(KERN_ERR "scanlog: unknown error from rtas: %d\n", status);
+				printk(KERN_ERR "scanlog: unknown error " \
+				       "from rtas: %d\n", status);
 				return -EIO;
 			}
 		}
@@ -134,15 +133,9 @@ static ssize_t scanlog_write(struct file * file, const char __user * buf,
 
 	if (buf) {
 		if (strncmp(stkbuf, "reset", 5) == 0) {
-			DEBUG("reset scanlog\n");
+			pr_debug("scanlog: reset scanlog\n");
 			status = rtas_call(ibm_scan_log_dump, 2, 1, NULL, 0, 0);
-			DEBUG("rtas returns %d\n", status);
-		} else if (strncmp(stkbuf, "debugon", 7) == 0) {
-			printk(KERN_ERR "scanlog: debug on\n");
-			scanlog_debug = 1;
-		} else if (strncmp(stkbuf, "debugoff", 8) == 0) {
-			printk(KERN_ERR "scanlog: debug off\n");
-			scanlog_debug = 0;
+			pr_debug("scanlog: rtas returns %d\n", status);
 		}
 	}
 	return count;
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f66aa9c..65e8795 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -70,11 +70,6 @@
 #include "plpar_wrappers.h"
 #include "pseries.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
@@ -326,7 +321,7 @@ static int pseries_set_xdabr(unsigned long dabr)
  */
 static void __init pSeries_init_early(void)
 {
-	DBG(" -> pSeries_init_early()\n");
+	pr_debug(" -> pSeries_init_early()\n");
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		find_udbg_vterm();
@@ -338,7 +333,7 @@ static void __init pSeries_init_early(void)
 
 	iommu_init_early_pSeries();
 
-	DBG(" <- pSeries_init_early()\n");
+	pr_debug(" <- pSeries_init_early()\n");
 }
 
 /*
@@ -383,7 +378,7 @@ static int __init pSeries_probe(void)
 	    of_flat_dt_is_compatible(root, "IBM,CBEA"))
 		return 0;
 
-	DBG("pSeries detected, looking for LPAR capability...\n");
+	pr_debug("pSeries detected, looking for LPAR capability...\n");
 
 	/* Now try to figure out if we are running on LPAR */
 	of_scan_flat_dt(pSeries_probe_hypertas, NULL);
@@ -393,8 +388,8 @@ static int __init pSeries_probe(void)
 	else
 		hpte_init_native();
 
-	DBG("Machine is%s LPAR !\n",
-	    (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
+	pr_debug("Machine is%s LPAR !\n",
+	         (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
 
 	return 1;
 }
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index ea4c659..e9bc2a5 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -51,12 +51,6 @@
 #include "plpar_wrappers.h"
 #include "pseries.h"
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
 
 /*
  * The primary thread of each non-boot processor is recorded here before
@@ -231,7 +225,7 @@ static void __init smp_init_pseries(void)
 {
 	int i;
 
-	DBG(" -> smp_init_pSeries()\n");
+	pr_debug(" -> smp_init_pSeries()\n");
 
 	/* Mark threads which are still spinning in hold loops. */
 	if (cpu_has_feature(CPU_FTR_SMT)) {
@@ -255,7 +249,7 @@ static void __init smp_init_pseries(void)
 		smp_ops->take_timebase = pSeries_take_timebase;
 	}
 
-	DBG(" <- smp_init_pSeries()\n");
+	pr_debug(" <- smp_init_pSeries()\n");
 }
 
 #ifdef CONFIG_MPIC
-- 
1.5.5
