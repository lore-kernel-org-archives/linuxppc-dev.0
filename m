Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF1FF2C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Mar 2014 14:26:51 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 2 Mar 2014 20:26:48 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 01266C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Mar 2014 22:26:42 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s233QjYv262414
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Mar 2014 03:26:45 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s233QijE029209
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Mar 2014 22:26:44 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/eeh: Check PCIe link in
 pcibios_set_pcie_reset_state()
Date: Mon,  3 Mar 2014 11:26:32 +0800
Message-Id: <1393817192-14271-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393817192-14271-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393817192-14271-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After PE reset in pcibios_set_pcie_reset_state(), the PCIe link
might be not ready after settle time of PE primary bus. The
subsequent access to PCI config and MMIO of the affected domain
would cause more problems (e.g. unexpected frozen PE).

The patch checks the PCIe link in pcibios_set_pcie_reset_state()
to make sure all PCIe links are up after PE reset so that to
avoid unexpected problems.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |    1 +
 arch/powerpc/kernel/eeh.c      |   29 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh_pe.c   |   21 +++++++++++++--------
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d4dd41f..e96ed32 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -231,6 +231,7 @@ void *eeh_pe_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
+void eeh_bridge_check_link(struct eeh_dev *edev);
 void eeh_pe_restore_bars(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 251e370..ba2dd2d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -532,6 +532,14 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
 	return rc;
 }
 
+static void *eeh_dev_check_link(void *data, void *flag)
+{
+	struct eeh_dev *edev = data;
+
+	eeh_bridge_check_link(edev);
+	return NULL;
+}
+
 /**
  * pcibios_set_pcie_slot_reset - Set PCI-E reset state
  * @dev: pci device struct
@@ -544,6 +552,7 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 {
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
 	struct eeh_pe *pe = edev->pe;
+	struct pci_bus *bus;
 
 	if (!pe) {
 		pr_err("%s: No PE found on PCI device %s\n",
@@ -551,10 +560,30 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		return -EINVAL;
 	}
 
+	bus = eeh_pe_bus_get(pe);
+	if (!bus) {
+		pr_err("%s: No PE primary bus found for PCI dev %s\n",
+			__func__, pci_name(dev));
+		return -EINVAL;
+	}
+
 	switch (state) {
 	case pcie_deassert_reset:
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
 		msleep(EEH_PE_RESET_HOLD_TIME);
+
+		/*
+		 * After PE reset, the PCIe link is probably
+		 * not ready after settle period. We're checking
+		 * all PCIe downstream port of the affected PE
+		 * ensure that.
+		 */
+		if (bus->self) {
+			edev = pci_dev_to_eeh_dev(bus->self);
+			eeh_bridge_check_link(edev);
+		}
+		eeh_pe_dev_traverse(pe, eeh_dev_check_link, NULL);
+
 		break;
 	case pcie_hot_reset:
 		eeh_ops->reset(pe, EEH_RESET_HOT);
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index f0c353f..a49f9dc 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -567,6 +567,9 @@ void eeh_pe_state_clear(struct eeh_pe *pe, int state)
 }
 
 /*
+ * eeh_bridge_check_link - Check PCI link is up or down
+ * @edev: EEH device
+ *
  * Some PCI bridges (e.g. PLX bridges) have primary/secondary
  * buses assigned explicitly by firmware, and we probably have
  * lost that after reset. So we have to delay the check until
@@ -577,18 +580,20 @@ void eeh_pe_state_clear(struct eeh_pe *pe, int state)
  * blocked on normal path during the stage. So we need utilize
  * eeh operations, which is always permitted.
  */
-static void eeh_bridge_check_link(struct eeh_dev *edev,
-				  struct device_node *dn)
+void eeh_bridge_check_link(struct eeh_dev *edev)
 {
+	struct device_node *dn;
 	int cap;
 	uint32_t val;
 	int timeout = 0;
 
-	/*
-	 * We only check root port and downstream ports of
-	 * PCIe switches
-	 */
-	if (!(edev->mode & (EEH_DEV_ROOT_PORT | EEH_DEV_DS_PORT)))
+	/* Only for root port and downstream ports */
+	if (!edev || !(edev->mode & (EEH_DEV_ROOT_PORT | EEH_DEV_DS_PORT)))
+		return;
+
+	/* Device node */
+	dn = eeh_dev_to_of_node(edev);
+	if (!dn)
 		return;
 
 	pr_debug("%s: Check PCIe link for %04x:%02x:%02x.%01x ...\n",
@@ -678,7 +683,7 @@ static void eeh_restore_bridge_bars(struct eeh_dev *edev,
 	eeh_ops->write_config(dn, PCI_COMMAND, 4, edev->config_space[1]);
 
 	/* Check the PCIe link is ready */
-	eeh_bridge_check_link(edev, dn);
+	eeh_bridge_check_link(edev);
 }
 
 static void eeh_restore_device_bars(struct eeh_dev *edev,
-- 
1.7.10.4
