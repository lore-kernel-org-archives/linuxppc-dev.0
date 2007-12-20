Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:55:00 +1100
Subject: [PATCH 15/19] [POWERPC] Various fixes to pcibios_enable_device()
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035502.B4A1BDDF0A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Our implementation of pcibios_enable_device() has a couple of problems.

One is that it should not check IORESOURCE_UNSET, as this might be
left dangling after resource assignment (shouldn't but there are
bugs), but instead, we make it check resource->parent which should
be a reliable indication that the resource has been successfully
claimed (it's in the resource tree).

Then, we also need to skip ROM resources that haven't been enabled
as x86 does.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-merge.orig/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:34.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:36.000000000 +1100
@@ -1147,7 +1147,10 @@ int pcibios_enable_device(struct pci_dev
 		r = &dev->resource[idx];
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
-		if (r->flags & IORESOURCE_UNSET) {
+		if ((idx == PCI_ROM_RESOURCE) &&
+				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+			continue;
+		if (r->parent == NULL) {
 			printk(KERN_ERR "PCI: Device %s not available because"
 			       " of resource collisions\n", pci_name(dev));
 			return -EINVAL;
