Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 903B2DE056
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 07:08:44 +1000 (EST)
Date: Mon, 8 Oct 2007 16:08:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 2/3] mpc85xx: Convert mpc8560ads to the new CPM binding.
Message-ID: <20071008210851.GA24445@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071008210829.GA24428@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8560ads.dts      |   82 ++++++++-------
 arch/powerpc/platforms/85xx/Kconfig       |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |  167 +++++++++++++++-------------
 3 files changed, 134 insertions(+), 116 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 5577ec1..6b362f8 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -138,15 +138,31 @@
 			device_type = "open-pic";
 		};
 
-		cpm@e0000000 {
+		cpm@919c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			device_type = "cpm";
-			model = "CPM2";
-			ranges = <0 0 c0000>;
-			reg = <80000 40000>;
-			command-proc = <919c0>;
-			brg-frequency = <9d5b340>;
+			compatible = "fsl,mpc8560-cpm", "fsl,cpm2";
+			reg = <919c0 30>;
+			ranges;
+
+			muram@80000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 80000 10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 4000 9000 2000>;
+				};
+			};
+
+			brg@919f0 {
+				compatible = "fsl,mpc8560-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <919f0 10 915f0 10>;
+				clock-frequency = <d#165000000>;
+			};
 
 			cpmpic: pic@90c00 {
 				interrupt-controller;
@@ -155,43 +171,38 @@
 				interrupts = <2e 2>;
 				interrupt-parent = <&mpic>;
 				reg = <90c00 80>;
-				device_type = "cpm-pic";
+				compatible = "fsl,mpc8560-cpm-pic", "fsl,cpm2-pic";
 			};
 
-			scc@91a00 {
+			serial@91a00 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SCC";
-				device-id = <1>;
+				compatible = "fsl,mpc8560-scc-uart",
+				             "fsl,cpm2-scc-uart";
 				reg = <91a00 20 88000 100>;
-				clock-setup = <00ffffff 0>;
-				rx-clock = <1>;
-				tx-clock = <1>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <00800000>;
 				current-speed = <1c200>;
 				interrupts = <28 8>;
 				interrupt-parent = <&cpmpic>;
 			};
 
-			scc@91a20 {
+			serial@91a20 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SCC";
-				device-id = <2>;
+				compatible = "fsl,mpc8560-scc-uart",
+				             "fsl,cpm2-scc-uart";
 				reg = <91a20 20 88100 100>;
-				clock-setup = <ff00ffff 90000>;
-				rx-clock = <2>;
-				tx-clock = <2>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <04a00000>;
 				current-speed = <1c200>;
 				interrupts = <29 8>;
 				interrupt-parent = <&cpmpic>;
 			};
 
