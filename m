Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4312B1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 13:46:48 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D5E31402A7
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 13:46:48 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 7 Aug 2015 13:46:47 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0C7AC2BB005B
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 13:46:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t773kWjr58130476
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 13:46:40 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t773kCqk012536
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 13:46:12 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t773kChH012041
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 13:46:12 +1000
Received: from ajd.ozlabs.ibm.com (unknown [9.192.254.114])
 by ozlabs.au.ibm.com (Postfix) with ESMTP id 76751A021A
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 13:45:48 +1000 (AEST)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: move dma_get_required_mask from pnv_phb to
 pci_controller_ops
Date: Fri,  7 Aug 2015 13:45:54 +1000
Message-Id: <1438919154-6179-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify the dma_get_required_mask call chain by moving it from pnv_phb to
pci_controller_ops, similar to commit 763d2d8df1ee2b92ff09c
("powerpc/powernv: Move dma_set_mask from pnv_phb to pci_controller_ops").

Previous call chain:

  0) call dma_get_required_mask() (kernel/dma.c)
  1) call ppc_md.dma_get_required_mask, if it exists. On powernv, that
     points to pnv_dma_get_required_mask() (platforms/powernv/setup.c)
  2) device is PCI, therefore call pnv_pci_dma_get_required_mask()
     (platforms/powernv/pci.c)
  3) call phb->dma_get_required_mask if it exists
  4) it only exists in the ioda case, where it points to
       pnv_pci_ioda_dma_get_required_mask() (platforms/powernv/pci-ioda.c)

New call chain:

  0) call dma_get_required_mask() (kernel/dma.c)
  1) device is PCI, therefore call pci_controller_ops.dma_get_required_mask
     if it exists
  2) in the ioda case, that points to pnv_pci_ioda_dma_get_required_mask()
     (platforms/powernv/pci-ioda.c)

In the p5ioc2 case, the call chain remains the same -
dma_get_required_mask() does not find either a ppc_md call or
pci_controller_ops call, so it calls __dma_get_required_mask().

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

dma_get_required_mask() is only used in a small handful of drivers, for
which I don't have access to appropriate hardware, so this was tested by
artificially inserting calls into the tg3 PCI network card driver.

---
 arch/powerpc/include/asm/pci-bridge.h     |  1 +
 arch/powerpc/kernel/dma.c                 |  7 +++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |  7 ++++---
 arch/powerpc/platforms/powernv/pci.c      | 11 -----------
 arch/powerpc/platforms/powernv/pci.h      |  2 --
 arch/powerpc/platforms/powernv/powernv.h  |  6 ------
 arch/powerpc/platforms/powernv/setup.c    |  9 ---------
 7 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 712add5..37fc535 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -42,6 +42,7 @@ struct pci_controller_ops {
 #endif
 
 	int             (*dma_set_mask)(struct pci_dev *dev, u64 dma_mask);
+	u64		(*dma_get_required_mask)(struct pci_dev *dev);
 
 	void		(*shutdown)(struct pci_controller *);
 };
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 35e4dcc..9d68589 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -278,6 +278,13 @@ u64 dma_get_required_mask(struct device *dev)
 	if (ppc_md.dma_get_required_mask)
 		return ppc_md.dma_get_required_mask(dev);
 
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_controller *phb = pci_bus_to_host(pdev->bus);
+		if (phb->controller_ops.dma_get_required_mask)
+			return phb->controller_ops.dma_get_required_mask(pdev);
+	}
+
 	return __dma_get_required_mask(dev);
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 85cbc96..6f015d4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1630,9 +1630,10 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 	return 0;
 }
 
-static u64 pnv_pci_ioda_dma_get_required_mask(struct pnv_phb *phb,
-					      struct pci_dev *pdev)
+static u64 pnv_pci_ioda_dma_get_required_mask(struct pci_dev *pdev)
 {
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
 	struct pci_dn *pdn = pci_get_pdn(pdev);
 	struct pnv_ioda_pe *pe;
 	u64 end, mask;
@@ -3057,6 +3058,7 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
        .window_alignment = pnv_pci_window_alignment,
        .reset_secondary_bus = pnv_pci_reset_secondary_bus,
        .dma_set_mask = pnv_pci_ioda_dma_set_mask,
+       .dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask,
        .shutdown = pnv_pci_ioda_shutdown,
 };
 
@@ -3203,7 +3205,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
-	phb->dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask;
 
 	/* Setup MSI support */
 	pnv_pci_init_ioda_msis(phb);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 765d8ed..3e7f6fd 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -761,17 +761,6 @@ void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 		phb->dma_dev_setup(phb, pdev);
 }
 
-u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev)
-{
-	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	struct pnv_phb *phb = hose->private_data;
-
-	if (phb && phb->dma_get_required_mask)
-		return phb->dma_get_required_mask(phb, pdev);
-
-	return __dma_get_required_mask(&pdev->dev);
-}
-
 void pnv_pci_shutdown(void)
 {
 	struct pci_controller *hose;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8ef2d28..93a319a 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -105,8 +105,6 @@ struct pnv_phb {
 			 unsigned int hwirq, unsigned int virq,
 			 unsigned int is_64, struct msi_msg *msg);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
-	u64 (*dma_get_required_mask)(struct pnv_phb *phb,
-				     struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
 	int (*init_m64)(struct pnv_phb *phb);
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 9269e30..6dbc0a1 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -12,15 +12,9 @@ struct pci_dev;
 #ifdef CONFIG_PCI
 extern void pnv_pci_init(void);
 extern void pnv_pci_shutdown(void);
-extern u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev);
 #else
 static inline void pnv_pci_init(void) { }
 static inline void pnv_pci_shutdown(void) { }
-
-static inline u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev)
-{
-	return 0;
-}
 #endif
 
 extern u32 pnv_get_supported_cpuidle_states(void);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 53737e0..77a31c1 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -165,14 +165,6 @@ static void pnv_progress(char *s, unsigned short hex)
 {
 }
 
-static u64 pnv_dma_get_required_mask(struct device *dev)
-{
-	if (dev_is_pci(dev))
-		return pnv_pci_dma_get_required_mask(to_pci_dev(dev));
-
-	return __dma_get_required_mask(dev);
-}
-
 static void pnv_shutdown(void)
 {
 	/* Let the PCI code clear up IODA tables */
@@ -314,7 +306,6 @@ define_machine(powernv) {
 	.machine_shutdown	= pnv_shutdown,
 	.power_save             = power7_idle,
 	.calibrate_decr		= generic_calibrate_decr,
-	.dma_get_required_mask	= pnv_dma_get_required_mask,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
 #endif
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
