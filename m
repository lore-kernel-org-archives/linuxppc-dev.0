Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE1A1DF428
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 03:08:09 +1000 (EST)
From: John Rigby <jrigby@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc: pci config cleanup [rev2]
Date: Thu, 26 Jun 2008 11:07:56 -0600
Message-Id: <1214500077-9254-2-git-send-email-jrigby@freescale.com>
In-Reply-To: <1214500077-9254-1-git-send-email-jrigby@freescale.com>
References: <1214500077-9254-1-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Choosing PCI or not at config time is allowed on some
platforms via an if expression in arch/powerpc/Kconfig.
To add a new platform with PCI support selectable at
config time, you must change the if expression.  This
patch makes this easier by changing:
    bool "PCI support" if <long expression>
to
    bool "PCI support" if PPC_PCI_CHOICE
and adding select PPC_PCI_CHOICE to all the config nodes that
were previously in the PCI if expression.

Platforms with unconditional PCI support continue to
just select PCI in their config nodes.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/Kconfig                   |   12 ++++++++----
 arch/powerpc/platforms/52xx/Kconfig    |    1 +
 arch/powerpc/platforms/83xx/Kconfig    |    1 +
 arch/powerpc/platforms/85xx/Kconfig    |    2 +-
 arch/powerpc/platforms/86xx/Kconfig    |    2 ++
 arch/powerpc/platforms/Kconfig         |    1 +
 arch/powerpc/platforms/Kconfig.cputype |    2 ++
 arch/powerpc/platforms/iseries/Kconfig |    1 +
 arch/powerpc/platforms/ps3/Kconfig     |    1 +
 arch/powerpc/platforms/pseries/Kconfig |    1 +
 10 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3934e26..36c8d1c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -542,11 +542,15 @@ config FSL_LBC
 config MCA
 	bool
 
+# Platforms that what PCI turned unconditionally just do select PCI
+# in their config node.  Platforms that want to choose at config
+# time should select PPC_PCI_CHOICE
+config PPC_PCI_CHOICE
+	bool
+
 config PCI
-	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
-		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
-		|| PPC_PS3 || 44x
-	default y if !40x && !CPM2 && !8xx && !PPC_MPC512x && !PPC_83xx \
+	bool "PCI support" if PPC_PCI_CHOICE
+	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index acd2fc8..d664b1b 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -3,6 +3,7 @@ config PPC_MPC52xx
 	depends on PPC_MULTIPLATFORM && PPC32
 	select FSL_SOC
 	select PPC_CLOCK
+	select PPC_PCI_CHOICE
 
 config PPC_MPC5200_SIMPLE
 	bool "Generic support for simple MPC5200 based boards"
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 583b0c7..0a306eb 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -2,6 +2,7 @@ menuconfig MPC83xx
 	bool "83xx Board Type"
 	depends on PPC_83xx
 	select PPC_UDBG_16550
+	select PPC_PCI_CHOICE
 	select PPC_INDIRECT_PCI
 
 if MPC83xx
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 7ff29d5..82a3023 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -2,8 +2,8 @@ menuconfig MPC85xx
 	bool "Machine Type"
 	depends on PPC_85xx
 	select PPC_UDBG_16550
-	select PPC_INDIRECT_PCI if PCI
 	select MPIC
+	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	default y
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 053f49a..3500e67 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -28,6 +28,7 @@ endchoice
 
 config MPC8641
 	bool
+	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
 	select PPC_UDBG_16550
 	select MPIC
@@ -35,6 +36,7 @@ config MPC8641
 
 config MPC8610
 	bool
+	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
 	select PPC_UDBG_16550
 	select MPIC
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 87454c5..aead68a 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -280,6 +280,7 @@ config CPM2
 	depends on MPC85xx || 8260
 	select CPM
 	select PPC_LIB_RHEAP
+	select PPC_PCI_CHOICE
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
 	  embedded CPUs made by Freescale.  Selecting this option means that
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f7efaa9..01e7561 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -42,12 +42,14 @@ config 40x
 	select PPC_DCR_NATIVE
 	select PPC_UDBG_16550
 	select 4xx_SOC
+	select PPC_PCI_CHOICE
 
 config 44x
 	bool "AMCC 44x"
 	select PPC_DCR_NATIVE
 	select PPC_UDBG_16550
 	select 4xx_SOC
+	select PPC_PCI_CHOICE
 
 config E200
 	bool "Freescale e200"
diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
index 761d9e9..ea3e541 100644
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ b/arch/powerpc/platforms/iseries/Kconfig
@@ -2,6 +2,7 @@ config PPC_ISERIES
 	bool "IBM Legacy iSeries"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_INDIRECT_IO
+	select PPC_PCI_CHOICE if EMBEDDED
 
 menu "iSeries device drivers"
 	depends on PPC_ISERIES
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index a5f4e95..920cf7a 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -8,6 +8,7 @@ config PPC_PS3
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select MEMORY_HOTPLUG
+	select PPC_PCI_CHOICE
 	help
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.  Enabling this
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 07fe5b6..757c029 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -7,6 +7,7 @@ config PPC_PSERIES
 	select RTAS_ERROR_LOGGING
 	select PPC_UDBG_16550
 	select PPC_NATIVE
+	select PPC_PCI_CHOICE if EMBEDDED
 	default y
 
 config PPC_SPLPAR
-- 
1.5.6.rc0.46.gd2b3
