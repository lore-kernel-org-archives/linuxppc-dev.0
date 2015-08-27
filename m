Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6E261A0545
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 14:13:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 27 Aug 2015 14:13:39 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 058572CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 14:13:38 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7R4DTUc56950972
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 14:13:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7R4D5hq010042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 14:13:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/pseries: Cleanup on pci_dn_reconfig_notifier()
Date: Thu, 27 Aug 2015 14:12:37 +1000
Message-Id: <1440648757-23359-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1440648757-23359-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1440648757-23359-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This applies cleanup on pci_dn_reconfig_notifier(), no functional
changes:

   * Rename variable "pci" to "pdn" to indicate its purpose clearly.
   * The parent node can be released at any time. So it should be
     hold with of_get_parent() before accessing it.
   * The device node doesn't have to have parent node in theory.
     More check on this.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e6e8b24..39a74fa 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -254,24 +254,26 @@ static void __init pseries_discover_pic(void)
 static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct of_reconfig_data *rd = data;
-	struct device_node *np = rd->dn;
-	struct pci_dn *pci = NULL;
+	struct device_node *parent, *np = rd->dn;
+	struct pci_dn *pdn;
 	int err = NOTIFY_OK;
 
 	switch (action) {
 	case OF_RECONFIG_ATTACH_NODE:
-		pci = np->parent->data;
-		if (pci) {
-			update_dn_pci_info(np, pci->phb);
-
-			/* Create EEH device for the OF node */
-			eeh_dev_init(PCI_DN(np), pci->phb);
+		parent = of_get_parent(np);
+		pdn = parent ? PCI_DN(parent) : NULL;
+		if (pdn) {
+			/* Create pdn and EEH device */
+			update_dn_pci_info(np, pdn->phb);
+			eeh_dev_init(PCI_DN(np), pdn->phb);
 		}
+
+		of_node_put(parent);
 		break;
 	case OF_RECONFIG_DETACH_NODE:
-		pci = PCI_DN(np);
-		if (pci)
-			list_del(&pci->list);
+		pdn = PCI_DN(np);
+		if (pdn)
+			list_del(&pdn->list);
 		break;
 	default:
 		err = NOTIFY_DONE;
-- 
2.1.0
