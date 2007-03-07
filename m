Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Mar 2007 11:27:55 +0100
Subject: [PATCH 3/3] powerpc: Fix warning in powermac pci.c
Message-Id: <20070307102807.71977DE261@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes a warning due to unused result from pci_enable_device() in
powermac pci.c

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/platforms/powermac/pci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-tika/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-tika.orig/arch/powerpc/platforms/powermac/pci.c	2007-03-05 14:24:23.000000000 +0100
+++ linux-tika/arch/powerpc/platforms/powermac/pci.c	2007-03-05 14:25:17.000000000 +0100
@@ -1191,8 +1191,11 @@
 	 * -- BenH
 	 */
 	for_each_pci_dev(dev) {
-		if ((dev->class >> 16) == PCI_BASE_CLASS_STORAGE)
-			pci_enable_device(dev);
+		if ((dev->class >> 16) != PCI_BASE_CLASS_STORAGE)
+			continue;
+		if (pci_enable_device(dev))
+			printk(KERN_WARNING
+			       "pci: Failed to enable %s\n", pci_name(dev));
 	}
 #endif /* CONFIG_BLK_DEV_IDE */
 
