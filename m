Return-Path: <B32579@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68E21B6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Apr 2011 16:36:42 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Save and restore pcie ATMU windows for PM
Date: Thu, 28 Apr 2011 12:08:49 +0530
Message-ID: <1303972729-32242-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>,
	Jiang Yutang <b14898@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

D3-cold state indicates removal of the clock and power. however auxiliary (AUX)
Power may remain available even after the main power rails are powered down.

wakeup from D3-cold state requires full context restore. Other things are taken
care in pci-driver except ATMUs.
ATMU windows needs to be saved and restored during suspend and resume.

Signed-off-by: Jiang Yutang <b14898@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branch master)

 arch/powerpc/sysdev/fsl_pci.c |  116 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h |    7 ++-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index f8f7f28..809fbfe 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -35,6 +35,9 @@
 #include <sysdev/fsl_pci.h>
 
 static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
+static int pcie_saved_pow_piw;
+struct pci_outbound_window_regs pcie_saved_pow[PCIE_POW_NUMBER];
+struct pci_inbound_window_regs pcie_saved_piw[PCIE_PIW_NUMBER];
 
 static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
 {
@@ -746,3 +749,116 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 
 	return 0;
 }
+
+
+static int fsl_pcie_save_pow_piw(struct device_node *np,
+					struct resource *rsrc)
+{
+	struct ccsr_pci __iomem *pci;
+	int start_idx = 1, end_idx = 4;
+	unsigned int i;
+
+	pci = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
+
+	if (!pci) {
+		printk(KERN_WARNING"pcie_pow ioremap error!\n");
+		return -1;
+	}
+
+	if (of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2")) {
+		start_idx = 0;
+		end_idx = 3;
+	}
+
+	for (i = 0; i < PCIE_POW_NUMBER; i++) {
+		pcie_saved_pow[i].potar = in_be32(&pci->pow[i].potar);
+		pcie_saved_pow[i].potear = in_be32(&pci->pow[i].potear);
+		pcie_saved_pow[i].powbar = in_be32(&pci->pow[i].powbar);
+		pcie_saved_pow[i].powar = in_be32(&pci->pow[i].powar);
+	}
+
+	for (i = start_idx; i < end_idx; i++) {
+		pcie_saved_piw[i].pitar = in_be32(&pci->piw[i].pitar);
+		pcie_saved_piw[i].piwbar = in_be32(&pci->piw[i].piwbar);
+		pcie_saved_piw[i].piwbear = in_be32(&pci->piw[i].piwbear);
+		pcie_saved_piw[i].piwar = in_be32(&pci->piw[i].piwar);
+	}
+
+	iounmap(pci);
+	return 0;
+}
+
+static int fsl_pcie_restore_pow_piw(struct device_node *np,
+					struct resource *rsrc)
+{
+	struct ccsr_pci __iomem *pci;
+	int start_idx = 1, end_idx = 4;
+	unsigned int i;
+
+	pci = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
+
+	if (of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2")) {
+		start_idx = 0;
+		end_idx = 3;
+	}
+	if (!pci) {
+		printk(KERN_WARNING"pcie_pow ioremap error!\n");
+		return -1;
+	}
+
+	for (i = 0; i < PCIE_POW_NUMBER; i++) {
+		out_be32(&pci->pow[i].potar, pcie_saved_pow[i].potar);
+		out_be32(&pci->pow[i].potear, pcie_saved_pow[i].potear);
+		out_be32(&pci->pow[i].powbar, pcie_saved_pow[i].powbar);
+		out_be32(&pci->pow[i].powar, pcie_saved_pow[i].powar);
+	}
+
+	for (i = 0; i < PCIE_PIW_NUMBER; i++) {
+		out_be32(&pci->piw[i].pitar, pcie_saved_piw[i].pitar);
+		out_be32(&pci->piw[i].piwbar, pcie_saved_piw[i].piwbar);
+		out_be32(&pci->piw[i].piwbear, pcie_saved_piw[i].piwbear);
+		out_be32(&pci->piw[i].piwar, pcie_saved_piw[i].piwar);
+	}
+
+	iounmap(pci);
+	return 0;
+}
+
+static void fsl_pcie_suspend_save(struct pci_dev *dev)
+{
+	struct device_node *np;
+	struct resource rsrc;
+
+	if (pcie_saved_pow_piw == 1)
+		return;
+
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,p1022-pcie")) {
+			of_address_to_resource(np, 0, &rsrc);
+			fsl_pcie_save_pow_piw(np, &rsrc);
+		}
+	}
+	pcie_saved_pow_piw = 1;
+}
+DECLARE_PCI_FIXUP_SUSPEND(0x1957, PCI_DEVICE_ID_P1022E, fsl_pcie_suspend_save);
+DECLARE_PCI_FIXUP_SUSPEND(0x1957, PCI_DEVICE_ID_P1022, fsl_pcie_suspend_save);
+
+static void fsl_pcie_resume_restore(struct pci_dev *dev)
+{
+	struct device_node *np;
+	struct resource rsrc;
+
+	if (pcie_saved_pow_piw == 0)
+		return;
+
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,p1022-pcie")) {
+			of_address_to_resource(np, 0, &rsrc);
+			fsl_pcie_restore_pow_piw(np, &rsrc);
+		}
+	}
+	pcie_saved_pow_piw = 0;
+}
+DECLARE_PCI_FIXUP_RESUME(0x1957, PCI_DEVICE_ID_P1022E, fsl_pcie_resume_restore);
+DECLARE_PCI_FIXUP_RESUME(0x1957, PCI_DEVICE_ID_P1022, fsl_pcie_resume_restore);
+
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..853672f 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -14,6 +14,9 @@
 #ifndef __POWERPC_FSL_PCI_H
 #define __POWERPC_FSL_PCI_H
 
+#define PCIE_POW_NUMBER	5
+#define PCIE_PIW_NUMBER	4
+
 #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
 #define PCIE_LTSSM_L0	0x16		/* L0 state */
 #define PIWAR_EN		0x80000000	/* Enable */
@@ -64,7 +67,7 @@ struct ccsr_pci {
  * The default outbound register set is used when a transaction misses
  * in all of the other outbound windows.
  */
-	struct pci_outbound_window_regs pow[5];
+	struct pci_outbound_window_regs pow[PCIE_POW_NUMBER];
 	u8	res14[96];
 	struct pci_inbound_window_regs	pmit;	/* 0xd00 - 0xd9c Inbound MSI */
 	u8	res6[96];
@@ -72,7 +75,7 @@ struct ccsr_pci {
  * inbound window 1 supports only a 32-bit base address and does not
  * define an inbound window base extended address register.
  */
-	struct pci_inbound_window_regs piw[4];
+	struct pci_inbound_window_regs piw[PCIE_PIW_NUMBER];
 
 	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect register */
 	u8	res21[4];
-- 
1.7.3
