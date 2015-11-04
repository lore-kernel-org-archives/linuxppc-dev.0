Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76A011A0CBE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:14:07 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:14:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9F0F42BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:14:04 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDvLI15859836
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:14:06 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDVZu019250
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:32 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 30/50] powerpc/pci: Move pci_find_bus_by_node() around
Date: Thu,  5 Nov 2015 00:12:30 +1100
Message-Id: <1446642770-4681-31-git-send-email-gwshan@linux.vnet.ibm.com>
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
index 3f62821..96e2cc3 100644
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
