Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF1B9B7124
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 06:11:11 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p1AIxZ6Q008512
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 11:59:35 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1AJAqcG101354
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 12:10:52 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p1AJApDX011211
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 12:10:52 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2] ppc: add dynamic dma window support
Date: Thu, 10 Feb 2011 11:10:47 -0800
Message-Id: <1297365047-15231-1-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1297119608-2335-1-git-send-email-nacc@us.ibm.com>
References: <1297119608-2335-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If firmware allows us to map all of a partition's memory for DMA on a
particular bridge, create a 1:1 mapping of that memory. Add hooks for
dealing with hotplug events. Dynamic DMA windows can use larger than the
default page size, and we use the largest one possible.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>
Cc: Paul Mackerras <paulus@samba.org> 
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org

---

Ben, apologies, but Milton gave some offline feedback and I've updated
the full patch -- change some success pr_warnings to pr_debugs; fix up a
typo (build instead of buid); don't set dma offset twice in success
path; and ensure dma_addr is set in the dupe cases.

 Documentation/kernel-parameters.txt    |    4 +
 arch/powerpc/platforms/pseries/iommu.c |  587 ++++++++++++++++++++++++++++++++
 2 files changed, 591 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 89835a4..fb70894 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -617,6 +617,10 @@ and is between 256 and 4096 characters. It is defined in the file
 	disable=	[IPV6]
 			See Documentation/networking/ipv6.txt.
 
+	disable_ddw     [PPC]
+			Disable Dynamic DMA Window support. Use this if
+			to workaround buggy firmware.
+
 	disable_ipv6=	[IPV6]
 			See Documentation/networking/ipv6.txt.
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index edea60b..154c464 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/crash_dump.h>
+#include <linux/memory.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -45,6 +46,7 @@
 #include <asm/tce.h>
 #include <asm/ppc-pci.h>
 #include <asm/udbg.h>
+#include <asm/mmzone.h>
 
 #include "plpar_wrappers.h"
 
@@ -270,6 +272,152 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
 	return tce_ret;
 }
 
