Return-Path: <bhe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414b3b1S1pzF45l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 13:29:47 +1000 (AEST)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
 josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de
Cc: patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, dmitry.torokhov@gmail.com,
 frowand.list@gmail.com, keith.busch@intel.com, jonathan.derrick@intel.com,
 lorenzo.pieralisi@arm.com, bhelgaas@google.com, tglx@linutronix.de,
 brijesh.singh@amd.com, jglisse@redhat.com, thomas.lendacky@amd.com,
 gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
 richard.weiyang@gmail.com, devel@linuxdriverproject.org,
 linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
 yinghai@kernel.org, kexec@lists.infradead.org, monstr@monstr.eu,
 davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
 gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
 seanpaul@chromium.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 2/4] resource: Use list_head to link sibling resource
Date: Tue, 12 Jun 2018 11:28:29 +0800
Message-Id: <20180612032831.29747-3-bhe@redhat.com>
In-Reply-To: <20180612032831.29747-1-bhe@redhat.com>
References: <20180612032831.29747-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The struct resource uses singly linked list to link siblings, implemented
by pointer operation. Replace it with list_head for better code readability.

Based on this list_head replacement, it will be very easy to do reverse
iteration on iomem_resource's sibling list in later patch.

Besides, type of member variables of struct resource, sibling and child, are
changed from 'struct resource *' to 'struct list_head'. This brings two
pointers of size increase.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: devel@linuxdriverproject.org
Cc: linux-input@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
Cc: devicetree@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 arch/arm/plat-samsung/pm-check.c            |   6 +-
 arch/microblaze/pci/pci-common.c            |   4 +-
 arch/powerpc/kernel/pci-common.c            |   4 +-
 arch/sparc/kernel/ioport.c                  |   2 +-
 arch/xtensa/include/asm/pci-bridge.h        |   4 +-
 drivers/eisa/eisa-bus.c                     |   2 +
 drivers/gpu/drm/drm_memory.c                |   3 +-
 drivers/gpu/drm/gma500/gtt.c                |   5 +-
 drivers/hv/vmbus_drv.c                      |  52 +++----
 drivers/input/joystick/iforce/iforce-main.c |   4 +-
 drivers/nvdimm/namespace_devs.c             |   6 +-
 drivers/nvdimm/nd.h                         |   5 +-
 drivers/of/address.c                        |   4 +-
 drivers/parisc/lba_pci.c                    |   4 +-
 drivers/pci/host/vmd.c                      |   8 +-
 drivers/pci/probe.c                         |   2 +
 drivers/pci/setup-bus.c                     |   2 +-
 include/linux/ioport.h                      |  17 ++-
 kernel/resource.c                           | 211 ++++++++++++++--------------
 19 files changed, 176 insertions(+), 169 deletions(-)

diff --git a/arch/arm/plat-samsung/pm-check.c b/arch/arm/plat-samsung/pm-check.c
index cd2c02c68bc3..5494355b1c49 100644
--- a/arch/arm/plat-samsung/pm-check.c
+++ b/arch/arm/plat-samsung/pm-check.c
@@ -46,8 +46,8 @@ typedef u32 *(run_fn_t)(struct resource *ptr, u32 *arg);
 static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
 {
 	while (ptr != NULL) {
-		if (ptr->child != NULL)
-			s3c_pm_run_res(ptr->child, fn, arg);
+		if (!list_empty(&ptr->child))
+			s3c_pm_run_res(resource_first_child(&ptr->child), fn, arg);
 
 		if ((ptr->flags & IORESOURCE_SYSTEM_RAM)
 				== IORESOURCE_SYSTEM_RAM) {
@@ -57,7 +57,7 @@ static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
 			arg = (fn)(ptr, arg);
 		}
 
-		ptr = ptr->sibling;
+		ptr = resource_sibling(ptr);
 	}
 }
 
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 7899bafab064..2bf73e27e231 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -533,7 +533,9 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			res->flags = range.flags;
 			res->start = range.cpu_addr;
 			res->end = range.cpu_addr + range.size - 1;
-			res->parent = res->child = res->sibling = NULL;
+			res->parent = NULL;
+			INIT_LIST_HEAD(&res->child);
+			INIT_LIST_HEAD(&res->sibling);
 		}
 	}
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 926035bb378d..28fbe83c9daf 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -761,7 +761,9 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			res->flags = range.flags;
 			res->start = range.cpu_addr;
 			res->end = range.cpu_addr + range.size - 1;
