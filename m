Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4692DDF16B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 22:39:09 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 37/60] microblaze_v4: io.h IO operations
Date: Thu, 26 Jun 2008 14:30:06 +0200
Message-Id: <1214483429-32360-38-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-37-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<1214483429-32360-14-git-send-email-monstr@seznam.cz>
	<1214483429-32360-15-git-send-email-monstr@seznam.cz>
	<1214483429-32360-16-git-send-email-monstr@seznam.cz>
	<1214483429-32360-17-git-send-email-monstr@seznam.cz>
	<1214483429-32360-18-git-send-email-monstr@seznam.cz>
	<1214483429-32360-19-git-send-email-monstr@seznam.cz>
	<1214483429-32360-20-git-send-email-monstr@seznam.cz>
	<1214483429-32360-21-git-send-email-monstr@seznam.cz>
	<1214483429-32360-22-git-send-email-monstr@seznam.cz>
	<1214483429-32360-23-git-send-email-monstr@seznam.cz>
	<1214483429-32360-24-git-send-email-monstr@seznam.cz>
	<1214483429-32360-25-git-send-email-monstr@seznam.cz>
	<1214483429-32360-26-git-send-email-monstr@seznam.cz>
	<1214483429-32360-27-git-send-email-monstr@seznam.cz>
	<1214483429-32360-28-git-send-email-monstr@seznam.cz>
	<1214483429-32360-29-git-send-email-monstr@seznam.cz>
	<1214483429-32360-30-git-send-email-monstr@seznam.cz>
	<1214483429-32360-31-git-send-email-monstr@seznam.cz>
	<1214483429-32360-32-git-send-email-monstr@seznam.cz>
	<1214483429-32360-33-git-send-email-monstr@seznam.cz>
	<1214483429-32360-34-git-send-email-monstr@seznam.cz>
	<1214483429-32360-35-git-send-email-monstr@seznam.cz>
	<1214483429-32360-36-git-send-email-monstr@seznam.cz>
	<1214483429-32360-37-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>


Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 include/asm-microblaze/io.h |  208 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 208 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-microblaze/io.h

