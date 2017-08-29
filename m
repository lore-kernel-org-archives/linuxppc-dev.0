Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xhL471GFyzDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:34:15 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v2 4/6] powerpc/eeh: Remove unnecessary config_addr
 from eeh_dev
Date: Tue, 29 Aug 2017 17:34:02 +1000
Message-Id: <20170829073404.8885-5-aik@ozlabs.ru>
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

The eeh_dev struct hold a config space address of an associated node
and the very same address is also stored in the pci_dn struct which
is always present during the eeh_dev lifetime.

This uses bus:devfn directly from pci_dn instead of cached and packed
config_addr.

Since config_addr is made from device's bus:dev.fn, there is no point
in keeping it in the debugfs either so remove that too.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changelog:
v2:
* fixed pseries platform
---
 arch/powerpc/include/asm/eeh.h               |  1 -
 arch/powerpc/kernel/eeh_pe.c                 | 42 ++++++++++++++--------------
 arch/powerpc/kernel/eeh_sysfs.c              |  3 --
 arch/powerpc/platforms/powernv/eeh-powernv.c |  9 +++---
 arch/powerpc/platforms/pseries/eeh_pseries.c |  2 --
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 777d37aa0a7f..9847ae3a12d1 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -131,7 +131,6 @@ static inline bool eeh_pe_passed(struct eeh_pe *pe)
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
 	int class_code;			/* Class code of the device	*/
-	int config_addr;		/* Config address		*/
 	int pe_config_addr;		/* PE config address		*/
 	u32 config_space[16];		/* Saved PCI config space	*/
 	int pcix_cap;			/* Saved PCIx capability	*/
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 419c3f07afd5..2e8d1b2b5af4 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -340,11 +340,12 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 {
 	struct eeh_pe *pe, *parent;
 	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
+	int config_addr = (pdn->busno << 8) | (pdn->devfn);
 
 	/* Check if the PE number is valid */
 	if (!eeh_has_flag(EEH_VALID_PE_ZERO) && !edev->pe_config_addr) {
 		pr_err("%s: Invalid PE#0 for edev 0x%x on PHB#%x\n",
-		       __func__, edev->config_addr, pdn->phb->global_number);
+		       __func__, config_addr, pdn->phb->global_number);
 		return -EINVAL;
 	}
 
@@ -354,8 +355,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	 * PE should be composed of PCI bus and its subordinate
 	 * components.
 	 */
-	pe = eeh_pe_get(pdn->phb, edev->pe_config_addr,
-			edev->config_addr);
+	pe = eeh_pe_get(pdn->phb, edev->pe_config_addr, config_addr);
 	if (pe && !(pe->type & EEH_PE_INVALID)) {
 		/* Mark the PE as type of PCI bus */
 		pe->type = EEH_PE_BUS;
@@ -365,10 +365,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 		list_add_tail(&edev->list, &pe->edevs);
 		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Bus PE#%x\n",
 			 pdn->phb->global_number,
-			edev->config_addr >> 8,
-			PCI_SLOT(edev->config_addr & 0xFF),
-			PCI_FUNC(edev->config_addr & 0xFF),
-			pe->addr);
+			 pdn->busno,
+			 PCI_SLOT(pdn->devfn),
+			 PCI_FUNC(pdn->devfn),
+			 pe->addr);
 		return 0;
 	} else if (pe && (pe->type & EEH_PE_INVALID)) {
 		list_add_tail(&edev->list, &pe->edevs);
@@ -388,10 +388,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Device "
 			 "PE#%x, Parent PE#%x\n",
 			 pdn->phb->global_number,
-			edev->config_addr >> 8,
-                        PCI_SLOT(edev->config_addr & 0xFF),
-                        PCI_FUNC(edev->config_addr & 0xFF),
-			pe->addr, pe->parent->addr);
+			 pdn->busno,
+			 PCI_SLOT(pdn->devfn),
+			 PCI_FUNC(pdn->devfn),
+			 pe->addr, pe->parent->addr);
 		return 0;
 	}
 
@@ -405,7 +405,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 		return -ENOMEM;
 	}
 	pe->addr	= edev->pe_config_addr;
