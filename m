Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBgcW54L8zDqGH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 18:14:19 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc: Move isa bridge definitions to separate include
Date: Mon, 30 Jan 2017 18:11:55 +1100
Message-Id: <20170130071157.22677-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We'll be adding non-PCI isa bridge support so let's not
have all the definition in pci-bridge.h

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/isa-bridge.h     | 28 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/pci-bridge.h     | 18 ------------------
 arch/powerpc/kernel/iomap.c               |  1 +
 arch/powerpc/kernel/isa-bridge.c          |  1 +
 arch/powerpc/platforms/maple/pci.c        |  1 +
 arch/powerpc/platforms/powernv/opal-lpc.c |  1 +
 arch/powerpc/platforms/pseries/setup.c    |  1 +
 7 files changed, 33 insertions(+), 18 deletions(-)
 create mode 100644 arch/powerpc/include/asm/isa-bridge.h

diff --git a/arch/powerpc/include/asm/isa-bridge.h b/arch/powerpc/include/asm/isa-bridge.h
new file mode 100644
index 0000000..94d9c1c
--- /dev/null
+++ b/arch/powerpc/include/asm/isa-bridge.h
@@ -0,0 +1,28 @@
+#ifndef __ISA_BRIDGE_H
+#define __ISA_BRIDGE_H
+
+#ifdef CONFIG_PPC64
+
+extern void isa_bridge_find_early(struct pci_controller *hose);
+
+static inline int isa_vaddr_is_ioport(void __iomem *address)
+{
+	/* Check if address hits the reserved legacy IO range */
+	unsigned long ea = (unsigned long)address;
+	return ea >= ISA_IO_BASE && ea < ISA_IO_END;
+}
+
+#else
+
+static inline int isa_vaddr_is_ioport(void __iomem *address)
+{
+	/* No specific ISA handling on ppc32 at this stage, it
+	 * all goes through PCI
+	 */
+	return 0;
+}
+
+#endif
+
+#endif /* __ISA_BRIDGE_H */
+
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index c0309c5..56c67d3 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -174,14 +174,6 @@ extern int pci_device_from_OF_node(struct device_node *node,
 				   u8 *bus, u8 *devfn);
 extern void pci_create_OF_bus_map(void);
 
-static inline int isa_vaddr_is_ioport(void __iomem *address)
-{
-	/* No specific ISA handling on ppc32 at this stage, it
-	 * all goes through PCI
-	 */
-	return 0;
-}
-
 #else	/* CONFIG_PPC64 */
 
 /*
@@ -269,16 +261,6 @@ extern void pci_hp_remove_devices(struct pci_bus *bus);
 /** Discover new pci devices under this bus, and add them */
 extern void pci_hp_add_devices(struct pci_bus *bus);
 
-
-extern void isa_bridge_find_early(struct pci_controller *hose);
-
-static inline int isa_vaddr_is_ioport(void __iomem *address)
-{
-	/* Check if address hits the reserved legacy IO range */
-	unsigned long ea = (unsigned long)address;
-	return ea >= ISA_IO_BASE && ea < ISA_IO_END;
-}
-
 extern int pcibios_unmap_io_space(struct pci_bus *bus);
 extern int pcibios_map_io_space(struct pci_bus *bus);
 
diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 3963f0b..a1854d1 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <asm/io.h>
 #include <asm/pci-bridge.h>
+#include <asm/isa-bridge.h>
 
 /*
  * Here comes the ppc64 implementation of the IOMAP 
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index ae13161..c898ff0 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -29,6 +29,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
+#include <asm/isa-bridge.h>
 
 unsigned long isa_io_base;	/* NULL if no ISA bus */
 EXPORT_SYMBOL(isa_io_base);
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index a0589aa..69794d9 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -24,6 +24,7 @@
 #include <asm/machdep.h>
 #include <asm/iommu.h>
 #include <asm/ppc-pci.h>
+#include <asm/isa-bridge.h>
 
 #include "maple.h"
 
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index 4886eb8..2048ce7 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -23,6 +23,7 @@
 #include <asm/prom.h>
 #include <linux/uaccess.h>
 #include <asm/debug.h>
+#include <asm/isa-bridge.h>
 
 static int opal_lpc_chip_id = -1;
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 7736352..b4d362e 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -66,6 +66,7 @@
 #include <asm/reg.h>
 #include <asm/plpar_wrappers.h>
 #include <asm/kexec.h>
+#include <asm/isa-bridge.h>
 
 #include "pseries.h"
 
-- 
2.9.3