diff --git a/include/asm-microblaze/io.h b/include/asm-microblaze/io.h
new file mode 100644
index 0000000..cb0a178
--- /dev/null
+++ b/include/asm-microblaze/io.h
@@ -0,0 +1,208 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_IO_H
+#define _ASM_MICROBLAZE_IO_H
+
+#include <asm/byteorder.h>
+#include <asm/page.h>
+
+static inline unsigned char __raw_readb(const volatile void *addr)
+{
+	return *(volatile unsigned char __force *)addr;
+}
+static inline unsigned short __raw_readw(const volatile void *addr)
+{
+	return *(volatile unsigned short __force *)addr;
+}
+static inline unsigned int __raw_readl(const volatile void *addr)
+{
+	return *(volatile unsigned int __force *)addr;
+}
+static inline unsigned long __raw_readq(const volatile void *addr)
+{
+	return *(volatile unsigned long __force *)addr;
+}
+static inline void __raw_writeb(unsigned char v, volatile void *addr)
+{
+	*(volatile unsigned char __force *)addr = v;
+}
+static inline void __raw_writew(unsigned short v, volatile void *addr)
+{
+	*(volatile unsigned short __force *)addr = v;
+}
+static inline void __raw_writel(unsigned int v, volatile void *addr)
+{
+	*(volatile unsigned int __force *)addr = v;
+}
+static inline void __raw_writeq(unsigned long v, volatile void *addr)
+{
+	*(volatile unsigned long __force *)addr = v;
+}
+
+/*
+ * read (readb, readw, readl, readq) and write (writeb, writew,
+ * writel, writeq) accessors are for PCI and thus littel endian.
+ * Linux 2.4 for Microblaze had this wrong.
+ */
+static inline unsigned char readb(const volatile void *addr)
+{
+	return *(volatile unsigned char __force *)addr;
+}
+static inline unsigned short readw(const volatile void *addr)
+{
+	return le16_to_cpu(*(volatile unsigned short __force *)addr);
+}
+static inline unsigned int readl(const volatile void *addr)
+{
+	return le32_to_cpu(*(volatile unsigned int __force *)addr);
+}
+static inline void writeb(unsigned char v, volatile void *addr)
+{
+	*(volatile unsigned char __force *)addr = v;
+}
+static inline void writew(unsigned short v, volatile void *addr)
+{
+	*(volatile unsigned short __force *)addr = cpu_to_le16(v);
+}
+static inline void writel(unsigned int v, volatile void __iomem *addr)
+{
+	*(volatile unsigned int __force *)addr = cpu_to_le32(v);
+}
+
+/* ioread and iowrite variants. thease are for now same as __raw_
+ * variants of accessors. we might check for endianess in the feature
+ */
+#define ioread8(addr)		__raw_readb((u8 *)(addr))
+#define ioread16(addr)		__raw_readw((u16 *)(addr))
+#define ioread32(addr)		__raw_readl((u32 *)(addr))
+#define iowrite8(v, addr)	__raw_writeb((u8)(v), (u8 *)(addr))
+#define iowrite16(v, addr)	__raw_writew((u16)(v), (u16 *)(addr))
+#define iowrite32(v, addr)	__raw_writel((u32)(v), (u32 *)(addr))
+
+/* These are the definitions for the x86 IO instructions
+ * inb/inw/inl/outb/outw/outl, the "string" versions
+ * insb/insw/insl/outsb/outsw/outsl, and the "pausing" versions
+ * inb_p/inw_p/...
+ * The macros don't do byte-swapping.
+ */
+#define inb(port)		readb((u8 *)((port)))
+#define outb(val, port)		writeb((val), (u8 *)((unsigned long)(port)))
+#define inw(port)		readw((u16 *)((port)))
+#define outw(val, port)		writew((val), (u16 *)((unsigned long)(port)))
+#define inl(port)		readl((u32 *)((port)))
+#define outl(val, port)		writel((val), (u32 *)((unsigned long)(port)))
+
+#define inb_p(port)		inb((port))
+#define outb_p(val, port)	outb((val), (port))
+#define inw_p(port)		inw((port))
+#define outw_p(val, port)	outw((val), (port))
+#define inl_p(port)		inl((port))
+#define outl_p(val, port)	outl((val), (port))
+
+#define memset_io(a, b, c)	memset((void *)(a), (b), (c))
+#define memcpy_fromio(a, b, c)	memcpy((a), (void *)(b), (c))
+#define memcpy_toio(a, b, c)	memcpy((void *)(a), (b), (c))
+
+/**
+ *	virt_to_phys	-	map virtual addresses to physical
+ *	@address: address to remap
+ *
+ *	The returned physical address is the physical (CPU) mapping for
+ *	the memory address given. It is only valid to use this function on
+ *	addresses directly mapped or allocated via kmalloc.
+ *
+ *	This function does not give bus mappings for DMA transfers. In
+ *	almost all conceivable cases a device driver should not be using
+ *	this function
+ */
+static inline unsigned long __iomem virt_to_phys(volatile void *address)
+{
+	return __pa((unsigned long)address);
+}
+
+#define virt_to_bus virt_to_phys
+
+/**
+ *	phys_to_virt	-	map physical address to virtual
+ *	@address: address to remap
+ *
+ *	The returned virtual address is a current CPU mapping for
+ *	the memory address given. It is only valid to use this function on
+ *	addresses that have a kernel mapping
+ *
+ *	This function does not handle bus mappings for DMA transfers. In
+ *	almost all conceivable cases a device driver should not be using
+ *	this function
+ */
+static inline void *phys_to_virt(unsigned long address)
+{
+	return (void *)__va(address);
+}
+
+#define bus_to_virt(a) phys_to_virt(a)
+
+static inline void *__ioremap(unsigned long address, unsigned long size,
+			unsigned long flags)
+{
+	return (void *)address;
+}
+
+
+#define IO_SPACE_LIMIT ~(0UL)
+
+#define ioremap(physaddr, size)	((void *)(unsigned long)(physaddr))
+#define iounmap(addr)		((void)0)
+#define ioremap_nocache(physaddr, size)	ioremap(physaddr, size)
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
+ * Big Endian
+ */
+#define out_be32(a, v) __raw_writel((v), (a))
+#define out_be16(a, v) __raw_writew((v), (a))
+
+#define in_be32(a) __raw_readl(a)
+#define in_be16(a) __raw_readw(a)
+
+/*
+ * Little endian
+ */
+
+#define out_le32(a, v) __raw_writel(__cpu_to_le32(v), (a));
+#define out_le16(a, v) __raw_writew(__cpu_to_le16(v), (a))
+
+#define in_le32(a) __le32_to_cpu(__raw_readl(a))
+#define in_le16(a) __le16_to_cpu(__raw_readw(a))
+
+/* Byte ops */
+#define out_8(a, v) __raw_writeb((v), (a))
+#define in_8(a) __raw_readb(a)
+
+/* FIXME */
+static inline void __iomem *ioport_map(unsigned long port, unsigned int len)
+{
+	return (void __iomem *) (port);
+}
+
+static inline void ioport_unmap(void __iomem *addr)
+{
+	/* Nothing to do */
+}
+
+#endif /* _ASM_MICROBLAZE_IO_H */
-- 
1.5.4.GIT
