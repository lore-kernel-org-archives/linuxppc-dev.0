Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5817467BAD
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 12:08:26 +1000 (EST)
Date: Tue, 5 Sep 2006 12:08:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] merge iSeries i/o operations with the rest
Message-Id: <20060905120817.e52857ee.sfr@canb.auug.org.au>
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

The low level i/o operations are now handled in iSeires by taking a
trap when we access the (inaccessible) io memory region and calling
the Hypervisor from the trap code.  To accomplish this the inline
assembler code for mos of the operations is simplified to ease decoding
and emulation.

The memset_io/memcpy_(to,from)io routines just do a firmware feature
check as it will compile out in the non combined build case and in the
combined build, the extra check is a relatively small overhead.

The remainder of the routines are not used in the drivers for any
currently supported hardware on legacy iSeries, so juts use the eeh
versions (they used to BUG or were not even implemented).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/fault.c                  |    8 ++
 arch/powerpc/platforms/iseries/pci.c     |  140 +++++++++++++++++++-----------
 include/asm-powerpc/io.h                 |  109 +++++++++++------------
 include/asm-powerpc/iseries/iseries_io.h |   27 ------
 include/asm-powerpc/ppc-pci.h            |   11 ++
 5 files changed, 159 insertions(+), 136 deletions(-)

This has been built for iSeries and pSeries and booted on iSeries.  It
has a measurable performance impact on iSeries for the only real device I
have (a PCnet32 ethernet card - iperf throughput is reduced by about
4-5%).  I have not booted this on pSeries much less tried to measure any
performance difference.

Comments welcome.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 78a0d59..e8add2b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -38,6 +38,8 @@ #include <asm/uaccess.h>
 #include <asm/tlbflush.h>
 #include <asm/kdebug.h>
 #include <asm/siginfo.h>
+#include <asm/firmware.h>
+#include <asm/ppc-pci.h>
 
 #ifdef CONFIG_KPROBES
 ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
@@ -185,8 +187,12 @@ #endif /* CONFIG_4xx || CONFIG_BOOKE */
 	}
 
 	/* On a kernel SLB miss we can only check for a valid exception entry */