+/* this is compatable with cells for the device tree property */
+struct dynamic_dma_window_prop {
+	__be32	liobn;		/* tce table number */
+	__be64	dma_base;	/* address hi,lo */
+	__be32	tce_shift;	/* ilog2(tce_page_size) */
+	__be32	window_shift;	/* ilog2(tce_window_size) */
+};
+
+struct direct_window {
+	struct device_node *device;
+	const struct dynamic_dma_window_prop *prop;
+	struct list_head list;
+};
+
+/* Dynamic DMA Window support */
+struct ddw_query_response {
+	u32 windows_available;
+	u32 largest_available_block;
+	u32 page_size;
+	u32 migration_capable;
+};
+
+struct ddw_create_response {
+	u32 liobn;
+	u32 addr_hi;
+	u32 addr_lo;
+};
+
+static LIST_HEAD(direct_window_list);
+/* prevents races between memory on/offline and window creation */
+static DEFINE_SPINLOCK(direct_window_list_lock);
+/* protects initializing window twice for same device */
+static DEFINE_MUTEX(direct_window_init_mutex);
+#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
+
+static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
+					unsigned long num_pfn, const void *arg)
+{
+	const struct dynamic_dma_window_prop *maprange = arg;
+	int rc;
+	u64 tce_size, num_tce, dma_offset, next;
+	u32 tce_shift;
+	long limit;
+
+	tce_shift = be32_to_cpu(maprange->tce_shift);
+	tce_size = 1ULL << tce_shift;
+	next = start_pfn << PAGE_SHIFT;
+	num_tce = num_pfn << PAGE_SHIFT;
+
+	/* round back to the beginning of the tce page size */
+	num_tce += next & (tce_size - 1);
+	next &= ~(tce_size - 1);
+
+	/* covert to number of tces */
+	num_tce |= tce_size - 1;
+	num_tce >>= tce_shift;
+
+	do {
+		/*
+		 * Set up the page with TCE data, looping through and setting
+		 * the values.
+		 */
+		limit = min_t(long, num_tce, 512);
+		dma_offset = next + be64_to_cpu(maprange->dma_base);
+
+		rc = plpar_tce_stuff((u64)be32_to_cpu(maprange->liobn),
+					     dma_offset,
+					     0, limit);
+		num_tce -= limit;
+	} while (num_tce > 0 && !rc);
+
+	return rc;
+}
+
+static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
+					unsigned long num_pfn, const void *arg)
+{
+	const struct dynamic_dma_window_prop *maprange = arg;
+	u64 *tcep, tce_size, num_tce, dma_offset, next, proto_tce, liobn;
+	u32 tce_shift;
+	u64 rc = 0;
+	long l, limit;
+
+	local_irq_disable();	/* to protect tcep and the page behind it */
+	tcep = __get_cpu_var(tce_page);
+
+	if (!tcep) {
+		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
+		if (!tcep) {
+			local_irq_enable();
+			return -ENOMEM;
+		}
+		__get_cpu_var(tce_page) = tcep;
+	}
+
+	proto_tce = TCE_PCI_READ | TCE_PCI_WRITE;
+
+	liobn = (u64)be32_to_cpu(maprange->liobn);
+	tce_shift = be32_to_cpu(maprange->tce_shift);
+	tce_size = 1ULL << tce_shift;
+	next = start_pfn << PAGE_SHIFT;
+	num_tce = num_pfn << PAGE_SHIFT;
+
+	/* round back to the beginning of the tce page size */
+	num_tce += next & (tce_size - 1);
+	next &= ~(tce_size - 1);
+
+	/* covert to number of tces */
+	num_tce |= tce_size - 1;
+	num_tce >>= tce_shift;
+
+	/* We can map max one pageful of TCEs at a time */
+	do {
+		/*
+		 * Set up the page with TCE data, looping through and setting
+		 * the values.
+		 */
+		limit = min_t(long, num_tce, 4096/TCE_ENTRY_SIZE);
+		dma_offset = next + be64_to_cpu(maprange->dma_base);
+
+		for (l = 0; l < limit; l++) {
+			tcep[l] = proto_tce | next;
+			next += tce_size;
+		}
+
+		rc = plpar_tce_put_indirect(liobn,
+					    dma_offset,
+					    (u64)virt_to_abs(tcep),
+					    limit);
+
+		num_tce -= limit;
+	} while (num_tce > 0 && !rc);
+
+	/* error cleanup: caller will clear whole range */
+
+	local_irq_enable();
+	return rc;
+}
+
+static int tce_setrange_multi_pSeriesLP_walk(unsigned long start_pfn,
+		unsigned long num_pfn, void *arg)
+{
+	return tce_setrange_multi_pSeriesLP(start_pfn, num_pfn, arg);
+}
+
+
 #ifdef CONFIG_PCI
 static void iommu_table_setparms(struct pci_controller *phb,
 				 struct device_node *dn,
@@ -495,6 +643,329 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		       pci_name(dev));
 }
 
