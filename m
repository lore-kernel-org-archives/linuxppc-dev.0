Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1F822C02F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 11:38:47 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 19:38:46 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8383F19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:38:04 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5Q1cDLW133300
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:38:13 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5Q1cDas022479
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:38:13 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc/eeh: Check PCIe link after reset
Date: Wed, 26 Jun 2013 09:38:04 +0800
Message-Id: <1372210688-12214-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372210688-12214-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372210688-12214-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After reset (e.g. complete reset) in order to bring the fenced PHB
back, the PCIe link might not be ready yet. The patch intends to
make sure the PCIe link is ready before accessing its subordinate
PCI devices. The patch also fixes that wrong values restored to
PCI_COMMAND register for PCI bridges.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c |  157 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 144 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 55943fc..016588a 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -22,6 +22,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
@@ -567,30 +568,132 @@ void eeh_pe_state_clear(struct eeh_pe *pe, int state)
 	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
 }
 
-/**
- * eeh_restore_one_device_bars - Restore the Base Address Registers for one device
- * @data: EEH device
- * @flag: Unused
+/*
+ * Some PCI bridges (e.g. PLX bridges) have primary/secondary
+ * buses assigned explicitly by firmware, and we probably have
+ * lost that after reset. So we have to delay the check until
+ * the PCI-CFG registers have been restored for the parent
+ * bridge.
  *
- * Loads the PCI configuration space base address registers,
- * the expansion ROM base address, the latency timer, and etc.
- * from the saved values in the device node.
+ * Don't use normal PCI-CFG accessors, which probably has been
+ * blocked on normal path during the stage. So we need utilize
+ * eeh operations, which is always permitted.
  */
