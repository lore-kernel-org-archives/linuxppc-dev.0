Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 500C11A090E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:47:13 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 18B81140213
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:13 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:47:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 409792CE8056
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:11 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3l3to46858468
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:11 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3kbRX030273
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:37 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/10] powerpc/powernv: Drop PHB operation set_option()
Date: Mon, 16 Feb 2015 14:45:44 +1100
Message-Id: <1424058348-28951-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch drops PHB EEH operation set_option() and merges its
logic to eeh_ops::set_option().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 84 ----------------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 61 +++++++++++++++++---
 arch/powerpc/platforms/powernv/pci.h         |  1 -
 3 files changed, 54 insertions(+), 92 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 6459516..349c083 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -34,89 +34,6 @@
 #include "powernv.h"
 #include "pci.h"
 
-/**
- * ioda_eeh_set_option - Set EEH operation or I/O setting
- * @pe: EEH PE
- * @option: options
- *
- * Enable or disable EEH option for the indicated PE. The
- * function also can be used to enable I/O or DMA for the
- * PE.
- */
-static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
-{
-	struct pci_controller *hose = pe->phb;
-	struct pnv_phb *phb = hose->private_data;
-	bool freeze_pe = false;
-	int enable, ret = 0;
-	s64 rc;
-
-	/* Check on PE number */
-	if (pe->addr < 0 || pe->addr >= phb->ioda.total_pe) {
-		pr_err("%s: PE address %x out of range [0, %x] "
-		       "on PHB#%x\n",
-			__func__, pe->addr, phb->ioda.total_pe,
-			hose->global_number);
-		return -EINVAL;
-	}
-
-	switch (option) {
-	case EEH_OPT_DISABLE:
-		return -EPERM;
-	case EEH_OPT_ENABLE:
-		return 0;
-	case EEH_OPT_THAW_MMIO:
-		enable = OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO;
-		break;
-	case EEH_OPT_THAW_DMA:
-		enable = OPAL_EEH_ACTION_CLEAR_FREEZE_DMA;
-		break;
-	case EEH_OPT_FREEZE_PE:
-		freeze_pe = true;
-		enable = OPAL_EEH_ACTION_SET_FREEZE_ALL;
-		break;
-	default:
-		pr_warn("%s: Invalid option %d\n",
-			__func__, option);
-		return -EINVAL;
-	}
-
-	/* If PHB supports compound PE, to handle it */
-	if (freeze_pe) {
-		if (phb->freeze_pe) {
-			phb->freeze_pe(phb, pe->addr);
-		} else {
-			rc = opal_pci_eeh_freeze_set(phb->opal_id,
-						     pe->addr,
-						     enable);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Failure %lld freezing "
-					"PHB#%x-PE#%x\n",
-					__func__, rc,
-					phb->hose->global_number, pe->addr);
-				ret = -EIO;
-			}
-		}
-	} else {
-		if (phb->unfreeze_pe) {
-			ret = phb->unfreeze_pe(phb, pe->addr, enable);
-		} else {
-			rc = opal_pci_eeh_freeze_clear(phb->opal_id,
-						       pe->addr,
-						       enable);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Failure %lld enable %d "
-					"for PHB#%x-PE#%x\n",
-					__func__, rc, option,
-					phb->hose->global_number, pe->addr);
-				ret = -EIO;
-			}
-		}
-	}
-
-	return ret;
-}
-
 static void ioda_eeh_phb_diag(struct eeh_pe *pe)
 {
 	struct pnv_phb *phb = pe->phb->private_data;
@@ -869,7 +786,6 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 }
 
 struct pnv_eeh_ops ioda_eeh_ops = {
-	.set_option		= ioda_eeh_set_option,
 	.get_state		= ioda_eeh_get_state,
 	.reset			= ioda_eeh_reset,
 	.next_error		= ioda_eeh_next_error
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a7087f4..2429a23 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -407,14 +407,61 @@ static int pnv_eeh_set_option(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
-	int ret = -EEXIST;
+	bool freeze_pe = false;
+	int opt, ret = 0;
+	s64 rc;
 
-	/*
-	 * What we need do is pass it down for hardware
-	 * implementation to handle it.
-	 */
-	if (phb->eeh_ops && phb->eeh_ops->set_option)
-		ret = phb->eeh_ops->set_option(pe, option);
+	/* Sanity check on option */
+	switch (option) {
+	case EEH_OPT_DISABLE:
+		return -EPERM;
+	case EEH_OPT_ENABLE:
+		return 0;
+	case EEH_OPT_THAW_MMIO:
+		opt = OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO;
+		break;
+	case EEH_OPT_THAW_DMA:
+		opt = OPAL_EEH_ACTION_CLEAR_FREEZE_DMA;
+		break;
+	case EEH_OPT_FREEZE_PE:
+		freeze_pe = true;
+		opt = OPAL_EEH_ACTION_SET_FREEZE_ALL;
+		break;
+	default:
+		pr_warn("%s: Invalid option %d\n", __func__, option);
+		return -EINVAL;
+	}
+
+	/* If PHB supports compound PE, to handle it */
+	if (freeze_pe) {
+		if (phb->freeze_pe) {
+			phb->freeze_pe(phb, pe->addr);
+		} else {
+			rc = opal_pci_eeh_freeze_set(phb->opal_id,
+						     pe->addr, opt);
+			if (rc != OPAL_SUCCESS) {
+				pr_warn("%s: Failure %lld freezing "
+					"PHB#%x-PE#%x\n",
+					__func__, rc,
+					phb->hose->global_number, pe->addr);
+				ret = -EIO;
+			}
+		}
+	} else {
+		if (phb->unfreeze_pe) {
+			ret = phb->unfreeze_pe(phb, pe->addr, opt);
+		} else {
+			rc = opal_pci_eeh_freeze_clear(phb->opal_id,
+						       pe->addr, opt);
+			if (rc != OPAL_SUCCESS) {
+				pr_warn("%s: Failure %lld enable %d "
+					"for PHB#%x-PE#%x\n",
+					__func__, rc, option,
+					phb->hose->global_number, pe->addr);
+				ret = -EIO;
+			}
+		}
+	}
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index d8808ca..8043dee 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -78,7 +78,6 @@ struct pnv_ioda_pe {
 /* IOC dependent EEH operations */
 #ifdef CONFIG_EEH
 struct pnv_eeh_ops {
-	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_state)(struct eeh_pe *pe);
 	int (*reset)(struct eeh_pe *pe, int option);
 	int (*next_error)(struct eeh_pe **pe);
-- 
1.8.3.2
