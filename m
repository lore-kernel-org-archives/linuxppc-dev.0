Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EB16ADE7D5
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 01:27:37 +1000 (EST)
Date: Mon, 25 Aug 2008 19:27:36 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC PATCH 2/2] powerpc/83xx: mpc836x_mds: add support for USB Host
Message-ID: <20080825152736.GB25178@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Various changes to support QE USB Host on a MPC8360E-MDS board:

- Update the device tree per QE USB bindings;
- Configure QE Par IO;
- Set up BCSR for both USB Host and Peripheral modes;
- Add timer (GTM) node;
- Add gpio-controller node for BCSR13 bank;
- Select FSL_GTM, QE_GPIO and OF_SIMPLE_GPIO.

The work is loosely based on Li Yang's patch[1], which is used
to support peripheral mode only.

[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061357.html

The s-o-b line of the original patch preserved here.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc836x_mds.dts     |   44 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/83xx/Kconfig       |    3 ++
 arch/powerpc/platforms/83xx/mpc836x_mds.c |   31 +++++++++++++++++++-
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index ada8446..0be98f3 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -69,8 +69,19 @@
 		};
 
 		bcsr@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "board-control";
 			reg = <1 0 0x8000>;
+			ranges = <0 1 0 0x8000>;
+
+			bcsr13: gpio-controller@d {
+				#gpio-cells = <2>;
+				compatible = "fsl,mpc8360mds-bcsr-gpio",
+					     "simple-gpio-bank";
+				reg = <0xd 1>;
+				gpio-controller;
+			};
 		};
 	};
 
@@ -191,10 +202,21 @@
 		};
 
 		par_io@1400 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			reg = <0x1400 0x100>;
+			ranges = <0 0x1400 0x100>;
 			device_type = "par_io";
 			num-ports = <7>;
 
+			qe_pio_b: gpio-controller@18 {
+				#gpio-cells = <2>;
+				compatible = "fsl,mpc8360-qe-pario-bank",
+					     "fsl,mpc8323-qe-pario-bank";
+				reg = <0x18 0x18>;
+				gpio-controller;
+			};
+
 			pio1: ucc_pin@01 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
@@ -278,6 +300,15 @@
 			};
 		};
 
+		timer@440 {
+			compatible = "fsl,mpc8360-qe-gtm",
+				     "fsl,qe-gtm", "fsl,gtm";
+			reg = <0x440 0x40>;
+			clock-frequency = <132000000>;
+			interrupts = <12 13 14 15>;
+			interrupt-parent = <&qeic>;
+		};
+
 		spi@4c0 {
 			cell-index = <0>;
 			compatible = "fsl,spi";
@@ -297,11 +328,20 @@
 		};
 
 		usb@6c0 {
-			compatible = "qe_udc";
+			compatible = "fsl,mpc8360-qe-usb",
+				     "fsl,mpc8323-qe-usb";
 			reg = <0x6c0 0x40 0x8b00 0x100>;
 			interrupts = <11>;
 			interrupt-parent = <&qeic>;
-			mode = "slave";
+			fsl,fullspeed-clock = "clk21";
+			fsl,lowspeed-clock = "brg9";
+			gpios = <&qe_pio_b  2 0   /* USBOE */
+				 &qe_pio_b  3 0   /* USBTP */
+				 &qe_pio_b  8 0   /* USBTN */
+				 &qe_pio_b  9 0   /* USBRP */
+				 &qe_pio_b 11 0   /* USBRN */
+				 &bcsr13    5 0   /* SPEED */
+				 &bcsr13    4 1>; /* POWER */
 		};
 
 		enet0: ucc@2000 {
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 6159c5d..558458d 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -58,6 +58,9 @@ config MPC836x_MDS
 	bool "Freescale MPC836x MDS"
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
+	select QE_GPIO
+	select OF_SIMPLE_GPIO
+	select FSL_GTM
 	help
 	  This option enables support for the MPC836x MDS Processor Board.
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 9d46e5b..58aabfb 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -127,9 +127,38 @@ static void __init mpc836x_mds_setup_arch(void)
 			iounmap(immap);
 		}
 
-		iounmap(bcsr_regs);
 		of_node_put(np);
 	}
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc8323-qe-usb");
+	if (np) {
+		const char *mode = of_get_property(np, "mode", NULL);
+
+		par_io_config_pin(1,  2, 1, 0, 3, 0); /* USBOE  */
+		par_io_config_pin(1,  3, 1, 0, 3, 0); /* USBTP  */
+		par_io_config_pin(1,  8, 1, 0, 1, 0); /* USBTN  */
+		par_io_config_pin(1, 10, 2, 0, 3, 0); /* USBRXD */
+		par_io_config_pin(1,  9, 2, 1, 3, 0); /* USBRP  */
+		par_io_config_pin(1, 11, 2, 1, 3, 0); /* USBRN  */
+		par_io_config_pin(2, 20, 2, 0, 1, 0); /* CLK21  */
+
+#define BCSR13_USBMASK	0x0f
+#define BCSR13_nUSBEN	0x08 /* 1 - Disable, 0 - Enable			*/
+#define BCSR13_USBSPEED 0x04 /* 1 - Full, 0 - Low			*/
+#define BCSR13_USBMODE	0x02 /* 1 - Host, 0 - Function			*/
+#define BCSR13_nUSBVCC	0x01 /* 1 - gets VBUS, 0 - supplies VBUS 	*/
+
+		clrsetbits_8(&bcsr_regs[13], BCSR13_USBMASK, BCSR13_USBSPEED);
+
+		if (mode && !strcmp(mode, "peripheral"))
+			setbits8(&bcsr_regs[13], BCSR13_nUSBVCC);
+		else
+			setbits8(&bcsr_regs[13], BCSR13_USBMODE);
+
+		of_node_put(np);
+	}
+
+	iounmap(bcsr_regs);
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-- 
1.5.6.3
