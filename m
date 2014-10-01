Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB5BB1A17F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:08:00 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:08:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B1A4D2CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:07:57 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9179jOZ30146660
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:09:45 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9177uME004737
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:07:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] powerpc/pseries: Drop config requests in EEH accessors
Date: Wed,  1 Oct 2014 17:07:52 +1000
Message-Id: <1412147274-28770-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pSeires EEH config accessors rely on rtas_{read, write}_config()
and the condition to check if the PE's config space is blocked
should be moved to those 2 functions so that config requests from
kernel, userland, EEH core can be dropped to avoid recursive EEH error
if necessary.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas_pci.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index ce7c8b6..7c55b86 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -66,6 +66,11 @@ int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	if (!config_access_valid(pdn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
+#ifdef CONFIG_EEH
+	if (pdn->edev && pdn->edev->pe &&
+	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
+		return PCIBIOS_SET_FAILED;
+#endif
 
 	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
 	buid = pdn->phb->buid;
@@ -90,9 +95,6 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 	struct device_node *busdn, *dn;
 	struct pci_dn *pdn;
 	bool found = false;
-#ifdef CONFIG_EEH
-	struct eeh_dev *edev;
-#endif
 	int ret;
 
 	/* Search only direct children of the bus */
@@ -109,11 +111,6 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 
 	if (!found)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-#ifdef CONFIG_EEH
-	edev = of_node_to_eeh_dev(dn);
-	if (edev && edev->pe && edev->pe->state & EEH_PE_CFG_BLOCKED)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-#endif
 
 	ret = rtas_read_config(pdn, where, size, val);
 	if (*val == EEH_IO_ERROR_VALUE(size) &&
@@ -132,6 +129,11 @@ int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	if (!config_access_valid(pdn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
+#ifdef CONFIG_EEH
+	if (pdn->edev && pdn->edev->pe &&
+	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
+		return PCIBIOS_SET_FAILED;
+#endif
 
 	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
 	buid = pdn->phb->buid;
@@ -155,10 +157,6 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 	struct device_node *busdn, *dn;
 	struct pci_dn *pdn;
 	bool found = false;
-#ifdef CONFIG_EEH
-	struct eeh_dev *edev;
-#endif
-	int ret;
 
 	/* Search only direct children of the bus */
 	busdn = pci_bus_to_OF_node(bus);
@@ -173,14 +171,8 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 
 	if (!found)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-#ifdef CONFIG_EEH
-	edev = of_node_to_eeh_dev(dn);
-	if (edev && edev->pe && (edev->pe->state & EEH_PE_CFG_BLOCKED))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-#endif
-	ret = rtas_write_config(pdn, where, size, val);
 
-	return ret;
+	return rtas_write_config(pdn, where, size, val);
 }
 
 static struct pci_ops rtas_pci_ops = {
-- 
1.8.3.2
