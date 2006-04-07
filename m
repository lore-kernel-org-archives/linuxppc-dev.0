Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: remove io_page_mask
Date: Fri, 07 Apr 2006 15:23:03 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060407052255.EE79567B40@ozlabs.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Cleanup patch which removes the io_page_mask.  It fixes the reset on
some e1000 devices which is needed for clean kexec reboots.  The legacy
devices which broke with this patch (parallel port and PC speaker) have
now been fixed in Linus' tree.  

Signed-off-by: Anton Blanchard <anton@samba.org>
Ack-by: Michael Neuling <mikey@neuling.org>

---
 arch/powerpc/kernel/iomap.c           |    2 --
 arch/powerpc/kernel/pci_64.c          |   30 +++---------------------------
 arch/powerpc/platforms/iseries/pci.c  |    3 ---
 arch/powerpc/platforms/maple/pci.c    |    3 ---
 arch/powerpc/platforms/powermac/pci.c |    3 ---
 include/asm-powerpc/eeh.h             |   15 +++------------
 include/asm-powerpc/io.h              |    6 ------
 7 files changed, 6 insertions(+), 56 deletions(-)

Index: linux-2.6-powerpc/arch/powerpc/kernel/iomap.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/kernel/iomap.c
+++ linux-2.6-powerpc/arch/powerpc/kernel/iomap.c
@@ -106,8 +106,6 @@ EXPORT_SYMBOL(iowrite32_rep);
 
 void __iomem *ioport_map(unsigned long port, unsigned int len)
 {
-	if (!_IO_IS_VALID(port))
-		return NULL;
 	return (void __iomem *) (port+pci_io_base);
 }
 
Index: linux-2.6-powerpc/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/kernel/pci_64.c
+++ linux-2.6-powerpc/arch/powerpc/kernel/pci_64.c
@@ -42,14 +42,6 @@
 unsigned long pci_probe_only = 1;
 int pci_assign_all_buses = 0;
 
-/*
- * legal IO pages under MAX_ISA_PORT.  This is to ensure we don't touch
- * devices we don't have access to.
- */
-unsigned long io_page_mask;
-
-EXPORT_SYMBOL(io_page_mask);
-
 #ifdef CONFIG_PPC_MULTIPLATFORM
 static void fixup_resource(struct resource *res, struct pci_dev *dev);
 static void do_bus_setup(struct pci_bus *bus);
@@ -1104,8 +1096,6 @@ void __init pci_setup_phb_io(struct pci_
 			pci_process_ISA_OF_ranges(isa_dn, hose->io_base_phys,
 						hose->io_base_virt);
 			of_node_put(isa_dn);
-			/* Allow all IO */
-			io_page_mask = -1;
 		}
 	}
 
