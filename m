Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9CFCEB7148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 18:58:36 +1100 (EST)
Received: from mail197-ch1 (localhost [127.0.0.1])	by
 mail197-ch1-R.bigfish.com (Postfix) with ESMTP id CBDE8280213	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 07:58:52 +0000 (UTC)
Received: from CH1EHSMHS004.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.247])	by mail197-ch1.bigfish.com (Postfix) with ESMTP id
 9DD0260003F	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 07:58:50
 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH SDK1.2 3/3] powerpc/fsl-pci: Add pci inbound/outbound PM
 support
Date: Wed, 21 Dec 2011 15:10:58 +0800
Message-ID: <1324451458-4644-4-git-send-email-B38951@freescale.com>
In-Reply-To: <1324451458-4644-1-git-send-email-B38951@freescale.com>
References: <1324451458-4644-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B11780@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
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
 arch/powerpc/include/asm/pci-bridge.h |    6 ++
 arch/powerpc/sysdev/fsl_pci.c         |  108 +++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 882b6aa..c99b40e 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -92,6 +92,12 @@ struct pci_controller {
 
 	void *private_data;
 #endif	/* CONFIG_PPC64 */
+
+#ifdef CONFIG_SUSPEND
+	struct pci_outbound_window_regs __iomem *pci_pow;
+	struct pci_inbound_window_regs __iomem *pci_piw;
+	void *saved_regs;
+#endif
 };
 
 /* These are used for config access before all the PCI probing
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index e318e9d..046866f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -756,12 +756,120 @@ static int __devinit fsl_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_SUSPEND
+
+#define PCI_POW_NUMBER	5
+#define PCI_POW_BIAS	0xc00
+#define PCI_PIW_NUMBER	3
+#define PCI_PIW_BIAS	0xda0
+
+static int fsl_pci_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct pci_controller *hose;
+	struct pci_outbound_window_regs *pci_saved_pow;
+	struct pci_inbound_window_regs *pci_saved_piw;
+	struct resource pci_rsrc;
+	unsigned int i;
+
+	hose = pci_find_hose_for_OF_device(dev->dev.of_node);
+	of_address_to_resource(dev->dev.of_node, 0, &pci_rsrc);
+
+	hose->pci_pow = ioremap(pci_rsrc.start + PCI_POW_BIAS,
+			sizeof(struct pci_outbound_window_regs)
+			* PCI_POW_NUMBER);
+	if (!hose->pci_pow) {
+		pr_err("pci_pow ioremap error!\n");
+		return -ENOMEM;
+	}
+
+	hose->pci_piw = ioremap(pci_rsrc.start + PCI_PIW_BIAS,
+			sizeof(struct pci_inbound_window_regs)
+			* PCI_PIW_NUMBER);
+	if (!hose->pci_piw) {
+		pr_err("pci_piw ioremap error!\n");
+		goto err1;
+	}
+
+	hose->saved_regs = kmalloc(
+		sizeof(struct pci_outbound_window_regs) * PCI_POW_NUMBER +
+		sizeof(struct pci_inbound_window_regs) * PCI_PIW_NUMBER,
+		GFP_KERNEL);
+	if (!hose->saved_regs)
+		goto err2;
+
+	pci_saved_pow = hose->saved_regs;
+	for (i = 0; i < PCI_POW_NUMBER; i++) {
+		pci_saved_pow[i].potar = in_be32(&hose->pci_pow[i].potar);
+		pci_saved_pow[i].potear = in_be32(&hose->pci_pow[i].potear);
+		pci_saved_pow[i].powbar = in_be32(&hose->pci_pow[i].powbar);
+		pci_saved_pow[i].powar = in_be32(&hose->pci_pow[i].powar);
+	}
+
+	pci_saved_piw = (struct pci_inbound_window_regs *)
+		(pci_saved_pow + PCI_POW_NUMBER);
+	for (i = 0; i < PCI_PIW_NUMBER; i++) {
+		pci_saved_piw[i].pitar = in_be32(&hose->pci_piw[i].pitar);
+		pci_saved_piw[i].piwbar = in_be32(&hose->pci_piw[i].piwbar);
+		pci_saved_piw[i].piwbear = in_be32(&hose->pci_piw[i].piwbear);
+		pci_saved_piw[i].piwar = in_be32(&hose->pci_piw[i].piwar);
+	}
+
+	return 0;
+
+err2:
+	iounmap(hose->pci_piw);
+
+err1:
+	iounmap(hose->pci_pow);
+	return -ENOMEM;
+}
+
+static int fsl_pci_resume(struct platform_device *dev)
+{
+	struct pci_controller *hose;
+	struct pci_outbound_window_regs *pci_saved_pow;
+	struct pci_inbound_window_regs *pci_saved_piw;
+	unsigned int i;
+
+	hose = pci_find_hose_for_OF_device(dev->dev.of_node);
+	if (!hose->pci_pow || !hose->pci_piw || !hose->saved_regs)
+		return 0;
+
+	pci_saved_pow = hose->saved_regs;
+	for (i = 0; i < PCI_POW_NUMBER; i++) {
+		out_be32(&hose->pci_pow[i].potar, pci_saved_pow[i].potar);
+		out_be32(&hose->pci_pow[i].potear, pci_saved_pow[i].potear);
+		out_be32(&hose->pci_pow[i].powbar, pci_saved_pow[i].powbar);
+		out_be32(&hose->pci_pow[i].powar, pci_saved_pow[i].powar);
+	}
+	iounmap(hose->pci_pow);
+
+	pci_saved_piw = (struct pci_inbound_window_regs *)
+		(pci_saved_pow + PCI_POW_NUMBER);
+	for (i = 0; i < PCI_PIW_NUMBER; i++) {
+		out_be32(&hose->pci_piw[i].pitar, pci_saved_piw[i].pitar);
+		out_be32(&hose->pci_piw[i].piwbar, pci_saved_piw[i].piwbar);
+		out_be32(&hose->pci_piw[i].piwbear, pci_saved_piw[i].piwbear);
+		out_be32(&hose->pci_piw[i].piwar, pci_saved_piw[i].piwar);
+	}
+	iounmap(hose->pci_piw);
+	kfree(hose->saved_regs);
+	hose->saved_regs = NULL;
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
-- 
1.7.5.1
