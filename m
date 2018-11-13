Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0CBC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 09:17:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D970E20868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 09:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D970E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vMT85cDJzF3DW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 20:17:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42vLRC6tCjzF3Km
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:30:15 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id C151BAE80490;
 Tue, 13 Nov 2018 03:29:41 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 22/22] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] [10de:1db1] subdriver
Date: Tue, 13 Nov 2018 19:28:23 +1100
Message-Id: <20181113082823.2440-23-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113082823.2440-1-aik@ozlabs.ru>
References: <20181113082823.2440-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
pluggable PCIe devices but implement PCIe links for config space and MMIO.
In addition to that the GPUs are interconnected to each other and also
have direct links to the P9 CPU. The links are NVLink2 and provide direct
access to the system RAM for GPUs via NPU (an NVLink2 "proxy" on P9 chip).
These systems also support ATS (address translation services) which is
a part of the NVLink2 protocol. Such GPUs also share on-board RAM
(16GB in tested config) to the system via the same NVLink2 so a CPU has
cache-coherent access to a GPU RAM.

This exports GPU RAM to the userspace as a new PCI region. This
preregisters the new memory as device memory as it might be used for DMA.
This inserts pfns from the fault handler as the GPU memory is not onlined
until the NVIDIA driver is loaded and trained the links so doing this
earlier produces low level errors which we fence in the firmware so
it does not hurt the host system but still better to avoid.

This exports ATSD (Address Translation Shootdown) register of NPU which
allows the guest to invalidate TLB. The register conveniently occupies
a single 64k page. Since NPU maps the GPU memory, it has a "tgt" property
(which is an abbreviated host system bus address) and tells the GPU its
own system address. This exports the "tgt" as a capability to let
the guest driver conglomerate the routing information so each GPU knows
how to get directly to the other GPUs. This also adds the "tgt" capability
to a GPU to allow the userspace to find out the NVLinks corresponding
to a specific GPU.

For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
know LPID (a logical partition ID or a KVM guest hardware ID in other
words) and PID (a memory context ID of a userspace process, not to be
confused with a linux pid). This assigns a GPU to LPID in the NPU and
this is why this adds a listener for KVM on an IOMMU group. A PID comes
via NVLink from a GPU and NPU uses a PID wildcard to pass it through.

This requires coherent memory and ATSD to be available on the host as
the GPU vendor only supports configurations with both features enabled
and other configurations are known not to work. Because of this and
because of the ways the features are advertised to the host system
(which is a device tree with very platform specific properties),
this requires enabled POWERNV platform.

This hardcodes the NVLink2 support for specific vendor and device IDs
as there is no reliable way of knowing about coherent memory and ATS
support. The GPU has an unique vendor PCIe capability 0x23 but it was
confirmed that it does not provide required information (and it is still
undisclosed what it actually does).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* reworded the commit log about tgt
* added tracepoints (do we want them enabled for entire vfio-pci?)
* added code comments
* added write|mmap flags to the new regions
* auto enabled VFIO_PCI_NVLINK2 config option
* added 'tgt' capability to a GPU so QEMU can recreate ibm,npu and ibm,gpu
references; there are required by the NVIDIA driver
* keep notifier registered only for short time
---
 drivers/vfio/pci/Makefile           |   1 +
 drivers/vfio/pci/trace.h            | 102 +++++++
 drivers/vfio/pci/vfio_pci_private.h |   2 +
 include/uapi/linux/vfio.h           |  26 ++
 drivers/vfio/pci/vfio_pci.c         |  39 ++-
 drivers/vfio/pci/vfio_pci_nvlink2.c | 433 ++++++++++++++++++++++++++++
 drivers/vfio/pci/Kconfig            |   6 +
 7 files changed, 607 insertions(+), 2 deletions(-)
 create mode 100644 drivers/vfio/pci/trace.h
 create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c

diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 76d8ec0..9662c06 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -1,5 +1,6 @@
 
 vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
+vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
 
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
new file mode 100644
index 0000000..b80d2d3
--- /dev/null
+++ b/drivers/vfio/pci/trace.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * VFIO PCI mmap/mmap_fault tracepoints
+ *
+ * Copyright (C) 2018 IBM Corp.  All rights reserved.
+ *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vfio_pci
+
+#if !defined(_TRACE_VFIO_PCI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_VFIO_PCI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(vfio_pci_nvgpu_mmap_fault,
+	TP_PROTO(struct pci_dev *pdev, unsigned long hpa, unsigned long ua,
+			vm_fault_t ret),
+	TP_ARGS(pdev, hpa, ua, ret),
+
+	TP_STRUCT__entry(
+		__field(const char *, name)
+		__field(unsigned long, hpa)
+		__field(unsigned long, ua)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->name = dev_name(&pdev->dev),
+		__entry->hpa = hpa;
+		__entry->ua = ua;
+		__entry->ret = ret;
+	),
+
+	TP_printk("%s: %lx -> %lx ret=%d", __entry->name, __entry->hpa,
+			__entry->ua, __entry->ret)
+);
+
+TRACE_EVENT(vfio_pci_nvgpu_mmap,
+	TP_PROTO(struct pci_dev *pdev, unsigned long hpa, unsigned long ua,
+			unsigned long size, int ret),
+	TP_ARGS(pdev, hpa, ua, size, ret),
+
+	TP_STRUCT__entry(
+		__field(const char *, name)
+		__field(unsigned long, hpa)
+		__field(unsigned long, ua)
+		__field(unsigned long, size)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->name = dev_name(&pdev->dev),
+		__entry->hpa = hpa;
+		__entry->ua = ua;
+		__entry->size = size;
+		__entry->ret = ret;
+	),
+
+	TP_printk("%s: %lx -> %lx size=%lx ret=%d", __entry->name, __entry->hpa,
+			__entry->ua, __entry->size, __entry->ret)
+);
+
+TRACE_EVENT(vfio_pci_npu2_mmap,
+	TP_PROTO(struct pci_dev *pdev, unsigned long hpa, unsigned long ua,
+			unsigned long size, int ret),
+	TP_ARGS(pdev, hpa, ua, size, ret),
+
+	TP_STRUCT__entry(
+		__field(const char *, name)
+		__field(unsigned long, hpa)
+		__field(unsigned long, ua)
+		__field(unsigned long, size)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->name = dev_name(&pdev->dev),
+		__entry->hpa = hpa;
+		__entry->ua = ua;
+		__entry->size = size;
+		__entry->ret = ret;
+	),
+
+	TP_printk("%s: %lx -> %lx size=%lx ret=%d", __entry->name, __entry->hpa,
+			__entry->ua, __entry->size, __entry->ret)
+);
+
+#endif /* _TRACE_SUBSYS_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 93c1738..7639241 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -163,4 +163,6 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
 	return -ENODEV;
 }
 #endif
+extern int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev);
+extern int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev);
 #endif /* VFIO_PCI_PRIVATE_H */
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8131028..53a4061 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -353,6 +353,20 @@ struct vfio_region_gfx_edid {
 #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
 };
 
+/* 10de vendor sub-type
+ *
+ * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address space.
+ */
+#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
+
+/*
+ * 1014 vendor sub-type
+ *
+ * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
+ * to do TLB invalidation on a GPU.
+ */
+#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
@@ -363,6 +377,18 @@ struct vfio_region_gfx_edid {
  */
 #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
 
+/*
+ * Capability with compressed real address (aka SSA - small system address)
+ * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
+ */
+#define VFIO_REGION_INFO_CAP_NPU2		4
+
+struct vfio_region_info_cap_npu2 {
+	struct vfio_info_cap_header header;
+	__u64 tgt;
+	/* size is defined in VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM */
+};
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 6cb70cf..f072d8e 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -224,6 +224,16 @@ static bool vfio_pci_nointx(struct pci_dev *pdev)
 	return false;
 }
 
