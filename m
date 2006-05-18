Return-Path: <jk@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 18 May 2006 16:32:55 +1000
Subject: [PATCH 1/2] powerpc: Add of_parse_dma_window()
Message-Id: <1147933975.484840.681634501201.qpush@pokey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a function for generic parsing of dma-window properties (ie,
ibm,dma-window and ibm,my-dma-window) of pci and virtual device nodes.

This function will also be used by cell.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

 arch/powerpc/kernel/prom_parse.c |   23 +++++++++++++++++++++++
 include/asm-powerpc/prom.h       |    6 ++++++
 2 files changed, 29 insertions(+)

Index: linux-2.6/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom_parse.c
+++ linux-2.6/arch/powerpc/kernel/prom_parse.c
@@ -548,3 +548,26 @@ int of_pci_address_to_resource(struct de
 	return __of_address_to_resource(dev, addrp, size, flags, r);
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
+
+void of_parse_dma_window(struct device_node *dn, unsigned char *dma_window_prop,
+		unsigned long *busno, unsigned long *phys, unsigned long *size)
+{
+	u32 *dma_window, cells;
+	unsigned char *prop;
+
+	dma_window = (u32 *)dma_window_prop;
+
+	/* busno is always one cell */
+	*busno = *(dma_window++);
+
+	prop = get_property(dn, "ibm,#dma-address-cells", NULL);
+	cells = prop ? *(u32 *)prop : prom_n_addr_cells(dn);
+	*phys = of_read_addr(dma_window, cells);
+
+	dma_window += cells;
+
+	prop = get_property(dn, "ibm,#dma-size-cells", NULL);
+	cells = prop ? *(u32 *)prop : prom_n_size_cells(dn);
+	*size = of_read_addr(dma_window, cells);
+}
+EXPORT_SYMBOL_GPL(of_parse_dma_window);
Index: linux-2.6/include/asm-powerpc/prom.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/prom.h
+++ linux-2.6/include/asm-powerpc/prom.h
@@ -230,6 +230,12 @@ extern int of_address_to_resource(struct
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				      struct resource *r);
 
+/* Parse the ibm,dma-window property of an OF node into the busno, phys and
+ * size parameters.
+ */
+void of_parse_dma_window(struct device_node *dn, unsigned char *dma_window_prop,
+		unsigned long *busno, unsigned long *phys, unsigned long *size);
+
 extern void kdump_move_device_tree(void);
 
 #endif /* __KERNEL__ */
