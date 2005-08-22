Return-Path: <a.othieno@bluewin.ch>
Received: from mail13.bluewin.ch (mail13.bluewin.ch [195.186.18.62])
	by ozlabs.org (Postfix) with ESMTP id 18C3967FEA
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2005 22:51:33 +1000 (EST)
Date: Mon, 22 Aug 2005 08:51:46 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050822125146.GA811@mars>
References: <20050821011649.GA31839@mars> <1124659361.5197.121.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1124659361.5197.121.camel@gaston>
From: a.othieno@bluewin.ch (Arthur Othieno)
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: Big-endian I/O memory accessors.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2005 at 07:22:41AM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2005-08-20 at 21:16 -0400, Arthur Othieno wrote:
> > I/O memory accessors. Big-endian version. For those busses/devices
> > that do export big-endian I/O memory.
> 
> No, that's not correct. You need to use the in_be/out_be variants which
> provide proper memory barriers.
> 
> Ben.

Oops. Silly me. Updated patch inline.

Signed-Off-By: Arthur Othieno <a.othieno@bluewin.ch>


 io.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)
 
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
