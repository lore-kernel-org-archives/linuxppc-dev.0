Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwfq3hcgzDqxC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:49:39 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mhairgrove@nvidia.com, shailendras@nvidia.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 3/3] powerpc/powernv: Introduce address translation services
 for Nvlink2
Date: Wed, 22 Mar 2017 14:49:33 +1100
Message-Id: <1490154573-22475-3-git-send-email-alistair@popple.id.au>
In-Reply-To: <1490154573-22475-1-git-send-email-alistair@popple.id.au>
References: <1490154573-22475-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nvlink2 supports address translation services (ATS) allowing devices
to request address translations from an mmu known as the nest MMU
which is setup to walk the CPU page tables.

To access this functionality certain firmware calls are required to
setup and manage hardware context tables in the nvlink processing unit
(NPU). The NPU also manages forwarding of TLB invalidates (known as
address translation shootdowns/ATSDs) to attached devices.

This patch exports several methods to allow device drivers to register
a process id (PASID/PID) in the hardware tables and to receive
notification of when a device should stop issuing address translation
requests (ATRs). It also adds a fault handler to allow device drivers
to demand fault pages in.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h       |   6 +
 arch/powerpc/include/asm/opal-api.h            |   5 +-
 arch/powerpc/include/asm/opal.h                |   5 +
 arch/powerpc/include/asm/tlb.h                 |  10 +-
 arch/powerpc/mm/mmu_context_book3s64.c         |   1 +
 arch/powerpc/platforms/powernv/npu-dma.c       | 427 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   3 +
 arch/powerpc/platforms/powernv/pci-ioda.c      |   2 +
 arch/powerpc/platforms/powernv/pci.h           |  25 +-
 9 files changed, 480 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 805d4105..1676ec8 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -73,10 +73,16 @@ extern struct patb_entry *partition_tb;
 typedef unsigned long mm_context_id_t;
 struct spinlock;
 
