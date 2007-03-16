Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2F1ADDED1
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 02:27:41 +1100 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1HSELC-00007h-Va
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 10:27:39 -0500
Date: Fri, 16 Mar 2007 10:24:21 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][POWERPC] [004/006] Removed config options that we don't
	support in embedded6xx
In-Reply-To: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703161023390.9740@localhost.localdomain>
References: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
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

When we started arch/powerpc we duplicated a number of config options from arch/ppc
for various platforms that are supported.  Now that we actually support a few
platforms, remove all the ones that haven't been moved over.  Additionally, this
cleanup moved the 82xx/PQ2 options over into arch/powerpc/platforms/82xx/Kconfig
where they belong.  It also killed GEN550 which doesn't exist in arch/powerpc.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig.debug                 |    3 +-
 arch/powerpc/platforms/82xx/Kconfig        |   35 ++++
 arch/powerpc/platforms/embedded6xx/Kconfig |  264 +---------------------------
 3 files changed, 38 insertions(+), 264 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index d39d133..50f48f0 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -132,8 +132,7 @@ config BOOTX_TEXT

 config SERIAL_TEXT_DEBUG
 	bool "Support for early boot texts over serial port"
-	depends on 4xx || LOPEC || MV64X60 || PPLUS || PRPMC800 || \
-		PPC_GEN550 || PPC_MPC52xx
+	depends on 4xx

 config PPC_EARLY_DEBUG
 	bool "Early debugging (dangerous)"
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 47d841e..4110716 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -18,4 +18,39 @@ config MPC82xx_ADS

 endchoice

+config PQ2ADS
+	bool
+	depends on ADS8272
+	default y
+
+config ADS8272
+	bool
+
+config 8260
+	bool "CPM2 Support" if WILLOW
+	depends on 6xx
+	default y if PQ2FADS
+	help
+	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
+	  this option means that you wish to build a kernel for a machine with
+	  an 8260 class CPU.
+
+config 8272
+	bool
+	depends on 6xx
+	default y if ADS8272
+	select 8260
+	help
+	  The MPC8272 CPM has a different internal dpram setup than other CPM2
+	  devices
+
+config CPM2
+	bool
+	depends on 8260 || MPC8560 || MPC8555
+	default y
+	help
+	  The CPM2 (Communications Processor Module) is a coprocessor on
+	  embedded CPUs made by Motorola.  Selecting this option means that
+	  you wish to build a kernel for a machine with a CPM2 coprocessor
+	  on it (826x, 827x, 8560).
 endmenu
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 3410bcb..9557908 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -2,78 +2,6 @@ choice
 	prompt "Machine Type"
 	depends on EMBEDDED6xx

-config KATANA
-	bool "Artesyn-Katana"
-	help
-	  Select KATANA if configuring an Artesyn KATANA 750i or 3750
-	  cPCI board.
-
-config WILLOW
-	bool "Cogent-Willow"
-
-config CPCI690
-	bool "Force-CPCI690"
-	help
-	  Select CPCI690 if configuring a Force CPCI690 cPCI board.
-
-config POWERPMC250
-	bool "Force-PowerPMC250"
-
-config CHESTNUT
-	bool "IBM 750FX Eval board or 750GX Eval board"
-	help
-	  Select CHESTNUT if configuring an IBM 750FX Eval Board or a
-	  IBM 750GX Eval board.
-
-config SPRUCE
-	bool "IBM-Spruce"
-	select PPC_INDIRECT_PCI
-
-config HDPU
-	bool "Sky-HDPU"
-	help
-	  Select HDPU if configuring a Sky Computers Compute Blade.
-
-config HDPU_FEATURES
-	depends on HDPU
-	tristate "HDPU-Features"
-	help
-	  Select to enable HDPU enhanced features.
-
-config EV64260
-	bool "Marvell-EV64260BP"
-	help
-	  Select EV64260 if configuring a Marvell (formerly Galileo)
-	  EV64260BP Evaluation platform.
-
-config LOPEC
-	bool "Motorola-LoPEC"
-	select PPC_I8259
-
-config MVME5100
-	bool "Motorola-MVME5100"
-	select PPC_INDIRECT_PCI
-
-config PPLUS
-	bool "Motorola-PowerPlus"
-	select PPC_I8259
-	select PPC_INDIRECT_PCI
-
-config PRPMC750
-	bool "Motorola-PrPMC750"
-	select PPC_INDIRECT_PCI
-
-config PRPMC800
-	bool "Motorola-PrPMC800"
-	select PPC_INDIRECT_PCI
-
-config SANDPOINT
-	bool "Motorola-Sandpoint"
-	select PPC_I8259
-	help
-	  Select SANDPOINT if configuring for a Motorola Sandpoint X3
-	  (any flavor).
-
 config LINKSTATION
 	bool "Linkstation / Kurobox(HG) from Buffalo"
 	select MPIC
