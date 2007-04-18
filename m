Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 4/10] Re-organize Kconfig code for 4xx in arch/powerpc
In-Reply-To: <20070418063517.GB29312@localhost.localdomain>
Message-Id: <20070418063626.4E05CDDE3B@ozlabs.org>
Date: Wed, 18 Apr 2007 16:36:26 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we always take a device tree in arch/powerpc, there's no good
reason not to allow a single kernel to support multiple embedded 4xx
boards - the correct platform code can be selected based on the device
tree information.

Therefore, this patch re-arranges the 4xx Kconfig code to allow this.
In addition we:
	- use "select" instead of depends to configure the correct
	  config options for specific 4xx CPUs and workarounds, which
	  makes the information about specific boards and CPUs less
	  scattered.
	- Some old, unused (in arch/powerpc) config options are
	  removed: WANT_EARLY_SERIAL, IBM_OCP, etc.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/platforms/4xx/Kconfig |  378 ++++++++++++++-----------------------
 1 file changed, 153 insertions(+), 225 deletions(-)

Index: working-2.6/arch/powerpc/platforms/4xx/Kconfig
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/4xx/Kconfig	2007-02-21 11:20:50.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/4xx/Kconfig	2007-02-21 11:25:43.000000000 +1100
@@ -3,278 +3,206 @@ config 4xx
 	depends on 40x || 44x
 	default y
 
-config WANT_EARLY_SERIAL
+config BOOKE
 	bool
-	select SERIAL_8250
-	default n
-
-menu "AMCC 4xx options"
-	depends on 4xx
-
-choice
-	prompt "Machine Type"
-	depends on 40x
-	default WALNUT
-
-config BUBINGA
-	bool "Bubinga"
-	select WANT_EARLY_SERIAL
-	help
-	  This option enables support for the IBM 405EP evaluation board.
-
-config CPCI405
-	bool "CPCI405"
-	help
-	  This option enables support for the CPCI405 board.
-
-config EP405
-	bool "EP405/EP405PC"
-	help
-	  This option enables support for the EP405/EP405PC boards.
-
-config REDWOOD_5
-	bool "Redwood-5"
-	help
-	  This option enables support for the IBM STB04 evaluation board.
-
-config REDWOOD_6
-	bool "Redwood-6"
-	help
-	  This option enables support for the IBM STBx25xx evaluation board.
-
-config SYCAMORE
-	bool "Sycamore"
-	help
-	  This option enables support for the IBM PPC405GPr evaluation board.
-
-config WALNUT
-	bool "Walnut"
-	help
-	  This option enables support for the IBM PPC405GP evaluation board.
-
-config XILINX_ML300
-	bool "Xilinx-ML300"
-	help
-	  This option enables support for the Xilinx ML300 evaluation board.
-
-endchoice
-
-choice
-	prompt "Machine Type"
 	depends on 44x
-	default EBONY
-
-config BAMBOO
-	bool "Bamboo"
-	select WANT_EARLY_SERIAL
-	help
-	  This option enables support for the IBM PPC440EP evaluation board.
-
-config EBONY
-	bool "Ebony"
-	select WANT_EARLY_SERIAL
-	help
-	  This option enables support for the IBM PPC440GP evaluation board.
-
-config LUAN
-	bool "Luan"
-	select WANT_EARLY_SERIAL
-	help
-	  This option enables support for the IBM PPC440SP evaluation board.
-
-config OCOTEA
-	bool "Ocotea"
-	select WANT_EARLY_SERIAL
-	help
-	  This option enables support for the IBM PPC440GX evaluation board.
+	default y
 
-endchoice
+menu "AMCC 40x options"
+	depends on 40x
 
