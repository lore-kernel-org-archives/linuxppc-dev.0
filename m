Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 8F78E67A83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 11:04:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 26 Jan 2005 18:03:59 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592A7@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: [PATCH]PCI9 errata workaround broken
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Changeset 1.1938.196.11 broke MPC8260 PCI9 Errata workaround.
This pach makes it work again.

Signed-off-by: Rune Torgersen <runet@innovsys.com>

=3D=3D=3D=3D=3D include/asm-ppc/io.h 1.29 vs edited =3D=3D=3D=3D=3D
--- 1.29/include/asm-ppc/io.h   2005-01-26 17:15:02 -06:00
+++ edited/include/asm-ppc/io.h 2005-01-26 17:54:11 -06:00
@@ -133,7 +133,10 @@
 {
        __asm__ __volatile__("stw%U0%X0 %1,%0; eieio" : "=3Dm" (*addr) :
"r" (val));
 }
-
+#if defined (CONFIG_8260_PCI9)
+#define readb(addr) in_8((volatile u8 *)(addr))
+#define writeb(b,addr) out_8((volatile u8 *)(addr), (b))
+#else
 static inline __u8 readb(volatile void __iomem *addr)
 {
        return in_8(addr);
@@ -142,6 +145,8 @@
 {
        out_8(addr, b);
 }
+#endif
+
 #if defined(CONFIG_APUS)
 static inline __u16 readw(volatile void __iomem *addr)
 {
@@ -159,6 +164,12 @@
 {
        *(__force volatile __u32 *)(addr) =3D b;
 }
+#elif defined (CONFIG_8260_PCI9)
+/* Use macros if PCI9 workaround enabled */
+#define readw(addr) in_le16((volatile u16 *)(addr))
+#define readl(addr) in_le32((volatile u32 *)(addr))
+#define writew(b,addr) out_le16((volatile u16 *)(addr),(b))
+#define writel(b,addr) out_le32((volatile u32 *)(addr),(b))
 #else
 static inline __u16 readw(volatile void __iomem *addr)
 {
@@ -332,6 +343,11 @@

 #define IO_SPACE_LIMIT ~0

+#if defined (CONFIG_8260_PCI9)
+#define memset_io(a,b,c)       memset((void *)(a),(b),(c))
+#define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
+#define memcpy_toio(a,b,c)     memcpy((void *)(a),(b),(c))
+#else
 static inline void memset_io(volatile void __iomem *addr, unsigned char
val, int count)
 {
        memset((void __force *)addr, val, count);
@@ -344,7 +360,7 @@
 {
        memcpy((void __force *) dst, src, count);
 }
-
+#endif
 /*
  * Map in an area of physical address space, for accessing
  * I/O devices etc.

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com
