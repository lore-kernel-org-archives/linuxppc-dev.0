Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 58086679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 May 2005 01:36:46 +1000 (EST)
Date: Wed, 25 May 2005 10:36:24 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505251035320.13355@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: shall@mvista.com, linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix building MPC8555 CDS when CONFIG_PCI is disabled
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The patch that introduced support for the VIA chipset broke building if
CONFIG_PCI is disabled.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 84a069e46b6b866b338e44529f505fddd7d31fbb
tree 362fd343e5b2c022b654da36742ce08b6a5ddca9
parent 7289356a6b3c0218f9ad6e85280c4f9cc121e371
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 25 May 2005 10:32:53 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 25 May 2005 10:32:53 -0500

 ppc/platforms/85xx/mpc85xx_cds_common.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- 12a426fa6a66d581ca2c5fca42457b3f3505af09/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
+++ 362fd343e5b2c022b654da36742ce08b6a5ddca9/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
@@ -439,9 +439,6 @@
 
 	printk("mpc85xx_cds_setup_arch\n");
 
-	/* VIA IDE configuration */
-        ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
-
 #ifdef CONFIG_CPM2
 	cpm2_reset();
 #endif
@@ -462,6 +459,9 @@
 	loops_per_jiffy = freq / HZ;
 
 #ifdef CONFIG_PCI
+	/* VIA IDE configuration */
+        ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
+
 	/* setup PCI host bridges */
 	mpc85xx_setup_hose();
 #endif
