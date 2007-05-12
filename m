Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7A852DDEC1
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 00:28:25 +1000 (EST)
Date: Sat, 12 May 2007 09:31:05 -0500
To: paulus@samba.org
Subject: [PATCH] pcmcia: ppc64 needs 64-bit ioaddr_t
Message-ID: <20070512143105.GA12890@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc64 really needs ioaddr_t to be 64-bit, since I/O addresses really
are MMIO addresses, and remapped to a high range.

While the type is exported to userspace, there hasn't been any platforms
with PCMCIA on 64-bit powerpc until now, so changing it won't regress
any existing users.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6.21/include/pcmcia/cs_types.h
===================================================================
--- 2.6.21.orig/include/pcmcia/cs_types.h
+++ 2.6.21/include/pcmcia/cs_types.h
@@ -21,12 +21,17 @@
 #include <sys/types.h>
 #endif
 
+#if defined(__powerpc64__)
+/* I/O addresses are really MMIO addresses on PPC, and can thus be 64 bits */
+typedef unsigned long ioaddr_t;
+#else
 #if defined(__arm__) || defined(__mips__)
 /* This (ioaddr_t) is exposed to userspace & hence cannot be changed. */
 typedef u_int   ioaddr_t;
 #else
 typedef u_short	ioaddr_t;
 #endif
+#endif
 typedef unsigned long kio_addr_t;
 
 typedef u_short	socket_t;
