Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48BC81A0E36
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 15:01:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 23 Jan 2015 14:01:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 24B85357804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 15:01:46 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0N41iRK19202154
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 15:01:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0N41gtq005069
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 15:01:43 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Drop delay in pcibios_set_pcie_reset_state()
Date: Fri, 23 Jan 2015 15:01:42 +1100
Message-Id: <1421985702-18882-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: wenxiong@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pcibios_set_pcie_reset_state(), implemented based on platform's EEH reset
backends, helps to reset PCI adapters. IPR driver might call this function
in timer handler and it's hard to make reset assertion and settlement delays
with msleep() in the atomic context. The issue was caused by commit 26833a5
("powerpc/eeh: Make the delay for PE reset unified").

The patch drops the reset assertion and settlement delays in the API and
caller will have to take corresponding delays. With the patch applied, the
reset assertion and settlement delays related to EEH reset become:

  * Reset for EEH recovery: inband
  * Reset for Guest PE recovery: inband
  * pcibios_set_pcie_reset_state(): outband

Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  2 +-
 arch/powerpc/kernel/eeh.c                    | 16 +++++++--------
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 29 ++++++++++++++++------------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  4 ++--
 arch/powerpc/platforms/powernv/pci.h         |  2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |  6 +++++-
 6 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 55abfd0..0bc7d3f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -205,7 +205,7 @@ struct eeh_ops {
 	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_pe_addr)(struct eeh_pe *pe);
 	int (*get_state)(struct eeh_pe *pe, int *state);
-	int (*reset)(struct eeh_pe *pe, int option);
+	int (*reset)(struct eeh_pe *pe, int option, bool delay);
 	int (*wait_state)(struct eeh_pe *pe, int max_wait);
 	int (*get_log)(struct eeh_pe *pe, int severity, char *drv_log, unsigned long len);
 	int (*configure_bridge)(struct eeh_pe *pe);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 3b2252e..b0352b5c 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -688,16 +688,16 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 
 	switch (state) {
 	case pcie_deassert_reset:
-		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
+		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE, false);
 		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		break;
 	case pcie_hot_reset:
 		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
-		eeh_ops->reset(pe, EEH_RESET_HOT);
+		eeh_ops->reset(pe, EEH_RESET_HOT, false);
 		break;
 	case pcie_warm_reset:
 		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
-		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
+		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL, false);
 		break;
 	default:
 		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
@@ -749,11 +749,11 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 	eeh_pe_dev_traverse(pe, eeh_set_dev_freset, &freset);
 
 	if (freset)
-		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
+		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL, true);
 	else
-		eeh_ops->reset(pe, EEH_RESET_HOT);
+		eeh_ops->reset(pe, EEH_RESET_HOT, true);
 
-	eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
+	eeh_ops->reset(pe, EEH_RESET_DEACTIVATE, true);
 }
 
 /**
@@ -1547,7 +1547,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 
 	switch (option) {
 	case EEH_RESET_DEACTIVATE:
-		ret = eeh_ops->reset(pe, option);
+		ret = eeh_ops->reset(pe, option, true);
 		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		if (ret)
 			break;
@@ -1564,7 +1564,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 
 		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
-		ret = eeh_ops->reset(pe, option);
+		ret = eeh_ops->reset(pe, option, true);
 		break;
 	default:
 		pr_debug("%s: Unsupported option %d\n",
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 2809c98..1a53cda 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -548,7 +548,8 @@ out:
 	return 0;
 }
 
-static int ioda_eeh_root_reset(struct pci_controller *hose, int option)
+static int ioda_eeh_root_reset(struct pci_controller *hose,
+			       int option, bool delay)
 {
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc = OPAL_SUCCESS;
@@ -578,7 +579,7 @@ static int ioda_eeh_root_reset(struct pci_controller *hose, int option)
 
 	/* Poll state of the PHB until the request is done */
 	rc = ioda_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE)
+	if (delay && option == EEH_RESET_DEACTIVATE)
 		msleep(EEH_PE_RST_SETTLE_TIME);
 out:
 	if (rc != OPAL_SUCCESS)
@@ -587,7 +588,7 @@ out:
 	return 0;
 }
 
