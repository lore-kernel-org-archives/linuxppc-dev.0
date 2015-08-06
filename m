Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F57D1A1001
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3D7A7357805E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D4xi24444984
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764CcF3026492
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:39 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 32/42] powerpc/powernv: Introduce pnv_pci_poll()
Date: Thu,  6 Aug 2015 14:11:37 +1000
Message-Id: <1438834307-26960-33-git-send-email-gwshan@linux.vnet.ibm.com>
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

This converts pnv_eeh_poll() to pnv_pci_poll() in order to:

   * Return linux error code other than OPAL error code.
   * The return value from last OPAL call, requested delay, is
     passed to pnv_pci_poll() and delay accordingly. Thus one
     call to opal_pci_poll() is saved.
   * More information (e.g. PCI slot power status) is returned
     if the last argument isn't NULL.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 47 ++++++----------------------
 arch/powerpc/platforms/powernv/pci.c         | 21 +++++++++++++
 arch/powerpc/platforms/powernv/pci.h         |  1 +
 3 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 4ae48ff..e664542 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -745,28 +745,11 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
 	return ret;
 }
 
-static s64 pnv_eeh_poll(uint64_t id)
-{
-	s64 rc = OPAL_HARDWARE;
-
-	while (1) {
-		rc = opal_pci_poll(id, NULL);
-		if (rc <= 0)
-			break;
-
-		if (system_state < SYSTEM_RUNNING)
-			udelay(1000 * rc);
-		else
-			msleep(rc);
-	}
-
-	return rc;
-}
-
 int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc = OPAL_HARDWARE;
+	int ret;
 
 	pr_debug("%s: Reset PHB#%x, option=%d\n",
 		 __func__, hose->global_number, option);
@@ -781,8 +764,6 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 		rc = opal_pci_reset(phb->opal_id,
 				    OPAL_RESET_PHB_COMPLETE,
 				    OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
 
 	/*
 	 * Poll state of the PHB until the request is done
@@ -790,24 +771,22 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 	 * reset followed by hot reset on root bus. So we also
 	 * need the PCI bus settlement delay.
 	 */
-	rc = pnv_eeh_poll(phb->opal_id);
-	if (option == EEH_RESET_DEACTIVATE) {
+	ret = pnv_pci_poll(phb->opal_id, rc, NULL);
+	if (option == EEH_RESET_DEACTIVATE && !ret) {
 		if (system_state < SYSTEM_RUNNING)
 			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
 		else
 			msleep(EEH_PE_RST_SETTLE_TIME);
 	}
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
 
-	return 0;
+	return ret;
 }
 
 static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc = OPAL_HARDWARE;
+	int ret;
 
 	pr_debug("%s: Reset PHB#%x, option=%d\n",
 		 __func__, hose->global_number, option);
@@ -829,18 +808,13 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 		rc = opal_pci_reset(phb->opal_id,
 				    OPAL_RESET_PCI_HOT,
 				    OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
 
 	/* Poll state of the PHB until the request is done */
-	rc = pnv_eeh_poll(phb->opal_id);
-	if (option == EEH_RESET_DEACTIVATE)
+	ret = pnv_pci_poll(phb->opal_id, rc, NULL);
+	if (option == EEH_RESET_DEACTIVATE && !ret)
 		msleep(EEH_PE_RST_SETTLE_TIME);
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
 
-	return 0;
+	return ret;
 }
 
 static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
@@ -930,10 +904,7 @@ static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
 	phb = hose->private_data;
 	id |= (pdev->bus->number << 24) | (pdev->devfn << 16) | phb->opal_id;
 	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
-	if (rc > 0)
-		rc = pnv_eeh_poll(id);
-
-	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+	return pnv_pci_poll(id, rc, NULL);
 }
 
 static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, int pos,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 6c350a2..801e3e8 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -44,6 +44,27 @@
 #define cfg_dbg(fmt...)	do { } while(0)
 //#define cfg_dbg(fmt...)	printk(fmt)
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
+{
+	while (rval > 0) {
+		if (system_state < SYSTEM_RUNNING)
+			udelay(1000 * rval);
+		else
+			msleep(rval);
+
+		rval = opal_pci_poll(id, pval);
+	}
+
+	/*
+	 * The caller expects to retrieve additional information
+	 * if the last argument is valid.
+	 */
+	if (rval == OPAL_SUCCESS && pval)
+		rval = opal_pci_poll(id, pval);
+
+	return rval ? -EIO : 0;
+}
+
 #ifdef CONFIG_PCI_MSI
 int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 2058f06..99d2da6 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -214,6 +214,7 @@ extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction);
 extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval);
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
 int pnv_pci_cfg_read(struct pci_dn *pdn,
-- 
2.1.0
