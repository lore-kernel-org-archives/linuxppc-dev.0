Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62F1EDDED5
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 03:28:45 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0SGSAgG019318
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 10:28:11 -0600
Date: Mon, 28 Jan 2008 10:25:43 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: rework platform Kconfig
Message-ID: <Pine.LNX.4.64.0801281024570.11773@blarg.am.freescale.net>
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
* Removed Kconfig option '85xx' which existed only for compat with arch/ppc
* Added a multiplatform 85xx defconfig (mpc85xx_defconfig). This builds
  all 85xx boards except sbc8560 and stx_gp3 since these to boards have
  board specific ifdef in driver code that may break all other boards

---

* removed defconfig from patch.

 arch/powerpc/configs/mpc85xx_defconfig | 1521 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig    |   32 +-
 arch/powerpc/platforms/Kconfig.cputype |    6 +-
 3 files changed, 1533 insertions(+), 26 deletions(-)
 create mode 100644 arch/powerpc/configs/mpc85xx_defconfig

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 74779b9..7e76ddb 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -1,7 +1,14 @@
-choice
-	prompt "Machine Type"
+menuconfig MPC85xx
+	bool "Machine Type"
 	depends on PPC_85xx
-	default MPC8540_ADS
+	select PPC_UDBG_16550
+	select PPC_INDIRECT_PCI if PCI
+	select MPIC
+	select FSL_PCI if PCI
+	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
+	default y
+
+if MPC85xx

 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
@@ -96,24 +103,7 @@ config SBC8560
 	help
 	  This option enables support for the Wind River SBC8560 board

-endchoice
+endif # MPC85xx

 config TQM85xx
 	bool
-	select MPC85xx
-
-config MPC8540
-	bool
-	select PPC_UDBG_16550
-	select PPC_INDIRECT_PCI
-	default y if MPC8540_ADS || MPC85xx_CDS || SBC8548
-
-config MPC85xx
-	bool
-	select PPC_UDBG_16550
-	select PPC_INDIRECT_PCI if PCI
-	select MPIC
-	select FSL_PCI if PCI
-	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
-	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
-		|| MPC85xx_MDS || MPC85xx_DS || STX_GP3 || SBC8560 || SBC8548
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c3ee0b5..f6bf025 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -29,8 +29,8 @@ config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
 	select FSL_SOC
-	select 85xx
 	select WANT_DEVICE_TREE
+	select MPC85xx

 config PPC_8xx
 	bool "Freescale 8xx"
@@ -97,10 +97,6 @@ config 8xx
 config 83xx
 	bool

-# this is temp to handle compat with arch=ppc
-config 85xx
-	bool
-
 config E500
 	bool

-- 
1.5.3.7
