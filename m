Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0FF56DDED9
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 05:57:11 +1100 (EST)
Date: Fri, 17 Oct 2008 22:57:09 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/83xx: add support for MCU on 8349emitx,
	837xrdb and 8315erdb boards
Message-ID: <20081017185709.GB30008@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MCU is an external Freescale MC9S08QG8 microcontroller, mainly used to
provide soft power-off function, but also exports two GPIOs (wired to
the LEDs and also available from the external headers).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts  |    8 ++++++++
 arch/powerpc/boot/dts/mpc8349emitx.dts |    8 ++++++++
 arch/powerpc/boot/dts/mpc8377_rdb.dts  |    8 ++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts  |    8 ++++++++
 arch/powerpc/boot/dts/mpc8379_rdb.dts  |    8 ++++++++
 5 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 7449e54..6b85067 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -121,6 +121,14 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+
+			mcu_pio: mcu@a {
+				#gpio-cells = <2>;
+				compatible = "fsl,mc9s08qg8-mpc8315erdb",
+					     "fsl,mcu-mpc8349emitx";
+				reg = <0x0a>;
+				gpio-controller;
+			};
 		};
 
 		spi@7000 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 7fc5414..4bdbaf4 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -91,6 +91,14 @@
 				interrupts = <18 0x8>;
 				interrupt-parent = <&ipic>;
 			};
+
+			mcu_pio: mcu@a {
+				#gpio-cells = <2>;
+				compatible = "fsl,mc9s08qg8-mpc8349emitx",
+					     "fsl,mcu-mpc8349emitx";
+				reg = <0x0a>;
+				gpio-controller;
+			};
 		};
 
 		spi@7000 {
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 53191ba..435ef3d 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -121,6 +121,14 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+
+			mcu_pio: mcu@a {
+				#gpio-cells = <2>;
+				compatible = "fsl,mc9s08qg8-mpc8377erdb",
+					     "fsl,mcu-mpc8349emitx";
+				reg = <0x0a>;
+				gpio-controller;
+			};
 		};
 
 		i2c@3100 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 4a09153..b11e68f 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -121,6 +121,14 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+
+			mcu_pio: mcu@a {
+				#gpio-cells = <2>;
+				compatible = "fsl,mc9s08qg8-mpc8378erdb",
+					     "fsl,mcu-mpc8349emitx";
+				reg = <0x0a>;
+				gpio-controller;
+			};
 		};
 
 		i2c@3100 {
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index bbd884a..337af6e 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -121,6 +121,14 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+
+			mcu_pio: mcu@a {
+				#gpio-cells = <2>;
+				compatible = "fsl,mc9s08qg8-mpc8379erdb",
+					     "fsl,mcu-mpc8349emitx";
+				reg = <0x0a>;
+				gpio-controller;
+			};
 		};
 
 		i2c@3100 {
-- 
1.5.6.3
