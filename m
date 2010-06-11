Return-Path: <dbaryshkov@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 9F6C01007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 21:52:38 +1000 (EST)
Received: by bwz8 with SMTP id 8so338650bwz.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 04:52:36 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] lite5200: add dts descriptions for onboard I2C eeprom and
	flash
Date: Fri, 11 Jun 2010 15:52:34 +0400
Message-Id: <1276257155-7297-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add dts descriptions for onboard 256 byte I2C eeprom (pcf8582C-2)
and 16MB NOR flash (am29lv652d).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/boot/dts/lite5200.dts |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 2b64d8e..da1dafb 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -255,6 +255,12 @@
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
+
+			eeprom@50 {
+				compatible = "nxp,pcf8582c", "at24,24c02";
+				reg = <0x50>;
+			};
+
 		};
 		sram@8000 {
 			compatible = "fsl,mpc5200-sram";
@@ -281,4 +287,22 @@
 			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
 			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
 	};
+
+	localbus {
+		compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
+
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		ranges = <0 0 0xff000000 0x00000000>;
+
+		flash@0,00000000 {
+			compatible = "amd,am29lv652d", "cfi-flash";
+			reg = <0 0x00000000 0x01000000>;
+			bank-width = <1>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+		};
+	};
+
 };
-- 
1.7.1
