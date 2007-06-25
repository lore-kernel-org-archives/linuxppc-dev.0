Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2FED7DDF05
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 10:45:31 +1000 (EST)
Date: Sun, 24 Jun 2007 19:54:39 -0500
To: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [PATCH] pcmcia: ppc64 needs 32-bit ioaddr_t
Message-ID: <20070625005439.GA31289@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, paulus@samba.org
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
