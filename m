Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxS7922m1zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 19:51:49 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mhairgrove@nvidia.com, robh+dt@kernel.org,
 shailendras@nvidia.com, Alistair Popple <alistair@popple.id.au>
Subject: [PATCH v2 2/3] powerpc/powernv: Add sanity checks to
 pnv_pci_get_{gpu|npu}_dev
Date: Mon,  3 Apr 2017 19:51:43 +1000
Message-Id: <1491213104-24450-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1491213104-24450-1-git-send-email-alistair@popple.id.au>
References: <1491213104-24450-1-git-send-email-alistair@popple.id.au>
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
dereferencing if they are incorrect called can be harder to spot than
an explicit WARN_ON.

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