-	pe->config_addr	= edev->config_addr;
+	pe->config_addr	= config_addr;
 
 	/*
 	 * Put the new EEH PE into hierarchy tree. If the parent
@@ -436,9 +436,9 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	pr_debug("EEH: Add %04x:%02x:%02x.%01x to "
 		 "Device PE#%x, Parent PE#%x\n",
 		 pdn->phb->global_number,
-		 edev->config_addr >> 8,
-		 PCI_SLOT(edev->config_addr & 0xFF),
-		 PCI_FUNC(edev->config_addr & 0xFF),
+		 pdn->busno,
+		 PCI_SLOT(pdn->devfn),
+		 PCI_FUNC(pdn->devfn),
 		 pe->addr, pe->parent->addr);
 
 	return 0;
@@ -462,9 +462,9 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 	if (!edev->pe) {
 		pr_debug("%s: No PE found for device %04x:%02x:%02x.%01x\n",
 			 __func__,  pdn->phb->global_number,
-			 edev->config_addr >> 8,
-			 PCI_SLOT(edev->config_addr & 0xFF),
-			 PCI_FUNC(edev->config_addr & 0xFF));
+			 pdn->busno,
+			 PCI_SLOT(pdn->devfn),
+			 PCI_FUNC(pdn->devfn));
 		return -EEXIST;
 	}
 
@@ -725,9 +725,9 @@ static void eeh_bridge_check_link(struct eeh_dev *edev)
 
 	pr_debug("%s: Check PCIe link for %04x:%02x:%02x.%01x ...\n",
 		 __func__, pdn->phb->global_number,
-		 edev->config_addr >> 8,
-		 PCI_SLOT(edev->config_addr & 0xFF),
-		 PCI_FUNC(edev->config_addr & 0xFF));
+		 pdn->busno,
+		 PCI_SLOT(pdn->devfn),
+		 PCI_FUNC(pdn->devfn));
 
 	/* Check slot status */
 	cap = edev->pcie_cap;
diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 1ceecdda810b..797549289798 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -51,7 +51,6 @@ static ssize_t eeh_show_##_name(struct device *dev,      \
 static DEVICE_ATTR(_name, S_IRUGO, eeh_show_##_name, NULL);
 
 EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
-EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
 EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
 
 static ssize_t eeh_pe_state_show(struct device *dev,
@@ -103,7 +102,6 @@ void eeh_sysfs_add_device(struct pci_dev *pdev)
 		return;
 
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
-	rc += device_create_file(&pdev->dev, &dev_attr_eeh_config_addr);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_state);
 
@@ -128,7 +126,6 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev)
 	}
 
 	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
-	device_remove_file(&pdev->dev, &dev_attr_eeh_config_addr);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_state);
 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 552b0cd4e8ba..8864065eba22 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -352,6 +352,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 	uint32_t pcie_flags;
 	int ret;
+	int config_addr = (pdn->busno << 8) | (pdn->devfn);
 
 	/*
 	 * When probing the root bridge, which doesn't have any
@@ -386,8 +387,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 		}
 	}
 
-	edev->config_addr    = (pdn->busno << 8) | (pdn->devfn);
-	edev->pe_config_addr = phb->ioda.pe_rmap[edev->config_addr];
+	edev->pe_config_addr = phb->ioda.pe_rmap[config_addr];
 
 	/* Create PE */
 	ret = eeh_add_to_parent_pe(edev);
@@ -1699,6 +1699,7 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 	struct pnv_phb *phb;
 	s64 ret;
+	int config_addr = (pdn->busno << 8) | (pdn->devfn);
 
 	if (!edev)
 		return -EEXIST;
@@ -1715,12 +1716,12 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 	} else {
 		phb = pdn->phb->private_data;
 		ret = opal_pci_reinit(phb->opal_id,
-				      OPAL_REINIT_PCI_DEV, edev->config_addr);
+				      OPAL_REINIT_PCI_DEV, config_addr);
 	}
 
 	if (ret) {
 		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
-			__func__, edev->config_addr, ret);
+			__func__, config_addr, ret);
 		return -EIO;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 04c8c1827549..6b812ad990e4 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -254,7 +254,6 @@ static void *pseries_eeh_probe(struct pci_dn *pdn, void *data)
 	ret = eeh_ops->set_option(&pe, EEH_OPT_ENABLE);
 	if (!ret) {
 		/* Retrieve PE address */
-		edev->config_addr = (pdn->busno << 16) | (pdn->devfn << 8);
 		edev->pe_config_addr = eeh_ops->get_pe_addr(&pe);
 		pe.addr = edev->pe_config_addr;
 
@@ -279,7 +278,6 @@ static void *pseries_eeh_probe(struct pci_dn *pdn, void *data)
 			/* This device doesn't support EEH, but it may have an
 			 * EEH parent, in which case we mark it as supported.
 			 */
-			edev->config_addr = pdn_to_eeh_dev(pdn->parent)->config_addr;
 			edev->pe_config_addr = pdn_to_eeh_dev(pdn->parent)->pe_config_addr;
 			eeh_add_to_parent_pe(edev);
 		}
-- 
2.11.0