+/* Maximum possible number of NPUs in a system. */
+#define NV_MAX_NPUS 8
+
 typedef struct {
 	mm_context_id_t id;
 	u16 user_psize;		/* page size index */
 
+	/* NPU NMMU context */
+	struct npu_context *npu_context;
+
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 low_slices_psize;	/* SLB page size encodings */
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index a0aa285..a599a2c 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -168,7 +168,10 @@
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
 #define OPAL_NMMU_SET_PTCR			127
-#define OPAL_LAST				127
+#define OPAL_NPU_INIT_CONTEXT			146
+#define OPAL_NPU_DESTROY_CONTEXT		147
+#define OPAL_NPU_MAP_LPAR			148
+#define OPAL_LAST				148
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 1ff03a6..b3b97c4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -29,6 +29,11 @@ extern struct device_node *opal_node;
 
 /* API functions */
 int64_t opal_invalid_call(void);
+int64_t opal_npu_destroy_context(uint64_t phb_id, uint64_t pid, uint64_t bdf);
+int64_t opal_npu_init_context(uint64_t phb_id, int pasid, uint64_t msr,
+			uint64_t bdf);
+int64_t opal_npu_map_lpar(uint64_t phb_id, uint64_t bdf, uint64_t lparid,
+			uint64_t lpcr);
 int64_t opal_console_write(int64_t term_number, __be64 *length,
 			   const uint8_t *buffer);
 int64_t opal_console_read(int64_t term_number, __be64 *length,
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 6095575..fc61fca 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -63,15 +63,21 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 }
 
 #ifdef CONFIG_SMP
+/* If there is an NPU context associated with this thread it may have
+ * been active on a GPU which has issued translation requests via the
+ * nest mmu. In this case we need to do a broadcast tlb to invalidate
+ * any caches on the nest mmu. Invalidations on the GPU are handled
+ * via mmu notfiers.
+ */
 static inline int mm_is_core_local(struct mm_struct *mm)
 {
-	return cpumask_subset(mm_cpumask(mm),
+	return !mm->context.npu_context && cpumask_subset(mm_cpumask(mm),
 			      topology_sibling_cpumask(smp_processor_id()));
 }
 
 static inline int mm_is_thread_local(struct mm_struct *mm)
 {
-	return cpumask_equal(mm_cpumask(mm),
+	return !mm->context.npu_context && cpumask_equal(mm_cpumask(mm),
 			      cpumask_of(smp_processor_id()));
 }
 
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 73bf6e1..eb317f1 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -67,6 +67,7 @@ static int radix__init_new_context(struct mm_struct *mm, int index)
 	 */
 	rts_field = radix__get_tree_size();
 	process_tb[index].prtb0 = cpu_to_be64(rts_field | __pa(mm->pgd) | RADIX_PGD_INDEX_SIZE);
+	mm->context.npu_context = NULL;
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 050bd5d..369a3d7 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -9,11 +9,18 @@
  * License as published by the Free Software Foundation.
  */
 
+#include <linux/slab.h>
+#include <linux/mmu_notifier.h>
+#include <linux/mmu_context.h>
+#include <linux/of.h>
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/memblock.h>
 #include <linux/iommu.h>
 
+#include <asm/reg.h>
+#include <asm/opal.h>
+#include <asm/io.h>
 #include <asm/iommu.h>
 #include <asm/pnv-pci.h>
 #include <asm/msi_bitmap.h>
@@ -22,6 +29,8 @@
 #include "powernv.h"
 #include "pci.h"
 
+#define npu_to_phb(x) container_of(x, struct pnv_phb, npu)
+
 /*
  * Other types of TCE cache invalidation are not functional in the
  * hardware.
@@ -371,3 +380,421 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 
 	return gpe;
 }
+
+/* Maximum number of nvlinks per npu */
+#define NV_MAX_LINKS 6
+
+/* Maximum index of npu2 hosts in the system. Always < NV_MAX_NPUS */
+static int max_npu2_index;
+
+struct npu_context {
+	struct mm_struct *mm;
+	struct pci_dev *npdev[NV_MAX_NPUS][NV_MAX_LINKS];
+	struct mmu_notifier mn;
+	struct kref kref;
+
+	/* Callback to stop translation requests on a given gpu */
+	struct npu_context *(*release_cb)(struct npu_context *, void *);
+
+	/* Private pointer passed to the above callback for usage by
+	 * device drivers
+	 */
+	void *priv;
+};
+
+/*
+ * Find a free MMIO ATSD register and mark it in use. Return -ENOSPC
+ * if none are available.
+ */
+static int get_mmio_atsd_reg(struct npu *npu)
+{
+	int i;
+
+	for (i = 0; i < npu->mmio_atsd_count; i++) {
+		if (!test_and_set_bit(i, &npu->mmio_atsd_usage))
+			return i;
+	}
+
+	return -ENOSPC;
+}
+
+static void put_mmio_atsd_reg(struct npu *npu, int reg)
+{
+	clear_bit(reg, &npu->mmio_atsd_usage);
+}
+
+/* MMIO ATSD register offsets */
+#define XTS_ATSD_AVA  1
+#define XTS_ATSD_STAT 2
+
+static int mmio_launch_invalidate(struct npu *npu, unsigned long launch,
+				unsigned long va)
+{
+	int mmio_atsd_reg;
+
+	do {
+		mmio_atsd_reg = get_mmio_atsd_reg(npu);
+		cpu_relax();
+	} while (mmio_atsd_reg < 0);
+
+	__raw_writeq(cpu_to_be64(va),
+		npu->mmio_atsd_regs[mmio_atsd_reg] + XTS_ATSD_AVA);
+	eieio();
+	__raw_writeq(cpu_to_be64(launch), npu->mmio_atsd_regs[mmio_atsd_reg]);
+
+	return mmio_atsd_reg;
+}
+
+static int mmio_invalidate_pid(struct npu *npu, unsigned long pid)
+{
+	unsigned long launch;
+
+	/* IS set to invalidate matching PID */
+	launch = PPC_BIT(12);
+
+	/* PRS set to process-scoped */
+	launch |= PPC_BIT(13);
+
+	/* AP */
+	launch |= (u64) mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
+
+	/* PID */
+	launch |= pid << PPC_BITLSHIFT(38);
+
+	/* Invalidating the entire process doesn't use a va */
+	return mmio_launch_invalidate(npu, launch, 0);
+}
+
+static int mmio_invalidate_va(struct npu *npu, unsigned long va,
+			unsigned long pid)
+{
+	unsigned long launch;
+
+	/* IS set to invalidate target VA */
+	launch = 0;
+
+	/* PRS set to process scoped */
+	launch |= PPC_BIT(13);
+
+	/* AP */
+	launch |= (u64) mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
+
+	/* PID */
+	launch |= pid << PPC_BITLSHIFT(38);
+
+	return mmio_launch_invalidate(npu, launch, va);
+}
+
+#define mn_to_npu_context(x) container_of(x, struct npu_context, mn)
+
+/* Invalidate either a single address or an entire PID depending on
+ * the value of va.
+ */
+static void mmio_invalidate(struct npu_context *npu_context, int va,
+			unsigned long address)
+{
+	int i, j, reg;
+	struct npu *npu;
+	struct pnv_phb *nphb;
+	struct pci_dev *npdev;
+	struct {
+		struct npu *npu;
+		int reg;
+	} mmio_atsd_reg[NV_MAX_NPUS];
+	unsigned long pid = npu_context->mm->context.id;
+
+	/* Loop over all the NPUs this process is active on and launch
+	 * an invalidate.
+	 */
+	for (i = 0; i <= max_npu2_index; i++) {
+		mmio_atsd_reg[i].reg = -1;
+		for (j = 0; j < NV_MAX_LINKS; j++) {
+			npdev = npu_context->npdev[i][j];
+			if (!npdev)
+				continue;
+
+			nphb = pci_bus_to_host(npdev->bus)->private_data;
+			npu = &nphb->npu;
+			mmio_atsd_reg[i].npu = npu;
+
+			if (va)
+				mmio_atsd_reg[i].reg =
+					mmio_invalidate_va(npu, address, pid);
+			else
+				mmio_atsd_reg[i].reg =
+					mmio_invalidate_pid(npu, pid);
+
+			/* The NPU hardware forwards the shootdown to
+			 * all GPUs so we only have to launch one
+			 * shootdown per NPU.
+			 */
+			break;
+		}
+	}
+
+	/* Wait for all invalidations to complete */
+	for (i = 0; i <= max_npu2_index; i++) {
+		if (mmio_atsd_reg[i].reg < 0)
+			continue;
+
+		/* Wait for completion */
+		npu = mmio_atsd_reg[i].npu;
+		reg = mmio_atsd_reg[i].reg;
+		while (__raw_readq(npu->mmio_atsd_regs[reg] + XTS_ATSD_STAT))
+			cpu_relax();
+		put_mmio_atsd_reg(npu, reg);
+	}
+}
+
+static void pnv_npu2_mn_release(struct mmu_notifier *mn,
+				struct mm_struct *mm)
+{
+	struct npu_context *npu_context = mn_to_npu_context(mn);
+
+	/* Call into device driver to stop requests to the NMMU */
+	if (npu_context->release_cb)
+		npu_context->release_cb(npu_context, npu_context->priv);
+
+	/* There should be no more translation requests for this PID,
+	 * but we need to ensure any entries for it are removed from
+	 * the TLB.
+	 */
+	mmio_invalidate(npu_context, 0, 0);
+}
+
+static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
+				struct mm_struct *mm,
+				unsigned long address,
+				pte_t pte)
+{
+	struct npu_context *npu_context = mn_to_npu_context(mn);
+
+	mmio_invalidate(npu_context, 1, address);
+}
+
+static void pnv_npu2_mn_invalidate_page(struct mmu_notifier *mn,
+					struct mm_struct *mm,
+					unsigned long address)
+{
+	struct npu_context *npu_context = mn_to_npu_context(mn);
+
+	mmio_invalidate(npu_context, 1, address);
+}
+
+static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
+					struct mm_struct *mm,
+					unsigned long start, unsigned long end)
+{
+	struct npu_context *npu_context = mn_to_npu_context(mn);
+	unsigned long address;
+
+	for (address = start; address <= end; address += PAGE_SIZE)
+		mmio_invalidate(npu_context, 1, address);
+}
+
+static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
+	.release = pnv_npu2_mn_release,
+	.change_pte = pnv_npu2_mn_change_pte,
+	.invalidate_page = pnv_npu2_mn_invalidate_page,
+	.invalidate_range = pnv_npu2_mn_invalidate_range,
+};
+
+/*
+ * Call into OPAL to setup the nmmu context for the current task in
+ * the NPU. This must be called to setup the context tables before the
+ * GPU issues ATRs. pdev should be a pointed to PCIe GPU device.
+ *
+ * A release callback should be registered to allow a device driver to
+ * be notified that it should not launch any new translation requests
+ * as the final TLB invalidate is about to occur.
+ *
+ * Returns an error if there no contexts are currently available or a
+ * npu_context which should be passed to pnv_npu2_handle_fault().
+ *
+ * mmap_sem must be held in write mode.
+ */
+struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
+			unsigned long flags,
+			struct npu_context *(*cb)(struct npu_context *, void *),
+			void *priv)
+{
+	int rc;
+	u32 nvlink_index;
+	struct device_node *nvlink_dn;
+	struct mm_struct *mm = current->mm;
+	struct pnv_phb *nphb;
+	struct npu *npu;
+	struct npu_context *npu_context;
+
+	/* At present we don't support gpus connected to multiple NPUs
+	 * and I'm not sure the hardware does either.
+	 */
+	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
+
+	if (!npdev)
+		/* No nvlink associated with this GPU device */
+		return ERR_PTR(-ENODEV);
+
+	if (!mm) {
+		/* kernel thread contexts are not supported */
+		return ERR_PTR(-EINVAL);
+	}
+
+	nphb = pci_bus_to_host(npdev->bus)->private_data;
+	npu = &nphb->npu;
+
+	/* Setup the NPU context table for a particular GPU. These
+	 * need to be per-GPU as we need the tables to filter ATSDs
+	 * when there are no active contexts on a particular GPU.
+	 */
+	rc = opal_npu_init_context(nphb->opal_id, mm->context.id, flags,
+				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+	if (rc < 0)
+		return ERR_PTR(-ENOSPC);
+
+	/* We store the npu pci device so we can more easily get at
+	 * the associated npus.
+	 */
+	npu_context = mm->context.npu_context;
+	if (!npu_context) {
+		npu_context = kzalloc(sizeof(struct npu_context), GFP_KERNEL);
+		if (!npu_context)
+			return ERR_PTR(-ENOMEM);
+
+		mm->context.npu_context = npu_context;
+		npu_context->mm = mm;
+		npu_context->mn.ops = &nv_nmmu_notifier_ops;
+		__mmu_notifier_register(&npu_context->mn, mm);
+		kref_init(&npu_context->kref);
+	} else {
+		kref_get(&npu_context->kref);
+	}
+
+	npu_context->release_cb = cb;
+	npu_context->priv = priv;
+	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
+	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
+							&nvlink_index)))
+		return ERR_PTR(-ENODEV);
+	npu_context->npdev[npu->index][nvlink_index] = npdev;
+
+	return npu_context;
+}
+EXPORT_SYMBOL(pnv_npu2_init_context);
+
+static void pnv_npu2_release_context(struct kref *kref)
+{
+	struct npu_context *npu_context =
+		container_of(kref, struct npu_context, kref);
+
+	npu_context->mm->context.npu_context = NULL;
+	mmu_notifier_unregister(&npu_context->mn,
+				npu_context->mm);
+
+	kfree(npu_context);
+}
+
+void pnv_npu2_destroy_context(struct npu_context *npu_context,
+			struct pci_dev *gpdev)
+{
+	struct pnv_phb *nphb, *phb;
+	struct npu *npu;
+	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
+	struct device_node *nvlink_dn;
+	u32 nvlink_index;
+
+	if (WARN_ON(!npdev))
+		return;
+
+	nphb = pci_bus_to_host(npdev->bus)->private_data;
+	npu = &nphb->npu;
+	phb = pci_bus_to_host(gpdev->bus)->private_data;
+	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
+	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
+							&nvlink_index)))
+		return;
+	npu_context->npdev[npu->index][nvlink_index] = NULL;
+	opal_npu_destroy_context(phb->opal_id, npu_context->mm->context.id,
+				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+	kref_put(&npu_context->kref, pnv_npu2_release_context);
+}
+EXPORT_SYMBOL(pnv_npu2_destroy_context);
+
+/*
+ * Assumes mmap_sem is held for the contexts associated mm.
+ */
+int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
+			unsigned long *flags, unsigned long *status, int count)
+{
+	u64 rc = 0, result = 0;
+	int i, is_write;
+	struct page *page[1];
+
+	/* mmap_sem should be held so the struct_mm must be present */
+	struct mm_struct *mm = context->mm;
+
+	WARN_ON(!rwsem_is_locked(&mm->mmap_sem));
+
+	for (i = 0; i < count; i++) {
+		is_write = flags[i] & NPU2_WRITE;
+		rc = get_user_pages_remote(NULL, mm, ea[i], 1,
+					is_write ? FOLL_WRITE : 0,
+					page, NULL, NULL);
+
+		/* To support virtualised environments we will have to
+		 * do an access to the page to ensure it gets faulted
+		 * into the hypervisor. For the moment virtualisation
+		 * is not supported in other areas so leave the access
+		 * out.
+		 */
+		if (rc != 1) {
+			status[i] = rc;
+			result = -EFAULT;
+			continue;
+		}
+
+		status[i] = 0;
+		put_page(page[0]);
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(pnv_npu2_handle_fault);
+
+int pnv_npu2_init(struct pnv_phb *phb)
+{
+	unsigned int i;
+	u64 mmio_atsd;
+	struct device_node *dn;
+	struct pci_dev *gpdev;
+	static int npu_index;
+	uint64_t rc = 0;
+
+	for_each_child_of_node(phb->hose->dn, dn) {
+		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
+		if (gpdev) {
+			rc = opal_npu_map_lpar(phb->opal_id,
+				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
+				0, 0);
+			if (rc)
+				dev_err(&gpdev->dev,
+					"Error %lld mapping device to LPAR\n",
+					rc);
+		}
+	}
+
+	for (i = 0; !of_property_read_u64_index(phb->hose->dn, "ibm,mmio-atsd",
+							i, &mmio_atsd); i++)
+		phb->npu.mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
+
+	pr_info("NPU%lld: Found %d MMIO ATSD registers", phb->opal_id, i);
+	phb->npu.mmio_atsd_count = i;
+	phb->npu.mmio_atsd_usage = 0;
+	npu_index++;
+	if (WARN_ON(npu_index >= NV_MAX_NPUS))
+		return -ENOSPC;
+	max_npu2_index = npu_index;
+	phb->npu.index = npu_index;
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 6693f75..f7b2c74 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -301,3 +301,6 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
+OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
+OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
+OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6901a06..04a88dc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1262,6 +1262,8 @@ static void pnv_pci_ioda_setup_PEs(void)
 			/* PE#0 is needed for error reporting */
 			pnv_ioda_reserve_pe(phb, 0);
 			pnv_ioda_setup_npu_PEs(hose->bus);
+			if (phb->model == PNV_PHB_MODEL_NPU2)
+				pnv_npu2_init(phb);
 		}
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index e1d3e55..bbf32f2 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -7,6 +7,9 @@
 
 struct pci_dn;
 
+/* Maximum possible number of ATSD MMIO registers per NPU */
+#define NV_NMMU_ATSD_REGS 8
+
 enum pnv_phb_type {
 	PNV_PHB_IODA1	= 0,
 	PNV_PHB_IODA2	= 1,
@@ -174,6 +177,16 @@ struct pnv_phb {
 		struct OpalIoP7IOCErrorData 	hub_diag;
 	} diag;
 
+	/* Nvlink2 data */
+	struct npu {
+		int index;
+		__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
+		unsigned int mmio_atsd_count;
+
+		/* Bitmask for MMIO register usage */
+		unsigned long mmio_atsd_usage;
+	} npu;
+
 #ifdef CONFIG_CXL_BASE
 	struct cxl_afu *cxl_afu;
 #endif
@@ -228,6 +241,7 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
 
 /* Nvlink functions */
+#define NPU2_WRITE 1
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
@@ -236,7 +250,16 @@ extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
 extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
 extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
-
+extern struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
+			unsigned long flags,
+			struct npu_context *(*cb)(struct npu_context *, void *),
+			void *priv);
+extern void pnv_npu2_destroy_context(struct npu_context *context,
+				struct pci_dev *gpdev);
+extern int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
+				unsigned long *flags, unsigned long *status,
+				int count);
+extern int pnv_npu2_init(struct pnv_phb *phb);
 
 /* cxl functions */
 extern bool pnv_cxl_enable_device_hook(struct pci_dev *dev);
-- 
2.1.4
