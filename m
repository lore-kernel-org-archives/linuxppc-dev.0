Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 449FCDDF28
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 06:27:45 +1100 (EST)
Date: Wed, 3 Dec 2008 22:27:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/5] powerpc/83xx: Add USB Host/Gadget support for
	MPC8360E-MDS boards
Message-ID: <20081203192743.GC13035@oksana.dev.rtsoft.ru>
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- Update the device tree per QE USB bindings;
- Add timer (FSL GTM) node;
- Add gpio-controller node for BCSR13 bank (GPIOs on that bank
  are used to control the USB transceiver);
- Set up other BCSR registers;
- Configure the QE Par IO.

The work is loosely based on Li Yang's patch[1], which was used
to support peripheral mode only.

[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061357.html

The s-o-b line of the original patch preserved here.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc836x_mds.dts     |   43 ++++++++++++++++-
 arch/powerpc/platforms/83xx/mpc836x_mds.c |   75 +++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 14534d0..6e34f17 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -69,8 +69,18 @@
 		};
 
 		bcsr@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
  			compatible = "fsl,mpc8360mds-bcsr";
 			reg = <1 0 0x8000>;
+			ranges = <0 1 0 0x8000>;
+
+			bcsr13: gpio-controller@d {
+				#gpio-cells = <2>;
+				compatible = "fsl,mpc8360mds-bcsr-gpio";
+				reg = <0xd 1>;
+				gpio-controller;
+			};
 		};
 	};
 
@@ -195,10 +205,21 @@
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
@@ -282,6 +303,15 @@
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
@@ -301,11 +331,20 @@
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
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 9d46e5b..fbcca19 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -43,6 +43,7 @@
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include <sysdev/simple_gpio.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
 
@@ -93,6 +94,16 @@ static void __init mpc836x_mds_setup_arch(void)
 
 		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
 			par_io_of_config(np);
+#ifdef CONFIG_QE_USB
+		/* Must fixup Par IO before QE GPIO chips are registered. */
+		par_io_config_pin(1,  2, 1, 0, 3, 0); /* USBOE  */
+		par_io_config_pin(1,  3, 1, 0, 3, 0); /* USBTP  */
+		par_io_config_pin(1,  8, 1, 0, 1, 0); /* USBTN  */
+		par_io_config_pin(1, 10, 2, 0, 3, 0); /* USBRXD */
+		par_io_config_pin(1,  9, 2, 1, 3, 0); /* USBRP  */
+		par_io_config_pin(1, 11, 2, 1, 3, 0); /* USBRN  */
+		par_io_config_pin(2, 20, 2, 0, 1, 0); /* CLK21  */
+#endif /* CONFIG_QE_USB */
 	}
 
 	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
@@ -151,6 +162,70 @@ static int __init mpc836x_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc836x_mds, mpc836x_declare_of_platform_devices);
 
+#ifdef CONFIG_QE_USB
+static int __init mpc836x_usb_cfg(void)
+{
+	u8 __iomem *bcsr;
+	struct device_node *np;
+	const char *mode;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc8360mds-bcsr");
+	if (!np)
+		return -ENODEV;
+
+	bcsr = of_iomap(np, 0);
+	of_node_put(np);
+	if (!bcsr)
+		return -ENOMEM;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc8323-qe-usb");
+	if (!np) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+#define BCSR8_TSEC1M_MASK	(0x3 << 6)
+#define BCSR8_TSEC1M_RGMII	(0x0 << 6)
+#define BCSR8_TSEC2M_MASK	(0x3 << 4)
+#define BCSR8_TSEC2M_RGMII	(0x0 << 4)
+	/*
+	 * Default is GMII (2), but we should set it to RGMII (0) if we use
+	 * USB (Eth PHY is in RGMII mode anyway).
+	 */
+	clrsetbits_8(&bcsr[8], BCSR8_TSEC1M_MASK | BCSR8_TSEC2M_MASK,
+			       BCSR8_TSEC1M_RGMII | BCSR8_TSEC2M_RGMII);
+
+#define BCSR13_USBMASK	0x0f
+#define BCSR13_nUSBEN	0x08 /* 1 - Disable, 0 - Enable			*/
+#define BCSR13_USBSPEED	0x04 /* 1 - Full, 0 - Low			*/
+#define BCSR13_USBMODE	0x02 /* 1 - Host, 0 - Function			*/
+#define BCSR13_nUSBVCC	0x01 /* 1 - gets VBUS, 0 - supplies VBUS 	*/
+
+	clrsetbits_8(&bcsr[13], BCSR13_USBMASK, BCSR13_USBSPEED);
+
+	mode = of_get_property(np, "mode", NULL);
+	if (mode && !strcmp(mode, "peripheral")) {
+		setbits8(&bcsr[13], BCSR13_nUSBVCC);
+		qe_usb_clock_set(QE_CLK21, 48000000);
+	} else {
+		setbits8(&bcsr[13], BCSR13_USBMODE);
+		/*
+		 * The BCSR GPIOs are used to control power and
+		 * speed of the USB transceiver. This is needed for
+		 * the USB Host only.
+		 */
+		simple_gpiochip_init("fsl,mpc8360mds-bcsr-gpio");
+	}
+
+	of_node_put(np);
+err:
+	iounmap(bcsr);
+	return ret;
+}
+machine_arch_initcall(mpc836x_mds, mpc836x_usb_cfg);
+#endif /* CONFIG_QE_USB */
+
 static void __init mpc836x_mds_init_IRQ(void)
 {
 	struct device_node *np;
-- 
1.5.6.5
