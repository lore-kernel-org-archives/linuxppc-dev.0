Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55FF91A0198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 17:28:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/powernv: Remove powernv RTAS support
Date: Thu, 12 Mar 2015 17:27:11 +1100
Message-Id: <1426141631-10741-1-git-send-email-mpe@ellerman.id.au>
Cc: dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powernv code has some conditional support for running on bare metal
machines that have no OPAL firmware, but provide RTAS.

No released machines ever supported that, and even in the lab it was
just a transitional hack in the days when OPAL was still being
developed.

So remove the code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/Kconfig |  7 ---
 arch/powerpc/platforms/powernv/pci.c   | 98 +++++++---------------------------
 arch/powerpc/platforms/powernv/setup.c | 19 -------
 arch/powerpc/platforms/powernv/smp.c   | 13 -----
 4 files changed, 19 insertions(+), 118 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 45a8ed0585cd..4b044d8cb49a 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -19,10 +19,3 @@ config PPC_POWERNV
 	select CPU_FREQ_GOV_CONSERVATIVE
 	select PPC_DOORBELL
 	default y
-
-config PPC_POWERNV_RTAS
-	depends on PPC_POWERNV
-	bool "Support for RTAS based PowerNV platforms such as BML"
-	default y
-	select PPC_ICS_RTAS
-	select PPC_RTAS
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 54323d6b5166..c8939ad221f9 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -679,66 +679,13 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 	tbl->it_type = TCE_PCI;
 }
 
-static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
-{
-	struct iommu_table *tbl;
-	const __be64 *basep, *swinvp;
-	const __be32 *sizep;
-
-	basep = of_get_property(hose->dn, "linux,tce-base", NULL);
-	sizep = of_get_property(hose->dn, "linux,tce-size", NULL);
-	if (basep == NULL || sizep == NULL) {
-		pr_err("PCI: %s has missing tce entries !\n",
-		       hose->dn->full_name);
-		return NULL;
-	}
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, hose->node);
-	if (WARN_ON(!tbl))
-		return NULL;
-	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
-				  be32_to_cpup(sizep), 0, IOMMU_PAGE_SHIFT_4K);
-	iommu_init_table(tbl, hose->node);
-	iommu_register_group(tbl, pci_domain_nr(hose->bus), 0);
-
-	/* Deal with SW invalidated TCEs when needed (BML way) */
-	swinvp = of_get_property(hose->dn, "linux,tce-sw-invalidate-info",
-				 NULL);
-	if (swinvp) {
-		tbl->it_busno = be64_to_cpu(swinvp[1]);
-		tbl->it_index = (unsigned long)ioremap(be64_to_cpup(swinvp), 8);
-		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
-	}
-	return tbl;
-}
-
-static void pnv_pci_dma_fallback_setup(struct pci_controller *hose,
-				       struct pci_dev *pdev)
-{
-	struct device_node *np = pci_bus_to_OF_node(hose->bus);
-	struct pci_dn *pdn;
-
-	if (np == NULL)
-		return;
-	pdn = PCI_DN(np);
-	if (!pdn->iommu_table)
-		pdn->iommu_table = pnv_pci_setup_bml_iommu(hose);
-	if (!pdn->iommu_table)
-		return;
-	set_iommu_table_base_and_group(&pdev->dev, pdn->iommu_table);
-}
-
 static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
 
-	/* If we have no phb structure, try to setup a fallback based on
-	 * the device-tree (RTAS PCI for example)
-	 */
 	if (phb && phb->dma_dev_setup)
 		phb->dma_dev_setup(phb, pdev);
-	else
-		pnv_pci_dma_fallback_setup(hose, pdev);
 }
 
 int pnv_pci_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
