Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437491A01AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:25 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 15:50:24 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3A3A12BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6G5RdwA29491454
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:27:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6G5oMFu024781
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] powerpc/eeh: Replace pr_warning() with pr_warn()
Date: Wed, 16 Jul 2014 15:50:17 +1000
Message-Id: <1405489819-26211-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pr_warn() is equal to pr_warning(), but the former is a bit more
formal. The patch replaces pr_warning() with pr_warn().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c                    | 16 ++++++++--------
 arch/powerpc/kernel/eeh_cache.c              |  7 ++++---
 arch/powerpc/kernel/eeh_dev.c                |  3 ++-
 arch/powerpc/kernel/eeh_driver.c             | 16 ++++++++--------
 arch/powerpc/kernel/eeh_pe.c                 |  3 ++-
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 12 ++++++------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  7 ++++---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 28 ++++++++++++++--------------
 8 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 123c151..dcc2a95 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -334,8 +334,8 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	/* Find the PHB PE */
 	phb_pe = eeh_phb_pe_get(pe->phb);
 	if (!phb_pe) {
-		pr_warning("%s Can't find PE for PHB#%d\n",
-			   __func__, pe->phb->global_number);
+		pr_warn("%s Can't find PE for PHB#%d\n",
+			__func__, pe->phb->global_number);
 		return -EEXIST;
 	}
 
