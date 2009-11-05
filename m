Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 977DEB7BA8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 02:16:16 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nA5FGDsm006143
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 09:16:13 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Kconfig cleanup
Date: Thu,  5 Nov 2009 09:16:13 -0600
Message-Id: <1257434173-14440-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce new FSL_SOC_BOOKE Kconfig to handle both 85xx and QorIQ
based chips.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/Kconfig    |   11 ++++++-----
 arch/powerpc/platforms/Kconfig         |    2 +-
 arch/powerpc/platforms/Kconfig.cputype |   17 ++++++++---------
 arch/powerpc/platforms/Makefile        |    2 +-
 arch/powerpc/sysdev/fsl_pci.c          |    4 ++--
 arch/powerpc/sysdev/fsl_soc.c          |    2 +-
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d3a975e..5de0d63 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -1,6 +1,7 @@
-menuconfig MPC85xx
-	bool "Machine Type"
-	depends on PPC_85xx
+menuconfig FSL_SOC_BOOKE
+	bool "Freescale Book-E Machine Type"
+	depends on PPC_85xx || PPC_BOOK3E
+	select FSL_SOC
 	select PPC_UDBG_16550
 	select MPIC
 	select PPC_PCI_CHOICE
@@ -8,7 +9,7 @@ menuconfig MPC85xx
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	default y
 
-if MPC85xx
+if FSL_SOC_BOOKE
 
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
@@ -144,7 +145,7 @@ config SBC8560
 	help
 	  This option enables support for the Wind River SBC8560 board
 
-endif # MPC85xx
+endif # FSL_SOC_BOOKE
 
 config TQM85xx
 	bool
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 56bf126..11c0852 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -260,7 +260,7 @@ config QE_GPIO
 
 config CPM2
 	bool "Enable support for the CPM2 (Communications Processor Module)"
-	depends on MPC85xx || 8260
+	depends on (FSL_SOC_BOOKE && PPC32) || 8260
 	select CPM
 	select PPC_LIB_RHEAP
 	select PPC_PCI_CHOICE
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e382cae..2eab27a 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -28,8 +28,6 @@ config PPC_BOOK3S_32
 config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
-	select FSL_SOC
-	select MPC85xx
 
 config PPC_8xx
 	bool "Freescale 8xx"
@@ -138,6 +136,14 @@ config PPC_FPU
 	bool
 	default y if PPC64
 
+config FSL_EMB_PERFMON
+	bool "Freescale Embedded Perfmon"
+	depends on E500 || PPC_83xx
+	help
+	  This is the Performance Monitor support found on the e500 core
+	  and some e300 cores (c3 and c4).  Select this only if your
+	  core supports the Embedded Performance Monitor APU
+
 config 4xx
 	bool
 	depends on 40x || 44x
@@ -153,13 +159,6 @@ config FSL_BOOKE
 	depends on E200 || E500
 	default y
 
-config FSL_EMB_PERFMON
-	bool "Freescale Embedded Perfmon"
-	depends on E500 || PPC_83xx
-	help
-	  This is the Performance Monitor support found on the e500 core
-	  and some e300 cores (c3 and c4).  Select this only if your
-	  core supports the Embedded Performance Monitor APU
 
 config PTE_64BIT
 	bool
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index a6812ee..fdb9f0b 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_8xx)		+= 8xx/
 obj-$(CONFIG_PPC_82xx)		+= 82xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
-obj-$(CONFIG_PPC_85xx)		+= 85xx/
+obj-$(CONFIG_FSL_SOC_BOOKE)	+= 85xx/
 obj-$(CONFIG_PPC_86xx)		+= 86xx/
 obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index ae88b14..cf57a42 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -56,7 +56,7 @@ static int __init fsl_pcie_check_link(struct pci_controller *hose)
 	return 0;
 }
 
-#if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
+#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
 static int __init setup_one_atmu(struct ccsr_pci __iomem *pci,
 	unsigned int index, const struct resource *res,
 	resource_size_t offset)
@@ -394,7 +394,7 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020, quirk_fsl_pcie_header);
-#endif /* CONFIG_PPC_85xx || CONFIG_PPC_86xx */
+#endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8314E, quirk_fsl_pcie_header);
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index adca4af..b91f7ac 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -372,7 +372,7 @@ err:
 
 arch_initcall(fsl_usb_of_init);
 
-#if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
+#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
 static __be32 __iomem *rstcr;
 
 static int __init setup_rstcr(void)
-- 
1.6.0.6
