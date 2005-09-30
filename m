Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5971068411
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2005 13:21:02 +1000 (EST)
Date: Fri, 30 Sep 2005 04:20:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <20050930032057.GE7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] missing qualifiers in readb() et.al. on ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/include/asm-ppc/io.h current/include/asm-ppc/io.h
--- RC14-rc2-git6-base/include/asm-ppc/io.h	2005-06-17 15:48:29.000000000 -0400
+++ current/include/asm-ppc/io.h	2005-09-29 22:47:06.000000000 -0400
@@ -56,7 +56,7 @@
  * is actually performed (i.e. the data has come back) before we start
  * executing any following instructions.
  */
-extern inline int in_8(volatile unsigned char __iomem *addr)
+extern inline int in_8(const volatile unsigned char __iomem *addr)
 {
 	int ret;
 
@@ -72,7 +72,7 @@
 	__asm__ __volatile__("stb%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }
 
-extern inline int in_le16(volatile unsigned short __iomem *addr)
+extern inline int in_le16(const volatile unsigned short __iomem *addr)
 {
 	int ret;
 
@@ -83,7 +83,7 @@
 	return ret;
 }
 
-extern inline int in_be16(volatile unsigned short __iomem *addr)
+extern inline int in_be16(const volatile unsigned short __iomem *addr)
 {
 	int ret;
 
@@ -104,7 +104,7 @@
 	__asm__ __volatile__("sth%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }
 
-extern inline unsigned in_le32(volatile unsigned __iomem *addr)
+extern inline unsigned in_le32(const volatile unsigned __iomem *addr)
 {
 	unsigned ret;
 
@@ -115,7 +115,7 @@
 	return ret;
 }
 
-extern inline unsigned in_be32(volatile unsigned __iomem *addr)
+extern inline unsigned in_be32(const volatile unsigned __iomem *addr)
 {
 	unsigned ret;
 
@@ -139,7 +139,7 @@
 #define readb(addr) in_8((volatile u8 *)(addr))
 #define writeb(b,addr) out_8((volatile u8 *)(addr), (b))
 #else
-static inline __u8 readb(volatile void __iomem *addr)
+static inline __u8 readb(const volatile void __iomem *addr)
 {
 	return in_8(addr);
 }
@@ -150,11 +150,11 @@
 #endif
 
 #if defined(CONFIG_APUS)
-static inline __u16 readw(volatile void __iomem *addr)
+static inline __u16 readw(const volatile void __iomem *addr)
 {
 	return *(__force volatile __u16 *)(addr);
 }
-static inline __u32 readl(volatile void __iomem *addr)
+static inline __u32 readl(const volatile void __iomem *addr)
 {
 	return *(__force volatile __u32 *)(addr);
 }
@@ -173,11 +173,11 @@
 #define writew(b,addr) out_le16((volatile u16 *)(addr),(b))
 #define writel(b,addr) out_le32((volatile u32 *)(addr),(b))
 #else
-static inline __u16 readw(volatile void __iomem *addr)
+static inline __u16 readw(const volatile void __iomem *addr)
 {
 	return in_le16(addr);
 }
-static inline __u32 readl(volatile void __iomem *addr)
+static inline __u32 readl(const volatile void __iomem *addr)
 {
 	return in_le32(addr);
 }