-static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
+static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option, bool delay)
 
 {
 	struct device_node *dn = pci_device_to_OF_node(dev);
@@ -614,14 +615,18 @@ static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
 		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
-		msleep(EEH_PE_RST_HOLD_TIME);
+
+		if (delay)
+			msleep(EEH_PE_RST_HOLD_TIME);
 
 		break;
 	case EEH_RESET_DEACTIVATE:
 		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
-		msleep(EEH_PE_RST_SETTLE_TIME);
+
+		if (delay)
+			msleep(EEH_PE_RST_SETTLE_TIME);
 
 		/* Continue reporting linkDown event */
 		if (aer) {
@@ -644,11 +649,11 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 
 	if (pci_is_root_bus(dev->bus)) {
 		hose = pci_bus_to_host(dev->bus);
-		ioda_eeh_root_reset(hose, EEH_RESET_HOT);
-		ioda_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
+		ioda_eeh_root_reset(hose, EEH_RESET_HOT, true);
+		ioda_eeh_root_reset(hose, EEH_RESET_DEACTIVATE, true);
 	} else {
-		ioda_eeh_bridge_reset(dev, EEH_RESET_HOT);
-		ioda_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
+		ioda_eeh_bridge_reset(dev, EEH_RESET_HOT, true);
+		ioda_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE, true);
 	}
 }
 
@@ -664,7 +669,7 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
  * through FLR. For now, we don't have OPAL APIs to do HARD
  * reset yet, so all reset would be SOFT (HOT) reset.
  */
-static int ioda_eeh_reset(struct eeh_pe *pe, int option)
+static int ioda_eeh_reset(struct eeh_pe *pe, int option, bool delay)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pci_bus *bus;
@@ -715,9 +720,9 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 		bus = eeh_pe_bus_get(pe);
 		if (pci_is_root_bus(bus) ||
 		    pci_is_root_bus(bus->parent))
-			ret = ioda_eeh_root_reset(hose, option);
+			ret = ioda_eeh_root_reset(hose, option, delay);
 		else
-			ret = ioda_eeh_bridge_reset(bus->self, option);
+			ret = ioda_eeh_bridge_reset(bus->self, option, delay);
 	}
 
 	return ret;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e261869..c89a7c4 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -298,14 +298,14 @@ static int powernv_eeh_get_state(struct eeh_pe *pe, int *delay)
  *
  * Reset the specified PE
  */
-static int powernv_eeh_reset(struct eeh_pe *pe, int option)
+static int powernv_eeh_reset(struct eeh_pe *pe, int option, bool delay)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
 	int ret = -EEXIST;
 
 	if (phb->eeh_ops && phb->eeh_ops->reset)
-		ret = phb->eeh_ops->reset(pe, option);
+		ret = phb->eeh_ops->reset(pe, option, delay);
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 6c02ff8..a998f2e 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -81,7 +81,7 @@ struct pnv_eeh_ops {
 	int (*post_init)(struct pci_controller *hose);
 	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_state)(struct eeh_pe *pe);
-	int (*reset)(struct eeh_pe *pe, int option);
+	int (*reset)(struct eeh_pe *pe, int option, bool delay);
 	int (*get_log)(struct eeh_pe *pe, int severity,
 		       char *drv_log, unsigned long len);
 	int (*configure_bridge)(struct eeh_pe *pe);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index a6c7e19..0c8d550 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -501,7 +501,7 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
  *
  * Reset the specified PE
  */
-static int pseries_eeh_reset(struct eeh_pe *pe, int option)
+static int pseries_eeh_reset(struct eeh_pe *pe, int option, bool delay)
 {
 	int config_addr;
 	int ret;
@@ -525,6 +525,9 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
 				BUID_LO(pe->phb->buid), option);
 	}
 
+	if (!delay)
+		goto out;
+
 	/* We need reset hold or settlement delay */
 	if (option == EEH_RESET_FUNDAMENTAL ||
 	    option == EEH_RESET_HOT)
@@ -532,6 +535,7 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
 	else
 		msleep(EEH_PE_RST_SETTLE_TIME);
 
+out:
 	return ret;
 }
 
-- 
1.8.3.2
