Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A60DDDF15
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 19:59:08 +1000 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH] celleb_scc_pciex endianness misannotations
Message-Id: <E1K36og-0007Yr-HC@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 02 Jun 2008 10:59:02 +0100
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/powerpc/platforms/cell/celleb_scc_pciex.c b/arch/powerpc/platforms/cell/celleb_scc_pciex.c
index 31da84c..0e04f8f 100644
--- a/arch/powerpc/platforms/cell/celleb_scc_pciex.c
+++ b/arch/powerpc/platforms/cell/celleb_scc_pciex.c
@@ -217,7 +217,7 @@ static u##size scc_pciex_in##name(unsigned long port)			\
 static void scc_pciex_ins##name(unsigned long p, void *b, unsigned long c) \
 {									\
 	struct iowa_bus *bus = iowa_pio_find_bus(p);			\
-	u##size *dst = b;						\
+	__le##size *dst = b;						\
 	for (; c != 0; c--, dst++)					\
 		*dst = cpu_to_le##size(__scc_pciex_in##name(bus->phb, p)); \
 	scc_pciex_io_flush(bus);					\
@@ -231,10 +231,11 @@ static void scc_pciex_outs##name(unsigned long p, const void *b,	\
 				 unsigned long c)			\
 {									\
 	struct iowa_bus *bus = iowa_pio_find_bus(p);			\
-	const u##size *src = b;						\
+	const __le##size *src = b;					\
 	for (; c != 0; c--, src++)					\
 		__scc_pciex_out##name(bus->phb, le##size##_to_cpu(*src), p); \
 }
+#define __le8 u8
 #define cpu_to_le8(x) (x)
 #define le8_to_cpu(x) (x)
 PCIEX_PIO_FUNC(8, b)