+static int __read_mostly disable_ddw;
+
+static int __init disable_ddw_setup(char *str)
+{
+	disable_ddw = 1;
+	printk(KERN_INFO "ppc iommu: disabling ddw.\n");
+
+	return 0;
+}
+
+early_param("disable_ddw", disable_ddw_setup);
+
+static void remove_ddw(struct device_node *np)
+{
+	struct dynamic_dma_window_prop *dwp;
+	struct property *win64;
+	const u32 *ddr_avail;
+	u64 liobn;
+	int len, ret;
+
+	ddr_avail = of_get_property(np, "ibm,ddw-applicable", &len);
+	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
+	if (!win64 || !ddr_avail || len < 3 * sizeof(u32))
+		return;
+
+	dwp = win64->value;
+	liobn = (u64)be32_to_cpu(dwp->liobn);
+
+	/* clear the whole window, note the arg is in kernel pages */
+	ret = tce_clearrange_multi_pSeriesLP(0,
+		1ULL << (be32_to_cpu(dwp->window_shift) - PAGE_SHIFT), dwp);
+	if (ret)
+		pr_warning("%s failed to clear tces in window.\n",
+			 np->full_name);
+	else
+		pr_debug("%s successfully cleared tces in window.\n",
+			 np->full_name);
+
+	ret = rtas_call(ddr_avail[2], 1, 1, NULL, liobn);
+	if (ret)
+		pr_warning("%s: failed to remove direct window: rtas returned "
+			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
+			np->full_name, ret, ddr_avail[2], liobn);
+	else
+		pr_debug("%s: successfully removed direct window: rtas returned "
+			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
+			np->full_name, ret, ddr_avail[2], liobn);
+}
+
+
+static int dupe_ddw_if_already_created(struct pci_dev *dev, struct device_node *pdn)
+{
+	struct device_node *dn;
+	struct pci_dn *pcidn;
+	struct direct_window *window;
+	const struct dynamic_dma_window_prop *direct64;
+	u64 dma_addr = 0;
+
+	dn = pci_device_to_OF_node(dev);
+	pcidn = PCI_DN(dn);
+	spin_lock(&direct_window_list_lock);
+	/* check if we already created a window and dupe that config if so */
+	list_for_each_entry(window, &direct_window_list, list) {
+		if (window->device == pdn) {
+			direct64 = window->prop;
+			dma_addr = direct64->dma_base;
+			break;
+		}
+	}
+	spin_unlock(&direct_window_list_lock);
+
+	return dma_addr;
+}
+
+static u64 dupe_ddw_if_kexec(struct pci_dev *dev, struct device_node *pdn)
+{
+	struct device_node *dn;
+	struct pci_dn *pcidn;
+	int len;
+	struct direct_window *window;
+	const struct dynamic_dma_window_prop *direct64;
+	u64 dma_addr = 0;
+
+	dn = pci_device_to_OF_node(dev);
+	pcidn = PCI_DN(dn);
+	direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
+	if (direct64) {
+		window = kzalloc(sizeof(*window), GFP_KERNEL);
+		if (!window) {
+			remove_ddw(pdn);
+		} else {
+			window->device = pdn;
+			window->prop = direct64;
+			spin_lock(&direct_window_list_lock);
+			list_add(&window->list, &direct_window_list);
+			spin_unlock(&direct_window_list_lock);
+			dma_addr = direct64->dma_base;
+		}
+	}
+
+	return dma_addr;
+}
+
+static int query_ddw(struct pci_dev *dev, const u32 *ddr_avail,
+			struct ddw_query_response *query)
+{
+	struct device_node *dn;
+	struct pci_dn *pcidn;
+	u32 cfg_addr;
+	u64 buid;
+	int ret;
+
+	/*
+	 * Get the config address and phb buid of the PE window.
+	 * Rely on eeh to retrieve this for us.
+	 * Retrieve them from the pci device, not the node with the
+	 * dma-window property
+	 */
+	dn = pci_device_to_OF_node(dev);
+	pcidn = PCI_DN(dn);
+	cfg_addr = pcidn->eeh_config_addr;
+	if (pcidn->eeh_pe_config_addr)
+		cfg_addr = pcidn->eeh_pe_config_addr;
+	buid = pcidn->phb->buid;
+	ret = rtas_call(ddr_avail[0], 3, 5, (u32 *)query,
+		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
+	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x"
+		" returned %d\n", ddr_avail[0], cfg_addr, BUID_HI(buid),
+		BUID_LO(buid), ret);
+	return ret;
+}
+
+static int create_ddw(struct pci_dev *dev, const u32 *ddr_avail,
+			struct ddw_create_response *create, int page_shift,
+			int window_shift)
+{
+	struct device_node *dn;
+	struct pci_dn *pcidn;
+	u32 cfg_addr;
+	u64 buid;
+	int ret;
+
+	/*
+	 * Get the config address and phb buid of the PE window.
+	 * Rely on eeh to retrieve this for us.
+	 * Retrieve them from the pci device, not the node with the
+	 * dma-window property
+	 */
+	dn = pci_device_to_OF_node(dev);
+	pcidn = PCI_DN(dn);
+	cfg_addr = pcidn->eeh_config_addr;
+	if (pcidn->eeh_pe_config_addr)
+		cfg_addr = pcidn->eeh_pe_config_addr;
+	buid = pcidn->phb->buid;
+
+	do {
+		/* extra outputs are LIOBN and dma-addr (hi, lo) */
+		ret = rtas_call(ddr_avail[1], 5, 4, (u32 *)create, cfg_addr,
+				BUID_HI(buid), BUID_LO(buid), page_shift, window_shift);
+	} while (rtas_busy_delay(ret));
+	dev_info(&dev->dev,
+		"ibm,create-pe-dma-window(%x) %x %x %x %x %x returned %d "
+		"(liobn = 0x%x starting addr = %x %x)\n", ddr_avail[1],
+		 cfg_addr, BUID_HI(buid), BUID_LO(buid), page_shift,
+		 window_shift, ret, create->liobn, create->addr_hi, create->addr_lo);
+
+	return ret;
+}
+
+/*
+ * If the PE supports dynamic dma windows, and there is space for a table
+ * that can map all pages in a linear offset, then setup such a table,
+ * and record the dma-offset in the struct device.
+ *
+ * dev: the pci device we are checking
+ * pdn: the parent pe node with the ibm,dma_window property
+ * Future: also check if we can remap the base window for our base page size
+ *
+ * returns the dma offset for use by dma_set_mask
+ */
+static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
+{
+	int len, ret;
+	struct ddw_query_response query;
+	struct ddw_create_response create;
+	int page_shift;
+	u64 dma_addr, max_addr;
+	struct device_node *dn;
+	const u32 *uninitialized_var(ddr_avail);
+	struct direct_window *window;
+	struct property *uninitialized_var(win64);
+	struct dynamic_dma_window_prop *ddwprop;
+
+	mutex_lock(&direct_window_init_mutex);
+
+	dma_addr = dupe_ddw_if_already_created(dev, pdn);
+	if (dma_addr != 0)
+		goto out_unlock;
+
+	dma_addr = dupe_ddw_if_kexec(dev, pdn);
+	if (dma_addr != 0)
+		goto out_unlock;
+
+	/*
+	 * the ibm,ddw-applicable property holds the tokens for:
+	 * ibm,query-pe-dma-window
+	 * ibm,create-pe-dma-window
+	 * ibm,remove-pe-dma-window
+	 * for the given node in that order.
+	 * the property is actually in the parent, not the PE
+	 */
+	ddr_avail = of_get_property(pdn, "ibm,ddw-applicable", &len);
+	if (!ddr_avail || len < 3 * sizeof(u32))
+		goto out_unlock;
+
+       /*
+	 * Query if there is a second window of size to map the
+	 * whole partition.  Query returns number of windows, largest
+	 * block assigned to PE (partition endpoint), and two bitmasks
+	 * of page sizes: supported and supported for migrate-dma.
+	 */
+	dn = pci_device_to_OF_node(dev);
+	ret = query_ddw(dev, ddr_avail, &query);
+	if (ret != 0)
+		goto out_unlock;
+
+	if (query.windows_available == 0) {
+		/*
+		 * no additional windows are available for this device.
+		 * We might be able to reallocate the existing window,
+		 * trading in for a larger page size.
+		 */
+		dev_dbg(&dev->dev, "no free dynamic windows");
+		goto out_unlock;
+	}
+	if (query.page_size & 4) {
+		page_shift = 24; /* 16MB */
+	} else if (query.page_size & 2) {
+		page_shift = 16; /* 64kB */
+	} else if (query.page_size & 1) {
+		page_shift = 12; /* 4kB */
+	} else {
+		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
+			  query.page_size);
+		goto out_unlock;
+	}
+	/* verify the window * number of ptes will map the partition */
+	/* check largest block * page size > max memory hotplug addr */
+	max_addr = memory_hotplug_max();
+	if (query.largest_available_block < (max_addr >> page_shift)) {
+		dev_dbg(&dev->dev, "can't map partiton max 0x%llx with %u "
+			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
+			  1ULL << page_shift);
+		goto out_unlock;
+	}
+	len = order_base_2(max_addr);
+	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
+	if (!win64) {
+		dev_info(&dev->dev,
+			"couldn't allocate property for 64bit dma window\n");
+		goto out_unlock;
+	}
+	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
+	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
+	if (!win64->name || !win64->value) {
+		dev_info(&dev->dev,
+			"couldn't allocate property name and value\n");
+		goto out_free_prop;
+	}
+
+	ret = create_ddw(dev, ddr_avail, &create, page_shift, len);
+	if (ret != 0)
+		goto out_free_prop;
+
+	ddwprop->liobn = cpu_to_be32(create.liobn);
+	ddwprop->dma_base = cpu_to_be64(of_read_number(&create.addr_hi, 2));
+	ddwprop->tce_shift = cpu_to_be32(page_shift);
+	ddwprop->window_shift = cpu_to_be32(len);
+
+	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %s\n",
+		  create.liobn, dn->full_name);
+
+	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	if (!window)
+		goto out_clear_window;
+
+	ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
+			win64->value, tce_setrange_multi_pSeriesLP_walk);
+	if (ret) {
+		dev_info(&dev->dev, "failed to map direct window for %s: %d\n",
+			 dn->full_name, ret);
+		goto out_clear_window;
+	}
+
+	ret = prom_add_property(pdn, win64);
+	if (ret) {
+		dev_err(&dev->dev, "unable to add dma window property for %s: %d",
+			 pdn->full_name, ret);
+		goto out_clear_window;
+	}
+
+	window->device = pdn;
+	window->prop = ddwprop;
+	spin_lock(&direct_window_list_lock);
+	list_add(&window->list, &direct_window_list);
+	spin_unlock(&direct_window_list_lock);
+
+	dma_addr = of_read_number(&create.addr_hi, 2);
+	goto out_unlock;
+
+out_clear_window:
+	remove_ddw(pdn);
+
+out_free_prop:
+	kfree(win64->name);
+	kfree(win64->value);
+	kfree(win64);
+
+out_unlock:
+	mutex_unlock(&direct_window_init_mutex);
+	return dma_addr;
+}
+
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 {
 	struct device_node *pdn, *dn;
@@ -541,23 +1012,137 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 
 	set_iommu_table_base(&dev->dev, pci->iommu_table);
 }
