Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 7712AB7D4A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 00:10:05 +1000 (EST)
Received: by pxi6 with SMTP id 6so1661937pxi.15
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jun 2010 07:10:04 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 1/5] of/address: merge of_iomap()
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:09:57 -0600
Message-ID: <20100608140957.25879.98286.stgit@angua>
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

Merge common code between Microblaze and PowerPC.  This patch creates
new of_address.h and address.c files to containing address translation
and mapping routines.  First routine to be moved it of_iomap()

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Wolfram Sang <w.sang@pengutronix.de>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
---
 arch/microblaze/include/asm/prom.h  |   10 +---------
 arch/microblaze/kernel/prom_parse.c |   11 -----------
 arch/powerpc/include/asm/prom.h     |   10 +---------
 arch/powerpc/kernel/prom_parse.c    |   11 -----------
 drivers/of/Kconfig                  |    4 ++++
 drivers/of/Makefile                 |    1 +
 drivers/of/address.c                |   22 ++++++++++++++++++++++
 include/linux/of_address.h          |    9 +++++++++
 8 files changed, 38 insertions(+), 40 deletions(-)
 create mode 100644 drivers/of/address.c
 create mode 100644 include/linux/of_address.h

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index 3659930..b6698ef 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -20,6 +20,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_fdt.h>
 #include <linux/proc_fs.h>
@@ -107,15 +108,6 @@ extern const void *of_get_mac_address(struct device_node *np);
 struct pci_dev;
 extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
 
-/**
- * of_iomap - Maps the memory mapped IO for a given device_node
- * @device:	the device whose io range will be mapped
- * @index:	index of the io range
- *
- * Returns a pointer to the mapped memory
- */
-extern void __iomem *of_iomap(struct device_node *device, int index);
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_MICROBLAZE_PROM_H */
diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel/prom_parse.c
index 70c0471..5003ee8 100644
--- a/arch/microblaze/kernel/prom_parse.c
+++ b/arch/microblaze/kernel/prom_parse.c
@@ -697,14 +697,3 @@ const void *of_get_mac_address(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL(of_get_mac_address);
-
-void __iomem *of_iomap(struct device_node *np, int index)
-{
-	struct resource res;
-
-	if (of_address_to_resource(np, index, &res))
-		return NULL;
-
-	return ioremap(res.start, 1 + res.end - res.start);
-}
-EXPORT_SYMBOL(of_iomap);
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 2440984..e0bdbc6 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -18,6 +18,7 @@
  */
 #include <linux/types.h>
 #include <linux/of_fdt.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/proc_fs.h>
 #include <linux/platform_device.h>
@@ -136,14 +137,5 @@ extern void of_irq_map_init(unsigned int flags);
 struct pci_dev;
 extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
 
-/**
- * of_iomap - Maps the memory mapped IO for a given device_node
- * @device:	the device whose io range will be mapped
- * @index:	index of the io range
- *
- * Returns a pointer to the mapped memory
- */
-extern void __iomem *of_iomap(struct device_node *device, int index);
-
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index ef518e3..dfb73c4 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -822,14 +822,3 @@ const void *of_get_mac_address(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL(of_get_mac_address);
-
-void __iomem *of_iomap(struct device_node *np, int index)
-{
-	struct resource res;
-
-	if (of_address_to_resource(np, index, &res))
-		return NULL;
-
-	return ioremap(res.start, 1 + res.end - res.start);
-}
-EXPORT_SYMBOL(of_iomap);
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index b87495e..097f42a 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -6,6 +6,10 @@ config OF_DYNAMIC
 	def_bool y
 	depends on OF && PPC_OF
 
+config OF_ADDRESS
+	def_bool y
+	depends on OF && !SPARC
+
 config OF_IRQ
 	def_bool y
 	depends on OF && !SPARC
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 3631a5e..0052c40 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,5 +1,6 @@
 obj-y = base.o
 obj-$(CONFIG_OF_FLATTREE) += fdt.o
+obj-$(CONFIG_OF_ADDRESS)  += address.o
 obj-$(CONFIG_OF_IRQ)    += irq.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_GPIO)   += gpio.o
diff --git a/drivers/of/address.c b/drivers/of/address.c
new file mode 100644
index 0000000..258528d
--- /dev/null
+++ b/drivers/of/address.c
@@ -0,0 +1,22 @@
+
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/of_address.h>
+
+/**
+ * of_iomap - Maps the memory mapped IO for a given device_node
+ * @device:	the device whose io range will be mapped
+ * @index:	index of the io range
+ *
+ * Returns a pointer to the mapped memory
+ */
+void __iomem *of_iomap(struct device_node *np, int index)
+{
+	struct resource res;
+
+	if (of_address_to_resource(np, index, &res))
+		return NULL;
+
+	return ioremap(res.start, 1 + res.end - res.start);
+}
+EXPORT_SYMBOL(of_iomap);
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
new file mode 100644
index 0000000..570831d
--- /dev/null
+++ b/include/linux/of_address.h
@@ -0,0 +1,9 @@
+#ifndef __OF_ADDRESS_H
+#define __OF_ADDRESS_H
+#include <linux/ioport.h>
+#include <linux/of.h>
+
+extern void __iomem *of_iomap(struct device_node *device, int index);
+
+#endif /* __OF_ADDRESS_H */
+
