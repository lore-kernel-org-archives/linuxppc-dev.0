Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F7201A0C14
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:51:10 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BDCFE140100
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 16:51:08 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 11:21:06 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 006F4E0056
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 11:21:34 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB45rChI65863878
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2014 11:23:12 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB45p3XY001412
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2014 11:21:03 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/powernv: Refactor ioda_eeh_reset()
Date: Thu,  4 Dec 2014 16:50:52 +1100
Message-Id: <1417672253-26692-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1417672253-26692-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1417672253-26692-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch refactors ioda_eeh_reset() to eliminate unnecessary
nested if statements to improve code readability. Except printing
the PHB index in the error message when failing to clear PHB error
injection registers, no logic changed.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 65 ++++++++++++++-----------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 825da60..78d94df 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -665,8 +665,8 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
 	struct pci_bus *bus;
-	int ret;
 
 	/*
 	 * For PHB reset, we always have complete reset. For those PEs whose
@@ -687,50 +687,43 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 		case EEH_RESET_HOT:
 		case EEH_RESET_FUNDAMENTAL:
 		case EEH_RESET_COMPLETE:
-			ret = ioda_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
-			break;
+			return ioda_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
 		case EEH_RESET_DEACTIVATE:
-			ret = 0;
-			break;
+			return 0;
 		default:
-			ret = -EINVAL;
+			return -EINVAL;
 		}
+	}
 
-		return ret;
-	} else {
-		struct pnv_phb *phb;
+	/*
+	 * The frozen PE might be caused by PAPR error injection
+	 * registers, which are expected to be cleared after hitting
+	 * frozen PE as stated in the hardware spec. Unfortunately,
+	 * that's not true on P7IOC. So we have to clear it manually
+	 * to avoid recursive EEH errors during recovery.
+	 */
+	if (phb->model == PNV_PHB_MODEL_P7IOC &&
+	    (option == EEH_RESET_HOT ||
+	     option == EEH_RESET_FUNDAMENTAL)) {
 		s64 rc;
 
-		/*
-		 * The frozen PE might be caused by PAPR error injection
-		 * registers, which are expected to be cleared after hitting
-		 * frozen PE as stated in the hardware spec. Unfortunately,
-		 * that's not true on P7IOC. So we have to clear it manually
-		 * to avoid recursive EEH errors during recovery.
-		 */
-		phb = hose->private_data;
-		if (phb->model == PNV_PHB_MODEL_P7IOC &&
-		    (option == EEH_RESET_HOT ||
-		    option == EEH_RESET_FUNDAMENTAL)) {
-			rc = opal_pci_reset(phb->opal_id,
-					    OPAL_RESET_PHB_ERROR,
-					    OPAL_ASSERT_RESET);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Failure %lld clearing "
-					"error injection registers\n",
-					__func__, rc);
-				return -EIO;
-			}
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PHB_ERROR,
+				    OPAL_ASSERT_RESET);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Failure %lld clearing PHB#%x "
+				"error injection registers\n",
+				__func__, rc, hose->global_number);
+			return -EIO;
 		}
-
-		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus))
-			ret = ioda_eeh_phb_reset(hose, option);
-		else
-			ret = ioda_eeh_bridge_reset(bus->self, option);
 	}
 
-	return ret;
+	/* Route PE reset request */
+	bus = eeh_pe_bus_get(pe);
+	if (pci_is_root_bus(bus))
+		return ioda_eeh_phb_reset(hose, option);
+
+	return ioda_eeh_bridge_reset(bus->self, option);
 }
 
 /**
-- 
1.8.3.2
