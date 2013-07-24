Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 604912C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:25:18 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 24 Jul 2013 02:25:16 -0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4012119D8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:01 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6O2PClH278386
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:12 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O2PC8I032353
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:12 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/11] powerpc/eeh: Don't use pci_dev during BAR restore
Date: Wed, 24 Jul 2013 10:24:59 +0800
Message-Id: <1374632701-20972-10-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While restoring BARs for one specific PCI device, the pci_dev
instance should have been released. So it's not reliable to use
the pci_dev instance on restoring BARs. However, we still need
some information (e.g. PCIe capability position, header type) from
the pci_dev instance. So we have to store those information to
EEH device in advance.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    8 +++-
 arch/powerpc/kernel/eeh_pe.c                 |   25 +++++-----
 arch/powerpc/platforms/powernv/eeh-powernv.c |   11 +++++
 arch/powerpc/platforms/pseries/eeh_pseries.c |   63 +++++++++++++++++++++++++-
 4 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index f54a601..4199d99 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -84,8 +84,11 @@ struct eeh_pe {
  * another tree except the currently existing tree of PCI
  * buses and PCI devices
  */
-#define EEH_DEV_IRQ_DISABLED	(1 << 0)	/* Interrupt disabled	*/
-#define EEH_DEV_DISCONNECTED	(1 << 1)	/* Removing from PE	*/
+#define EEH_DEV_BRIDGE		(1 << 0)	/* PCI bridge		*/
+#define EEH_DEV_ROOT_PORT	(1 << 1)	/* PCIe root port	*/
+#define EEH_DEV_DS_PORT		(1 << 2)	/* Downstream port	*/
+#define EEH_DEV_IRQ_DISABLED	(1 << 3)	/* Interrupt disabled	*/
+#define EEH_DEV_DISCONNECTED	(1 << 4)	/* Removing from PE	*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
@@ -93,6 +96,7 @@ struct eeh_dev {
 	int config_addr;		/* Config address		*/
 	int pe_config_addr;		/* PE config address		*/
 	u32 config_space[16];		/* Saved PCI config space	*/
+	u8 pcie_cap;			/* Saved PCIe capability	*/
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 2aa955a..f945053 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -578,7 +578,7 @@ void eeh_pe_state_clear(struct eeh_pe *pe, int state)
  * blocked on normal path during the stage. So we need utilize
  * eeh operations, which is always permitted.
  */
-static void eeh_bridge_check_link(struct pci_dev *pdev,
+static void eeh_bridge_check_link(struct eeh_dev *edev,
 				  struct device_node *dn)
 {
 	int cap;
@@ -589,16 +589,17 @@ static void eeh_bridge_check_link(struct pci_dev *pdev,
 	 * We only check root port and downstream ports of
 	 * PCIe switches
 	 */
-	if (!pci_is_pcie(pdev) ||
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
-	     pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
+	if (!(edev->mode & (EEH_DEV_ROOT_PORT | EEH_DEV_DS_PORT)))
 		return;
 
-	pr_debug("%s: Check PCIe link for %s ...\n",
-		 __func__, pci_name(pdev));
+	pr_debug("%s: Check PCIe link for %04x:%02x:%02x.%01x ...\n",
+		 __func__, edev->phb->global_number,
+		 edev->config_addr >> 8,
+		 PCI_SLOT(edev->config_addr & 0xFF),
+		 PCI_FUNC(edev->config_addr & 0xFF));
 
 	/* Check slot status */
-	cap = pdev->pcie_cap;
+	cap = edev->pcie_cap;
 	eeh_ops->read_config(dn, cap + PCI_EXP_SLTSTA, 2, &val);
 	if (!(val & PCI_EXP_SLTSTA_PDS)) {
 		pr_debug("  No card in the slot (0x%04x) !\n", val);
@@ -652,8 +653,7 @@ static void eeh_bridge_check_link(struct pci_dev *pdev,
 #define BYTE_SWAP(OFF)	(8*((OFF)/4)+3-(OFF))
 #define SAVED_BYTE(OFF)	(((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
 
-static void eeh_restore_bridge_bars(struct pci_dev *pdev,
-				    struct eeh_dev *edev,
+static void eeh_restore_bridge_bars(struct eeh_dev *edev,
 				    struct device_node *dn)
 {
 	int i;
@@ -679,7 +679,7 @@ static void eeh_restore_bridge_bars(struct pci_dev *pdev,
 	eeh_ops->write_config(dn, PCI_COMMAND, 4, edev->config_space[1]);
 
 	/* Check the PCIe link is ready */
-	eeh_bridge_check_link(pdev, dn);
+	eeh_bridge_check_link(edev, dn);
 }
 
 static void eeh_restore_device_bars(struct eeh_dev *edev,
@@ -729,12 +729,11 @@ static void eeh_restore_device_bars(struct eeh_dev *edev,
 static void *eeh_restore_one_device_bars(void *data, void *flag)
 {
 	struct eeh_dev *edev = (struct eeh_dev *)data;
-	struct pci_dev *pdev = eeh_dev_to_pci_dev(edev);
 	struct device_node *dn = eeh_dev_to_of_node(edev);
 
 	/* Do special restore for bridges */
-	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-		eeh_restore_bridge_bars(pdev, edev, dn);
+	if (edev->mode & EEH_DEV_BRIDGE)
+		eeh_restore_bridge_bars(edev, dn);
 	else
 		eeh_restore_device_bars(edev, dn);
 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a380428..4361a5c 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -124,6 +124,17 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	/* Initialize eeh device */
 	edev->class_code	= dev->class;
 	edev->mode		= 0;
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		edev->mode |= EEH_DEV_BRIDGE;
+	if (pci_is_pcie(dev)) {
+		edev->pcie_cap = pci_pcie_cap(dev);
+
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+			edev->mode |= EEH_DEV_ROOT_PORT;
+		else if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
+			edev->mode |= EEH_DEV_DS_PORT;
+	}
+
 	edev->config_addr	= ((dev->bus->number << 8) | dev->devfn);
 	edev->pe_config_addr	= phb->bdfn_to_pe(phb, dev->bus, dev->devfn & 0xff);
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 0f44f9f..9e80f0a 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -133,6 +133,48 @@ static int pseries_eeh_init(void)
 	return 0;
 }
 
+static int pseries_eeh_cap_start(struct device_node *dn)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+	u32 status;
+
+	if (!pdn)
+		return 0;
+
+	rtas_read_config(pdn, PCI_STATUS, 2, &status);
+	if (!(status & PCI_STATUS_CAP_LIST))
+		return 0;
+
+	return PCI_CAPABILITY_LIST;
+}
+
+
+static int pseries_eeh_find_cap(struct device_node *dn, int cap)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+	int pos = pseries_eeh_cap_start(dn);
+	int cnt = 48;	/* Maximal number of capabilities */
+	u32 id;
+
+	if (!pos)
+		return 0;
+
+        while (cnt--) {
+		rtas_read_config(pdn, pos, 1, &pos);
+		if (pos < 0x40)
+			break;
+		pos &= ~3;
+		rtas_read_config(pdn, pos + PCI_CAP_LIST_ID, 1, &id);
+		if (id == 0xff)
+			break;
+		if (id == cap)
+			return pos;
+		pos += PCI_CAP_LIST_NEXT;
+	}
+
+	return 0;
+}
+
 /**
  * pseries_eeh_of_probe - EEH probe on the given device
  * @dn: OF node
@@ -146,8 +188,10 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 {
 	struct eeh_dev *edev;
 	struct eeh_pe pe;
+	struct pci_dn *pdn = PCI_DN(dn);
 	const u32 *class_code, *vendor_id, *device_id;
 	const u32 *regs;
+	u32 pcie_flags;
 	int enable = 0;
 	int ret;
 
@@ -167,9 +211,26 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 	if (dn->type && !strcmp(dn->type, "isa"))
 		return NULL;
 
-	/* Update class code and mode of eeh device */
+	/*
+	 * Update class code and mode of eeh device. We need
+	 * correctly reflects that current device is root port
+	 * or PCIe switch downstream port.
+	 */
 	edev->class_code = *class_code;
+	edev->pcie_cap = pseries_eeh_find_cap(dn, PCI_CAP_ID_EXP);
 	edev->mode = 0;
+	if ((edev->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		edev->mode |= EEH_DEV_BRIDGE;
+		if (edev->pcie_cap) {
+			rtas_read_config(pdn, edev->pcie_cap + PCI_EXP_FLAGS,
+					 2, &pcie_flags);
+			pcie_flags = (pcie_flags & PCI_EXP_FLAGS_TYPE) >> 4;
+			if (pcie_flags == PCI_EXP_TYPE_ROOT_PORT)
+				edev->mode |= EEH_DEV_ROOT_PORT;
+			else if (pcie_flags == PCI_EXP_TYPE_DOWNSTREAM)
+				edev->mode |= EEH_DEV_DS_PORT;
+		}
+	}
 
 	/* Retrieve the device address */
 	regs = of_get_property(dn, "reg", NULL);
-- 
1.7.5.4
