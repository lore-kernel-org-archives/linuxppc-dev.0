Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f182.google.com (mail-pz0-f182.google.com
	[209.85.222.182]) by ozlabs.org (Postfix) with ESMTP id 8A36E1007E4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 00:10:12 +1000 (EST)
Received: by pzk12 with SMTP id 12so3113174pzk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jun 2010 07:10:10 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 2/5] of/address: merge of_address_to_resource()
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:10:03 -0600
Message-ID: <20100608141002.25879.82283.stgit@angua>
In-Reply-To: <20100608140917.25879.67745.stgit@angua>
References: <20100608140917.25879.67745.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge common code between PowerPC and Microblaze.  This patch also
moves the prototype of pci_address_to_pio() out of pci-bridge.h and
into prom.h because the only user of pci_address_to_pio() is
of_address_to_resource().

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Grant Likely <grant.likely@secretlab.ca>
CC: Wolfram Sang <w.sang@pengutronix.de>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
---
 arch/microblaze/include/asm/pci-bridge.h |    5 ---
 arch/microblaze/include/asm/prom.h       |   17 +++++-----
 arch/microblaze/kernel/prom_parse.c      |   46 +--------------------------
 arch/powerpc/include/asm/pci-bridge.h    |    5 ---
 arch/powerpc/include/asm/prom.h          |   17 +++++-----
 arch/powerpc/kernel/prom_parse.c         |   47 +---------------------------
 drivers/of/address.c                     |   51 ++++++++++++++++++++++++++++++
 include/linux/of_address.h               |    5 +++
 8 files changed, 76 insertions(+), 117 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index 0c77cda..0c68764 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -172,13 +172,8 @@ static inline int pci_has_flag(int flag)
 
 extern struct list_head hose_list;
 
-extern unsigned long pci_address_to_pio(phys_addr_t address);
 extern int pcibios_vaddr_is_ioport(void __iomem *address);
 #else
-static inline unsigned long pci_address_to_pio(phys_addr_t address)
-{
-	return (unsigned long)-1;
-}
 static inline int pcibios_vaddr_is_ioport(void __iomem *address)
 {
 	return 0;
diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index b6698ef..644fa32 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -65,17 +65,18 @@ extern const u32 *of_get_address(struct device_node *dev, int index,
 extern const u32 *of_get_pci_address(struct device_node *dev, int bar_no,
 			u64 *size, unsigned int *flags);
 
-/* Get an address as a resource. Note that if your address is
- * a PIO address, the conversion will fail if the physical address
- * can't be internally converted to an IO token with
- * pci_address_to_pio(), that is because it's either called to early
- * or it can't be matched to any host bridge IO space
- */
-extern int of_address_to_resource(struct device_node *dev, int index,
-				struct resource *r);
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				struct resource *r);
 
+#ifdef CONFIG_PCI
+extern unsigned long pci_address_to_pio(phys_addr_t address);
+#else
+static inline unsigned long pci_address_to_pio(phys_addr_t address)
+{
+	return (unsigned long)-1;
+}
+#endif	/* CONFIG_PCI */
+
 /* Parse the ibm,dma-window property of an OF node into the busno, phys and
  * size parameters.
  */
diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel/prom_parse.c
index 5003ee8..7cb5a98 100644
--- a/arch/microblaze/kernel/prom_parse.c
+++ b/arch/microblaze/kernel/prom_parse.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/etherdevice.h>
+#include <linux/of_address.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
@@ -17,9 +18,6 @@
 			(ns) > 0)
 
 static struct of_bus *of_match_bus(struct device_node *np);
-static int __of_address_to_resource(struct device_node *dev,
-		const u32 *addrp, u64 size, unsigned int flags,
-		struct resource *r);
 
 /* Debug utility */
 #ifdef DEBUG
@@ -576,48 +574,6 @@ const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
 }
 EXPORT_SYMBOL(of_get_address);
 
-static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
-				u64 size, unsigned int flags,
-				struct resource *r)
-{
-	u64 taddr;
-
-	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
-		return -EINVAL;
-	taddr = of_translate_address(dev, addrp);
-	if (taddr == OF_BAD_ADDR)
-		return -EINVAL;
-	memset(r, 0, sizeof(struct resource));
-	if (flags & IORESOURCE_IO) {
-		unsigned long port;
-		port = -1; /* pci_address_to_pio(taddr); */
-		if (port == (unsigned long)-1)
-			return -EINVAL;
-		r->start = port;
-		r->end = port + size - 1;
-	} else {
-		r->start = taddr;
-		r->end = taddr + size - 1;
-	}
-	r->flags = flags;
-	r->name = dev->name;
-	return 0;
-}
-
-int of_address_to_resource(struct device_node *dev, int index,
-			struct resource *r)
-{
-	const u32	*addrp;
-	u64		size;
-	unsigned int	flags;
-
-	addrp = of_get_address(dev, index, &size, &flags);
-	if (addrp == NULL)
-		return -EINVAL;
-	return __of_address_to_resource(dev, addrp, size, flags, r);
-}
-EXPORT_SYMBOL_GPL(of_address_to_resource);
-
 void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
 		unsigned long *busno, unsigned long *phys, unsigned long *size)
 {
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 76e1f31..51e9e6f 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -303,13 +303,8 @@ extern void pcibios_free_controller(struct pci_controller *phb);
 extern void pcibios_setup_phb_resources(struct pci_controller *hose);
 
 #ifdef CONFIG_PCI
-extern unsigned long pci_address_to_pio(phys_addr_t address);
 extern int pcibios_vaddr_is_ioport(void __iomem *address);
 #else
-static inline unsigned long pci_address_to_pio(phys_addr_t address)
-{
-	return (unsigned long)-1;
-}
 static inline int pcibios_vaddr_is_ioport(void __iomem *address)
 {
 	return 0;
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index e0bdbc6..e1c1bdd 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -70,14 +70,6 @@ static inline const u32 *of_get_pci_address(struct device_node *dev,
 }
 #endif /* CONFIG_PCI */
 
-/* Get an address as a resource. Note that if your address is
- * a PIO address, the conversion will fail if the physical address
- * can't be internally converted to an IO token with
- * pci_address_to_pio(), that is because it's either called to early
- * or it can't be matched to any host bridge IO space
- */
-extern int of_address_to_resource(struct device_node *dev, int index,
-				  struct resource *r);
 #ifdef CONFIG_PCI
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				      struct resource *r);
@@ -89,6 +81,15 @@ static inline int of_pci_address_to_resource(struct device_node *dev, int bar,
 }
 #endif /* CONFIG_PCI */
 
+#ifdef CONFIG_PCI
+extern unsigned long pci_address_to_pio(phys_addr_t address);
+#else
+static inline unsigned long pci_address_to_pio(phys_addr_t address)
+{
+	return (unsigned long)-1;
+}
+#endif	/* CONFIG_PCI */
+
 /* Parse the ibm,dma-window property of an OF node into the busno, phys and
  * size parameters.
  */
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index dfb73c4..a2ef129 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/etherdevice.h>
+#include <linux/of_address.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
@@ -27,10 +28,6 @@
 			(ns) > 0)
 
 static struct of_bus *of_match_bus(struct device_node *np);
