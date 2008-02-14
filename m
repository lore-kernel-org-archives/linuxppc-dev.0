Return-Path: <bzolnier@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id BBC41DE5A7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 11:23:24 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so145260nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 16:23:22 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Thu, 14 Feb 2008 01:37:43 +0100
Message-Id: <20080214003743.12879.33797.sendpatchset@localhost.localdomain>
In-Reply-To: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
References: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Subject: [PATCH 11/11] ppc/pmac: remove no longer needed IDE quirk
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

IDE PMAC host driver and all IDE PCI host drivers use pci_enable_device()
nowadays so the following quirk in pmac_pcibios_after_init() can be removed.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 arch/powerpc/platforms/powermac/pci.c |   22 ----------------------
 1 file changed, 22 deletions(-)

Index: b/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -1144,28 +1144,6 @@ void __init pmac_pcibios_after_init(void
 {
 	struct device_node* nd;
 
-#ifdef CONFIG_BLK_DEV_IDE
-	struct pci_dev *dev = NULL;
-
-	/* OF fails to initialize IDE controllers on macs
-	 * (and maybe other machines)
-	 *
-	 * Ideally, this should be moved to the IDE layer, but we need
-	 * to check specifically with Andre Hedrick how to do it cleanly
-	 * since the common IDE code seem to care about the fact that the
-	 * BIOS may have disabled a controller.
-	 *
-	 * -- BenH
-	 */
-	for_each_pci_dev(dev) {
-		if ((dev->class >> 16) != PCI_BASE_CLASS_STORAGE)
-			continue;
-		if (pci_enable_device(dev))
-			printk(KERN_WARNING
-			       "pci: Failed to enable %s\n", pci_name(dev));
-	}
-#endif /* CONFIG_BLK_DEV_IDE */
-
 	for_each_node_by_name(nd, "firewire") {
 		if (nd->parent && (of_device_is_compatible(nd, "pci106b,18") ||
 				   of_device_is_compatible(nd, "pci106b,30") ||