-config EP405PC
-	bool "EP405PC Support"
-	depends on EP405
+#config BUBINGA
+#	bool "Bubinga"
+#	depends on 40x
+#	default n
+#	select 405EP
+#	help
+#	  This option enables support for the IBM 405EP evaluation board.
+
+#config CPCI405
+#	bool "CPCI405"
+#	depends on 40x
+#	default n
+#	select 405GP
+#	help
+#	  This option enables support for the CPCI405 board.
+
+#config EP405
+#	bool "EP405/EP405PC"
+#	depends on 40x
+#	default n
+#	select 405GP
+#	help
+#	  This option enables support for the EP405/EP405PC boards.
+
+#config EP405PC
+#	bool "EP405PC Support"
+#	depends on EP405
+#	default y
+#	help
+#	  This option enables support for the extra features of the EP405PC board.
+
+#config REDWOOD_5
+#	bool "Redwood-5"
+#	depends on 40x
+#	default n
+#	select STB03xxx
+#	help
+#	  This option enables support for the IBM STB04 evaluation board.
+
+#config REDWOOD_6
+#	bool "Redwood-6"
+#	depends on 40x
+#	default n
+#	select STB03xxx
+#	help
+#	  This option enables support for the IBM STBx25xx evaluation board.
+
+#config SYCAMORE
+#	bool "Sycamore"
+#	depends on 40x
+#	default n
+#	select 405GPR
+#	help
+#	  This option enables support for the IBM PPC405GPr evaluation board.
+
+#config WALNUT
+#	bool "Walnut"
+#	depends on 40x
+#	default y
+#	select 405GP
+#	help
+#	  This option enables support for the IBM PPC405GP evaluation board.
+
+#config XILINX_ML300
+#	bool "Xilinx-ML300"
+#	depends on 40x
+#	default y
+#	select VIRTEX_II_PRO
+#	help
+#	  This option enables support for the Xilinx ML300 evaluation board.
 
+endmenu
 
-# It's often necessary to know the specific 4xx processor type.
-# Fortunately, it is impled (so far) from the board type, so we
-# don't need to ask more redundant questions.
+# 40x specific CPU modules, selected based on the board above.
 config NP405H
 	bool
-	depends on ASH
-	default y
+	#depends on ASH
 
-config 440EP
+# OAK doesn't exist but wanted to keep this around for any future 403GCX boards
+config 403GCX
 	bool
-	depends on BAMBOO
-	select PPC_FPU
-	default y
+	#depends on OAK
+	select IBM405_ERR51
 
-config 440GP
+config 405GP
 	bool
-	depends on EBONY
-	default y
+	select IBM405_ERR77
+	select IBM405_ERR51
 
-config 440GX
+config 405EP
 	bool
-	depends on OCOTEA
-	default y
 
-config 440SP
+config 405GPR
 	bool
-	depends on LUAN
-	default y
 
-config 440
+config VIRTEX_II_PRO
 	bool
-	depends on 440GP || 440SP || 440EP
-	default y
+	select IBM405_ERR77
+	select IBM405_ERR51
 
-config 440A
+config STB03xxx
 	bool
-	depends on 440GX
-	default y
+	select IBM405_ERR77
+	select IBM405_ERR51
 
-config IBM440EP_ERR42
-	bool
-	depends on 440EP
-	default y
+# 40x errata/workaround config symbols, selected by the CPU models above
 
 # All 405-based cores up until the 405GPR and 405EP have this errata.
 config IBM405_ERR77
 	bool
-	depends on 40x && !403GCX && !405GPR && !405EP
-	default y
 
 # All 40x-based cores, up until the 405GPR and 405EP have this errata.
 config IBM405_ERR51
 	bool
-	depends on 40x && !405GPR && !405EP
-	default y
 
-config BOOKE
-	bool
+menu "AMCC 44x options"
 	depends on 44x
-	default y
 
-config IBM_OCP
-	bool
-	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
-	default y
+#config BAMBOO
+#	bool "Bamboo"
+#	depends on 44x
+#	default n
+#	select 440EP
+#	help
+#	  This option enables support for the IBM PPC440EP evaluation board.
 
