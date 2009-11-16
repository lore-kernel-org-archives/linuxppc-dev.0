Return-Path: <dbaryshkov@gmail.com>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 6EE461007F9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 00:59:06 +1100 (EST)
Received: by ywh37 with SMTP id 37so5344740ywh.17
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 05:59:04 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/4] mpc8349emitx: populate I2C busses
Date: Mon, 16 Nov 2009 16:58:52 +0300
Message-Id: <1258379934-32352-3-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
References: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add OF descriptions of EEPROM, two GPIO extenders and SPD hanging on I2C
on this board.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 16872c9..0fb78b2 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -90,6 +90,12 @@
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
+
+			eeprom: at24@50 {
+				compatible = "st-micro,24c256";
+				reg = <0x50>;
+			};
+
 		};
 
 		i2c@3100 {
@@ -109,6 +115,25 @@
 				interrupt-parent = <&ipic>;
 			};
 
+			pcf1: iexp@38 {
+				#gpio-cells = <2>;
+				compatible = "ti,pcf8574a";
+				reg = <0x38>;
+				gpio-controller;
+			};
+
+			pcf2: iexp@39 {
+				#gpio-cells = <2>;
+				compatible = "ti,pcf8574a";
+				reg = <0x39>;
+				gpio-controller;
+			};
+
+			spd: at24@51 {
+				compatible = "at24,spd";
+				reg = <0x51>;
+			};
+
 			mcu_pio: mcu@a {
 				#gpio-cells = <2>;
 				compatible = "fsl,mc9s08qg8-mpc8349emitx",
-- 
1.6.5