-			res->parent = res->child = res->sibling = NULL;
+			res->parent = NULL;
+			INIT_LIST_HEAD(&res->child);
+			INIT_LIST_HEAD(&res->sibling);
 		}
 	}
 }
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index cca9134cfa7d..99efe4e98b16 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -669,7 +669,7 @@ static int sparc_io_proc_show(struct seq_file *m, void *v)
 	struct resource *root = m->private, *r;
 	const char *nm;
 
-	for (r = root->child; r != NULL; r = r->sibling) {
+	list_for_each_entry(r, &root->child, sibling) {
 		if ((nm = r->name) == NULL) nm = "???";
 		seq_printf(m, "%016llx-%016llx: %s\n",
 				(unsigned long long)r->start,
diff --git a/arch/xtensa/include/asm/pci-bridge.h b/arch/xtensa/include/asm/pci-bridge.h
index 0b68c76ec1e6..f487b06817df 100644
--- a/arch/xtensa/include/asm/pci-bridge.h
+++ b/arch/xtensa/include/asm/pci-bridge.h
@@ -71,8 +71,8 @@ static inline void pcibios_init_resource(struct resource *res,
 	res->flags = flags;
 	res->name = name;
 	res->parent = NULL;
-	res->sibling = NULL;
-	res->child = NULL;
+	INIT_LIST_HEAD(&res->child);
+	INIT_LIST_HEAD(&res->sibling);
 }
 
 
diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index 1e8062f6dbfc..dba78f75fd06 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -408,6 +408,8 @@ static struct resource eisa_root_res = {
 	.start = 0,
 	.end   = 0xffffffff,
 	.flags = IORESOURCE_IO,
+	.sibling = LIST_HEAD_INIT(eisa_root_res.sibling),
+	.child  = LIST_HEAD_INIT(eisa_root_res.child),
 };
 
 static int eisa_bus_count;
diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
index 3c54044214db..53e300a993dc 100644
--- a/drivers/gpu/drm/drm_memory.c
+++ b/drivers/gpu/drm/drm_memory.c
@@ -155,9 +155,8 @@ u64 drm_get_max_iomem(void)
 	struct resource *tmp;
 	resource_size_t max_iomem = 0;
 
-	for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling) {
+	list_for_each_entry(tmp, &iomem_resource.child, sibling)
 		max_iomem = max(max_iomem,  tmp->end);
-	}
 
 	return max_iomem;
 }
diff --git a/drivers/gpu/drm/gma500/gtt.c b/drivers/gpu/drm/gma500/gtt.c
index 3949b0990916..addd3bc009af 100644
--- a/drivers/gpu/drm/gma500/gtt.c
+++ b/drivers/gpu/drm/gma500/gtt.c
@@ -565,7 +565,7 @@ int psb_gtt_init(struct drm_device *dev, int resume)
 int psb_gtt_restore(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
-	struct resource *r = dev_priv->gtt_mem->child;
+	struct resource *r;
 	struct gtt_range *range;
 	unsigned int restored = 0, total = 0, size = 0;
 
@@ -573,14 +573,13 @@ int psb_gtt_restore(struct drm_device *dev)
 	mutex_lock(&dev_priv->gtt_mutex);
 	psb_gtt_init(dev, 1);
 
-	while (r != NULL) {
+	list_for_each_entry(r, &dev_priv->gtt_mem->child, sibling) {
 		range = container_of(r, struct gtt_range, resource);
 		if (range->pages) {
 			psb_gtt_insert(dev, range, 1);
 			size += range->resource.end - range->resource.start;
 			restored++;
 		}
-		r = r->sibling;
 		total++;
 	}
 	mutex_unlock(&dev_priv->gtt_mutex);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b10fe26c4891..d87ec5a1bc4c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1412,9 +1412,8 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 {
 	resource_size_t start = 0;
 	resource_size_t end = 0;
-	struct resource *new_res;
+	struct resource *new_res, *tmp;
 	struct resource **old_res = &hyperv_mmio;
-	struct resource **prev_res = NULL;
 
 	switch (res->type) {
 
@@ -1461,44 +1460,36 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 	/*
 	 * If two ranges are adjacent, merge them.
 	 */
-	do {
-		if (!*old_res) {
-			*old_res = new_res;
-			break;
-		}
-
-		if (((*old_res)->end + 1) == new_res->start) {
-			(*old_res)->end = new_res->end;
+	if (!*old_res) {
+		*old_res = new_res;
+		return AE_OK;
+	}
+	tmp = *old_res;
+	list_for_each_entry_from(tmp, &tmp->parent->child, sibling) {
+		if ((tmp->end + 1) == new_res->start) {
+			tmp->end = new_res->end;
 			kfree(new_res);
 			break;
 		}
 
-		if ((*old_res)->start == new_res->end + 1) {
-			(*old_res)->start = new_res->start;
+		if (tmp->start == new_res->end + 1) {
+			tmp->start = new_res->start;
 			kfree(new_res);
 			break;
 		}
 
-		if ((*old_res)->start > new_res->end) {
-			new_res->sibling = *old_res;
-			if (prev_res)
-				(*prev_res)->sibling = new_res;
-			*old_res = new_res;
+		if (tmp->start > new_res->end) {
+			list_add(&new_res->sibling, tmp->sibling.prev);
 			break;
 		}
-
-		prev_res = old_res;
-		old_res = &(*old_res)->sibling;
-
-	} while (1);
+	}
 
 	return AE_OK;
 }
 
 static int vmbus_acpi_remove(struct acpi_device *device)
 {
-	struct resource *cur_res;
-	struct resource *next_res;
+	struct resource *res;
 
 	if (hyperv_mmio) {
 		if (fb_mmio) {
@@ -1507,10 +1498,9 @@ static int vmbus_acpi_remove(struct acpi_device *device)
 			fb_mmio = NULL;
 		}
 
-		for (cur_res = hyperv_mmio; cur_res; cur_res = next_res) {
-			next_res = cur_res->sibling;
-			kfree(cur_res);
-		}
+		res = hyperv_mmio;
+		list_for_each_entry_from(res, &res->parent->child, sibling)
+			kfree(res);
 	}
 
 	return 0;
@@ -1596,7 +1586,8 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 		}
 	}
 
-	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
+	iter = hyperv_mmio;
+	list_for_each_entry_from(iter, &iter->parent->child, sibling) {
 		if ((iter->start >= max) || (iter->end <= min))
 			continue;
 
@@ -1639,7 +1630,8 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 	struct resource *iter;
 
 	down(&hyperv_mmio_lock);
-	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
+	iter = hyperv_mmio;
+	list_for_each_entry_from(iter, &iter->parent->child, sibling) {
 		if ((iter->start >= start + size) || (iter->end <= start))
 			continue;
 
diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index daeeb4c7e3b0..5c0be27b33ff 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -305,8 +305,8 @@ int iforce_init_device(struct iforce *iforce)
 	iforce->device_memory.end = 200;
 	iforce->device_memory.flags = IORESOURCE_MEM;
 	iforce->device_memory.parent = NULL;
-	iforce->device_memory.child = NULL;
-	iforce->device_memory.sibling = NULL;
+	INIT_LIST_HEAD(&iforce->device_memory.child);
+	INIT_LIST_HEAD(&iforce->device_memory.sibling);
 
 /*
  * Wait until device ready - until it sends its first response.
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 28afdd668905..f53d410d9981 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -637,7 +637,7 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
  retry:
 	first = 0;
 	for_each_dpa_resource(ndd, res) {
-		struct resource *next = res->sibling, *new_res = NULL;
+		struct resource *next = resource_sibling(res), *new_res = NULL;
 		resource_size_t allocate, available = 0;
 		enum alloc_loc loc = ALLOC_ERR;
 		const char *action;
@@ -763,7 +763,7 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 	 * an initial "pmem-reserve pass".  Only do an initial BLK allocation
 	 * when none of the DPA space is reserved.
 	 */
-	if ((is_pmem || !ndd->dpa.child) && n == to_allocate)
+	if ((is_pmem || list_empty(&ndd->dpa.child)) && n == to_allocate)
 		return init_dpa_allocation(label_id, nd_region, nd_mapping, n);
 	return n;
 }
@@ -779,7 +779,7 @@ static int merge_dpa(struct nd_region *nd_region,
  retry:
 	for_each_dpa_resource(ndd, res) {
 		int rc;
-		struct resource *next = res->sibling;
+		struct resource *next = resource_sibling(res);
 		resource_size_t end = res->start + resource_size(res);
 
 		if (!next || strcmp(res->name, label_id->id) != 0
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 32e0364b48b9..da7da15e03e7 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -102,11 +102,10 @@ unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd);
 		(unsigned long long) (res ? res->start : 0), ##arg)
 
 #define for_each_dpa_resource(ndd, res) \
-	for (res = (ndd)->dpa.child; res; res = res->sibling)
+	list_for_each_entry(res, &(ndd)->dpa.child, sibling)
 
 #define for_each_dpa_resource_safe(ndd, res, next) \
-	for (res = (ndd)->dpa.child, next = res ? res->sibling : NULL; \
-			res; res = next, next = next ? next->sibling : NULL)
+	list_for_each_entry_safe(res, next, &(ndd)->dpa.child, sibling)
 
 struct nd_percpu_lane {
 	int count;
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 53349912ac75..e2e25719ab52 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -330,7 +330,9 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 {
 	int err;
 	res->flags = range->flags;
-	res->parent = res->child = res->sibling = NULL;
+	res->parent = NULL;
+	INIT_LIST_HEAD(&res->child);
+	INIT_LIST_HEAD(&res->sibling);
 	res->name = np->full_name;
 
 	if (res->flags & IORESOURCE_IO) {
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 69bd98421eb1..7482bdfd1959 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -170,8 +170,8 @@ lba_dump_res(struct resource *r, int d)
 	for (i = d; i ; --i) printk(" ");
 	printk(KERN_DEBUG "%p [%lx,%lx]/%lx\n", r,
 		(long)r->start, (long)r->end, r->flags);
-	lba_dump_res(r->child, d+2);
-	lba_dump_res(r->sibling, d);
+	lba_dump_res(resource_first_child(&r->child), d+2);
+	lba_dump_res(resource_sibling(r), d);
 }
 
 
diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 942b64fc7f1f..e3ace20345c7 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -542,14 +542,14 @@ static struct pci_ops vmd_ops = {
 
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
-	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
-	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[2];
+	list_add(&vmd->resources[1].sibling, &vmd->dev->resource[VMD_MEMBAR1].child);
+	list_add(&vmd->resources[2].sibling, &vmd->dev->resource[VMD_MEMBAR2].child);
 }
 
 static void vmd_detach_resources(struct vmd_dev *vmd)
 {
-	vmd->dev->resource[VMD_MEMBAR1].child = NULL;
-	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
+	INIT_LIST_HEAD(&vmd->dev->resource[VMD_MEMBAR1].child);
+	INIT_LIST_HEAD(&vmd->dev->resource[VMD_MEMBAR2].child);
 }
 
 /*
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..9624dd1dfd49 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -59,6 +59,8 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
 	r->res.start = 0;
 	r->res.end = 0xff;
 	r->res.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED;
+	INIT_LIST_HEAD(&r->res.child);
+	INIT_LIST_HEAD(&r->res.sibling);
 
 	list_add_tail(&r->list, &pci_domain_busn_res_list);
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1824e83b4..8e685af8938d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2107,7 +2107,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 				continue;
 
 			/* Ignore BARs which are still in use */
-			if (res->child)
+			if (!list_empty(&res->child))
 				continue;
 
 			ret = add_to_list(&saved, bridge, res, 0, 0);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index dfdcd0bfe54e..b7456ae889dd 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -12,6 +12,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/list.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -22,7 +23,8 @@ struct resource {
 	const char *name;
 	unsigned long flags;
 	unsigned long desc;
-	struct resource *parent, *sibling, *child;
+	struct list_head child, sibling;
+	struct resource *parent;
 };
 
 /*
@@ -216,7 +218,6 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
 	return r1->start <= r2->start && r1->end >= r2->end;
 }
 
-
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
 #define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
@@ -287,6 +288,18 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
        return (r1->start <= r2->end && r1->end >= r2->start);
 }
 
+static inline struct resource *resource_sibling(struct resource *res)
+{
+	if (res->parent && !list_is_last(&res->sibling, &res->parent->child))
+		return list_next_entry(res, sibling);
+	return NULL;
+}
+
+static inline struct resource *resource_first_child(struct list_head *head)
+{
+	return list_first_entry_or_null(head, struct resource, sibling);
+}
+
 
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 5e7c56d5d838..ef9a20b75234 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -31,6 +31,8 @@ struct resource ioport_resource = {
 	.start	= 0,
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
+	.sibling = LIST_HEAD_INIT(ioport_resource.sibling),
+	.child  = LIST_HEAD_INIT(ioport_resource.child),
 };
 EXPORT_SYMBOL(ioport_resource);
 
@@ -39,6 +41,8 @@ struct resource iomem_resource = {
 	.start	= 0,
 	.end	= -1,
 	.flags	= IORESOURCE_MEM,
+	.sibling = LIST_HEAD_INIT(iomem_resource.sibling),
+	.child  = LIST_HEAD_INIT(iomem_resource.child),
 };
 EXPORT_SYMBOL(iomem_resource);
 
@@ -57,20 +61,20 @@ static DEFINE_RWLOCK(resource_lock);
  * by boot mem after the system is up. So for reusing the resource entry
  * we need to remember the resource.
  */
-static struct resource *bootmem_resource_free;
+static struct list_head bootmem_resource_free = LIST_HEAD_INIT(bootmem_resource_free);
 static DEFINE_SPINLOCK(bootmem_resource_lock);
 
 static struct resource *next_resource(struct resource *p, bool sibling_only)
 {
 	/* Caller wants to traverse through siblings only */
 	if (sibling_only)
-		return p->sibling;
+		return resource_sibling(p);
 
-	if (p->child)
-		return p->child;
-	while (!p->sibling && p->parent)
+	if (!list_empty(&p->child))
+		return resource_first_child(&p->child);
+	while (!resource_sibling(p) && p->parent)
 		p = p->parent;
-	return p->sibling;
+	return resource_sibling(p);
 }
 
 static void *r_next(struct seq_file *m, void *v, loff_t *pos)
@@ -90,7 +94,7 @@ static void *r_start(struct seq_file *m, loff_t *pos)
 	struct resource *p = PDE_DATA(file_inode(m->file));
 	loff_t l = 0;
 	read_lock(&resource_lock);
-	for (p = p->child; p && l < *pos; p = r_next(m, p, &l))
+	for (p = resource_first_child(&p->child); p && l < *pos; p = r_next(m, p, &l))
 		;
 	return p;
 }
@@ -153,8 +157,7 @@ static void free_resource(struct resource *res)
 
 	if (!PageSlab(virt_to_head_page(res))) {
 		spin_lock(&bootmem_resource_lock);
-		res->sibling = bootmem_resource_free;
-		bootmem_resource_free = res;
+		list_add(&res->sibling, &bootmem_resource_free);
 		spin_unlock(&bootmem_resource_lock);
 	} else {
 		kfree(res);
@@ -166,10 +169,9 @@ static struct resource *alloc_resource(gfp_t flags)
 	struct resource *res = NULL;
 
 	spin_lock(&bootmem_resource_lock);
-	if (bootmem_resource_free) {
-		res = bootmem_resource_free;
-		bootmem_resource_free = res->sibling;
-	}
+	res = resource_first_child(&bootmem_resource_free);
+	if (res)
+		list_del(&res->sibling);
 	spin_unlock(&bootmem_resource_lock);
 
 	if (res)
@@ -177,6 +179,8 @@ static struct resource *alloc_resource(gfp_t flags)
 	else
 		res = kzalloc(sizeof(struct resource), flags);
 
+	INIT_LIST_HEAD(&res->child);
+	INIT_LIST_HEAD(&res->sibling);
 	return res;
 }
 
@@ -185,7 +189,7 @@ static struct resource * __request_resource(struct resource *root, struct resour
 {
 	resource_size_t start = new->start;
 	resource_size_t end = new->end;
-	struct resource *tmp, **p;
+	struct resource *tmp;
 
 	if (end < start)
 		return root;
@@ -193,64 +197,62 @@ static struct resource * __request_resource(struct resource *root, struct resour
 		return root;
 	if (end > root->end)
 		return root;
-	p = &root->child;
-	for (;;) {
-		tmp = *p;
-		if (!tmp || tmp->start > end) {
-			new->sibling = tmp;
-			*p = new;
+
+	if (list_empty(&root->child)) {
+		list_add(&new->sibling, &root->child);
+		new->parent = root;
+		INIT_LIST_HEAD(&new->child);
+		return NULL;
+	}
+
+	list_for_each_entry(tmp, &root->child, sibling) {
+		if (tmp->start > end) {
+			list_add(&new->sibling, tmp->sibling.prev);
 			new->parent = root;
+			INIT_LIST_HEAD(&new->child);
 			return NULL;
 		}
-		p = &tmp->sibling;
 		if (tmp->end < start)
 			continue;
 		return tmp;
 	}
+
+	list_add_tail(&new->sibling, &root->child);
+	new->parent = root;
+	INIT_LIST_HEAD(&new->child);
+	return NULL;
 }
 
 static int __release_resource(struct resource *old, bool release_child)
 {
-	struct resource *tmp, **p, *chd;
+	struct resource *tmp, *next, *chd;
 
-	p = &old->parent->child;
-	for (;;) {
-		tmp = *p;
-		if (!tmp)
-			break;
+	list_for_each_entry_safe(tmp, next, &old->parent->child, sibling) {
 		if (tmp == old) {
-			if (release_child || !(tmp->child)) {
-				*p = tmp->sibling;
+			if (release_child || list_empty(&tmp->child)) {
+				list_del(&tmp->sibling);
 			} else {
-				for (chd = tmp->child;; chd = chd->sibling) {
+				list_for_each_entry(chd, &tmp->child, sibling)
 					chd->parent = tmp->parent;
-					if (!(chd->sibling))
-						break;
-				}
-				*p = tmp->child;
-				chd->sibling = tmp->sibling;
+				list_splice(&tmp->child, tmp->sibling.prev);
+				list_del(&tmp->sibling);
 			}
+
 			old->parent = NULL;
 			return 0;
 		}
-		p = &tmp->sibling;
 	}
 	return -EINVAL;
 }
 
 static void __release_child_resources(struct resource *r)
 {
-	struct resource *tmp, *p;
+	struct resource *tmp, *next;
 	resource_size_t size;
 
-	p = r->child;
-	r->child = NULL;
-	while (p) {
-		tmp = p;
-		p = p->sibling;
-
+	list_for_each_entry_safe(tmp, next, &r->child, sibling) {
 		tmp->parent = NULL;
-		tmp->sibling = NULL;
+		INIT_LIST_HEAD(&tmp->sibling);
 		__release_child_resources(tmp);
 
 		printk(KERN_DEBUG "release child resource %pR\n", tmp);
@@ -259,6 +261,8 @@ static void __release_child_resources(struct resource *r)
 		tmp->start = 0;
 		tmp->end = size - 1;
 	}
+
+	INIT_LIST_HEAD(&tmp->child);
 }
 
 void release_child_resources(struct resource *r)
@@ -343,7 +347,8 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 
 	read_lock(&resource_lock);
 
-	for (p = iomem_resource.child; p; p = next_resource(p, sibling_only)) {
+	for (p = resource_first_child(&iomem_resource.child); p;
+			p = next_resource(p, sibling_only)) {
 		if ((p->flags & res->flags) != res->flags)
 			continue;
 		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
@@ -532,7 +537,7 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 	struct resource *p;
 
 	read_lock(&resource_lock);
-	for (p = iomem_resource.child; p ; p = p->sibling) {
+	list_for_each_entry(p, &iomem_resource.child, sibling) {
 		bool is_type = (((p->flags & flags) == flags) &&
 				((desc == IORES_DESC_NONE) ||
 				 (desc == p->desc)));
@@ -586,7 +591,7 @@ static int __find_resource(struct resource *root, struct resource *old,
 			 resource_size_t  size,
 			 struct resource_constraint *constraint)
 {
-	struct resource *this = root->child;
+	struct resource *this = resource_first_child(&root->child);
 	struct resource tmp = *new, avail, alloc;
 
 	tmp.start = root->start;
@@ -596,7 +601,7 @@ static int __find_resource(struct resource *root, struct resource *old,
 	 */
 	if (this && this->start == root->start) {
 		tmp.start = (this == old) ? old->start : this->end + 1;
-		this = this->sibling;
+		this = resource_sibling(this);
 	}
 	for(;;) {
 		if (this)
@@ -632,7 +637,7 @@ next:		if (!this || this->end == root->end)
 
 		if (this != old)
 			tmp.start = this->end + 1;
-		this = this->sibling;
+		this = resource_sibling(this);
 	}
 	return -EBUSY;
 }
@@ -676,7 +681,7 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 		goto out;
 	}
 
-	if (old->child) {
+	if (!list_empty(&old->child)) {
 		err = -EBUSY;
 		goto out;
 	}
@@ -757,7 +762,7 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start)
 	struct resource *res;
 
 	read_lock(&resource_lock);
-	for (res = root->child; res; res = res->sibling) {
+	list_for_each_entry(res, &root->child, sibling) {
 		if (res->start == start)
 			break;
 	}
@@ -790,32 +795,27 @@ static struct resource * __insert_resource(struct resource *parent, struct resou
 			break;
 	}
 
-	for (next = first; ; next = next->sibling) {
+	for (next = first; ; next = resource_sibling(next)) {
 		/* Partial overlap? Bad, and unfixable */
 		if (next->start < new->start || next->end > new->end)
 			return next;
-		if (!next->sibling)
+		if (!resource_sibling(next))
 			break;
-		if (next->sibling->start > new->end)
+		if (resource_sibling(next)->start > new->end)
 			break;
 	}
-
 	new->parent = parent;
-	new->sibling = next->sibling;
-	new->child = first;
+	list_add(&new->sibling, &next->sibling);
+	INIT_LIST_HEAD(&new->child);
 
-	next->sibling = NULL;
-	for (next = first; next; next = next->sibling)
+	/*
+	 * From first to next, they all fall into new's region, so change them
+	 * as new's children.
+	 */
+	list_cut_position(&new->child, first->sibling.prev, &next->sibling);
+	list_for_each_entry(next, &new->child, sibling)
 		next->parent = new;
 
-	if (parent->child == first) {
-		parent->child = new;
-	} else {
-		next = parent->child;
-		while (next->sibling != first)
-			next = next->sibling;
-		next->sibling = new;
-	}
 	return NULL;
 }
 
@@ -937,19 +937,17 @@ static int __adjust_resource(struct resource *res, resource_size_t start,
 	if ((start < parent->start) || (end > parent->end))
 		goto out;
 
-	if (res->sibling && (res->sibling->start <= end))
+	if (resource_sibling(res) && (resource_sibling(res)->start <= end))
 		goto out;
 
-	tmp = parent->child;
-	if (tmp != res) {
-		while (tmp->sibling != res)
-			tmp = tmp->sibling;
+	if (res->sibling.prev != &parent->child) {
+		tmp = list_prev_entry(res, sibling);
 		if (start <= tmp->end)
 			goto out;
 	}
 
 skip:
-	for (tmp = res->child; tmp; tmp = tmp->sibling)
+	list_for_each_entry(tmp, &res->child, sibling)
 		if ((tmp->start < start) || (tmp->end > end))
 			goto out;
 
@@ -987,31 +985,33 @@ EXPORT_SYMBOL(adjust_resource);
  * Reparent resource children of pr that conflict with res
  * under res, and make res replace those children.
  */
-static int reparent_resources(struct resource *parent,
-				     struct resource *res)
+int reparent_resources(struct resource *parent, struct resource *res)
 {
-	struct resource *p, **pp;
-	struct resource **firstpp = NULL;
+	struct resource *p, *first = NULL;
 
-	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
+	list_for_each_entry(p, &parent->child, sibling) {
 		if (p->end < res->start)
 			continue;
 		if (res->end < p->start)
 			break;
 		if (p->start < res->start || p->end > res->end)
 			return -1;	/* not completely contained */
-		if (firstpp == NULL)
-			firstpp = pp;
+		if (first == NULL)
+			first = p;
 	}
-	if (firstpp == NULL)
+	if (first == NULL)
 		return -1;	/* didn't find any conflicting entries? */
 	res->parent = parent;
-	res->child = *firstpp;
-	res->sibling = *pp;
-	*firstpp = res;
-	*pp = NULL;
-	for (p = res->child; p != NULL; p = p->sibling) {
-		p->parent = res;
+	list_add(&res->sibling, &p->sibling.prev);
+	INIT_LIST_HEAD(&res->child);
+
+	/*
+	 * From first to p's previous sibling, they all fall into
+	 * res's region, change them as res's children.
+	 */
+	list_cut_position(&res->child, first->sibling.prev, res->sibling.prev);
+	list_for_each_entry(p, &new->child, sibling) {
+                p->parent = new;
 		pr_debug("PCI: Reparented %s %pR under %s\n",
 			 p->name, p, res->name);
 	}
@@ -1210,34 +1210,32 @@ EXPORT_SYMBOL(__request_region);
 void __release_region(struct resource *parent, resource_size_t start,
 			resource_size_t n)
 {
-	struct resource **p;
+	struct resource *res;
 	resource_size_t end;
 
-	p = &parent->child;
+	res = resource_first_child(&parent->child);
 	end = start + n - 1;
 
 	write_lock(&resource_lock);
 
 	for (;;) {
-		struct resource *res = *p;
-
 		if (!res)
 			break;
 		if (res->start <= start && res->end >= end) {
 			if (!(res->flags & IORESOURCE_BUSY)) {
-				p = &res->child;
+				res = resource_first_child(&res->child);
 				continue;
 			}
 			if (res->start != start || res->end != end)
 				break;
-			*p = res->sibling;
+			list_del(&res->sibling);
 			write_unlock(&resource_lock);
 			if (res->flags & IORESOURCE_MUXED)
 				wake_up(&muxed_resource_wait);
 			free_resource(res);
 			return;
 		}
-		p = &res->sibling;
+		res = resource_sibling(res);
 	}
 
 	write_unlock(&resource_lock);
@@ -1272,9 +1270,7 @@ EXPORT_SYMBOL(__release_region);
 int release_mem_region_adjustable(struct resource *parent,
 			resource_size_t start, resource_size_t size)
 {
-	struct resource **p;
-	struct resource *res;
-	struct resource *new_res;
+	struct resource *res, *new_res;
 	resource_size_t end;
 	int ret = -EINVAL;
 
@@ -1285,16 +1281,16 @@ int release_mem_region_adjustable(struct resource *parent,
 	/* The alloc_resource() result gets checked later */
 	new_res = alloc_resource(GFP_KERNEL);
 
-	p = &parent->child;
+	res = resource_first_child(&parent->child);
 	write_lock(&resource_lock);
 
-	while ((res = *p)) {
+	while ((res)) {
 		if (res->start >= end)
 			break;
 
 		/* look for the next resource if it does not fit into */
 		if (res->start > start || res->end < end) {
-			p = &res->sibling;
+			res = resource_sibling(res);
 			continue;
 		}
 
@@ -1302,14 +1298,14 @@ int release_mem_region_adjustable(struct resource *parent,
 			break;
 
 		if (!(res->flags & IORESOURCE_BUSY)) {
-			p = &res->child;
+			res = resource_first_child(&res->child);
 			continue;
 		}
 
 		/* found the target resource; let's adjust accordingly */
 		if (res->start == start && res->end == end) {
 			/* free the whole entry */
-			*p = res->sibling;
+			list_del(&res->sibling);
 			free_resource(res);
 			ret = 0;
 		} else if (res->start == start && res->end != end) {
@@ -1332,14 +1328,13 @@ int release_mem_region_adjustable(struct resource *parent,
 			new_res->flags = res->flags;
 			new_res->desc = res->desc;
 			new_res->parent = res->parent;
-			new_res->sibling = res->sibling;
-			new_res->child = NULL;
+			INIT_LIST_HEAD(&new_res->child);
 
 			ret = __adjust_resource(res, res->start,
 						start - res->start);
 			if (ret)
 				break;
-			res->sibling = new_res;
+			list_add(&new_res->sibling, &res->sibling);
 			new_res = NULL;
 		}
 
@@ -1520,7 +1515,7 @@ static int __init reserve_setup(char *str)
 			res->end = io_start + io_num - 1;
 			res->flags |= IORESOURCE_BUSY;
 			res->desc = IORES_DESC_NONE;
-			res->child = NULL;
+			INIT_LIST_HEAD(&res->child);
 			if (request_resource(parent, res) == 0)
 				reserved = x+1;
 		}
@@ -1540,7 +1535,7 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 	loff_t l;
 
 	read_lock(&resource_lock);
-	for (p = p->child; p ; p = r_next(NULL, p, &l)) {
+	for (p = resource_first_child(&p->child); p; p = r_next(NULL, p, &l)) {
 		/*
 		 * We can probably skip the resources without
 		 * IORESOURCE_IO attribute?
@@ -1596,7 +1591,7 @@ bool iomem_is_exclusive(u64 addr)
 	addr = addr & PAGE_MASK;
 
 	read_lock(&resource_lock);
-	for (p = p->child; p ; p = r_next(NULL, p, &l)) {
+	for (p = resource_first_child(&p->child); p; p = r_next(NULL, p, &l)) {
 		/*
 		 * We can probably skip the resources without
 		 * IORESOURCE_IO attribute?
-- 
2.13.6
