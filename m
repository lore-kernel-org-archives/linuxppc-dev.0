Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 839D8DDFBC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:18 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1XBd1027064
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:12 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1XBcf001201
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:11 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18Uaf007844
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:30 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 54993AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:10 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1XATO015284
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:33:10 -0500
Date: Tue, 17 Jul 2007 20:33:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/61] bootwrapper: Add 16-bit I/O.
Message-ID: <20070718013310.GJ15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/boot/io.h |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
index 32974ed..ff3aa19 100644
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
-- 
1.5.0.3
