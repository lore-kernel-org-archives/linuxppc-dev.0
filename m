Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3C9B62C017C
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 13:03:25 +1000 (EST)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r6F33KdG013377
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Jul 2013 22:03:22 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/8] powerpc: Better split CONFIG_PPC_INDIRECT_PIO and
 CONFIG_PPC_INDIRECT_MMIO
Date: Mon, 15 Jul 2013 13:03:08 +1000
Message-Id: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the generic PPC_INDIRECT_IO and ensure we only add overhead
to the right accessors. IE. If only CONFIG_PPC_INDIRECT_PIO is set,
we don't add overhead to all MMIO accessors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/io.h        | 25 +++++++++++++++----------
 arch/powerpc/kernel/Makefile         |  2 +-
 arch/powerpc/kernel/io-workarounds.c | 19 ++++++++++++++++++-
 arch/powerpc/kernel/setup_64.c       |  5 ++---
 arch/powerpc/platforms/Kconfig       |  7 +------
 5 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index dd15e5e..6cc61a3 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -69,8 +69,10 @@ extern unsigned long pci_dram_offset;
 
 extern resource_size_t isa_mem_base;
 
-#if defined(CONFIG_PPC32) && defined(CONFIG_PPC_INDIRECT_IO)
-#error CONFIG_PPC_INDIRECT_IO is not yet supported on 32 bits
+#ifdef CONFIG_PPC32
+#if defined(CONFIG_PPC_INDIRECT_PIO) || defined(CONFIG_PPC_INDIRECT_MMIO)
+#error CONFIG_PPC_INDIRECT_{PIO,MMIO} are not yet supported on 32 bits
+#endif
 #endif
 
 /*
@@ -222,9 +224,9 @@ extern void _memcpy_toio(volatile void __iomem *dest, const void *src,
  * for PowerPC is as close as possible to the x86 version of these, and thus
  * provides fairly heavy weight barriers for the non-raw versions
  *
- * In addition, they support a hook mechanism when CONFIG_PPC_INDIRECT_IO
- * allowing the platform to provide its own implementation of some or all
- * of the accessors.
+ * In addition, they support a hook mechanism when CONFIG_PPC_INDIRECT_MMIO
+ * or CONFIG_PPC_INDIRECT_PIO are set allowing the platform to provide its
+ * own implementation of some or all of the accessors.
  */
 
 /*
@@ -240,8 +242,8 @@ extern void _memcpy_toio(volatile void __iomem *dest, const void *src,
 
 /* Indirect IO address tokens:
  *
- * When CONFIG_PPC_INDIRECT_IO is set, the platform can provide hooks
- * on all IOs. (Note that this is all 64 bits only for now)
+ * When CONFIG_PPC_INDIRECT_MMIO is set, the platform can provide hooks
+ * on all MMIOs. (Note that this is all 64 bits only for now)
  *
  * To help platforms who may need to differenciate MMIO addresses in
  * their hooks, a bitfield is reserved for use by the platform near the
@@ -263,11 +265,14 @@ extern void _memcpy_toio(volatile void __iomem *dest, const void *src,
  *
  * The direct IO mapping operations will then mask off those bits
  * before doing the actual access, though that only happen when
- * CONFIG_PPC_INDIRECT_IO is set, thus be careful when you use that
+ * CONFIG_PPC_INDIRECT_MMIO is set, thus be careful when you use that
  * mechanism
+ *
+ * For PIO, there is a separate CONFIG_PPC_INDIRECT_PIO which makes
+ * all PIO functions call through a hook.
  */
 
-#ifdef CONFIG_PPC_INDIRECT_IO
+#ifdef CONFIG_PPC_INDIRECT_MMIO
 #define PCI_IO_IND_TOKEN_MASK	0x0fff000000000000ul
 #define PCI_IO_IND_TOKEN_SHIFT	48
 #define PCI_FIX_ADDR(addr)						\
@@ -672,7 +677,7 @@ extern void __iomem * __ioremap_at(phys_addr_t pa, void *ea,
 extern void __iounmap_at(void *ea, unsigned long size);
 
 /*
- * When CONFIG_PPC_INDIRECT_IO is set, we use the generic iomap implementation
+ * When CONFIG_PPC_INDIRECT_PIO is set, we use the generic iomap implementation
  * which needs some additional definitions here. They basically allow PIO
  * space overall to be 1GB. This will work as long as we never try to use
  * iomap to map MMIO below 1GB which should be fine on ppc64
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index a8619bf..725c2fb 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -119,7 +119,7 @@ obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 
 obj-$(CONFIG_8XX_MINIMAL_FPEMU) += softemu8xx.o
 
-ifneq ($(CONFIG_PPC_INDIRECT_IO),y)
+ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
 obj-y				+= iomap.o
 endif
 
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index fa0b54b..24b968f 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -53,6 +53,7 @@ static struct iowa_bus *iowa_pci_find(unsigned long vaddr, unsigned long paddr)
 	return NULL;
 }
 
+#ifdef CONFIG_PPC_INDIRECT_MMIO
 struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
 {
 	unsigned hugepage_shift;
@@ -90,13 +91,25 @@ struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
 
 	return bus;
 }
+#else /* CONFIG_PPC_INDIRECT_MMIO */
+struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
+{
+	return NULL;
+}
+#endif /* !CONFIG_PPC_INDIRECT_MMIO */
 
+#ifdef CONFIG_PPC_INDIRECT_PIO
 struct iowa_bus *iowa_pio_find_bus(unsigned long port)
 {
 	unsigned long vaddr = (unsigned long)pci_io_base + port;
 	return iowa_pci_find(vaddr, 0);
 }
-
+#else
+struct iowa_bus *iowa_pio_find_bus(unsigned long port)
+{
+	return NULL;
+}
+#endif
 
 #define DEF_PCI_AC_RET(name, ret, at, al, space, aa)		\
 static ret iowa_##name at					\
@@ -137,6 +150,7 @@ static const struct ppc_pci_io iowa_pci_io = {
 
 };
 
+#ifdef CONFIG_PPC_INDIRECT_MMIO
 static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
 				  unsigned long flags, void *caller)
 {
@@ -151,6 +165,9 @@ static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
 	}
 	return res;
 }
+#else /* CONFIG_PPC_INDIRECT_MMIO */
+#define iowa_ioremap NULL
+#endif /* !CONFIG_PPC_INDIRECT_MMIO */
 
 /* Enable IO workaround */
 static void io_workaround_init(void)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 389fb807..5647b6c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -701,8 +701,7 @@ void __init setup_per_cpu_areas(void)
 #endif
 
 
-#ifdef CONFIG_PPC_INDIRECT_IO
+#if defined(CONFIG_PPC_INDIRECT_PIO) || defined(CONFIG_PPC_INDIRECT_MMIO)
 struct ppc_pci_io ppc_pci_io;
 EXPORT_SYMBOL(ppc_pci_io);
-#endif /* CONFIG_PPC_INDIRECT_IO */
-
+#endif
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 0847ee6..b2697e5 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -202,17 +202,12 @@ config PPC_P7_NAP
 	bool
 	default n
 
-config PPC_INDIRECT_IO
-	bool
-	select GENERIC_IOMAP
-
 config PPC_INDIRECT_PIO
 	bool
-	select PPC_INDIRECT_IO
+	select GENERIC_IOMAP
 
 config PPC_INDIRECT_MMIO
 	bool
-	select PPC_INDIRECT_IO
 
 config PPC_IO_WORKAROUNDS
 	bool
-- 
1.8.1.2
