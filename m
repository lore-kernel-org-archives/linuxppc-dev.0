Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D6D19679E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 May 2005 08:09:06 +1000 (EST)
Date: Fri, 27 May 2005 17:08:36 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505271707530.25368@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: MPC834x BCSR_SIZE too small for use in a BAT.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The call to io_block_mapping was creating an invalid BAT entry because
the value of BCSR_SIZE (32K) is too small to be used in a BAT (128K min).
This change removes the io_block_mapping call since these registers can
easily be mapped using ioremap at the point of use.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 2c6dd281d28694239de9e453541ed3b937d11e25
tree 0d93680a000f9dafe78831ee00573c1bb544bcf6
parent 4ec5240ec367a592834385893200dd4fb369354c
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 26 May 2005 19:14:39 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 26 May 2005 19:14:39 -0500

 ppc/platforms/83xx/mpc834x_sys.c |    1 -
 ppc/platforms/83xx/mpc834x_sys.h |    1 -
 2 files changed, 2 deletions(-)

Index: arch/ppc/platforms/83xx/mpc834x_sys.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/arch/ppc/platforms/83xx/mpc834x_sys.c  (mode:100644)
+++ 0d93680a000f9dafe78831ee00573c1bb544bcf6/arch/ppc/platforms/83xx/mpc834x_sys.c  (mode:100644)
@@ -127,7 +127,6 @@
 {
 	/* we steal the lowest ioremap addr for virt space */
 	io_block_mapping(VIRT_IMMRBAR, immrbar, 1024*1024, _PAGE_IO);
-	io_block_mapping(BCSR_VIRT_ADDR, BCSR_PHYS_ADDR, BCSR_SIZE, _PAGE_IO);
 }
 
 int
Index: arch/ppc/platforms/83xx/mpc834x_sys.h
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
+++ 0d93680a000f9dafe78831ee00573c1bb544bcf6/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
@@ -26,7 +26,6 @@
 #define VIRT_IMMRBAR		((uint)0xfe000000)
 
 #define BCSR_PHYS_ADDR		((uint)0xf8000000)
-#define BCSR_VIRT_ADDR		((uint)0xfe100000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
 #ifdef CONFIG_PCI
