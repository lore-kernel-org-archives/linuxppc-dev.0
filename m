Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3942C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 05:25:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5C6206DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 05:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5C6206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZWc42NKgzDqJT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:25:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 44ZWZD6TQ1zDqDh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 16:23:32 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 7B583AE80001;
 Thu,  4 Apr 2019 01:23:26 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH kernel v2] powerpc/powernv: Isolate NVLinks between
 GV100GL on Witherspoon
Date: Thu,  4 Apr 2019 16:23:24 +1100
Message-Id: <20190404052324.90501-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The NVIDIA V100 SXM2 GPUs are connected to the CPU via PCIe links and
(on POWER9) NVLinks. In addition to that, GPUs themselves have direct
peer to peer NVLinks in groups of 2 to 4 GPUs. At the moment the POWERNV
platform puts all interconnected GPUs to the same IOMMU group.

However the user may want to pass individual GPUs to the userspace so
in order to do so we need to put them into separate IOMMU groups and
cut off the interconnects.

Thankfully V100 GPUs implement an interface to do by programming link
disabling mask to BAR0 of a GPU. Once a link is disabled in a GPU using
this interface, it cannot be re-enabled until the secondary bus reset is
issued to the GPU.

This adds an extra step to the secondary bus reset handler (the one used
for such GPUs) to block NVLinks to GPUs which do not belong to the same
group as the GPU being reset.

This adds a new "isolate_nvlink" kernel parameter to allow GPU isolation;
when enabled, every GPU gets its own IOMMU group. The new parameter is off
by default to preserve the existing behaviour.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* this is rework of [PATCH kernel RFC 0/2] vfio, powerpc/powernv: Isolate GV100GL
but this time it is contained in the powernv platform
---
 arch/powerpc/platforms/powernv/Makefile      |   2 +-
 arch/powerpc/platforms/powernv/pci.h         |   1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c |   1 +
 arch/powerpc/platforms/powernv/npu-dma.c     |  24 +++-
 arch/powerpc/platforms/powernv/nvlinkgpu.c   | 131 +++++++++++++++++++
 5 files changed, 156 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/nvlinkgpu.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index da2e99efbd04..60a10d3b36eb 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,7 +6,7 @@ obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
-obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o
+obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o nvlinkgpu.o
 obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8e36da379252..9fd3f391482c 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -250,5 +250,6 @@ extern void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
 extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 		void *tce_mem, u64 tce_size,
 		u64 dma_offset, unsigned int page_shift);
+extern void pnv_try_isolate_nvidia_v100(struct pci_dev *gpdev);
 
 #endif /* __POWERNV_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index f38078976c5d..464b097d9635 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -937,6 +937,7 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
 		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
 	}
+	pnv_try_isolate_nvidia_v100(dev);
 }
 
 static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index dc23d9d2a7d9..017eae8197e7 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -529,6 +529,23 @@ static void pnv_comp_attach_table_group(struct npu_comp *npucomp,
 	++npucomp->pe_num;
 }
 
