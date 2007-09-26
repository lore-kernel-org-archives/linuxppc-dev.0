Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C4DBDDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 19:44:55 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l8Q9iRDV431536
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 09:44:27 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8Q9iR812646148
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 10:44:27 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8Q9iKEU006710
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 10:44:21 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/5] PowerPC: Move of_device allocation into of_device.[ch]
Date: Wed, 26 Sep 2007 11:44:12 +0200
References: <200709261143.24735.fenkes@de.ibm.com>
In-Reply-To: <200709261143.24735.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261144.14282.fenkes@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Extract generic of_device allocation code from of_platform_device_create()
and move it into of_device.[ch], called of_device_alloc(). Also, there's now
of_device_free() which puts the device node.

This way, bus drivers that build on of_platform (like ibmebus will) can
build upon this code instead of reinventing the wheel.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 include/asm-powerpc/of_device.h   |    4 ++
 include/linux/of_device.h         |    5 ++
 arch/powerpc/kernel/of_device.c   |   80 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/of_platform.c |   70 +-------------------------------
 4 files changed, 91 insertions(+), 68 deletions(-)

diff --git a/include/asm-powerpc/of_device.h b/include/asm-powerpc/of_device.h
index ec2a8a2..9ab469d 100644
--- a/include/asm-powerpc/of_device.h
+++ b/include/asm-powerpc/of_device.h
@@ -17,6 +17,10 @@ struct of_device
 	struct device		dev;		/* Generic device interface */
 };
 
