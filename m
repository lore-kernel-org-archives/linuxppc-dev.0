Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 69329DDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 14:30:39 +1000 (EST)
Date: Mon, 14 May 2007 23:33:43 -0500
To: paulus@samba.org
Subject: [PATCH v2] pcmcia: ppc64 needs 32-bit ioaddr_t
Message-ID: <20070515043343.GA6561@lixom.net>
References: <20070512143105.GA12890@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070512143105.GA12890@lixom.net>
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

ppc64 really needs ioaddr_t to be 32-bit, since I/O beyond the
first PCI bus might be mapped at a higher range.

While the type is exported to userspace, there hasn't been any platforms
with PCMCIA on 64-bit powerpc until now, so changing it won't regress
any existing users. Besides, those interfaces are overdue for removal
already.


Signed-off-by: Olof Johansson <olof@lixom.net>

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
