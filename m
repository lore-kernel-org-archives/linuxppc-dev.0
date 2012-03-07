Return-Path: <bhelgaas@google.com>
Received: from mail-lpp01m010-f73.google.com (mail-lpp01m010-f73.google.com
 [209.85.215.73])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B829CB70B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 09:34:27 +1100 (EST)
Received: by laah2 with SMTP id h2so234035laa.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2012 14:34:23 -0800 (PST)
Subject: [PATCH v3 27/34] powerpc/PCI: get rid of device resource fixups
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 15:34:22 -0700
Message-ID: <20120307223422.25669.72561.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

Previously, powerpc used a HEADER quirk to perform this address fixup
in the following path:

    pci_device_add()
      pci_fixup_device(pci_fixup_header, dev)
        pcibios_fixup_resources()
	  fixup_resource()

This happened for both generic (via pci_scan_child_bus()) and
OF device tree enumeration (via of_scan_bus()).

This patch removes fixup_resource(), so the HEADER quirk no longer does
address fixup.  The generic path now does the fixup in __pci_read_base()
using the offsets supplied with pci_add_resource_offset().  The OF path
now does the fixup with new pcibios_bus_to_resource() calls in
of_pci_parse_addrs() and of_scan_pci_bridge().

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/pci.h    |    9 +---
 arch/powerpc/kernel/pci-common.c  |   83 ++++---------------------------------
 arch/powerpc/kernel/pci_32.c      |    6 +--
 arch/powerpc/kernel/pci_64.c      |    2 -
 arch/powerpc/kernel/pci_of_scan.c |   12 ++++-
 5 files changed, 23 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index f54b3d2..21fbeeb 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -154,13 +154,7 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 
 #endif /* CONFIG_PPC64 */
 
-extern void pcibios_resource_to_bus(struct pci_dev *dev,
-			struct pci_bus_region *region,
-			struct resource *res);
-
-extern void pcibios_bus_to_resource(struct pci_dev *dev,
-			struct resource *res,
-			struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
@@ -190,6 +184,7 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
 
+extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 6d03da4..2efd52d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -846,60 +846,6 @@ int pci_proc_domain(struct pci_bus *bus)
 	return 1;
 }
 
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			     struct resource *res)
-{
-	resource_size_t offset = 0, mask = (resource_size_t)-1;
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	if (!hose)
-		return;
-	if (res->flags & IORESOURCE_IO) {
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		mask = 0xffffffffu;
-	} else if (res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-
-	region->start = (res->start - offset) & mask;
-	region->end = (res->end - offset) & mask;
-}
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			     struct pci_bus_region *region)
-{
-	resource_size_t offset = 0, mask = (resource_size_t)-1;
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	if (!hose)
-		return;
-	if (res->flags & IORESOURCE_IO) {
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		mask = 0xffffffffu;
-	} else if (res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-	res->start = (region->start + offset) & mask;
-	res->end = (region->end + offset) & mask;
-}
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-
-/* Fixup a bus resource into a linux resource */
-static void __devinit fixup_resource(struct resource *res, struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	resource_size_t offset = 0, mask = (resource_size_t)-1;
-
-	if (res->flags & IORESOURCE_IO) {
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		mask = 0xffffffffu;
-	} else if (res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-
-	res->start = (res->start + offset) & mask;
-	res->end = (res->end + offset) & mask;
-}
-
-
 /* This header fixup will do the resource fixup for all devices as they are
  * probed, but not for bridge ranges
  */
@@ -939,18 +885,11 @@ static void __devinit pcibios_fixup_resources(struct pci_dev *dev)
 			continue;
 		}
 
-		pr_debug("PCI:%s Resource %d %016llx-%016llx [%x] fixup...\n",
+		pr_debug("PCI:%s Resource %d %016llx-%016llx [%x]\n",
 			 pci_name(dev), i,
 			 (unsigned long long)res->start,\
 			 (unsigned long long)res->end,
 			 (unsigned int)res->flags);
-
-		fixup_resource(res, dev);
-
-		pr_debug("PCI:%s            %016llx-%016llx\n",
-			 pci_name(dev),
-			 (unsigned long long)res->start,
-			 (unsigned long long)res->end);
 	}
 
 	/* Call machine specific resource fixup */
@@ -1052,27 +991,18 @@ static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
 			continue;
 		}
 
