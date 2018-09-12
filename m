Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vg6rq3zF3FL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:43 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1J3X3016925
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2meqxfadfk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:41 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:39 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1Nb5161472966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C61A11C04C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:26 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D77DA11C05C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:25 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:25 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B9FDAA03B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/14] powerpc/eeh: Cleanup eeh_pe_state_mark()
Date: Wed, 12 Sep 2018 11:23:31 +1000
In-Reply-To: <cover.1536715396.git.sbobroff@linux.ibm.com>
References: <cover.1536715396.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <a3b721ccbabe740f4d94ad87c06b738798a32b49.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, eeh_pe_state_mark() marks a PE (and it's children) with a
state and then performs additional processing if that state included
EEH_PE_ISOLATED.

The state parameter is always a constant at the call site, so
rearrange eeh_pe_state_mark() into two functions and just call the
appropriate one at each site.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h           |  1 +
 arch/powerpc/kernel/eeh.c                    |  8 +--
 arch/powerpc/kernel/eeh_driver.c             | 10 ++-
 arch/powerpc/kernel/eeh_pe.c                 | 70 +++++++++-----------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  8 +--
 drivers/pci/hotplug/pnv_php.c                |  2 +-
 6 files changed, 46 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 726288048652..f67da277d652 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -58,6 +58,7 @@ void eeh_save_bars(struct eeh_dev *edev);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_pe_state_mark(struct eeh_pe *pe, int state);
+void eeh_pe_mark_isolated(struct eeh_pe *pe);
 void eeh_pe_state_clear(struct eeh_pe *pe, int state);
 void eeh_pe_state_mark_with_cfg(struct eeh_pe *pe, int state);
 void eeh_pe_dev_mode_mark(struct eeh_pe *pe, int mode);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index dd5ac2ad141e..90e718f58676 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -404,7 +404,7 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	}
 
 	/* Isolate the PHB and send event */
-	eeh_pe_state_mark(phb_pe, EEH_PE_ISOLATED);
+	eeh_pe_mark_isolated(phb_pe);
 	eeh_serialize_unlock(flags);
 
 	pr_err("EEH: PHB#%x failure detected, location: %s\n",
@@ -563,7 +563,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	 * with other functions on this device, and functions under
 	 * bridges.
 	 */
-	eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+	eeh_pe_mark_isolated(pe);
 	eeh_serialize_unlock(flags);
 
 	/* Most EEH events are due to device driver bugs.  Having
@@ -830,7 +830,7 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 		break;
 	case pcie_hot_reset:
-		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		eeh_pe_mark_isolated(pe);
 		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
@@ -839,7 +839,7 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
-		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		eeh_pe_mark_isolated(pe);
 		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index ffe8293d1f06..c827617613c1 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -1029,7 +1029,7 @@ void eeh_handle_special_event(void)
 				phb_pe = eeh_phb_pe_get(hose);
 				if (!phb_pe) continue;
 
-				eeh_pe_state_mark(phb_pe, EEH_PE_ISOLATED);
+				eeh_pe_mark_isolated(phb_pe);
 			}
 
 			eeh_serialize_unlock(flags);
@@ -1044,11 +1044,9 @@ void eeh_handle_special_event(void)
 			/* Purge all events of the PHB */
 			eeh_remove_event(pe, true);
 
-			if (rc == EEH_NEXT_ERR_DEAD_PHB)
-				eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
-			else
-				eeh_pe_state_mark(pe,
-					EEH_PE_ISOLATED | EEH_PE_RECOVERING);
+			if (rc != EEH_NEXT_ERR_DEAD_PHB)
+				eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
+			eeh_pe_mark_isolated(pe);
 
 			eeh_serialize_unlock(flags);
 
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 2b376718237f..e43dcefbe73f 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -540,56 +540,50 @@ void eeh_pe_update_time_stamp(struct eeh_pe *pe)
 }
 
 /**
- * __eeh_pe_state_mark - Mark the state for the PE
- * @data: EEH PE
- * @flag: state
+ * eeh_pe_state_mark - Mark specified state for PE and its associated device
+ * @pe: EEH PE
  *
- * The function is used to mark the indicated state for the given
- * PE. Also, the associated PCI devices will be put into IO frozen
- * state as well.
+ * EEH error affects the current PE and its child PEs. The function
+ * is used to mark appropriate state for the affected PEs and the
+ * associated devices.
  */
