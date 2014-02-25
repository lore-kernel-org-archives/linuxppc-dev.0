Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C7B242C030C
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 16:38:12 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:38:10 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A440FC90026
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:05 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P5c8UN7799056
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 05:38:08 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P5c8eR020753
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:08 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/9] powerpc/powernv: Cache PHB diag-data
Date: Tue, 25 Feb 2014 13:37:48 +0800
Message-Id: <1393306670-17435-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PHB diag-data is useful to help locating the root cause for
frozen PE or fenced PHB. However, EEH core enables IO path by clearing
part of HW registers before collecting it and eventually we got broken
PHB diag-data.

The patch intends to fix it by caching the PHB diag-data in advance
to eeh_pe::data when frozen/fenced state on PE or PHB is detected
for the first time in eeh_ops::get_state() or next_error() backend.
Also, we collect diag-data for INF error without dumping it.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    |   84 ++++++++++++++------------
 arch/powerpc/platforms/powernv/eeh-powernv.c |   32 ++++++----
 arch/powerpc/platforms/powernv/pci.h         |    2 +-
 3 files changed, 67 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 04b4710..cd06c52 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -114,6 +114,23 @@ DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_inbB_dbgfs_ops, ioda_eeh_inbB_dbgfs_get,
 			ioda_eeh_inbB_dbgfs_set, "0x%llx\n");
 #endif /* CONFIG_DEBUG_FS */
 
+static void ioda_eeh_phb_diag(struct pci_controller *hose, char *buf)
+{
+	struct pnv_phb *phb = hose->private_data;
+	long rc;
+
+	if (!buf)
+		return;
+
+	rc = opal_pci_get_phb_diag_data2(phb->opal_id, buf,
+                                         PNV_PCI_DIAG_BUF_SIZE);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failed to get PHB#%x diag-data (%ld)\n",
+			__func__, hose->global_number, rc);
+		return;
+	}
+}
+
 /**
  * ioda_eeh_post_init - Chip dependent post initialization
  * @hose: PCI controller
@@ -224,12 +241,13 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 /**
  * ioda_eeh_get_state - Retrieve the state of PE
  * @pe: EEH PE
+ * @cache_diag: Cache PHB diag-data or not
  *
  * The PE's state should be retrieved from the PEEV, PEST
  * IODA tables. Since the OPAL has exported the function
  * to do it, it'd better to use that.
  */
-static int ioda_eeh_get_state(struct eeh_pe *pe)
+static int ioda_eeh_get_state(struct eeh_pe *pe, bool cache_diag)
 {
 	s64 ret = 0;
 	u8 fstate;
@@ -272,6 +290,9 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
 			result |= EEH_STATE_DMA_ACTIVE;
 			result |= EEH_STATE_MMIO_ENABLED;
 			result |= EEH_STATE_DMA_ENABLED;
+		} else if (cache_diag && !(pe->state & EEH_PE_ISOLATED)) {
+			/* Cache diag-data for fenced PHB */
+			ioda_eeh_phb_diag(hose, pe->data);
 		}
 
 		return result;
@@ -315,6 +336,14 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
 			   __func__, fstate, hose->global_number, pe_no);
 	}
 
+	/* Cache PHB diag-data for frozen PE */
+	if (cache_diag &&
+	    result != EEH_STATE_NOT_SUPPORT &&
+	    (result & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) !=
+	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE) &&
+	    !(pe->state & EEH_PE_ISOLATED))
+		ioda_eeh_phb_diag(hose, pe->data);
+
 	return result;
 }
 
@@ -541,26 +570,10 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
 			    char *drv_log, unsigned long len)
 {
-	s64 ret;
-	unsigned long flags;
-	struct pci_controller *hose = pe->phb;
-	struct pnv_phb *phb = hose->private_data;
+	if (!pe->data)
+		return 0;
 
-	spin_lock_irqsave(&phb->lock, flags);
-
-	ret = opal_pci_get_phb_diag_data2(phb->opal_id,
-			phb->diag.blob, PNV_PCI_DIAG_BUF_SIZE);
-	if (ret) {
-		spin_unlock_irqrestore(&phb->lock, flags);
-		pr_warning("%s: Can't get log for PHB#%x-PE#%x (%lld)\n",
-			   __func__, hose->global_number, pe->addr, ret);
-		return -EIO;
-	}
-
-	/* The PHB diag-data is always indicative */
-	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
-
-	spin_unlock_irqrestore(&phb->lock, flags);
+	pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
 
 	return 0;
 }
@@ -646,22 +659,6 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
 	}
 }
 
