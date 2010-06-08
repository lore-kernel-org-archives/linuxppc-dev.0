Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 5/6] of: Merge of_device_alloc
To: ben@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:26:38 -0600
Message-ID: <20100608142638.26088.21830.stgit@angua>
In-Reply-To: <20100608142152.26088.1108.stgit@angua>
References: <20100608142152.26088.1108.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge common code between PowerPC and Microblaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Grant Likely <grant.likely@secretlab.ca>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
CC: devicetree-discuss@lists.ozlabs.org
---
 arch/microblaze/include/asm/device.h    |    3 +
 arch/microblaze/include/asm/of_device.h |   15 -------
 arch/microblaze/kernel/Makefile         |    2 -
 arch/microblaze/kernel/of_device.c      |   64 -------------------------------
 arch/powerpc/include/asm/device.h       |    3 +
 arch/powerpc/include/asm/of_device.h    |   10 -----
 arch/powerpc/kernel/of_device.c         |   61 ++++--------------------------
 drivers/of/platform.c                   |   53 ++++++++++++++++++++++++++
 include/linux/of_platform.h             |    4 ++
 9 files changed, 72 insertions(+), 143 deletions(-)
 delete mode 100644 arch/microblaze/kernel/of_device.c

diff --git a/arch/microblaze/include/asm/device.h b/arch/microblaze/include/asm/device.h
index 123b2fe..5e63552 100644
--- a/arch/microblaze/include/asm/device.h
+++ b/arch/microblaze/include/asm/device.h
@@ -21,6 +21,9 @@ struct pdev_archdata {
 	u64 dma_mask;
 };
 
+/* Don't override the default bus id behaviour */
+#define of_device_make_bus_id __of_device_make_bus_id
+
 #endif /* _ASM_MICROBLAZE_DEVICE_H */
 
 
diff --git a/arch/microblaze/include/asm/of_device.h b/arch/microblaze/include/asm/of_device.h
index c9be534..47e8d42 100644
--- a/arch/microblaze/include/asm/of_device.h
+++ b/arch/microblaze/include/asm/of_device.h
@@ -10,19 +10,4 @@
 
 #ifndef _ASM_MICROBLAZE_OF_DEVICE_H
 #define _ASM_MICROBLAZE_OF_DEVICE_H
-#ifdef __KERNEL__
-
-#include <linux/device.h>
-#include <linux/of.h>
-
-extern struct of_device *of_device_alloc(struct device_node *np,
-					 const char *bus_id,
-					 struct device *parent);
-
-extern void of_device_make_bus_id(struct of_device *dev);
-
-/* This is just here during the transition */
-#include <linux/of_device.h>
-
-#endif /* __KERNEL__ */
 #endif /* _ASM_MICROBLAZE_OF_DEVICE_H */
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index e51bc15..727e2cb 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -15,7 +15,7 @@ endif
 extra-y := head.o vmlinux.lds
 
 obj-y += dma.o exceptions.o \
-	hw_exception_handler.o init_task.o intc.o irq.o of_device.o \
+	hw_exception_handler.o init_task.o intc.o irq.o \
 	of_platform.o process.o prom.o prom_parse.o ptrace.o \
 	setup.o signal.o sys_microblaze.o timer.o traps.o reset.o
 
diff --git a/arch/microblaze/kernel/of_device.c b/arch/microblaze/kernel/of_device.c
deleted file mode 100644
index 3a367d7..0000000
--- a/arch/microblaze/kernel/of_device.c
+++ /dev/null
@@ -1,64 +0,0 @@
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/slab.h>
-#include <linux/of_device.h>
-
-#include <linux/errno.h>
-
-void of_device_make_bus_id(struct of_device *dev)
-{
-	static atomic_t bus_no_reg_magic;
-	struct device_node *node = dev->dev.of_node;
-	const u32 *reg;
-	u64 addr;
-	int magic;
-
-	/*
-	 * For MMIO, get the physical address
-	 */
-	reg = of_get_property(node, "reg", NULL);
-	if (reg) {
-		addr = of_translate_address(node, reg);
-		if (addr != OF_BAD_ADDR) {
-			dev_set_name(&dev->dev, "%llx.%s",
-				     (unsigned long long)addr, node->name);
-			return;
-		}
-	}
-
-	/*
-	 * No BusID, use the node name and add a globally incremented
-	 * counter (and pray...)
-	 */
-	magic = atomic_add_return(1, &bus_no_reg_magic);
-	dev_set_name(&dev->dev, "%s.%d", node->name, magic - 1);
-}
-EXPORT_SYMBOL(of_device_make_bus_id);
-
-struct of_device *of_device_alloc(struct device_node *np,
-				  const char *bus_id,
-				  struct device *parent)
-{
-	struct of_device *dev;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return NULL;
-
-	dev->dev.of_node = of_node_get(np);
-	dev->dev.dma_mask = &dev->archdata.dma_mask;
-	dev->dev.parent = parent;
-	dev->dev.release = of_release_dev;
-
-	if (bus_id)
-		dev_set_name(&dev->dev, bus_id);
-	else
-		of_device_make_bus_id(dev);
-
-	return dev;
-}
-EXPORT_SYMBOL(of_device_alloc);
diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index a3954e4..3c897a8 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -31,4 +31,7 @@ struct pdev_archdata {
 	u64 dma_mask;
 };
 
+/* Override the default bus_id behaviour for OF stuff */
+extern void of_device_make_bus_id(struct device *dev);
+
 #endif /* _ASM_POWERPC_DEVICE_H */
