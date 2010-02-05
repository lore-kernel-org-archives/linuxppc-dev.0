Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id CB347B7D2F
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 08:06:27 +1100 (EST)
Date: Sat, 6 Feb 2010 00:06:26 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Add NOR, LEDs and PIB support for
	MPC8568E-MDS boards
Message-ID: <20100205210626.GA9882@oksana.dev.rtsoft.ru>
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

This patch adds NOR Flash, LEDs and PIB support for MPC8568E-MDS
boards. Plus, move bcsr node into localbus node, and add bcsr5
gpio-controller node.

Some platform code modifications were also needed.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts      |   65 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    3 +
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 6d892ba..92fb178 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -54,9 +54,52 @@
 		reg = <0x0 0x10000000>;
 	};
 
-	bcsr@f8000000 {
-		compatible = "fsl,mpc8568mds-bcsr";
-		reg = <0xf8000000 0x8000>;
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8568-localbus", "fsl,pq3-localbus",
+			     "simple-bus";
+		reg = <0xe0005000 0x1000>;
+
+		ranges = <0x0 0x0 0xfe000000 0x02000000
+			  0x1 0x0 0xf8000000 0x00008000
+			  0x2 0x0 0xf0000000 0x04000000
+			  0x4 0x0 0xf8008000 0x00008000
+			  0x5 0x0 0xf8010000 0x00008000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x02000000>;
+			bank-width = <2>;
+			device-width = <2>;
+		};
+
+		bcsr@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8568mds-bcsr";
+			reg = <1 0 0x8000>;
+			ranges = <0 1 0 0x8000>;
+
+			bcsr5: gpio-controller@11 {
+				#gpio-cells = <2>;
+				compatible = "fsl,mpc8568mds-bcsr-gpio";
+				reg = <0x5 0x1>;
+				gpio-controller;
+			};
+		};
+
+		pib@4,0 {
+			compatible = "fsl,mpc8568mds-pib";
+			reg = <4 0 0x8000>;
+		};
+
+		pib@5,0 {
+			compatible = "fsl,mpc8568mds-pib";
+			reg = <5 0 0x8000>;
+		};
 	};
 
 	soc8568@e0000000 {
@@ -610,4 +653,20 @@
 		sleep = <&pmc 0x00080000   /* controller */
 			 &pmc 0x00040000>; /* message unit */
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		green {
+			gpios = <&bcsr5 1 0>;
+		};
+
+		amber {
+			gpios = <&bcsr5 2 0>;
+		};
+
+		red {
+			gpios = <&bcsr5 3 0>;
+		};
+	};
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 21f61b8..04af81e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -302,11 +302,14 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,rapidio-delta", },
 	{ .compatible = "fsl,mpc8548-guts", },
+	{ .compatible = "gpio-leds", },
 	{},
 };
 
 static int __init mpc85xx_publish_devices(void)
 {
+	if (machine_is(mpc8568_mds))
+		simple_gpiochip_init("fsl,mpc8568mds-bcsr-gpio");
 	if (machine_is(mpc8569_mds))
 		simple_gpiochip_init("fsl,mpc8569mds-bcsr-gpio");
 
-- 
1.6.5.7