-static void ioda_eeh_phb_diag(struct pci_controller *hose)
-{
-	struct pnv_phb *phb = hose->private_data;
-	long rc;
-
-	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
-					 PNV_PCI_DIAG_BUF_SIZE);
-	if (rc != OPAL_SUCCESS) {
-		pr_warning("%s: Failed to get diag-data for PHB#%x (%ld)\n",
-			    __func__, hose->global_number, rc);
-		return;
-	}
-
-	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
-}
-
 static int ioda_eeh_get_pe(struct pci_controller *hose,
 			   u16 pe_no, struct eeh_pe **pe)
 {
@@ -778,7 +775,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				pr_info("EEH: PHB#%x informative error "
 					"detected\n",
 					hose->global_number);
-				ioda_eeh_phb_diag(hose);
+				ioda_eeh_phb_diag(hose, phb->diag.blob);
 				ret = EEH_NEXT_ERR_NONE;
 			}
 
@@ -809,6 +806,19 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		}
 
 		/*
+		 * EEH core will try recover from fenced PHB or
+		 * frozen PE. In the time for frozen PE, EEH core
+		 * enable IO path for that before collecting logs,
+		 * but it ruins the site. So we have to cache the
+		 * log in advance here.
+		 */
+		if (ret == EEH_NEXT_ERR_FROZEN_PE ||
+		    ret == EEH_NEXT_ERR_FENCED_PHB) {
+			eeh_pe_state_mark(*pe, EEH_PE_ISOLATED);
+			ioda_eeh_phb_diag(hose, (*pe)->data);
+		}
+
+		/*
 		 * If we have no errors on the specific PHB or only
 		 * informative error there, we continue poking it.
 		 * Otherwise, we need actions to be taken by upper
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index cfba40a..54051bf 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -190,24 +190,15 @@ static int powernv_eeh_get_pe_addr(struct eeh_pe *pe)
 	return pe->addr;
 }
 
-/**
- * powernv_eeh_get_state - Retrieve PE state
- * @pe: EEH PE
- * @delay: delay while PE state is temporarily unavailable
- *
- * Retrieve the state of the specified PE. For IODA-compitable
- * platform, it should be retrieved from IODA table. Therefore,
- * we prefer passing down to hardware implementation to handle
- * it.
- */
-static int powernv_eeh_get_state(struct eeh_pe *pe, int *delay)
+static int __powernv_eeh_get_state(struct eeh_pe *pe,
+				   int *delay, bool cache_diag)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
 	int ret = EEH_STATE_NOT_SUPPORT;
 
 	if (phb->eeh_ops && phb->eeh_ops->get_state) {
-		ret = phb->eeh_ops->get_state(pe);
+		ret = phb->eeh_ops->get_state(pe, cache_diag);
 
 		/*
 		 * If the PE state is temporarily unavailable,
@@ -225,6 +216,21 @@ static int powernv_eeh_get_state(struct eeh_pe *pe, int *delay)
 }
 
 /**
+ * powernv_eeh_get_state - Retrieve PE state
+ * @pe: EEH PE
+ * @delay: delay while PE state is temporarily unavailable
+ *
+ * Retrieve the state of the specified PE. For IODA-compitable
+ * platform, it should be retrieved from IODA table. Therefore,
+ * we prefer passing down to hardware implementation to handle
+ * it.
+ */
+static int powernv_eeh_get_state(struct eeh_pe *pe, int *delay)
+{
+	return __powernv_eeh_get_state(pe, delay, true);
+}
+
+/**
  * powernv_eeh_reset - Reset the specified PE
  * @pe: EEH PE
  * @option: reset option
@@ -257,7 +263,7 @@ static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
 	int mwait;
 
 	while (1) {
-		ret = powernv_eeh_get_state(pe, &mwait);
+		ret = __powernv_eeh_get_state(pe, &mwait, false);
 
 		/*
 		 * If the PE's state is temporarily unavailable,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 94e3495..3645fc4 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -74,7 +74,7 @@ struct pnv_ioda_pe {
 struct pnv_eeh_ops {
 	int (*post_init)(struct pci_controller *hose);
 	int (*set_option)(struct eeh_pe *pe, int option);
-	int (*get_state)(struct eeh_pe *pe);
+	int (*get_state)(struct eeh_pe *pe, bool cache_diag);
 	int (*reset)(struct eeh_pe *pe, int option);
 	int (*get_log)(struct eeh_pe *pe, int severity,
 		       char *drv_log, unsigned long len);
-- 
1.7.10.4
