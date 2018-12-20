Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23130C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 09:08:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9807A2176F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 09:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9807A2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L5XW4tN6zDqy6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 20:08:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43L4Z55t4KzDqv3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 19:25:01 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 40C26AE80490;
 Thu, 20 Dec 2018 03:24:58 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 18/20] vfio_pci: Allow mapping extra regions
Date: Thu, 20 Dec 2018 19:23:48 +1100
Message-Id: <20181220082350.58113-19-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
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
Cc: Christoph Hellwig <hch@infradead.org>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

So far we only allowed mapping of MMIO BARs to the userspace. However
there are GPUs with on-board coherent RAM accessible via side
channels which we also want to map to the userspace. The first client
for this is NVIDIA V100 GPU with NVLink2 direct links to a POWER9
NPU-enabled CPU; such GPUs have 16GB RAM which is coherently mapped
to the system address space, we are going to export these as an extra
PCI region.

We already support extra PCI regions and this adds support for mapping
them to the userspace.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v2:
* reverted one of mistakenly removed error checks
---
 drivers/vfio/pci/vfio_pci_private.h | 3 +++
 drivers/vfio/pci/vfio_pci.c         | 9 +++++++++
 2 files changed, 12 insertions(+)

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
index fef5002..4a6f7c0 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1130,6 +1130,15 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 		return -EINVAL;
 	if ((vma->vm_flags & VM_SHARED) == 0)
 		return -EINVAL;
+	if (index >= VFIO_PCI_NUM_REGIONS) {
+		int regnum = index - VFIO_PCI_NUM_REGIONS;
+		struct vfio_pci_region *region = vdev->region + regnum;
+
+		if (region && region->ops && region->ops->mmap &&
+		    (region->flags & VFIO_REGION_INFO_FLAG_MMAP))
+			return region->ops->mmap(vdev, region, vma);
+		return -EINVAL;
+	}
 	if (index >= VFIO_PCI_ROM_REGION_INDEX)
 		return -EINVAL;
 	if (!vdev->bar_mmap_supported[index])
-- 
2.17.1

