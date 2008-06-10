Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 48A2EDDFAD
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 08:31:02 +1000 (EST)
Date: Wed, 11 Jun 2008 02:31:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: implement OF PCI address accessors stubs for
	CONFIG_PCI=n
Message-ID: <20080610223100.GA3359@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To avoid "#ifdef CONFIG_PCI" in the drivers we should provide stubs in
place of OF PCI address accessors.

Without these stubs build breaks for drivers not strictly requiring PCI,
for example CONFIG_FB_OF=y without CONFIG_PCI:

  LD      .tmp_vmlinux1
drivers/built-in.o: In function `offb_map_reg':
offb.c:(.text+0x6e7c): undefined reference to `of_get_pci_address'

OF PCI IRQ accessors require pci_dev argument, so drivers using PCI
IRQs should depend on CONFIG_PCI anyway.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Other option is to patch offb.c with #ifdef CONFIG_PCI. Though, I think
stubs looks better.

 include/asm-powerpc/prom.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 78b7b0d..eb3bd2e 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -212,8 +212,16 @@ extern u64 of_translate_dma_address(struct device_node *dev,
  */
 extern const u32 *of_get_address(struct device_node *dev, int index,
 			   u64 *size, unsigned int *flags);
+#ifdef CONFIG_PCI
 extern const u32 *of_get_pci_address(struct device_node *dev, int bar_no,
 			       u64 *size, unsigned int *flags);
+#else
+static inline const u32 *of_get_pci_address(struct device_node *dev,
+		int bar_no, u64 *size, unsigned int *flags)
+{
+	return NULL;
+}
+#endif /* CONFIG_PCI */
 
 /* Get an address as a resource. Note that if your address is
  * a PIO address, the conversion will fail if the physical address
@@ -223,8 +231,16 @@ extern const u32 *of_get_pci_address(struct device_node *dev, int bar_no,
  */
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
+#ifdef CONFIG_PCI
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				      struct resource *r);
+#else
+static inline int of_pci_address_to_resource(struct device_node *dev, int bar,
+		struct resource *r)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_PCI */
 
 /* Parse the ibm,dma-window property of an OF node into the busno, phys and
  * size parameters.
-- 
1.5.5.4
