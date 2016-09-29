Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl3c30Xs5zDsff
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:46 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8T5lxtr145841
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:44 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25rq5x79jt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:44 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 15:51:41 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A08F32CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8T5pcTS56230004
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8T5pbI0003258
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v4 5/7] drivers/pci/hotplug: Remove likely() and unlikely() in
 powernv driver
Date: Thu, 29 Sep 2016 15:52:03 +1000
In-Reply-To: <1475128325-5367-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1475128325-5367-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1475128325-5367-6-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes likely() and unlikely() in pnv_php.c as the code isn't
running in hot path. Those macros to affect CPU's branch stream don't
help a lot for performance. I used them to identify the cases are
likely or unlikely to happen. No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 56 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index e6245b0..182f218 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -122,7 +122,7 @@ static void pnv_php_detach_device_nodes(struct device_node *parent)
 
 		of_node_put(dn);
 		refcount = atomic_read(&dn->kobj.kref.refcount);
-		if (unlikely(refcount != 1))
+		if (refcount != 1)
 			pr_warn("Invalid refcount %d on <%s>\n",
 				refcount, of_node_full_name(dn));
 
@@ -184,11 +184,11 @@ static int pnv_php_populate_changeset(struct of_changeset *ocs,
 
 	for_each_child_of_node(dn, child) {
 		ret = of_changeset_attach_node(ocs, child);
-		if (unlikely(ret))
+		if (ret)
 			break;
 
 		ret = pnv_php_populate_changeset(ocs, child);
-		if (unlikely(ret))
+		if (ret)
 			break;
 	}
 
@@ -201,7 +201,7 @@ static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
 	struct pci_dn *pdn;
 
 	pdn = pci_add_device_node_info(hose, dn);
-	if (unlikely(!pdn))
+	if (!pdn)
 		return ERR_PTR(-ENOMEM);
 
 	return NULL;
@@ -224,21 +224,21 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	 * fits the real size.
 	 */
 	fdt1 = kzalloc(0x10000, GFP_KERNEL);
-	if (unlikely(!fdt1)) {
+	if (!fdt1) {
 		ret = -ENOMEM;
 		dev_warn(&php_slot->pdev->dev, "Cannot alloc FDT blob\n");
 		goto out;
 	}
 
 	ret = pnv_pci_get_device_tree(php_slot->dn->phandle, fdt1, 0x10000);
-	if (unlikely(ret)) {
+	if (ret) {
 		dev_warn(&php_slot->pdev->dev, "Error %d getting FDT blob\n",
 			 ret);
 		goto free_fdt1;
 	}
 
 	fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
-	if (unlikely(!fdt)) {
+	if (!fdt) {
 		ret = -ENOMEM;
 		dev_warn(&php_slot->pdev->dev, "Cannot %d bytes memory\n",
 			 fdt_totalsize(fdt1));
@@ -248,7 +248,7 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	/* Unflatten device tree blob */
 	memcpy(fdt, fdt1, fdt_totalsize(fdt1));
 	dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
-	if (unlikely(!dt)) {
+	if (!dt) {
 		ret = -EINVAL;
 		dev_warn(&php_slot->pdev->dev, "Cannot unflatten FDT\n");
 		goto free_fdt;
@@ -258,7 +258,7 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	of_changeset_init(&php_slot->ocs);
 	pnv_php_reverse_nodes(php_slot->dn);
 	ret = pnv_php_populate_changeset(&php_slot->ocs, php_slot->dn);
-	if (unlikely(ret)) {
+	if (ret) {
 		pnv_php_reverse_nodes(php_slot->dn);
 		dev_warn(&php_slot->pdev->dev, "Error %d populating changeset\n",
 			 ret);
@@ -267,7 +267,7 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 
 	php_slot->dn->child = NULL;
 	ret = of_changeset_apply(&php_slot->ocs);
-	if (unlikely(ret)) {
+	if (ret) {
 		dev_warn(&php_slot->pdev->dev, "Error %d applying changeset\n",
 			 ret);
 		goto destroy_changeset;
@@ -301,7 +301,7 @@ int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 	int ret;
 
 	ret = pnv_pci_set_power_state(php_slot->id, state, &msg);
-	if (likely(ret > 0)) {
+	if (ret > 0) {
 		if (be64_to_cpu(msg.params[1]) != php_slot->dn->phandle	||
 		    be64_to_cpu(msg.params[2]) != state			||
 		    be64_to_cpu(msg.params[3]) != OPAL_SUCCESS) {
@@ -311,7 +311,7 @@ int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 				 be64_to_cpu(msg.params[3]));
 			return -ENOMSG;
 		}
-	} else if (unlikely(ret < 0)) {
+	} else if (ret < 0) {
 		dev_warn(&php_slot->pdev->dev, "Error %d powering %s\n",
 			 ret, (state == OPAL_PCI_SLOT_POWER_ON) ? "on" : "off");
 		return ret;
@@ -338,7 +338,7 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 	 * be on.
 	 */
 	ret = pnv_pci_get_power_state(php_slot->id, &power_state);
-	if (unlikely(ret)) {
+	if (ret) {
 		dev_warn(&php_slot->pdev->dev, "Error %d getting power status\n",
 			 ret);
 	} else {
@@ -360,7 +360,7 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	 * get that, it will fail back to be empty.
 	 */
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
-	if (likely(ret >= 0)) {
+	if (ret >= 0) {
 		*state = presence;
 		slot->info->adapter_status = presence;
 		ret = 0;
@@ -393,7 +393,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 
 	/* Retrieve slot presence status */
 	ret = pnv_php_get_adapter_state(slot, &presence);
-	if (unlikely(ret))
+	if (ret)
 		return ret;
 
 	/* Proceed if there have nothing behind the slot */
@@ -414,7 +414,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 		php_slot->power_state_check = true;
 
 		ret = pnv_php_get_power_state(slot, &power_status);
-		if (unlikely(ret))
+		if (ret)
 			return ret;
 
 		if (power_status != OPAL_PCI_SLOT_POWER_ON)
@@ -423,7 +423,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 
 	/* Check the power status. Scan the slot if it is already on */
 	ret = pnv_php_get_power_state(slot, &power_status);
-	if (unlikely(ret))
+	if (ret)
 		return ret;
 
 	if (power_status == OPAL_PCI_SLOT_POWER_ON)
@@ -431,7 +431,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 
 	/* Power is off, turn it on and then scan the slot */
 	ret = pnv_php_set_slot_power_state(slot, OPAL_PCI_SLOT_POWER_ON);
-	if (unlikely(ret))
+	if (ret)
 		return ret;
 
 scan:
@@ -515,27 +515,27 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	uint64_t id;
 
 	label = of_get_property(dn, "ibm,slot-label", NULL);
-	if (unlikely(!label))
+	if (!label)
 		return NULL;
 
 	if (pnv_pci_get_slot_id(dn, &id))
 		return NULL;
 
 	bus = pci_find_bus_by_node(dn);
-	if (unlikely(!bus))
+	if (!bus)
 		return NULL;
 
 	php_slot = kzalloc(sizeof(*php_slot), GFP_KERNEL);
-	if (unlikely(!php_slot))
+	if (!php_slot)
 		return NULL;
 
 	php_slot->name = kstrdup(label, GFP_KERNEL);
-	if (unlikely(!php_slot->name)) {
+	if (!php_slot->name) {
 		kfree(php_slot);
 		return NULL;
 	}
 
-	if (likely(dn->child && PCI_DN(dn->child)))
+	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
 		php_slot->slot_no = -1;   /* Placeholder slot */
@@ -567,7 +567,7 @@ static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
 
 	/* Check if the slot is registered or not */
 	parent = pnv_php_find_slot(php_slot->dn);
-	if (unlikely(parent)) {
+	if (parent) {
 		pnv_php_put_slot(parent);
 		return -EEXIST;
 	}
@@ -575,7 +575,7 @@ static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
 	/* Register PCI slot */
 	ret = pci_hp_register(&php_slot->slot, php_slot->bus,
 			      php_slot->slot_no, php_slot->name);
-	if (unlikely(ret)) {
+	if (ret) {
 		dev_warn(&php_slot->pdev->dev, "Error %d registering slot\n",
 			 ret);
 		return ret;
@@ -625,15 +625,15 @@ static int pnv_php_register_one(struct device_node *dn)
 		return -ENXIO;
 
 	php_slot = pnv_php_alloc_slot(dn);
-	if (unlikely(!php_slot))
+	if (!php_slot)
 		return -ENODEV;
 
 	ret = pnv_php_register_slot(php_slot);
-	if (unlikely(ret))
+	if (ret)
 		goto free_slot;
 
 	ret = pnv_php_enable(php_slot, false);
-	if (unlikely(ret))
+	if (ret)
 		goto unregister_slot;
 
 	return 0;
-- 
2.1.0
