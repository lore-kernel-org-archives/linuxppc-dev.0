Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm4YK1qQszDrGY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:37:41 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rm4YJ31qFz9s5Q
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2016 16:37:40 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/14] powerpc/powernv: Discover IODA3 PHBs
Date: Fri,  8 Jul 2016 16:37:09 +1000
Message-Id: <1467959838-6900-5-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We instanciate them as IODA2. We also change the MSI EOI hack
to only kick on PHB3 since it will not be needed on any new
implementation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 arch/powerpc/platforms/powernv/pci.c      | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0be6f2b..092b2e6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2711,7 +2711,8 @@ static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
 	struct irq_data *idata;
 	struct irq_chip *ichip;
 
-	if (phb->type != PNV_PHB_IODA2)
+	/* The MSI EOI OPAL call is only needed on PHB3 */
+	if (phb->model != PNV_PHB_MODEL_PHB3)
 		return;
 
 	if (!phb->ioda.irq_chip_init) {
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 62c7637..4617ea2 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -932,6 +932,10 @@ void __init pnv_pci_init(void)
 	for_each_compatible_node(np, NULL, "ibm,ioda2-phb")
 		pnv_pci_init_ioda2_phb(np);
 
+	/* Look for ioda3 built-in PHB4's, we treat them as IODA2 */
+	for_each_compatible_node(np, NULL, "ibm,ioda3-phb")
+		pnv_pci_init_ioda2_phb(np);
+
 	/* Look for NPU PHBs */
 	for_each_compatible_node(np, NULL, "ibm,ioda2-npu-phb")
 		pnv_pci_init_npu_phb(np);
-- 
2.7.4
