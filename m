Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 4B7A667A73
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2005 11:28:38 +1100 (EST)
Date: Mon, 24 Jan 2005 15:46:20 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0501241543530.23252@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, rvinson@mvista.com, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Missing call to ioremap in pci_iomap()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PPC version of pci_iomap seems to be missing a call to ioremap. This 
patch corrects that oversight and has been tested on a IBM PPC750FX Eval 
board.

Signed-off-by Randy Vinson <rvinson@mvista.com>
Signed-off-by Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c	2005-01-24 15:43:19 -06:00
+++ b/arch/ppc/kernel/pci.c	2005-01-24 15:43:19 -06:00
@@ -1712,7 +1712,11 @@
 	if (flags & IORESOURCE_IO)
 		return ioport_map(start, len);
 	if (flags & IORESOURCE_MEM)
-		return (void __iomem *) start;
+		/* Not checking IORESOURCE_CACHEABLE because PPC does
+		 * not currently distinguish between ioremap and
+		 * ioremap_nocache.
+		 */
+		return ioremap(start, len);
 	/* What? */
 	return NULL;
 }
