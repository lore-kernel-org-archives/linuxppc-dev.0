Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E268F67A79
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Mar 2005 10:22:43 +1100 (EST)
Date: Fri, 18 Mar 2005 17:22:38 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503181719250.26300@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix CONFIG_SERIAL_TEXT_DEBUG support on 83xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

The uart initialization for CONFIG_SERIAL_TEXT_DEBUG on 83xx was passing 
in physical addresses instead of effective.  Additional, fix the Kconfig 
support to be for all 83xx devices, not just the MPC834x SYS board.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-03-18 17:15:04 -06:00
+++ b/arch/ppc/Kconfig	2005-03-18 17:15:04 -06:00
@@ -733,7 +733,7 @@
 	depends on SANDPOINT || MCPN765 || SPRUCE || PPLUS || PCORE || \
 		PRPMC750 || K2 || PRPMC800 || LOPEC || \
 		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D || \
-		MPC834x_SYS
+		83xx
 	default y
 
 config FORCE
diff -Nru a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c	2005-03-18 17:15:04 -06:00
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c	2005-03-18 17:15:04 -06:00
@@ -243,14 +243,14 @@
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
-		p.membase = (unsigned char __iomem *)immrbar + 0x4500;
+		p.membase = (unsigned char __iomem *)(VIRT_IMMRBAR + 0x4500);
 		p.uartclk = binfo->bi_busfreq;
 
 		gen550_init(0, &p);
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
-		p.membase = (unsigned char __iomem *)immrbar + 0x4500;
+		p.membase = (unsigned char __iomem *)(VIRT_IMMRBAR + 0x4600);
 		p.uartclk = binfo->bi_busfreq;
 
 		gen550_init(1, &p);