@@ -97,212 +25,24 @@ config MPC7448HPC2
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
-
-config RADSTONE_PPC7D
-	bool "Radstone Technology PPC7D board"
-	select PPC_I8259
-
-config PAL4
-	bool "SBS-Palomar4"
-
-config EST8260
-	bool "EST8260"
-	---help---
-	  The EST8260 is a single-board computer manufactured by Wind River
-	  Systems, Inc. (formerly Embedded Support Tools Corp.) and based on
-	  the MPC8260.  Wind River Systems has a website at
-	  <http://www.windriver.com/>, but the EST8260 cannot be found on it
-	  and has probably been discontinued or rebadged.
-
-config SBC82xx
-	bool "SBC82xx"
-	---help---
-	  SBC PowerQUICC II, single-board computer with MPC82xx CPU
-	  Manufacturer: Wind River Systems, Inc.
-	  Date of Release: May 2003
-	  End of Life: -
-	  URL: <http://www.windriver.com/>
-
-config SBS8260
-	bool "SBS8260"
-
-config RPX8260
-	bool "RPXSUPER"
-
-config TQM8260
-	bool "TQM8260"
-	---help---
-	  MPC8260 based module, little larger than credit card,
-	  up to 128 MB global + 64 MB local RAM, 32 MB Flash,
-	  32 kB EEPROM, 256 kB L@ Cache, 10baseT + 100baseT Ethernet,
-	  2 x serial ports, ...
-	  Manufacturer: TQ Components, www.tq-group.de
-	  Date of Release: June 2001
-	  End of Life: not yet :-)
-	  URL: <http://www.denx.de/PDF/TQM82xx_SPEC_Rev005.pdf>
-
-config ADS8272
-	bool "ADS8272"
-
-config PQ2FADS
-	bool "Freescale-PQ2FADS"
-	help
-	  Select PQ2FADS if you wish to configure for a Freescale
-	  PQ2FADS board (-VR or -ZU).
-
-config EV64360
-	bool "Marvell-EV64360BP"
-	help
-	  Select EV64360 if configuring a Marvell EV64360BP Evaluation
-	  platform.
 endchoice

-config PQ2ADS
-	bool
-	depends on ADS8272
-	default y
-
-config TQM8xxL
-	bool
-	depends on 8xx && (TQM823L || TQM850L || FPS850L || TQM855L || TQM860L)
-	default y
-
-config 8260
-	bool "CPM2 Support" if WILLOW
-	depends on 6xx
-	default y if TQM8260 || RPX8260 || EST8260 || SBS8260 || SBC82xx || PQ2FADS
-	help
-	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
-	  this option means that you wish to build a kernel for a machine with
-	  an 8260 class CPU.
-
-config 8272
-	bool
-	depends on 6xx
-	default y if ADS8272
-	select 8260
-	help
-	  The MPC8272 CPM has a different internal dpram setup than other CPM2
-	  devices
-
-config CPM2
-	bool
-	depends on 8260 || MPC8560 || MPC8555
-	default y
-	help
-	  The CPM2 (Communications Processor Module) is a coprocessor on
-	  embedded CPUs made by Motorola.  Selecting this option means that
-	  you wish to build a kernel for a machine with a CPM2 coprocessor
-	  on it (826x, 827x, 8560).
-
-config PPC_GEN550
-	bool
-	depends on SANDPOINT || SPRUCE || PPLUS || \
-		PRPMC750 || PRPMC800 || LOPEC || \
-		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D || \
-		83xx || LINKSTATION
-	default y
-
-config FORCE
-	bool
-	depends on 6xx && POWERPMC250
-	default y
-
-config GT64260
-	bool
-	depends on EV64260 || CPCI690
-	default y
-
-config MV64360		# Really MV64360 & MV64460
-	bool
-	depends on CHESTNUT || KATANA || RADSTONE_PPC7D || HDPU || EV64360
-	default y
-
-config MV64X60
-	bool
-	depends on (GT64260 || MV64360)
-	select PPC_INDIRECT_PCI
-	default y
-
 config TSI108_BRIDGE
 	bool
 	depends on MPC7448HPC2
 	default y

-menu "Set bridge options"
-	depends on MV64X60
-
-config NOT_COHERENT_CACHE
-	bool "Turn off Cache Coherency"
-	default n
-	help
-	  Some 64x60 bridges lock up when trying to enforce cache coherency.
-	  When this option is selected, cache coherency will be turned off.
-	  Note that this can cause other problems (e.g., stale data being
-	  speculatively loaded via a cached mapping).  Use at your own risk.
-
-config MV64X60_BASE
-	hex "Set bridge base used by firmware"
-	default "0xf1000000"
-	help
-	  A firmware can leave the base address of the bridge's registers at
-	  a non-standard location.  If so, set this value to reflect the
-	  address of that non-standard location.
-
-config MV64X60_NEW_BASE
-	hex "Set bridge base used by kernel"
-	default "0xf1000000"
-	help
-	  If the current base address of the bridge's registers is not where
-	  you want it, set this value to the address that you want it moved to.
-
-endmenu
-
-config NONMONARCH_SUPPORT
-	bool "Enable Non-Monarch Support"
-	depends on PRPMC800
-
-config HARRIER
-	bool
-	depends on PRPMC800
-	default y
-
-config EPIC_SERIAL_MODE
-	bool
-	depends on 6xx && (LOPEC || SANDPOINT)
-	default y
-
 config MPC10X_BRIDGE
 	bool
-	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
+	depends on LINKSTATION
 	select PPC_INDIRECT_PCI
 	default y

 config MPC10X_OPENPIC
 	bool
-	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
+	depends on LINKSTATION
 	default y

 config MPC10X_STORE_GATHERING
 	bool "Enable MPC10x store gathering"
 	depends on MPC10X_BRIDGE
-
-config SANDPOINT_ENABLE_UART1
-	bool "Enable DUART mode on Sandpoint"
-	depends on SANDPOINT
-	help
-	  If this option is enabled then the MPC824x processor will run
-	  in DUART mode instead of UART mode.
-
-config HARRIER_STORE_GATHERING
-	bool "Enable Harrier store gathering"
-	depends on HARRIER
-
-config MVME5100_IPMC761_PRESENT
-	bool "MVME5100 configured with an IPMC761"
-	depends on MVME5100
-	select PPC_I8259
-
-config SPRUCE_BAUD_33M
-	bool "Spruce baud clock support"
-	depends on SPRUCE
-- 
1.5.0.2