-		pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x] fixup...\n",
+		pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x]\n",
 			 pci_name(dev), i,
 			 (unsigned long long)res->start,\
 			 (unsigned long long)res->end,
 			 (unsigned int)res->flags);
 
-		/* Perform fixup */
-		fixup_resource(res, dev);
-
 		/* Try to detect uninitialized P2P bridge resources,
 		 * and clear them out so they get re-assigned later
 		 */
 		if (pcibios_uninitialized_bridge_resource(bus, res)) {
 			res->flags = 0;
 			pr_debug("PCI:%s            (unassigned)\n", pci_name(dev));
-		} else {
-
-			pr_debug("PCI:%s            %016llx-%016llx\n",
-				 pci_name(dev),
-				 (unsigned long long)res->start,
-				 (unsigned long long)res->end);
 		}
 	}
 }
@@ -1562,6 +1492,11 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
+resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
+{
+	return (unsigned long) hose->io_base_virt - _IO_BASE;
+}
+
 static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, struct list_head *resources)
 {
 	struct resource *res;
@@ -1586,7 +1521,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, s
 		 (unsigned long long)res->start,
 		 (unsigned long long)res->end,
 		 (unsigned long)res->flags);
-	pci_add_resource(resources, res);
+	pci_add_resource_offset(resources, res, pcibios_io_space_offset(hose));
 
 	/* Hookup PHB Memory resources */
 	for (i = 0; i < 3; ++i) {
@@ -1609,7 +1544,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, s
 			 (unsigned long long)res->start,
 			 (unsigned long long)res->end,
 			 (unsigned long)res->flags);
-		pci_add_resource(resources, res);
+		pci_add_resource_offset(resources, res, hose->pci_mem_offset);
 	}
 
 	pr_debug("PCI: PHB MEM offset     = %016llx\n",
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index fdd1a3d..4b06ec5 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -219,9 +219,9 @@ void __devinit pcibios_setup_phb_io_space(struct pci_controller *hose)
 	struct resource *res = &hose->io_resource;
 
 	/* Fixup IO space offset */
-	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
-	res->start = (res->start + io_offset) & 0xffffffffu;
-	res->end = (res->end + io_offset) & 0xffffffffu;
+	io_offset = pcibios_io_space_offset(hose);
+	res->start += io_offset;
+	res->end += io_offset;
 }
 
 static int __init pcibios_init(void)
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 75417fd..94a54f6 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -168,7 +168,7 @@ static int __devinit pcibios_map_phb_io_space(struct pci_controller *hose)
 		return -ENOMEM;
 
 	/* Fixup hose IO resource */
-	io_virt_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+	io_virt_offset = pcibios_io_space_offset(hose);
 	hose->io_resource.start += io_virt_offset;
 	hose->io_resource.end += io_virt_offset;
 
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index b37d0b5..89dde17 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -75,6 +75,7 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 {
 	u64 base, size;
 	unsigned int flags;
+	struct pci_bus_region region;
 	struct resource *res;
 	const u32 *addrs;
 	u32 i;
@@ -106,10 +107,11 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
 			continue;
 		}
-		res->start = base;
-		res->end = base + size - 1;
 		res->flags = flags;
 		res->name = pci_name(dev);
+		region.start = base;
+		region.end = base + size - 1;
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 }
 
@@ -209,6 +211,7 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev)
 	struct pci_bus *bus;
 	const u32 *busrange, *ranges;
 	int len, i, mode;
+	struct pci_bus_region region;
 	struct resource *res;
 	unsigned int flags;
 	u64 size;
@@ -270,9 +273,10 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev)
 			res = bus->resource[i];
 			++i;
 		}
-		res->start = of_read_number(&ranges[1], 2);
-		res->end = res->start + size - 1;
 		res->flags = flags;
+		region.start = of_read_number(&ranges[1], 2);
+		region.end = region.start + size - 1;
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
 		bus->number);
