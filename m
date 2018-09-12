Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vg62hnzF3FK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:43 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1IZ8e038062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:41 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2meqcyuejj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:41 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:39 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1NbIk47055080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF465AE053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:22:52 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 277D3AE045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:22:52 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:22:52 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B0647A03A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/14] powerpc/eeh: Cleanup list_head field names
Date: Wed, 12 Sep 2018 11:23:26 +1000
In-Reply-To: <cover.1536715396.git.sbobroff@linux.ibm.com>
References: <cover.1536715396.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1ab3c0b2a38601c3f114249eeaf11511df80bff1.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instances of struct eeh_pe are placed in a tree structure using the
fields "child_list" and "child", so place these next to each other
in the definition.

The field "child" is a list entry, so remove the unnecessary and
misleading use of the list initializer, LIST_HEAD(), on it.

The eeh_dev struct contains two list entry fields, called "list" and
"rmv_list". Rename them to "entry" and "rmv_entry" and, as above, stop
initializing them with LIST_HEAD().

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               | 12 ++++++------
 arch/powerpc/kernel/eeh_dev.c                |  2 --
 arch/powerpc/kernel/eeh_driver.c             | 10 +++++-----
 arch/powerpc/kernel/eeh_pe.c                 | 11 +++++------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  2 +-
 arch/powerpc/platforms/pseries/msi.c         |  3 ++-
 6 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 703d1f96ee8b..b48b08ed9be3 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -98,13 +98,13 @@ struct eeh_pe {
 	atomic_t pass_dev_cnt;		/* Count of passed through devs	*/
 	struct eeh_pe *parent;		/* Parent PE			*/
 	void *data;			/* PE auxillary data		*/
-	struct list_head child_list;	/* Link PE to the child list	*/
-	struct list_head edevs;		/* Link list of EEH devices	*/
-	struct list_head child;		/* Child PEs			*/
+	struct list_head child_list;	/* List of PEs below this PE	*/
+	struct list_head child;		/* Memb. child_list/eeh_phb_pe	*/
+	struct list_head edevs;		/* List of eeh_dev in this PE	*/
 };
 
 #define eeh_pe_for_each_dev(pe, edev, tmp) \
-		list_for_each_entry_safe(edev, tmp, &pe->edevs, list)
+		list_for_each_entry_safe(edev, tmp, &pe->edevs, entry)
 
 #define eeh_for_each_pe(root, pe) \
 	for (pe = root; pe; pe = eeh_pe_next(pe, root))
