Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xhL493gKyzDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:34:17 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v2 6/6] powerpc/pci: Remove OF node back pointer from
 pci_dn
Date: Tue, 29 Aug 2017 17:34:04 +1000
Message-Id: <20170829073404.8885-7-aik@ozlabs.ru>
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

The check_req() helper uses pci_get_pdn() to get an OF node pointer.
pci_get_pdn() returns a pci_dn pointer which either:
1) from the OF node returned by pci_device_to_OF_node();
2) from the parent child_list where entries don't have OF node pointers.
Since check_req() does not care about 2), it can call
pci_device_to_OF_node() directly, hence the change.

The find_pe_dn() helper uses embedded pci_dn to get an OF node which is
also stored in edev->pdev so let's take a shortcut and call
pci_device_to_OF_node() directly.

With these 2 changes, we can finally get rid of the OF node back pointer.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changelog:
v2:
* fixed pseries platform
---
 arch/powerpc/include/asm/pci-bridge.h |  1 -
 arch/powerpc/kernel/pci_dn.c          |  1 -
 arch/powerpc/platforms/pseries/msi.c  | 11 ++---------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 56c67d3f0108..0b8aa1fe2d5f 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -195,7 +195,6 @@ struct pci_dn {
 	struct  pci_dn *parent;
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table_group *table_group;	/* for phb's or bridges */
-	struct	device_node *node;	/* back-pointer to the device_node */
 
 	int	pci_ext_config_space;	/* for pci devices */
 
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index dfb107631116..0e395afbf0f4 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -293,7 +293,6 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 	if (pdn == NULL)
 		return NULL;
 	dn->data = pdn;
-	pdn->node = dn;
 	pdn->phb = hose;
 #ifdef CONFIG_PPC_POWERNV
 	pdn->pe_number = IODA_INVALID_PE;
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 326ef0dd6038..70b7aeff8139 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -132,15 +132,10 @@ static void rtas_teardown_msi_irqs(struct pci_dev *pdev)
 static int check_req(struct pci_dev *pdev, int nvec, char *prop_name)
 {
 	struct device_node *dn;
-	struct pci_dn *pdn;
 	const __be32 *p;
 	u32 req_msi;
 
-	pdn = pci_get_pdn(pdev);
-	if (!pdn)
-		return -ENODEV;
-
-	dn = pdn->node;
+	dn = pci_device_to_OF_node(pdev);
 
 	p = of_get_property(dn, prop_name, NULL);
 	if (!p) {
@@ -197,7 +192,6 @@ static struct device_node *find_pe_total_msi(struct pci_dev *dev, int *total)
 static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 {
 	struct device_node *dn;
-	struct pci_dn *pdn;
 	struct eeh_dev *edev;
 
 	/* Found our PE and assume 8 at that point. */
@@ -210,8 +204,7 @@ static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 	edev = pdn_to_eeh_dev(PCI_DN(dn));
 	if (edev->pe)
 		edev = list_first_entry(&edev->pe->edevs, struct eeh_dev, list);
-	pdn = eeh_dev_to_pdn(edev);
-	dn = pdn ? pdn->node : NULL;
+	dn = pci_device_to_OF_node(edev->pdev);
 	if (!dn)
 		return NULL;
 
-- 
2.11.0
