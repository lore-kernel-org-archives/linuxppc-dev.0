Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8776DDFC2
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 04:19:27 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] [POWERPC] Use global_number in ppc32 pci_controller
Date: Wed, 27 Jun 2007 13:19:14 -0500
Message-Id: <11829683663762-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829683631074-git-send-email-galak@kernel.crashing.org>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
	<11829683604166-git-send-email-galak@kernel.crashing.org>
	<11829683612573-git-send-email-galak@kernel.crashing.org>
	<11829683631074-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the pci_controller struct use global_number for the PHB domain number
instead of index to match what ppc64 does and reuse its pci_domain_nr code.

Introduced a pci-common.c to handle shared code between ppc32 & ppc64.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/Makefile        |    2 +-
 arch/powerpc/kernel/pci-common.c    |   53 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c        |    6 ++--
 arch/powerpc/kernel/pci_64.c        |   16 ----------
 arch/powerpc/platforms/52xx/efika.c |    4 +-
 arch/powerpc/platforms/chrp/pci.c   |    4 +-
 include/asm-powerpc/pci-bridge.h    |    2 +-
 include/asm-powerpc/pci.h           |    7 +---
 8 files changed, 64 insertions(+), 30 deletions(-)
 create mode 100644 arch/powerpc/kernel/pci-common.c

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index eb6a33e..42c42ec 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_MODULES)		+= $(module-y)
 
 pci64-$(CONFIG_PPC64)		+= pci_64.o pci_dn.o isa-bridge.o
 pci32-$(CONFIG_PPC32)		:= pci_32.o
-obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
+obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y) pci-common.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
 kexec-$(CONFIG_PPC32)		:= machine_kexec_32.o
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
new file mode 100644
index 0000000..3ca8cfb
--- /dev/null
+++ b/arch/powerpc/kernel/pci-common.c
@@ -0,0 +1,53 @@
+/*
+ * Contains common pci routines for ALL ppc platform
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <linux/list.h>
+#include <linux/syscalls.h>
+#include <linux/irq.h>
+#include <linux/vmalloc.h>
+
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/byteorder.h>
+#include <asm/machdep.h>
+#include <asm/ppc-pci.h>
+#include <asm/firmware.h>
+
+#ifdef DEBUG
+#include <asm/udbg.h>
+#define DBG(fmt...) printk(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+/*
+ * Return the domain number for this bus.
+ */
+int pci_domain_nr(struct pci_bus *bus)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+	else {
+		struct pci_controller *hose = pci_bus_to_host(bus);
+
+		return hose->global_number;
+	}
+}
+
+EXPORT_SYMBOL(pci_domain_nr);
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 2d4a1c4..56deb31 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -620,7 +620,7 @@ pcibios_alloc_controller(void)
 	*hose_tail = hose;
 	hose_tail = &hose->next;
 
-	hose->index = next_controller_index++;
+	hose->global_number = next_controller_index++;
 
 	return hose;
 }
@@ -1336,7 +1336,7 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
 		if (!res->flags) {
 			if (io_offset)
 				printk(KERN_ERR "I/O resource not set for host"
-				       " bridge %d\n", hose->index);
+				       " bridge %d\n", hose->global_number);
 			res->start = 0;
 			res->end = IO_SPACE_LIMIT;
 			res->flags = IORESOURCE_IO;
@@ -1350,7 +1350,7 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
 				if (i > 0)
 					continue;
 				printk(KERN_ERR "Memory resource not set for "
-				       "host bridge %d\n", hose->index);
+				       "host bridge %d\n", hose->global_number);
 				res->start = hose->pci_mem_offset;
 				res->end = ~0U;
 				res->flags = IORESOURCE_MEM;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 6ae67eb..23494fe 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -636,22 +636,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-/*
- * Return the domain number for this bus.
- */
-int pci_domain_nr(struct pci_bus *bus)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		return 0;
-	else {
-		struct pci_controller *hose = pci_bus_to_host(bus);
-
-		return hose->global_number;
-	}
-}
-
-EXPORT_SYMBOL(pci_domain_nr);
-
 /* Decide whether to display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
 {
diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 4cb4419..010be5c 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -54,7 +54,7 @@ static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
 	    | (((bus->number - hose->first_busno) & 0xff) << 16)
-	    | (hose->index << 24);
+	    | (hose->global_number << 24);
 	int ret = -1;
 	int rval;
 
@@ -69,7 +69,7 @@ static int rtas_write_config(struct pci_bus *bus, unsigned int devfn,
 	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
 	    | (((bus->number - hose->first_busno) & 0xff) << 16)
-	    | (hose->index << 24);
+	    | (hose->global_number << 24);
 	int rval;
 
 	rval = rtas_call(rtas_token("write-pci-config"), 3, 1, NULL,
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index d32fedc..d840863 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -99,7 +99,7 @@ int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
 		| (((bus->number - hose->first_busno) & 0xff) << 16)
-		| (hose->index << 24);
+		| (hose->global_number << 24);
         int ret = -1;
 	int rval;
 
@@ -114,7 +114,7 @@ int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
 		| (((bus->number - hose->first_busno) & 0xff) << 16)
-		| (hose->index << 24);
+		| (hose->global_number << 24);
 	int rval;
 
 	rval = rtas_call(rtas_token("write-pci-config"), 3, 1, NULL,
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index e2b2b6b..80cfb4a 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -21,7 +21,6 @@ extern struct pci_controller* pci_bus_to_hose(int bus);
 struct pci_controller {
 	struct pci_bus *bus;
 	void *arch_data;
-	int index;			/* PCI domain number */
 	struct pci_controller *next;
 	struct device *parent;
 
@@ -60,6 +59,7 @@ struct pci_controller {
 	 */
 	struct resource	io_resource;
 	struct resource mem_resources[3];
+	int global_number;		/* PCI domain number */
 };
 
 static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
index 93e3752..0cd3e77 100644
--- a/include/asm-powerpc/pci.h
+++ b/include/asm-powerpc/pci.h
@@ -107,8 +107,6 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 #define get_pci_dma_ops()	NULL
 #endif
 
-extern int pci_domain_nr(struct pci_bus *bus);
-
 /* Decide whether to display the domain number in /proc */
 extern int pci_proc_domain(struct pci_bus *bus);
 
@@ -130,9 +128,6 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
  */
 #define pci_dac_dma_supported(pci_dev, mask)	(0)
 
-/* Return the index of the PCI controller for device PDEV. */
-#define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
-
 /* Set the name of the bus as it appears in /proc/bus/pci */
 static inline int pci_proc_domain(struct pci_bus *bus)
 {
@@ -141,6 +136,8 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 
 #endif /* CONFIG_PPC64 */
 
+extern int pci_domain_nr(struct pci_bus *bus);
+
 struct vm_area_struct;
 /* Map a range of PCI memory or I/O space for a device into user space */
 int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-- 
1.5.2.1
