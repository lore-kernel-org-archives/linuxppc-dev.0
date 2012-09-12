Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9C2A2C0095
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 15:16:34 +1000 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 12 Sep 2012 01:16:31 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C3D5E6E803F
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 01:16:28 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8C5GSIa126724
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 01:16:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8C5GR5r002982
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 02:16:28 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] ppc/eeh: introduce EEH_PE_INVALID type PE
Date: Wed, 12 Sep 2012 13:16:16 +0800
Message-Id: <1347426978-6194-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When EEH error happens on the PE whose PCI devices don't have
attached drivers. In function eeh_handle_event(), the default
value PCI_ERS_RESULT_NONE will be returned after iterating all
drivers of those PCI devices belonging to the PE. Actually, we
don't have installed drivers for the PCI devices. Under the
circumstance, we will remove the corresponding PCI bus of the PE,
including the associated EEH devices and PE instance. However,
we still need the information stored in the PE instance to do PE
reset after that. So it's unsafe to free the PE instance.

The patch introduces EEH_PE_INVALID type PE to address the issue.
When the PCI bus and the corresponding attached EEH devices are
removed, we will mark the PE as EEH_PE_INVALID. At later point,
the PE will be changed to EEH_PE_DEVICE or EEH_PE_BUS when the
corresponding EEH devices are attached again.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    7 ++--
 arch/powerpc/platforms/pseries/eeh_pe.c |   50 ++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 58c5ee6..afeb400 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -45,9 +45,10 @@ struct device_node;
  * in the corresponding PHB. Therefore, the root PEs should be created
  * against existing PHBs in on-to-one fashion.
  */
-#define EEH_PE_PHB	1	/* PHB PE    */
-#define EEH_PE_DEVICE 	2	/* Device PE */
-#define EEH_PE_BUS	3	/* Bus PE    */
+#define EEH_PE_INVALID	(1 << 0)	/* Invalid   */
+#define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
+#define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
+#define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
 
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 047617e..8f95ffd 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -107,7 +107,7 @@ static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
 		 * the PE for PHB has been determined when that
 		 * was created.
 		 */
-		if (pe->type == EEH_PE_PHB &&
+		if ((pe->type & EEH_PE_PHB) &&
 		    pe->phb == phb) {
 			eeh_unlock();
 			return pe;
@@ -219,7 +219,7 @@ static void *__eeh_pe_get(void *data, void *flag)
 	struct eeh_dev *edev = (struct eeh_dev *)flag;
 
 	/* Unexpected PHB PE */
-	if (pe->type == EEH_PE_PHB)
+	if (pe->type & EEH_PE_PHB)
 		return NULL;
 
 	/* We prefer PE address */
@@ -314,7 +314,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	 * components.
 	 */
 	pe = eeh_pe_get(edev);
-	if (pe) {
+	if (pe && !(pe->type & EEH_PE_INVALID)) {
 		if (!edev->pe_config_addr) {
 			pr_err("%s: PE with addr 0x%x already exists\n",
 				__func__, edev->config_addr);
@@ -331,6 +331,24 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 			edev->dn->full_name, pe->addr);
 
 		return 0;
+	} else if (pe && (pe->type & EEH_PE_INVALID)) {
+		list_add_tail(&edev->list, &pe->edevs);
+		edev->pe = pe;
+		/*
+		 * We're running to here because of PCI hotplug caused by
+		 * EEH recovery. We need clear EEH_PE_INVALID until the top.
+		 */
+		parent = pe;
+		while (parent) {
+			if (!(parent->type & EEH_PE_INVALID))
+				break;
+			parent->type &= ~EEH_PE_INVALID;
+			parent = parent->parent;
+		}
+		pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
+			edev->dn->full_name, pe->addr, pe->parent->addr);
+
+		return 0;
 	}
 
 	/* Create a new EEH PE */
@@ -385,7 +403,8 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
  */
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 {
-	struct eeh_pe *pe, *parent;
+	struct eeh_pe *pe, *parent, *child;
+	int cnt;
 
 	if (!edev->pe) {
 		pr_warning("%s: No PE found for EEH device %s\n",
@@ -406,13 +425,22 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 	 */
 	while (1) {
 		parent = pe->parent;
-		if (pe->type == EEH_PE_PHB)
+		if (pe->type & EEH_PE_PHB)
 			break;
 
-		if (list_empty(&pe->edevs) &&
-		    list_empty(&pe->child_list)) {
-			list_del(&pe->child);
-			kfree(pe);
+		if (list_empty(&pe->edevs)) {
+			cnt = 0;
+			list_for_each_entry(child, &pe->child_list, child) {
+				if (!(pe->type & EEH_PE_INVALID)) {
+					cnt++;
+					break;
+				}
+			}
+
+			if (!cnt)
+				pe->type |= EEH_PE_INVALID;
+			else
+				break;
 		}
 
 		pe = parent;
@@ -578,9 +606,9 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 	struct eeh_dev *edev;
 	struct pci_dev *pdev;
 
-	if (pe->type == EEH_PE_PHB) {
+	if (pe->type & EEH_PE_PHB) {
 		bus = pe->phb->bus;
-	} else if (pe->type == EEH_PE_BUS) {
+	} else if (pe->type & EEH_PE_BUS) {
 		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		pdev = eeh_dev_to_pci_dev(edev);
 		if (pdev)
-- 
1.7.5.4
