Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJTZc5Cl9zDvmJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 14:02:32 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/pci: Always print PHB and PE numbers as hexadecimal
Date: Wed, 16 Nov 2016 14:02:15 +1100
Message-Id: <20161116030215.6886-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PHB, PE (and by association MVE) numbers are printed as a mix of decimal
and hexadecimal throughout the kernel.  This can be misleading, so make
them all hexadecimal.

Standardising on hex instead of dec because:

 - PHB numbers are presented in hex in sysfs/debugfs (and lspci, etc)
 - PE numbers are presented as hex in sysfs and parsed in hex in debugfs

The only place I think this could cause confusing are the messages during
boot, i.e.

	pci 000a:01     : [PE# 000] Secondary bus 1 associated with PE#0

which can be a quick way to check PE numbers.  pe_level_printk() will
only print two characters instead of three, so the above would be

	pci 000a:01     : [PE# 00] Secondary bus 1 associated with PE#0

which gives a hint it's in hex.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
I think I caught them all, if I didn't, let me know!
---
 arch/powerpc/kernel/eeh.c                    |  6 ++---
 arch/powerpc/kernel/eeh_driver.c             |  8 +++---
 arch/powerpc/kernel/eeh_event.c              |  4 +--
 arch/powerpc/kernel/eeh_pe.c                 |  4 +--
 arch/powerpc/platforms/powernv/eeh-powernv.c |  4 +--
 arch/powerpc/platforms/powernv/npu-dma.c     |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c    | 38 ++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci.c         |  6 ++---
 arch/powerpc/platforms/pseries/eeh_pseries.c |  8 +++---
 9 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index f257316..927d162 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -372,7 +372,7 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	/* Find the PHB PE */
 	phb_pe = eeh_phb_pe_get(pe->phb);
 	if (!phb_pe) {
-		pr_warn("%s Can't find PE for PHB#%d\n",
+		pr_warn("%s Can't find PE for PHB#%x\n",
 			__func__, pe->phb->global_number);
 		return -EEXIST;
 	}
@@ -664,7 +664,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
 	rc = eeh_ops->set_option(pe, function);
 	if (rc)
 		pr_warn("%s: Unexpected state change %d on "
-			"PHB#%d-PE#%x, err=%d\n",
+			"PHB#%x-PE#%x, err=%d\n",
 			__func__, function, pe->phb->global_number,
 			pe->addr, rc);
 
@@ -864,7 +864,7 @@ int eeh_reset_pe(struct eeh_pe *pe)
 		}
 
 		if (state < 0) {
-			pr_warn("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
+			pr_warn("%s: Unrecoverable slot failure on PHB#%x-PE#%x",
 				__func__, pe->phb->global_number, pe->addr);
 			ret = -ENOTRECOVERABLE;
 			goto out;
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index a62be72..ac984d2 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -732,7 +732,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 
 	frozen_bus = eeh_pe_bus_get(pe);
 	if (!frozen_bus) {
-		pr_err("%s: Cannot find PCI bus for PHB#%d-PE#%x\n",
+		pr_err("%s: Cannot find PCI bus for PHB#%x-PE#%x\n",
 			__func__, pe->phb->global_number, pe->addr);
 		return;
 	}
@@ -876,7 +876,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * are due to poorly seated PCI cards. Only 10% or so are
 	 * due to actual, failed cards.
 	 */
-	pr_err("EEH: PHB#%d-PE#%x has failed %d times in the\n"
+	pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
 	       "last hour and has been permanently disabled.\n"
 	       "Please try reseating or replacing it.\n",
 		pe->phb->global_number, pe->addr,
@@ -884,7 +884,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	goto perm_error;
 
 hard_fail:
-	pr_err("EEH: Unable to recover from failure from PHB#%d-PE#%x.\n"
+	pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
 	       "Please try reseating or replacing it\n",
 		pe->phb->global_number, pe->addr);
 
@@ -998,7 +998,7 @@ static void eeh_handle_special_event(void)
 				bus = eeh_pe_bus_get(phb_pe);
 				if (!bus) {
 					pr_err("%s: Cannot find PCI bus for "
-					       "PHB#%d-PE#%x\n",
+					       "PHB#%x-PE#%x\n",
 					       __func__,
 					       pe->phb->global_number,
 					       pe->addr);
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 82e7327..accbf8b 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -75,11 +75,11 @@ static int eeh_event_handler(void * dummy)
 		if (pe) {
 			eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
 			if (pe->type & EEH_PE_PHB)
-				pr_info("EEH: Detected error on PHB#%d\n",
+				pr_info("EEH: Detected error on PHB#%x\n",
 					 pe->phb->global_number);
 			else
 				pr_info("EEH: Detected PCI bus error on "
-					"PHB#%d-PE#%x\n",
+					"PHB#%x-PE#%x\n",
 					pe->phb->global_number, pe->addr);
 			eeh_handle_event(pe);
 			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index de7d091..cc4b206 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -104,7 +104,7 @@ int eeh_phb_pe_create(struct pci_controller *phb)
 	/* Put it into the list */
 	list_add_tail(&pe->child, &eeh_phb_pe);
 
-	pr_debug("EEH: Add PE for PHB#%d\n", phb->global_number);
+	pr_debug("EEH: Add PE for PHB#%x\n", phb->global_number);
 
 	return 0;
 }
@@ -333,7 +333,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 
 	/* Check if the PE number is valid */
 	if (!eeh_has_flag(EEH_VALID_PE_ZERO) && !edev->pe_config_addr) {
-		pr_err("%s: Invalid PE#0 for edev 0x%x on PHB#%d\n",
+		pr_err("%s: Invalid PE#0 for edev 0x%x on PHB#%x\n",
 		       __func__, edev->config_addr, edev->phb->global_number);
 		return -EINVAL;
 	}
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 2354ea5..6fb5522 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -393,7 +393,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	/* Create PE */
 	ret = eeh_add_to_parent_pe(edev);
 	if (ret) {
-		pr_warn("%s: Can't add PCI dev %04x:%02x:%02x.%01x to parent PE (%d)\n",
+		pr_warn("%s: Can't add PCI dev %04x:%02x:%02x.%01x to parent PE (%x)\n",
 			__func__, hose->global_number, pdn->busno,
 			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn), ret);
 		return NULL;
@@ -1097,7 +1097,7 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 
 	bus = eeh_pe_bus_get(pe);
 	if (!bus) {
-		pr_err("%s: Cannot find PCI bus for PHB#%d-PE#%x\n",
+		pr_err("%s: Cannot find PCI bus for PHB#%x-PE#%x\n",
 			__func__, pe->phb->global_number, pe->addr);
 		return -EIO;
 	}
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index aec85e7..73b155f 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -263,7 +263,7 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 	/* Enable the bypass window */
 
 	top = roundup_pow_of_two(top);
-	dev_info(&npe->pdev->dev, "Enabling bypass for PE %d\n",
+	dev_info(&npe->pdev->dev, "Enabling bypass for PE %x\n",
 			npe->pe_number);
 	rc = opal_pci_map_pe_dma_window_real(phb->opal_id,
 			npe->pe_number, npe->pe_number,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d4b33dd..73d8144 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -83,7 +83,7 @@ void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			PCI_SLOT(pe->rid), PCI_FUNC(pe->rid));
 #endif /* CONFIG_PCI_IOV*/
 
-	printk("%spci %s: [PE# %.3d] %pV",
+	printk("%spci %s: [PE# %.2x] %pV",
 	       level, pfix, pe->pe_number, &vaf);
 
 	va_end(args);
@@ -146,7 +146,7 @@ static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
 				       OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
 	if (rc != OPAL_SUCCESS)
-		pr_warn("%s: Error %lld unfreezing PHB#%d-PE#%d\n",
+		pr_warn("%s: Error %lld unfreezing PHB#%x-PE#%x\n",
 			__func__, rc, phb->hose->global_number, pe_no);
 
 	return &phb->ioda.pe_array[pe_no];
@@ -155,13 +155,13 @@ static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 {
 	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe_num)) {
-		pr_warn("%s: Invalid PE %d on PHB#%x\n",
+		pr_warn("%s: Invalid PE %x on PHB#%x\n",
 			__func__, pe_no, phb->hose->global_number);
 		return;
 	}
 
 	if (test_and_set_bit(pe_no, phb->ioda.pe_alloc))
-		pr_debug("%s: PE %d was reserved on PHB#%x\n",
+		pr_debug("%s: PE %x was reserved on PHB#%x\n",
 			 __func__, pe_no, phb->hose->global_number);
 
 	pnv_ioda_init_pe(phb, pe_no);
@@ -229,7 +229,7 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
 	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
 		r->end -= (2 * phb->ioda.m64_segsize);
 	else
-		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
+		pr_warn("  Cannot strip M64 segment for reserved PE#%x\n",
 			phb->ioda.reserved_pe_idx);
 
 	return 0;
@@ -291,7 +291,7 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
 				OPAL_M64_WINDOW_TYPE, index, base, 0,
 				PNV_IODA1_M64_SEGS * segsz);
 		if (rc != OPAL_SUCCESS) {
-			pr_warn("  Error %lld setting M64 PHB#%d-BAR#%d\n",
+			pr_warn("  Error %lld setting M64 PHB#%x-BAR#%d\n",
 				rc, phb->hose->global_number, index);
 			goto fail;
 		}
@@ -300,7 +300,7 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
 				OPAL_M64_WINDOW_TYPE, index,
 				OPAL_ENABLE_M64_SPLIT);
 		if (rc != OPAL_SUCCESS) {
-			pr_warn("  Error %lld enabling M64 PHB#%d-BAR#%d\n",
+			pr_warn("  Error %lld enabling M64 PHB#%x-BAR#%d\n",
 				rc, phb->hose->global_number, index);
 			goto fail;
 		}
@@ -316,7 +316,7 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
 	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
 		r->end -= (2 * phb->ioda.m64_segsize);
 	else
-		WARN(1, "Wrong reserved PE#%d on PHB#%d\n",
+		WARN(1, "Wrong reserved PE#%x on PHB#%x\n",
 		     phb->ioda.reserved_pe_idx, phb->hose->global_number);
 
 	return 0;
@@ -414,7 +414,7 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 					pe->pe_number / PNV_IODA1_M64_SEGS,
 					pe->pe_number % PNV_IODA1_M64_SEGS);
 			if (rc != OPAL_SUCCESS)
-				pr_warn("%s: Error %lld mapping M64 for PHB#%d-PE#%d\n",
+				pr_warn("%s: Error %lld mapping M64 for PHB#%x-PE#%x\n",
 					__func__, rc, phb->hose->global_number,
 					pe->pe_number);
 		}
@@ -941,14 +941,14 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 	pe->mve_number = pe->pe_number;
 	rc = opal_pci_set_mve(phb->opal_id, pe->mve_number, pe->pe_number);
 	if (rc != OPAL_SUCCESS) {
-		pe_err(pe, "OPAL error %ld setting up MVE %d\n",
+		pe_err(pe, "OPAL error %ld setting up MVE %x\n",
 		       rc, pe->mve_number);
 		pe->mve_number = -1;
 	} else {
 		rc = opal_pci_set_mve_enable(phb->opal_id,
 					     pe->mve_number, OPAL_ENABLE_MVE);
 		if (rc) {
-			pe_err(pe, "OPAL error %ld enabling MVE %d\n",
+			pe_err(pe, "OPAL error %ld enabling MVE %x\n",
 			       rc, pe->mve_number);
 			pe->mve_number = -1;
 		}
@@ -1159,10 +1159,10 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	pe->rid = bus->busn_res.start << 8;
 
 	if (all)
-		pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
+		pe_info(pe, "Secondary bus %d..%d associated with PE#%x\n",
 			bus->busn_res.start, bus->busn_res.end, pe->pe_number);
 	else
-		pe_info(pe, "Secondary bus %d associated with PE#%d\n",
+		pe_info(pe, "Secondary bus %d associated with PE#%x\n",
 			bus->busn_res.start, pe->pe_number);
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
@@ -1213,7 +1213,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
 			 * peer NPU.
 			 */
 			dev_info(&npu_pdev->dev,
-				"Associating to existing PE %d\n", pe_num);
+				"Associating to existing PE %x\n", pe_num);
 			pci_dev_get(npu_pdev);
 			npu_pdn = pci_get_pdn(npu_pdev);
 			rid = npu_pdev->bus->number << 8 | npu_pdn->devfn;
@@ -1539,7 +1539,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
 			   pci_iov_virtfn_devfn(pdev, vf_index);
 
-		pe_info(pe, "VF %04d:%02d:%02d.%d associated with PE#%d\n",
+		pe_info(pe, "VF %04d:%02d:%02d.%d associated with PE#%x\n",
 			hose->global_number, pdev->bus->number,
 			PCI_SLOT(pci_iov_virtfn_devfn(pdev, vf_index)),
 			PCI_FUNC(pci_iov_virtfn_devfn(pdev, vf_index)), pe_num);
@@ -2844,7 +2844,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 	pnv_set_msi_irq_chip(phb, virq);
 
 	pr_devel("%s: %s-bit MSI on hwirq %x (xive #%d),"
-		 " address=%x_%08x data=%x PE# %d\n",
+		 " address=%x_%08x data=%x PE# %x\n",
 		 pci_name(dev), is_64 ? "64" : "32", hwirq, xive_num,
 		 msg->address_hi, msg->address_lo, data, pe->pe_number);
 
@@ -2993,7 +2993,7 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
 			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
 				pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
 			if (rc != OPAL_SUCCESS) {
-				pr_err("%s: Error %lld mapping IO segment#%d to PE#%d\n",
+				pr_err("%s: Error %lld mapping IO segment#%d to PE#%x\n",
 				       __func__, rc, index, pe->pe_number);
 				break;
 			}
@@ -3017,7 +3017,7 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
 			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
 				pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
 			if (rc != OPAL_SUCCESS) {
-				pr_err("%s: Error %lld mapping M32 segment#%d to PE#%d",
+				pr_err("%s: Error %lld mapping M32 segment#%d to PE#%x",
 				       __func__, rc, index, pe->pe_number);
 				break;
 			}
@@ -3281,7 +3281,7 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 		break;
 	default:
-		pr_warn("%s: No DMA for PHB#%d (type %d)\n",
+		pr_warn("%s: No DMA for PHB#%x (type %d)\n",
 			__func__, phb->hose->global_number, phb->type);
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index db7b802..c6d554f 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -234,7 +234,7 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
 	int i;
 
 	data = (struct OpalIoP7IOCPhbErrorData *)common;
-	pr_info("P7IOC PHB#%d Diag-data (Version: %d)\n",
+	pr_info("P7IOC PHB#%x Diag-data (Version: %d)\n",
 		hose->global_number, be32_to_cpu(common->version));
 
 	if (data->brdgCtl)
@@ -326,7 +326,7 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
 	int i;
 
 	data = (struct OpalIoPhb3ErrorData*)common;
-	pr_info("PHB3 PHB#%d Diag-data (Version: %d)\n",
+	pr_info("PHB3 PHB#%x Diag-data (Version: %d)\n",
 		hose->global_number, be32_to_cpu(common->version));
 	if (data->brdgCtl)
 		pr_info("brdgCtl:     %08x\n",
@@ -516,7 +516,7 @@ static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
 		}
 	}
 
-	pr_devel(" -> EEH check, bdfn=%04x PE#%d fstate=%x\n",
+	pr_devel(" -> EEH check, bdfn=%04x PE#%x fstate=%x\n",
 		 (pdn->busno << 8) | (pdn->devfn), pe_no, fstate);
 
 	/* Clear the frozen state if applicable */
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 1c428f0..1eef46d 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -270,7 +270,7 @@ static void *pseries_eeh_probe(struct pci_dn *pdn, void *data)
 			eeh_add_flag(EEH_ENABLED);
 			eeh_add_to_parent_pe(edev);
 
-			pr_debug("%s: EEH enabled on %02x:%02x.%01x PHB#%d-PE#%x\n",
+			pr_debug("%s: EEH enabled on %02x:%02x.%01x PHB#%x-PE#%x\n",
 				__func__, pdn->busno, PCI_SLOT(pdn->devfn),
 				PCI_FUNC(pdn->devfn), pe.phb->global_number,
 				pe.addr);
@@ -371,7 +371,7 @@ static int pseries_eeh_get_pe_addr(struct eeh_pe *pe)
 				pe->config_addr, BUID_HI(pe->phb->buid),
 				BUID_LO(pe->phb->buid), 0);
 		if (ret) {
-			pr_warn("%s: Failed to get address for PHB#%d-PE#%x\n",
+			pr_warn("%s: Failed to get address for PHB#%x-PE#%x\n",
 				__func__, pe->phb->global_number, pe->config_addr);
 			return 0;
 		}
@@ -384,7 +384,7 @@ static int pseries_eeh_get_pe_addr(struct eeh_pe *pe)
 				pe->config_addr, BUID_HI(pe->phb->buid),
 				BUID_LO(pe->phb->buid), 0);
 		if (ret) {
-			pr_warn("%s: Failed to get address for PHB#%d-PE#%x\n",
+			pr_warn("%s: Failed to get address for PHB#%x-PE#%x\n",
 				__func__, pe->phb->global_number, pe->config_addr);
 			return 0;
 		}
@@ -653,7 +653,7 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
 		rtas_busy_delay(ret);
 	}
 
-	pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
+	pr_warn("%s: Unable to configure bridge PHB#%x-PE#%x (%d)\n",
 		__func__, pe->phb->global_number, pe->addr, ret);
 	return ret;
 }
-- 
2.10.2
