Return-Path: <anton@samba.org>
Date: Mon, 25 Jun 2012 14:25:28 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 miltonm@bga.com, nacc@us.ibm.com, brking@linux.vnet.ibm.com,
 rcj@linux.vnet.ibm.com
Subject: [PATCH 3/4] powerpc: call dma_debug_add_bus for PCI and VIO buses
Message-ID: <20120625142528.6244dd0c@kryten>
In-Reply-To: <20120625142353.0a92791a@kryten>
References: <20120625142353.0a92791a@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The DMA API debug code has hooks to verify all DMA entries have been
freed at time of hot unplug. We need to call dma_debug_add_bus for
this to work.

Signed-off-by: Anton Blanchard <anton@samba.org>  
---

Index: linux-build/arch/powerpc/kernel/vio.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/vio.c	2012-06-08 09:16:53.856359566 +1000
+++ linux-build/arch/powerpc/kernel/vio.c	2012-06-08 09:17:43.625089518 +1000
@@ -37,8 +37,6 @@
 #include <asm/page.h>
 #include <asm/hvcall.h>
 
-static struct bus_type vio_bus_type;
-
 static struct vio_dev vio_bus_device  = { /* fake "parent" device */
 	.name = "vio",
 	.type = "",
@@ -1580,7 +1578,7 @@ static int vio_hotplug(struct device *de
 	return 0;
 }
 
-static struct bus_type vio_bus_type = {
+struct bus_type vio_bus_type = {
 	.name = "vio",
 	.dev_attrs = vio_dev_attrs,
 	.uevent = vio_hotplug,
Index: linux-build/arch/powerpc/kernel/dma.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/dma.c	2012-06-08 09:12:47.356758198 +1000
+++ linux-build/arch/powerpc/kernel/dma.c	2012-06-08 09:17:43.625089518 +1000
@@ -11,6 +11,8 @@
 #include <linux/gfp.h>
 #include <linux/memblock.h>
 #include <linux/export.h>
+#include <linux/pci.h>
+#include <asm/vio.h>
 #include <asm/bug.h>
 #include <asm/abs_addr.h>
 #include <asm/machdep.h>
@@ -205,7 +207,13 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask)
 
 static int __init dma_init(void)
 {
-       dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
+	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
+#ifdef CONFIG_PCI
+	dma_debug_add_bus(&pci_bus_type);
+#endif
+#ifdef CONFIG_IBMVIO
+	dma_debug_add_bus(&vio_bus_type);
+#endif
 
        return 0;
 }
Index: linux-build/arch/powerpc/include/asm/vio.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/vio.h	2012-06-08 09:12:47.344758025 +1000
+++ linux-build/arch/powerpc/include/asm/vio.h	2012-06-08 09:17:43.625089518 +1000
@@ -44,6 +44,8 @@
  */
 #define VIO_CMO_MIN_ENT 1562624
 
+extern struct bus_type vio_bus_type;
+
 struct iommu_table;
 
 /*