+extern struct of_device *of_device_alloc(struct device_node *np,
+					 const char *bus_id,
+					 struct device *parent);
+
 extern ssize_t of_device_get_modalias(struct of_device *ofdev,
 					char *str, ssize_t len);
 extern int of_device_uevent(struct device *dev,
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 91bf84b..212bffb 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -22,5 +22,10 @@ extern int of_device_register(struct of_device *ofdev);
 extern void of_device_unregister(struct of_device *ofdev);
 extern void of_release_dev(struct device *dev);
 
+static inline void of_device_free(struct of_device *dev)
+{
+	of_release_dev(&dev->dev);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_OF_DEVICE_H */
diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 89b911e..ecb8b0e 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -7,8 +7,88 @@
 #include <linux/slab.h>
 
 #include <asm/errno.h>
+#include <asm/dcr.h>
 #include <asm/of_device.h>
 
+static void of_device_make_bus_id(struct of_device *dev)
+{
+	static atomic_t bus_no_reg_magic;
+	struct device_node *node = dev->node;
+	char *name = dev->dev.bus_id;
+	const u32 *reg;
+	u64 addr;
+	int magic;
+
+	/*
+	 * If it's a DCR based device, use 'd' for native DCRs
+	 * and 'D' for MMIO DCRs.
+	 */
+#ifdef CONFIG_PPC_DCR
+	reg = of_get_property(node, "dcr-reg", NULL);
+	if (reg) {
+#ifdef CONFIG_PPC_DCR_NATIVE
+		snprintf(name, BUS_ID_SIZE, "d%x.%s",
+			 *reg, node->name);
+#else /* CONFIG_PPC_DCR_NATIVE */
+		addr = of_translate_dcr_address(node, *reg, NULL);
+		if (addr != OF_BAD_ADDR) {
+			snprintf(name, BUS_ID_SIZE,
+				 "D%llx.%s", (unsigned long long)addr,
+				 node->name);
+			return;
+		}
+#endif /* !CONFIG_PPC_DCR_NATIVE */
+	}
+#endif /* CONFIG_PPC_DCR */
+
+	/*
+	 * For MMIO, get the physical address
+	 */
+	reg = of_get_property(node, "reg", NULL);
+	if (reg) {
+		addr = of_translate_address(node, reg);
+		if (addr != OF_BAD_ADDR) {
+			snprintf(name, BUS_ID_SIZE,
+				 "%llx.%s", (unsigned long long)addr,
+				 node->name);
+			return;
+		}
+	}
+
+	/*
+	 * No BusID, use the node name and add a globally incremented
+	 * counter (and pray...)
+	 */
+	magic = atomic_add_return(1, &bus_no_reg_magic);
+	snprintf(name, BUS_ID_SIZE, "%s.%d", node->name, magic - 1);
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
+	dev->node = of_node_get(np);
+	dev->dev.dma_mask = &dev->dma_mask;
+	dev->dev.parent = parent;
+	dev->dev.release = of_release_dev;
+	dev->dev.archdata.of_node = np;
+	dev->dev.archdata.numa_node = of_node_to_nid(np);
+
+	if (bus_id)
+		strlcpy(dev->dev.bus_id, bus_id, BUS_ID_SIZE);
+	else
+		of_device_make_bus_id(dev);
+
+	return dev;
+}
+EXPORT_SYMBOL(of_device_alloc);
+
 ssize_t of_device_get_modalias(struct of_device *ofdev,
 				char *str, ssize_t len)
 {
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index f70e787..1d96b82 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -21,7 +21,6 @@
 #include <linux/pci.h>
 
 #include <asm/errno.h>
-#include <asm/dcr.h>
 #include <asm/of_device.h>
 #include <asm/of_platform.h>
 #include <asm/topology.h>
@@ -53,8 +52,6 @@ static struct of_device_id of_default_bus_ids[] = {
 	{},
 };
 
-static atomic_t bus_no_reg_magic;
-
 struct bus_type of_platform_bus_type = {
        .uevent	= of_device_uevent,
 };
@@ -84,89 +81,26 @@ void of_unregister_platform_driver(struct of_platform_driver *drv)
 }
 EXPORT_SYMBOL(of_unregister_platform_driver);
 
-static void of_platform_make_bus_id(struct of_device *dev)
-{
-	struct device_node *node = dev->node;
-	char *name = dev->dev.bus_id;
-	const u32 *reg;
-	u64 addr;
-	int magic;
-
-	/*
-	 * If it's a DCR based device, use 'd' for native DCRs
-	 * and 'D' for MMIO DCRs.
-	 */
-#ifdef CONFIG_PPC_DCR
-	reg = of_get_property(node, "dcr-reg", NULL);
-	if (reg) {
-#ifdef CONFIG_PPC_DCR_NATIVE
-		snprintf(name, BUS_ID_SIZE, "d%x.%s",
-			 *reg, node->name);
-#else /* CONFIG_PPC_DCR_NATIVE */
-		addr = of_translate_dcr_address(node, *reg, NULL);
-		if (addr != OF_BAD_ADDR) {
-			snprintf(name, BUS_ID_SIZE,
-				 "D%llx.%s", (unsigned long long)addr,
-				 node->name);
-			return;
-		}
-#endif /* !CONFIG_PPC_DCR_NATIVE */
-	}
-#endif /* CONFIG_PPC_DCR */
-
-	/*
-	 * For MMIO, get the physical address
-	 */
-	reg = of_get_property(node, "reg", NULL);
-	if (reg) {
-		addr = of_translate_address(node, reg);
-		if (addr != OF_BAD_ADDR) {
-			snprintf(name, BUS_ID_SIZE,
-				 "%llx.%s", (unsigned long long)addr,
-				 node->name);
-			return;
-		}
-	}
-
-	/*
-	 * No BusID, use the node name and add a globally incremented
-	 * counter (and pray...)
-	 */
-	magic = atomic_add_return(1, &bus_no_reg_magic);
-	snprintf(name, BUS_ID_SIZE, "%s.%d", node->name, magic - 1);
-}
-
 struct of_device* of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
 					    struct device *parent)
 {
 	struct of_device *dev;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	dev = of_device_alloc(np, bus_id, parent);
 	if (!dev)
 		return NULL;
 
-	dev->node = of_node_get(np);
 	dev->dma_mask = 0xffffffffUL;
-	dev->dev.dma_mask = &dev->dma_mask;
-	dev->dev.parent = parent;
 	dev->dev.bus = &of_platform_bus_type;
-	dev->dev.release = of_release_dev;
-	dev->dev.archdata.of_node = np;
-	dev->dev.archdata.numa_node = of_node_to_nid(np);
 
 	/* We do not fill the DMA ops for platform devices by default.
 	 * This is currently the responsibility of the platform code
 	 * to do such, possibly using a device notifier
 	 */
 
-	if (bus_id)
-		strlcpy(dev->dev.bus_id, bus_id, BUS_ID_SIZE);
-	else
-		of_platform_make_bus_id(dev);
-
 	if (of_device_register(dev) != 0) {
-		kfree(dev);
+		of_device_free(dev);
 		return NULL;
 	}
 
-- 
1.5.2
