Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A3BE3DDE28
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 00:29:41 +1000 (EST)
Date: Sat, 12 May 2007 09:32:22 -0500
To: paulus@samba.org
Subject: [PATCH] powerpc: make ioport_map() handle already mapped ranges
Message-ID: <20070512143221.GB12890@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make ioport_map() handle already mapped port range without trying
to add _IO_BASE to them.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6.21/arch/powerpc/kernel/iomap.c
===================================================================
--- 2.6.21.orig/arch/powerpc/kernel/iomap.c
+++ 2.6.21/arch/powerpc/kernel/iomap.c
@@ -106,7 +106,13 @@ EXPORT_SYMBOL(iowrite32_rep);
 
 void __iomem *ioport_map(unsigned long port, unsigned int len)
 {
-	return (void __iomem *) (port + _IO_BASE);
+	/* Do nothing if we're being asked to map an already
+	 * ioremapped() address
+	 */
+	if (port >= IMALLOC_BASE && (port+len) < IMALLOC_END)
+		return (void __iomem *) port;
+	else
+		return (void __iomem *) (port + _IO_BASE);
 }
 
 void ioport_unmap(void __iomem *addr)
