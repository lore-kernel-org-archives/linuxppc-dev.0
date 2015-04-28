Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DCB11A0567
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:12:38 +1000 (AEST)
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 16603140083
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:12:38 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so152823345pab.2
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 22:12:36 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/powernv: Move dma_set_mask from pnv_phb to
 pci_controller_ops
Date: Tue, 28 Apr 2015 15:12:07 +1000
Message-Id: <1430197927-24814-4-git-send-email-dja@axtens.net>
In-Reply-To: <1430197927-24814-1-git-send-email-dja@axtens.net>
References: <1430197927-24814-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously, dma_set_mask on powernv was convoluted:
0) Call dma_set_mask (kernel/dma.c)
1) In dma_set_mask, ppc_md.dma_set_mask exists, so call it.
2) On powernv, that function pointer is pnv_dma_set_mask.
   In pnv_dma_set_mask, the device is pci, so call pnv_pci_dma_set_mask.
3) In pnv_pci_dma_set_mask, call pnv_phb->set_dma_mask if it exists.
4) It only exists in the ioda case, where it points to
   pnv_pci_ioda_dma_set_mask, which is the final function.

So the call chain is:
 dma_set_mask ->
  pnv_dma_set_mask ->
   pnv_pci_dma_set_mask ->
    pnv_pci_ioda_dma_set_mask
Both ppc_md and pnv_phb function pointers are used

Rip out the ppc_md call, pnv_dma_set_mask, pnv_pci_dma_set_mask.
Instead:
0) Call dma_set_mask (kernel/dma.c)
1) In dma_set_mask, the device is pci, and pci_controller_ops.dma_set_mask
   exists, so call pci_controller_ops.dma_set_mask
2) In the ioda case, that points to pnv_pci_ioda_dma_set_mask.

The new call chain is
 dma_set_mask ->
  pnv_pci_ioda_dma_set_mask
Now only the pci_controller_ops function pointer is used.

The fallback paths for p5ioc2 are the same.
Previously, pnv_pci_dma_set_mask would find no pnv_phb->set_dma_mask
function, to it would call __set_dma_mask.
Now, dma_set_mask finds no ppc_md call or pci_controller_ops call,
so it calls __set_dma_mask.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |  7 ++++---
 arch/powerpc/platforms/powernv/pci.c      | 10 ----------
 arch/powerpc/platforms/powernv/pci.h      |  2 --
 arch/powerpc/platforms/powernv/powernv.h  |  6 ------
 arch/powerpc/platforms/powernv/setup.c    |  8 --------
 5 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c853b62..1e77a50 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1603,9 +1603,10 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 	set_iommu_table_base_and_group(&pdev->dev, pe->tce32_table);
 }
 
-static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
-				     struct pci_dev *pdev, u64 dma_mask)
+static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 {
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
 	struct pci_dn *pdn = pci_get_pdn(pdev);
 	struct pnv_ioda_pe *pe;
 	uint64_t top;
@@ -2793,7 +2794,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
-	phb->dma_set_mask = pnv_pci_ioda_dma_set_mask;
 	phb->dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask;
 
 	/* Setup shutdown function for kexec */
@@ -2877,4 +2877,5 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
        .enable_device_hook = pnv_pci_enable_device_hook,
        .window_alignment = pnv_pci_window_alignment,
        .reset_secondary_bus = pnv_pci_reset_secondary_bus,
+       .dma_set_mask = pnv_pci_ioda_dma_set_mask,
 };
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index d7e37d8..acc0ced 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -689,16 +689,6 @@ void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 		phb->dma_dev_setup(phb, pdev);
 }
 
-int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
-{
-	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	struct pnv_phb *phb = hose->private_data;
-
-	if (phb && phb->dma_set_mask)
-		return phb->dma_set_mask(phb, pdev, dma_mask);
-	return __dma_set_mask(&pdev->dev, dma_mask);
-}
-
 u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index b6d1290..60bb935 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -106,8 +106,6 @@ struct pnv_phb {
 			 unsigned int hwirq, unsigned int virq,
 			 unsigned int is_64, struct msi_msg *msg);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
-	int (*dma_set_mask)(struct pnv_phb *phb, struct pci_dev *pdev,
-			    u64 dma_mask);
 	u64 (*dma_get_required_mask)(struct pnv_phb *phb,
 				     struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 604c48e..1e56962 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -12,17 +12,11 @@ struct pci_dev;
 #ifdef CONFIG_PCI
 extern void pnv_pci_init(void);
 extern void pnv_pci_shutdown(void);
-extern int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask);
 extern u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev);
 #else
 static inline void pnv_pci_init(void) { }
 static inline void pnv_pci_shutdown(void) { }
 
-static inline int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
-{
-	return -ENODEV;
-}
-
 static inline u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev)
 {
 	return 0;
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 16fdcb2..92fcc04 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -169,13 +169,6 @@ static void pnv_progress(char *s, unsigned short hex)
 {
 }
 
-static int pnv_dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	if (dev_is_pci(dev))
-		return pnv_pci_dma_set_mask(to_pci_dev(dev), dma_mask);
-	return __dma_set_mask(dev, dma_mask);
-}
-
 static u64 pnv_dma_get_required_mask(struct device *dev)
 {
 	if (dev_is_pci(dev))
@@ -492,7 +485,6 @@ define_machine(powernv) {
 	.machine_shutdown	= pnv_shutdown,
 	.power_save             = power7_idle,
 	.calibrate_decr		= generic_calibrate_decr,
-	.dma_set_mask		= pnv_dma_set_mask,
 	.dma_get_required_mask	= pnv_dma_get_required_mask,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
-- 
2.1.4
