Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CBA7A67B5D
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Sep 2006 15:39:00 +1000 (EST)
Date: Mon, 18 Sep 2006 15:38:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] merge iSeries i/o operations with the rest
Message-Id: <20060918153853.f4332d2a.sfr@canb.auug.org.au>
In-Reply-To: <20060905120817.e52857ee.sfr@canb.auug.org.au>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes the io operations so that they are out of line if
CONFIG_PPC_ISERIES is set (which they were anyway) and includes a
firmware feature check in that case (so we come closer to building a
combined kernel).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c     |  349 ++++++++++++++++++++++++++----
 include/asm-powerpc/io.h                 |  155 +++++++------
 include/asm-powerpc/iseries/iseries_io.h |   60 -----
 3 files changed, 380 insertions(+), 184 deletions(-)

This new version produces unchanged code on pSeries and g5 etc and adds a
stack frame for a couple of the iSeries calls.  I have not yet measured
the performance hit of taking the io accessors out of line, but that will
only happen in the combined kernel case (whcih we can't build yet).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index f4d427a..7677d45 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -34,6 +34,7 @@ #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 #include <asm/iommu.h>
 #include <asm/abs_addr.h>
+#include <asm/firmware.h>
 
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/mf.h>
@@ -270,46 +271,6 @@ void pcibios_fixup_resources(struct pci_
 }
 
 /*
- * I/0 Memory copy MUST use mmio commands on iSeries
- * To do; For performance, include the hv call directly
- */
-void iSeries_memset_io(volatile void __iomem *dest, char c, size_t Count)
-{
-	u8 ByteValue = c;
-	long NumberOfBytes = Count;
-
-	while (NumberOfBytes > 0) {
-		iSeries_Write_Byte(ByteValue, dest++);
-		-- NumberOfBytes;
-	}
-}
-EXPORT_SYMBOL(iSeries_memset_io);
-
-void iSeries_memcpy_toio(volatile void __iomem *dest, void *source, size_t count)
-{
-	char *src = source;
-	long NumberOfBytes = count;
-
-	while (NumberOfBytes > 0) {
-		iSeries_Write_Byte(*src++, dest++);
-		-- NumberOfBytes;
-	}
-}
-EXPORT_SYMBOL(iSeries_memcpy_toio);
-
-void iSeries_memcpy_fromio(void *dest, const volatile void __iomem *src, size_t count)
-{
-	char *dst = dest;
-	long NumberOfBytes = count;
-
-	while (NumberOfBytes > 0) {
-		*dst++ = iSeries_Read_Byte(src++);
-		-- NumberOfBytes;
-	}
-}
-EXPORT_SYMBOL(iSeries_memcpy_fromio);
-
-/*
  * Look down the chain to find the matching Device Device
  */
 static struct device_node *find_Device_Node(int bus, int devfn)
@@ -491,7 +452,7 @@ static inline struct device_node *xlate_
  * iSeries_Read_Word = Read Word  (16 bit)
  * iSeries_Read_Long = Read Long  (32 bit)
  */
-u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
+static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -518,9 +479,8 @@ u8 iSeries_Read_Byte(const volatile void
 
 	return (u8)ret.value;
 }
-EXPORT_SYMBOL(iSeries_Read_Byte);
 
-u16 iSeries_Read_Word(const volatile void __iomem *IoAddress)
+static u16 iSeries_Read_Word(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -548,9 +508,8 @@ u16 iSeries_Read_Word(const volatile voi
 
 	return swab16((u16)ret.value);
 }
-EXPORT_SYMBOL(iSeries_Read_Word);
 
-u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
+static u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -578,7 +537,6 @@ u32 iSeries_Read_Long(const volatile voi
 
 	return swab32((u32)ret.value);
 }
-EXPORT_SYMBOL(iSeries_Read_Long);
 
 /*
  * Write MM I/O Instructions for the iSeries
@@ -587,7 +545,7 @@ EXPORT_SYMBOL(iSeries_Read_Long);
  * iSeries_Write_Word = Write Word(16 bit)
  * iSeries_Write_Long = Write Long(32 bit)
  */
-void iSeries_Write_Byte(u8 data, volatile void __iomem *IoAddress)
+static void iSeries_Write_Byte(u8 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -612,9 +570,8 @@ void iSeries_Write_Byte(u8 data, volatil
 		rc = HvCall4(HvCallPciBarStore8, dsa, BarOffset, data, 0);
 	} while (CheckReturnCode("WWB", DevNode, &retry, rc) != 0);
 }
-EXPORT_SYMBOL(iSeries_Write_Byte);
 
-void iSeries_Write_Word(u16 data, volatile void __iomem *IoAddress)
+static void iSeries_Write_Word(u16 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -639,9 +596,8 @@ void iSeries_Write_Word(u16 data, volati
 		rc = HvCall4(HvCallPciBarStore16, dsa, BarOffset, swab16(data), 0);
 	} while (CheckReturnCode("WWW", DevNode, &retry, rc) != 0);
 }
-EXPORT_SYMBOL(iSeries_Write_Word);
 
-void iSeries_Write_Long(u32 data, volatile void __iomem *IoAddress)
+static void iSeries_Write_Long(u32 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -666,4 +622,293 @@ void iSeries_Write_Long(u32 data, volati
 		rc = HvCall4(HvCallPciBarStore32, dsa, BarOffset, swab32(data), 0);
 	} while (CheckReturnCode("WWL", DevNode, &retry, rc) != 0);
 }
-EXPORT_SYMBOL(iSeries_Write_Long);
+
+extern unsigned char __raw_readb(const volatile void __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		BUG();
+		return 0;
+	}
+	return *(volatile unsigned char __force *)addr;
+}
+EXPORT_SYMBOL(__raw_readb);
+
+extern unsigned short __raw_readw(const volatile void __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		BUG();
+		return 0;
+	}
+	return *(volatile unsigned short __force *)addr;
+}
+EXPORT_SYMBOL(__raw_readw);
+
+extern unsigned int __raw_readl(const volatile void __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		BUG();
+		return 0;
+	}
+	return *(volatile unsigned int __force *)addr;
+}
+EXPORT_SYMBOL(__raw_readl);
+
+extern unsigned long __raw_readq(const volatile void __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		BUG();
+		return 0;
+	}
+	return *(volatile unsigned long __force *)addr;
+}
+EXPORT_SYMBOL(__raw_readq);
+
+extern void __raw_writeb(unsigned char v, volatile void __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		*(volatile unsigned char __force *)addr = v;
+}
+EXPORT_SYMBOL(__raw_writeb);
+
+extern void __raw_writew(unsigned short v, volatile void __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		*(volatile unsigned short __force *)addr = v;
+}
+EXPORT_SYMBOL(__raw_writew);
+
+extern void __raw_writel(unsigned int v, volatile void __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		*(volatile unsigned int __force *)addr = v;
+}
+EXPORT_SYMBOL(__raw_writel);
+
+extern void __raw_writeq(unsigned long v, volatile void __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		*(volatile unsigned long __force *)addr = v;
+}
+EXPORT_SYMBOL(__raw_writeq);
+
+int in_8(const volatile unsigned char __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return iSeries_Read_Byte(addr);
+	return __in_8(addr);
+}
+EXPORT_SYMBOL(in_8);
+
+void out_8(volatile unsigned char __iomem *addr, int val)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		iSeries_Write_Byte(val, addr);
+	else
+		__out_8(addr, val);
+}
+EXPORT_SYMBOL(out_8);
+
+int in_le16(const volatile unsigned short __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return iSeries_Read_Word(addr);
+	return __in_le16(addr);
+}
+EXPORT_SYMBOL(in_le16);
+
+int in_be16(const volatile unsigned short __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		BUG();
+		return 0;
+	}
+	return __in_be16(addr);
+}
+EXPORT_SYMBOL(in_be16);
+
+void out_le16(volatile unsigned short __iomem *addr, int val)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		iSeries_Write_Word(val, addr);
+	else
+		__out_le16(addr, val);
+}
+EXPORT_SYMBOL(out_le16);
+
+void out_be16(volatile unsigned short __iomem *addr, int val)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		__out_be16(addr, val);
+}
+EXPORT_SYMBOL(out_be16);
+
+unsigned in_le32(const volatile unsigned __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return iSeries_Read_Long(addr);
+	return __in_le32(addr);
+}
+EXPORT_SYMBOL(in_le32);
+
+unsigned in_be32(const volatile unsigned __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		BUG();
+		return 0;
+	}
+	return __in_be32(addr);
+}
+EXPORT_SYMBOL(in_be32);
+
+void out_le32(volatile unsigned __iomem *addr, int val)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		iSeries_Write_Long(val, addr);
+	else
+		__out_le32(addr, val);
+}
+EXPORT_SYMBOL(out_le32);
+
+void out_be32(volatile unsigned __iomem *addr, int val)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		__out_be32(addr, val);
+}
+EXPORT_SYMBOL(out_be32);
+
+unsigned long in_le64(const volatile unsigned long __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		BUG();
+		return 0;
+	}
+	return __in_le64(addr);
+}
+EXPORT_SYMBOL(in_le64);
+
+unsigned long in_be64(const volatile unsigned long __iomem *addr)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		BUG();
+		return 0;
+	}
+	return __in_be64(addr);
+}
+EXPORT_SYMBOL(in_be64);
+
+void out_le64(volatile unsigned long __iomem *addr, unsigned long val)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		__out_le64(addr, val);
+}
+EXPORT_SYMBOL(out_le64);
+
+void out_be64(volatile unsigned long __iomem *addr, unsigned long val)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		__out_be64(addr, val);
+}
+EXPORT_SYMBOL(out_be64);
+
+void memset_io(volatile void __iomem *addr, int c, unsigned long n)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		volatile char __iomem *d = addr;
+
+		while (n-- > 0) {
+			iSeries_Write_Byte(c, d++);
+		}
+	} else
+		eeh_memset_io(addr, c, n);
+}
+EXPORT_SYMBOL(memset_io);
+
+void memcpy_fromio(void *dest, const volatile void __iomem *src,
+                                 unsigned long n)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		char *d = dest;
+		const volatile char __iomem *s = src;
+
+		while (n-- > 0) {
+			*d++ = iSeries_Read_Byte(s++);
+		}
+	} else
+		eeh_memcpy_fromio(dest, src, n);
+}
+EXPORT_SYMBOL(memcpy_fromio);
+
+void memcpy_toio(volatile void __iomem *dest, const void *src, unsigned long n)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		const char *s = src;
+		volatile char __iomem *d = dest;
+
+		while (n-- > 0) {
+			iSeries_Write_Byte(*s++, d++);
+		}
+	} else
+		eeh_memcpy_toio(dest, src, n);
+}
+EXPORT_SYMBOL(memcpy_toio);
+
+void insb(unsigned long port, void *buf, int ns)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		eeh_insb(port, buf, ns);
+}
+EXPORT_SYMBOL(insb);
+
+void insw(unsigned long port, void *buf, int ns)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		eeh_insw_ns(port, buf, ns);
+}
+EXPORT_SYMBOL(insw);
+
+void insl(unsigned long port, void *buf, int ns)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		eeh_insl_ns(port, buf, ns);
+}
+EXPORT_SYMBOL(insl);
+
+void insw_ns(unsigned long port, void *buf, int ns)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		eeh_insw_ns(port, buf, ns);
+}
+EXPORT_SYMBOL(insw_ns);
+
+void insl_ns(unsigned long port, void *buf, int ns)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		BUG();
+	else
+		eeh_insl_ns(port, buf, ns);
+}
+EXPORT_SYMBOL(insl_ns);
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 212428d..05575b2 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -20,9 +20,6 @@ #include <linux/compiler.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>
 #include <asm/paca.h>
