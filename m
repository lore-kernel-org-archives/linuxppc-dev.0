Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A4A5367B41
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 17:58:23 +1000 (EST)
Date: Fri, 7 Apr 2006 17:57:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [RFC][PATCH] first pass at iSeries io rewrite
Message-Id: <20060407175749.4c43759d.sfr@canb.auug.org.au>
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

We would like to reduce the special casing of things for legacy iSeries
generally.  This patch starts the work on iSeries i/o.  This changes the
i/o so that iSeries will take a fault if any i/o is attempted and the
appripriate instructions are emulated.  To make this easier, some of the
i/o primitives have been modified to use a simple set of load/store
instructions with the target or source fixed to r0.

This also (strangely) shrinks a normal pSeries built kernel text by about
130 bytes (but adds 256 bytes to its data).

Before this change, typical outw() took about 1650 - 2740 cycles and
afterward about 2190 - 9020 cycles.  The variablilty is interesting and is
probably not only due to these changes.

This does not yet handle memset_io, memcopy_fromio and memcpy_toio.

Some possibilities:
	try to shorten the fault path
	doing a fixup on the fist trap

Suggestions? Comments?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

---

 arch/powerpc/mm/fault.c                  |    8 ++
 arch/powerpc/platforms/iseries/pci.c     |  139 +++++++++++++++++++-----------
 include/asm-powerpc/io.h                 |   81 +++++------------
 include/asm-powerpc/iseries/iseries_io.h |   19 ----
 include/asm-powerpc/ppc-pci.h            |   11 ++
 5 files changed, 128 insertions(+), 130 deletions(-)

51ff17bea4b0434067e0d3b2fa58493227619baa
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index fdbba42..c0b1986 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -39,6 +39,8 @@
 #include <asm/tlbflush.h>
 #include <asm/kdebug.h>
 #include <asm/siginfo.h>
+#include <asm/firmware.h>
+#include <asm/ppc-pci.h>
 
 /*
  * Check whether the instruction at regs->nip is a store using
@@ -152,8 +154,12 @@ int __kprobes do_page_fault(struct pt_re
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
index a19833b..3631995 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/ide.h>
 #include <linux/pci.h>
+#include <linux/ptrace.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -37,6 +38,7 @@
 
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/mf.h>
+#include <asm/iseries/iseries_io.h>
 
 #include <asm/ppc-pci.h>
 
@@ -465,46 +467,6 @@ static int scan_bridge_slot(HvBusNumber 
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
@@ -685,7 +647,7 @@ static inline struct device_node *xlate_
  * iSeries_Read_Word = Read Word  (16 bit)
  * iSeries_Read_Long = Read Long  (32 bit)
  */
-u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
+static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -713,9 +675,8 @@ u8 iSeries_Read_Byte(const volatile void
 
 	return (u8)ret.value;
 }
-EXPORT_SYMBOL(iSeries_Read_Byte);
 
