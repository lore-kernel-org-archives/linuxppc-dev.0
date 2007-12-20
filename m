Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:55:05 +1100
Subject: [PATCH 19/19] [POWERPC] Disable PCI IO/Mem on a device when resources
	can't be allocated
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035507.B9B94DDF34@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes the PowerPC PCI code to disable IO and/or Memory
decoding on a PCI device when a resource of that type failed to be
allocated. This is done to avoid having unallocated dangling BARs enabled
that might try to decode on top of other devices.

If a proper resource is assigned later on, then pci_enable_device()
will take care of re-enabling decoding.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci-common.c	2007-12-20 14:51:19.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci-common.c	2007-12-20 14:51:20.000000000 +1100
@@ -1034,7 +1034,7 @@ clear_resource:
 	}
 }
 
-static inline void __devinit alloc_resource(struct pci_dev *dev, int idx)
+static inline int __devinit alloc_resource(struct pci_dev *dev, int idx)
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
@@ -1058,7 +1058,10 @@ static inline void __devinit alloc_resou
 		r->flags |= IORESOURCE_UNSET;
 		r->end -= r->start;
 		r->start = 0;
+
+		return -EBUSY;
 	}
+	return 0;
 }
 
 static void __init pcibios_allocate_resources(int pass)
@@ -1080,8 +1083,12 @@ static void __init pcibios_allocate_reso
 				disabled = !(command & PCI_COMMAND_IO);
 			else
 				disabled = !(command & PCI_COMMAND_MEMORY);
-			if (pass == disabled)
-				alloc_resource(dev, idx);
+			if (pass == disabled && alloc_resource(dev, idx)) {
+				command &= ~(r->flags & (IORESOURCE_IO |
+							 IORESOURCE_MEM));
+				pci_write_config_word(dev,
+						      PCI_COMMAND, command);
+			}
 		}
 		if (pass)
 			continue;
