Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2EB4C2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 May 2013 10:23:04 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r450MwrC009734
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 19:23:00 -0500
Message-ID: <1367713377.11982.24.camel@pasglop>
Subject: [PATCH] powerpc/pci: Don't add bogus empty resources to PHBs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Sun, 05 May 2013 10:22:57 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When converting to use the new pci_add_resource_offset() we didn't
properly account for empty resources (0 flags) and add those bogons
to the PHBs. The result is some annoying messages in the log.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

BTW. Anybody knows if we really need those ppc32 workarounds anymore ?

They smell like ancient pre-device-tree crap... if a bridge is missing
a window in its "ranges" property it should probably not have it exposed
to the generic code nowadays.
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f325dc9..5775ea9 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1532,12 +1532,16 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 		res->flags = IORESOURCE_IO;
 #endif /* CONFIG_PPC32 */
 	}
+	if (res->flags) {
+		pr_debug("PCI: PHB IO resource    = %016llx-%016llx [%lx]\n",
+			 (unsigned long long)res->start,
+			 (unsigned long long)res->end,
+			 (unsigned long)res->flags);
+		pci_add_resource_offset(resources, res, pcibios_io_space_offset(hose));
 
-	pr_debug("PCI: PHB IO resource    = %016llx-%016llx [%lx]\n",
-		 (unsigned long long)res->start,
-		 (unsigned long long)res->end,
-		 (unsigned long)res->flags);
-	pci_add_resource_offset(resources, res, pcibios_io_space_offset(hose));
+		pr_debug("PCI: PHB IO  offset     = %08lx\n",
+			 (unsigned long)hose->io_base_virt - _IO_BASE);
+	}
 
 	/* Hookup PHB Memory resources */
 	for (i = 0; i < 3; ++i) {
@@ -1555,19 +1559,17 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 			res->flags = IORESOURCE_MEM;
 #endif /* CONFIG_PPC32 */
 		}
-
-		pr_debug("PCI: PHB MEM resource %d = %016llx-%016llx [%lx]\n", i,
-			 (unsigned long long)res->start,
-			 (unsigned long long)res->end,
-			 (unsigned long)res->flags);
-		pci_add_resource_offset(resources, res, hose->pci_mem_offset);
+		if (res->flags) {
+			pr_debug("PCI: PHB MEM resource %d = %016llx-%016llx [%lx]\n", i,
+				 (unsigned long long)res->start,
+				 (unsigned long long)res->end,
+				 (unsigned long)res->flags);
+			pci_add_resource_offset(resources, res, hose->pci_mem_offset);
+		}
 	}
 
 	pr_debug("PCI: PHB MEM offset     = %016llx\n",
 		 (unsigned long long)hose->pci_mem_offset);
-	pr_debug("PCI: PHB IO  offset     = %08lx\n",
-		 (unsigned long)hose->io_base_virt - _IO_BASE);
-
 }
 
 /*