-static void *__eeh_pe_state_mark(struct eeh_pe *pe, void *flag)
+void eeh_pe_state_mark(struct eeh_pe *root, int state)
 {
-	int state = *((int *)flag);
-	struct eeh_dev *edev, *tmp;
-	struct pci_dev *pdev;
-
-	/* Keep the state of permanently removed PE intact */
-	if (pe->state & EEH_PE_REMOVED)
-		return NULL;
-
-	pe->state |= state;
-
-	/* Offline PCI devices if applicable */
-	if (!(state & EEH_PE_ISOLATED))
-		return NULL;
-
-	eeh_pe_for_each_dev(pe, edev, tmp) {
-		pdev = eeh_dev_to_pci_dev(edev);
-		if (pdev)
-			pdev->error_state = pci_channel_io_frozen;
-	}
-
-	/* Block PCI config access if required */
-	if (pe->state & EEH_PE_CFG_RESTRICTED)
-		pe->state |= EEH_PE_CFG_BLOCKED;
+	struct eeh_pe *pe;
 
-	return NULL;
+	eeh_for_each_pe(root, pe)
+		if (!(pe->state & EEH_PE_REMOVED))
+			pe->state |= state;
 }
+EXPORT_SYMBOL_GPL(eeh_pe_state_mark);
 
 /**
- * eeh_pe_state_mark - Mark specified state for PE and its associated device
+ * eeh_pe_mark_isolated
  * @pe: EEH PE
  *
- * EEH error affects the current PE and its child PEs. The function
- * is used to mark appropriate state for the affected PEs and the
- * associated devices.
+ * Record that a PE has been isolated by marking the PE and it's children as
+ * EEH_PE_ISOLATED (and EEH_PE_CFG_BLOCKED, if required) and their PCI devices
+ * as pci_channel_io_frozen.
  */
-void eeh_pe_state_mark(struct eeh_pe *pe, int state)
+void eeh_pe_mark_isolated(struct eeh_pe *root)
 {
-	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
+	struct eeh_pe *pe;
+	struct eeh_dev *edev;
+	struct pci_dev *pdev;
+
+	eeh_pe_state_mark(root, EEH_PE_ISOLATED);
+	eeh_for_each_pe(root, pe) {
+		list_for_each_entry(edev, &pe->edevs, entry) {
+			pdev = eeh_dev_to_pci_dev(edev);
+			if (pdev)
+				pdev->error_state = pci_channel_io_frozen;
+		}
+		/* Block PCI config access if required */
+		if (pe->state & EEH_PE_CFG_RESTRICTED)
+			pe->state |= EEH_PE_CFG_BLOCKED;
+	}
 }
-EXPORT_SYMBOL_GPL(eeh_pe_state_mark);
+EXPORT_SYMBOL_GPL(eeh_pe_mark_isolated);
 
 static void *__eeh_pe_dev_mode_mark(struct eeh_dev *edev, void *flag)
 {
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a7e59dbf2696..fd1db9f286f1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -590,7 +590,7 @@ static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
 			  EEH_STATE_MMIO_ENABLED |
 			  EEH_STATE_DMA_ENABLED);
 	} else if (!(pe->state & EEH_PE_ISOLATED)) {
-		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		eeh_pe_mark_isolated(pe);
 		pnv_eeh_get_phb_diag(pe);
 
 		if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
@@ -692,7 +692,7 @@ static int pnv_eeh_get_pe_state(struct eeh_pe *pe)
 		if (phb->freeze_pe)
 			phb->freeze_pe(phb, pe->addr);
 
-		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		eeh_pe_mark_isolated(pe);
 		pnv_eeh_get_phb_diag(pe);
 
 		if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
@@ -1597,7 +1597,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 		if ((ret == EEH_NEXT_ERR_FROZEN_PE  ||
 		    ret == EEH_NEXT_ERR_FENCED_PHB) &&
 		    !((*pe)->state & EEH_PE_ISOLATED)) {
-			eeh_pe_state_mark(*pe, EEH_PE_ISOLATED);
+			eeh_pe_mark_isolated(*pe);
 			pnv_eeh_get_phb_diag(*pe);
 
 			if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
@@ -1626,7 +1626,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 			}
 
 			/* We possibly migrate to another PE */
-			eeh_pe_state_mark(*pe, EEH_PE_ISOLATED);
+			eeh_pe_mark_isolated(*pe);
 		}
 
 		/*
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 6c2e8d7307c6..9555338f39c5 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -738,7 +738,7 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 		pe = edev ? edev->pe : NULL;
 		if (pe) {
 			eeh_serialize_lock(&flags);
-			eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+			eeh_pe_mark_isolated(pe);
 			eeh_serialize_unlock(flags);
 			eeh_pe_set_option(pe, EEH_OPT_FREEZE_PE);
 		}
-- 
2.19.0.2.gcad72f5712
