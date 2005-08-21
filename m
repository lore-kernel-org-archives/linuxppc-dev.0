Return-Path: <a.othieno@bluewin.ch>
Received: from mail13.bluewin.ch (mail13.bluewin.ch [195.186.18.62])
	by ozlabs.org (Postfix) with ESMTP id 8E7ED67FA5
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Aug 2005 11:39:09 +1000 (EST)
Received: from localhost.localdomain (62.202.87.184) by mail13.bluewin.ch
	(Bluewin 7.2.063) id 42DF674800541D79 for linuxppc-dev@ozlabs.org;
	Sun, 21 Aug 2005 01:16:33 +0000
Date: Sat, 20 Aug 2005 21:16:49 -0400
To: linuxppc-dev@ozlabs.org
Message-ID: <20050821011649.GA31839@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: a.othieno@bluewin.ch (Arthur Othieno)
Subject: [PATCH] ppc32: Big-endian I/O memory accessors.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I/O memory accessors. Big-endian version. For those busses/devices
that do export big-endian I/O memory.

Of notable relevance/reference:

   http://lwn.net/Articles/132804/
   http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019798.html
   http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019752.html

Signed-Off-By: Arthur Othieno <a.othieno@bluewin.ch>


  io.h |   20 ++++++++++++++++++++
  1 files changed, 20 insertions(+)


--- a/include/asm-ppc/io.h	2005-08-20 19:24:40.000000000 -0400
+++ b/include/asm-ppc/io.h	2005-08-20 20:18:03.000000000 -0400
@@ -487,11 +487,21 @@
 	return readw(addr);
 }
 
+static inline unsigned int ioread16be(void __iomem *addr)
+{
+	return __raw_readw(addr);
+}
+
 static inline unsigned int ioread32(void __iomem *addr)
 {
 	return readl(addr);
 }
 
+static inline unsigned int ioread32be(void __iomem *addr)
+{
+	return __raw_readl(addr);
+}
+
 static inline void iowrite8(u8 val, void __iomem *addr)
 {
 	writeb(val, addr);
@@ -502,11 +512,21 @@
 	writew(val, addr);
 }
 
+static inline void iowrite16be(u16 val, void __iomem *addr)
+{
+	__raw_writew(val, addr);
+}
+
 static inline void iowrite32(u32 val, void __iomem *addr)
 {
 	writel(val, addr);
 }
 
+static inline void iowrite32be(u32 val, void __iomem *addr)
+{
+	__raw_writel(val, addr);
+}
+
 static inline void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 {
 	_insb(addr, dst, count);
