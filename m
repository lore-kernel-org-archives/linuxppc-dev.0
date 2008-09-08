Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 1847BDDE03
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Sep 2008 18:00:21 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2] powerpc/44x: Add hwmon support to Sequoia device tree
Date: Mon, 8 Sep 2008 09:57:21 +0200
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<20080905201703.0586e131@lappy.seanm.ca>
	<20080906120747.GA21519@vader.jdub.homelinux.org>
In-Reply-To: <20080906120747.GA21519@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809080957.21716.matthias.fuchs@esd-electronics.com>
Cc: Stefan Roese <sr@denx.de>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the AD7414 temperature sensor
on Sequoia PPC440EPx board.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Acked-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/sequoia.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 72d15f0..3b295e8 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -246,13 +246,22 @@
 	   		};
 
 			IIC0: i2c@ef600700 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				compatible = "ibm,iic-440epx", "ibm,iic";
 				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <0x2 0x4>;
+
+				hwmon@48 {
+					compatible = "adi,ad7414";
+					reg = <0x48>;
+				};
 			};
 
 			IIC1: i2c@ef600800 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				compatible = "ibm,iic-440epx", "ibm,iic";
 				reg = <0xef600800 0x00000014>;
 				interrupt-parent = <&UIC0>;
-- 
1.5.3