+
+static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
+{
+	bool ddw_enabled = false;
+	struct device_node *pdn, *dn;
+	struct pci_dev *pdev;
+	const void *dma_window = NULL;
+	u64 dma_offset;
+
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
+		return -EIO;
+
+	/* only attempt to use a new window if 64-bit DMA is requested */
+	if (!disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
+		pdev = to_pci_dev(dev);
+
+		dn = pci_device_to_OF_node(pdev);
+		dev_dbg(dev, "node is %s\n", dn->full_name);
+
+		/*
+		 * the device tree might contain the dma-window properties
+		 * per-device and not neccesarily for the bus. So we need to
+		 * search upwards in the tree until we either hit a dma-window
+		 * property, OR find a parent with a table already allocated.
+		 */
+		for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
+				pdn = pdn->parent) {
+			dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
+			if (dma_window)
+				break;
+		}
+		if (pdn && PCI_DN(pdn)) {
+			dma_offset = enable_ddw(pdev, pdn);
+			if (dma_offset != 0) {
+				dev_info(dev, "Using 64-bit direct DMA at offset %llx\n", dma_offset);
+				set_dma_offset(dev, dma_offset);
+				set_dma_ops(dev, &dma_direct_ops);
+				ddw_enabled = true;
+			}
+		}
+	}
+
+	/* fall-through to iommu ops */
+	if (!ddw_enabled) {
+		dev_info(dev, "Using 32-bit DMA via iommu\n");
+		set_dma_ops(dev, &dma_iommu_ops);
+	}
+
+	*dev->dma_mask = dma_mask;
+	return 0;
+}
+
 #else  /* CONFIG_PCI */
 #define pci_dma_bus_setup_pSeries	NULL
 #define pci_dma_dev_setup_pSeries	NULL
 #define pci_dma_bus_setup_pSeriesLP	NULL
 #define pci_dma_dev_setup_pSeriesLP	NULL
