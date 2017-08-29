Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xhL461YcbzDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:34:14 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v2 3/6] powerpc/eeh: Remove unnecessary pointer to phb
 from eeh_dev
Date: Tue, 29 Aug 2017 17:34:01 +1000
Message-Id: <20170829073404.8885-4-aik@ozlabs.ru>
In-Reply-To: <20170829073404.8885-1-aik@ozlabs.ru>
References: <20170829073404.8885-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The eeh_dev struct already holds a pointer to pci_dn which it does not
exist without and pci_dn itself holds the very same pointer so just
use it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changelog:
v2:
* fixed pseries platform
---
 arch/powerpc/include/asm/eeh.h               |  1 -
 arch/powerpc/kernel/eeh.c                    |  7 +++----
 arch/powerpc/kernel/eeh_dev.c                |  2 --
 arch/powerpc/kernel/eeh_driver.c             |  2 +-
 arch/powerpc/kernel/eeh_pe.c                 | 24 +++++++++++++-----------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  5 ++---
 arch/powerpc/platforms/pseries/eeh_pseries.c |  2 +-
 7 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 26a6a43f8799..777d37aa0a7f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -141,7 +141,6 @@ struct eeh_dev {
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
 	struct list_head rmv_list;	/* Record the removed edevs	*/
-	struct pci_controller *phb;	/* Associated PHB		*/
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
 	bool in_error;			/* Error flag for edev		*/
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 5e6887c40528..66c98c158ee3 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -170,10 +170,10 @@ static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 	char buffer[128];
 
 	n += scnprintf(buf+n, len-n, "%04x:%02x:%02x.%01x\n",
-		       edev->phb->global_number, pdn->busno,
+		       pdn->phb->global_number, pdn->busno,
 		       PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
 	pr_warn("EEH: of node=%04x:%02x:%02x.%01x\n",
-		edev->phb->global_number, pdn->busno,
+		pdn->phb->global_number, pdn->busno,
 		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
 
 	eeh_ops->read_config(pdn, PCI_VENDOR_ID, 4, &cfg);
@@ -1064,7 +1064,7 @@ core_initcall_sync(eeh_init);
  */
 void eeh_add_device_early(struct pci_dn *pdn)
 {
-	struct pci_controller *phb;
+	struct pci_controller *phb = pdn ? pdn->phb : NULL;
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
 	if (!edev)
@@ -1074,7 +1074,6 @@ void eeh_add_device_early(struct pci_dn *pdn)
 		return;
 
 	/* USB Bus children of PCI devices will not have BUID's */
-	phb = edev->phb;
 	if (NULL == phb ||
 	    (eeh_has_flag(EEH_PROBE_MODE_DEVTREE) && 0 == phb->buid))
 		return;
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index d6b2ca70d14d..bdf4a3698a35 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -50,7 +50,6 @@
  */
 struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
 {
-	struct pci_controller *phb = pdn->phb;
 	struct eeh_dev *edev;
 
 	/* Allocate EEH device */
@@ -64,7 +63,6 @@ struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
 	/* Associate EEH device with OF node */
 	pdn->edev = edev;
 	edev->pdn = pdn;
-	edev->phb = phb;
 	INIT_LIST_HEAD(&edev->list);
 	INIT_LIST_HEAD(&edev->rmv_list);
 
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index c405c79e50cd..8b840191df59 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -428,7 +428,7 @@ static void *eeh_add_virt_device(void *data, void *userdata)
 
 	if (!(edev->physfn)) {
 		pr_warn("%s: EEH dev %04x:%02x:%02x.%01x not for VF\n",
-			__func__, edev->phb->global_number, pdn->busno,
+			__func__, pdn->phb->global_number, pdn->busno,
 			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
 		return NULL;
 	}
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 84d79f3da7d6..419c3f07afd5 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -339,11 +339,12 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
 int eeh_add_to_parent_pe(struct eeh_dev *edev)
 {
 	struct eeh_pe *pe, *parent;
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
 	/* Check if the PE number is valid */
 	if (!eeh_has_flag(EEH_VALID_PE_ZERO) && !edev->pe_config_addr) {
 		pr_err("%s: Invalid PE#0 for edev 0x%x on PHB#%x\n",
-		       __func__, edev->config_addr, edev->phb->global_number);
+		       __func__, edev->config_addr, pdn->phb->global_number);
 		return -EINVAL;
 	}
 
@@ -353,7 +354,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	 * PE should be composed of PCI bus and its subordinate
 	 * components.
 	 */
-	pe = eeh_pe_get(edev->pdn->phb, edev->pe_config_addr,
+	pe = eeh_pe_get(pdn->phb, edev->pe_config_addr,
 			edev->config_addr);
 	if (pe && !(pe->type & EEH_PE_INVALID)) {
 		/* Mark the PE as type of PCI bus */
@@ -363,7 +364,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 		/* Put the edev to PE */
 		list_add_tail(&edev->list, &pe->edevs);
 		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Bus PE#%x\n",
-			edev->phb->global_number,
+			 pdn->phb->global_number,
 			edev->config_addr >> 8,
 			PCI_SLOT(edev->config_addr & 0xFF),
 			PCI_FUNC(edev->config_addr & 0xFF),
@@ -386,7 +387,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 
 		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Device "
 			 "PE#%x, Parent PE#%x\n",
-			edev->phb->global_number,
+			 pdn->phb->global_number,
 			edev->config_addr >> 8,
                         PCI_SLOT(edev->config_addr & 0xFF),
                         PCI_FUNC(edev->config_addr & 0xFF),
@@ -396,9 +397,9 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 
 	/* Create a new EEH PE */
 	if (edev->physfn)
-		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
+		pe = eeh_pe_alloc(pdn->phb, EEH_PE_VF);
 	else
-		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
+		pe = eeh_pe_alloc(pdn->phb, EEH_PE_DEVICE);
 	if (!pe) {
 		pr_err("%s: out of memory!\n", __func__);
 		return -ENOMEM;
@@ -414,10 +415,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	 */
 	parent = eeh_pe_get_parent(edev);
 	if (!parent) {
-		parent = eeh_phb_pe_get(edev->phb);
+		parent = eeh_phb_pe_get(pdn->phb);
 		if (!parent) {
 			pr_err("%s: No PHB PE is found (PHB Domain=%d)\n",
-				__func__, edev->phb->global_number);
+				__func__, pdn->phb->global_number);
 			edev->pe = NULL;
 			kfree(pe);
 			return -EEXIST;
@@ -434,7 +435,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	edev->pe = pe;
 	pr_debug("EEH: Add %04x:%02x:%02x.%01x to "
 		 "Device PE#%x, Parent PE#%x\n",
-		 edev->phb->global_number,
+		 pdn->phb->global_number,
 		 edev->config_addr >> 8,
 		 PCI_SLOT(edev->config_addr & 0xFF),
 		 PCI_FUNC(edev->config_addr & 0xFF),
@@ -456,10 +457,11 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 {
 	struct eeh_pe *pe, *parent, *child;
 	int cnt;
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
 	if (!edev->pe) {
 		pr_debug("%s: No PE found for device %04x:%02x:%02x.%01x\n",
-			 __func__,  edev->phb->global_number,
+			 __func__,  pdn->phb->global_number,
 			 edev->config_addr >> 8,
 			 PCI_SLOT(edev->config_addr & 0xFF),
 			 PCI_FUNC(edev->config_addr & 0xFF));
@@ -722,7 +724,7 @@ static void eeh_bridge_check_link(struct eeh_dev *edev)
 		return;
 
 	pr_debug("%s: Check PCIe link for %04x:%02x:%02x.%01x ...\n",
-		 __func__, edev->phb->global_number,
+		 __func__, pdn->phb->global_number,
 		 edev->config_addr >> 8,
 		 PCI_SLOT(edev->config_addr & 0xFF),
 		 PCI_FUNC(edev->config_addr & 0xFF));
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ac8c01cd251c..552b0cd4e8ba 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -926,7 +926,6 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
 				     int pos, u16 mask)
 {
-	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 	int i, status = 0;
 
 	/* Wait for Transaction Pending bit to be cleared */
@@ -940,7 +939,7 @@ static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
 
 	pr_warn("%s: Pending transaction while issuing %sFLR to %04x:%02x:%02x.%01x\n",
 		__func__, type,
-		edev->phb->global_number, pdn->busno,
+		pdn->phb->global_number, pdn->busno,
 		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
 }
 
@@ -1714,7 +1713,7 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 	if (edev->physfn) {
 		ret = pnv_eeh_restore_vf_config(pdn);
 	} else {
-		phb = edev->phb->private_data;
+		phb = pdn->phb->private_data;
 		ret = opal_pci_reinit(phb->opal_id,
 				      OPAL_REINIT_PCI_DEV, edev->config_addr);
 	}
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 1eef46d9cf30..04c8c1827549 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -247,7 +247,7 @@ static void *pseries_eeh_probe(struct pci_dn *pdn, void *data)
 
 	/* Initialize the fake PE */
 	memset(&pe, 0, sizeof(struct eeh_pe));
-	pe.phb = edev->phb;
+	pe.phb = pdn->phb;
 	pe.config_addr = (pdn->busno << 16) | (pdn->devfn << 8);
 
 	/* Enable EEH on the device */
-- 
2.11.0
