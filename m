Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF3F91A0344
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:56 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:45:56 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 799BE2CE8063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:52 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3jixI17826032
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:52 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3jI1c018105
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 26/45] powerpc/pci: Move pci_find_bus_by_node() around
Date: Wed, 17 Feb 2016 14:44:09 +1100
Message-Id: <1455680668-23298-27-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves pci_find_bus_by_node() from arch/powerpc/platforms/
pseries/pci_dlpar.c to arch/powerpc/kernel/pci-hotplug.c so that
the function can be used by pSeries and PowerNV platform at the
same time. Also, below cleanup applied. No functional changes
introduced.

   * Remove variable "busdn" in find_bus_among_children()
   * Use PCI_DN() to convert device node to pci_dn

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-hotplug.c          | 29 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pci_dlpar.c | 31 ------------------------------
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 78bf2a1..7929a1c 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -21,6 +21,35 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
+static struct pci_bus *find_bus_among_children(struct pci_bus *bus,
+					       struct device_node *dn)
+{
+	struct pci_bus *child = NULL;
+	struct pci_bus *tmp;
+
+	if (pci_bus_to_OF_node(bus) == dn)
+		return bus;
+
+	list_for_each_entry(tmp, &bus->children, node) {
+		child = find_bus_among_children(tmp, dn);
+		if (child)
+			break;
+	}
+
+	return child;
+}
+
+struct pci_bus *pci_find_bus_by_node(struct device_node *dn)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	if (!pdn  || !pdn->phb || !pdn->phb->bus)
+		return NULL;
+
+	return find_bus_among_children(pdn->phb->bus, dn);
+}
+EXPORT_SYMBOL_GPL(pci_find_bus_by_node);
+
 /**
  * pcibios_release_device - release PCI device
  * @dev: PCI device
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index aee22b4..906dbaa 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -34,37 +34,6 @@
 
 #include "pseries.h"
 
-static struct pci_bus *
-find_bus_among_children(struct pci_bus *bus,
-                        struct device_node *dn)
-{
-	struct pci_bus *child = NULL;
-	struct pci_bus *tmp;
-	struct device_node *busdn;
-
-	busdn = pci_bus_to_OF_node(bus);
-	if (busdn == dn)
-		return bus;
-
-	list_for_each_entry(tmp, &bus->children, node) {
-		child = find_bus_among_children(tmp, dn);
-		if (child)
-			break;
-	};
-	return child;
-}
-
-struct pci_bus *pci_find_bus_by_node(struct device_node *dn)
-{
-	struct pci_dn *pdn = dn->data;
-
-	if (!pdn  || !pdn->phb || !pdn->phb->bus)
-		return NULL;
-
-	return find_bus_among_children(pdn->phb->bus, dn);
-}
-EXPORT_SYMBOL_GPL(pci_find_bus_by_node);
-
 struct pci_controller *init_phb_dynamic(struct device_node *dn)
 {
 	struct pci_controller *phb;
-- 
2.1.0