-static int __of_address_to_resource(struct device_node *dev,
-		const u32 *addrp, u64 size, unsigned int flags,
-		struct resource *r);
-
 
 /* Debug utility */
 #ifdef DEBUG
@@ -610,48 +607,6 @@ const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
 }
 EXPORT_SYMBOL(of_get_address);
 
-static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
-				    u64 size, unsigned int flags,
-				    struct resource *r)
-{
-	u64 taddr;
-
-	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
-		return -EINVAL;
-	taddr = of_translate_address(dev, addrp);
-	if (taddr == OF_BAD_ADDR)
-		return -EINVAL;
-	memset(r, 0, sizeof(struct resource));
-	if (flags & IORESOURCE_IO) {
-		unsigned long port;
-		port = pci_address_to_pio(taddr);
-		if (port == (unsigned long)-1)
-			return -EINVAL;
-		r->start = port;
-		r->end = port + size - 1;
-	} else {
-		r->start = taddr;
-		r->end = taddr + size - 1;
-	}
-	r->flags = flags;
-	r->name = dev->name;
-	return 0;
-}
-
-int of_address_to_resource(struct device_node *dev, int index,
-			   struct resource *r)
-{
-	const u32	*addrp;
-	u64		size;
-	unsigned int	flags;
-
-	addrp = of_get_address(dev, index, &size, &flags);
-	if (addrp == NULL)
-		return -EINVAL;
-	return __of_address_to_resource(dev, addrp, size, flags, r);
-}
-EXPORT_SYMBOL_GPL(of_address_to_resource);
-
 void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
 		unsigned long *busno, unsigned long *phys, unsigned long *size)
 {
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 258528d..c381955 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -3,6 +3,57 @@
 #include <linux/ioport.h>
 #include <linux/of_address.h>
 
+int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
+			     u64 size, unsigned int flags,
+			     struct resource *r)
+{
+	u64 taddr;
+
+	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
+		return -EINVAL;
+	taddr = of_translate_address(dev, addrp);
+	if (taddr == OF_BAD_ADDR)
+		return -EINVAL;
+	memset(r, 0, sizeof(struct resource));
+	if (flags & IORESOURCE_IO) {
+		unsigned long port;
+		port = pci_address_to_pio(taddr);
+		if (port == (unsigned long)-1)
+			return -EINVAL;
+		r->start = port;
+		r->end = port + size - 1;
+	} else {
+		r->start = taddr;
+		r->end = taddr + size - 1;
+	}
+	r->flags = flags;
+	r->name = dev->name;
+	return 0;
+}
+
+/**
+ * of_address_to_resource - Translate device tree address and return as resource
+ *
+ * Note that if your address is a PIO address, the conversion will fail if
+ * the physical address can't be internally converted to an IO token with
+ * pci_address_to_pio(), that is because it's either called to early or it
+ * can't be matched to any host bridge IO space
+ */
+int of_address_to_resource(struct device_node *dev, int index,
+			   struct resource *r)
+{
+	const u32	*addrp;
+	u64		size;
+	unsigned int	flags;
+
+	addrp = of_get_address(dev, index, &size, &flags);
+	if (addrp == NULL)
+		return -EINVAL;
+	return __of_address_to_resource(dev, addrp, size, flags, r);
+}
+EXPORT_SYMBOL_GPL(of_address_to_resource);
+
+
 /**
  * of_iomap - Maps the memory mapped IO for a given device_node
  * @device:	the device whose io range will be mapped
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 570831d..474b794 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -3,6 +3,11 @@
 #include <linux/ioport.h>
 #include <linux/of.h>
 
+extern int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
+				    u64 size, unsigned int flags,
+				    struct resource *r);
+extern int of_address_to_resource(struct device_node *dev, int index,
+				  struct resource *r);
 extern void __iomem *of_iomap(struct device_node *device, int index);
 
 #endif /* __OF_ADDRESS_H */
