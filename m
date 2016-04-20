Return-Path: <linus.walleij@linaro.org>
Received: from mail-lf0-x229.google.com (mail-lf0-x229.google.com
 [IPv6:2a00:1450:4010:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqbQv0vdbzDqK8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 18:59:01 +1000 (AEST)
Received: by mail-lf0-x229.google.com with SMTP id c126so36745335lfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 01:59:01 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-gpio@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/23] powerpc: do away with
 ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
Date: Wed, 20 Apr 2016 10:58:10 +0200
Message-Id: <1461142701-21096-13-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
References: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This replaces:

- "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB" as this can
  now be selected directly.

- "select ARCH_WANT_OPTIONAL_GPIOLIB" with no dependency: GPIOLIB
  is now selectable by everyone, so we need not declare our
  intent to select it.

When ordering the symbols the following rationale was used:
if the selects were in alphabetical order, I moved select GPIOLIB
to be in alphabetical order, but if the selects were not
maintained in alphabetical order, I just replaced
"select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB".

Cc: Michael Büsch <m@bues.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Various arch maintainers:

either ACK this and I will merge it into the GPIO tree for v4.7
anticipating no clashes, or you wait until I have the enabling patch
upstream (patch 1 in this series, removing deps on
ARCH_[WANTS_OPTIONAL|REQUIRES]_GPIOLIB), and you will be able to
merge it to your arch trees yourselves for late v4.7
(post GPIO tree merge) or for v4.8.

You can also ask me for an immutable branch if you prefer that, I
will put the enabling patch on a branch and the patch for your arch
on top and ask you to pull it.

Select your option from the menu, silence probably means I will
merge it to the GPIO tree. Unless you are X86 or ARM in which case
I will be cautious.
---
 arch/powerpc/Kconfig                | 1 -
 arch/powerpc/platforms/40x/Kconfig  | 2 +-
 arch/powerpc/platforms/44x/Kconfig  | 2 +-
 arch/powerpc/platforms/512x/Kconfig | 1 -
 arch/powerpc/platforms/83xx/Kconfig | 3 ---
 arch/powerpc/platforms/85xx/Kconfig | 4 ++--
 arch/powerpc/platforms/86xx/Kconfig | 7 +++----
 arch/powerpc/platforms/8xx/Kconfig  | 2 +-
 arch/powerpc/platforms/Kconfig      | 8 ++++----
 9 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7cd32c038286..6e39dfe096e6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -98,7 +98,6 @@ config PPC
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select SYSCTL_EXCEPTION_TRACE
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select VIRT_TO_BUS if !PPC64
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 6e287f1294fa..e3257f24a8a1 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -137,7 +137,7 @@ config STB03xxx
 config PPC4xx_GPIO
 	bool "PPC4xx GPIO support"
 	depends on 40x
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 	  Enable gpiolib support for ppc40x based boards
 
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 5538e57c36c1..48fc18041ff6 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -273,7 +273,7 @@ config PPC44x_SIMPLE
 config PPC4xx_GPIO
 	bool "PPC4xx GPIO support"
 	depends on 44x
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 	  Enable gpiolib support for ppc440 based boards
 
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index f09016f6b3a6..bf7ae5cbd07a 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -6,7 +6,6 @@ config PPC_MPC512x
 	select IPIC
 	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_EHCI_BIG_ENDIAN_MMIO if USB_EHCI_HCD
 	select USB_EHCI_BIG_ENDIAN_DESC if USB_EHCI_HCD
 
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 2bdc8c862c46..4ef7f1cd05b7 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -116,7 +116,6 @@ endif
 # used for usb & gpio
 config PPC_MPC831x
 	bool
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 # used for math-emu
 config PPC_MPC832x
@@ -125,9 +124,7 @@ config PPC_MPC832x
 # used for usb & gpio
 config PPC_MPC834x
 	bool
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 # used for usb & gpio
 config PPC_MPC837x
 	bool
-	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index e626461a63bd..df25a3ed489d 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -225,7 +225,7 @@ config GE_IMP3A
 	select DEFAULT_UIMAGE
 	select SWIOTLB
 	select MMIO_NVRAM
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select GE_FPGA
 	help
 	  This option enables support for the GE Intelligent Platforms IMP3A
@@ -272,7 +272,7 @@ config CORENET_GENERIC
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 1afd1e4a2dd2..3988f16e46c1 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -4,7 +4,6 @@ menuconfig PPC_86xx
 	depends on 6xx
 	select FSL_SOC
 	select ALTIVEC
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  The Freescale E600 SoCs have 74xx cores.
 
@@ -37,7 +36,7 @@ config GEF_PPC9A
 	bool "GE PPC9A"
 	select DEFAULT_UIMAGE
 	select MMIO_NVRAM
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select GE_FPGA
 	help
 	  This option enables support for the GE PPC9A.
@@ -46,7 +45,7 @@ config GEF_SBC310
 	bool "GE SBC310"
 	select DEFAULT_UIMAGE
 	select MMIO_NVRAM
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select GE_FPGA
 	help
 	  This option enables support for the GE SBC310.
@@ -55,7 +54,7 @@ config GEF_SBC610
 	bool "GE SBC610"
 	select DEFAULT_UIMAGE
 	select MMIO_NVRAM
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select GE_FPGA
 	select HAS_RAPIDIO
 	help
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 157250426b56..564d99bb2a26 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -109,7 +109,7 @@ config 8xx_COPYBACK
 
 config 8xx_GPIO
 	bool "GPIO API Support"
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 	  Saying Y here will cause the ports on an MPC8xx processor to be used
 	  with the GPIO API.  If you say N here, the kernel needs less memory.
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 46a3533d3acb..3663f71fd913 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -275,7 +275,7 @@ config TAU_AVERAGE
 config QE_GPIO
 	bool "QE GPIO support"
 	depends on QUICC_ENGINE
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 	  Say Y here if you're going to use hardware that connects to the
 	  QE GPIOs.
@@ -285,7 +285,7 @@ config CPM2
 	depends on (FSL_SOC_BOOKE && PPC32) || 8260
 	select CPM
 	select PPC_PCI_CHOICE
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
 	  embedded CPUs made by Freescale.  Selecting this option means that
@@ -324,7 +324,7 @@ config OF_RTC
 config SIMPLE_GPIO
 	bool "Support for simple, memory-mapped GPIO controllers"
 	depends on PPC
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 	  Say Y here to support simple, memory-mapped GPIO controllers.
 	  These are usually BCSRs used to control board's switches, LEDs,
@@ -334,7 +334,7 @@ config SIMPLE_GPIO
 config MCU_MPC8349EMITX
 	bool "MPC8349E-mITX MCU driver"
 	depends on I2C=y && PPC_83xx
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 	  Say Y here to enable soft power-off functionality on the Freescale
 	  boards with the MPC8349E-mITX-compatible MCU chips. This driver will
-- 
2.4.11
