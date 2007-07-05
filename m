Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6E972DDF24
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:47 +1000 (EST)
Message-Id: <20070705170234.215137000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:36 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 03/35] Change powerpc64 ioaddr_t to u_int
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc64 really needs ioaddr_t to be 32-bit, since I/O addresses really are
MMIO addresses, and remapped at an offset that's well above 16 bits in
some cases.

While the type is exported to userspace, there hasn't been any platforms
with PCMCIA on 64-bit powerpc until now, so changing it won't regress
any existing users.


Signed-off-by: Olof Johansson <olof@lixom.net>
Acked-by: Paul Mackerras <paulus@samba.org>

Index: 2.6.21/include/pcmcia/cs_types.h
===================================================================
--- 2.6.21.orig/include/pcmcia/cs_types.h
+++ 2.6.21/include/pcmcia/cs_types.h
@@ -21,7 +21,7 @@
 #include <sys/types.h>
 #endif
 
-#if defined(__arm__) || defined(__mips__)
+#if defined(__arm__) || defined(__mips__) || defined(__powerpc64__)
 /* This (ioaddr_t) is exposed to userspace & hence cannot be changed. */
 typedef u_int   ioaddr_t;
 #else

--