+#define dma_set_mask_pSeriesLP		NULL
 #endif /* !CONFIG_PCI */
 
+static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
+		void *data)
+{
+	struct direct_window *window;
+	struct memory_notify *arg = data;
+	int ret = 0;
+
+	switch (action) {
+	case MEM_GOING_ONLINE:
+		spin_lock(&direct_window_list_lock);
+		list_for_each_entry(window, &direct_window_list, list) {
+			ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
+					arg->nr_pages, window->prop);
+			/* XXX log error */
+		}
+		spin_unlock(&direct_window_list_lock);
+		break;
+	case MEM_CANCEL_ONLINE:
+	case MEM_OFFLINE:
+		spin_lock(&direct_window_list_lock);
+		list_for_each_entry(window, &direct_window_list, list) {
+			ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
+					arg->nr_pages, window->prop);
+			/* XXX log error */
+		}
+		spin_unlock(&direct_window_list_lock);
+		break;
+	default:
+		break;
+	}
+	if (ret && action != MEM_CANCEL_ONLINE)
+		return NOTIFY_BAD;
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block iommu_mem_nb = {
+	.notifier_call = iommu_mem_notifier,
+};
+
 static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
 {
 	int err = NOTIFY_OK;
 	struct device_node *np = node;
 	struct pci_dn *pci = PCI_DN(np);
+	struct direct_window *window;
 
 	switch (action) {
 	case PSERIES_RECONFIG_REMOVE:
 		if (pci && pci->iommu_table)
 			iommu_free_table(pci->iommu_table, np->full_name);
+
+		spin_lock(&direct_window_list_lock);
+		list_for_each_entry(window, &direct_window_list, list) {
+			if (window->device == np) {
+				list_del(&window->list);
+				kfree(window);
+				break;
+			}
+		}
+		spin_unlock(&direct_window_list_lock);
+
+		/*
+		 * Because the notifier runs after isolation of the
+		 * slot, we are guaranteed any DMA window has already
+		 * been revoked and the TCEs have been marked invalid,
+		 * so we don't need a call to remove_ddw(np). However,
+		 * if an additional notifier action is added before the
+		 * isolate call, we should update this code for
+		 * completeness with such a call.
+		 */
 		break;
 	default:
 		err = NOTIFY_DONE;
@@ -587,6 +1172,7 @@ void iommu_init_early_pSeries(void)
 		ppc_md.tce_get   = tce_get_pSeriesLP;
 		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_pSeriesLP;
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
+		ppc_md.dma_set_mask = dma_set_mask_pSeriesLP;
 	} else {
 		ppc_md.tce_build = tce_build_pSeries;
 		ppc_md.tce_free  = tce_free_pSeries;
@@ -597,6 +1183,7 @@ void iommu_init_early_pSeries(void)
 
 
 	pSeries_reconfig_notifier_register(&iommu_reconfig_nb);
+	register_memory_notifier(&iommu_mem_nb);
 
 	set_pci_dma_ops(&dma_iommu_ops);
 }
-- 
1.7.1
