Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwfq1jr1zDqr6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:49:39 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mhairgrove@nvidia.com, shailendras@nvidia.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 2/3] powerpc/powernv: Add sanity checks to
 pnv_pci_get_{gpu|npu}_dev
Date: Wed, 22 Mar 2017 14:49:32 +1100
Message-Id: <1490154573-22475-2-git-send-email-alistair@popple.id.au>
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

The pnv_pci_get_{gpu|npu}_dev functions are used to find associations
between nvlink PCIe devices and standard PCIe devices. However they
lacked basic sanity checking which results in NULL pointer
dereferencing if they are incorrectly called which can be harder to
spot than an explicit WARN_ON.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 1c383f3..050bd5d 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -37,6 +37,12 @@ struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev)
 	struct device_node *dn;
 	struct pci_dev *gpdev;

+	if (WARN_ON(!npdev))
+		return NULL;
+
+	if (WARN_ON(!npdev->dev.of_node))
+		return NULL;
+
 	/* Get assoicated PCI device */
 	dn = of_parse_phandle(npdev->dev.of_node, "ibm,gpu", 0);
 	if (!dn)
@@ -55,6 +61,12 @@ struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
 	struct device_node *dn;
 	struct pci_dev *npdev;

+	if (WARN_ON(!gpdev))
+		return NULL;
+
+	if (WARN_ON(!gpdev->dev.of_node))
+		return NULL;
+
 	/* Get assoicated PCI device */
 	dn = of_parse_phandle(gpdev->dev.of_node, "ibm,npu", index);
 	if (!dn)
--
2.1.4
