Return-Path: <anton@samba.org>
Date: Mon, 9 May 2011 17:43:47 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/2] powerpc: Remove ioremap_flags
Message-ID: <20110509174347.5695cf56@kryten>
In-Reply-To: <20110509174159.6f9759d9@kryten>
References: <20110509174159.6f9759d9@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We have a confusing number of ioremap functions. Make things just a
bit simpler by merging ioremap_flags and ioremap_prot.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/include/asm/io.h
===================================================================
--- linux-powerpc.orig/arch/powerpc/include/asm/io.h	2011-05-09 13:29:33.000000000 +1000
+++ linux-powerpc/arch/powerpc/include/asm/io.h	2011-05-09 13:33:30.969769572 +1000
@@ -624,9 +624,8 @@ static inline void iosync(void)
  * * ioremap is the standard one and provides non-cacheable guarded mappings
  *   and can be hooked by the platform via ppc_md
  *
- * * ioremap_flags allows to specify the page flags as an argument and can
- *   also be hooked by the platform via ppc_md. ioremap_prot is the exact
- *   same thing as ioremap_flags.
+ * * ioremap_prot allows to specify the page flags as an argument and can
+ *   also be hooked by the platform via ppc_md.
  *
  * * ioremap_nocache is identical to ioremap
  *
@@ -639,7 +638,7 @@ static inline void iosync(void)
  *   currently be hooked. Must be page aligned.
  *
  * * __ioremap is the low level implementation used by ioremap and
- *   ioremap_flags and cannot be hooked (but can be used by a hook on one
+ *   ioremap_prot and cannot be hooked (but can be used by a hook on one
  *   of the previous ones)
  *
  * * __ioremap_caller is the same as above but takes an explicit caller
@@ -650,11 +649,10 @@ static inline void iosync(void)
  *
  */
 extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
-extern void __iomem *ioremap_flags(phys_addr_t address, unsigned long size,
-				   unsigned long flags);
+extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
+				  unsigned long flags);
 extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
-#define ioremap_prot(addr, size, prot)	ioremap_flags((addr), (size), (prot))
 
 extern void iounmap(volatile void __iomem *addr);
 
Index: linux-powerpc/arch/powerpc/lib/devres.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/lib/devres.c	2011-05-09 13:20:38.000000000 +1000
+++ linux-powerpc/arch/powerpc/lib/devres.c	2011-05-09 13:32:38.768848426 +1000
@@ -9,11 +9,11 @@
 
 #include <linux/device.h>	/* devres_*(), devm_ioremap_release() */
 #include <linux/gfp.h>
-#include <linux/io.h>		/* ioremap_flags() */
+#include <linux/io.h>		/* ioremap_prot() */
 #include <linux/module.h>	/* EXPORT_SYMBOL() */
 
 /**
- * devm_ioremap_prot - Managed ioremap_flags()
+ * devm_ioremap_prot - Managed ioremap_prot()
  * @dev: Generic device to remap IO address for
  * @offset: BUS offset to map
  * @size: Size of map
@@ -31,7 +31,7 @@ void __iomem *devm_ioremap_prot(struct d
 	if (!ptr)
 		return NULL;
 
-	addr = ioremap_flags(offset, size, flags);
+	addr = ioremap_prot(offset, size, flags);
 	if (addr) {
 		*ptr = addr;
 		devres_add(dev, ptr);
Index: linux-powerpc/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/mm/pgtable_32.c	2011-05-09 13:30:21.000000000 +1000
+++ linux-powerpc/arch/powerpc/mm/pgtable_32.c	2011-05-09 13:32:38.768848426 +1000
@@ -141,7 +141,7 @@ ioremap_wc(phys_addr_t addr, unsigned lo
 EXPORT_SYMBOL(ioremap_wc);
 
 void __iomem *
-ioremap_flags(phys_addr_t addr, unsigned long size, unsigned long flags)
+ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
 	/* writeable implies dirty for kernel addresses */
 	if (flags & _PAGE_RW)
