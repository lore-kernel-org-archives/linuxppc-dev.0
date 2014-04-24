Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 28B6C140165
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:32 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:31 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DCA113578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:28 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dY939044228
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80SUx023406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:28 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 10/25] powerpc/eeh: Use cached capability for log dump
Date: Thu, 24 Apr 2014 18:00:16 +1000
Message-Id: <1398326431-24305-11-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When calling into eeh_gather_pci_data() on pSeries platform, we
possiblly don't have pci_dev instance yet, but eeh_dev is always
ready. So we use cached capability from eeh_dev instead of pci_dev
for log dump there. In order to keep things unified, we also cache
PCI capability positions to eeh_dev for PowerNV as well.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  4 ++-
 arch/powerpc/kernel/eeh.c                    | 39 ++++++++++++----------------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  4 +++
 arch/powerpc/platforms/pseries/eeh_pseries.c | 32 +++++++++++++++++++++++
 4 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index fa32d8d..f0183e3 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -99,7 +99,9 @@ struct eeh_dev {
 	int config_addr;		/* Config address		*/
 	int pe_config_addr;		/* PE config address		*/
 	u32 config_space[16];		/* Saved PCI config space	*/
-	u8 pcie_cap;			/* Saved PCIe capability	*/
+	int pcix_cap;			/* Saved PCIx capability	*/
+	int pcie_cap;			/* Saved PCIe capability	*/
+	int aer_cap;			/* Saved AER capability		*/
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index c6d8f7e..69df898 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -145,7 +145,6 @@ static struct eeh_stats eeh_stats;
 static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 {
 	struct device_node *dn = eeh_dev_to_of_node(edev);
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	u32 cfg;
 	int cap, i;
 	int n = 0;
@@ -161,13 +160,8 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
 	pr_warn("EEH: PCI cmd/status register: %08x\n", cfg);
 
-	if (!dev) {
-		pr_warn("EEH: no PCI device for this of node\n");
-		return n;
-	}
-
 	/* Gather bridge-specific registers */
-	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
+	if (edev->mode & EEH_DEV_BRIDGE) {
 		eeh_ops->read_config(dn, PCI_SEC_STATUS, 2, &cfg);
 		n += scnprintf(buf+n, len-n, "sec stat:%x\n", cfg);
 		pr_warn("EEH: Bridge secondary status: %04x\n", cfg);
@@ -178,7 +172,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 	}
 
 	/* Dump out the PCI-X command and status regs */
-	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	cap = edev->pcix_cap;
 	if (cap) {
 		eeh_ops->read_config(dn, cap, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-cmd:%x\n", cfg);
@@ -189,28 +183,29 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 		pr_warn("EEH: PCI-X status: %08x\n", cfg);
 	}
 
-	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
-	if (pci_is_pcie(dev)) {
+	/* If PCI-E capable, dump PCI-E cap 10 */
+	cap = edev->pcie_cap;
+	if (cap) {
 		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
 		pr_warn("EEH: PCI-E capabilities and status follow:\n");
 
 		for (i=0; i<=8; i++) {
-			eeh_ops->read_config(dn, dev->pcie_cap+4*i, 4, &cfg);
+			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
 			pr_warn("EEH: PCI-E %02x: %08x\n", i, cfg);
 		}
+	}
 
-		cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-		if (cap) {
-			n += scnprintf(buf+n, len-n, "pci-e AER:\n");
-			pr_warn("EEH: PCI-E AER capability register "
-				"set follows:\n");
-
-			for (i=0; i<14; i++) {
-				eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
-				n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
-				pr_warn("EEH: PCI-E AER %02x: %08x\n", i, cfg);
-			}
+	/* If AER capable, dump it */
+	cap = edev->aer_cap;
+	if (cap) {
+		n += scnprintf(buf+n, len-n, "pci-e AER:\n");
+		pr_warn("EEH: PCI-E AER capability register set follows:\n");
+
+		for (i=0; i<14; i++) {
+			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
+			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
+			pr_warn("EEH: PCI-E AER %02x: %08x\n", i, cfg);
 		}
 	}
 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a59788e..56a206f 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -126,6 +126,7 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	edev->mode	&= 0xFFFFFF00;
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 		edev->mode |= EEH_DEV_BRIDGE;
+	edev->pcix_cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
 	if (pci_is_pcie(dev)) {
 		edev->pcie_cap = pci_pcie_cap(dev);
 
@@ -133,6 +134,9 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 			edev->mode |= EEH_DEV_ROOT_PORT;
 		else if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
 			edev->mode |= EEH_DEV_DS_PORT;
+
+		edev->aer_cap = pci_find_ext_capability(dev,
+							PCI_EXT_CAP_ID_ERR);
 	}
 
 	edev->config_addr	= ((dev->bus->number << 8) | dev->devfn);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 8a8f047..9d58a53 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -175,6 +175,36 @@ static int pseries_eeh_find_cap(struct device_node *dn, int cap)
 	return 0;
 }
 
+static int pseries_eeh_find_ecap(struct device_node *dn, int cap)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	u32 header;
+	int pos = 256;
+	int ttl = (4096 - 256) / 8;
+
+	if (!edev || !edev->pcie_cap)
+		return 0;
+	if (rtas_read_config(pdn, pos, 4, &header) != PCIBIOS_SUCCESSFUL)
+		return 0;
+	else if (!header)
+		return 0;
+
+	while (ttl-- > 0) {
+		if (PCI_EXT_CAP_ID(header) == cap && pos)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (pos < 256)
+			break;
+
+		if (rtas_read_config(pdn, pos, 4, &header) != PCIBIOS_SUCCESSFUL)
+			break;
+	}
+
+	return 0;
+}
+
 /**
  * pseries_eeh_of_probe - EEH probe on the given device
  * @dn: OF node
@@ -220,7 +250,9 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 	 * or PCIe switch downstream port.
 	 */
 	edev->class_code = class_code;
+	edev->pcix_cap = pseries_eeh_find_cap(dn, PCI_CAP_ID_PCIX);
 	edev->pcie_cap = pseries_eeh_find_cap(dn, PCI_CAP_ID_EXP);
+	edev->aer_cap = pseries_eeh_find_ecap(dn, PCI_EXT_CAP_ID_ERR);
 	edev->mode &= 0xFFFFFF00;
 	if ((edev->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		edev->mode |= EEH_DEV_BRIDGE;
-- 
1.8.3.2
