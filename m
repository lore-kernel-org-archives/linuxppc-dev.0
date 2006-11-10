Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 18:44:45 +1100
Subject: [PATCH 4/32] arch provides generic iomap missing accessors
In-Reply-To: <1163144683.554182.685908332811.qpush@grosgo>
Message-Id: <20061110074449.5DA7767D34@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Linus Torvalds <torvalds@osdl.org>

Allow architectures to provide their own implementation of the big endian MMIO
accessors and "repeat" MMIO accessors for use by the generic iomap.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
More-or-less-tested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 lib/iomap.c |   32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

Index: linux-cell/lib/iomap.c
===================================================================
--- linux-cell.orig/lib/iomap.c	2006-11-05 16:19:32.000000000 +1100
+++ linux-cell/lib/iomap.c	2006-11-05 16:19:40.000000000 +1100
@@ -50,6 +50,16 @@
 	}							\
 } while (0)
 
+#ifndef pio_read16be
+#define pio_read16be(port) swab16(inw(port))
+#define pio_read32be(port) swab32(inl(port))
+#endif
+
+#ifndef mmio_read16be
+#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
+#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
+#endif
+
 unsigned int fastcall ioread8(void __iomem *addr)
 {
 	IO_COND(addr, return inb(port), return readb(addr));
@@ -60,7 +70,7 @@
 }
 unsigned int fastcall ioread16be(void __iomem *addr)
 {
-	IO_COND(addr, return inw(port), return be16_to_cpu(__raw_readw(addr)));
+	IO_COND(addr, return pio_read16be(port), return mmio_read16be(addr));
 }
 unsigned int fastcall ioread32(void __iomem *addr)
 {
@@ -68,7 +78,7 @@
 }
 unsigned int fastcall ioread32be(void __iomem *addr)
 {
-	IO_COND(addr, return inl(port), return be32_to_cpu(__raw_readl(addr)));
+	IO_COND(addr, return pio_read32be(port), return mmio_read32be(addr));
 }
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
@@ -76,6 +86,16 @@
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
 
+#ifndef pio_write16be
+#define pio_write16be(val,port) outw(swab16(val),port)
+#define pio_write32be(val,port) outl(swab32(val),port)
+#endif
+
+#ifndef mmio_write16be
+#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
+#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
+#endif
+
 void fastcall iowrite8(u8 val, void __iomem *addr)
 {
 	IO_COND(addr, outb(val,port), writeb(val, addr));
@@ -86,7 +106,7 @@
 }
 void fastcall iowrite16be(u16 val, void __iomem *addr)
 {
-	IO_COND(addr, outw(val,port), __raw_writew(cpu_to_be16(val), addr));
+	IO_COND(addr, pio_write16be(val,port), mmio_write16be(val, addr));
 }
 void fastcall iowrite32(u32 val, void __iomem *addr)
 {
@@ -94,7 +114,7 @@
 }
 void fastcall iowrite32be(u32 val, void __iomem *addr)
 {
-	IO_COND(addr, outl(val,port), __raw_writel(cpu_to_be32(val), addr));
+	IO_COND(addr, pio_write32be(val,port), mmio_write32be(val, addr));
 }
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
@@ -108,6 +128,7 @@
  * convert to CPU byte order. We write in "IO byte
  * order" (we also don't have IO barriers).
  */
+#ifndef mmio_insb
 static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
 {
 	while (--count >= 0) {
@@ -132,7 +153,9 @@
 		dst++;
 	}
 }
+#endif
 
+#ifndef mmio_outsb
 static inline void mmio_outsb(void __iomem *addr, const u8 *src, int count)
 {
 	while (--count >= 0) {
@@ -154,6 +177,7 @@
 		src++;
 	}
 }
+#endif
 
 void fastcall ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 {
