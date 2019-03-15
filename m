Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807DBC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 08:23:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077AC21871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 08:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077AC21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LJVt12Q3zDqSR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 19:23:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 44LJQC3lkWzDqSN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 19:19:15 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 19FB7AE807F1;
 Fri, 15 Mar 2019 04:18:41 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel RFC 2/2] vfio-pci-nvlink2: Implement interconnect
 isolation
Date: Fri, 15 Mar 2019 19:18:35 +1100
Message-Id: <20190315081835.14083-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315081835.14083-1-aik@ozlabs.ru>
References: <20190315081835.14083-1-aik@ozlabs.ru>
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
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
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

This defines a reset_done() handler for V100 NVlink2 device which
determines what links need to be disabled. This relies on presence
of the new "ibm,nvlink-peers" device tree property of a GPU telling which
PCI peers it is connected to (which includes NVLink bridges or peer GPUs).

This does not change the existing behaviour and instead adds
a new "isolate_nvlink" kernel parameter to allow such isolation.

The alternative approaches would be:

1. do this in the system firmware (skiboot) but for that we would need
to tell skiboot via an additional OPAL call whether or not we want this
isolation - skiboot is unaware of IOMMU groups.

2. do this in the secondary bus reset handler in the POWERNV platform -
the problem with that is at that point the device is not enabled, i.e.
config space is not restored so we need to enable the device (i.e. MMIO
bit in CMD register + program valid address to BAR0) in order to disable
links and then perhaps undo all this initialization to bring the device
back to the state where pci_try_reset_function() expects it to be.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 24 +++++-
 drivers/vfio/pci/vfio_pci_nvlink2.c      | 98 ++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 3a102378c8dc..6f5c769b6fc8 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -441,6 +441,23 @@ static void pnv_comp_attach_table_group(struct npu_comp *npucomp,
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
@@ -463,7 +480,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
 	hose = pci_bus_to_host(npdev->bus);
 	phb = hose->private_data;
 
-	if (hose->npu) {
+	if (hose->npu && !isolate_nvlink) {
 		if (!phb->npucomp) {
 			phb->npucomp = kzalloc(sizeof(struct npu_comp),
 					GFP_KERNEL);
@@ -477,7 +494,10 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
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
diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
index 32f695ffe128..bb6bba762f46 100644
--- a/drivers/vfio/pci/vfio_pci_nvlink2.c
+++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
@@ -206,6 +206,102 @@ static int vfio_pci_nvgpu_group_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int vfio_pci_nvdia_v100_is_ph_in_group(struct device *dev, void *data)
+{
+	return dev->of_node->phandle == *(phandle *) data;
+}
+
+static u32 vfio_pci_nvdia_v100_get_disable_mask(struct device *dev)
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
+					vfio_pci_nvdia_v100_is_ph_in_group))
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
+static void vfio_pci_nvdia_v100_nvlink2_reset_done(struct vfio_pci_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u16 cmd = 0, cmdmask;
+	u32 mask, val;
+	void __iomem *bar0;
+
+	bar0 = vdev->barmap[0];
+	if (!bar0)
+		return;
+
+	mask = vfio_pci_nvdia_v100_get_disable_mask(&pdev->dev);
+	if (!mask)
+		return;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	cmdmask = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_PARITY;
+	if ((cmd & cmdmask) != cmdmask)
+		pci_write_config_word(pdev, PCI_COMMAND, cmd | cmdmask);
+
+	/*
+	 * The sequence is from
+	 * Tesla P100 and V100 SXM2 NVLink Isolation on Multi-Tenant Systems.
+	 * The register names are not provided there either, hence raw values.
+	 */
+	iowrite32(0x4, bar0 + 0x12004C);
+	iowrite32(0x2, bar0 + 0x122204);
+	val = ioread32(bar0 + 0x200);
+	val |= 0x02000000;
+	iowrite32(val, bar0 + 0x200);
+	val = ioread32(bar0 + 0xA00148);
+	val |= mask;
+	iowrite32(val, bar0 + 0xA00148);
+	val = ioread32(bar0 + 0xA00148);
+
+	if ((cmd | cmdmask) != cmd)
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+}
+
+static struct vfio_pci_error_handlers vfio_pci_nvdia_v100_error_handlers = {
+	.reset_done = vfio_pci_nvdia_v100_nvlink2_reset_done,
+};
+
 int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
 {
 	int ret;
@@ -286,6 +382,8 @@ int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
 	if (ret)
 		goto free_exit;
 
+	vdev->error_handlers = &vfio_pci_nvdia_v100_error_handlers;
+
 	return 0;
 free_exit:
 	kfree(data);
-- 
2.17.1

