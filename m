Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 3/20] [powerpc] Remove linux,pci-domain properties
Message-ID: 1151993427.2210.04@pokey
Date: Tue,  4 Jul 2006 16:47:18 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The linux,pci-domain property is no longer used by DLPAR/PCI Hotplug
utilites, or LSVPD. This change removes it.

Built for ppc64_defconfig.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 pci_64.c |   39 +--------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci_64.c
+++ linux-2.6/arch/powerpc/kernel/pci_64.c
@@ -185,34 +185,6 @@ static void __devinit pci_setup_pci_cont
 	spin_unlock(&hose_spinlock);
 }
 
-static void add_linux_pci_domain(struct device_node *dev,
-				 struct pci_controller *phb)
-{
-	struct property *of_prop;
-	unsigned int size;
-
-	of_prop = (struct property *)
-		get_property(dev, "linux,pci-domain", &size);
-	if (of_prop != NULL)
-		return;
-	WARN_ON(of_prop && size < sizeof(int));
-	if (of_prop && size < sizeof(int))
-		of_prop = NULL;
-	size = sizeof(struct property) + sizeof(int);
-	if (of_prop == NULL) {
-		if (mem_init_done)
-			of_prop = kmalloc(size, GFP_KERNEL);
-		else
-			of_prop = alloc_bootmem(size);
-	}
-	memset(of_prop, 0, sizeof(struct property));
-	of_prop->name = "linux,pci-domain";
-	of_prop->length = sizeof(int);
-	of_prop->value = (unsigned char *)&of_prop[1];
-	*((int *)of_prop->value) = phb->global_number;
-	prom_add_property(dev, of_prop);
-}
-
 struct pci_controller * pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *phb;
@@ -226,22 +198,13 @@ struct pci_controller * pcibios_alloc_co
 	pci_setup_pci_controller(phb);
 	phb->arch_data = dev;
 	phb->is_dynamic = mem_init_done;
-	if (dev) {
+	if (dev)
 		PHB_SET_NODE(phb, of_node_to_nid(dev));
-		add_linux_pci_domain(dev, phb);
-	}
 	return phb;
 }
 
 void pcibios_free_controller(struct pci_controller *phb)
 {
-	if (phb->arch_data) {
-		struct device_node *np = phb->arch_data;
-		int *domain = (int *)get_property(np,
-						  "linux,pci-domain", NULL);
-		if (domain)
-			*domain = -1;
-	}
 	if (phb->is_dynamic)
 		kfree(phb);
 }
