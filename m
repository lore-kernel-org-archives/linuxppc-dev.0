Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVTN3wZBzDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:36 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:43:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3FF022BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435hPaT6357500
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:43:33 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435h0ug007906
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:43:01 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 19/26] powerpc/pci: Rename pcibios_find_pci_bus()
Date: Tue,  3 May 2016 15:41:38 +1000
Message-Id: <1462254105-24128-20-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This renames pcibios_find_pci_bus() to pci_find_bus_by_node() to
avoid conflicts with those PCI subsystem weak function names, which
have prefix "pcibios". No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci-bridge.h      | 2 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c | 5 ++---
 drivers/pci/hotplug/rpadlpar_core.c        | 6 +++---
 drivers/pci/hotplug/rpaphp_pci.c           | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 99027b8..f0a5b16 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -257,7 +257,7 @@ static inline struct eeh_dev *pdn_to_eeh_dev(struct pci_dn *pdn)
 #endif
 
 /** Find the bus corresponding to the indicated device node */
-extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
+extern struct pci_bus *pci_find_bus_by_node(struct device_node *dn);
 
 /** Remove all of the PCI devices under this bus */
 extern void pci_hp_remove_devices(struct pci_bus *bus);
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 5d4a3df..aee22b4 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -54,8 +54,7 @@ find_bus_among_children(struct pci_bus *bus,
 	return child;
 }
 
-struct pci_bus *
-pcibios_find_pci_bus(struct device_node *dn)
+struct pci_bus *pci_find_bus_by_node(struct device_node *dn)
 {
 	struct pci_dn *pdn = dn->data;
 
@@ -64,7 +63,7 @@ pcibios_find_pci_bus(struct device_node *dn)
 
 	return find_bus_among_children(pdn->phb->bus, dn);
 }
-EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
+EXPORT_SYMBOL_GPL(pci_find_bus_by_node);
 
 struct pci_controller *init_phb_dynamic(struct device_node *dn)
 {
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index b770d6d..dc67f39 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -175,7 +175,7 @@ static int dlpar_add_pci_slot(char *drc_name, struct device_node *dn)
 	struct pci_dev *dev;
 	struct pci_controller *phb;
 
-	if (pcibios_find_pci_bus(dn))
+	if (pci_find_bus_by_node(dn))
 		return -EINVAL;
 
 	/* Add pci bus */
@@ -212,7 +212,7 @@ static int dlpar_remove_phb(char *drc_name, struct device_node *dn)
 	struct pci_dn *pdn;
 	int rc = 0;
 
-	if (!pcibios_find_pci_bus(dn))
+	if (!pci_find_bus_by_node(dn))
 		return -EINVAL;
 
 	/* If pci slot is hotpluggable, use hotplug to remove it */
@@ -356,7 +356,7 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
 
 	pci_lock_rescan_remove();
 
-	bus = pcibios_find_pci_bus(dn);
+	bus = pci_find_bus_by_node(dn);
 	if (!bus) {
 		ret = -EINVAL;
 		goto out;
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index 137a892..ea41ea1 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -93,7 +93,7 @@ int rpaphp_enable_slot(struct slot *slot)
 	if (rc)
 		return rc;
 
-	bus = pcibios_find_pci_bus(slot->dn);
+	bus = pci_find_bus_by_node(slot->dn);
 	if (!bus) {
 		err("%s: no pci_bus for dn %s\n", __func__, slot->dn->full_name);
 		return -EINVAL;
-- 
2.1.0