-config XILINX_OCP
-	bool
-	depends on XILINX_ML300
-	default y
-
-config IBM_EMAC4
-	bool
-	depends on 440GX || 440SP
-	default y
-
-config BIOS_FIXUP
-	bool
-	depends on BUBINGA || EP405 || SYCAMORE || WALNUT
-	default y
-
-# OAK doesn't exist but wanted to keep this around for any future 403GCX boards
-config 403GCX
-	bool
-	depends on OAK
-	default y
-
-config 405EP
-	bool
-	depends on BUBINGA
-	default y
-
-config 405GP
-	bool
-	depends on CPCI405 || EP405 || WALNUT
-	default y
-
-config 405GPR
-	bool
-	depends on SYCAMORE
-	default y
-
-config VIRTEX_II_PRO
-	bool
-	depends on XILINX_ML300
-	default y
-
-config STB03xxx
-	bool
-	depends on REDWOOD_5 || REDWOOD_6
-	default y
-
-config EMBEDDEDBOOT
-	bool
-	depends on EP405 || XILINX_ML300
+config EBONY
+	bool "Ebony"
+	depends on 44x
 	default y
+	select 440GP
+	help
+	  This option enables support for the IBM PPC440GP evaluation board.
 
-config IBM_OPENBIOS
-	bool
-	depends on ASH || BUBINGA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
-	default y
+#config LUAN
+#	bool "Luan"
+#	depends on 44x
+#	default n
+#	select 440SP
+#	help
+#	  This option enables support for the IBM PPC440SP evaluation board.
+
+#config OCOTEA
+#	bool "Ocotea"
+#	depends on 44x
+#	default n
+#	select 440GX
+#	help
+#	  This option enables support for the IBM PPC440GX evaluation board.
 
-config PPC4xx_DMA
-	bool "PPC4xx DMA controller support"
-	depends on 4xx
+endmenu
 
-config PPC4xx_EDMA
+# 44x specific CPU modules, selected based on the board above.
+config 440EP
 	bool
-	depends on !STB03xxx && PPC4xx_DMA
-	default y
+	select PPC_FPU
+	select IBM440EP_ERR42
 
-config PPC_GEN550
+config 440GP
 	bool
-	depends on 4xx
-	default y
-
-choice
-	prompt "TTYS0 device and default console"
-	depends on 40x
-	default UART0_TTYS0
-
-config UART0_TTYS0
-	bool "UART0"
-
-config UART0_TTYS1
-	bool "UART1"
+	select IBM_NEW_EMAC_ZMII
 
-endchoice
-
-config SERIAL_SICC
-	bool "SICC Serial port support"
-	depends on STB03xxx
-
-config UART1_DFLT_CONSOLE
+config 440GX
 	bool
-	depends on SERIAL_SICC && UART0_TTYS1
-	default y
 
-config SERIAL_SICC_CONSOLE
+config 440SP
 	bool
-	depends on SERIAL_SICC && UART0_TTYS1
-	default y
-endmenu
-
 
-menu "IBM 40x options"
-	depends on 40x
-
-config SERIAL_SICC
-	bool "SICC Serial port"
-	depends on STB03xxx
-
-config UART1_DFLT_CONSOLE
+config 440A
 	bool
-	depends on SERIAL_SICC && UART0_TTYS1
+	depends on 440GX
 	default y
 
-config SERIAL_SICC_CONSOLE
+# 44x errata/workaround config symbols, selected by the CPU models above
+config IBM440EP_ERR42
 	bool
-	depends on SERIAL_SICC && UART0_TTYS1
-	default y
 
-endmenu
+#config XILINX_OCP
+#	bool
+#	depends on XILINX_ML300
+#	default y
+
+#config BIOS_FIXUP
+#	bool
+#	depends on BUBINGA || EP405 || SYCAMORE || WALNUT
+#	default y
+
+#config PPC4xx_DMA
+#	bool "PPC4xx DMA controller support"
+#	depends on 4xx
+
+#config PPC4xx_EDMA
+#	bool
+#	depends on !STB03xxx && PPC4xx_DMA
+#	default y
