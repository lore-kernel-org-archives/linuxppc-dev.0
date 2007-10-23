Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C22EDDECE
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 07:58:38 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] 8xx: Convert mpc866ads to the new device binding.
Date: Wed, 24 Oct 2007 01:58:30 +0400
Message-ID: <20071023215829.6772.29220.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Verified on mpc866ads. This version has muram and brg nodes added to dts
to get the things work.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/boot/dts/mpc866ads.dts          |  156 ++++++++------
 arch/powerpc/platforms/8xx/Kconfig           |    1 
 arch/powerpc/platforms/8xx/mpc86xads.h       |   44 ----
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |  289 +++++++-------------------
 4 files changed, 175 insertions(+), 315 deletions(-)


diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index 90f2293..daf9433 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "MPC866ADS";
-	compatible = "mpc8xx";
+	compatible = "fsl,mpc866ads";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -23,15 +23,15 @@
 		PowerPC,866@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-line-size = <10>;	// 16 bytes
+			i-cache-line-size = <10>;	// 16 bytes
 			d-cache-size = <2000>;		// L1, 8K
 			i-cache-size = <4000>;		// L1, 16K
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
 			interrupts = <f 2>;	// decrementer interrupt
-			interrupt-parent = <&Mpc8xx_pic>;
+			interrupt-parent = <&PIC>;
 		};
 	};
 
@@ -40,107 +40,139 @@
 		reg = <00000000 800000>;
 	};
 