@@ -1232,27 +1222,13 @@ static void phbs_remap_io(void)
 static void __devinit fixup_resource(struct resource *res, struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long start, end, mask, offset;
+	unsigned long offset;
 
 	if (res->flags & IORESOURCE_IO) {
 		offset = (unsigned long)hose->io_base_virt - pci_io_base;
 
-		start = res->start += offset;
-		end = res->end += offset;
-
-		/* Need to allow IO access to pages that are in the
-		   ISA range */
-		if (start < MAX_ISA_PORT) {
-			if (end > MAX_ISA_PORT)
-				end = MAX_ISA_PORT;
-
-			start >>= PAGE_SHIFT;
-			end >>= PAGE_SHIFT;
-
-			/* get the range of pages for the map */
-			mask = ((1 << (end+1)) - 1) ^ ((1 << start) - 1);
-			io_page_mask |= mask;
-		}
+		res->start += offset;
+		res->end += offset;
 	} else if (res->flags & IORESOURCE_MEM) {
 		res->start += hose->pci_mem_offset;
 		res->end += hose->pci_mem_offset;
Index: linux-2.6-powerpc/arch/powerpc/platforms/iseries/pci.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/platforms/iseries/pci.c
+++ linux-2.6-powerpc/arch/powerpc/platforms/iseries/pci.c
@@ -45,8 +45,6 @@
 #include "call_pci.h"
 #include "iommu.h"
 
-extern unsigned long io_page_mask;
-
 /*
  * Forward declares of prototypes.
  */
@@ -277,7 +275,6 @@ void iSeries_pcibios_init(void)
 {
 	iomm_table_initialize();
 	find_and_init_phbs();
-	io_page_mask = -1;
 }
 
 /*
Index: linux-2.6-powerpc/arch/powerpc/platforms/maple/pci.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/platforms/maple/pci.c
+++ linux-2.6-powerpc/arch/powerpc/platforms/maple/pci.c
@@ -437,9 +437,6 @@ void __init maple_pci_init(void)
 
 	/* Tell pci.c to not change any resource allocations.  */
 	pci_probe_only = 1;
-	
-	/* Allow all IO */
-	io_page_mask = -1;
 }
 
 int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
Index: linux-2.6-powerpc/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/platforms/powermac/pci.c
+++ linux-2.6-powerpc/arch/powerpc/platforms/powermac/pci.c
@@ -1068,9 +1068,6 @@ void __init pmac_pci_init(void)
 	/* Tell pci.c to not use the common resource allocation mechanism */
 	pci_probe_only = 1;
 
-	/* Allow all IO */
-	io_page_mask = -1;
-
 #else /* CONFIG_PPC64 */
 	init_p2pbridge();
 	fixup_nec_usb2();
Index: linux-2.6-powerpc/include/asm-powerpc/eeh.h
===================================================================
--- linux-2.6-powerpc.orig/include/asm-powerpc/eeh.h
+++ linux-2.6-powerpc/include/asm-powerpc/eeh.h
@@ -293,8 +293,6 @@ static inline void eeh_memcpy_toio(volat
 static inline u8 eeh_inb(unsigned long port)
 {
 	u8 val;
-	if (!_IO_IS_VALID(port))
-		return ~0;
 	val = in_8((u8 __iomem *)(port+pci_io_base));
 	if (EEH_POSSIBLE_ERROR(val, u8))
 		return eeh_check_failure((void __iomem *)(port), val);
@@ -303,15 +301,12 @@ static inline u8 eeh_inb(unsigned long p
 
 static inline void eeh_outb(u8 val, unsigned long port)
 {
-	if (_IO_IS_VALID(port))
-		out_8((u8 __iomem *)(port+pci_io_base), val);
+	out_8((u8 __iomem *)(port+pci_io_base), val);
 }
 
 static inline u16 eeh_inw(unsigned long port)
 {
 	u16 val;
-	if (!_IO_IS_VALID(port))
-		return ~0;
 	val = in_le16((u16 __iomem *)(port+pci_io_base));
 	if (EEH_POSSIBLE_ERROR(val, u16))
 		return eeh_check_failure((void __iomem *)(port), val);
@@ -320,15 +315,12 @@ static inline u16 eeh_inw(unsigned long 
 
 static inline void eeh_outw(u16 val, unsigned long port)
 {
-	if (_IO_IS_VALID(port))
-		out_le16((u16 __iomem *)(port+pci_io_base), val);
+	out_le16((u16 __iomem *)(port+pci_io_base), val);
 }
 
 static inline u32 eeh_inl(unsigned long port)
 {
 	u32 val;
-	if (!_IO_IS_VALID(port))
-		return ~0;
 	val = in_le32((u32 __iomem *)(port+pci_io_base));
 	if (EEH_POSSIBLE_ERROR(val, u32))
 		return eeh_check_failure((void __iomem *)(port), val);
@@ -337,8 +329,7 @@ static inline u32 eeh_inl(unsigned long 
 
 static inline void eeh_outl(u32 val, unsigned long port)
 {
-	if (_IO_IS_VALID(port))
-		out_le32((u32 __iomem *)(port+pci_io_base), val);
+	out_le32((u32 __iomem *)(port+pci_io_base), val);
 }
 
 /* in-string eeh macros */
Index: linux-2.6-powerpc/include/asm-powerpc/io.h
===================================================================
--- linux-2.6-powerpc.orig/include/asm-powerpc/io.h
+++ linux-2.6-powerpc/include/asm-powerpc/io.h
@@ -37,12 +37,6 @@
 
 extern unsigned long isa_io_base;
 extern unsigned long pci_io_base;
-extern unsigned long io_page_mask;
-
-#define MAX_ISA_PORT 0x10000
-
-#define _IO_IS_VALID(port) ((port) >= MAX_ISA_PORT || (1 << (port>>PAGE_SHIFT)) \
-			    & io_page_mask)
 
 #ifdef CONFIG_PPC_ISERIES
 /* __raw_* accessors aren't supported on iSeries */

This is a 
