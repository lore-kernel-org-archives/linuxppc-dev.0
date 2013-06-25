Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C1CF02C0394
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 15:55:59 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 24 Jun 2013 23:55:57 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 1182A6E8028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:50 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P5tO2D334472
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:55:24 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P5tN2Y016852
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 02:55:24 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/10] powerpc/eeh: Check PCIe link after reset
Date: Tue, 25 Jun 2013 13:55:10 +0800
Message-Id: <1372139717-14885-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/eeh_pe.c |  120 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 55943fc..db83ada 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -22,6 +22,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
@@ -567,6 +568,88 @@ void eeh_pe_state_clear(struct eeh_pe *pe, int state)
 	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
 }
 
+/*
+ * Some PCI bridges (e.g. PLX bridges) have primary/secondary
+ * buses assigned explicitly by firmware, and we probably have
+ * lost that after reset. So we have to delay the check until
+ * the PCI-CFG registers have been restored for the parent
+ * bridge.
+ *
+ * Don't use normal PCI-CFG accessors, which probably has been
+ * blocked on normal path during the stage. So we need utilize
+ * eeh operations, which is always permitted.
+ */
+static void eeh_bridge_check_link(struct device_node *dn,
+				  struct pci_dev *pdev)
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
 /**
  * eeh_restore_one_device_bars - Restore the Base Address Registers for one device
  * @data: EEH device
@@ -580,9 +663,17 @@ static void *eeh_restore_one_device_bars(void *data, void *flag)
 {
 	int i;
 	u32 cmd;
+	struct pci_dev *pdev = NULL;
 	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct device_node *dn = eeh_dev_to_of_node(edev);
 
+	/* Trace the PCI bridge */
+	if (eeh_probe_mode_dev()) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (pdev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+			pdev = NULL;
+	}
+
 	for (i = 4; i < 10; i++)
 		eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
 	/* 12 == Expansion ROM Address */
@@ -603,16 +694,25 @@ static void *eeh_restore_one_device_bars(void *data, void *flag)
 	 * Restore PERR & SERR bits, some devices require it,
 	 * don't touch the other command bits
 	 */
-	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
-	if (edev->config_space[1] & PCI_COMMAND_PARITY)
-		cmd |= PCI_COMMAND_PARITY;
-	else
-		cmd &= ~PCI_COMMAND_PARITY;
-	if (edev->config_space[1] & PCI_COMMAND_SERR)
-		cmd |= PCI_COMMAND_SERR;
-	else
-		cmd &= ~PCI_COMMAND_SERR;
-	eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
+	if (pdev) {
+		eeh_ops->write_config(dn, PCI_COMMAND, 4,
+				      edev->config_space[1]);
+	} else {
+		eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
+		if (edev->config_space[1] & PCI_COMMAND_PARITY)
+			cmd |= PCI_COMMAND_PARITY;
+		else
+			cmd &= ~PCI_COMMAND_PARITY;
+		if (edev->config_space[1] & PCI_COMMAND_SERR)
+			cmd |= PCI_COMMAND_SERR;
+		else
+			cmd &= ~PCI_COMMAND_SERR;
+		eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
+	}
+
+	/* Check the PCIe link for bridge */
+	if (pdev)
+		eeh_bridge_check_link(dn, pdev);
 
 	return NULL;
 }
-- 
1.7.5.4