diff --git a/arch/powerpc/include/asm/of_device.h b/arch/powerpc/include/asm/of_device.h
index 5d5103c..04f7671 100644
--- a/arch/powerpc/include/asm/of_device.h
+++ b/arch/powerpc/include/asm/of_device.h
@@ -1,13 +1,3 @@
 #ifndef _ASM_POWERPC_OF_DEVICE_H
 #define _ASM_POWERPC_OF_DEVICE_H
-#ifdef __KERNEL__
-
-#include <linux/device.h>
-#include <linux/of.h>
-
-extern struct of_device *of_device_alloc(struct device_node *np,
-					 const char *bus_id,
-					 struct device *parent);
-
-#endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_OF_DEVICE_H */
diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index db91a9d..0b60783 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -5,32 +5,29 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/errno.h>
 #include <asm/dcr.h>
 
-static void of_device_make_bus_id(struct of_device *dev)
+void of_device_make_bus_id(struct device *dev)
 {
-	static atomic_t bus_no_reg_magic;
-	struct device_node *node = dev->dev.of_node;
+#ifdef CONFIG_PPC_DCR
+	struct device_node *node = dev->of_node;
 	const u32 *reg;
-	u64 addr;
-	int magic;
 
 	/*
 	 * If it's a DCR based device, use 'd' for native DCRs
 	 * and 'D' for MMIO DCRs.
 	 */
-#ifdef CONFIG_PPC_DCR
 	reg = of_get_property(node, "dcr-reg", NULL);
 	if (reg) {
 #ifdef CONFIG_PPC_DCR_NATIVE
-		dev_set_name(&dev->dev, "d%x.%s", *reg, node->name);
+		dev_set_name(dev, "d%x.%s", *reg, node->name);
 #else /* CONFIG_PPC_DCR_NATIVE */
-		addr = of_translate_dcr_address(node, *reg, NULL);
+		u64 addr = of_translate_dcr_address(node, *reg, NULL);
 		if (addr != OF_BAD_ADDR) {
-			dev_set_name(&dev->dev, "D%llx.%s",
+			dev_set_name(dev, "D%llx.%s",
 				     (unsigned long long)addr, node->name);
 			return;
 		}
@@ -38,47 +35,5 @@ static void of_device_make_bus_id(struct of_device *dev)
 	}
 #endif /* CONFIG_PPC_DCR */
 
-	/*
-	 * For MMIO, get the physical address
-	 */
-	reg = of_get_property(node, "reg", NULL);
-	if (reg) {
-		addr = of_translate_address(node, reg);
-		if (addr != OF_BAD_ADDR) {
-			dev_set_name(&dev->dev, "%llx.%s",
-				     (unsigned long long)addr, node->name);
-			return;
-		}
-	}
-
-	/*
-	 * No BusID, use the node name and add a globally incremented
-	 * counter (and pray...)
-	 */
-	magic = atomic_add_return(1, &bus_no_reg_magic);
-	dev_set_name(&dev->dev, "%s.%d", node->name, magic - 1);
-}
-
-struct of_device *of_device_alloc(struct device_node *np,
-				  const char *bus_id,
-				  struct device *parent)
-{
-	struct of_device *dev;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return NULL;
-
-	dev->dev.of_node = of_node_get(np);
-	dev->dev.dma_mask = &dev->archdata.dma_mask;
-	dev->dev.parent = parent;
-	dev->dev.release = of_release_dev;
-
-	if (bus_id)
-		dev_set_name(&dev->dev, "%s", bus_id);
-	else
-		of_device_make_bus_id(dev);
-
-	return dev;
+	__of_device_make_bus_id(dev);
 }
-EXPORT_SYMBOL(of_device_alloc);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index d9c81e9..4bb898d 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -407,6 +407,59 @@ EXPORT_SYMBOL(of_unregister_driver);
  * mechanism for creating devices from device tree nodes.
  */
 
+void __of_device_make_bus_id(struct device *dev)
+{
+	static atomic_t bus_no_reg_magic;
+	struct device_node *node = dev->of_node;
+	const u32 *reg;
+	u64 addr;
+	int magic;
+
+	/*
+	 * For MMIO, get the physical address
+	 */
+	reg = of_get_property(node, "reg", NULL);
+	if (reg) {
+		addr = of_translate_address(node, reg);
+		if (addr != OF_BAD_ADDR) {
+			dev_set_name(dev, "%llx.%s",
+				     (unsigned long long)addr, node->name);
+			return;
+		}
+	}
+
+	/*
+	 * No BusID, use the node name and add a globally incremented
+	 * counter (and pray...)
+	 */
+	magic = atomic_add_return(1, &bus_no_reg_magic);
+	dev_set_name(dev, "%s.%d", node->name, magic - 1);
+}
+
+struct of_device *of_device_alloc(struct device_node *np,
+				  const char *bus_id,
+				  struct device *parent)
+{
+	struct of_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	dev->dev.of_node = of_node_get(np);
+	dev->dev.dma_mask = &dev->archdata.dma_mask;
+	dev->dev.parent = parent;
+	dev->dev.release = of_release_dev;
+
+	if (bus_id)
+		dev_set_name(&dev->dev, "%s", bus_id);
+	else
+		of_device_make_bus_id(&dev->dev);
+
+	return dev;
+}
+EXPORT_SYMBOL(of_device_alloc);
+
 /**
  * of_platform_device_create - Alloc, initialize and register an of_device
  * @np: pointer to node to create device for
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 4bbba41..8c82a2f 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -60,6 +60,10 @@ static inline void of_unregister_platform_driver(struct of_platform_driver *drv)
 	of_unregister_driver(drv);
 }
 
+extern void __of_device_make_bus_id(struct device *dev);
+extern struct of_device *of_device_alloc(struct device_node *np,
+					 const char *bus_id,
+					 struct device *parent);
 #include <asm/of_platform.h>
 
 extern struct of_device *of_find_device_by_node(struct device_node *np);