-	soc866@ff000000 {
+	localbus@ff000100 {
+		compatible = "fsl,mpc866-localbus", "fsl,pq1-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <ff000100 40>;
+
+		ranges = <
+			1 0 ff080000 00008000
+			5 0 ff0a0000 00008000
+		>;
+
+		board-control@1,0 {
+			reg = <1 0 20 5 300 4>;
+			compatible = "fsl,mpc866ads-bcsr";
+		};
+	};
+
+	soc@ff000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0 ff000000 00100000>;
 		reg = <ff000000 00000200>;
 		bus-frequency = <0>;
-		mdio@e80 {
-			device_type = "mdio";
-			compatible = "fs_enet";
-			reg = <e80 8>;
+
+		mdio@e00 {
+			compatible = "fsl,mpc866-fec-mdio", "fsl,pq1-fec-mdio";
+			reg = <e00 188>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			phy: ethernet-phy@f {
+			PHY: ethernet-phy@f {
 				reg = <f>;
 				device_type = "ethernet-phy";
 			};
 		};
 
-		fec@e00 {
+		ethernet@e00 {
 			device_type = "network";
-			compatible = "fs_enet";
-			model = "FEC";
-			device-id = <1>;
+			compatible = "fsl,mpc866-fec-enet",
+			             "fsl,pq1-fec-enet";
 			reg = <e00 188>;
-			mac-address = [ 00 00 0C 00 01 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <3 1>;
-			interrupt-parent = <&Mpc8xx_pic>;
-			phy-handle = <&Phy>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY>;
+			linux,network-index = <0>;
 		};
 
-		mpc8xx_pic: pic@ff000000 {
+		PIC: pic@0 {
 			interrupt-controller;
-			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0 24>;
-			device_type = "mpc8xx-pic";
-			compatible = "CPM";
+			compatible = "fsl,mpc866-pic", "fsl,pq1-pic";
 		};
 
-		cpm@ff000000 {
+		cpm@9c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			device_type = "cpm";
-			model = "CPM";
-			ranges = <0 0 4000>;
-			reg = <860 f0>;
-			command-proc = <9c0>;
+			compatible = "fsl,mpc866-cpm", "fsl,cpm1";
+			ranges;
+			reg = <9c0 40>;
 			brg-frequency = <0>;
 			interrupts = <0 2>;	// cpm error interrupt
-			interrupt-parent = <&Cpm_pic>;
+			interrupt-parent = <&CPM_PIC>;
 
-			cpm_pic: pic@930 {
+			muram@2000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 2000 2000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 1c00>;
+				};
+			};
+
+			brg@9f0 {
+				compatible = "fsl,mpc866-brg",
+					     "fsl,cpm1-brg",
+					     "fsl,cpm-brg";
+				reg = <9f0 10>;
+				clock-frequency = <0>;
+			};
+
+			CPM_PIC: pic@930 {
 				interrupt-controller;
 				#address-cells = <0>;
-				#interrupt-cells = <2>;
+				#interrupt-cells = <1>;
 				interrupts = <5 2 0 2>;
-				interrupt-parent = <&Mpc8xx_pic>;
+				interrupt-parent = <&PIC>;
 				reg = <930 20>;
-				device_type = "cpm-pic";
-				compatible = "CPM";
+				compatible = "fsl,mpc866-cpm-pic",
+				             "fsl,cpm1-pic";
 			};
 
-			smc@a80 {
+
+			serial@a80 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SMC";
-				device-id = <1>;
+				compatible = "fsl,mpc866-smc-uart",
+				             "fsl,cpm1-smc-uart";
 				reg = <a80 10 3e80 40>;
-				clock-setup = <00ffffff 0>;
-				rx-clock = <1>;
-				tx-clock = <1>;
-				current-speed = <0>;
-				interrupts = <4 3>;
-				interrupt-parent = <&Cpm_pic>;
+				interrupts = <4>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0090>;
 			};
 
-			smc@a90 {
+			serial@a90 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SMC";
-				device-id = <2>;
-				reg = <a90 20 3f80 40>;
-				clock-setup = <ff00ffff 90000>;
-				rx-clock = <2>;
-				tx-clock = <2>;
-				current-speed = <0>;
-				interrupts = <3 3>;
-				interrupt-parent = <&Cpm_pic>;
+				compatible = "fsl,mpc866-smc-uart",
+				             "fsl,cpm1-smc-uart";
+				reg = <a90 10 3f80 40>;
+				interrupts = <3>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <00d0>;
 			};
 
-			scc@a00 {
+			ethernet@a00 {
 				device_type = "network";
-				compatible = "fs_enet";
-				model = "SCC";
-				device-id = <1>;
-				reg = <a00 18 3c00 80>;
-				mac-address = [ 00 00 0C 00 03 FD ];
-				interrupts = <1e 3>;
-				interrupt-parent = <&Cpm_pic>;
+				compatible = "fsl,mpc866-scc-enet",
+				             "fsl,cpm1-scc-enet";
+				reg = <a00 18 3c00 100>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				interrupts = <1e>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-command = <0000>;
+				linux,network-index = <1>;
 			};
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc/cpm/serial@a80";
+	};
 };
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index bd28655..91fbe42 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -18,6 +18,7 @@ config MPC8XXFADS
 config MPC86XADS
 	bool "MPC86XADS"
 	select CPM1
+	select PPC_CPM_NEW_BINDING
 	help
 	  MPC86x Application Development System by Freescale Semiconductor.
 	  The MPC86xADS is meant to serve as a platform for s/w and h/w
diff --git a/arch/powerpc/platforms/8xx/mpc86xads.h b/arch/powerpc/platforms/8xx/mpc86xads.h
index cffa194..17b1fe7 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads.h
+++ b/arch/powerpc/platforms/8xx/mpc86xads.h
@@ -15,27 +15,6 @@
 #ifndef __ASM_MPC86XADS_H__
 #define __ASM_MPC86XADS_H__
 
-#include <sysdev/fsl_soc.h>
-
-/* U-Boot maps BCSR to 0xff080000 */
-#define BCSR_ADDR		((uint)0xff080000)
-#define BCSR_SIZE		((uint)32)
-#define BCSR0			((uint)(BCSR_ADDR + 0x00))
-#define BCSR1			((uint)(BCSR_ADDR + 0x04))
-#define BCSR2			((uint)(BCSR_ADDR + 0x08))
-#define BCSR3			((uint)(BCSR_ADDR + 0x0c))
-#define BCSR4			((uint)(BCSR_ADDR + 0x10))
-
-#define CFG_PHYDEV_ADDR		((uint)0xff0a0000)
-#define BCSR5			((uint)(CFG_PHYDEV_ADDR + 0x300))
-
-#define MPC8xx_CPM_OFFSET	(0x9c0)
-#define CPM_MAP_ADDR		(get_immrbase() + MPC8xx_CPM_OFFSET)
-#define CPM_IRQ_OFFSET		16     // for compability with cpm_uart driver
-
-#define PCMCIA_MEM_ADDR		((uint)0xff020000)
-#define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
-
 /* Bits of interest in the BCSRs.
  */
 #define BCSR1_ETHEN		((uint)0x20000000)
@@ -64,28 +43,5 @@
 #define BCSR5_MII1_EN		0x02
 #define BCSR5_MII1_RST		0x01
 
-/* Interrupt level assignments */
-#define PHY_INTERRUPT	SIU_IRQ7	/* PHY link change interrupt */
-#define SIU_INT_FEC1	SIU_LEVEL1	/* FEC1 interrupt */
-#define FEC_INTERRUPT	SIU_INT_FEC1	/* FEC interrupt */
-
-/* We don't use the 8259 */
-#define NR_8259_INTS	0
-
-/* CPM Ethernet through SCC1 */
-#define PA_ENET_RXD     ((ushort)0x0001)
-#define PA_ENET_TXD     ((ushort)0x0002)
-#define PA_ENET_TCLK    ((ushort)0x0100)
-#define PA_ENET_RCLK    ((ushort)0x0200)
-#define PB_ENET_TENA    ((uint)0x00001000)
-#define PC_ENET_CLSN    ((ushort)0x0010)
-#define PC_ENET_RENA    ((ushort)0x0020)
-
-/* Control bits in the SICR to route TCLK (CLK1) and RCLK (CLK2) to
- * SCC1.  Also, make sure GR1 (bit 24) and SC1 (bit 25) are zero.
- */
-#define SICR_ENET_MASK  ((uint)0x000000ff)
-#define SICR_ENET_CLKRT ((uint)0x0000002c)
-
 #endif /* __ASM_MPC86XADS_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index 4901283..d2927a4 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -6,264 +6,134 @@
  *
  * Copyright 2005 MontaVista Software Inc.
  *
+ * Heavily modified by Scott Wood <scottwood@freescale.com>
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <linux/ioport.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/root_dev.h>
-
-#include <linux/fs_enet_pd.h>
-#include <linux/fs_uart_pd.h>
-#include <linux/mii.h>
+#include <linux/of_platform.h>
 
-#include <asm/delay.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/page.h>
-#include <asm/processor.h>
 #include <asm/system.h>
 #include <asm/time.h>
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
 #include <asm/commproc.h>
 #include <asm/fs_pd.h>
-#include <asm/prom.h>
+#include <asm/udbg.h>
 
 #include <sysdev/commproc.h>
 
-static void init_smc1_uart_ioports(struct fs_uart_platform_info* fpi);
-static void init_smc2_uart_ioports(struct fs_uart_platform_info* fpi);
-static void init_scc1_ioports(struct fs_platform_info* ptr);
-
-void __init mpc86xads_board_setup(void)
-{
-	cpm8xx_t *cp;
- 	unsigned int *bcsr_io;
-	u8 tmpval8;
-
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-	cp = (cpm8xx_t *)immr_map(im_cpm);
-
-	if (bcsr_io == NULL) {
-		printk(KERN_CRIT "Could not remap BCSR\n");
-		return;
-	}
-#ifdef CONFIG_SERIAL_CPM_SMC1
-	clrbits32(bcsr_io, BCSR1_RS232EN_1);
-	clrbits32(&cp->cp_simode, 0xe0000000 >> 17);	/* brg1 */
-	tmpval8 = in_8(&(cp->cp_smc[0].smc_smcm)) | (SMCM_RX | SMCM_TX);
-	out_8(&(cp->cp_smc[0].smc_smcm), tmpval8);
-	clrbits16(&cp->cp_smc[0].smc_smcmr, SMCMR_REN | SMCMR_TEN);
-#else
-	setbits32(bcsr_io,BCSR1_RS232EN_1);
-	out_be16(&cp->cp_smc[0].smc_smcmr, 0);
-	out_8(&cp->cp_smc[0].smc_smce, 0);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SMC2
-	clrbits32(bcsr_io,BCSR1_RS232EN_2);
-	clrbits32(&cp->cp_simode, 0xe0000000 >> 1);
-	setbits32(&cp->cp_simode, 0x20000000 >> 1);	/* brg2 */
-	tmpval8 = in_8(&(cp->cp_smc[1].smc_smcm)) | (SMCM_RX | SMCM_TX);
-	out_8(&(cp->cp_smc[1].smc_smcm), tmpval8);
-	clrbits16(&cp->cp_smc[1].smc_smcmr, SMCMR_REN | SMCMR_TEN);
+#include "mpc86xads.h"
 
-	init_smc2_uart_ioports(0);
-#else
-	setbits32(bcsr_io,BCSR1_RS232EN_2);
-	out_be16(&cp->cp_smc[1].smc_smcmr, 0);
-	out_8(&cp->cp_smc[1].smc_smce, 0);
-#endif
-	immr_unmap(cp);
-	iounmap(bcsr_io);
-}
+struct cpm_pin {
+	int port, pin, flags;
+};
 
+static struct cpm_pin mpc866ads_pins[] = {
+	/* SMC1 */
+	{CPM_PORTB, 24, CPM_PIN_INPUT}, /* RX */
+	{CPM_PORTB, 25, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
+
+	/* SMC2 */
+	{CPM_PORTB, 21, CPM_PIN_INPUT}, /* RX */
+	{CPM_PORTB, 20, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
+
+	/* SCC1 */
+	{CPM_PORTA, 6, CPM_PIN_INPUT}, /* CLK1 */
+	{CPM_PORTA, 7, CPM_PIN_INPUT}, /* CLK2 */
+	{CPM_PORTA, 14, CPM_PIN_INPUT}, /* TX */
+	{CPM_PORTA, 15, CPM_PIN_INPUT}, /* RX */
+	{CPM_PORTB, 19, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TENA */
+	{CPM_PORTC, 10, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_GPIO}, /* RENA */
+	{CPM_PORTC, 11, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_GPIO}, /* CLSN */
+
+	/* MII */
+	{CPM_PORTD, 3, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 4, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 5, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 6, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 7, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 8, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 9, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 10, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 11, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 12, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 13, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 14, CPM_PIN_OUTPUT},
+	{CPM_PORTD, 15, CPM_PIN_OUTPUT},
+};
 
-static void init_fec1_ioports(struct fs_platform_info* ptr)
+static void __init init_ioports(void)
 {
-	iop8xx_t *io_port = (iop8xx_t *)immr_map(im_ioport);
+	int i;
 
-	/* configure FEC1 pins  */
+	for (i = 0; i < ARRAY_SIZE(mpc866ads_pins); i++) {
+		struct cpm_pin *pin = &mpc866ads_pins[i];
+		cpm1_set_pin(pin->port, pin->pin, pin->flags);
+	}
 
-	setbits16(&io_port->iop_pdpar, 0x1fff);
-	setbits16(&io_port->iop_pddir, 0x1fff);
+	cpm1_clk_setup(CPM_CLK_SMC1, CPM_BRG1, CPM_CLK_RTX);
+	cpm1_clk_setup(CPM_CLK_SMC2, CPM_BRG2, CPM_CLK_RTX);
+	cpm1_clk_setup(CPM_CLK_SCC1, CPM_CLK1, CPM_CLK_TX);
+	cpm1_clk_setup(CPM_CLK_SCC1, CPM_CLK2, CPM_CLK_RX);
 
-	immr_unmap(io_port);
+	/* Set FEC1 and FEC2 to MII mode */
+	clrbits32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
 }
 
-void init_fec_ioports(struct fs_platform_info *fpi)
+static void __init mpc86xads_setup_arch(void)
 {
-	int fec_no = fs_get_fec_index(fpi->fs_no);
+	struct device_node *np;
+	u32 __iomem *bcsr_io;
+
+	cpm_reset();
+	init_ioports();
 
-	switch (fec_no) {
-	case 0:
-		init_fec1_ioports(fpi);
-		break;
-	default:
-		printk(KERN_ERR "init_fec_ioports: invalid FEC number\n");
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc866ads-bcsr");
+	if (!np) {
+		printk(KERN_CRIT "Could not find fsl,mpc866ads-bcsr node\n");
 		return;
 	}
-}
 
-static void init_scc1_ioports(struct fs_platform_info* fpi)
-{
-	unsigned *bcsr_io;
-	iop8xx_t *io_port;
-	cpm8xx_t *cp;
-
-	bcsr_io = ioremap(BCSR_ADDR, BCSR_SIZE);
-	io_port = (iop8xx_t *)immr_map(im_ioport);
-	cp = (cpm8xx_t *)immr_map(im_cpm);
+	bcsr_io = of_iomap(np, 0);
+	of_node_put(np);
 
 	if (bcsr_io == NULL) {
 		printk(KERN_CRIT "Could not remap BCSR\n");
 		return;
 	}
 
-	/* Configure port A pins for Txd and Rxd.
-	 */
-	setbits16(&io_port->iop_papar, PA_ENET_RXD | PA_ENET_TXD);
-	clrbits16(&io_port->iop_padir, PA_ENET_RXD | PA_ENET_TXD);
-	clrbits16(&io_port->iop_paodr, PA_ENET_TXD);
-
-	/* Configure port C pins to enable CLSN and RENA.
-	 */
-	clrbits16(&io_port->iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
-	clrbits16(&io_port->iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
-	setbits16(&io_port->iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
-
-	/* Configure port A for TCLK and RCLK.
-	 */
-	setbits16(&io_port->iop_papar, PA_ENET_TCLK | PA_ENET_RCLK);
-        clrbits16(&io_port->iop_padir, PA_ENET_TCLK | PA_ENET_RCLK);
-        clrbits32(&cp->cp_pbpar, PB_ENET_TENA);
-        clrbits32(&cp->cp_pbdir, PB_ENET_TENA);
-
-	/* Configure Serial Interface clock routing.
-	 * First, clear all SCC bits to zero, then set the ones we want.
-	 */
-	clrbits32(&cp->cp_sicr, SICR_ENET_MASK);
-	setbits32(&cp->cp_sicr, SICR_ENET_CLKRT);
-
-	/* In the original SCC enet driver the following code is placed at
-	   the end of the initialization */
-        setbits32(&cp->cp_pbpar, PB_ENET_TENA);
-        setbits32(&cp->cp_pbdir, PB_ENET_TENA);
-
-	clrbits32(bcsr_io+1, BCSR1_ETHEN);
+	clrbits32(bcsr_io, BCSR1_RS232EN_1 | BCSR1_RS232EN_2 | BCSR1_ETHEN);
 	iounmap(bcsr_io);
-	immr_unmap(cp);
-	immr_unmap(io_port);
-}
-
-void init_scc_ioports(struct fs_platform_info *fpi)
-{
-	int scc_no = fs_get_scc_index(fpi->fs_no);
-
-	switch (scc_no) {
-	case 0:
-		init_scc1_ioports(fpi);
-		break;
-	default:
-		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
-		return;
-	}
 }
 
-
-
-static void init_smc1_uart_ioports(struct fs_uart_platform_info* ptr)
+static int __init mpc86xads_probe(void)
 {
-        unsigned *bcsr_io;
-	cpm8xx_t *cp = (cpm8xx_t *)immr_map(im_cpm);
-
-	setbits32(&cp->cp_pbpar, 0x000000c0);
-	clrbits32(&cp->cp_pbdir, 0x000000c0);
-	clrbits16(&cp->cp_pbodr, 0x00c0);
-	immr_unmap(cp);
-
-        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-
-        if (bcsr_io == NULL) {
-                printk(KERN_CRIT "Could not remap BCSR1\n");
-                return;
-        }
-        clrbits32(bcsr_io,BCSR1_RS232EN_1);
-        iounmap(bcsr_io);
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,mpc866ads");
 }
 
-static void init_smc2_uart_ioports(struct fs_uart_platform_info* fpi)
-{
-        unsigned *bcsr_io;
-	cpm8xx_t *cp = (cpm8xx_t *)immr_map(im_cpm);
-
-	setbits32(&cp->cp_pbpar, 0x00000c00);
-	clrbits32(&cp->cp_pbdir, 0x00000c00);
-	clrbits16(&cp->cp_pbodr, 0x0c00);
-	immr_unmap(cp);
-
-        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-
-        if (bcsr_io == NULL) {
-                printk(KERN_CRIT "Could not remap BCSR1\n");
-                return;
-        }
-        clrbits32(bcsr_io,BCSR1_RS232EN_2);
-        iounmap(bcsr_io);
-}
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "cpm", },
+	{ .name = "localbus", },
+	{},
+};
 
-void init_smc_ioports(struct fs_uart_platform_info *data)
+static int __init declare_of_platform_devices(void)
 {
-	int smc_no = fs_uart_id_fsid2smc(data->fs_no);
+	if (machine_is(mpc86x_ads))
+		of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
-	switch (smc_no) {
-	case 0:
-		init_smc1_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	case 1:
-		init_smc2_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	default:
-		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
-		return;
-	}
-}
-
-int platform_device_skip(const char *model, int id)
-{
 	return 0;
 }
-
-static void __init mpc86xads_setup_arch(void)
-{
-	cpm_reset();
-
-	mpc86xads_board_setup();
-
-	ROOT_DEV = Root_NFS;
-}
-
-static int __init mpc86xads_probe(void)
-{
-	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
-					  "model", NULL);
-	if (model == NULL)
-		return 0;
-	if (strcmp(model, "MPC866ADS"))
-		return 0;
-
-	return 1;
-}
+device_initcall(declare_of_platform_devices);
 
 define_machine(mpc86x_ads) {
 	.name			= "MPC86x ADS",
@@ -275,4 +145,5 @@ define_machine(mpc86x_ads) {
 	.calibrate_decr		= mpc8xx_calibrate_decr,
 	.set_rtc_time		= mpc8xx_set_rtc_time,
 	.get_rtc_time		= mpc8xx_get_rtc_time,
+	.progress		= udbg_progress,
 };