-			fcc@91320 {
+			ethernet@91320 {
 				device_type = "network";
-				compatible = "fs_enet";
-				model = "FCC";
-				device-id = <2>;
-				reg = <91320 20 88500 100 913a0 30>;
+				compatible = "fsl,mpc8560-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <91320 20 88500 100 913b0 1>;
 				/*
 				 * mac-address is deprecated and will be removed
 				 * in 2.6.25.  Only recent versions of
@@ -199,20 +210,17 @@
 				 */
 				mac-address = [ 00 00 00 00 00 00 ];
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				clock-setup = <ff00ffff 250000>;
-				rx-clock = <15>;
-				tx-clock = <16>;
+				fsl,cpm-command = <16200300>;
 				interrupts = <21 8>;
 				interrupt-parent = <&cpmpic>;
 				phy-handle = <&phy2>;
 			};
 
-			fcc@91340 {
+			ethernet@91340 {
 				device_type = "network";
-				compatible = "fs_enet";
-				model = "FCC";
-				device-id = <3>;
-				reg = <91340 20 88600 100 913d0 30>;
+				compatible = "fsl,mpc8560-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <91340 20 88600 100 913d0 1>;
 				/*
 				 * mac-address is deprecated and will be removed
 				 * in 2.6.25.  Only recent versions of
@@ -220,9 +228,7 @@
 				 */
 				mac-address = [ 00 00 00 00 00 00 ];
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				clock-setup = <ffff00ff 3700>;
-				rx-clock = <17>;
-				tx-clock = <18>;
+				fsl,cpm-command = <1a400300>;
 				interrupts = <22 8>;
 				interrupt-parent = <&cpmpic>;
 				phy-handle = <&phy3>;
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index b8476b2..439f815 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -12,6 +12,7 @@ config MPC8540_ADS
 config MPC8560_ADS
 	bool "Freescale MPC8560 ADS"
 	select DEFAULT_UIMAGE
+	select PPC_CPM_NEW_BINDING
 	help
 	  This option enables support for the MPC 8560 ADS board
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 378a244..509d46b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -17,13 +17,13 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpc85xx.h>
-#include <asm/prom.h>
 #include <asm/mpic.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
@@ -32,10 +32,8 @@
 #include <sysdev/fsl_pci.h>
 
 #ifdef CONFIG_CPM2
-#include <linux/fs_enet_pd.h>
 #include <asm/cpm2.h>
 #include <sysdev/cpm2_pic.h>
-#include <asm/fs_pd.h>
 #endif
 
 #ifdef CONFIG_PCI
@@ -95,10 +93,10 @@ static void __init mpc85xx_ads_pic_init(void)
 
 #ifdef CONFIG_CPM2
 	/* Setup CPM2 PIC */
-	np = of_find_node_by_type(NULL, "cpm-pic");
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
 	if (np == NULL) {
-		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
-                return;
+		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
+		return;
 	}
 	irq = irq_of_parse_and_map(np, 0);
 
@@ -111,81 +109,75 @@ static void __init mpc85xx_ads_pic_init(void)
  * Setup the architecture
  */
 #ifdef CONFIG_CPM2
-void init_fcc_ioports(struct fs_platform_info *fpi)
+struct cpm_pin {
+	int port, pin, flags;
+};
+
+static struct cpm_pin mpc8560_ads_pins[] = {
+	/* SCC1 */
+	{3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* SCC2 */
+	{3, 26, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 27, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC2 */
+	{1, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 20, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 25, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 26, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 27, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{1, 30, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK14 */
+	{2, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK13 */
+
+	/* FCC3 */
+	{1, 4, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 5, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 6, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 7, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 9, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 10, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 11, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 12, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 13, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 14, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 15, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 16, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK16 */
+	{2, 17, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK15 */
+};
+
+static void __init init_ioports(void)
 {
-	struct io_port *io = cpm2_map(im_ioport);
-	int fcc_no = fs_get_fcc_index(fpi->fs_no);
-	int target;
-	u32 tempval;
-
-	switch(fcc_no) {
-	case 1:
-		tempval = in_be32(&io->iop_pdirb);
-		tempval &= ~PB2_DIRB0;
-		tempval |= PB2_DIRB1;
-		out_be32(&io->iop_pdirb, tempval);
-
-		tempval = in_be32(&io->iop_psorb);
-		tempval &= ~PB2_PSORB0;
-		tempval |= PB2_PSORB1;
-		out_be32(&io->iop_psorb, tempval);
-
-		tempval = in_be32(&io->iop_pparb);
-		tempval |= (PB2_DIRB0 | PB2_DIRB1);
-		out_be32(&io->iop_pparb, tempval);
-
-		target = CPM_CLK_FCC2;
-		break;
-	case 2:
-		tempval = in_be32(&io->iop_pdirb);
-		tempval &= ~PB3_DIRB0;
-		tempval |= PB3_DIRB1;
-		out_be32(&io->iop_pdirb, tempval);
-
-		tempval = in_be32(&io->iop_psorb);
-		tempval &= ~PB3_PSORB0;
-		tempval |= PB3_PSORB1;
-		out_be32(&io->iop_psorb, tempval);
-
-		tempval = in_be32(&io->iop_pparb);
-		tempval |= (PB3_DIRB0 | PB3_DIRB1);
-		out_be32(&io->iop_pparb, tempval);
-
-		tempval = in_be32(&io->iop_pdirc);
-		tempval |= PC3_DIRC1;
-		out_be32(&io->iop_pdirc, tempval);
-
-		tempval = in_be32(&io->iop_pparc);
-		tempval |= PC3_DIRC1;
-		out_be32(&io->iop_pparc, tempval);
-
-		target = CPM_CLK_FCC3;
-		break;
-	default:
-		printk(KERN_ERR "init_fcc_ioports: invalid FCC number\n");
-		return;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mpc8560_ads_pins); i++) {
+		struct cpm_pin *pin = &mpc8560_ads_pins[i];
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
 	}
 
-	/* Port C has clocks......  */
-	tempval = in_be32(&io->iop_psorc);
-	tempval &= ~(PC_CLK(fpi->clk_rx - 8) | PC_CLK(fpi->clk_tx - 8));
-	out_be32(&io->iop_psorc, tempval);
-
-	tempval = in_be32(&io->iop_pdirc);
-	tempval &= ~(PC_CLK(fpi->clk_rx - 8) | PC_CLK(fpi->clk_tx - 8));
-	out_be32(&io->iop_pdirc, tempval);
-	tempval = in_be32(&io->iop_pparc);
-	tempval |= (PC_CLK(fpi->clk_rx - 8) | PC_CLK(fpi->clk_tx - 8));
-	out_be32(&io->iop_pparc, tempval);
-
-	cpm2_unmap(io);
-
-	/* Configure Serial Interface clock routing.
-	 * First,  clear FCC bits to zero,
-	 * then set the ones we want.
-	 */
-	cpm2_clk_setup(target, fpi->clk_rx, CPM_CLK_RX);
-	cpm2_clk_setup(target, fpi->clk_tx, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK13, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK14, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK15, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK16, CPM_CLK_TX);
 }
 #endif
 
@@ -200,6 +192,7 @@ static void __init mpc85xx_ads_setup_arch(void)
 
 #ifdef CONFIG_CPM2
 	cpm2_reset();
+	init_ioports();
 #endif
 
 #ifdef CONFIG_PCI
@@ -231,6 +224,24 @@ static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .type = "soc", },
+	{ .name = "cpm", },
+	{ .name = "localbus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc85xx_ads))
+		return 0;
+
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	return 0;
+}
+device_initcall(declare_of_platform_devices);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
-- 
1.5.3.4
