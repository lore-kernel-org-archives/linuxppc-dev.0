Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1FDD2DDEBA
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:39:59 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 06/20] bootwrapper: Add 16-bit I/O, sync(), eieio(),
	and barrier().
Message-ID: <20070820173951.GE30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also, include types.h from io.h, so callers don't have to.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/io.h |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
index 32974ed..ccaedae 100644
--- a/arch/powerpc/boot/io.h
+++ b/arch/powerpc/boot/io.h
@@ -1,5 +1,8 @@
 #ifndef _IO_H
 #define __IO_H
+
+#include "types.h"
+
 /*
  * Low-level I/O routines.
  *
@@ -20,6 +23,37 @@ static inline void out_8(volatile unsigned char *addr, int val)
 			     : "=m" (*addr) : "r" (val));
 }
 
+static inline unsigned in_le16(const volatile u16 *addr)
+{
+	unsigned ret;
+
+	__asm__ __volatile__("lhbrx %0,0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "r" (addr), "m" (*addr));
+
+	return ret;
+}
+
+static inline unsigned in_be16(const volatile u16 *addr)
+{
+	unsigned ret;
+
+	__asm__ __volatile__("lhz%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
+	return ret;
+}
+
+static inline void out_le16(volatile u16 *addr, int val)
+{
+	__asm__ __volatile__("sthbrx %1,0,%2; sync" : "=m" (*addr)
+			     : "r" (val), "r" (addr));
+}
+
+static inline void out_be16(volatile u16 *addr, int val)
+{
+	__asm__ __volatile__("sth%U0%X0 %1,%0; sync"
+			     : "=m" (*addr) : "r" (val));
+}
+
 static inline unsigned in_le32(const volatile unsigned *addr)
 {
 	unsigned ret;
@@ -50,4 +84,19 @@ static inline void out_be32(volatile unsigned *addr, int val)
 			     : "=m" (*addr) : "r" (val));
 }
 
+static inline void sync(void)
+{
+	asm volatile("sync" : : : "memory");
+}
+
+static inline void eieio(void)
+{
+	asm volatile("eieio" : : : "memory");
+}
+
+static inline void barrier(void)
+{
+	asm volatile("" : : : "memory");
+}
+
 #endif /* _IO_H */
-- 
1.5.0.3
