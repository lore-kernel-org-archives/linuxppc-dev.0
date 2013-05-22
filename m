Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD5252C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 18:58:31 +1000 (EST)
Message-ID: <1369213101.3870.12.camel@pasglop>
Subject: [PATCH] powerpc: Make radeon 32-bit MSI quirk work on powernv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 22 May 2013 18:58:21 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, klebers@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the quirk itself to pci_64.c as to get built on all ppc64
platforms (the only ones with a pci_dn), factors the two implementations
of get_pdn() into a single pci_get_dn() and use the quirk to do 32-bit
MSIs on IODA based powernv platforms.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

(We really need to rename that pci_dn structure to something a bit more
telling one of these days, such as pci_dn_auxdata)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 8b11b5b..2c1d8cb 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -174,6 +174,8 @@ struct pci_dn {
 /* Get the pointer to a device_node's pci_dn */
 #define PCI_DN(dn)	((struct pci_dn *) (dn)->data)
 
+extern struct pci_dn *pci_get_pdn(struct pci_dev *pdev);
+
 extern void * update_dn_pci_info(struct device_node *dn, void *data);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 873050d..2e86296 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -266,3 +266,13 @@ int pcibus_to_node(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibus_to_node);
 #endif
+
+static void quirk_radeon_32bit_msi(struct pci_dev *dev)
+{
+	struct pci_dn *pdn = pci_get_pdn(dev);
+
+	if (pdn)
+		pdn->force_32bit_msi = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon_32bit_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index e7af165..df03844 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -32,6 +32,14 @@
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
 
+struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
+{
+	struct device_node *dn = pci_device_to_OF_node(pdev);
+	if (!dn)
+		return NULL;
+	return PCI_DN(dn);
+}
+
 /*
  * Traverse_func that inits the PCI fields of the device node.
  * NOTE: this *must* be done before read/write config to the device.
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 194e921..49c4c57 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -68,16 +68,6 @@ define_pe_printk_level(pe_err, KERN_ERR);
 define_pe_printk_level(pe_warn, KERN_WARNING);
 define_pe_printk_level(pe_info, KERN_INFO);
 
-static struct pci_dn *pnv_ioda_get_pdn(struct pci_dev *dev)
-{
-	struct device_node *np;
-
-	np = pci_device_to_OF_node(dev);
-	if (!np)
-		return NULL;
-	return PCI_DN(np);
-}
-
 static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
 	unsigned long pe;
@@ -110,7 +100,7 @@ static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
-	struct pci_dn *pdn = pnv_ioda_get_pdn(dev);
+	struct pci_dn *pdn = pci_get_pdn(dev);
 
 	if (!pdn)
 		return NULL;
@@ -173,7 +163,7 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	/* Add to all parents PELT-V */
 	while (parent) {
-		struct pci_dn *pdn = pnv_ioda_get_pdn(parent);
+		struct pci_dn *pdn = pci_get_pdn(parent);
 		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
 			rc = opal_pci_set_peltv(phb->opal_id, pdn->pe_number,
 						pe->pe_number, OPAL_ADD_PE_TO_DOMAIN);
@@ -252,7 +242,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
-	struct pci_dn *pdn = pnv_ioda_get_pdn(dev);
+	struct pci_dn *pdn = pci_get_pdn(dev);
 	struct pnv_ioda_pe *pe;
 	int pe_num;
 
@@ -323,7 +313,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		struct pci_dn *pdn = pnv_ioda_get_pdn(dev);
+		struct pci_dn *pdn = pci_get_pdn(dev);
 
 		if (pdn == NULL) {
 			pr_warn("%s: No device node associated with device !\n",
@@ -436,7 +426,7 @@ static void pnv_pci_ioda_setup_PEs(void)
 
 static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev)
 {
-	struct pci_dn *pdn = pnv_ioda_get_pdn(pdev);
+	struct pci_dn *pdn = pci_get_pdn(pdev);
 	struct pnv_ioda_pe *pe;
 
 	/*
@@ -768,6 +758,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				  unsigned int is_64, struct msi_msg *msg)
 {
 	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
+	struct pci_dn *pdn = pci_get_pdn(dev);
 	struct irq_data *idata;
 	struct irq_chip *ichip;
 	unsigned int xive_num = hwirq - phb->msi_base;
@@ -783,6 +774,10 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 	if (pe->mve_number < 0)
 		return -ENXIO;
 
+	/* Force 32-bit MSI on some broken devices */
+	if (pdn && pdn->force_32bit_msi)
+		is_64 = 0;
+
 	/* Assign XIVE to PE */
 	rc = opal_pci_set_xive_pe(phb->opal_id, pe->pe_number, xive_num);
 	if (rc) {
@@ -1035,7 +1030,7 @@ static int pnv_pci_enable_device_hook(struct pci_dev *dev)
 	if (!phb->initialized)
 		return 0;
 
-	pdn = pnv_ioda_get_pdn(dev);
+	pdn = pci_get_pdn(dev);
 	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
 		return -EINVAL;
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 098d357..277343c 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -47,6 +47,10 @@ static int pnv_msi_check_device(struct pci_dev* pdev, int nvec, int type)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+
+	if (pdn && pdn->force_32bit_msi && !phb->msi32_support)
+		return -ENODEV;
 
 	return (phb && phb->msi_bmp.bitmap) ? 0 : -ENODEV;
 }
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 420524e..d34f4ff 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -26,26 +26,6 @@ static int query_token, change_token;
 #define RTAS_CHANGE_MSIX_FN	4
 #define RTAS_CHANGE_32MSI_FN	5
 
-static struct pci_dn *get_pdn(struct pci_dev *pdev)
-{
-	struct device_node *dn;
-	struct pci_dn *pdn;
-
-	dn = pci_device_to_OF_node(pdev);
-	if (!dn) {
-		dev_dbg(&pdev->dev, "rtas_msi: No OF device node\n");
-		return NULL;
-	}
-
-	pdn = PCI_DN(dn);
-	if (!pdn) {
-		dev_dbg(&pdev->dev, "rtas_msi: No PCI DN\n");
-		return NULL;
-	}
-
-	return pdn;
-}
-
 /* RTAS Helpers */
 
 static int rtas_change_msi(struct pci_dn *pdn, u32 func, u32 num_irqs)
@@ -91,7 +71,7 @@ static void rtas_disable_msi(struct pci_dev *pdev)
 {
 	struct pci_dn *pdn;
 
-	pdn = get_pdn(pdev);
+	pdn = pci_get_pdn(pdev);
 	if (!pdn)
 		return;
 
@@ -152,7 +132,7 @@ static int check_req(struct pci_dev *pdev, int nvec, char *prop_name)
 	struct pci_dn *pdn;
 	const u32 *req_msi;
 
-	pdn = get_pdn(pdev);
+	pdn = pci_get_pdn(pdev);
 	if (!pdn)
 		return -ENODEV;
 
@@ -402,7 +382,7 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
 	struct msi_msg msg;
 	int nvec = nvec_in;
 
-	pdn = get_pdn(pdev);
+	pdn = pci_get_pdn(pdev);
 	if (!pdn)
 		return -ENODEV;
 
@@ -518,12 +498,3 @@ static int rtas_msi_init(void)
 }
 arch_initcall(rtas_msi_init);
 
-static void quirk_radeon(struct pci_dev *dev)
-{
-	struct pci_dn *pdn = get_pdn(dev);
-
-	if (pdn)
-		pdn->force_32bit_msi = 1;
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon);
