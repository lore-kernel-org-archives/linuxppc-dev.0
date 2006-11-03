Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 750F867CA9
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 08:12:53 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id kA3LClPV024869
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 15:12:48 -0600
Subject: [PATCH/RFC] Hookable IO operations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 08:12:47 +1100
Message-Id: <1162588367.10630.100.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch reworks the way iSeries hooks on PCI IO operations (both MMIO
and PIO) and provides a generic way for other platforms to do so (we
have need to do that for various other platforms).

While reworking the IO ops, I ended up doing some spring cleaning in
io.h and eeh.h which I might want to split into 2 or 3 patches (among
others, eeh.h had a lot of useless stuff in it) and I sitll need to do
hooks for the insw/insl/... versions of the ops, along with handling the
iomap case (probably by falling back to lib/iomap.c when INDIRECT_PCI_IO
is set).

A side effect is that EEH for PIO should work now (it used to pass IO
ports down to the eeh address check functions which is bogus).

Since I need that to fix some issues with Cell fairly urgently, I plan
to push that to 2.6.20 when the merge window opens, so please comment
asap :)

Oh, also, in the long run, I might also make EEH use the hooks instead
of wrapping at the toplevel, which would make things even cleaner and
relegate EEH completely in platforms/iseries, but we have to measure the
performance impact there (though it's really only on MMIO reads)

iSeries boots with that patch.

Not for merge yet, so no signed-off-yet... Diffstat is pretty nice
overall:

 arch/powerpc/Kconfig                 |    5
 arch/powerpc/kernel/setup_64.c       |   45 +++
 arch/powerpc/platforms/iseries/pci.c |  356 ++++++------------------
 include/asm-powerpc/eeh.h            |   91 ------
 include/asm-powerpc/io.h             |  506 ++++++++++++++++++-----------------
 5 files changed, 403 insertions(+), 600 deletions(-)


Index: linux-cell/include/asm-powerpc/io.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/io.h	2006-11-03 15:33:33.000000000 +1100
+++ linux-cell/include/asm-powerpc/io.h	2006-11-03 18:57:46.000000000 +1100
@@ -31,57 +31,111 @@ extern int check_legacy_ioport(unsigned 
 
 #define SLOW_DOWN_IO
 
+/*
+ *
+ * Low level MMIO accessors
+ *
+ * This provides the non-bus specific accessors to MMIO. Those are PowerPC
+ * specific and thus shouldn't be used in generic code. The accessors
+ * provided here are:
+ *
+ *	in_8, in_le16, in_be16, in_le32, in_be32, in_le64, in_be64
+ *	out_8, out_le16, out_be16, out_le32, out_be32, out_le64, out_be64
+ *	_insb, _insw_ns, _insl_ns, _outsb, _outsw_ns, _outsl_ns
+ *
+ * Those operate direction on a kernel virtual address. Note that the prototype
+ * for the out_* accessors has the arguments in opposite order from the usual
+ * linux PCI accessors. Unlike those, they take the address first and the value
+ * next.
+ *
+ * Note: I might drop the _ns suffix on the stream operations soon as it is
+ * simply normal for stream operations to not swap in the first place.
+ *
+ */
+
+#define DEF_MMIO_IN(name, type, insn)					\
+static inline type in_##name(const volatile type __iomem *addr)		\
+{									\
+	type ret;							\
+	__asm__ __volatile__("sync;" insn ";twi 0,%0,0;isync"		\
+ 		: "=r" (ret) : "r" (addr), "m" (*addr));		\
+	return ret;							\
+}
+
+#define DEF_MMIO_OUT(name, type, insn)					\
+static inline void out_##name(volatile type __iomem *addr, type val)	\
+{									\
+	__asm__ __volatile__("sync;" insn				\
+ 		: "=m" (*addr) : "r" (val), "r" (addr));		\
+	get_paca()->io_sync = 1;					\
+}
+
+
+#define DEF_MMIO_IN_BE(pfx, size, insn) \
+	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)"%U2%X2 %0,%2")
+#define DEF_MMIO_IN_LE(pfx, size, insn) \
+	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)" %0,0,%1")
+
+#define DEF_MMIO_OUT_BE(pfx, size, insn) \
+	DEF_MMIO_OUT(pfx##size, u##size, __stringify(insn)"%U0%X0 %1,%0")
+#define DEF_MMIO_OUT_LE(pfx, size, insn) \
+	DEF_MMIO_OUT(pfx##size, u##size, __stringify(insn)" %1,0,%2")
+
+DEF_MMIO_IN_BE(  ,  8, lbz);
+DEF_MMIO_IN_BE(be, 16, lhz);
+DEF_MMIO_IN_BE(be, 32, lwz);
+DEF_MMIO_IN_BE(be, 64, ld);
+DEF_MMIO_IN_LE(le, 16, lhbrx);
+DEF_MMIO_IN_LE(le, 32, lwbrx);
+
+DEF_MMIO_OUT_BE(  ,  8, stb);
+DEF_MMIO_OUT_BE(be, 16, sth);
+DEF_MMIO_OUT_BE(be, 32, stw);
+DEF_MMIO_OUT_BE(be, 64, std);
+DEF_MMIO_OUT_LE(le, 16, sthbrx);
+DEF_MMIO_OUT_LE(le, 32, stwbrx);
+
+/* There is no asm instructions for 64 bits reverse loads and stores */
+static inline u64 in_le64(const volatile u64 __iomem *addr)
+{
+	return le64_to_cpu(in_le64(addr));
+}
+
+static inline void out_le64(volatile u64 __iomem *addr, u64 val)
+{
+	out_le64(addr, cpu_to_le64(val));
+}
+
+/*
+ * IO stream instructions are defined out of line
+ */
+extern void _insb(volatile u8 __iomem *port, void *buf, long count);
+extern void _outsb(volatile u8 __iomem *port, const void *buf, long count);
+extern void _insw_ns(volatile u16 __iomem *port, void *buf, long count);
+extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, long count);
+extern void _insl_ns(volatile u32 __iomem *port, void *buf, long count);
+extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, long count);
+
+
+
+/*
+ *
+ * PCI and standard ISA accessors
+ *
+ * Those are globally defined linux accessors for devices on PCI or ISA
+ * busses. They follow the Linux defined semantics. The current implementation
+ * for PowerPC is as close as possible to the x86 version of these, and thus
+ * provides fairly heavy weight barriers for the non-raw versions
+ *
+ */
+
 extern unsigned long isa_io_base;
 extern unsigned long pci_io_base;
 
