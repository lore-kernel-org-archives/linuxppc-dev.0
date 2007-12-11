Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A0765DDE27
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:06:24 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 350FB368002
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:06:22 +1100 (EST)
Date: Tue, 11 Dec 2007 11:00:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 02/19] [POWERPC] consolidate pci_controller
Message-Id: <20071211110013.0212a1a5.sfr@canb.auug.org.au>
In-Reply-To: <20071206180608.de14e9b1.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071206180608.de14e9b1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/pci-bridge.h |   65 +++++++++++++-------------------------
 1 files changed, 22 insertions(+), 43 deletions(-)

diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index e021314..f67d262 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -11,33 +11,44 @@
 #include <linux/list.h>
 #include <linux/ioport.h>
 
-#ifndef CONFIG_PPC64
 /*
  * Structure of a PCI controller (host bridge)
  */
 struct pci_controller {
 	struct pci_bus *bus;
 	char is_dynamic;
+#ifdef CONFIG_PPC64
+	int node;
+#endif
 	void *arch_data;
 	struct list_head list_node;
 	struct device *parent;
 
 	int first_busno;
 	int last_busno;
+#ifndef CONFIG_PPC64
 	int self_busno;
+#endif
 
 	void __iomem *io_base_virt;
+#ifdef CONFIG_PPC64
+	void *io_base_alloc;
+#endif
 	resource_size_t io_base_phys;
 
 	/* Some machines (PReP) have a non 1:1 mapping of
 	 * the PCI memory space in the CPU bus space
 	 */
 	resource_size_t pci_mem_offset;
+#ifdef CONFIG_PPC64
+	unsigned long pci_io_size;
+#endif
 
 	struct pci_ops *ops;
 	volatile unsigned int __iomem *cfg_addr;
 	volatile void __iomem *cfg_data;
 
+#ifndef CONFIG_PPC64
 	/*
 	 * Used for variants of PCI indirect handling and possible quirks:
 	 *  SET_CFG_TYPE - used on 4xx or any PHB that does explicit type0/1
@@ -58,15 +69,24 @@ struct pci_controller {
 #define PPC_INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
 #define PPC_INDIRECT_TYPE_BIG_ENDIAN		0x00000010
 	u32 indirect_type;
-
+#endif	/* !CONFIG_PPC64 */
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
 	 * ranges since the common pci_bus structure can't handle more
 	 */
 	struct resource	io_resource;
 	struct resource mem_resources[3];
 	int global_number;		/* PCI domain number */
+#ifdef CONFIG_PPC64
+	unsigned long buid;
+	unsigned long dma_window_base_cur;
+	unsigned long dma_window_size;
+
+	void *private_data;
+#endif	/* CONFIG_PPC64 */
 };
 
+#ifndef CONFIG_PPC64
+
 static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
 {
 	return bus->sysdata;
@@ -108,47 +128,6 @@ extern void __init update_bridge_resource(struct pci_dev *dev,
 #else	/* CONFIG_PPC64 */
 
 /*
- * Structure of a PCI controller (host bridge)
- */
-struct pci_controller {
-	struct pci_bus *bus;
-	char is_dynamic;
-	int node;
-	void *arch_data;
-	struct list_head list_node;
-	struct device *parent;
-
-	int first_busno;
-	int last_busno;
-
-	void __iomem *io_base_virt;
-	void *io_base_alloc;
-	resource_size_t io_base_phys;
-
-	/* Some machines have a non 1:1 mapping of
-	 * the PCI memory space in the CPU bus space
-	 */
-	resource_size_t pci_mem_offset;
-	unsigned long pci_io_size;
-
-	struct pci_ops *ops;
-	volatile unsigned int __iomem *cfg_addr;
-	volatile void __iomem *cfg_data;
-
-	/* Currently, we limit ourselves to 1 IO range and 3 mem
-	 * ranges since the common pci_bus structure can't handle more
-	 */
-	struct resource io_resource;
-	struct resource mem_resources[3];
-	int global_number;
-	unsigned long buid;
-	unsigned long dma_window_base_cur;
-	unsigned long dma_window_size;
-
-	void *private_data;
-};
-
-/*
  * PCI stuff, for nodes representing PCI devices, pointed to
  * by device_node->data.
  */
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