-u16 iSeries_Read_Word(const volatile void __iomem *IoAddress)
+static u16 iSeries_Read_Word(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -744,9 +705,8 @@ u16 iSeries_Read_Word(const volatile voi
 
 	return swab16((u16)ret.value);
 }
-EXPORT_SYMBOL(iSeries_Read_Word);
 
-u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
+static u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -775,7 +735,6 @@ u32 iSeries_Read_Long(const volatile voi
 
 	return swab32((u32)ret.value);
 }
-EXPORT_SYMBOL(iSeries_Read_Long);
 
 /*
  * Write MM I/O Instructions for the iSeries
@@ -784,7 +743,7 @@ EXPORT_SYMBOL(iSeries_Read_Long);
  * iSeries_Write_Word = Write Word(16 bit)
  * iSeries_Write_Long = Write Long(32 bit)
  */
-void iSeries_Write_Byte(u8 data, volatile void __iomem *IoAddress)
+static void iSeries_Write_Byte(u8 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -810,9 +769,8 @@ void iSeries_Write_Byte(u8 data, volatil
 		rc = HvCall4(HvCallPciBarStore8, dsa, BarOffset, data, 0);
 	} while (CheckReturnCode("WWB", DevNode, &retry, rc) != 0);
 }
-EXPORT_SYMBOL(iSeries_Write_Byte);
 
-void iSeries_Write_Word(u16 data, volatile void __iomem *IoAddress)
+static void iSeries_Write_Word(u16 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -838,9 +796,8 @@ void iSeries_Write_Word(u16 data, volati
 		rc = HvCall4(HvCallPciBarStore16, dsa, BarOffset, swab16(data), 0);
 	} while (CheckReturnCode("WWW", DevNode, &retry, rc) != 0);
 }
-EXPORT_SYMBOL(iSeries_Write_Word);
 
-void iSeries_Write_Long(u32 data, volatile void __iomem *IoAddress)
+static void iSeries_Write_Long(u32 data, volatile void __iomem *IoAddress)
 {
 	u64 BarOffset;
 	u64 dsa;
@@ -866,4 +823,82 @@ void iSeries_Write_Long(u32 data, volati
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
+void iSeries_memcpy_toio(volatile void __iomem *dest, void *source, size_t count)
+{
+	char *src = source;
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
index 68efbea..0725c11 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -16,9 +16,6 @@
 #include <linux/compiler.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>
-#ifdef CONFIG_PPC_ISERIES 
-#include <asm/iseries/iseries_io.h>
-#endif  
 #include <asm/synch.h>
 #include <asm/delay.h>
 
@@ -44,41 +41,6 @@ extern unsigned long io_page_mask;
 #define _IO_IS_VALID(port) ((port) >= MAX_ISA_PORT || (1 << (port>>PAGE_SHIFT)) \
 			    & io_page_mask)
 
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
-/*
- * The *_ns versions below don't do byte-swapping.
- * Neither do the standard versions now, these are just here
- * for older code.
- */
-#define insw_ns(port, buf, ns)	_insw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insl_ns(port, buf, nl)	_insl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
-#else
-
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
 {
 	return *(volatile unsigned char __force *)addr;
@@ -144,8 +106,6 @@ static inline void __raw_writeq(unsigned
 #define outsw(port, buf, ns)  _outsw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define outsl(port, buf, nl)  _outsl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 
-#endif
-
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
@@ -273,25 +233,30 @@ static inline void iosync(void)
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
 
-static inline void out_8(volatile unsigned char __iomem *addr, int val)
+static inline void out_8(volatile unsigned char __iomem *addr, int ival)
 {
-	__asm__ __volatile__("stb%U0%X0 %1,%0; sync"
-			     : "=m" (*addr) : "r" (val));
+	register unsigned int val __asm__("r0") = ival;
+
+	__asm__ __volatile__("stbx %0,0,%1; sync"
+			     : : "r" (val), "r" (addr));
 }
 
 static inline int in_le16(const volatile unsigned short __iomem *addr)
 {
-	int ret;
+	register unsigned int ret __asm__("r0");
 
 	__asm__ __volatile__("lhbrx %0,0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "r" (addr), "m" (*addr));
@@ -307,10 +272,12 @@ static inline int in_be16(const volatile
 	return ret;
 }
 
-static inline void out_le16(volatile unsigned short __iomem *addr, int val)
+static inline void out_le16(volatile unsigned short __iomem *addr, int ival)
 {
-	__asm__ __volatile__("sthbrx %1,0,%2; sync"
-			     : "=m" (*addr) : "r" (val), "r" (addr));
+	register unsigned int val __asm__("r0") = ival;
+
+	__asm__ __volatile__("sthbrx %0,0,%1; sync"
+			     : : "r" (val), "r" (addr));
 }
 
 static inline void out_be16(volatile unsigned short __iomem *addr, int val)
@@ -321,7 +288,7 @@ static inline void out_be16(volatile uns
 
 static inline unsigned in_le32(const volatile unsigned __iomem *addr)
 {
-	unsigned ret;
+	register unsigned int ret __asm__("r0");
 
 	__asm__ __volatile__("lwbrx %0,0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "r" (addr), "m" (*addr));
@@ -337,10 +304,12 @@ static inline unsigned in_be32(const vol
 	return ret;
 }
 
-static inline void out_le32(volatile unsigned __iomem *addr, int val)
+static inline void out_le32(volatile unsigned __iomem *addr, int ival)
 {
-	__asm__ __volatile__("stwbrx %1,0,%2; sync" : "=m" (*addr)
-			     : "r" (val), "r" (addr));
+	register unsigned int val __asm__("r0") = ival;
+
+	__asm__ __volatile__("stwbrx %1,0,%2; sync"
+			     : "=m" (*addr) : "r" (val), "r" (addr));
 }
 
 static inline void out_be32(volatile unsigned __iomem *addr, int val)
@@ -399,9 +368,7 @@ static inline void out_be64(volatile uns
 	__asm__ __volatile__("std%U0%X0 %1,%0; sync" : "=m" (*addr) : "r" (val));
 }
 
-#ifndef CONFIG_PPC_ISERIES 
 #include <asm/eeh.h>
-#endif
 
 /**
  *	check_signature		-	find BIOS signatures
@@ -417,7 +384,6 @@ static inline int check_signature(const 
 	const unsigned char *signature, int length)
 {
 	int retval = 0;
-#ifndef CONFIG_PPC_ISERIES 
 	do {
 		if (readb(io_addr) != *signature)
 			goto out;
@@ -427,7 +393,6 @@ static inline int check_signature(const 
 	} while (length);
 	retval = 1;
 out:
-#endif
 	return retval;
 }
 
diff --git a/include/asm-powerpc/iseries/iseries_io.h b/include/asm-powerpc/iseries/iseries_io.h
index 496aa85..5be0a73 100644
--- a/include/asm-powerpc/iseries/iseries_io.h
+++ b/include/asm-powerpc/iseries/iseries_io.h
@@ -1,8 +1,6 @@
 #ifndef _ASM_POWERPC_ISERIES_ISERIES_IO_H
 #define _ASM_POWERPC_ISERIES_ISERIES_IO_H
 
-#include <linux/config.h>
-
 #ifdef CONFIG_PPC_ISERIES
 #include <linux/types.h>
 /*
@@ -33,28 +31,11 @@
  */
 
 #ifdef CONFIG_PCI
-extern u8   iSeries_Read_Byte(const volatile void __iomem * IoAddress);
-extern u16  iSeries_Read_Word(const volatile void __iomem * IoAddress);
-extern u32  iSeries_Read_Long(const volatile void __iomem * IoAddress);
-extern void iSeries_Write_Byte(u8  IoData, volatile void __iomem * IoAddress);
-extern void iSeries_Write_Word(u16 IoData, volatile void __iomem * IoAddress);
-extern void iSeries_Write_Long(u32 IoData, volatile void __iomem * IoAddress);
-
 extern void iSeries_memset_io(volatile void __iomem *dest, char x, size_t n);
 extern void iSeries_memcpy_toio(volatile void __iomem *dest, void *source,
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
 #endif	/* CONFIG_PCI */
 
 #endif /* CONFIG_PPC_ISERIES */
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
1.2.4