-#ifdef CONFIG_PPC_ISERIES
 
-extern int in_8(const volatile unsigned char __iomem *addr);
-extern void out_8(volatile unsigned char __iomem *addr, int val);
-extern int in_le16(const volatile unsigned short __iomem *addr);
-extern int in_be16(const volatile unsigned short __iomem *addr);
-extern void out_le16(volatile unsigned short __iomem *addr, int val);
-extern void out_be16(volatile unsigned short __iomem *addr, int val);
-extern unsigned in_le32(const volatile unsigned __iomem *addr);
-extern unsigned in_be32(const volatile unsigned __iomem *addr);
-extern void out_le32(volatile unsigned __iomem *addr, int val);
-extern void out_be32(volatile unsigned __iomem *addr, int val);
-extern unsigned long in_le64(const volatile unsigned long __iomem *addr);
-extern unsigned long in_be64(const volatile unsigned long __iomem *addr);
-extern void out_le64(volatile unsigned long __iomem *addr, unsigned long val);
-extern void out_be64(volatile unsigned long __iomem *addr, unsigned long val);
-
-extern unsigned char __raw_readb(const volatile void __iomem *addr);
-extern unsigned short __raw_readw(const volatile void __iomem *addr);
-extern unsigned int __raw_readl(const volatile void __iomem *addr);
-extern unsigned long __raw_readq(const volatile void __iomem *addr);
-extern void __raw_writeb(unsigned char v, volatile void __iomem *addr);
-extern void __raw_writew(unsigned short v, volatile void __iomem *addr);
-extern void __raw_writel(unsigned int v, volatile void __iomem *addr);
-extern void __raw_writeq(unsigned long v, volatile void __iomem *addr);
-
-extern void memset_io(volatile void __iomem *addr, int c, unsigned long n);
-extern void memcpy_fromio(void *dest, const volatile void __iomem *src,
-                                 unsigned long n);
-extern void memcpy_toio(volatile void __iomem *dest, const void *src,
-                                 unsigned long n);
-
-#else /* CONFIG_PPC_ISERIES */
-
-#define in_8(addr)		__in_8((addr))
-#define out_8(addr, val)	__out_8((addr), (val))
-#define in_le16(addr)		__in_le16((addr))
-#define in_be16(addr)		__in_be16((addr))
-#define out_le16(addr, val)	__out_le16((addr), (val))
-#define out_be16(addr, val)	__out_be16((addr), (val))
-#define in_le32(addr)		__in_le32((addr))
-#define in_be32(addr)		__in_be32((addr))
-#define out_le32(addr, val)	__out_le32((addr), (val))
-#define out_be32(addr, val)	__out_be32((addr), (val))
-#define in_le64(addr)		__in_le64((addr))
-#define in_be64(addr)		__in_be64((addr))
-#define out_le64(addr, val)	__out_le64((addr), (val))
-#define out_be64(addr, val)	__out_be64((addr), (val))
+/*
+ * Non ordered and non-swapping "raw" accessors
+ */
 
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
 {
@@ -115,17 +169,133 @@ static inline void __raw_writeq(unsigned
 {
 	*(volatile unsigned long __force *)addr = v;
 }
-#define memset_io(a,b,c)	eeh_memset_io((a),(b),(c))
-#define memcpy_fromio(a,b,c)	eeh_memcpy_fromio((a),(b),(c))
-#define memcpy_toio(a,b,c)	eeh_memcpy_toio((a),(b),(c))
 
-#endif /* CONFIG_PPC_ISERIES */
+
+/*
+ * PCI IO accessors.
+ *
+ * Right now, we still use the eeh versions inline but that might change
+ * as EEH can use the new hook mecanism, provided it doesn't impact
+ * performances too much
+ */
+
+#include <asm/eeh.h>
+
+#define DEF_PCI_DT_b		u8
+#define DEF_PCI_DT_w		u16
+#define DEF_PCI_DT_l		u32
+#define DEF_PCI_DT_q		u64
+
+#define __do_writeb(val, addr)	out_8(addr, val)
+#define __do_writew(val, addr)	out_le16(addr, val)
+#define __do_writel(val, addr)	out_le32(addr, val)
+#define __do_writeq(val, addr)	out_le64(addr, val)
+
+#ifdef CONFIG_PPC_INDIRECT_IO
+#define DEF_PCI_HOOK(x)		x
+#else
+#define DEF_PCI_HOOK(x)		NULL
+#endif
+
+#define DEF_PCI_AC_IN_MMIO(ts)							\
+extern DEF_PCI_DT_##ts (*__ind_read##ts)(const volatile void __iomem * addr);	\
+static inline DEF_PCI_DT_##ts read##ts(const volatile void __iomem * addr)	\
+{										\
+	if (DEF_PCI_HOOK(__ind_read##ts) != NULL)				\
+		return __ind_read##ts(addr);					\
+	return eeh_read##ts(addr);						\
+}
+
+#define DEF_PCI_AC_IN_PIO(ts)							\
+extern DEF_PCI_DT_##ts (*__ind_in##ts)(unsigned long port);			\
+static inline DEF_PCI_DT_##ts in##ts(unsigned long port)	       		\
+{										\
+	if (DEF_PCI_HOOK(__ind_in##ts) != NULL)					\
+		return __ind_in##ts(port);					\
+	return read##ts((void __iomem *)pci_io_base + port);			\
+}
+
+#define DEF_PCI_AC_OUT_MMIO(ts)							\
+extern void (*__ind_write##ts)(DEF_PCI_DT_##ts val,				\
+			       volatile void __iomem *addr);			\
+static inline void write##ts(DEF_PCI_DT_##ts val, volatile void __iomem *addr)	\
+{										\
+	if (DEF_PCI_HOOK(__ind_write##ts) != NULL)				\
+		__ind_write##ts(val, addr);					\
+	else									\
+		__do_write##ts(val, addr);					\
+}
+
+#define DEF_PCI_AC_OUT_PIO(ts)							\
+extern void (*__ind_out##ts)(DEF_PCI_DT_##ts val, unsigned long port);		\
+static inline void out##ts(DEF_PCI_DT_##ts val, unsigned long port)		\
+{										\
+	if (DEF_PCI_HOOK(__ind_out##ts) != NULL)				\
+		__ind_out##ts(val, port);					\
+	else									\
+		write##ts(val, (void __iomem *)pci_io_base + port);		\
+}
+
+#define DEF_PCI_AC_MMIO(ts, dir)	DEF_PCI_AC_##dir##_MMIO(ts)
+#define DEF_PCI_AC_PIO(ts, dir)		DEF_PCI_AC_##dir##_PIO(ts)
+
+#define DEF_PCI_AC(ts, dir)		DEF_PCI_AC_MMIO(ts, dir)		\
+					DEF_PCI_AC_PIO(ts, dir)
+DEF_PCI_AC(b, IN)
+DEF_PCI_AC(w, IN)
+DEF_PCI_AC(l, IN)
+DEF_PCI_AC_MMIO(q, IN)
+DEF_PCI_AC(b, OUT)
+DEF_PCI_AC(w, OUT)
+DEF_PCI_AC(l, OUT)
+DEF_PCI_AC_MMIO(q, OUT)
+
+/* We still use EEH versions for now. Ultimately, we might just get rid of
+ * EEH in here and use it as a set of __memset_io etc... hooks
+ */
+
+extern void (*__memset_io)(volatile void __iomem *addr, int c,
+			   unsigned long n);
+extern void (*__memcpy_fromio)(void *dest, const volatile void __iomem *src,
+			       unsigned long n);
+extern void (*__memcpy_toio)(volatile void __iomem *dest, const void *src,
+			     unsigned long n);
+
+static inline void memset_io(volatile void __iomem *addr, int c,
+			     unsigned long n)
+{
+	if (DEF_PCI_HOOK(__memset_io))
+		__memset_io(addr, c, n);
+	else
+		eeh_memset_io(addr, c, n);
+}
+
+static inline void memcpy_fromio(void *dest, const volatile void __iomem *src,
+				 unsigned long n)
+{
+	if (DEF_PCI_HOOK(__memcpy_fromio))
+		__memcpy_fromio(dest, src, n);
+	else
+		eeh_memcpy_fromio(dest, src, n);
+}
+
+static inline void memcpy_toio(volatile void __iomem *dest, const void *src,
+			       unsigned long n)
+{
+	if (DEF_PCI_HOOK(__memcpy_toio))
+		__memcpy_toio(dest, src, n);
+	else
+		eeh_memcpy_toio(dest, src, n);
+}
 
 /*
  * The insw/outsw/insl/outsl macros don't do byte-swapping.
  * They are only used in practice for transferring buffers which
  * are arrays of bytes, and byte-swapping is not appropriate in
- * that case.  - paulus */
+ * that case.  - paulus
+ *
+ * We need to add hooking mecanisms to these
+ */
 #define insb(port, buf, ns)	eeh_insb((port), (buf), (ns))
 #define insw(port, buf, ns)	eeh_insw_ns((port), (buf), (ns))
 #define insl(port, buf, nl)	eeh_insl_ns((port), (buf), (nl))
@@ -134,33 +304,39 @@ static inline void __raw_writeq(unsigned
 #define outsw(port, buf, ns)  _outsw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define outsl(port, buf, nl)  _outsl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 
-#define readb(addr)		eeh_readb(addr)
-#define readw(addr)		eeh_readw(addr)
-#define readl(addr)		eeh_readl(addr)
-#define readq(addr)		eeh_readq(addr)
-#define writeb(data, addr)	eeh_writeb((data), (addr))
-#define writew(data, addr)	eeh_writew((data), (addr))
-#define writel(data, addr)	eeh_writel((data), (addr))
-#define writeq(data, addr)	eeh_writeq((data), (addr))
-#define inb(port)		eeh_inb((unsigned long)port)
-#define outb(val, port)		eeh_outb(val, (unsigned long)port)
-#define inw(port)		eeh_inw((unsigned long)port)
-#define outw(val, port)		eeh_outw(val, (unsigned long)port)
-#define inl(port)		eeh_inl((unsigned long)port)
-#define outl(val, port)		eeh_outl(val, (unsigned long)port)
 
+
+/* Nothing to do */
+
+#define dma_cache_inv(_start,_size)		do { } while (0)
+#define dma_cache_wback(_start,_size)		do { } while (0)
+#define dma_cache_wback_inv(_start,_size)	do { } while (0)
+
+
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
+/*
+ * We don't do relaxed operations yet, at least not with this semantic
+ */
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
 #define readq_relaxed(addr) readq(addr)
 
-extern void _insb(volatile u8 __iomem *port, void *buf, long count);
-extern void _outsb(volatile u8 __iomem *port, const void *buf, long count);
-extern void _insw_ns(volatile u16 __iomem *port, void *buf, long count);
-extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, long count);
-extern void _insl_ns(volatile u32 __iomem *port, void *buf, long count);
-extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, long count);
-
+/*
+ * Enforce synchronisation of stores vs. spin_unlock
+ * (this does it explicitely, though our implementation of spin_unlock
+ * does it implicitely too)
+ */
 static inline void mmiowb(void)
 {
 	unsigned long tmp;
@@ -170,6 +346,19 @@ static inline void mmiowb(void)
 	: "memory");
 }
 
+static inline void iosync(void)
+{
+        __asm__ __volatile__ ("sync" : : : "memory");
+}
+
+/* Enforce in-order execution of data I/O.
+ * No distinction between read/write on PPC; use eieio for all three.
+ */
+#define iobarrier_rw() eieio()
+#define iobarrier_r()  eieio()
+#define iobarrier_w()  eieio()
+
+
 /*
  * output pause versions need a delay at least for the
  * w83c105 ide controller in a p610.
@@ -254,177 +443,6 @@ static inline void * phys_to_virt(unsign
  */
 #define BIO_VMERGE_BOUNDARY	0
 
-static inline void iosync(void)
-{
-        __asm__ __volatile__ ("sync" : : : "memory");
-}
-
-/* Enforce in-order execution of data I/O. 
- * No distinction between read/write on PPC; use eieio for all three.
- */
-#define iobarrier_rw() eieio()
-#define iobarrier_r()  eieio()
-#define iobarrier_w()  eieio()
-
-/*
- * 8, 16 and 32 bit, big and little endian I/O operations, with barrier.
- * These routines do not perform EEH-related I/O address translation,
- * and should not be used directly by device drivers.  Use inb/readb
- * instead.
- */
-static inline int __in_8(const volatile unsigned char __iomem *addr)
-{
-	int ret;
-
-	__asm__ __volatile__("sync; lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "m" (*addr));
-	return ret;
-}
-
-static inline void __out_8(volatile unsigned char __iomem *addr, int val)
-{
-	__asm__ __volatile__("sync; stb%U0%X0 %1,%0"
-			     : "=m" (*addr) : "r" (val));
-	get_paca()->io_sync = 1;
-}
-
-static inline int __in_le16(const volatile unsigned short __iomem *addr)
-{
-	int ret;
-
-	__asm__ __volatile__("sync; lhbrx %0,0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "r" (addr), "m" (*addr));
-	return ret;
-}
-
-static inline int __in_be16(const volatile unsigned short __iomem *addr)
-{
-	int ret;
-
-	__asm__ __volatile__("sync; lhz%U1%X1 %0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "m" (*addr));
-	return ret;
-}
-
-static inline void __out_le16(volatile unsigned short __iomem *addr, int val)
-{
-	__asm__ __volatile__("sync; sthbrx %1,0,%2"
-			     : "=m" (*addr) : "r" (val), "r" (addr));
-	get_paca()->io_sync = 1;
-}
-
-static inline void __out_be16(volatile unsigned short __iomem *addr, int val)
-{
-	__asm__ __volatile__("sync; sth%U0%X0 %1,%0"
-			     : "=m" (*addr) : "r" (val));
-	get_paca()->io_sync = 1;
-}
-
-static inline unsigned __in_le32(const volatile unsigned __iomem *addr)
-{
-	unsigned ret;
-
-	__asm__ __volatile__("sync; lwbrx %0,0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "r" (addr), "m" (*addr));
-	return ret;
-}
-
-static inline unsigned __in_be32(const volatile unsigned __iomem *addr)
-{
-	unsigned ret;
-
-	__asm__ __volatile__("sync; lwz%U1%X1 %0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "m" (*addr));
-	return ret;
-}
-
-static inline void __out_le32(volatile unsigned __iomem *addr, int val)
-{
-	__asm__ __volatile__("sync; stwbrx %1,0,%2" : "=m" (*addr)
-			     : "r" (val), "r" (addr));
-	get_paca()->io_sync = 1;
-}
-
-static inline void __out_be32(volatile unsigned __iomem *addr, int val)
-{
-	__asm__ __volatile__("sync; stw%U0%X0 %1,%0"
-			     : "=m" (*addr) : "r" (val));
-	get_paca()->io_sync = 1;
-}
-
-static inline unsigned long __in_le64(const volatile unsigned long __iomem *addr)
-{
-	unsigned long tmp, ret;
-
-	__asm__ __volatile__(
-			     "sync\n"
-			     "ld %1,0(%2)\n"
-			     "twi 0,%1,0\n"
-			     "isync\n"
-			     "rldimi %0,%1,5*8,1*8\n"
-			     "rldimi %0,%1,3*8,2*8\n"
-			     "rldimi %0,%1,1*8,3*8\n"
-			     "rldimi %0,%1,7*8,4*8\n"
-			     "rldicl %1,%1,32,0\n"
-			     "rlwimi %0,%1,8,8,31\n"
-			     "rlwimi %0,%1,24,16,23\n"
-			     : "=r" (ret) , "=r" (tmp) : "b" (addr) , "m" (*addr));
-	return ret;
-}
-
-static inline unsigned long __in_be64(const volatile unsigned long __iomem *addr)
-{
-	unsigned long ret;
-
-	__asm__ __volatile__("sync; ld%U1%X1 %0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "m" (*addr));
-	return ret;
-}
-
-static inline void __out_le64(volatile unsigned long __iomem *addr, unsigned long val)
-{
-	unsigned long tmp;
-
-	__asm__ __volatile__(
-			     "rldimi %0,%1,5*8,1*8\n"
-			     "rldimi %0,%1,3*8,2*8\n"
-			     "rldimi %0,%1,1*8,3*8\n"
-			     "rldimi %0,%1,7*8,4*8\n"
-			     "rldicl %1,%1,32,0\n"
-			     "rlwimi %0,%1,8,8,31\n"
-			     "rlwimi %0,%1,24,16,23\n"
-			     "sync\n"
-			     "std %0,0(%3)"
-			     : "=&r" (tmp) , "=&r" (val) : "1" (val) , "b" (addr) , "m" (*addr));
-	get_paca()->io_sync = 1;
-}
-
-static inline void __out_be64(volatile unsigned long __iomem *addr, unsigned long val)
-{
-	__asm__ __volatile__("sync; std%U0%X0 %1,%0" : "=m" (*addr) : "r" (val));
-	get_paca()->io_sync = 1;
-}
-
-#include <asm/eeh.h>
-
-/* Nothing to do */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
-
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 #endif /* __KERNEL__ */
 
 #endif /* CONFIG_PPC64 */
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2006-11-03 15:33:33.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig	2006-11-03 15:52:58.000000000 +1100
@@ -389,6 +389,7 @@ config PPC_PSERIES
 config PPC_ISERIES
 	bool "IBM Legacy iSeries"
 	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_INDIRECT_IO
 
 config PPC_CHRP
 	bool "Common Hardware Reference Platform (CHRP) based machines"
@@ -534,6 +535,10 @@ config PPC_970_NAP
 	bool
 	default n
 
+config PPC_INDIRECT_IO
+	bool
+	default n
+
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_PMAC
Index: linux-cell/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup_64.c	2006-11-03 15:52:54.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/setup_64.c	2006-11-03 18:51:14.000000000 +1100
@@ -599,3 +599,48 @@ void __init setup_per_cpu_areas(void)
 	}
 }
 #endif
+
+
+#ifdef CONFIG_PPC_INDIRECT_IO
+
+#define EXP_PCI_AC_IN_MMIO(ts)						\
+DEF_PCI_DT_##ts (*__ind_read##ts)(const volatile void __iomem * addr);	\
+EXPORT_SYMBOL(__ind_read##ts);
+
+#define EXP_PCI_AC_IN_PIO(ts)						\
+DEF_PCI_DT_##ts (*__ind_in##ts)(unsigned long port);			\
+EXPORT_SYMBOL(__ind_in##ts);
+
+#define EXP_PCI_AC_OUT_MMIO(ts)						\
+void (*__ind_write##ts)(DEF_PCI_DT_##ts val,				\
+			volatile void __iomem *addr);			\
+EXPORT_SYMBOL(__ind_write##ts);
+
+#define EXP_PCI_AC_OUT_PIO(ts)						\
+void (*__ind_out##ts)(DEF_PCI_DT_##ts val, unsigned long port);		\
+EXPORT_SYMBOL(__ind_out##ts);
+
+#define EXP_PCI_AC_MMIO(ts, dir)	EXP_PCI_AC_##dir##_MMIO(ts)
+#define EXP_PCI_AC_PIO(ts, dir)		EXP_PCI_AC_##dir##_PIO(ts)
+
+#define EXP_PCI_AC(ts, dir)		EXP_PCI_AC_MMIO(ts, dir)	\
+					EXP_PCI_AC_PIO(ts, dir)
+EXP_PCI_AC(b, IN)
+EXP_PCI_AC(w, IN)
+EXP_PCI_AC(l, IN)
+EXP_PCI_AC_MMIO(q, IN)
+EXP_PCI_AC(b, OUT)
+EXP_PCI_AC(w, OUT)
+EXP_PCI_AC(l, OUT)
+EXP_PCI_AC_MMIO(q, OUT)
+
+void (*__memset_io)(volatile void __iomem *addr, int c, unsigned long n);
+void (*__memcpy_fromio)(void *dest, const volatile void __iomem *src,
+			unsigned long n);
+void (*__memcpy_toio)(volatile void __iomem *dest, const void *src,
+		      unsigned long n);
+EXPORT_SYMBOL(__memset_io);
+EXPORT_SYMBOL(__memcpy_fromio);
+EXPORT_SYMBOL(__memcpy_toio);
+#endif /* CONFIG_PPC_INDIRECT_IO */
+
Index: linux-cell/arch/powerpc/platforms/iseries/pci.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/iseries/pci.c	2006-11-03 15:37:23.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/iseries/pci.c	2006-11-03 18:54:13.000000000 +1100
@@ -156,53 +156,6 @@ static void pci_Log_Error(char *Error_Te
 }
 
 /*
- * iSeries_pcibios_init
- *
- * Description:
- *   This function checks for all possible system PCI host bridges that connect
- *   PCI buses.  The system hypervisor is queried as to the guest partition
- *   ownership status.  A pci_controller is built for any bus which is partially
- *   owned or fully owned by this guest partition.
- */
-void iSeries_pcibios_init(void)
-{
-	struct pci_controller *phb;
-	struct device_node *root = of_find_node_by_path("/");
-	struct device_node *node = NULL;
-
-	if (root == NULL) {
-		printk(KERN_CRIT "iSeries_pcibios_init: can't find root "
-				"of device tree\n");
-		return;
-	}
-	while ((node = of_get_next_child(root, node)) != NULL) {
-		HvBusNumber bus;
-		const u32 *busp;
-
-		if ((node->type == NULL) || (strcmp(node->type, "pci") != 0))
-			continue;
-
-		busp = get_property(node, "bus-range", NULL);
-		if (busp == NULL)
-			continue;
-		bus = *busp;
-		printk("bus %d appears to exist\n", bus);
-		phb = pcibios_alloc_controller(node);
-		if (phb == NULL)
-			continue;
-
-		phb->pci_mem_offset = phb->local_number = bus;
-		phb->first_busno = bus;
-		phb->last_busno = bus;
-		phb->ops = &iSeries_pci_ops;
-	}
-
-	of_node_put(root);
-
-	pci_devs_phb_init();
-}
-
-/*
  * iSeries_pci_final_fixup(void)
  */
 void __init iSeries_pci_final_fixup(void)
@@ -438,13 +391,9 @@ static inline struct device_node *xlate_
 /*
  * Read MM I/O Instructions for the iSeries
  * On MM I/O error, all ones are returned and iSeries_pci_IoError is cal
- * else, data is returned in big Endian format.
- *
- * iSeries_Read_Byte = Read Byte  ( 8 bit)
- * iSeries_Read_Word = Read Word  (16 bit)
- * iSeries_Read_Long = Read Long  (32 bit)
+ * else, data is returned in little Endian format.
  */
-static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
+static u8 iseries_readb(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -462,7 +411,8 @@ static u8 iSeries_Read_Byte(const volati
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO address %p\n", IoAddress);
+			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO address %p\n",
+			       IoAddress);
 		return 0xff;
 	}
 	do {
@@ -472,7 +422,7 @@ static u8 iSeries_Read_Byte(const volati
 	return (u8)ret.value;
 }
 
-static u16 iSeries_Read_Word(const volatile void __iomem *IoAddress)
+static u16 iseries_readw(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -490,7 +440,8 @@ static u16 iSeries_Read_Word(const volat
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Read_Word: invalid access at IO address %p\n", IoAddress);
+			printk(KERN_ERR "iSeries_Read_Word: invalid access at IO address %p\n",
+			       IoAddress);
 		return 0xffff;
 	}
 	do {
@@ -498,10 +449,10 @@ static u16 iSeries_Read_Word(const volat
 				BarOffset, 0);
 	} while (CheckReturnCode("RDW", DevNode, &retry, ret.rc) != 0);
 
-	return swab16((u16)ret.value);
+	return cpu_to_le16((u16)ret.value);
 }
 
-static u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
+static u32 iseries_readl(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -519,7 +470,8 @@ static u32 iSeries_Read_Long(const volat
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Read_Long: invalid access at IO address %p\n", IoAddress);
+			printk(KERN_ERR "iSeries_Read_Long: invalid access at IO address %p\n",
+			       IoAddress);
 		return 0xffffffff;
 	}
 	do {
@@ -527,17 +479,14 @@ static u32 iSeries_Read_Long(const volat
 				BarOffset, 0);
 	} while (CheckReturnCode("RDL", DevNode, &retry, ret.rc) != 0);
 
-	return swab32((u32)ret.value);
+	return cpu_to_le32((u32)ret.value);
 }
 
 /*
  * Write MM I/O Instructions for the iSeries
  *
- * iSeries_Write_Byte = Write Byte (8 bit)
- * iSeries_Write_Word = Write Word(16 bit)
- * iSeries_Write_Long = Write Long(32 bit)
  */
-static void iSeries_Write_Byte(u8 data, volatile void __iomem *IoAddress)
+static void iseries_writeb(u8 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -563,7 +512,7 @@ static void iSeries_Write_Byte(u8 data, 
 	} while (CheckReturnCode("WWB", DevNode, &retry, rc) != 0);
 }
 
-static void iSeries_Write_Word(u16 data, volatile void __iomem *IoAddress)
+static void iseries_writew(u16 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -581,15 +530,16 @@ static void iSeries_Write_Word(u16 data,
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Write_Word: invalid access at IO address %p\n", IoAddress);
+			printk(KERN_ERR "iSeries_Write_Word: invalid access at IO address %p\n",
+			       IoAddress);
 		return;
 	}
 	do {
-		rc = HvCall4(HvCallPciBarStore16, dsa, BarOffset, swab16(data), 0);
+		rc = HvCall4(HvCallPciBarStore16, dsa, BarOffset, le16_to_cpu(data), 0);
 	} while (CheckReturnCode("WWW", DevNode, &retry, rc) != 0);
 }
 
-static void iSeries_Write_Long(u32 data, volatile void __iomem *IoAddress)
+static void iseries_writel(u32 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -607,231 +557,107 @@ static void iSeries_Write_Long(u32 data,
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Write_Long: invalid access at IO address %p\n", IoAddress);
+			printk(KERN_ERR "iSeries_Write_Long: invalid access at IO address %p\n",
+			       IoAddress);
 		return;
 	}
 	do {
-		rc = HvCall4(HvCallPciBarStore32, dsa, BarOffset, swab32(data), 0);
+		rc = HvCall4(HvCallPciBarStore32, dsa, BarOffset, le32_to_cpu(data), 0);
 	} while (CheckReturnCode("WWL", DevNode, &retry, rc) != 0);
 }
 
-extern unsigned char __raw_readb(const volatile void __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	return *(volatile unsigned char __force *)addr;
-}
-EXPORT_SYMBOL(__raw_readb);
-
-extern unsigned short __raw_readw(const volatile void __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	return *(volatile unsigned short __force *)addr;
-}
-EXPORT_SYMBOL(__raw_readw);
-
-extern unsigned int __raw_readl(const volatile void __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	return *(volatile unsigned int __force *)addr;
-}
-EXPORT_SYMBOL(__raw_readl);
-
-extern unsigned long __raw_readq(const volatile void __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	return *(volatile unsigned long __force *)addr;
-}
-EXPORT_SYMBOL(__raw_readq);
-
-extern void __raw_writeb(unsigned char v, volatile void __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	*(volatile unsigned char __force *)addr = v;
-}
-EXPORT_SYMBOL(__raw_writeb);
-
-extern void __raw_writew(unsigned short v, volatile void __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	*(volatile unsigned short __force *)addr = v;
-}
-EXPORT_SYMBOL(__raw_writew);
-
-extern void __raw_writel(unsigned int v, volatile void __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	*(volatile unsigned int __force *)addr = v;
-}
-EXPORT_SYMBOL(__raw_writel);
-
-extern void __raw_writeq(unsigned long v, volatile void __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	*(volatile unsigned long __force *)addr = v;
-}
-EXPORT_SYMBOL(__raw_writeq);
-
-int in_8(const volatile unsigned char __iomem *addr)
+static void iseries_memset_io(volatile void __iomem *addr, int c, unsigned long n)
 {
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		return iSeries_Read_Byte(addr);
-	return __in_8(addr);
-}
-EXPORT_SYMBOL(in_8);
-
-void out_8(volatile unsigned char __iomem *addr, int val)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		iSeries_Write_Byte(val, addr);
-	else
-		__out_8(addr, val);
-}
-EXPORT_SYMBOL(out_8);
-
-int in_le16(const volatile unsigned short __iomem *addr)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		return iSeries_Read_Word(addr);
-	return __in_le16(addr);
-}
-EXPORT_SYMBOL(in_le16);
-
-int in_be16(const volatile unsigned short __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	return __in_be16(addr);
-}
-EXPORT_SYMBOL(in_be16);
-
-void out_le16(volatile unsigned short __iomem *addr, int val)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		iSeries_Write_Word(val, addr);
-	else
-		__out_le16(addr, val);
-}
-EXPORT_SYMBOL(out_le16);
-
-void out_be16(volatile unsigned short __iomem *addr, int val)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	__out_be16(addr, val);
-}
-EXPORT_SYMBOL(out_be16);
-
-unsigned in_le32(const volatile unsigned __iomem *addr)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		return iSeries_Read_Long(addr);
-	return __in_le32(addr);
-}
-EXPORT_SYMBOL(in_le32);
-
-unsigned in_be32(const volatile unsigned __iomem *addr)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	return __in_be32(addr);
-}
-EXPORT_SYMBOL(in_be32);
+	volatile char __iomem *d = addr;
 
-void out_le32(volatile unsigned __iomem *addr, int val)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		iSeries_Write_Long(val, addr);
-	else
-		__out_le32(addr, val);
+	while (n-- > 0)
+		iseries_writeb(c, d++);
 }
-EXPORT_SYMBOL(out_le32);
 
-void out_be32(volatile unsigned __iomem *addr, int val)
+static void iseries_memcpy_fromio(void *dest, const volatile void __iomem *src,
+				  unsigned long n)
 {
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
+	char *d = dest;
+	const volatile char __iomem *s = src;
 
-	__out_be32(addr, val);
+	while (n-- > 0)
+		*d++ = iseries_readb(s++);
 }
-EXPORT_SYMBOL(out_be32);
 
-unsigned long in_le64(const volatile unsigned long __iomem *addr)
+static void iseries_memcpy_toio(volatile void __iomem *dest, const void *src,
+				unsigned long n)
 {
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
+	const char *s = src;
+	volatile char __iomem *d = dest;
 
-	return __in_le64(addr);
+	while (n-- > 0)
+		iseries_writeb(*s++, d++);
 }
-EXPORT_SYMBOL(in_le64);
 
-unsigned long in_be64(const volatile unsigned long __iomem *addr)
+static void __init iseries_setup_io_access(void)
 {
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
-
-	return __in_be64(addr);
+	/* Note that we only set the ones we support. The other ones
+	 * are kept to their native implementation which will fault
+	 * since we are giving them tokens that match non-mapped areas.
+	 * This is as good behaviour as the BUG() we used to have
+	 */
+	__ind_readb = iseries_readb;
+	__ind_readw = iseries_readw;
+	__ind_readl = iseries_readl;
+	__ind_writeb = iseries_writeb;
+	__ind_writew = iseries_writew;
+	__ind_writel = iseries_writel;
+	__memset_io = iseries_memset_io;
+	__memcpy_fromio = iseries_memcpy_fromio;
+	__memcpy_toio = iseries_memcpy_toio;
 }
-EXPORT_SYMBOL(in_be64);
 
-void out_le64(volatile unsigned long __iomem *addr, unsigned long val)
+/*
+ * iSeries_pcibios_init
+ *
+ * Description:
+ *   This function checks for all possible system PCI host bridges that connect
+ *   PCI buses.  The system hypervisor is queried as to the guest partition
+ *   ownership status.  A pci_controller is built for any bus which is partially
+ *   owned or fully owned by this guest partition.
+ */
+void __init iSeries_pcibios_init(void)
 {
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
+	struct pci_controller *phb;
+	struct device_node *root = of_find_node_by_path("/");
+	struct device_node *node = NULL;
 
-	__out_le64(addr, val);
-}
-EXPORT_SYMBOL(out_le64);
+	iseries_setup_io_access();
 
-void out_be64(volatile unsigned long __iomem *addr, unsigned long val)
-{
-	BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES));
+	if (root == NULL) {
+		printk(KERN_CRIT "iSeries_pcibios_init: can't find root "
+				"of device tree\n");
+		return;
+	}
+	while ((node = of_get_next_child(root, node)) != NULL) {
+		HvBusNumber bus;
+		const u32 *busp;
 
-	__out_be64(addr, val);
-}
-EXPORT_SYMBOL(out_be64);
+		if ((node->type == NULL) || (strcmp(node->type, "pci") != 0))
+			continue;
 
-void memset_io(volatile void __iomem *addr, int c, unsigned long n)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		volatile char __iomem *d = addr;
+		busp = get_property(node, "bus-range", NULL);
+		if (busp == NULL)
+			continue;
+		bus = *busp;
+		printk("bus %d appears to exist\n", bus);
+		phb = pcibios_alloc_controller(node);
+		if (phb == NULL)
+			continue;
 
-		while (n-- > 0) {
-			iSeries_Write_Byte(c, d++);
-		}
-	} else
-		eeh_memset_io(addr, c, n);
-}
-EXPORT_SYMBOL(memset_io);
+		phb->pci_mem_offset = phb->local_number = bus;
+		phb->first_busno = bus;
+		phb->last_busno = bus;
+		phb->ops = &iSeries_pci_ops;
+	}
 
-void memcpy_fromio(void *dest, const volatile void __iomem *src,
-                                 unsigned long n)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		char *d = dest;
-		const volatile char __iomem *s = src;
+	of_node_put(root);
 
-		while (n-- > 0) {
-			*d++ = iSeries_Read_Byte(s++);
-		}
-	} else
-		eeh_memcpy_fromio(dest, src, n);
+	pci_devs_phb_init();
 }
-EXPORT_SYMBOL(memcpy_fromio);
 
-void memcpy_toio(volatile void __iomem *dest, const void *src, unsigned long n)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		const char *s = src;
-		volatile char __iomem *d = dest;
-
-		while (n-- > 0) {
-			iSeries_Write_Byte(*s++, d++);
-		}
-	} else
-		eeh_memcpy_toio(dest, src, n);
-}
-EXPORT_SYMBOL(memcpy_toio);
Index: linux-cell/include/asm-powerpc/eeh.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/eeh.h	2006-10-06 13:48:23.000000000 +1000
+++ linux-cell/include/asm-powerpc/eeh.h	2006-11-03 18:25:21.000000000 +1100
@@ -120,10 +120,6 @@ static inline u8 eeh_readb(const volatil
 		return eeh_check_failure(addr, val);
 	return val;
 }
-static inline void eeh_writeb(u8 val, volatile void __iomem *addr)
-{
-	out_8(addr, val);
-}
 
 static inline u16 eeh_readw(const volatile void __iomem *addr)
 {
@@ -132,21 +128,6 @@ static inline u16 eeh_readw(const volati
 		return eeh_check_failure(addr, val);
 	return val;
 }
-static inline void eeh_writew(u16 val, volatile void __iomem *addr)
-{
-	out_le16(addr, val);
-}
-static inline u16 eeh_raw_readw(const volatile void __iomem *addr)
-{
-	u16 val = in_be16(addr);
-	if (EEH_POSSIBLE_ERROR(val, u16))
-		return eeh_check_failure(addr, val);
-	return val;
-}
-static inline void eeh_raw_writew(u16 val, volatile void __iomem *addr) {
-	volatile u16 __iomem *vaddr = (volatile u16 __iomem *) addr;
-	out_be16(vaddr, val);
-}
 
 static inline u32 eeh_readl(const volatile void __iomem *addr)
 {
@@ -155,21 +136,6 @@ static inline u32 eeh_readl(const volati
 		return eeh_check_failure(addr, val);
 	return val;
 }
-static inline void eeh_writel(u32 val, volatile void __iomem *addr)
-{
-	out_le32(addr, val);
-}
-static inline u32 eeh_raw_readl(const volatile void __iomem *addr)
-{
-	u32 val = in_be32(addr);
-	if (EEH_POSSIBLE_ERROR(val, u32))
-		return eeh_check_failure(addr, val);
-	return val;
-}
-static inline void eeh_raw_writel(u32 val, volatile void __iomem *addr)
-{
-	out_be32(addr, val);
-}
 
 static inline u64 eeh_readq(const volatile void __iomem *addr)
 {
@@ -178,21 +144,6 @@ static inline u64 eeh_readq(const volati
 		return eeh_check_failure(addr, val);
 	return val;
 }
-static inline void eeh_writeq(u64 val, volatile void __iomem *addr)
-{
-	out_le64(addr, val);
-}
-static inline u64 eeh_raw_readq(const volatile void __iomem *addr)
-{
-	u64 val = in_be64(addr);
-	if (EEH_POSSIBLE_ERROR(val, u64))
-		return eeh_check_failure(addr, val);
-	return val;
-}
-static inline void eeh_raw_writeq(u64 val, volatile void __iomem *addr)
-{
-	out_be64(addr, val);
-}
 
 #define EEH_CHECK_ALIGN(v,a) \
 	((((unsigned long)(v)) & ((a) - 1)) == 0)
@@ -292,48 +243,6 @@ static inline void eeh_memcpy_toio(volat
 
 #undef EEH_CHECK_ALIGN
 
-static inline u8 eeh_inb(unsigned long port)
-{
-	u8 val;
-	val = in_8((u8 __iomem *)(port+pci_io_base));
-	if (EEH_POSSIBLE_ERROR(val, u8))
-		return eeh_check_failure((void __iomem *)(port), val);
-	return val;
-}
-
-static inline void eeh_outb(u8 val, unsigned long port)
-{
-	out_8((u8 __iomem *)(port+pci_io_base), val);
-}
-
-static inline u16 eeh_inw(unsigned long port)
-{
-	u16 val;
-	val = in_le16((u16 __iomem *)(port+pci_io_base));
-	if (EEH_POSSIBLE_ERROR(val, u16))
-		return eeh_check_failure((void __iomem *)(port), val);
-	return val;
-}
-
-static inline void eeh_outw(u16 val, unsigned long port)
-{
-	out_le16((u16 __iomem *)(port+pci_io_base), val);
-}
-
-static inline u32 eeh_inl(unsigned long port)
-{
-	u32 val;
-	val = in_le32((u32 __iomem *)(port+pci_io_base));
-	if (EEH_POSSIBLE_ERROR(val, u32))
-		return eeh_check_failure((void __iomem *)(port), val);
-	return val;
-}
-
-static inline void eeh_outl(u32 val, unsigned long port)
-{
-	out_le32((u32 __iomem *)(port+pci_io_base), val);
-}
-
 /* in-string eeh macros */
 static inline void eeh_insb(unsigned long port, void * buf, int ns)
 {
