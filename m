Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EA021A1951
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:09:09 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:08:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B47982BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:08:52 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s917AWMl33882278
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:10:40 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9178JEk019062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:08:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc/eeh: Rename flag EEH_PE_RESET to
 EEH_PE_CFG_BLOCKED
Date: Wed,  1 Oct 2014 17:07:50 +1000
Message-Id: <1412147274-28770-3-git-send-email-gwshan@linux.vnet.ibm.com>
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

The flag EEH_PE_RESET indicates blocking config space of the PE
during reset time. We potentially need block PE's config space
other than reset time. So it's reasonable to replace it with
EEH_PE_CFG_BLOCKED to indicate its usage.

There are no substantial code or logic changes in this patch.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            |  2 +-
 arch/powerpc/kernel/eeh.c                 | 12 ++++++------
 arch/powerpc/kernel/eeh_driver.c          | 12 ++++++------
 arch/powerpc/kernel/rtas_pci.c            |  4 ++--
 arch/powerpc/platforms/powernv/eeh-ioda.c |  2 +-
 arch/powerpc/platforms/powernv/pci.c      |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index ee54f01..e925a8e 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -71,7 +71,7 @@ struct device_node;
 
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
-#define EEH_PE_RESET		(1 << 2)	/* PE reset in progress	*/
+#define EEH_PE_CFG_BLOCKED	(1 << 2)	/* Block config access	*/
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 519622f..c9d274e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -673,18 +673,18 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 	switch (state) {
 	case pcie_deassert_reset:
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
-		eeh_pe_state_clear(pe, EEH_PE_RESET);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		break;
 	case pcie_hot_reset:
-		eeh_pe_state_mark(pe, EEH_PE_RESET);
+		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
-		eeh_pe_state_mark(pe, EEH_PE_RESET);
+		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 		break;
 	default:
-		eeh_pe_state_clear(pe, EEH_PE_RESET);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		return -EINVAL;
 	};
 
@@ -1523,7 +1523,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 	switch (option) {
 	case EEH_RESET_DEACTIVATE:
 		ret = eeh_ops->reset(pe, option);
-		eeh_pe_state_clear(pe, EEH_PE_RESET);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		if (ret)
 			break;
 
@@ -1538,7 +1538,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 		 */
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 
-		eeh_pe_state_mark(pe, EEH_PE_RESET);
+		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		ret = eeh_ops->reset(pe, option);
 		break;
 	default:
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 3fd514f..6535936 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -528,13 +528,13 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
 
 	/* Issue reset */
-	eeh_pe_state_mark(pe, EEH_PE_RESET);
+	eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 	ret = eeh_reset_pe(pe);
 	if (ret) {
-		eeh_pe_state_clear(pe, EEH_PE_RECOVERING | EEH_PE_RESET);
+		eeh_pe_state_clear(pe, EEH_PE_RECOVERING | EEH_PE_CFG_BLOCKED);
 		return ret;
 	}
-	eeh_pe_state_clear(pe, EEH_PE_RESET);
+	eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 
 	/* Unfreeze the PE */
 	ret = eeh_clear_pe_frozen_state(pe, true);
@@ -601,10 +601,10 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 * config accesses. So we prefer to block them. However, controlled
 	 * PCI config accesses initiated from EEH itself are allowed.
 	 */
-	eeh_pe_state_mark(pe, EEH_PE_RESET);
+	eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 	rc = eeh_reset_pe(pe);
 	if (rc) {
-		eeh_pe_state_clear(pe, EEH_PE_RESET);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		return rc;
 	}
 
@@ -613,7 +613,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	/* Restore PE */
 	eeh_ops->configure_bridge(pe);
 	eeh_pe_restore_bars(pe);
-	eeh_pe_state_clear(pe, EEH_PE_RESET);
+	eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 
 	/* Clear frozen state */
 	rc = eeh_clear_pe_frozen_state(pe, false);
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index c168337..ce7c8b6 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -111,7 +111,7 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 #ifdef CONFIG_EEH
 	edev = of_node_to_eeh_dev(dn);
-	if (edev && edev->pe && edev->pe->state & EEH_PE_RESET)
+	if (edev && edev->pe && edev->pe->state & EEH_PE_CFG_BLOCKED)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 #endif
 
@@ -175,7 +175,7 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 #ifdef CONFIG_EEH
 	edev = of_node_to_eeh_dev(dn);
-	if (edev && edev->pe && (edev->pe->state & EEH_PE_RESET))
+	if (edev && edev->pe && (edev->pe->state & EEH_PE_CFG_BLOCKED))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 #endif
 	ret = rtas_write_config(pdn, where, size, val);
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 61ccb1e..5cd4226 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -373,7 +373,7 @@ static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
 	 * moving forward, we have to return operational
 	 * state during PE reset.
 	 */
-	if (pe->state & EEH_PE_RESET) {
+	if (pe->state & EEH_PE_CFG_BLOCKED) {
 		result = (EEH_STATE_MMIO_ACTIVE  |
 			  EEH_STATE_DMA_ACTIVE   |
 			  EEH_STATE_MMIO_ENABLED |
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index e9f509b..b1b7ac2 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -513,7 +513,7 @@ static bool pnv_pci_cfg_check(struct pci_controller *hose,
 	edev = of_node_to_eeh_dev(dn);
 	if (edev) {
 		if (edev->pe &&
-		    (edev->pe->state & EEH_PE_RESET))
+		    (edev->pe->state & EEH_PE_CFG_BLOCKED))
 			return false;
 
 		if (edev->mode & EEH_DEV_REMOVED)
-- 
1.8.3.2
