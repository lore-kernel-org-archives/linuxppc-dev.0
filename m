Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14E5DB7028
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 20:00:52 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V3 4/6] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Fri, 8 Jun 2012 17:42:05 +0800
Message-ID: <1339148527-16911-5-git-send-email-B38951@freescale.com>
In-Reply-To: <1339148527-16911-1-git-send-email-B38951@freescale.com>
References: <1339148527-16911-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: R65777@freescale.com, b38951@freescale.com, B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power supply for PCI inbound/outbound window registers is off when system
go to deep-sleep state. We save the values of registers before suspend
and restore to registers after resume.

Signed-off-by: Jiang Yutang <b14898@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/pci-bridge.h |    2 +-
 arch/powerpc/sysdev/fsl_pci.c         |  121 +++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h         |   10 +++
 3 files changed, 132 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ac39e6a..823e000 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -89,9 +89,9 @@ struct pci_controller {
 
 #ifdef CONFIG_PPC64
 	unsigned long buid;
+#endif	/* CONFIG_PPC64 */
 
 	void *private_data;
-#endif	/* CONFIG_PPC64 */
 };
 
 /* These are used for config access before all the PCI probing
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index a5e573c..287e630 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -857,12 +857,133 @@ static int __devinit fsl_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_SUSPEND
+
+#define PCI_POW_PIW_OFFSET	0xc00
+#define PCI_POW_PIW_SIZE	0x200
+#define PCI_POW_NUMBER		5
+
+static int fsl_pci_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct pci_controller *hose;
+	struct pci_outbound_window_regs *pci_saved_pow;
+	struct pci_inbound_window_regs *pci_saved_piw, *temp_piw;
+	struct resource pci_rsrc;
+	unsigned int i;
+	struct fsl_pci_private_data *sus_info;
+
+	hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
+	of_address_to_resource(pdev->dev.of_node, 0, &pci_rsrc);
+
+	sus_info = kmalloc(
+			sizeof(struct fsl_pci_private_data), GFP_KERNEL);
+	if (!sus_info)
+		return -ENOMEM;
+
+	hose->private_data = sus_info;
+
+	sus_info->pci_pow = ioremap(pci_rsrc.start + PCI_POW_PIW_OFFSET,
+			PCI_POW_PIW_SIZE);
+	if (!sus_info->pci_pow) {
+		dev_err(&pdev->dev, "pci outbound/inbound windows ioremap error!\n");
+		goto err1;
+	}
+
+	sus_info->pci_piw = (struct pci_inbound_window_regs *)
+		((void *)sus_info->pci_pow + PCI_POW_PIW_SIZE) - 1;
+
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,qoriq-pcie-v2.2"))
+		sus_info->inbound_num = 4;
+	else
+		sus_info->inbound_num = 3;
+
+	sus_info->saved_regs = kmalloc(
+		sizeof(struct pci_outbound_window_regs) * PCI_POW_NUMBER +
+		sizeof(struct pci_inbound_window_regs) * sus_info->inbound_num,
+		GFP_KERNEL);
+	if (!sus_info->saved_regs)
+		goto err2;
+
+	pci_saved_pow = sus_info->saved_regs;
+	for (i = 0; i < PCI_POW_NUMBER; i++) {
+		pci_saved_pow[i].potar = in_be32(&sus_info->pci_pow[i].potar);
+		pci_saved_pow[i].potear = in_be32(&sus_info->pci_pow[i].potear);
+		pci_saved_pow[i].powbar = in_be32(&sus_info->pci_pow[i].powbar);
+		pci_saved_pow[i].powar = in_be32(&sus_info->pci_pow[i].powar);
+	}
+
+	pci_saved_piw = (struct pci_inbound_window_regs *)
+		(pci_saved_pow + PCI_POW_NUMBER);
+	temp_piw = sus_info->pci_piw;
+	for (i = 0; i < sus_info->inbound_num; i++, temp_piw--) {
+		pci_saved_piw[i].pitar = in_be32(&temp_piw->pitar);
+		pci_saved_piw[i].piwbar = in_be32(&temp_piw->piwbar);
+		pci_saved_piw[i].piwbear = in_be32(&temp_piw->piwbear);
+		pci_saved_piw[i].piwar = in_be32(&temp_piw->piwar);
+	}
+
+	return 0;
+
+err2:
+	iounmap(sus_info->pci_pow);
+
+err1:
+	kfree(sus_info);
+	return -ENOMEM;
+}
+
+static int fsl_pci_resume(struct platform_device *pdev)
+{
+	struct pci_controller *hose;
+	struct pci_outbound_window_regs *pci_saved_pow;
+	struct pci_inbound_window_regs *pci_saved_piw, *temp_piw;
+	unsigned int i;
+	struct fsl_pci_private_data *sus_info;
+
+	hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
+	sus_info = (struct fsl_pci_private_data *)hose->private_data;
+
+	if (!sus_info->pci_pow || !sus_info->pci_piw || !sus_info->saved_regs)
+		return 0;
+
+	pci_saved_pow = sus_info->saved_regs;
+	for (i = 0; i < PCI_POW_NUMBER; i++) {
+		out_be32(&sus_info->pci_pow[i].potar, pci_saved_pow[i].potar);
+		out_be32(&sus_info->pci_pow[i].potear, pci_saved_pow[i].potear);
+		out_be32(&sus_info->pci_pow[i].powbar, pci_saved_pow[i].powbar);
+		out_be32(&sus_info->pci_pow[i].powar, pci_saved_pow[i].powar);
+	}
+
+	pci_saved_piw = (struct pci_inbound_window_regs *)
+		(pci_saved_pow + PCI_POW_NUMBER);
+	temp_piw = sus_info->pci_piw;
+	for (i = 0; i < sus_info->inbound_num; i++, temp_piw--) {
+		out_be32(&temp_piw->pitar, pci_saved_piw[i].pitar);
+		out_be32(&temp_piw->piwbar, pci_saved_piw[i].piwbar);
+		out_be32(&temp_piw->piwbear, pci_saved_piw[i].piwbear);
+		out_be32(&temp_piw->piwar, pci_saved_piw[i].piwar);
+	}
+	iounmap(sus_info->pci_pow);
+	kfree(sus_info->saved_regs);
+	sus_info->saved_regs = NULL;
+	kfree(sus_info);
+	sus_info = NULL;
+	hose->private_data = NULL;
+
+	return 0;
+}
+#endif
+
 static struct platform_driver fsl_pci_driver = {
 	.driver = {
 		.name = "fsl-pci",
 		.of_match_table = pci_ids,
 	},
 	.probe = fsl_pci_probe,
+#ifdef CONFIG_SUSPEND
+	.suspend	= fsl_pci_suspend,
+	.resume		= fsl_pci_resume,
+#endif
 };
 
 static int __init fsl_pci_init(void)
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index df9fc44..1093e24 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -88,6 +88,16 @@ struct ccsr_pci {
 	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
 };
 
+
+#ifdef CONFIG_SUSPEND
+struct fsl_pci_private_data {
+	int inbound_num;
+	struct pci_outbound_window_regs __iomem *pci_pow;
+	struct pci_inbound_window_regs __iomem *pci_piw;
+	void *saved_regs;
+};
+#endif
+
 extern int primary_phb_addr;
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
-- 
1.7.5.1
