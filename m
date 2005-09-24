Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id C6F39683B5
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 08:44:52 +1000 (EST)
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.36 #1 (Debian))
	id 1EJIlH-0004zU-00
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 00:44:51 +0200
Date: Sun, 25 Sep 2005 00:44:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509250044420.19187@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH 8/8] apus: update zorro bus access functions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


APUS only needs an eieio() to synchronize IO access, also a simple C
construct to access memory mapped IO is sufficient.

---

 include/asm-ppc/zorro.h |   52 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 8 deletions(-)

Index: linux/include/asm-ppc/zorro.h
===================================================================
--- linux.orig/include/asm-ppc/zorro.h	2005-09-23 15:52:38.000000000 +0200
+++ linux/include/asm-ppc/zorro.h	2005-09-23 16:45:08.000000000 +0200
@@ -3,13 +3,50 @@
 
 #include <asm/io.h>
 
-#define z_readb in_8
-#define z_readw in_be16
-#define z_readl in_be32
-
-#define z_writeb(val, port) out_8((port), (val))
-#define z_writew(val, port) out_be16((port), (val))
-#define z_writel(val, port) out_be32((port), (val))
+static inline unsigned int z_readb(unsigned long addr)
+{
+	unsigned int ret;
+
+	ret = *(volatile u8 *)addr;
+	eieio();
+	return ret;
+}
+
+static inline unsigned int z_readw(unsigned long addr)
+{
+	unsigned int ret;
+
+	ret = *(volatile u16 *)addr;
+	eieio();
+	return ret;
+}
+
+static inline unsigned int z_readl(unsigned long addr)
+{
+	unsigned int ret;
+
+	ret = *(volatile u32 *)addr;
+	eieio();
+	return ret;
+}
+
+static inline void z_writeb(unsigned int val, unsigned long addr)
+{
+	*(volatile u8 *)addr = val;
+	eieio();
+}
+
+static inline void z_writew(unsigned int val, unsigned long addr)
+{
+	*(volatile u16 *)addr = val;
+	eieio();
+}
+
+static inline void z_writel(unsigned int val,unsigned long addr)
+{
+	*(volatile u32 *)addr = val;
+	eieio();
+}
 
 #define z_memset_io(a,b,c)	memset((void *)(a),(b),(c))
 #define z_memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
@@ -19,7 +56,6 @@ extern void *__ioremap(unsigned long add
 		       unsigned long flags);
 
 extern void *ioremap(unsigned long address, unsigned long size);
-extern void iounmap(void *addr);
 
 extern void *__ioremap(unsigned long address, unsigned long size,
                        unsigned long flags);
