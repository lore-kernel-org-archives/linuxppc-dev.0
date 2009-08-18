Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8B027B7DE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 09:28:23 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id BCB4ADDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 09:28:22 +1000 (EST)
Date: Wed, 19 Aug 2009 03:28:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/85xx: Add QE USB support for MPC8569E-MDS boards
Message-ID: <20090818232821.GC27907@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add gpio-controller node for BCSR17, it is used to control USB
  speed and VBUS;
- Add timer node for QE GTM, needed for USB host;
- Add usb node itself;
- Add some probing code for BCSR GPIOs.

NOTE: QE USB doesn't work on prototype boards, but should work on
      pilot boards if specs and schematics are correct, though we
      don't have the pilot boards to actually test it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8569mds.dts      |   45 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    4 ++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index a680165..880f896 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -99,8 +99,18 @@
 		};
 
 		bcsr@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "fsl,mpc8569mds-bcsr";
 			reg = <1 0 0x8000>;
+			ranges = <0 1 0 0x8000>;
+
+			bcsr17: gpio-controller@11 {
+				#gpio-cells = <2>;
+				compatible = "fsl,mpc8569mds-bcsr-gpio";
+				reg = <0x11 0x1>;
+				gpio-controller;
+			};
 		};
 
 		nand@3,0 {
@@ -315,6 +325,14 @@
 				gpio-controller;
 			};
 
+			qe_pio_f: gpio-controller@a0 {
+				#gpio-cells = <2>;
+				compatible = "fsl,mpc8569-qe-pario-bank",
+					     "fsl,mpc8323-qe-pario-bank";
+				reg = <0xa0 0x18>;
+				gpio-controller;
+			};
+
 			pio1: ucc_pin@01 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
@@ -419,6 +437,16 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		timer@440 {
+			compatible = "fsl,mpc8569-qe-gtm",
+				     "fsl,qe-gtm", "fsl,gtm";
+			reg = <0x440 0x40>;
+			interrupts = <12 13 14 15>;
+			interrupt-parent = <&qeic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
+		};
+
 		spi@4c0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -446,6 +474,23 @@
 			mode = "cpu";
 		};
 
+		usb@6c0 {
+			compatible = "fsl,mpc8569-qe-usb",
+				     "fsl,mpc8323-qe-usb";
+			reg = <0x6c0 0x40 0x8b00 0x100>;
+			interrupts = <11>;
+			interrupt-parent = <&qeic>;
+			fsl,fullspeed-clock = "clk5";
+			fsl,lowspeed-clock = "brg10";
+			gpios = <&qe_pio_f 3 0   /* USBOE */
+				 &qe_pio_f 4 0   /* USBTP */
+				 &qe_pio_f 5 0   /* USBTN */
+				 &qe_pio_f 6 0   /* USBRP */
+				 &qe_pio_f 8 0   /* USBRN */
+				 &bcsr17   6 0   /* SPEED */
+				 &bcsr17   5 1>; /* POWER */
+		};
+
 		enet0: ucc@2000 {
 			device_type = "network";
 			compatible = "ucc_geth";
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 60ed9c0..173d459 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -47,6 +47,7 @@
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include <sysdev/simple_gpio.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>
@@ -291,6 +292,9 @@ static struct of_device_id mpc85xx_ids[] = {
 
 static int __init mpc85xx_publish_devices(void)
 {
+	if (machine_is(mpc8569_mds))
+		simple_gpiochip_init("fsl,mpc8569mds-bcsr-gpio");
+
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
 
-- 
1.6.3.3
