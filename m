Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 0D09E2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 10:22:07 +1100 (EST)
Date: Wed, 12 Jan 2005 16:22:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20050112232206.GT3391@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.10] ppc32: Add Freescale PQ2FADS support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.  The following adds support for Freescale's PQ2FADS board to the
kernel.

(The 'real' changes required for the board are in the ethernet driver,
which needs a massive sync-up with mainline as I've been holding out for
a better, rewritten one from the Freescale folks, who're waiting for the
PHY lib patch sent to the net-dev list to get ack'd)

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.94/arch/ppc/Kconfig	2005-01-04 19:48:07 -07:00
+++ edited/arch/ppc/Kconfig	2005-01-12 16:17:17 -07:00
@@ -623,6 +623,12 @@
 config ADS8272
 	bool "ADS8272"
 
+config PQ2FADS
+	bool "Freescale-PQ2FADS"
+	help
+	  Select PQ2FADS if you wish to configure for a Freescale
+	  PQ2FADS board (-VR or -ZU).
+
 config LITE5200
 	bool "Freescale LITE5200 / (IceCube)"
 	select PPC_MPC52xx
@@ -655,7 +661,7 @@
 config 8260
 	bool "CPM2 Support" if WILLOW
 	depends on 6xx
-	default y if TQM8260 || RPX8260 || EST8260 || SBS8260 || SBC82xx
+	default y if TQM8260 || RPX8260 || EST8260 || SBS8260 || SBC82xx || PQ2FADS
 	help
 	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
 	  this option means that you wish to build a kernel for a machine with
--- 1.2/arch/ppc/platforms/pq2ads.h	2004-08-13 14:03:33 -07:00
+++ edited/arch/ppc/platforms/pq2ads.h	2005-01-12 16:20:03 -07:00
@@ -40,6 +40,8 @@
 #define BCSR1_FETH_RST		((uint)0x04000000)	/* 0 == reset */
 #define BCSR1_RS232_EN1		((uint)0x02000000)	/* 0 == enable */
 #define BCSR1_RS232_EN2		((uint)0x01000000)	/* 0 == enable */
+#define BCSR3_FETHIEN2		((uint)0x10000000)	/* 0 == enable */
+#define BCSR3_FETH2_RST 	((uint)0x80000000)	/* 0 == reset */
 
 #define PHY_INTERRUPT	SIU_INT_IRQ7
 
--- 1.10/include/asm-ppc/mpc8260.h	2004-08-23 11:08:39 -07:00
+++ edited/include/asm-ppc/mpc8260.h	2005-01-12 16:17:18 -07:00
@@ -36,7 +36,7 @@
 #include <platforms/tqm8260.h>
 #endif
 
-#ifdef CONFIG_PQ2ADS
+#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
 #include <platforms/pq2ads.h>
 #endif
 

-- 
Tom Rini
http://gate.crashing.org/~trini/