@@ -141,8 +141,8 @@ struct eeh_dev {
 	int aer_cap;			/* Saved AER capability		*/
 	int af_cap;			/* Saved AF capability		*/
 	struct eeh_pe *pe;		/* Associated PE		*/
-	struct list_head list;		/* Form link list in the PE	*/
-	struct list_head rmv_list;	/* Record the removed edevs	*/
+	struct list_head entry;		/* Membership in eeh_pe.edevs	*/
+	struct list_head rmv_entry;	/* Membership in rmv_list	*/
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
 	bool in_error;			/* Error flag for edev		*/
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index a34e6912c15e..d8c90f3284b5 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -60,8 +60,6 @@ struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
 	/* Associate EEH device with OF node */
 	pdn->edev = edev;
 	edev->pdn = pdn;
-	INIT_LIST_HEAD(&edev->list);
-	INIT_LIST_HEAD(&edev->rmv_list);
 
 	return edev;
 }
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index cc300eb9585c..7859af897058 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -404,7 +404,7 @@ static void *eeh_dev_restore_state(struct eeh_dev *edev, void *userdata)
 	 * EEH device is created.
 	 */
 	if (edev->pe && (edev->pe->state & EEH_PE_CFG_RESTRICTED)) {
-		if (list_is_last(&edev->list, &edev->pe->edevs))
+		if (list_is_last(&edev->entry, &edev->pe->edevs))
 			eeh_pe_restore_bars(edev->pe);
 
 		return NULL;
@@ -560,7 +560,7 @@ static void *eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 		pdn->pe_number = IODA_INVALID_PE;
 #endif
 		if (rmv_data)
-			list_add(&edev->rmv_list, &rmv_data->edev_list);
+			list_add(&edev->rmv_entry, &rmv_data->edev_list);
 	} else {
 		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(dev);
@@ -739,7 +739,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 		 * PE. We should disconnect it so the binding can be
 		 * rebuilt when adding PCI devices.
 		 */
-		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
+		edev = list_first_entry(&pe->edevs, struct eeh_dev, entry);
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
 		if (pe->type & EEH_PE_VF) {
 			eeh_add_virt_device(edev);
@@ -934,9 +934,9 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * For those hot removed VFs, we should add back them after PF get
 	 * recovered properly.
 	 */
-	list_for_each_entry_safe(edev, tmp, &rmv_data.edev_list, rmv_list) {
+	list_for_each_entry_safe(edev, tmp, &rmv_data.edev_list, rmv_entry) {
 		eeh_add_virt_device(edev);
-		list_del(&edev->rmv_list);
+		list_del(&edev->rmv_entry);
 	}
 
 	/* Tell all device drivers that they can resume operations */
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 210d239a9395..7d6d93cd67e1 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -75,7 +75,6 @@ static struct eeh_pe *eeh_pe_alloc(struct pci_controller *phb, int type)
 	pe->type = type;
 	pe->phb = phb;
 	INIT_LIST_HEAD(&pe->child_list);
-	INIT_LIST_HEAD(&pe->child);
 	INIT_LIST_HEAD(&pe->edevs);
 
 	pe->data = (void *)pe + ALIGN(sizeof(struct eeh_pe),
@@ -360,7 +359,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 		edev->pe = pe;
 
 		/* Put the edev to PE */
-		list_add_tail(&edev->list, &pe->edevs);
+		list_add_tail(&edev->entry, &pe->edevs);
 		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Bus PE#%x\n",
 			 pdn->phb->global_number,
 			 pdn->busno,
@@ -369,7 +368,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 			 pe->addr);
 		return 0;
 	} else if (pe && (pe->type & EEH_PE_INVALID)) {
-		list_add_tail(&edev->list, &pe->edevs);
+		list_add_tail(&edev->entry, &pe->edevs);
 		edev->pe = pe;
 		/*
 		 * We're running to here because of PCI hotplug caused by
@@ -429,7 +428,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	 * link the EEH device accordingly.
 	 */
 	list_add_tail(&pe->child, &parent->child_list);
-	list_add_tail(&edev->list, &pe->edevs);
+	list_add_tail(&edev->entry, &pe->edevs);
 	edev->pe = pe;
 	pr_debug("EEH: Add %04x:%02x:%02x.%01x to "
 		 "Device PE#%x, Parent PE#%x\n",
@@ -469,7 +468,7 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 	/* Remove the EEH device */
 	pe = eeh_dev_to_pe(edev);
 	edev->pe = NULL;
-	list_del(&edev->list);
+	list_del(&edev->entry);
 
 	/*
 	 * Check if the parent PE includes any EEH devices.
@@ -945,7 +944,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 		return pe->bus;
 
 	/* Retrieve the parent PCI bus of first (top) PCI device */
-	edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, list);
+	edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, entry);
 	pdev = eeh_dev_to_pci_dev(edev);
 	if (pdev)
 		return pdev->bus;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index d0764f2c0733..a7e59dbf2696 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1040,7 +1040,7 @@ static int pnv_eeh_reset_vf_pe(struct eeh_pe *pe, int option)
 	int ret;
 
 	/* The VF PE should have only one child device */
-	edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, list);
+	edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, entry);
 	pdn = eeh_dev_to_pdn(edev);
 	if (!pdn)
 		return -ENXIO;
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index b7496948129e..8011b4129e3a 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -203,7 +203,8 @@ static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 	/* Get the top level device in the PE */
 	edev = pdn_to_eeh_dev(PCI_DN(dn));
 	if (edev->pe)
-		edev = list_first_entry(&edev->pe->edevs, struct eeh_dev, list);
+		edev = list_first_entry(&edev->pe->edevs, struct eeh_dev,
+					entry);
 	dn = pci_device_to_OF_node(edev->pdev);
 	if (!dn)
 		return NULL;
-- 
2.19.0.2.gcad72f5712