@@ -784,13 +784,13 @@ void eeh_save_bars(struct eeh_dev *edev)
 int __init eeh_ops_register(struct eeh_ops *ops)
 {
 	if (!ops->name) {
-		pr_warning("%s: Invalid EEH ops name for %p\n",
+		pr_warn("%s: Invalid EEH ops name for %p\n",
 			__func__, ops);
 		return -EINVAL;
 	}
 
 	if (eeh_ops && eeh_ops != ops) {
-		pr_warning("%s: EEH ops of platform %s already existing (%s)\n",
+		pr_warn("%s: EEH ops of platform %s already existing (%s)\n",
 			__func__, eeh_ops->name, ops->name);
 		return -EEXIST;
 	}
@@ -810,7 +810,7 @@ int __init eeh_ops_register(struct eeh_ops *ops)
 int __exit eeh_ops_unregister(const char *name)
 {
 	if (!name || !strlen(name)) {
-		pr_warning("%s: Invalid EEH ops name\n",
+		pr_warn("%s: Invalid EEH ops name\n",
 			__func__);
 		return -EINVAL;
 	}
@@ -875,11 +875,11 @@ int eeh_init(void)
 
 	/* call platform initialization function */
 	if (!eeh_ops) {
-		pr_warning("%s: Platform EEH operation not found\n",
+		pr_warn("%s: Platform EEH operation not found\n",
 			__func__);
 		return -EEXIST;
 	} else if ((ret = eeh_ops->init())) {
-		pr_warning("%s: Failed to call platform init function (%d)\n",
+		pr_warn("%s: Failed to call platform init function (%d)\n",
 			__func__, ret);
 		return ret;
 	}
@@ -920,7 +920,7 @@ int eeh_init(void)
 	if (eeh_enabled())
 		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
 	else
-		pr_warning("EEH: No capable adapters found\n");
+		pr_warn("EEH: No capable adapters found\n");
 
 	return ret;
 }
diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 3639bee..07d8a24 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -143,7 +143,7 @@ eeh_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
 		} else {
 			if (dev != piar->pcidev ||
 			    alo != piar->addr_lo || ahi != piar->addr_hi) {
-				pr_warning("PIAR: overlapping address range\n");
+				pr_warn("PIAR: overlapping address range\n");
 			}
 			return piar;
 		}
@@ -177,13 +177,14 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 
 	dn = pci_device_to_OF_node(dev);
 	if (!dn) {
-		pr_warning("PCI: no pci dn found for dev=%s\n", pci_name(dev));
+		pr_warn("PCI: no pci dn found for dev=%s\n",
+			pci_name(dev));
 		return;
 	}
 
 	edev = of_node_to_eeh_dev(dn);
 	if (!edev) {
-		pr_warning("PCI: no EEH dev found for dn=%s\n",
+		pr_warn("PCI: no EEH dev found for dn=%s\n",
 			dn->full_name);
 		return;
 	}
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index 1efa28f..e5274ee 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -57,7 +57,8 @@ void *eeh_dev_init(struct device_node *dn, void *data)
 	/* Allocate EEH device */
 	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
 	if (!edev) {
-		pr_warning("%s: out of memory\n", __func__);
+		pr_warn("%s: out of memory\n",
+			__func__);
 		return NULL;
 	}
 
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 420da61..6a0dcee 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -599,7 +599,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	pe->freeze_count++;
 	if (pe->freeze_count > EEH_MAX_ALLOWED_FREEZES)
 		goto excess_failures;
-	pr_warning("EEH: This PCI device has failed %d times in the last hour\n",
+	pr_warn("EEH: This PCI device has failed %d times in the last hour\n",
 		pe->freeze_count);
 
 	/* Walk the various device drivers attached to this slot through
@@ -616,7 +616,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	 */
 	rc = eeh_ops->wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
 	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
-		pr_warning("EEH: Permanent failure\n");
+		pr_warn("EEH: Permanent failure\n");
 		goto hard_fail;
 	}
 
@@ -635,8 +635,8 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 		pr_info("EEH: Reset with hotplug activity\n");
 		rc = eeh_reset_device(pe, frozen_bus);
 		if (rc) {
-			pr_warning("%s: Unable to reset, err=%d\n",
-				   __func__, rc);
+			pr_warn("%s: Unable to reset, err=%d\n",
+				__func__, rc);
 			goto hard_fail;
 		}
 	}
@@ -678,7 +678,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 
 	/* If any device has a hard failure, then shut off everything. */
 	if (result == PCI_ERS_RESULT_DISCONNECT) {
-		pr_warning("EEH: Device driver gave up\n");
+		pr_warn("EEH: Device driver gave up\n");
 		goto hard_fail;
 	}
 
@@ -687,8 +687,8 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 		pr_info("EEH: Reset without hotplug activity\n");
 		rc = eeh_reset_device(pe, NULL);
 		if (rc) {
-			pr_warning("%s: Cannot reset, err=%d\n",
-				   __func__, rc);
+			pr_warn("%s: Cannot reset, err=%d\n",
+				__func__, rc);
 			goto hard_fail;
 		}
 
@@ -701,7 +701,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	/* All devices should claim they have recovered by now. */
 	if ((result != PCI_ERS_RESULT_RECOVERED) &&
 	    (result != PCI_ERS_RESULT_NONE)) {
-		pr_warning("EEH: Not recovered\n");
+		pr_warn("EEH: Not recovered\n");
 		goto hard_fail;
 	}
 
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 418d79c..77632ab 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -179,7 +179,8 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
 	void *ret;
 
 	if (!root) {
-		pr_warning("%s: Invalid PE %p\n", __func__, root);
+		pr_warn("%s: Invalid PE %p\n",
+			__func__, root);
 		return NULL;
 	}
 
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 7f6bee1..edec622 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -244,8 +244,8 @@ static void ioda_eeh_phb_diag(struct pci_controller *hose)
 	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
 					 PNV_PCI_DIAG_BUF_SIZE);
 	if (rc != OPAL_SUCCESS) {
-		pr_warning("%s: Failed to get diag-data for PHB#%x (%ld)\n",
-			    __func__, hose->global_number, rc);
+		pr_warn("%s: Failed to get diag-data for PHB#%x (%ld)\n",
+			__func__, hose->global_number, rc);
 		return;
 	}
 
@@ -661,8 +661,8 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
 
 	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, sizeof(*data));
 	if (rc != OPAL_SUCCESS) {
-		pr_warning("%s: Failed to get HUB#%llx diag-data (%ld)\n",
-			   __func__, phb->hub_id, rc);
+		pr_warn("%s: Failed to get HUB#%llx diag-data (%ld)\n",
+			__func__, phb->hub_id, rc);
 		return;
 	}
 
@@ -698,8 +698,8 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
 		ioda_eeh_hub_diag_common(data);
 		break;
 	default:
-		pr_warning("%s: Invalid type of HUB#%llx diag-data (%d)\n",
-			   __func__, phb->hub_id, data->type);
+		pr_warn("%s: Invalid type of HUB#%llx diag-data (%d)\n",
+			__func__, phb->hub_id, data->type);
 	}
 }
 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 740c396..f1f5d4b 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -50,7 +50,8 @@ static int powernv_eeh_init(void)
 
 	/* We require OPALv3 */
 	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
-		pr_warning("%s: OPALv3 is required !\n", __func__);
+		pr_warn("%s: OPALv3 is required !\n",
+			__func__);
 		return -EINVAL;
 	}
 