-static void *eeh_restore_one_device_bars(void *data, void *flag)
+static void eeh_bridge_check_link(struct pci_dev *pdev,
+				  struct device_node *dn)
+{
+	int cap;
+	uint32_t val;
+	int timeout = 0;
+
+	/*
+	 * We only check root port and downstream ports of
+	 * PCIe switches
+	 */
+	if (!pci_is_pcie(pdev) ||
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
+	     pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
+		return;
+
+	pr_debug("%s: Check PCIe link for %s ...\n",
+		 __func__, pci_name(pdev));
+
+	/* Check slot status */
+	cap = pdev->pcie_cap;
+	eeh_ops->read_config(dn, cap + PCI_EXP_SLTSTA, 2, &val);
+	if (!(val & PCI_EXP_SLTSTA_PDS)) {
+		pr_debug("  No card in the slot (0x%04x) !\n", val);
+		return;
+	}
+
+	/* Check power status if we have the capability */
+	eeh_ops->read_config(dn, cap + PCI_EXP_SLTCAP, 2, &val);
+	if (val & PCI_EXP_SLTCAP_PCP) {
+		eeh_ops->read_config(dn, cap + PCI_EXP_SLTCTL, 2, &val);
+		if (val & PCI_EXP_SLTCTL_PCC) {
+			pr_debug("  In power-off state, power it on ...\n");
+			val &= ~(PCI_EXP_SLTCTL_PCC | PCI_EXP_SLTCTL_PIC);
+			val |= (0x0100 & PCI_EXP_SLTCTL_PIC);
+			eeh_ops->write_config(dn, cap + PCI_EXP_SLTCTL, 2, val);
+			msleep(2 * 1000);
+		}
+	}
+
+	/* Enable link */
+	eeh_ops->read_config(dn, cap + PCI_EXP_LNKCTL, 2, &val);
+	val &= ~PCI_EXP_LNKCTL_LD;
+	eeh_ops->write_config(dn, cap + PCI_EXP_LNKCTL, 2, val);
+
+	/* Check link */
+	eeh_ops->read_config(dn, cap + PCI_EXP_LNKCAP, 4, &val);
+	if (!(val & PCI_EXP_LNKCAP_DLLLARC)) {
+		pr_debug("  No link reporting capability (0x%08x) \n", val);
+		msleep(1000);
+		return;
+	}
+
+	/* Wait the link is up until timeout (5s) */
+	timeout = 0;
+	while (timeout < 5000) {
+		msleep(20);
+		timeout += 20;
+
+		eeh_ops->read_config(dn, cap + PCI_EXP_LNKSTA, 2, &val);
+		if (val & PCI_EXP_LNKSTA_DLLLA)
+			break;
+	}
+
+	if (val & PCI_EXP_LNKSTA_DLLLA)
+		pr_debug("  Link up (%s)\n",
+			 (val & PCI_EXP_LNKSTA_CLS_2_5GB) ? "2.5GB" : "5GB");
+	else
+		pr_debug("  Link not ready (0x%04x)\n", val);
+}
+
+#define BYTE_SWAP(OFF)	(8*((OFF)/4)+3-(OFF))
+#define SAVED_BYTE(OFF)	(((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
+
+static void eeh_restore_bridge_bars(struct pci_dev *pdev,
+				    struct eeh_dev *edev,
+				    struct device_node *dn)
+{
+	int i;
+
+	/*
+	 * Device BARs: 0x10 - 0x18
+	 * Bus numbers and windows: 0x18 - 0x30
+	 */
+	for (i = 4; i < 13; i++)
+		eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
+	/* Rom: 0x38 */
+	eeh_ops->write_config(dn, 14*4, 4, edev->config_space[14]);
+
+	/* Cache line & Latency timer: 0xC 0xD */
+	eeh_ops->write_config(dn, PCI_CACHE_LINE_SIZE, 1,
+                SAVED_BYTE(PCI_CACHE_LINE_SIZE));
+        eeh_ops->write_config(dn, PCI_LATENCY_TIMER, 1,
+                SAVED_BYTE(PCI_LATENCY_TIMER));
+	/* Max latency, min grant, interrupt ping and line: 0x3C */
+	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
+
+	/* PCI Command: 0x4 */
+	eeh_ops->write_config(dn, PCI_COMMAND, 4, edev->config_space[1]);
+
+	/* Check the PCIe link is ready */
+	eeh_bridge_check_link(pdev, dn);
+}
+
+static void eeh_restore_device_bars(struct eeh_dev *edev,
+				    struct device_node *dn)
 {
 	int i;
 	u32 cmd;
-	struct eeh_dev *edev = (struct eeh_dev *)data;
-	struct device_node *dn = eeh_dev_to_of_node(edev);
 
 	for (i = 4; i < 10; i++)
 		eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
 	/* 12 == Expansion ROM Address */
 	eeh_ops->write_config(dn, 12*4, 4, edev->config_space[12]);
 
-#define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
-#define SAVED_BYTE(OFF) (((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
-
 	eeh_ops->write_config(dn, PCI_CACHE_LINE_SIZE, 1,
 		SAVED_BYTE(PCI_CACHE_LINE_SIZE));
 	eeh_ops->write_config(dn, PCI_LATENCY_TIMER, 1,
@@ -613,6 +716,34 @@ static void *eeh_restore_one_device_bars(void *data, void *flag)
 	else
 		cmd &= ~PCI_COMMAND_SERR;
 	eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
+}
+
+/**
+ * eeh_restore_one_device_bars - Restore the Base Address Registers for one device
+ * @data: EEH device
+ * @flag: Unused
+ *
+ * Loads the PCI configuration space base address registers,
+ * the expansion ROM base address, the latency timer, and etc.
+ * from the saved values in the device node.
+ */
+static void *eeh_restore_one_device_bars(void *data, void *flag)
+{
+	struct pci_dev *pdev = NULL;
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct device_node *dn = eeh_dev_to_of_node(edev);
+
+	/* Trace the PCI bridge */
+	if (eeh_probe_mode_dev()) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (pdev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+                        pdev = NULL;
+        }
+
+	if (pdev)
+		eeh_restore_bridge_bars(pdev, edev, dn);
+	else
+		eeh_restore_device_bars(edev, dn);
 
 	return NULL;
 }
-- 
1.7.5.4
