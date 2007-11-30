Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:10:46 +1100
Subject: [PATCH 7/24] powerpc: Change 32 bits PCI message about resource
	allocation
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
Message-Id: <20071130061149.48E3DDDECC@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 32 bits PCI code will display a rather scary error message

   PCI: Cannot allocate resource region N of device XXX

at boot when the existing setup of a device as left by the
firmware doesn't match the kernel needs and the device needs
to be moved. This is often not an error at all, as the kernel
will generally easily reallocate the device elsewhere.

This changes the message to something less scary and lowers
its level from error to warning.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2007-11-20 17:04:07.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2007-11-21 16:53:53.000000000 +1100
@@ -508,7 +508,7 @@ static inline void alloc_resource(struct
 	    pci_name(dev), idx, (u64)r->start, (u64)r->end, r->flags);
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || request_resource(pr, r) < 0) {
-		printk(KERN_ERR "PCI: Cannot allocate resource region %d"
+		printk(KERN_WARNING "PCI: Remapping resource region %d"
 		       " of device %s\n", idx, pci_name(dev));
 		if (pr)
 			DBG("PCI:  parent is %p: %016llx-%016llx (f=%lx)\n",
