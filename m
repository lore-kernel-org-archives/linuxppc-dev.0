Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xhL4c5b1BzDqZ0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:34:40 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v2 1/6] powerpc/pci: Remove unused parameter from
 add_one_dev_pci_data()
Date: Tue, 29 Aug 2017 17:33:59 +1000
Message-Id: <20170829073404.8885-2-aik@ozlabs.ru>
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

pdev is always NULL, remove it.

To make checkpatch.pl happy, this also removes the "out of memory"
message.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/pci_dn.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 592693437070..0256372b72de 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -139,7 +139,6 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 
 #ifdef CONFIG_PCI_IOV
 static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
-					   struct pci_dev *pdev,
 					   int vf_index,
 					   int busno, int devfn)
 {
@@ -150,10 +149,8 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 		return NULL;
 
 	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
-	if (!pdn) {
-		dev_warn(&pdev->dev, "%s: Out of memory!\n", __func__);
+	if (!pdn)
 		return NULL;
-	}
 
 	pdn->phb = parent->phb;
 	pdn->parent = parent;
@@ -167,13 +164,6 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 	INIT_LIST_HEAD(&pdn->list);
 	list_add_tail(&pdn->list, &parent->child_list);
 
-	/*
-	 * If we already have PCI device instance, lets
-	 * bind them.
-	 */
-	if (pdev)
-		pdev->dev.archdata.pci_data = pdn;
-
 	return pdn;
 }
 #endif
@@ -201,7 +191,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
 		struct eeh_dev *edev __maybe_unused;
 
-		pdn = add_one_dev_pci_data(parent, NULL, i,
+		pdn = add_one_dev_pci_data(parent, i,
 					   pci_iov_virtfn_bus(pdev, i),
 					   pci_iov_virtfn_devfn(pdev, i));
 		if (!pdn) {
-- 
2.11.0
