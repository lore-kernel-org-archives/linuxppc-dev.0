Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 56108475DF
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 00:48:35 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
Date: Thu, 4 Sep 2008 16:41:57 +0200
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<20080904122507.GB12867@yoda.jdub.homelinux.org>
	<200809041628.29460.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200809041628.29460.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809041641.57614.matthias.fuchs@esd-electronics.com>
Cc: sr@denx.de
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
---
 arch/powerpc/boot/dts/sequoia.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 72d15f0..9ba5def 100644
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
+					compatible = "analog,ad7414";
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
