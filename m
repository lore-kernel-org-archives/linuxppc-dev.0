Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 320DFB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 17:16:34 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAU6GQIm007122
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 00:16:26 -0600
Message-ID: <1322633785.21641.60.camel@pasglop>
Subject: [PATCH] powerpc/pci: Make pci_read_irq_line() static
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 30 Nov 2011 17:16:25 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's only used inside the same file where it's defined. There's
also no point exporting it anymore.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/pci.h   |    2 --
 arch/powerpc/kernel/pci-common.c |    3 +--
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 49c3de5..1c92013 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -184,8 +184,6 @@ extern void of_scan_pci_bridge(struct pci_dev *dev);
 extern void of_scan_bus(struct device_node *node, struct pci_bus *bus);
 extern void of_rescan_bus(struct device_node *node, struct pci_bus *bus);
 
-extern int pci_read_irq_line(struct pci_dev *dev);
-
 struct file;
 extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 unsigned long pfn,
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 9bffc02..fa4a573 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -214,7 +214,7 @@ char __devinit *pcibios_setup(char *str)
  * If the interrupt is used, then gets the interrupt line from the
  * openfirmware and sets it in the pci_dev and pci_config line.
  */
-int pci_read_irq_line(struct pci_dev *pci_dev)
+static int pci_read_irq_line(struct pci_dev *pci_dev)
 {
 	struct of_irq oirq;
 	unsigned int virq;
@@ -283,7 +283,6 @@ int pci_read_irq_line(struct pci_dev *pci_dev)
 
 	return 0;
 }
-EXPORT_SYMBOL(pci_read_irq_line);
 
 /*
  * Platform support for /proc/bus/pci/X/Y mmap()s,
-- 
1.7.7.2