@@ -784,38 +731,31 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
 void __init pnv_pci_init(void)
 {
 	struct device_node *np;
+	bool found_ioda = false;
 
 	pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
 
-	/* OPAL absent, try POPAL first then RTAS detection of PHBs */
-	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
-#ifdef CONFIG_PPC_POWERNV_RTAS
-		init_pci_config_tokens();
-		find_and_init_phbs();
-#endif /* CONFIG_PPC_POWERNV_RTAS */
-	}
-	/* OPAL is here, do our normal stuff */
-	else {
-		int found_ioda = 0;
+	/* If we don't have OPAL, eg. in sim, just skip PCI probe */
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
+		return;
 
-		/* Look for IODA IO-Hubs. We don't support mixing IODA
-		 * and p5ioc2 due to the need to change some global
-		 * probing flags
-		 */
-		for_each_compatible_node(np, NULL, "ibm,ioda-hub") {
-			pnv_pci_init_ioda_hub(np);
-			found_ioda = 1;
-		}
+	/* Look for IODA IO-Hubs. We don't support mixing IODA
+	 * and p5ioc2 due to the need to change some global
+	 * probing flags
+	 */
+	for_each_compatible_node(np, NULL, "ibm,ioda-hub") {
+		pnv_pci_init_ioda_hub(np);
+		found_ioda = true;
+	}
 
-		/* Look for p5ioc2 IO-Hubs */
-		if (!found_ioda)
-			for_each_compatible_node(np, NULL, "ibm,p5ioc2")
-				pnv_pci_init_p5ioc2_hub(np);
+	/* Look for p5ioc2 IO-Hubs */
+	if (!found_ioda)
+		for_each_compatible_node(np, NULL, "ibm,p5ioc2")
+			pnv_pci_init_p5ioc2_hub(np);
 
-		/* Look for ioda2 built-in PHB3's */
-		for_each_compatible_node(np, NULL, "ibm,ioda2-phb")
-			pnv_pci_init_ioda2_phb(np);
-	}
+	/* Look for ioda2 built-in PHB3's */
+	for_each_compatible_node(np, NULL, "ibm,ioda2-phb")
+		pnv_pci_init_ioda2_phb(np);
 
 	/* Setup the linkage between OF nodes and PHBs */
 	pci_devs_phb_init();
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d2de7d5d7574..499ddc0dcf66 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -32,7 +32,6 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/xics.h>
-#include <asm/rtas.h>
 #include <asm/opal.h>
 #include <asm/kexec.h>
 #include <asm/smp.h>
@@ -278,20 +277,6 @@ static void __init pnv_setup_machdep_opal(void)
 	ppc_md.handle_hmi_exception = opal_handle_hmi_exception;
 }
 
-#ifdef CONFIG_PPC_POWERNV_RTAS
-static void __init pnv_setup_machdep_rtas(void)
-{
-	if (rtas_token("get-time-of-day") != RTAS_UNKNOWN_SERVICE) {
-		ppc_md.get_boot_time = rtas_get_boot_time;
-		ppc_md.get_rtc_time = rtas_get_rtc_time;
-		ppc_md.set_rtc_time = rtas_set_rtc_time;
-	}
-	ppc_md.restart = rtas_restart;
-	pm_power_off = rtas_power_off;
-	ppc_md.halt = rtas_halt;
-}
-#endif /* CONFIG_PPC_POWERNV_RTAS */
-
 static u32 supported_cpuidle_states;
 
 int pnv_save_sprs_for_winkle(void)
@@ -465,10 +450,6 @@ static int __init pnv_probe(void)
 
 	if (firmware_has_feature(FW_FEATURE_OPAL))
 		pnv_setup_machdep_opal();
-#ifdef CONFIG_PPC_POWERNV_RTAS
-	else if (rtas.base)
-		pnv_setup_machdep_rtas();
-#endif /* CONFIG_PPC_POWERNV_RTAS */
 
 	pr_debug("PowerNV detected !\n");
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index fc34025ef822..273d7b46f72a 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -25,7 +25,6 @@
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/firmware.h>
-#include <asm/rtas.h>
 #include <asm/vdso_datapage.h>
 #include <asm/cputhreads.h>
 #include <asm/xics.h>
@@ -241,18 +240,6 @@ void __init pnv_smp_init(void)
 {
 	smp_ops = &pnv_smp_ops;
 
-	/* XXX We don't yet have a proper entry point from HAL, for
-	 * now we rely on kexec-style entry from BML
-	 */
-
-#ifdef CONFIG_PPC_RTAS
-	/* Non-lpar has additional take/give timebase */
-	if (rtas_token("freeze-time-base") != RTAS_UNKNOWN_SERVICE) {
-		smp_ops->give_timebase = rtas_give_timebase;
-		smp_ops->take_timebase = rtas_take_timebase;
-	}
-#endif /* CONFIG_PPC_RTAS */
-
 #ifdef CONFIG_HOTPLUG_CPU
 	ppc_md.cpu_die	= pnv_smp_cpu_kill_self;
 #endif
-- 
2.1.0
