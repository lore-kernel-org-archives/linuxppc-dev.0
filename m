Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wV0jP5q4bzDqdr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 May 2017 06:56:57 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev
Cc: mpe@ellerman.id.au, sbaskaran@nvidia.com, shailendras@nvidia.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powernv/npu-dma.c: Fix opal_npu_destroy_context call
Date: Sat, 20 May 2017 06:56:35 +1000
Message-Id: <1495227395-13721-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

opal_npu_destroy_context() should be called with the NPU PHB, not the
PCIe PHB.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 067defe..78fa939 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -714,7 +714,7 @@ static void pnv_npu2_release_context(struct kref *kref)
 void pnv_npu2_destroy_context(struct npu_context *npu_context,
 			struct pci_dev *gpdev)
 {
-	struct pnv_phb *nphb, *phb;
+	struct pnv_phb *nphb;
 	struct npu *npu;
 	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
 	struct device_node *nvlink_dn;
@@ -728,13 +728,12 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 
 	nphb = pci_bus_to_host(npdev->bus)->private_data;
 	npu = &nphb->npu;
-	phb = pci_bus_to_host(gpdev->bus)->private_data;
 	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
 		return;
 	npu_context->npdev[npu->index][nvlink_index] = NULL;
-	opal_npu_destroy_context(phb->opal_id, npu_context->mm->context.id,
+	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
 				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
 	kref_put(&npu_context->kref, pnv_npu2_release_context);
 }
-- 
2.1.4
