Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 30D6ADDFBA
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 05:42:44 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix pci_setup_phb_io_dynamic for pci_iomap
Date: Thu, 3 May 2007 21:42:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200705032142.39031.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We had a problem on a system with only dynamically allocated
PCI buses (using of_pci_phb_driver) in combination with libata.

It turns out that pci_setup_phb_io_dynamic does a simple ioremap
instead of an __ioremap_explicit into the reserved I/O space
region, which causes pcim_iomap->pci_iomap->ioport_map to fail
a sanity check for the virtual address of the I/O port.

Also, our setup ended up having no "primary" phb, which means
that pci_io_base never got initialized. This caused the same
bug independently.

This patch fixes both problems.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---

 arch/powerpc/kernel/of_platform.c |    4 ++--
 arch/powerpc/kernel/pci_64.c      |    6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.21.ppc64/arch/powerpc/kernel/of_platform.c
===================================================================
--- linux-2.6.21.ppc64.orig/arch/powerpc/kernel/of_platform.c
+++ linux-2.6.21.ppc64/arch/powerpc/kernel/of_platform.c
@@ -426,13 +426,13 @@ static int __devinit of_pci_phb_probe(st
 	}
 
 	/* Process "ranges" property */
-	pci_process_bridge_OF_ranges(phb, dev->node, 0);
+	pci_process_bridge_OF_ranges(phb, dev->node, pci_io_base == 0);
 
 	/* Setup IO space.
 	 * This will not work properly for ISA IOs, something needs to be done
 	 * about it if we ever generalize that way of probing PCI brigdes
 	 */
-	pci_setup_phb_io_dynamic(phb, 0);
+	pci_setup_phb_io_dynamic(phb, pci_io_base == 0);
 
 	/* Init pci_dn data structures */
 	pci_devs_phb_init_dynamic(phb);
Index: linux-2.6.21.ppc64/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-2.6.21.ppc64.orig/arch/powerpc/kernel/pci_64.c
+++ linux-2.6.21.ppc64/arch/powerpc/kernel/pci_64.c
@@ -1077,8 +1077,7 @@ void __devinit pci_setup_phb_io_dynamic(
 	unsigned long io_virt_offset;
 	struct resource *res;
 
-	hose->io_base_virt = __ioremap(hose->io_base_phys, size,
-					_PAGE_NO_CACHE | _PAGE_GUARDED);
+	hose->io_base_virt = reserve_phb_iospace(size);
 	DBG("phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n",
 		hose->global_number, hose->io_base_phys,
 		(unsigned long) hose->io_base_virt);
@@ -1090,6 +1089,9 @@ void __devinit pci_setup_phb_io_dynamic(
 	res = &hose->io_resource;
 	res->start += io_virt_offset;
 	res->end += io_virt_offset;
+
+	__ioremap_explicit(hose->io_base_phys, (unsigned long)hose->io_base_virt, size,
+			_PAGE_NO_CACHE | _PAGE_GUARDED);
 }
 
 