@@ -304,8 +305,8 @@ static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
 
 		max_wait -= mwait;
 		if (max_wait <= 0) {
-			pr_warning("%s: Timeout getting PE#%x's state (%d)\n",
-				   __func__, pe->addr, max_wait);
+			pr_warn("%s: Timeout getting PE#%x's state (%d)\n",
+				__func__, pe->addr, max_wait);
 			return EEH_STATE_NOT_SUPPORT;
 		}
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 1e15cdd..a81c063 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -89,26 +89,26 @@ static int pseries_eeh_init(void)
 	 * of domain/bus/slot/function for EEH RTAS operations.
 	 */
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("%s: RTAS service <ibm,set-eeh-option> invalid\n",
+		pr_warn("%s: RTAS service <ibm,set-eeh-option> invalid\n",
 			__func__);
 		return -EINVAL;
 	} else if (ibm_set_slot_reset == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("%s: RTAS service <ibm,set-slot-reset> invalid\n",
+		pr_warn("%s: RTAS service <ibm,set-slot-reset> invalid\n",
 			__func__);
 		return -EINVAL;
 	} else if (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
 		   ibm_read_slot_reset_state == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("%s: RTAS service <ibm,read-slot-reset-state2> and "
+		pr_warn("%s: RTAS service <ibm,read-slot-reset-state2> and "
 			"<ibm,read-slot-reset-state> invalid\n",
 			__func__);
 		return -EINVAL;
 	} else if (ibm_slot_error_detail == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("%s: RTAS service <ibm,slot-error-detail> invalid\n",
+		pr_warn("%s: RTAS service <ibm,slot-error-detail> invalid\n",
 			__func__);
 		return -EINVAL;
 	} else if (ibm_configure_pe == RTAS_UNKNOWN_SERVICE &&
 		   ibm_configure_bridge == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("%s: RTAS service <ibm,configure-pe> and "
+		pr_warn("%s: RTAS service <ibm,configure-pe> and "
 			"<ibm,configure-bridge> invalid\n",
 			__func__);
 		return -EINVAL;
@@ -118,11 +118,11 @@ static int pseries_eeh_init(void)
 	spin_lock_init(&slot_errbuf_lock);
 	eeh_error_buf_size = rtas_token("rtas-error-log-max");
 	if (eeh_error_buf_size == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("%s: unknown EEH error log size\n",
+		pr_warn("%s: unknown EEH error log size\n",
 			__func__);
 		eeh_error_buf_size = 1024;
 	} else if (eeh_error_buf_size > RTAS_ERROR_LOG_MAX) {
-		pr_warning("%s: EEH error log size %d exceeds the maximal %d\n",
+		pr_warn("%s: EEH error log size %d exceeds the maximal %d\n",
 			__func__, eeh_error_buf_size, RTAS_ERROR_LOG_MAX);
 		eeh_error_buf_size = RTAS_ERROR_LOG_MAX;
 	}
@@ -270,7 +270,7 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 	/* Retrieve the device address */
 	regs = of_get_property(dn, "reg", NULL);
 	if (!regs) {
-		pr_warning("%s: OF node property %s::reg not found\n",
+		pr_warn("%s: OF node property %s::reg not found\n",
 			__func__, dn->full_name);
 		return NULL;
 	}
@@ -398,7 +398,7 @@ static int pseries_eeh_get_pe_addr(struct eeh_pe *pe)
 				pe->config_addr, BUID_HI(pe->phb->buid),
 				BUID_LO(pe->phb->buid), 0);
 		if (ret) {
-			pr_warning("%s: Failed to get address for PHB#%d-PE#%x\n",
+			pr_warn("%s: Failed to get address for PHB#%d-PE#%x\n",
 				__func__, pe->phb->global_number, pe->config_addr);
 			return 0;
 		}
@@ -411,7 +411,7 @@ static int pseries_eeh_get_pe_addr(struct eeh_pe *pe)
 				pe->config_addr, BUID_HI(pe->phb->buid),
 				BUID_LO(pe->phb->buid), 0);
 		if (ret) {
-			pr_warning("%s: Failed to get address for PHB#%d-PE#%x\n",
+			pr_warn("%s: Failed to get address for PHB#%d-PE#%x\n",
 				__func__, pe->phb->global_number, pe->config_addr);
 			return 0;
 		}
@@ -584,17 +584,17 @@ static int pseries_eeh_wait_state(struct eeh_pe *pe, int max_wait)
 			return ret;
 
 		if (max_wait <= 0) {
-			pr_warning("%s: Timeout when getting PE's state (%d)\n",
+			pr_warn("%s: Timeout when getting PE's state (%d)\n",
 				__func__, max_wait);
 			return EEH_STATE_NOT_SUPPORT;
 		}
 
 		if (mwait <= 0) {
-			pr_warning("%s: Firmware returned bad wait value %d\n",
+			pr_warn("%s: Firmware returned bad wait value %d\n",
 				__func__, mwait);
 			mwait = EEH_STATE_MIN_WAIT_TIME;
 		} else if (mwait > EEH_STATE_MAX_WAIT_TIME) {
-			pr_warning("%s: Firmware returned too long wait value %d\n",
+			pr_warn("%s: Firmware returned too long wait value %d\n",
 				__func__, mwait);
 			mwait = EEH_STATE_MAX_WAIT_TIME;
 		}
@@ -675,7 +675,7 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
 	}
 
 	if (ret)
-		pr_warning("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
+		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
 			__func__, pe->phb->global_number, pe->addr, ret);
 
 	return ret;
-- 
1.8.3.2
