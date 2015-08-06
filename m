Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F54A1A0FFD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:17 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 043AD3578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D0NO65077436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764CbWx001273
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 26/42] powerpc/powernv: Simplify pnv_eeh_reset()
Date: Thu,  6 Aug 2015 14:11:31 +1000
Message-Id: <1438834307-26960-27-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This simplifies pnv_eeh_reset() by avoiding the unnecessary nested
"if" statement. No logicial changes introduced by this.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 65 +++++++++++++---------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 7be2ebf..95332e9 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1086,7 +1086,9 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
 	struct pci_bus *bus;
+	int64_t rc;
 	int ret;
 
 	/*
@@ -1103,44 +1105,39 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 	 * reset. The side effect is that EEH core has to clear the frozen
 	 * state explicitly after BAR restore.
 	 */
-	if (pe->type & EEH_PE_PHB) {
-		ret = pnv_eeh_phb_reset(hose, option);
-	} else {
-		struct pnv_phb *phb;
-		s64 rc;
+	if (pe->type & EEH_PE_PHB)
+		return pnv_eeh_phb_reset(hose, option);
 
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
+	/*
+	 * The frozen PE might be caused by PAPR error injection
+	 * registers, which are expected to be cleared after hitting
+	 * frozen PE as stated in the hardware spec. Unfortunately,
+	 * that's not true on P7IOC. So we have to clear it manually
+	 * to avoid recursive EEH errors during recovery.
+	 */
+	phb = hose->private_data;
+	if (phb->model == PNV_PHB_MODEL_P7IOC &&
+	    (option == EEH_RESET_HOT ||
+	    option == EEH_RESET_FUNDAMENTAL)) {
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PHB_ERROR,
+				    OPAL_ASSERT_RESET);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Error %lld clearing errinjct registers\n",
+				__func__, rc);
+			return -EIO;
 		}
-
-		bus = eeh_pe_bus_get(pe);
-		if (pe->type & EEH_PE_VF)
-			ret = pnv_eeh_vf_pe_reset(pe, option);
-		else if (pci_is_root_bus(bus) ||
-			pci_is_root_bus(bus->parent))
-			ret = pnv_eeh_root_reset(hose, option);
-		else
-			ret = pnv_eeh_bridge_reset(bus->self, option);
 	}
 
+	bus = eeh_pe_bus_get(pe);
+	if (pe->type & EEH_PE_VF)
+		ret = pnv_eeh_vf_pe_reset(pe, option);
+	else if (pci_is_root_bus(bus) ||
+		 pci_is_root_bus(bus->parent))
+		ret = pnv_eeh_root_reset(hose, option);
+	else
+		ret = pnv_eeh_bridge_reset(bus->self, option);
+
 	return ret;
 }
 
-- 
2.1.0
