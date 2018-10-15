Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E352CC7112B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:59:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A652064E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A652064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYnT3QQtzF3Nb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:59:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YYQk4Nh0zF3NW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:43:10 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 6CBDCAE807F7;
 Mon, 15 Oct 2018 05:42:37 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 1/3] vfio_pci: Allow mapping extra regions
Date: Mon, 15 Oct 2018 20:42:31 +1100
Message-Id: <20181015094233.1324-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181015094233.1324-1-aik@ozlabs.ru>
References: <20181015094233.1324-1-aik@ozlabs.ru>
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
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

So far we only allowed mapping of MMIO BARs to the userspace. However
there there are GPUs with on-board coherent RAM accessible via side
channels which we also want to map to the userspace. The first client
for this is NVIDIA V100 GPU with NVLink2 direct links to a POWER9
NPU-enabled CPU; such GPUs have 16GB RAM which is coherently mapped
to the system address space, we are going to export these as an extra
PCI region.

We already support extra PCI regions and this adds support for mapping
them to the userspace.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* reverted one of mistakenly removed error checks
---
 drivers/vfio/pci/vfio_pci_private.h | 3 +++
 drivers/vfio/pci/vfio_pci.c         | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index cde3b5d..86aab05 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -59,6 +59,9 @@ struct vfio_pci_regops {
 		      size_t count, loff_t *ppos, bool iswrite);
 	void	(*release)(struct vfio_pci_device *vdev,
 			   struct vfio_pci_region *region);
+	int	(*mmap)(struct vfio_pci_device *vdev,
+			struct vfio_pci_region *region,
+			struct vm_area_struct *vma);
 };
 
 struct vfio_pci_region {
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index d9af440..7923314 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1126,6 +1126,14 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 		return -EINVAL;
 	if ((vma->vm_flags & VM_SHARED) == 0)
 		return -EINVAL;
+	if (index >= VFIO_PCI_NUM_REGIONS) {
+		int regnum = index - VFIO_PCI_NUM_REGIONS;
+		struct vfio_pci_region *region = vdev->region + regnum;
+
+		if (region && region->ops && region->ops->mmap)
+			return region->ops->mmap(vdev, region, vma);
+		return -EINVAL;
+	}
 	if (index >= VFIO_PCI_ROM_REGION_INDEX)
 		return -EINVAL;
 	if (!vdev->bar_mmap_supported[index])
-- 
2.11.0

