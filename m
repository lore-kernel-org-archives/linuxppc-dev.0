Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DD72467A72
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 18:31:00 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j2A7WHBh002219 for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 00:32:17 -0700 (MST)
Received: from postal.somerset.sps.mot.com ([163.12.132.5])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j2A7WMgN025776
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 01:32:22 -0600 (CST)
Received: from blarg.somerset.sps.mot.com (blarg.somerset.sps.mot.com
	[163.12.112.65])
	by postal.somerset.sps.mot.com (8.11.0/8.11.0) with ESMTP id
	j2A7Uwi13641 for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 01:30:58 -0600 (CST)
Received: from blarg.somerset.sps.mot.com (localhost.localdomain [127.0.0.1])
	by blarg.somerset.sps.mot.com (8.12.11/8.11.0) with ESMTP id
	j2A7Uvvw003549
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Mar 2005 01:30:57 -0600
Received: from localhost (galak@localhost)
	by blarg.somerset.sps.mot.com (8.12.11/8.12.11/Submit) with ESMTP id
	j2A7Uulc003546
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Mar 2005 01:30:57 -0600
Date: Thu, 10 Mar 2005 01:30:55 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <Pine.LNX.4.61.0503100130230.3545@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] ppc32: Consolidate Kconfig support for 83xx (fwd)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



---------- Forwarded message ----------
Date: Wed, 9 Mar 2005 21:31:05 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Cc: linuxppc-embedded@ozlab.org, trini@kernel.crashing.org
Subject: [PATCH] ppc32: Consolidate Kconfig support for 83xx

Andrew,

(Note this removes arch/ppc/platforms/83xx/Kconfig)

Consolidate Kconfig options between arch/ppc/platforms/83xx/Kconfig and 
arch/ppc/Kconfig at Tom Rini's request.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
   
---
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-03-09 21:23:40 -06:00
+++ b/arch/ppc/Kconfig	2005-03-09 21:23:41 -06:00
@@ -228,7 +228,6 @@
 	  If in doubt, say Y here.
 
 source arch/ppc/platforms/4xx/Kconfig
-source arch/ppc/platforms/83xx/Kconfig
 source arch/ppc/platforms/85xx/Kconfig
 
 config PPC64BRIDGE
@@ -476,7 +475,7 @@
 
 choice
 	prompt "Machine Type"
-	depends on (6xx && !83xx) || POWER3 || POWER4
+	depends on 6xx || POWER3 || POWER4
 	default PPC_MULTIPLATFORM
 	---help---
 	  Linux currently supports several different kinds of PowerPC-based
@@ -643,6 +642,11 @@
 	  much but it's only been tested on this board version. I think this
 	  board is also known as IceCube.
 
+config MPC834x_SYS
+	bool "Freescale MPC834x SYS"
+	help
+	  This option enables support for the MPC 834x SYS evaluation board.
+
 endchoice
 
 config PQ2ADS
@@ -665,7 +669,7 @@
 
 config 8260
 	bool "CPM2 Support" if WILLOW
-	depends on 6xx && !83xx
+	depends on 6xx
 	default y if TQM8260 || RPX8260 || EST8260 || SBS8260 || SBC82xx || PQ2FADS
 	help
 	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
@@ -681,6 +685,14 @@
 	  The MPC8272 CPM has a different internal dpram setup than other CPM2
 	  devices
 
+config 83xx
+	bool
+	default y if MPC834x_SYS
+
+config MPC834x
+	bool
+	default y if MPC834x_SYS
+
 config CPM2
 	bool
 	depends on 8260 || MPC8560 || MPC8555
@@ -720,7 +732,8 @@
 	bool
 	depends on SANDPOINT || MCPN765 || SPRUCE || PPLUS || PCORE || \
 		PRPMC750 || K2 || PRPMC800 || LOPEC || \
-		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D
+		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D || \
+		MPC834x_SYS
 	default y
 
 config FORCE
diff -Nru a/arch/ppc/platforms/83xx/Kconfig b/arch/ppc/platforms/83xx/Kconfig
--- a/arch/ppc/platforms/83xx/Kconfig	2005-03-09 21:23:40 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,30 +0,0 @@
-config 83xx
-	bool "PowerQUICC II Pro (83xx) Support"
-	depends on 6xx
-
-menu "Freescale 83xx options"
-	depends on 83xx
-
-choice
-	prompt "Machine Type"
-	depends on 83xx
-	default MPC834x_SYS
-
-config MPC834x_SYS
-	bool "Freescale MPC834x SYS"
-	help
-	  This option enables support for the MPC 834x SYS evaluation board.
-
-endchoice
-
-config MPC834x
-	bool
-	depends on MPC834x_SYS
-	default y
-
-config PPC_GEN550
-	bool
-	depends on 83xx
-	default y
-
-endmenu
