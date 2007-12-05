Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 05 Dec 2007 11:53:00 +1100
Subject: [RFC/PATCH 1/6] powerpc: pci32: remove bogus alignment message
In-Reply-To: <1196815980.72143.899704305870.qpush@grosgo>
Message-Id: <20071205005410.0007BDDF93@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's a stale & bogus piece of code in 32 bits PCI code that
complains about ISA related alignment issues. Just remove it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_32.c |    6 ------
 1 file changed, 6 deletions(-)

Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2007-12-04 16:59:57.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2007-12-04 16:59:57.000000000 +1100
@@ -199,12 +199,6 @@ void pcibios_align_resource(void *data, 
 	if (res->flags & IORESOURCE_IO) {
 		resource_size_t start = res->start;
 
-		if (size > 0x100) {
-			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
-			       " (%lld bytes)\n", pci_name(dev),
-			       dev->resource - res, (unsigned long long)size);
-		}
-
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
 			res->start = start;
