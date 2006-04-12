Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:26:59 -0500
To: paulus@ozlabs.org
Subject: [8/10]: Quiet PCI init printouts
Message-ID: <20060412202659.GO19464@pb15.lixom.net>
References: <20060412201823.GG19464@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412201823.GG19464@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quiet some of the more debug related output from the pci probe routines.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/arch/powerpc/kernel/pci_64.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/pci_64.c
+++ 2.6/arch/powerpc/kernel/pci_64.c
@@ -605,7 +605,7 @@ static int __init pcibios_init(void)
 	iSeries_pcibios_init(); 
 #endif
 
-	printk("PCI: Probing PCI hardware\n");
+	printk(KERN_DEBUG "PCI: Probing PCI hardware\n");
 
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
@@ -630,14 +630,14 @@ static int __init pcibios_init(void)
 	/* Cache the location of the ISA bridge (if we have one) */
 	ppc64_isabridge_dev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
 	if (ppc64_isabridge_dev != NULL)
-		printk("ISA bridge at %s\n", pci_name(ppc64_isabridge_dev));
+		printk(KERN_DEBUG "ISA bridge at %s\n", pci_name(ppc64_isabridge_dev));
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
 	/* map in PCI I/O space */
 	phbs_remap_io();
 #endif
 
-	printk("PCI: Probing PCI hardware done\n");
+	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
 
 	return 0;
 }
@@ -804,7 +804,7 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	else
 		prot |= _PAGE_GUARDED;
 
-	printk("PCI map for %s:%lx, prot: %lx\n", pci_name(dev), rp->start,
+	printk(KERN_DEBUG "PCI map for %s:%lx, prot: %lx\n", pci_name(dev), rp->start,
 	       prot);
 
 	return __pgprot(prot);
@@ -1212,7 +1212,7 @@ int remap_bus_range(struct pci_bus *bus)
 		return 1;
 	if (start_phys == 0)
 		return 1;
-	printk("mapping IO %lx -> %lx, size: %lx\n", start_phys, start_virt, size);
+	printk(KERN_DEBUG "mapping IO %lx -> %lx, size: %lx\n", start_phys, start_virt, size);
 	if (__ioremap_explicit(start_phys, start_virt, size,
 			       _PAGE_NO_CACHE | _PAGE_GUARDED))
 		return 1;
