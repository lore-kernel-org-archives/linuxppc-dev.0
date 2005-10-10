Return-Path: <a.othieno@bluewin.ch>
Received: from mail21.bluewin.ch (mail21.bluewin.ch [195.186.18.66])
	by ozlabs.org (Postfix) with ESMTP id 6755D684C7
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2005 08:01:45 +1000 (EST)
Date: Mon, 10 Oct 2005 17:50:21 -0400
To: paulus@samba.org
Message-ID: <20051010215021.GA5854@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: a.othieno@bluewin.ch (Arthur Othieno)
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Big-endian I/O memory accessors.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arthur Othieno <a.othieno@bluewin.ch>

I/O memory accessors. Big endian version. For those busses/devices
that do export big-endian I/O memory.

Of notable relevance/reference:

  http://lwn.net/Articles/132804/
  http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019798.html
  http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019752.html

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>
---

Paulus, 

A similar patch for ppc64 made it upstream with your big ppc64 merge.
This one is still sitting in http://patchwork.ozlabs.org/linuxppc/
and didn't make it with the ppc32 equivalent. Thanks.


 include/asm-ppc/io.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff -uprN a/include/asm-ppc/io.h b/include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	2005-08-21 17:49:44.000000000 -0400
+++ b/include/asm-ppc/io.h	2005-08-21 20:29:55.000000000 -0400
@@ -487,11 +487,21 @@ static inline unsigned int ioread16(void
 	return readw(addr);
 }
 
+static inline unsigned int ioread16be(void __iomem *addr)
+{
+	return in_be16(addr);
+}
+
 static inline unsigned int ioread32(void __iomem *addr)
 {
 	return readl(addr);
 }
 
+static inline unsigned int ioread32be(void __iomem *addr)
+{
+	return in_be32(addr);
+}
+
 static inline void iowrite8(u8 val, void __iomem *addr)
 {
 	writeb(val, addr);
@@ -502,11 +512,21 @@ static inline void iowrite16(u16 val, vo
 	writew(val, addr);
 }
 
+static inline void iowrite16be(u16 val, void __iomem *addr)
+{
+	out_be16(addr, val);
+}
+
 static inline void iowrite32(u32 val, void __iomem *addr)
 {
 	writel(val, addr);
 }
 
+static inline void iowrite32be(u32 val, void __iomem *addr)
+{
+	out_be32(addr, val);
+}
+
 static inline void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 {
 	_insb(addr, dst, count);