+int __weak vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
+{
+	return -ENODEV;
+}
+
+int __weak vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
+{
+	return -ENODEV;
+}
+
 static int vfio_pci_enable(struct vfio_pci_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -302,14 +312,39 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 		if (ret) {
 			dev_warn(&vdev->pdev->dev,
 				 "Failed to setup Intel IGD regions\n");
-			vfio_pci_disable(vdev);
-			return ret;
+			goto disable_exit;
+		}
+	}
+
+	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
+	    pdev->device == 0x1db1 &&
+	    IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2)) {
+		ret = vfio_pci_nvdia_v100_nvlink2_init(vdev);
+		if (ret) {
+			dev_warn(&vdev->pdev->dev,
+				 "Failed to setup NVIDIA NV2 RAM region\n");
+			goto disable_exit;
+		}
+	}
+
+	if (pdev->vendor == PCI_VENDOR_ID_IBM &&
+	    pdev->device == 0x04ea &&
+	    IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2)) {
+		ret = vfio_pci_ibm_npu2_init(vdev);
+		if (ret) {
+			dev_warn(&vdev->pdev->dev,
+					"Failed to setup NVIDIA NV2 ATSD region\n");
+			goto disable_exit;
 		}
 	}
 
 	vfio_pci_probe_mmaps(vdev);
 
 	return 0;
+
+disable_exit:
+	vfio_pci_disable(vdev);
+	return ret;
 }
 
 static void vfio_pci_disable(struct vfio_pci_device *vdev)
diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
new file mode 100644
index 0000000..300159b
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VFIO PCI NVIDIA Whitherspoon GPU support a.k.a. NVLink2.
+ *
+ * Copyright (C) 2018 IBM Corp.  All rights reserved.
+ *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Register an on-GPU RAM region for cacheable access.
+ *
+ * Derived from original vfio_pci_igd.c:
+ * Copyright (C) 2016 Red Hat, Inc.  All rights reserved.
+ *	Author: Alex Williamson <alex.williamson@redhat.com>
+ */
+
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/uaccess.h>
+#include <linux/vfio.h>
+#include <linux/sched/mm.h>
+#include <linux/mmu_context.h>
+#include <asm/kvm_ppc.h>
+#include "vfio_pci_private.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(vfio_pci_nvgpu_mmap_fault);
+EXPORT_TRACEPOINT_SYMBOL_GPL(vfio_pci_nvgpu_mmap);
+EXPORT_TRACEPOINT_SYMBOL_GPL(vfio_pci_npu2_mmap);
+
+struct vfio_pci_nvgpu_data {
+	unsigned long gpu_hpa; /* GPU RAM physical address */
+	unsigned long gpu_tgt; /* TGT address of corresponding GPU RAM */
+	unsigned long useraddr; /* GPU RAM userspace address */
+	unsigned long size; /* Size of the GPU RAM window (usually 128GB) */
+	void *base; /* GPU RAM virtual address, for emulated access */
+	struct mm_struct *mm;
+	struct mm_iommu_table_group_mem_t *mem; /* Pre-registered RAM descr. */
+	struct pci_dev *gpdev;
+	struct notifier_block group_notifier;
+};
+
+static size_t vfio_pci_nvgpu_rw(struct vfio_pci_device *vdev,
+		char __user *buf, size_t count, loff_t *ppos, bool iswrite)
+{
+	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
+	struct vfio_pci_nvgpu_data *data = vdev->region[i].data;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+
+	if (pos >= vdev->region[i].size)
+		return -EINVAL;
+
+	count = min(count, (size_t)(vdev->region[i].size - pos));
+
+	if (iswrite) {
+		if (copy_from_user(data->base + pos, buf, count))
+			return -EFAULT;
+	} else {
+		if (copy_to_user(buf, data->base + pos, count))
+			return -EFAULT;
+	}
+	*ppos += count;
+
+	return count;
+}
+
+static void vfio_pci_nvgpu_release(struct vfio_pci_device *vdev,
+		struct vfio_pci_region *region)
+{
+	struct vfio_pci_nvgpu_data *data = region->data;
+	long ret;
+	struct pci_controller *hose;
+	struct pci_dev *npdev;
+
+	/* If there were any mappings at all... */
+	if (data->mm) {
+		ret = mm_iommu_put(data->mm, data->mem);
+		WARN_ON(ret);
+
+		mmdrop(data->mm);
+	}
+
+	vfio_unregister_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
+			&data->group_notifier);
+
+	npdev = pnv_pci_get_npu_dev(data->gpdev, 0);
+	hose = pci_bus_to_host(npdev->bus);
+
+	pnv_npu2_unmap_lpar_dev(data->gpdev);
+
+	memunmap(data->base);
+	kfree(data);
+}
+
+static vm_fault_t vfio_pci_nvgpu_mmap_fault(struct vm_fault *vmf)
+{
+	vm_fault_t ret;
+	struct vm_area_struct *vma = vmf->vma;
+	struct vfio_pci_region *region = vma->vm_private_data;
+	struct vfio_pci_nvgpu_data *data = region->data;
+	unsigned long vmf_off = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long nv2pg = data->gpu_hpa >> PAGE_SHIFT;
+	unsigned long vm_pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+	unsigned long pfn = nv2pg + vm_pgoff + vmf_off;
+
+	ret = vmf_insert_pfn(vma, vmf->address, pfn);
+	trace_vfio_pci_nvgpu_mmap_fault(data->gpdev, pfn << PAGE_SHIFT,
+			vmf->address, ret);
+
+	return ret;
+}
+
+static const struct vm_operations_struct vfio_pci_nvgpu_mmap_vmops = {
+	.fault = vfio_pci_nvgpu_mmap_fault,
+};
+
+static int vfio_pci_nvgpu_mmap(struct vfio_pci_device *vdev,
+		struct vfio_pci_region *region, struct vm_area_struct *vma)
+{
+	long ret;
+	struct vfio_pci_nvgpu_data *data = region->data;
+
+	if (data->useraddr)
+		return -EPERM;
+
+	if (vma->vm_end - vma->vm_start > data->size)
+		return -EINVAL;
+
+	vma->vm_private_data = region;
+	vma->vm_flags |= VM_PFNMAP;
+	vma->vm_ops = &vfio_pci_nvgpu_mmap_vmops;
+
+	/*
+	 * Calling mm_iommu_newdev() here once as the region is not
+	 * registered yet and therefore right initialization will happen now.
+	 * Other places will use mm_iommu_find() which returns
+	 * registered @mem and does not go gup().
+	 */
+	data->useraddr = vma->vm_start;
+	data->mm = current->mm;
+
+	atomic_inc(&data->mm->mm_count);
+	ret = mm_iommu_newdev(data->mm, data->useraddr,
+			(vma->vm_end - vma->vm_start) >> PAGE_SHIFT,
+			data->gpu_hpa, &data->mem);
+
+	trace_vfio_pci_nvgpu_mmap(vdev->pdev, data->gpu_hpa, data->useraddr,
+			vma->vm_end - vma->vm_start, ret);
+
+	return ret;
+}
+
+static int vfio_pci_nvgpu_add_capability(struct vfio_pci_device *vdev,
+		struct vfio_pci_region *region, struct vfio_info_cap *caps)
+{
+	struct vfio_pci_nvgpu_data *data = region->data;
+	struct vfio_region_info_cap_npu2 cap;
+
+	cap.header.id = VFIO_REGION_INFO_CAP_NPU2;
+	cap.header.version = 1;
+	cap.tgt = data->gpu_tgt;
+
+	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+}
+
+static const struct vfio_pci_regops vfio_pci_nvgpu_regops = {
+	.rw = vfio_pci_nvgpu_rw,
+	.release = vfio_pci_nvgpu_release,
+	.mmap = vfio_pci_nvgpu_mmap,
+	.add_capability = vfio_pci_nvgpu_add_capability,
+};
+
+static int vfio_pci_nvgpu_group_notifier(struct notifier_block *nb,
+		unsigned long action, void *opaque)
+{
+	struct kvm *kvm = opaque;
+	struct vfio_pci_nvgpu_data *data = container_of(nb,
+			struct vfio_pci_nvgpu_data,
+			group_notifier);
+
+	if (action == VFIO_GROUP_NOTIFY_SET_KVM && kvm &&
+			pnv_npu2_map_lpar_dev(data->gpdev,
+				kvm->arch.lpid, MSR_DR | MSR_PR))
+		return NOTIFY_BAD;
+
+	return NOTIFY_OK;
+}
+
+int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
+{
+	int ret;
+	u64 reg[2];
+	u64 tgt = 0;
+	struct device_node *npu_node, *mem_node;
+	struct pci_dev *npu_dev;
+	struct vfio_pci_nvgpu_data *data;
+	uint32_t mem_phandle = 0;
+	unsigned long events = VFIO_GROUP_NOTIFY_SET_KVM;
+
+	npu_dev = pnv_pci_get_npu_dev(vdev->pdev, 0);
+	if (!npu_dev)
+		return -EINVAL;
+
+	npu_node = pci_device_to_OF_node(npu_dev);
+	if (!npu_node)
+		return -EINVAL;
+
+	if (of_property_read_u32(npu_node, "memory-region", &mem_phandle))
+		return -EINVAL;
+
+	mem_node = of_find_node_by_phandle(mem_phandle);
+	if (!mem_node)
+		return -EINVAL;
+
+	if (of_property_read_variable_u64_array(mem_node, "reg", reg,
+				ARRAY_SIZE(reg), ARRAY_SIZE(reg)) !=
+			ARRAY_SIZE(reg))
+		return -EINVAL;
+
+	if (of_property_read_u64(npu_node, "ibm,device-tgt-addr", &tgt)) {
+		dev_warn(&vdev->pdev->dev, "No ibm,device-tgt-addr found\n");
+		return -EFAULT;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->gpu_hpa = reg[0];
+	data->gpu_tgt = tgt;
+	data->size = reg[1];
+	data->base = memremap(data->gpu_hpa, data->size, MEMREMAP_WB);
+	if (!data->base) {
+		ret = -ENOMEM;
+		goto free_exit;
+	}
+
+	dev_dbg(&vdev->pdev->dev, "%lx..%lx\n", data->gpu_hpa,
+			data->gpu_hpa + data->size - 1);
+
+	data->gpdev = vdev->pdev;
+	data->group_notifier.notifier_call = vfio_pci_nvgpu_group_notifier;
+
+	ret = vfio_register_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
+			&events, &data->group_notifier);
+	if (ret)
+		goto free_exit;
+
+	/*
+	 * We have just set KVM, we do not need the listener anymore.
+	 * Also, keeping it registered means that if more than one GPU is
+	 * assigned, we will get several similar notifiers notifying about
+	 * the same device again which does not help with anything.
+	 */
+	vfio_unregister_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
+			&data->group_notifier);
+
+	ret = vfio_pci_register_dev_region(vdev,
+			PCI_VENDOR_ID_NVIDIA | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
+			VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM,
+			&vfio_pci_nvgpu_regops,
+			data->size,
+			VFIO_REGION_INFO_FLAG_READ |
+			VFIO_REGION_INFO_FLAG_WRITE |
+			VFIO_REGION_INFO_FLAG_MMAP,
+			data);
+	if (ret)
+		goto free_exit;
+
+	return 0;
+free_exit:
+	kfree(data);
+
+	return ret;
+}
+
+/*
+ * IBM NPU2 bridge
+ */
+struct vfio_pci_npu2_data {
+	void *base; /* ATSD register virtual address, for emulated access */
+	unsigned long mmio_atsd; /* ATSD physical address */
+	unsigned long gpu_tgt; /* TGT address of corresponding GPU RAM */
+};
+
+static size_t vfio_pci_npu2_rw(struct vfio_pci_device *vdev,
+		char __user *buf, size_t count, loff_t *ppos, bool iswrite)
+{
+	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
+	struct vfio_pci_npu2_data *data = vdev->region[i].data;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+
+	if (pos >= vdev->region[i].size)
+		return -EINVAL;
+
+	count = min(count, (size_t)(vdev->region[i].size - pos));
+
+	if (iswrite) {
+		if (copy_from_user(data->base + pos, buf, count))
+			return -EFAULT;
+	} else {
+		if (copy_to_user(buf, data->base + pos, count))
+			return -EFAULT;
+	}
+	*ppos += count;
+
+	return count;
+}
+
+static int vfio_pci_npu2_mmap(struct vfio_pci_device *vdev,
+		struct vfio_pci_region *region, struct vm_area_struct *vma)
+{
+	int ret;
+	struct vfio_pci_npu2_data *data = region->data;
+	unsigned long req_len = vma->vm_end - vma->vm_start;
+
+	if (req_len != PAGE_SIZE)
+		return -EINVAL;
+
+	vma->vm_flags |= VM_PFNMAP;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	ret = remap_pfn_range(vma, vma->vm_start, data->mmio_atsd >> PAGE_SHIFT,
+			req_len, vma->vm_page_prot);
+	trace_vfio_pci_npu2_mmap(vdev->pdev, data->mmio_atsd, vma->vm_start,
+			vma->vm_end - vma->vm_start, ret);
+
+	return ret;
+}
+
+static void vfio_pci_npu2_release(struct vfio_pci_device *vdev,
+		struct vfio_pci_region *region)
+{
+	struct vfio_pci_npu2_data *data = region->data;
+
+	memunmap(data->base);
+	kfree(data);
+}
+
+static int vfio_pci_npu2_add_capability(struct vfio_pci_device *vdev,
+		struct vfio_pci_region *region, struct vfio_info_cap *caps)
+{
+	struct vfio_pci_npu2_data *data = region->data;
+	struct vfio_region_info_cap_npu2 cap;
+
+	cap.header.id = VFIO_REGION_INFO_CAP_NPU2;
+	cap.header.version = 1;
+	cap.tgt = data->gpu_tgt;
+
+	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+}
+
+static const struct vfio_pci_regops vfio_pci_npu2_regops = {
+	.rw = vfio_pci_npu2_rw,
+	.mmap = vfio_pci_npu2_mmap,
+	.release = vfio_pci_npu2_release,
+	.add_capability = vfio_pci_npu2_add_capability,
+};
+
+int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
+{
+	int ret;
+	struct vfio_pci_npu2_data *data;
+	struct device_node *nvlink_dn;
+	u32 nvlink_index = 0;
+	struct pci_dev *npdev = vdev->pdev;
+	struct device_node *npu_node = pci_device_to_OF_node(npdev);
+	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
+	u64 mmio_atsd = 0;
+	u64 tgt = 0;
+
+	/*
+	 * NPU2 normally has 8 ATSD registers (for concurrency) and 6 links
+	 * so we can allocate one register per link.
+	 * Since skiboot only exposes one (a bug), use this as a fallback
+	 * which is safe as we do not split GPUs attached to the same NPU.
+	 */
+	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
+	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
+			&nvlink_index)))
+		return -ENODEV;
+
+	if (of_property_read_u64_index(hose->dn, "ibm,mmio-atsd", nvlink_index,
+			&mmio_atsd)) {
+		if (of_property_read_u64_index(hose->dn, "ibm,mmio-atsd", 0,
+					&mmio_atsd)) {
+			dev_warn(&vdev->pdev->dev, "No ATSD found\n");
+			return -EFAULT;
+		}
+		dev_warn(&vdev->pdev->dev, "Fallback to ATSD#0\n");
+	}
+
+	if (of_property_read_u64(npu_node, "ibm,device-tgt-addr", &tgt)) {
+		dev_warn(&vdev->pdev->dev, "No ibm,device-tgt-addr found\n");
+		return -EFAULT;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->mmio_atsd = mmio_atsd;
+	data->gpu_tgt = tgt;
+	data->base = memremap(data->mmio_atsd, SZ_64K, MEMREMAP_WT);
+	if (!data->base) {
+		ret = -ENOMEM;
+		goto free_exit;
+	}
+
+	ret = vfio_pci_register_dev_region(vdev,
+			PCI_VENDOR_ID_IBM | VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
+			VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
+			&vfio_pci_npu2_regops,
+			PAGE_SIZE,
+			VFIO_REGION_INFO_FLAG_READ |
+			VFIO_REGION_INFO_FLAG_WRITE |
+			VFIO_REGION_INFO_FLAG_MMAP,
+			data);
+	if (ret)
+		goto free_exit;
+
+	return 0;
+
+free_exit:
+	kfree(data);
+
+	return ret;
+}
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 42dc1d3..d0f8e4f 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -38,3 +38,9 @@ config VFIO_PCI_IGD
 	  and LPC bridge config space.
 
 	  To enable Intel IGD assignment through vfio-pci, say Y.
+
+config VFIO_PCI_NVLINK2
+	def_bool y
+	depends on VFIO_PCI && PPC_POWERNV
+	help
+	  VFIO PCI support for P9 Witherspoon machine with NVIDIA V100 GPUs
-- 
2.17.1