@@ -160,7 +160,7 @@ ioremap_flags(phys_addr_t addr, unsigned
 
 	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
-EXPORT_SYMBOL(ioremap_flags);
+EXPORT_SYMBOL(ioremap_prot);
 
 void __iomem *
 __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
Index: linux-powerpc/arch/powerpc/mm/pgtable_64.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/mm/pgtable_64.c	2011-05-09 13:32:20.000000000 +1000
+++ linux-powerpc/arch/powerpc/mm/pgtable_64.c	2011-05-09 13:33:50.310110792 +1000
@@ -265,7 +265,7 @@ void __iomem * ioremap_wc(phys_addr_t ad
 	return __ioremap_caller(addr, size, flags, caller);
 }
 
-void __iomem * ioremap_flags(phys_addr_t addr, unsigned long size,
+void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 			     unsigned long flags)
 {
 	void *caller = __builtin_return_address(0);
@@ -322,7 +322,7 @@ void iounmap(volatile void __iomem *toke
 
 EXPORT_SYMBOL(ioremap);
 EXPORT_SYMBOL(ioremap_wc);
-EXPORT_SYMBOL(ioremap_flags);
+EXPORT_SYMBOL(ioremap_prot);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(__ioremap_at);
 EXPORT_SYMBOL(iounmap);
Index: linux-powerpc/arch/powerpc/platforms/ps3/spu.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/ps3/spu.c	2011-05-09 13:20:38.000000000 +1000
+++ linux-powerpc/arch/powerpc/platforms/ps3/spu.c	2011-05-09 13:32:38.768848426 +1000
@@ -197,7 +197,7 @@ static void spu_unmap(struct spu *spu)
  * The current HV requires the spu shadow regs to be mapped with the
  * PTE page protection bits set as read-only (PP=3).  This implementation
  * uses the low level __ioremap() to bypass the page protection settings
- * inforced by ioremap_flags() to get the needed PTE bits set for the
+ * inforced by ioremap_prot() to get the needed PTE bits set for the
  * shadow regs.
  */
 
@@ -214,7 +214,7 @@ static int __init setup_areas(struct spu
 		goto fail_ioremap;
 	}
 
-	spu->local_store = (__force void *)ioremap_flags(spu->local_store_phys,
+	spu->local_store = (__force void *)ioremap_prot(spu->local_store_phys,
 		LS_SIZE, _PAGE_NO_CACHE);
 
 	if (!spu->local_store) {
Index: linux-powerpc/arch/powerpc/sysdev/axonram.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/sysdev/axonram.c	2011-05-09 13:20:38.000000000 +1000
+++ linux-powerpc/arch/powerpc/sysdev/axonram.c	2011-05-09 13:32:38.768848426 +1000
@@ -216,7 +216,7 @@ static int axon_ram_probe(struct platfor
 			AXON_RAM_DEVICE_NAME, axon_ram_bank_id, bank->size >> 20);
 
 	bank->ph_addr = resource.start;
-	bank->io_addr = (unsigned long) ioremap_flags(
+	bank->io_addr = (unsigned long) ioremap_prot(
 			bank->ph_addr, bank->size, _PAGE_NO_CACHE);
 	if (bank->io_addr == 0) {
 		dev_err(&device->dev, "ioremap() failed\n");
Index: linux-powerpc/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/sysdev/fsl_85xx_cache_sram.c	2011-05-09 13:20:38.000000000 +1000
+++ linux-powerpc/arch/powerpc/sysdev/fsl_85xx_cache_sram.c	2011-05-09 13:32:38.768848426 +1000
@@ -106,10 +106,10 @@ int __init instantiate_cache_sram(struct
 		goto out_free;
 	}
 
-	cache_sram->base_virt = ioremap_flags(cache_sram->base_phys,
+	cache_sram->base_virt = ioremap_prot(cache_sram->base_phys,
 				cache_sram->size, _PAGE_COHERENT | PAGE_KERNEL);
 	if (!cache_sram->base_virt) {
-		dev_err(&dev->dev, "%s: ioremap_flags failed\n",
+		dev_err(&dev->dev, "%s: ioremap_prot failed\n",
 				dev->dev.of_node->full_name);
 		ret = -ENOMEM;
 		goto out_release;
