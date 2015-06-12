Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A03091A06DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 12:27:00 +1000 (AEST)
Received: by ykfl8 with SMTP id l8so11102396ykf.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 19:26:57 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: pci: use %pR for printing struct resource
Date: Fri, 12 Jun 2015 10:26:37 +0800
Message-Id: <1434075997-23216-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use %pR to simplify the debug code. This also make the debug info more
readable.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/pci-common.c | 72 +++++++++++-----------------------------
 1 file changed, 19 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b9de34d44fcb..d44f37854eb1 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -823,23 +823,16 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 		    (reg.start == 0 && !pci_has_flag(PCI_PROBE_ONLY))) {
 			/* Only print message if not re-assigning */
 			if (!pci_has_flag(PCI_REASSIGN_ALL_RSRC))
-				pr_debug("PCI:%s Resource %d %016llx-%016llx [%x] "
+				pr_debug("PCI:%s Resource %d %pR "
 					 "is unassigned\n",
-					 pci_name(dev), i,
-					 (unsigned long long)res->start,
-					 (unsigned long long)res->end,
-					 (unsigned int)res->flags);
+					 pci_name(dev), i, res);
 			res->end -= res->start;
 			res->start = 0;
 			res->flags |= IORESOURCE_UNSET;
 			continue;
 		}
 
-		pr_debug("PCI:%s Resource %d %016llx-%016llx [%x]\n",
-			 pci_name(dev), i,
-			 (unsigned long long)res->start,\
-			 (unsigned long long)res->end,
-			 (unsigned int)res->flags);
+		pr_debug("PCI:%s Resource %d %pR\n", pci_name(dev), i, res);
 	}
 
 	/* Call machine specific resource fixup */
@@ -943,11 +936,7 @@ static void pcibios_fixup_bridge(struct pci_bus *bus)
 			continue;
 		}
 
-		pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x]\n",
-			 pci_name(dev), i,
-			 (unsigned long long)res->start,\
-			 (unsigned long long)res->end,
-			 (unsigned int)res->flags);
+		pr_debug("PCI:%s Bus rsrc %d %pR\n", pci_name(dev), i, res);
 
 		/* Try to detect uninitialized P2P bridge resources,
 		 * and clear them out so they get re-assigned later
@@ -1132,10 +1121,8 @@ static int reparent_resources(struct resource *parent,
 	*pp = NULL;
 	for (p = res->child; p != NULL; p = p->sibling) {
 		p->parent = res;
-		pr_debug("PCI: Reparented %s [%llx..%llx] under %s\n",
-			 p->name,
-			 (unsigned long long)p->start,
-			 (unsigned long long)p->end, res->name);
+		pr_debug("PCI: Reparented %s %pR under %s\n",
+			 p->name, p, res->name);
 	}
 	return 0;
 }
@@ -1204,14 +1191,10 @@ static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 			}
 		}
 
-		pr_debug("PCI: %s (bus %d) bridge rsrc %d: %016llx-%016llx "
-			 "[0x%x], parent %p (%s)\n",
-			 bus->self ? pci_name(bus->self) : "PHB",
-			 bus->number, i,
-			 (unsigned long long)res->start,
-			 (unsigned long long)res->end,
-			 (unsigned int)res->flags,
-			 pr, (pr && pr->name) ? pr->name : "nil");
+		pr_debug("PCI: %s (bus %d) bridge rsrc %d: %pR, parent %p "
+			 "(%s)\n", bus->self ? pci_name(bus->self) : "PHB",
+			 bus->number, i, res, pr,
+			 (pr && pr->name) ? pr->name : "nil");
 
 		if (pr && !(pr->flags & IORESOURCE_UNSET)) {
 			struct pci_dev *dev = bus->self;
@@ -1253,11 +1236,8 @@ static inline void alloc_resource(struct pci_dev *dev, int idx)
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
-	pr_debug("PCI: Allocating %s: Resource %d: %016llx..%016llx [%x]\n",
-		 pci_name(dev), idx,
-		 (unsigned long long)r->start,
-		 (unsigned long long)r->end,
-		 (unsigned int)r->flags);
+	pr_debug("PCI: Allocating %s: Resource %d: %pR\n",
+		 pci_name(dev), idx, r);
 
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || (pr->flags & IORESOURCE_UNSET) ||
@@ -1265,11 +1245,7 @@ static inline void alloc_resource(struct pci_dev *dev, int idx)
 		printk(KERN_WARNING "PCI: Cannot allocate resource region %d"
 		       " of device %s, will remap\n", idx, pci_name(dev));
 		if (pr)
-			pr_debug("PCI:  parent is %p: %016llx-%016llx [%x]\n",
-				 pr,
-				 (unsigned long long)pr->start,
-				 (unsigned long long)pr->end,
-				 (unsigned int)pr->flags);
+			pr_debug("PCI:  parent is %p: %pR\n", pr, pr);
 		/* We'll assign a new address later */
 		r->flags |= IORESOURCE_UNSET;
 		r->end -= r->start;
@@ -1431,12 +1407,8 @@ void pcibios_claim_one_bus(struct pci_bus *bus)
 			if (r->parent || !r->start || !r->flags)
 				continue;
 
-			pr_debug("PCI: Claiming %s: "
-				 "Resource %d: %016llx..%016llx [%x]\n",
-				 pci_name(dev), i,
-				 (unsigned long long)r->start,
-				 (unsigned long long)r->end,
-				 (unsigned int)r->flags);
+			pr_debug("PCI: Claiming %s: Resource %d: %pR\n",
+				 pci_name(dev), i, r);
 
 			if (pci_claim_resource(dev, i) == 0)
 				continue;
@@ -1520,11 +1492,8 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 	} else {
 		offset = pcibios_io_space_offset(hose);
 
-		pr_debug("PCI: PHB IO resource    = %08llx-%08llx [%lx] off 0x%08llx\n",
-			 (unsigned long long)res->start,
-			 (unsigned long long)res->end,
-			 (unsigned long)res->flags,
-			 (unsigned long long)offset);
+		pr_debug("PCI: PHB IO resource    = %pR off 0x%08llx\n",
+			 res, (unsigned long long)offset);
 		pci_add_resource_offset(resources, res, offset);
 	}
 
@@ -1541,11 +1510,8 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 		offset = hose->mem_offset[i];
 
 
-		pr_debug("PCI: PHB MEM resource %d = %08llx-%08llx [%lx] off 0x%08llx\n", i,
-			 (unsigned long long)res->start,
-			 (unsigned long long)res->end,
-			 (unsigned long)res->flags,
-			 (unsigned long long)offset);
+		pr_debug("PCI: PHB MEM resource %d = %pR off 0x%08llx\n", i,
+			 res, (unsigned long long)offset);
 
 		pci_add_resource_offset(resources, res, offset);
 	}
-- 
2.1.0
