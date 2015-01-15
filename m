Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0109.outbound.protection.outlook.com [65.55.169.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 92C0C1A0E02
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:06:14 +1100 (AEDT)
From: <Yuantian.Tang@freescale.com>
To: <mturquette@linaro.org>
Subject: [PATCH 2/2] clk: ppc-corenet: rename driver to clk-qoriq
Date: Thu, 15 Jan 2015 14:03:41 +0800
Message-ID: <1421301821-18917-2-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1421301821-18917-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1421301821-18917-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Freescale introduced new ARM-based socs which using the compatible
clock IP block with PowerPC-based socs'. So this driver can be used
on both platforms.
Updated relevant descriptions and renamed this driver to better
represent its meaning and keep the function of driver untouched.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 Documentation/devicetree/bindings/clock/qoriq-clock.txt |  5 +++--
 drivers/clk/Kconfig                                     | 10 +++++-----
 drivers/clk/Makefile                                    |  2 +-
 drivers/clk/{clk-ppc-corenet.c => clk-qoriq.c}          |  6 +++---
 drivers/cpufreq/Kconfig.powerpc                         |  2 +-
 5 files changed, 13 insertions(+), 12 deletions(-)
 rename drivers/clk/{clk-ppc-corenet.c => clk-qoriq.c} (98%)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 266ff9d..df4a259 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -1,6 +1,6 @@
-* Clock Block on Freescale CoreNet Platforms
+* Clock Block on Freescale QorIQ Platforms
 
-Freescale CoreNet chips take primary clocking input from the external
+Freescale qoriq chips take primary clocking input from the external
 SYSCLK signal. The SYSCLK input (frequency) is multiplied using
 multiple phase locked loops (PLL) to create a variety of frequencies
 which can then be passed to a variety of internal logic, including
@@ -29,6 +29,7 @@ Required properties:
 	* "fsl,t4240-clockgen"
 	* "fsl,b4420-clockgen"
 	* "fsl,b4860-clockgen"
+	* "fsl,ls1021a-clockgen"
 	Chassis clock strings include:
 	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
 	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3f44f29..a896fbc 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -101,12 +101,12 @@ config COMMON_CLK_AXI_CLKGEN
 	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
 
-config CLK_PPC_CORENET
-	bool "Clock driver for PowerPC corenet platforms"
-	depends on PPC_E500MC && OF
+config CLK_QORIQ
+	bool "Clock driver for Freescale QorIQ platforms"
+	depends on (PPC_E500MC || ARM) && OF
 	---help---
-	  This adds the clock driver support for Freescale PowerPC corenet
-	  platforms using common clock framework.
+	  This adds the clock driver support for Freescale QorIQ platforms
+	  using common clock framework.
 
 config COMMON_CLK_XGENE
 	bool "Clock driver for APM XGene SoC"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d5fba5b..4ff94cd 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
-obj-$(CONFIG_CLK_PPC_CORENET)		+= clk-ppc-corenet.o
+obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
 obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-qoriq.c
similarity index 98%
rename from drivers/clk/clk-ppc-corenet.c
rename to drivers/clk/clk-qoriq.c
index 5e9bb18..f9b7eb4 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-qoriq.c
@@ -5,7 +5,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * clock driver for Freescale PowerPC corenet SoCs.
+ * clock driver for Freescale QorIQ SoCs.
  */
 #include <linux/clk-provider.h>
 #include <linux/io.h>
@@ -166,7 +166,7 @@ static void __init core_pll_init(struct device_node *np)
 
 	base = of_iomap(np, 0);
 	if (!base) {
-		pr_err("clk-ppc: iomap error\n");
+		pr_err("clk-qoriq: iomap error\n");
 		return;
 	}
 
@@ -260,7 +260,7 @@ static void __init sysclk_init(struct device_node *node)
 	u32 rate;
 
 	if (!np) {
-		pr_err("ppc-clk: could not get parent node\n");
+		pr_err("qoriq-clk: could not get parent node\n");
 		return;
 	}
 
diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index 72564b7..7ea2441 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -26,7 +26,7 @@ config CPU_FREQ_MAPLE
 config PPC_CORENET_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
 	depends on PPC_E500MC && OF && COMMON_CLK
-	select CLK_PPC_CORENET
+	select CLK_QORIQ
 	help
 	  This adds the CPUFreq driver support for Freescale e500mc,
 	  e5500 and e6500 series SoCs which are capable of changing
-- 
2.1.0.27.g96db324
