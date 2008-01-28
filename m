Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0E0ADE1B5
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 04:45:49 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0SGuPTe020631
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 10:56:26 -0600
Date: Mon, 28 Jan 2008 10:53:58 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 83xx: rework platform Kconfig
Message-ID: <Pine.LNX.4.64.0801281053230.20897@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Allow multiple boards to be selected in a single build
* Removed Kconfig option '83xx' which existed only for compat with arch/ppc
* Removed Kconfig option 'PPC_MPC836x' since its not used
* Renamed Kconfig option 'MPC834x' to 'PPC_MPC834x' to match others
* Added a multiplatform 83xx defconfig (mpc83xx_defconfig).

---

Removed defconfig from patch

 arch/powerpc/configs/mpc83xx_defconfig |  895 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/Kconfig    |   43 +-
 arch/powerpc/platforms/83xx/usb.c      |    4 +-
 arch/powerpc/platforms/Kconfig         |    2 +-
 arch/powerpc/platforms/Kconfig.cputype |    4 -
 5 files changed, 918 insertions(+), 30 deletions(-)
 create mode 100644 arch/powerpc/configs/mpc83xx_defconfig

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index ba28882..13587e2 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -1,11 +1,15 @@
-choice
-	prompt "83xx Board Type"
+menuconfig MPC83xx
+	bool "83xx Board Type"
 	depends on PPC_83xx
-	default MPC834x_MDS
+	select PPC_UDBG_16550
+	select PPC_INDIRECT_PCI
+
+if MPC83xx

 config MPC831x_RDB
 	bool "Freescale MPC831x RDB"
 	select DEFAULT_UIMAGE
+	select PPC_MPC831x
 	help
 	  This option enables support for the MPC8313 RDB and MPC8315 RDB boards.

@@ -13,6 +17,7 @@ config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
+	select PPC_MPC832x
 	help
 	  This option enables support for the MPC832x MDS evaluation board.

@@ -20,12 +25,14 @@ config MPC832x_RDB
 	bool "Freescale MPC832x RDB"
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
+	select PPC_MPC832x
 	help
 	  This option enables support for the MPC8323 RDB board.

 config MPC834x_MDS
 	bool "Freescale MPC834x MDS"
 	select DEFAULT_UIMAGE
+	select PPC_MPC834x
 	help
 	  This option enables support for the MPC 834x MDS evaluation board.

@@ -37,6 +44,7 @@ config MPC834x_MDS
 config MPC834x_ITX
 	bool "Freescale MPC834x ITX"
 	select DEFAULT_UIMAGE
+	select PPC_MPC834x
 	help
 	  This option enables support for the MPC 834x ITX evaluation board.

@@ -53,49 +61,38 @@ config MPC836x_MDS
 config MPC837x_MDS
 	bool "Freescale MPC837x MDS"
 	select DEFAULT_UIMAGE
+	select PPC_MPC837x
 	help
 	  This option enables support for the MPC837x MDS Processor Board.

 config MPC837x_RDB
 	bool "Freescale MPC837x RDB"
 	select DEFAULT_UIMAGE
+	select PPC_MPC837x
 	help
 	  This option enables support for the MPC837x RDB Board.

 config SBC834x
 	bool "Wind River SBC834x"
 	select DEFAULT_UIMAGE
+	select PPC_MPC834x
 	help
 	  This option enables support for the Wind River SBC834x board.

-endchoice
+endif

+# used for usb
 config PPC_MPC831x
 	bool
-	select PPC_UDBG_16550
-	select PPC_INDIRECT_PCI
-	default y if MPC831x_RDB

+# used for math-emu
 config PPC_MPC832x
 	bool
-	select PPC_UDBG_16550
-	select PPC_INDIRECT_PCI
-	default y if MPC832x_MDS || MPC832x_RDB

-config MPC834x
+# used for usb
+config PPC_MPC834x
 	bool
-	select PPC_UDBG_16550
-	select PPC_INDIRECT_PCI
-	default y if MPC834x_MDS || MPC834x_ITX || SBC834x
-
-config PPC_MPC836x
-	bool
-	select PPC_UDBG_16550
-	select PPC_INDIRECT_PCI
-	default y if MPC836x_MDS

+# used for usb
 config PPC_MPC837x
 	bool
-	select PPC_UDBG_16550
-	select PPC_INDIRECT_PCI
-	default y if MPC837x_MDS || MPC837x_RDB
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 6a454a4..681230a 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -22,7 +22,7 @@
 #include "mpc83xx.h"


-#ifdef CONFIG_MPC834x
+#ifdef CONFIG_PPC_MPC834x
 int mpc834x_usb_cfg(void)
 {
 	unsigned long sccr, sicrl, sicrh;
@@ -96,7 +96,7 @@ int mpc834x_usb_cfg(void)
 	iounmap(immap);
 	return 0;
 }
-#endif /* CONFIG_MPC834x */
+#endif /* CONFIG_PPC_MPC834x */

 #ifdef CONFIG_PPC_MPC831x
 int mpc831x_usb_cfg(void)
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 582a3a6..fdce10c 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -21,7 +21,7 @@ config PPC_83xx
 	bool "Freescale 83xx"
 	depends on 6xx
 	select FSL_SOC
-	select 83xx
+	select MPC83xx
 	select IPIC
 	select WANT_DEVICE_TREE

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f6bf025..7fc4110 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -93,10 +93,6 @@ config 6xx
 config 8xx
 	bool

-# this is temp to handle compat with arch=ppc
-config 83xx
-	bool
-
 config E500
 	bool

-- 
1.5.3.7
