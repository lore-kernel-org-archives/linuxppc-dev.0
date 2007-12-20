Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:54:56 +1100
Subject: [PATCH 11/19] [POWERPC] Updates/fixes to 32 bits
	pcibios_enable_device()
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035458.764ABDDF3E@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Our implementation of pcibios_enable_device() incorrectly ignores
the mask argument and always checks that all resources have been
allocated which isn't the right thing to do anymore.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_32.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:32.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:33.000000000 +1100
@@ -530,10 +530,16 @@ int pcibios_enable_device(struct pci_dev
 		
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for (idx=0; idx<6; idx++) {
+	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
+		/* Only set up the requested stuff */
+		if (!(mask & (1 << idx)))
+			continue;
 		r = &dev->resource[idx];
+		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
 		if (r->flags & IORESOURCE_UNSET) {
-			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
+			printk(KERN_ERR "PCI: Device %s not available because"
+			       " of resource collisions\n", pci_name(dev));
 			return -EINVAL;
 		}
 		if (r->flags & IORESOURCE_IO)
