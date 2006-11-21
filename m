Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D696568460
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 12:35:42 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id kAL1ksEl125516
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 12:46:54 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAL1cwCb148244
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 12:39:03 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAL1ZUOR008011
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 12:35:30 +1100
Subject: [PATCH] powerpc: Fix __raw* accessors
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 12:35:29 +1100
Message-Id: <1164072929.8073.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new IO accessor code allows to stick a token in the top bit of MMIO
addresses which gets masked out during actual accesses. However, the
__raw_* accessors forgot to mask it out. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/include/asm-powerpc/io.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/io.h	2006-11-21 11:01:12.000000000 +1100
+++ linux-cell/include/asm-powerpc/io.h	2006-11-21 11:56:14.000000000 +1100
@@ -185,53 +185,6 @@ extern void _memcpy_toio(volatile void _
  * of the accessors.
  */
 
-
-/*
- * Non ordered and non-swapping "raw" accessors
- */
-
-static inline unsigned char __raw_readb(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned char __force *)addr;
-}
-static inline unsigned short __raw_readw(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned short __force *)addr;
-}
-static inline unsigned int __raw_readl(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned int __force *)addr;
-}
-static inline void __raw_writeb(unsigned char v, volatile void __iomem *addr)
-{
-	*(volatile unsigned char __force *)addr = v;
-}
-static inline void __raw_writew(unsigned short v, volatile void __iomem *addr)
-{
-	*(volatile unsigned short __force *)addr = v;
-}
-static inline void __raw_writel(unsigned int v, volatile void __iomem *addr)
-{
-	*(volatile unsigned int __force *)addr = v;
-}
-
-#ifdef __powerpc64__
-static inline unsigned long __raw_readq(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned long __force *)addr;
-}
-static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
-{
-	*(volatile unsigned long __force *)addr = v;
-}
-#endif /* __powerpc64__ */
-
-/*
- *
- * PCI PIO and MMIO accessors.
- *
- */
-
 /*
  * Include the EEH definitions when EEH is enabled only so they don't get
  * in the way when building for 32 bits
@@ -291,7 +244,52 @@ do {									\
 #define PCI_FIX_ADDR(addr) (addr)
 #endif
 
+
+/*
+ * Non ordered and non-swapping "raw" accessors
+ */
+
+static inline unsigned char __raw_readb(const volatile void __iomem *addr)
+{
+	return *(volatile unsigned char __force *)PCI_FIX_ADDR(addr);
+}
+static inline unsigned short __raw_readw(const volatile void __iomem *addr)
+{
+	return *(volatile unsigned short __force *)PCI_FIX_ADDR(addr);
+}
+static inline unsigned int __raw_readl(const volatile void __iomem *addr)
+{
+	return *(volatile unsigned int __force *)PCI_FIX_ADDR(addr);
+}
+static inline void __raw_writeb(unsigned char v, volatile void __iomem *addr)
+{
+	*(volatile unsigned char __force *)PCI_FIX_ADDR(addr) = v;
+}
+static inline void __raw_writew(unsigned short v, volatile void __iomem *addr)
+{
+	*(volatile unsigned short __force *)PCI_FIX_ADDR(addr) = v;
+}
+static inline void __raw_writel(unsigned int v, volatile void __iomem *addr)
+{
+	*(volatile unsigned int __force *)PCI_FIX_ADDR(addr) = v;
+}
+
+#ifdef __powerpc64__
+static inline unsigned long __raw_readq(const volatile void __iomem *addr)
+{
+	return *(volatile unsigned long __force *)PCI_FIX_ADDR(addr);
+}
+static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
+{
+	*(volatile unsigned long __force *)PCI_FIX_ADDR(addr) = v;
+}
+#endif /* __powerpc64__ */
+
 /*
+ *
+ * PCI PIO and MMIO accessors.
+ *
+ *
  * On 32 bits, PIO operations have a recovery mechanism in case they trigger
  * machine checks (which they occasionally do when probing non existing
  * IO ports on some platforms, like PowerMac and 8xx).