+static bool isolate_nvlink;
+
+static int __init parse_isolate_nvlink(char *p)
+{
+	bool val;
+
+	if (!p)
+		val = true;
+	else if (kstrtobool(p, &val))
+		return -EINVAL;
+
+	isolate_nvlink = val;
+
+	return 0;
+}
+early_param("isolate_nvlink", parse_isolate_nvlink);
+
 struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
 {
 	struct iommu_table_group *table_group;
@@ -549,7 +566,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
 
 	hose = pci_bus_to_host(npdev->bus);
 
-	if (hose->npu) {
+	if (hose->npu && !isolate_nvlink) {
 		table_group = &hose->npu->npucomp.table_group;
 
 		if (!table_group->group) {
@@ -559,7 +576,10 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
 					pe->pe_number);
 		}
 	} else {
-		/* Create a group for 1 GPU and attached NPUs for POWER8 */
+		/*
+		 * Create a group for 1 GPU and attached NPUs for
+		 * POWER8 (always) or POWER9 (when isolate_nvlink).
+		 */
 		pe->npucomp = kzalloc(sizeof(*pe->npucomp), GFP_KERNEL);
 		table_group = &pe->npucomp->table_group;
 		table_group->ops = &pnv_npu_peers_ops;
diff --git a/arch/powerpc/platforms/powernv/nvlinkgpu.c b/arch/powerpc/platforms/powernv/nvlinkgpu.c
new file mode 100644
index 000000000000..dbd8e9d47a05
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/nvlinkgpu.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * A helper to disable NVLinks between GPUs on IBM Withersponn platform.
+ *
+ * Copyright (C) 2019 IBM Corp.  All rights reserved.
+ *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/iommu.h>
+#include <linux/pci.h>
+
+static int nvlinkgpu_is_ph_in_group(struct device *dev, void *data)
+{
+	return dev->of_node->phandle == *(phandle *) data;
+}
+
+static u32 nvlinkgpu_get_disable_mask(struct device *dev)
+{
+	int npu, peer;
+	u32 mask;
+	struct device_node *dn;
+	struct iommu_group *group;
+
+	dn = dev->of_node;
+	if (!of_find_property(dn, "ibm,nvlink-peers", NULL))
+		return 0;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return 0;
+
+	/*
+	 * Collect links to keep which includes links to NPU and links to
+	 * other GPUs in the same IOMMU group.
+	 */
+	for (npu = 0, mask = 0; ; ++npu) {
+		u32 npuph = 0;
+
+		if (of_property_read_u32_index(dn, "ibm,npu", npu, &npuph))
+			break;
+
+		for (peer = 0; ; ++peer) {
+			u32 peerph = 0;
+
+			if (of_property_read_u32_index(dn, "ibm,nvlink-peers",
+					peer, &peerph))
+				break;
+
+			if (peerph != npuph &&
+				!iommu_group_for_each_dev(group, &peerph,
+					nvlinkgpu_is_ph_in_group))
+				continue;
+
+			mask |= 1 << (peer + 16);
+		}
+	}
+	iommu_group_put(group);
+
+	/* Disabling mechanism takes links to disable so invert it here */
+	mask = ~mask & 0x3F0000;
+
+	return mask;
+}
+
+void pnv_try_isolate_nvidia_v100(struct pci_dev *bridge)
+{
+	u32 mask;
+	void __iomem *bar0_0, *bar0_120000, *bar0_a00000;
+	struct pci_dev *pdev;
+
+	if (!bridge->subordinate)
+		return;
+
+	pdev = list_first_entry_or_null(&bridge->subordinate->devices,
+			struct pci_dev, bus_list);
+	if (!pdev)
+		return;
+
+	if (pdev->vendor != PCI_VENDOR_ID_NVIDIA)
+		return;
+
+	mask = nvlinkgpu_get_disable_mask(&pdev->dev);
+	if (!mask)
+		return;
+
+	bar0_0 = pci_iomap_range(pdev, 0, 0, 0x10000);
+	bar0_120000 = pci_iomap_range(pdev, 0, 0x120000, 0x10000);
+	bar0_a00000 = pci_iomap_range(pdev, 0, 0xA00000, 0x10000);
+
+	if (bar0_120000 && bar0_0 && bar0_a00000) {
+		u32 val;
+		u16 cmd = 0, cmdmask = PCI_COMMAND_MEMORY;
+
+		pci_restore_state(pdev);
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		if ((cmd & cmdmask) != cmdmask)
+			pci_write_config_word(pdev, PCI_COMMAND, cmd | cmdmask);
+
+		/*
+		 * The sequence is from "Tesla P100 and V100 SXM2 NVLink
+		 * Isolation on Multi-Tenant Systems".
+		 * The register names are not provided there either,
+		 * hence raw values.
+		 */
+		iowrite32(0x4, bar0_120000 + 0x4C);
+		iowrite32(0x2, bar0_120000 + 0x2204);
+		val = ioread32(bar0_0 + 0x200);
+		val |= 0x02000000;
+		iowrite32(val, bar0_0 + 0x200);
+		val = ioread32(bar0_a00000 + 0x148);
+		val |= mask;
+		iowrite32(val, bar0_a00000 + 0x148);
+
+		if ((cmd | cmdmask) != cmd)
+			pci_write_config_word(pdev, PCI_COMMAND, cmd);
+	}
+
+	if (bar0_0)
+		pci_iounmap(pdev, bar0_0);
+	if (bar0_120000)
+		pci_iounmap(pdev, bar0_120000);
+	if (bar0_a00000)
+		pci_iounmap(pdev, bar0_a00000);
+}
-- 
2.17.1

