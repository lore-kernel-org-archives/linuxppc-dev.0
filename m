Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19EDA67A95
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2005 13:36:11 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0501241543530.23252@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0501241543530.23252@blarg.somerset.sps.mot.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 13:35:33 +1100
Message-Id: <1106620533.21888.1.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	rvinson@mvista.com, Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc64: Missing call to ioremap in pci_iomap()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-01-24 at 15:46 -0600, Kumar Gala wrote: 
> The PPC version of pci_iomap seems to be missing a call to ioremap. This 
> patch corrects that oversight and has been tested on a IBM PPC750FX Eval 
> board.

Looks like the ppc64 version as well !

This patch adds the missing ioremap call to pci_iomap on ppc64.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/iomap.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/iomap.c	2005-01-24 11:42:36.000000000 +1100
+++ linux-work/arch/ppc64/kernel/iomap.c	2005-01-25 13:33:13.000000000 +1100
@@ -113,7 +113,7 @@
 	if (flags & IORESOURCE_IO)
 		return ioport_map(start, len);
 	if (flags & IORESOURCE_MEM)
-		return (void __iomem *) start;
+		return ioremap(start, len);
 	/* What? */
 	return NULL;
 }
