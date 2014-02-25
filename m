Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 100B62C00C3
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 18:28:56 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 02:28:54 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EE855C90026
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 02:28:48 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P7SqK56029798
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 07:28:52 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P7Spb6031678
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 02:28:51 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc/powernv: Dump PHB diag-data immediately
Date: Tue, 25 Feb 2014 15:28:37 +0800
Message-Id: <1393313318-6341-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393313318-6341-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393313318-6341-1-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch intends to fix it by dumping the PHB diag-data immediately
when frozen/fenced state on PE or PHB is detected for the first time
in eeh_ops::get_state() or next_error() backend.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   79 +++++++++++++++--------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 04b4710..6dba684 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -114,6 +114,22 @@ DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_inbB_dbgfs_ops, ioda_eeh_inbB_dbgfs_get,
 			ioda_eeh_inbB_dbgfs_set, "0x%llx\n");
 #endif /* CONFIG_DEBUG_FS */
 
+static void ioda_eeh_phb_diag(struct pci_controller *hose)
+{
+	struct pnv_phb *phb = hose->private_data;
+	long rc;
+
+	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
+					 PNV_PCI_DIAG_BUF_SIZE);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failed to get diag-data for PHB#%x (%ld)\n",
+			__func__, hose->global_number, rc);
+		return;
+	}
+
+	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
+}
+
 /**
  * ioda_eeh_post_init - Chip dependent post initialization
  * @hose: PCI controller
@@ -272,6 +288,9 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
 			result |= EEH_STATE_DMA_ACTIVE;
 			result |= EEH_STATE_MMIO_ENABLED;
 			result |= EEH_STATE_DMA_ENABLED;
+		} else if (!(pe->state & EEH_PE_ISOLATED)) {
+			eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+			ioda_eeh_phb_diag(hose);
 		}
 
 		return result;
@@ -315,6 +334,15 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
 			   __func__, fstate, hose->global_number, pe_no);
 	}
 
+	/* Dump PHB diag-data for frozen PE */
+	if (result != EEH_STATE_NOT_SUPPORT &&
+	    (result & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) !=
+	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE) &&
+	    !(pe->state & EEH_PE_ISOLATED)) {
+		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		ioda_eeh_phb_diag(hose);
+	}
+
 	return result;
 }
 
@@ -541,27 +569,6 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
 			    char *drv_log, unsigned long len)
 {
-	s64 ret;
-	unsigned long flags;
-	struct pci_controller *hose = pe->phb;
-	struct pnv_phb *phb = hose->private_data;
-
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
-
 	return 0;
 }
 
@@ -646,22 +653,6 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
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
@@ -809,6 +800,20 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		}
 
 		/*
+		 * EEH core will try recover from fenced PHB or
+		 * frozen PE. In the time for frozen PE, EEH core
+		 * enable IO path for that before collecting logs,
+		 * but it ruins the site. So we have to dump the
+		 * log in advance here.
+		 */
+		if ((ret == EEH_NEXT_ERR_FROZEN_PE  ||
+		    ret == EEH_NEXT_ERR_FENCED_PHB) &&
+		    !((*pe)->state & EEH_PE_ISOLATED)) {
+			eeh_pe_state_mark(*pe, EEH_PE_ISOLATED);
+			ioda_eeh_phb_diag(hose);
+		}
+
+		/*
 		 * If we have no errors on the specific PHB or only
 		 * informative error there, we continue poking it.
 		 * Otherwise, we need actions to be taken by upper
-- 
1.7.10.4
