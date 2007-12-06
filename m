Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 09658DE22D
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:58 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id B3D9C368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:57 +1100 (EST)
Date: Fri, 7 Dec 2007 01:53:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 09/19] [POWERPC] iSeries: remove one layer of IO routines
Message-Id: <20071207015344.c903f3e1.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c |   68 +++++++++------------------------
 1 files changed, 19 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 105b23d..8844d3e 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -382,7 +382,7 @@ static inline struct device_node *xlate_iomm_address(
  * On MM I/O error, all ones are returned and iSeries_pci_IoError is cal
  * else, data is returned in Big Endian format.
  */
-static u8 iSeries_read_byte(const volatile void __iomem *addr)
+static u8 iseries_readb(const volatile void __iomem *addr)
 {
 	u64 bar_offset;
 	u64 dsa;
@@ -400,7 +400,7 @@ static u8 iSeries_read_byte(const volatile void __iomem *addr)
 	return ret.value;
 }
 
-static u16 iSeries_read_word(const volatile void __iomem *addr)
+static u16 iseries_readw_be(const volatile void __iomem *addr)
 {
 	u64 bar_offset;
 	u64 dsa;
@@ -419,7 +419,7 @@ static u16 iSeries_read_word(const volatile void __iomem *addr)
 	return ret.value;
 }
 
-static u32 iSeries_read_long(const volatile void __iomem *addr)
+static u32 iseries_readl_be(const volatile void __iomem *addr)
 {
 	u64 bar_offset;
 	u64 dsa;
@@ -442,7 +442,7 @@ static u32 iSeries_read_long(const volatile void __iomem *addr)
  * Write MM I/O Instructions for the iSeries
  *
  */
-static void iSeries_write_byte(u8 data, volatile void __iomem *addr)
+static void iseries_writeb(u8 data, volatile void __iomem *addr)
 {
 	u64 bar_offset;
 	u64 dsa;
@@ -458,7 +458,7 @@ static void iSeries_write_byte(u8 data, volatile void __iomem *addr)
 	} while (check_return_code("WWB", dn, &retry, rc) != 0);
 }
 
-static void iSeries_write_word(u16 data, volatile void __iomem *addr)
+static void iseries_writew_be(u16 data, volatile void __iomem *addr)
 {
 	u64 bar_offset;
 	u64 dsa;
@@ -474,7 +474,7 @@ static void iSeries_write_word(u16 data, volatile void __iomem *addr)
 	} while (check_return_code("WWW", dn, &retry, rc) != 0);
 }
 
-static void iSeries_write_long(u32 data, volatile void __iomem *addr)
+static void iseries_writel_be(u32 data, volatile void __iomem *addr)
 {
 	u64 bar_offset;
 	u64 dsa;
@@ -490,54 +490,24 @@ static void iSeries_write_long(u32 data, volatile void __iomem *addr)
 	} while (check_return_code("WWL", dn, &retry, rc) != 0);
 }
 