-#ifdef CONFIG_PPC_ISERIES 
-#include <asm/iseries/iseries_io.h>
-#endif  
 #include <asm/synch.h>
 #include <asm/delay.h>
 
@@ -43,42 +40,59 @@ extern unsigned long isa_io_base;
 extern unsigned long pci_io_base;
 
 #ifdef CONFIG_PPC_ISERIES
-/* __raw_* accessors aren't supported on iSeries */
-#define __raw_readb(addr)	{ BUG(); 0; }
-#define __raw_readw(addr)       { BUG(); 0; }
-#define __raw_readl(addr)       { BUG(); 0; }
-#define __raw_readq(addr)       { BUG(); 0; }
-#define __raw_writeb(v, addr)   { BUG(); 0; }
-#define __raw_writew(v, addr)   { BUG(); 0; }
-#define __raw_writel(v, addr)   { BUG(); 0; }
-#define __raw_writeq(v, addr)   { BUG(); 0; }
-#define readb(addr)		iSeries_Read_Byte(addr)
-#define readw(addr)		iSeries_Read_Word(addr)
-#define readl(addr)		iSeries_Read_Long(addr)
-#define writeb(data, addr)	iSeries_Write_Byte((data),(addr))
-#define writew(data, addr)	iSeries_Write_Word((data),(addr))
-#define writel(data, addr)	iSeries_Write_Long((data),(addr))
-#define memset_io(a,b,c)	iSeries_memset_io((a),(b),(c))
-#define memcpy_fromio(a,b,c)	iSeries_memcpy_fromio((a), (b), (c))
-#define memcpy_toio(a,b,c)	iSeries_memcpy_toio((a), (b), (c))
-
-#define inb(addr)		readb(((void __iomem *)(long)(addr)))
-#define inw(addr)		readw(((void __iomem *)(long)(addr)))
-#define inl(addr)		readl(((void __iomem *)(long)(addr)))
-#define outb(data,addr)		writeb(data,((void __iomem *)(long)(addr)))
-#define outw(data,addr)		writew(data,((void __iomem *)(long)(addr)))
-#define outl(data,addr)		writel(data,((void __iomem *)(long)(addr)))
-/*
- * The *_ns versions below don't do byte-swapping.
- * Neither do the standard versions now, these are just here
- * for older code.
- */
-#define insb(port, buf, ns)	_insb((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insw(port, buf, ns)	_insw_ns((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insl(port, buf, nl)	_insl_ns((u8 __iomem *)((port)+pci_io_base), (buf), (nl))
-#define insw_ns(port, buf, ns)	_insw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insl_ns(port, buf, nl)	_insl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
-#else
+
+extern int in_8(const volatile unsigned char __iomem *addr);
+extern void out_8(volatile unsigned char __iomem *addr, int val);
+extern int in_le16(const volatile unsigned short __iomem *addr);
+extern int in_be16(const volatile unsigned short __iomem *addr);
+extern void out_le16(volatile unsigned short __iomem *addr, int val);
+extern void out_be16(volatile unsigned short __iomem *addr, int val);
+extern unsigned in_le32(const volatile unsigned __iomem *addr);
+extern unsigned in_be32(const volatile unsigned __iomem *addr);
+extern void out_le32(volatile unsigned __iomem *addr, int val);
+extern void out_be32(volatile unsigned __iomem *addr, int val);
+extern unsigned long in_le64(const volatile unsigned long __iomem *addr);
+extern unsigned long in_be64(const volatile unsigned long __iomem *addr);
+extern void out_le64(volatile unsigned long __iomem *addr, unsigned long val);
+extern void out_be64(volatile unsigned long __iomem *addr, unsigned long val);
+
+extern unsigned char __raw_readb(const volatile void __iomem *addr);
+extern unsigned short __raw_readw(const volatile void __iomem *addr);
+extern unsigned int __raw_readl(const volatile void __iomem *addr);
+extern unsigned long __raw_readq(const volatile void __iomem *addr);
+extern void __raw_writeb(unsigned char v, volatile void __iomem *addr);
+extern void __raw_writew(unsigned short v, volatile void __iomem *addr);
+extern void __raw_writel(unsigned int v, volatile void __iomem *addr);
+extern void __raw_writeq(unsigned long v, volatile void __iomem *addr);
+
+extern void memset_io(volatile void __iomem *addr, int c, unsigned long n);
+extern void memcpy_fromio(void *dest, const volatile void __iomem *src,
+                                 unsigned long n);
+extern void memcpy_toio(volatile void __iomem *dest, const void *src,
+                                 unsigned long n);
+
+extern void insb(unsigned long port, void *buf, int ns);
+extern void insw(unsigned long port, void *buf, int ns);
+extern void insl(unsigned long port, void *buf, int ns);
+extern void insw_ns(unsigned long port, void *buf, int ns);
+extern void insl_ns(unsigned long port, void *buf, int ns);
+
+#else /* CONFIG_PPC_ISERIES */
+
+#define in_8(addr)		__in_8((addr))
+#define out_8(addr, val)	__out_8((addr), (val))
+#define in_le16(addr)		__in_le16((addr))
+#define in_be16(addr)		__in_be16((addr))
+#define out_le16(addr, val)	__out_le16((addr), (val))
+#define out_be16(addr, val)	__out_be16((addr), (val))
+#define in_le32(addr)		__in_le32((addr))
+#define in_be32(addr)		__in_be32((addr))
+#define out_le32(addr, val)	__out_le32((addr), (val))
+#define out_be32(addr, val)	__out_be32((addr), (val))
+#define in_le64(addr)		__in_le64((addr))
+#define in_be64(addr)		__in_be64((addr))
+#define out_le64(addr, val)	__out_le64((addr), (val))
+#define out_be64(addr, val)	__out_be64((addr), (val))
 
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
 {
@@ -112,23 +126,9 @@ static inline void __raw_writeq(unsigned
 {
 	*(volatile unsigned long __force *)addr = v;
 }
-#define readb(addr)		eeh_readb(addr)
-#define readw(addr)		eeh_readw(addr)
-#define readl(addr)		eeh_readl(addr)
-#define readq(addr)		eeh_readq(addr)
-#define writeb(data, addr)	eeh_writeb((data), (addr))
-#define writew(data, addr)	eeh_writew((data), (addr))
-#define writel(data, addr)	eeh_writel((data), (addr))
-#define writeq(data, addr)	eeh_writeq((data), (addr))
 #define memset_io(a,b,c)	eeh_memset_io((a),(b),(c))
 #define memcpy_fromio(a,b,c)	eeh_memcpy_fromio((a),(b),(c))
 #define memcpy_toio(a,b,c)	eeh_memcpy_toio((a),(b),(c))
-#define inb(port)		eeh_inb((unsigned long)port)
-#define outb(val, port)		eeh_outb(val, (unsigned long)port)
-#define inw(port)		eeh_inw((unsigned long)port)
-#define outw(val, port)		eeh_outw(val, (unsigned long)port)
-#define inl(port)		eeh_inl((unsigned long)port)
-#define outl(val, port)		eeh_outl(val, (unsigned long)port)
 
 /*
  * The insw/outsw/insl/outsl macros don't do byte-swapping.
@@ -141,12 +141,27 @@ #define insl(port, buf, nl)	eeh_insl_ns(
 #define insw_ns(port, buf, ns)	eeh_insw_ns((port), (buf), (ns))
 #define insl_ns(port, buf, nl)	eeh_insl_ns((port), (buf), (nl))
 
-#endif
+#endif /* CONFIG_PPC_ISERIES */
 
 #define outsb(port, buf, ns)  _outsb((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define outsw(port, buf, ns)  _outsw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define outsl(port, buf, nl)  _outsl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 
+#define readb(addr)		eeh_readb(addr)
+#define readw(addr)		eeh_readw(addr)
+#define readl(addr)		eeh_readl(addr)
+#define readq(addr)		eeh_readq(addr)
+#define writeb(data, addr)	eeh_writeb((data), (addr))
+#define writew(data, addr)	eeh_writew((data), (addr))
+#define writel(data, addr)	eeh_writel((data), (addr))
+#define writeq(data, addr)	eeh_writeq((data), (addr))
+#define inb(port)		eeh_inb((unsigned long)port)
+#define outb(val, port)		eeh_outb(val, (unsigned long)port)
+#define inw(port)		eeh_inw((unsigned long)port)
+#define outw(val, port)		eeh_outw(val, (unsigned long)port)
+#define inl(port)		eeh_inl((unsigned long)port)
+#define outl(val, port)		eeh_outl(val, (unsigned long)port)
+
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
@@ -279,7 +294,7 @@ #define iobarrier_w()  eieio()
  * and should not be used directly by device drivers.  Use inb/readb
  * instead.
  */
-static inline int in_8(const volatile unsigned char __iomem *addr)
+static inline int __in_8(const volatile unsigned char __iomem *addr)
 {
 	int ret;
 
@@ -288,14 +303,14 @@ static inline int in_8(const volatile un
 	return ret;
 }
 
-static inline void out_8(volatile unsigned char __iomem *addr, int val)
+static inline void __out_8(volatile unsigned char __iomem *addr, int val)
 {
 	__asm__ __volatile__("sync; stb%U0%X0 %1,%0"
 			     : "=m" (*addr) : "r" (val));
 	get_paca()->io_sync = 1;
 }
 
-static inline int in_le16(const volatile unsigned short __iomem *addr)
+static inline int __in_le16(const volatile unsigned short __iomem *addr)
 {
 	int ret;
 
@@ -304,7 +319,7 @@ static inline int in_le16(const volatile
 	return ret;
 }
 
-static inline int in_be16(const volatile unsigned short __iomem *addr)
+static inline int __in_be16(const volatile unsigned short __iomem *addr)
 {
 	int ret;
 
@@ -313,21 +328,21 @@ static inline int in_be16(const volatile
 	return ret;
 }
 
-static inline void out_le16(volatile unsigned short __iomem *addr, int val)
+static inline void __out_le16(volatile unsigned short __iomem *addr, int val)
 {
 	__asm__ __volatile__("sync; sthbrx %1,0,%2"
 			     : "=m" (*addr) : "r" (val), "r" (addr));
 	get_paca()->io_sync = 1;
 }
 
-static inline void out_be16(volatile unsigned short __iomem *addr, int val)
+static inline void __out_be16(volatile unsigned short __iomem *addr, int val)
 {
 	__asm__ __volatile__("sync; sth%U0%X0 %1,%0"
 			     : "=m" (*addr) : "r" (val));
 	get_paca()->io_sync = 1;
 }
 
-static inline unsigned in_le32(const volatile unsigned __iomem *addr)
+static inline unsigned __in_le32(const volatile unsigned __iomem *addr)
 {
 	unsigned ret;
 
@@ -336,7 +351,7 @@ static inline unsigned in_le32(const vol
 	return ret;
 }
 
-static inline unsigned in_be32(const volatile unsigned __iomem *addr)
+static inline unsigned __in_be32(const volatile unsigned __iomem *addr)
 {
 	unsigned ret;
 
@@ -345,21 +360,21 @@ static inline unsigned in_be32(const vol
 	return ret;
 }
 
-static inline void out_le32(volatile unsigned __iomem *addr, int val)
+static inline void __out_le32(volatile unsigned __iomem *addr, int val)
 {
 	__asm__ __volatile__("sync; stwbrx %1,0,%2" : "=m" (*addr)
 			     : "r" (val), "r" (addr));
 	get_paca()->io_sync = 1;
 }
 
-static inline void out_be32(volatile unsigned __iomem *addr, int val)
+static inline void __out_be32(volatile unsigned __iomem *addr, int val)
 {
 	__asm__ __volatile__("sync; stw%U0%X0 %1,%0"
 			     : "=m" (*addr) : "r" (val));
 	get_paca()->io_sync = 1;
 }
 
-static inline unsigned long in_le64(const volatile unsigned long __iomem *addr)
+static inline unsigned long __in_le64(const volatile unsigned long __iomem *addr)
 {
 	unsigned long tmp, ret;
 
@@ -379,7 +394,7 @@ static inline unsigned long in_le64(cons
 	return ret;
 }
 
-static inline unsigned long in_be64(const volatile unsigned long __iomem *addr)
+static inline unsigned long __in_be64(const volatile unsigned long __iomem *addr)
 {
 	unsigned long ret;
 
@@ -388,7 +403,7 @@ static inline unsigned long in_be64(cons
 	return ret;
 }
 
-static inline void out_le64(volatile unsigned long __iomem *addr, unsigned long val)
+static inline void __out_le64(volatile unsigned long __iomem *addr, unsigned long val)
 {
 	unsigned long tmp;
 
@@ -406,15 +421,13 @@ static inline void out_le64(volatile uns
 	get_paca()->io_sync = 1;
 }
 
-static inline void out_be64(volatile unsigned long __iomem *addr, unsigned long val)
+static inline void __out_be64(volatile unsigned long __iomem *addr, unsigned long val)
 {
 	__asm__ __volatile__("sync; std%U0%X0 %1,%0" : "=m" (*addr) : "r" (val));
 	get_paca()->io_sync = 1;
 }
 
-#ifndef CONFIG_PPC_ISERIES 
 #include <asm/eeh.h>
-#endif
 
 /**
  *	check_signature		-	find BIOS signatures
@@ -430,7 +443,6 @@ static inline int check_signature(const 
 	const unsigned char *signature, int length)
 {
 	int retval = 0;
-#ifndef CONFIG_PPC_ISERIES 
 	do {
 		if (readb(io_addr) != *signature)
 			goto out;
@@ -440,7 +452,6 @@ #ifndef CONFIG_PPC_ISERIES 
 	} while (length);
 	retval = 1;
 out:
-#endif
 	return retval;
 }
 
diff --git a/include/asm-powerpc/iseries/iseries_io.h b/include/asm-powerpc/iseries/iseries_io.h
deleted file mode 100644
index f29009b..0000000
--- a/include/asm-powerpc/iseries/iseries_io.h
+++ /dev/null
@@ -1,60 +0,0 @@
-#ifndef _ASM_POWERPC_ISERIES_ISERIES_IO_H
-#define _ASM_POWERPC_ISERIES_ISERIES_IO_H
-
-
-#ifdef CONFIG_PPC_ISERIES
-#include <linux/types.h>
-/*
- * Created by Allan Trautman on Thu Dec 28 2000.
- *
- * Remaps the io.h for the iSeries Io
- * Copyright (C) 2000  Allan H Trautman, IBM Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the:
- * Free Software Foundation, Inc.,
- * 59 Temple Place, Suite 330,
- * Boston, MA  02111-1307  USA
- *
- * Change Activity:
- *   Created December 28, 2000
- * End Change Activity
- */
-
-#ifdef CONFIG_PCI
-extern u8   iSeries_Read_Byte(const volatile void __iomem * IoAddress);
-extern u16  iSeries_Read_Word(const volatile void __iomem * IoAddress);
-extern u32  iSeries_Read_Long(const volatile void __iomem * IoAddress);
-extern void iSeries_Write_Byte(u8  IoData, volatile void __iomem * IoAddress);
-extern void iSeries_Write_Word(u16 IoData, volatile void __iomem * IoAddress);
-extern void iSeries_Write_Long(u32 IoData, volatile void __iomem * IoAddress);
-
-extern void iSeries_memset_io(volatile void __iomem *dest, char x, size_t n);
-extern void iSeries_memcpy_toio(volatile void __iomem *dest, void *source,
-		size_t n);
-extern void iSeries_memcpy_fromio(void *dest,
-		const volatile void __iomem *source, size_t n);
-#else
-static inline u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
-{
-	return 0xff;
-}
-
-static inline void iSeries_Write_Byte(u8 IoData,
-		volatile void __iomem *IoAddress)
-{
-}
-#endif	/* CONFIG_PCI */
-
-#endif /* CONFIG_PPC_ISERIES */
-#endif /* _ASM_POWERPC_ISERIES_ISERIES_IO_H */
-- 
1.4.2.1