-	if (!user_mode(regs) && (address >= TASK_SIZE))
+	if (!user_mode(regs) && (address >= TASK_SIZE)) {
+		if (firmware_has_feature(FW_FEATURE_ISERIES) &&
+				iseries_handle_io_fault(regs, address))
+			return 0;
 		return SIGSEGV;
+	}
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
   	if (error_code & DSISR_DABRMATCH) {
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index f4d427a..04b50d9 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -26,6 +26,7 @@ #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/ide.h>
 #include <linux/pci.h>
+#include <linux/ptrace.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -38,6 +39,7 @@ #include <asm/abs_addr.h>
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/mf.h>
 #include <asm/iseries/iommu.h>
+#include <asm/iseries/iseries_io.h>
 
 #include <asm/ppc-pci.h>
 
@@ -270,46 +272,6 @@ void pcibios_fixup_resources(struct pci_
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
@@ -491,7 +453,7 @@ static inline struct device_node *xlate_
  * iSeries_Read_Word = Read Word  (16 bit)
  * iSeries_Read_Long = Read Long  (32 bit)
  */
-u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
+static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -518,9 +480,8 @@ u8 iSeries_Read_Byte(const volatile void
 
 	return (u8)ret.value;
 }
-EXPORT_SYMBOL(iSeries_Read_Byte);
 
-u16 iSeries_Read_Word(const volatile void __iomem *IoAddress)
+static u16 iSeries_Read_Word(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -548,9 +509,8 @@ u16 iSeries_Read_Word(const volatile voi
 
 	return swab16((u16)ret.value);
 }
-EXPORT_SYMBOL(iSeries_Read_Word);
 
-u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
+static u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -578,7 +538,6 @@ u32 iSeries_Read_Long(const volatile voi
 
 	return swab32((u32)ret.value);
 }
-EXPORT_SYMBOL(iSeries_Read_Long);
 
 /*
  * Write MM I/O Instructions for the iSeries
@@ -587,7 +546,7 @@ EXPORT_SYMBOL(iSeries_Read_Long);
  * iSeries_Write_Word = Write Word(16 bit)
  * iSeries_Write_Long = Write Long(32 bit)
  */
-void iSeries_Write_Byte(u8 data, volatile void __iomem *IoAddress)
+static void iSeries_Write_Byte(u8 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -612,9 +571,8 @@ void iSeries_Write_Byte(u8 data, volatil
 		rc = HvCall4(HvCallPciBarStore8, dsa, BarOffset, data, 0);
 	} while (CheckReturnCode("WWB", DevNode, &retry, rc) != 0);
 }
-EXPORT_SYMBOL(iSeries_Write_Byte);
 
-void iSeries_Write_Word(u16 data, volatile void __iomem *IoAddress)
+static void iSeries_Write_Word(u16 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -639,9 +597,8 @@ void iSeries_Write_Word(u16 data, volati
 		rc = HvCall4(HvCallPciBarStore16, dsa, BarOffset, swab16(data), 0);
 	} while (CheckReturnCode("WWW", DevNode, &retry, rc) != 0);
 }
-EXPORT_SYMBOL(iSeries_Write_Word);
 
-void iSeries_Write_Long(u32 data, volatile void __iomem *IoAddress)
+static void iSeries_Write_Long(u32 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -666,4 +623,83 @@ void iSeries_Write_Long(u32 data, volati
 		rc = HvCall4(HvCallPciBarStore32, dsa, BarOffset, swab32(data), 0);
 	} while (CheckReturnCode("WWL", DevNode, &retry, rc) != 0);
 }
-EXPORT_SYMBOL(iSeries_Write_Long);
+
+/*
+ * I/0 Memory copy MUST use mmio commands on iSeries
+ * To do; For performance, include the hv call directly
+ */
+void iSeries_memset_io(volatile void __iomem *dest, char c, size_t Count)
+{
+	u8 ByteValue = c;
+	long NumberOfBytes = Count;
+
+	while (NumberOfBytes > 0) {
+		iSeries_Write_Byte(ByteValue, dest++);
+		-- NumberOfBytes;
+	}
+}
+EXPORT_SYMBOL(iSeries_memset_io);
+
+void iSeries_memcpy_toio(volatile void __iomem *dest, const void *source,
+		size_t count)
+{
+	const char *src = source;
+	long NumberOfBytes = count;
+
+	while (NumberOfBytes > 0) {
+		iSeries_Write_Byte(*src++, dest++);
+		-- NumberOfBytes;
+	}
+}
+EXPORT_SYMBOL(iSeries_memcpy_toio);
+
+void iSeries_memcpy_fromio(void *dest, const volatile void __iomem *src, size_t count)
+{
+	char *dst = dest;
+	long NumberOfBytes = count;
+
+	while (NumberOfBytes > 0) {
+		*dst++ = iSeries_Read_Byte(src++);
+		-- NumberOfBytes;
+	}
+}
+EXPORT_SYMBOL(iSeries_memcpy_fromio);
+
+int iseries_handle_io_fault(struct pt_regs *regs, unsigned long address)
+{
+	u32 instr;
+
+	/* is the address in out i/o range? */
+	if ((address < BASE_IO_MEMORY) || (address >= max_io_memory))
+		return 0;
+	/* we are only called for kernel mode faults */
+	instr = *(u32 *)regs->nip;
+	/* Is the major opcode 31 and target/source r0? */
+	if ((instr & 0xffe00000) != 0x7C000000)
+		return 0;
+
+	switch ((instr >> 1) & 0x3ff) {
+	case 87:
+		regs->gpr[0] = iSeries_Read_Byte((void __iomem *)address);
+		break;
+	case 215:
+		iSeries_Write_Byte(regs->gpr[0], (void __iomem *)address);
+		break;
+	case 790:
+		regs->gpr[0] = iSeries_Read_Word((void __iomem *)address);
+		break;
+	case 918:
+		iSeries_Write_Word(regs->gpr[0], (void __iomem *)address);
+		break;
+	case 534:
+		regs->gpr[0] = iSeries_Read_Long((void __iomem *)address);
+		break;
+	case 662:
+		iSeries_Write_Long(regs->gpr[0], (void __iomem *)address);
+		break;
+	default:
+		return 0;
+	}
+	regs->nip += 4;
+	return 1;
+}
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 36c4c34..5420fac 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -19,11 +19,10 @@ #else
 #include <linux/compiler.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>
-#ifdef CONFIG_PPC_ISERIES 
 #include <asm/iseries/iseries_io.h>
-#endif  
 #include <asm/synch.h>
 #include <asm/delay.h>
+#include <asm/firmware.h>
 
 #include <asm-generic/iomap.h>
 
@@ -41,44 +40,10 @@ #define SLOW_DOWN_IO
 extern unsigned long isa_io_base;
 extern unsigned long pci_io_base;
 
-#ifdef CONFIG_PPC_ISERIES
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
 /*
- * The *_ns versions below don't do byte-swapping.
- * Neither do the standard versions now, these are just here
- * for older code.
+ * __raw_* accessors aren't supported on iSeries so
+ * these used to BUG() on iSeries, but that is not really necessary.
  */
-#define insb(port, buf, ns)	_insb((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insw(port, buf, ns)	_insw_ns((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insl(port, buf, nl)	_insl_ns((u8 __iomem *)((port)+pci_io_base), (buf), (nl))
-#define insw_ns(port, buf, ns)	_insw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insl_ns(port, buf, nl)	_insl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
-#else
-
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
 {
 	return *(volatile unsigned char __force *)addr;
@@ -111,6 +76,7 @@ static inline void __raw_writeq(unsigned
 {
 	*(volatile unsigned long __force *)addr = v;
 }
+
 #define readb(addr)		eeh_readb(addr)
 #define readw(addr)		eeh_readw(addr)
 #define readl(addr)		eeh_readl(addr)
@@ -119,9 +85,6 @@ #define writeb(data, addr)	eeh_writeb((d
 #define writew(data, addr)	eeh_writew((data), (addr))
 #define writel(data, addr)	eeh_writel((data), (addr))
 #define writeq(data, addr)	eeh_writeq((data), (addr))
-#define memset_io(a,b,c)	eeh_memset_io((a),(b),(c))
-#define memcpy_fromio(a,b,c)	eeh_memcpy_fromio((a),(b),(c))
-#define memcpy_toio(a,b,c)	eeh_memcpy_toio((a),(b),(c))
 #define inb(port)		eeh_inb((unsigned long)port)
 #define outb(val, port)		eeh_outb(val, (unsigned long)port)
 #define inw(port)		eeh_inw((unsigned long)port)
@@ -140,8 +103,6 @@ #define insl(port, buf, nl)	eeh_insl_ns(
 #define insw_ns(port, buf, ns)	eeh_insw_ns((port), (buf), (ns))
 #define insl_ns(port, buf, nl)	eeh_insl_ns((port), (buf), (nl))
 
-#endif
-
 #define outsb(port, buf, ns)  _outsb((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define outsw(port, buf, ns)  _outsw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define outsl(port, buf, nl)  _outsl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
@@ -273,25 +234,30 @@ #define iobarrier_w()  eieio()
  * These routines do not perform EEH-related I/O address translation,
  * and should not be used directly by device drivers.  Use inb/readb
  * instead.
+ *
+ * For some of these, we force the target/source register to be
+ * r0 to ease decoding on iSeries.
  */
 static inline int in_8(const volatile unsigned char __iomem *addr)
 {
-	int ret;
+	register unsigned int ret __asm__("r0");
 
-	__asm__ __volatile__("lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "m" (*addr));
+	__asm__ __volatile__("lbzx %0,0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "r" (addr));
 	return ret;
 }
 
 static inline void out_8(volatile unsigned char __iomem *addr, int val)
 {
-	__asm__ __volatile__("stb%U0%X0 %1,%0; sync"
-			     : "=m" (*addr) : "r" (val));
+	register unsigned int rval __asm__("r0") = val;
+
+	__asm__ __volatile__("stbx %0,0,%1; sync"
+			     : : "r" (rval), "r" (addr));
 }
 
 static inline int in_le16(const volatile unsigned short __iomem *addr)
 {
-	int ret;
+	register unsigned int ret __asm__("r0");
 
 	__asm__ __volatile__("lhbrx %0,0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "r" (addr), "m" (*addr));
@@ -309,8 +275,10 @@ static inline int in_be16(const volatile
 
 static inline void out_le16(volatile unsigned short __iomem *addr, int val)
 {
-	__asm__ __volatile__("sthbrx %1,0,%2; sync"
-			     : "=m" (*addr) : "r" (val), "r" (addr));
+	register unsigned int rval __asm__("r0") = val;
+
+	__asm__ __volatile__("sthbrx %0,0,%1; sync"
+			     : : "r" (rval), "r" (addr));
 }
 
 static inline void out_be16(volatile unsigned short __iomem *addr, int val)
@@ -321,7 +289,7 @@ static inline void out_be16(volatile uns
 
 static inline unsigned in_le32(const volatile unsigned __iomem *addr)
 {
-	unsigned ret;
+	register unsigned int ret __asm__("r0");
 
 	__asm__ __volatile__("lwbrx %0,0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "r" (addr), "m" (*addr));
@@ -339,8 +307,10 @@ static inline unsigned in_be32(const vol
 
 static inline void out_le32(volatile unsigned __iomem *addr, int val)
 {
-	__asm__ __volatile__("stwbrx %1,0,%2; sync" : "=m" (*addr)
-			     : "r" (val), "r" (addr));
+	register unsigned int rval __asm__("r0") = val;
+
+	__asm__ __volatile__("stwbrx %1,0,%2; sync"
+			     : "=m" (*addr) : "r" (rval), "r" (addr));
 }
 
 static inline void out_be32(volatile unsigned __iomem *addr, int val)
@@ -399,9 +369,34 @@ static inline void out_be64(volatile uns
 	__asm__ __volatile__("std%U0%X0 %1,%0; sync" : "=m" (*addr) : "r" (val));
 }
 
-#ifndef CONFIG_PPC_ISERIES 
 #include <asm/eeh.h>
-#endif
+
+static inline void memset_io(volatile void __iomem *addr, int c,
+                                 unsigned long n)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		iSeries_memset_io(addr, c, n);
+	else
+		eeh_memset_io(addr, c, n);
+}
+
+static inline void memcpy_fromio(void *dest, const volatile void __iomem *src,
+                                 unsigned long n)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		iSeries_memcpy_fromio(dest, src, n);
+	else
+		eeh_memcpy_fromio(dest, src, n);
+}
+
+static inline void memcpy_toio(volatile void __iomem *dest, const void *src,
+                                 unsigned long n)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		iSeries_memcpy_toio(dest, src, n);
+	else
+		eeh_memcpy_toio(dest, src, n);
+}
 
 /**
  *	check_signature		-	find BIOS signatures
@@ -417,7 +412,6 @@ static inline int check_signature(const 
 	const unsigned char *signature, int length)
 {
 	int retval = 0;
-#ifndef CONFIG_PPC_ISERIES 
 	do {
 		if (readb(io_addr) != *signature)
 			goto out;
@@ -427,7 +421,6 @@ #ifndef CONFIG_PPC_ISERIES 
 	} while (length);
 	retval = 1;
 out:
-#endif
 	return retval;
 }
 
diff --git a/include/asm-powerpc/iseries/iseries_io.h b/include/asm-powerpc/iseries/iseries_io.h
index f29009b..1b61c51 100644
--- a/include/asm-powerpc/iseries/iseries_io.h
+++ b/include/asm-powerpc/iseries/iseries_io.h
@@ -1,9 +1,5 @@
 #ifndef _ASM_POWERPC_ISERIES_ISERIES_IO_H
 #define _ASM_POWERPC_ISERIES_ISERIES_IO_H
-
-
-#ifdef CONFIG_PPC_ISERIES
-#include <linux/types.h>
 /*
  * Created by Allan Trautman on Thu Dec 28 2000.
  *
@@ -30,31 +26,12 @@ #include <linux/types.h>
  *   Created December 28, 2000
  * End Change Activity
  */
-
-#ifdef CONFIG_PCI
-extern u8   iSeries_Read_Byte(const volatile void __iomem * IoAddress);
-extern u16  iSeries_Read_Word(const volatile void __iomem * IoAddress);
-extern u32  iSeries_Read_Long(const volatile void __iomem * IoAddress);
-extern void iSeries_Write_Byte(u8  IoData, volatile void __iomem * IoAddress);
-extern void iSeries_Write_Word(u16 IoData, volatile void __iomem * IoAddress);
-extern void iSeries_Write_Long(u32 IoData, volatile void __iomem * IoAddress);
+#include <linux/types.h>
 
 extern void iSeries_memset_io(volatile void __iomem *dest, char x, size_t n);
-extern void iSeries_memcpy_toio(volatile void __iomem *dest, void *source,
+extern void iSeries_memcpy_toio(volatile void __iomem *dest, const void *source,
 		size_t n);
 extern void iSeries_memcpy_fromio(void *dest,
 		const volatile void __iomem *source, size_t n);
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
 
-#endif /* CONFIG_PPC_ISERIES */
 #endif /* _ASM_POWERPC_ISERIES_ISERIES_IO_H */
diff --git a/include/asm-powerpc/ppc-pci.h b/include/asm-powerpc/ppc-pci.h
index cf79bc7..db153ab 100644
--- a/include/asm-powerpc/ppc-pci.h
+++ b/include/asm-powerpc/ppc-pci.h
@@ -51,6 +51,17 @@ extern void pSeries_irq_bus_setup(struct
 
 extern unsigned long pci_probe_only;
 
+/* From platforms/iseries/pci.c */
+#if defined(CONFIG_PPC_ISERIES) && defined(CONFIG_PCI)
+extern int iseries_handle_io_fault(struct pt_regs *regs, unsigned long address);
+#else
+static inline int iseries_handle_io_fault(struct pt_regs *regs,
+		unsigned long address)
+{
+	return 0;
+}
+#endif
+
 /* ---- EEH internal-use-only related routines ---- */
 #ifdef CONFIG_EEH
 
-- 
1.4.1.1
