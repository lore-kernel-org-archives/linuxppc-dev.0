Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 747EC1A0CC4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D3DB13578055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:49 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDf9V39256242
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:49 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDGnu030236
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:17 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 37/50] powerpc/powernv: Simplify pnv_eeh_reset()
Date: Thu,  5 Nov 2015 00:12:37 +1100
Message-Id: <1446642770-4681-38-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This drops unnecessary nested if statements in pnv_eeh_reset() to
improve the code readability. After the changes, the unused local
variable "ret" is dropped as well. No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 61 ++++++++++++----------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 861a7d2..a7d84a4 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -907,8 +907,9 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb;
 	struct pci_bus *bus;
-	int ret;
+	int64_t rc;
 
 	/*
 	 * For PHB reset, we always have complete reset. For those PEs whose
@@ -924,43 +925,35 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
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
+	    (option == EEH_RESET_HOT || option == EEH_RESET_FUNDAMENTAL)) {
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PHB_ERROR,
+				    OPAL_ASSERT_RESET);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Error %lld clearing error injection\n",
+				__func__, rc);
+			return -EIO;
 		}
-
-		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus) ||
-			pci_is_root_bus(bus->parent))
-			ret = pnv_eeh_root_reset(hose, option);
-		else
-			ret = pnv_eeh_bridge_reset(bus->self, option);
 	}
 
-	return ret;
+	bus = eeh_pe_bus_get(pe);
+	if (pci_is_root_bus(bus) ||
+	    pci_is_root_bus(bus->parent))
+		return pnv_eeh_root_reset(hose, option);
+
+	return pnv_eeh_bridge_reset(bus->self, option);
 }
 
 /**
-- 
2.1.0