-static u8 iseries_readb(const volatile void __iomem *addr)
-{
-	return iSeries_read_byte(addr);
-}
-
 static u16 iseries_readw(const volatile void __iomem *addr)
 {
-	return le16_to_cpu(iSeries_read_word(addr));
+	return le16_to_cpu(iseries_readw_be(addr));
 }
 
 static u32 iseries_readl(const volatile void __iomem *addr)
 {
-	return le32_to_cpu(iSeries_read_long(addr));
-}
-
-static u16 iseries_readw_be(const volatile void __iomem *addr)
-{
-	return iSeries_read_word(addr);
-}
-
-static u32 iseries_readl_be(const volatile void __iomem *addr)
-{
-	return iSeries_read_long(addr);
-}
-
-static void iseries_writeb(u8 data, volatile void __iomem *addr)
-{
-	iSeries_write_byte(data, addr);
+	return le32_to_cpu(iseries_readl_be(addr));
 }
 
 static void iseries_writew(u16 data, volatile void __iomem *addr)
 {
-	iSeries_write_word(cpu_to_le16(data), addr);
+	iseries_writew_be(cpu_to_le16(data), addr);
 }
 
 static void iseries_writel(u32 data, volatile void __iomem *addr)
 {
-	iSeries_write_long(cpu_to_le32(data), addr);
-}
-
-static void iseries_writew_be(u16 data, volatile void __iomem *addr)
-{
-	iSeries_write_word(data, addr);
-}
-
-static void iseries_writel_be(u32 data, volatile void __iomem *addr)
-{
-	iSeries_write_long(data, addr);
+	iseries_writel(cpu_to_le32(data), addr);
 }
 
 static void iseries_readsb(const volatile void __iomem *addr, void *buf,
@@ -545,7 +515,7 @@ static void iseries_readsb(const volatile void __iomem *addr, void *buf,
 {
 	u8 *dst = buf;
 	while(count-- > 0)
-		*(dst++) = iSeries_read_byte(addr);
+		*(dst++) = iseries_readb(addr);
 }
 
 static void iseries_readsw(const volatile void __iomem *addr, void *buf,
@@ -553,7 +523,7 @@ static void iseries_readsw(const volatile void __iomem *addr, void *buf,
 {
 	u16 *dst = buf;
 	while(count-- > 0)
-		*(dst++) = iSeries_read_word(addr);
+		*(dst++) = iseries_readw_be(addr);
 }
 
 static void iseries_readsl(const volatile void __iomem *addr, void *buf,
@@ -561,7 +531,7 @@ static void iseries_readsl(const volatile void __iomem *addr, void *buf,
 {
 	u32 *dst = buf;
 	while(count-- > 0)
-		*(dst++) = iSeries_read_long(addr);
+		*(dst++) = iseries_readl_be(addr);
 }
 
 static void iseries_writesb(volatile void __iomem *addr, const void *buf,
@@ -569,7 +539,7 @@ static void iseries_writesb(volatile void __iomem *addr, const void *buf,
 {
 	const u8 *src = buf;
 	while(count-- > 0)
-		iSeries_write_byte(*(src++), addr);
+		iseries_writeb(*(src++), addr);
 }
 
 static void iseries_writesw(volatile void __iomem *addr, const void *buf,
@@ -577,7 +547,7 @@ static void iseries_writesw(volatile void __iomem *addr, const void *buf,
 {
 	const u16 *src = buf;
 	while(count-- > 0)
-		iSeries_write_word(*(src++), addr);
+		iseries_writew_be(*(src++), addr);
 }
 
 static void iseries_writesl(volatile void __iomem *addr, const void *buf,
@@ -585,7 +555,7 @@ static void iseries_writesl(volatile void __iomem *addr, const void *buf,
 {
 	const u32 *src = buf;
 	while(count-- > 0)
-		iSeries_write_long(*(src++), addr);
+		iseries_writel_be(*(src++), addr);
 }
 
 static void iseries_memset_io(volatile void __iomem *addr, int c,
@@ -594,7 +564,7 @@ static void iseries_memset_io(volatile void __iomem *addr, int c,
 	volatile char __iomem *d = addr;
 
 	while (n-- > 0)
-		iSeries_write_byte(c, d++);
+		iseries_writeb(c, d++);
 }
 
 static void iseries_memcpy_fromio(void *dest, const volatile void __iomem *src,
@@ -604,7 +574,7 @@ static void iseries_memcpy_fromio(void *dest, const volatile void __iomem *src,
 	const volatile char __iomem *s = src;
 
 	while (n-- > 0)
-		*d++ = iSeries_read_byte(s++);
+		*d++ = iseries_readb(s++);
 }
 
 static void iseries_memcpy_toio(volatile void __iomem *dest, const void *src,
@@ -614,7 +584,7 @@ static void iseries_memcpy_toio(volatile void __iomem *dest, const void *src,
 	volatile char __iomem *d = dest;
 
 	while (n-- > 0)
-		iSeries_write_byte(*s++, d++);
+		iseries_writeb(*s++, d++);
 }
 
 /* We only set MMIO ops. The default PIO ops will be default
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
