Return-Path: <gustavo@zacarias.com.ar>
Received: from loknar.toptech.com.ar (loknar.toptech.com.ar [74.118.36.95])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.toptech.com.ar", Issuer "mail.toptech.com.ar" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2515B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2012 00:40:58 +1000 (EST)
From: Gustavo Zacarias <gustavo@zacarias.com.ar>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/p1010rdb: add EEPROMs to device tree
Date: Wed, 23 May 2012 11:35:18 -0300
Message-Id: <1337783718-25553-1-git-send-email-gustavo@zacarias.com.ar>
Cc: Gustavo Zacarias <gustavo@zacarias.com.ar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add EEPROM to the P1010RDB device tree.
The 24c01 acts as a memory SPD so it shouldn't be overwritten without
care.
The 24c256 is a general purpose memory.

Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
---
 arch/powerpc/boot/dts/p1010rdb.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index 4977614..ec7c27a 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -126,12 +126,24 @@
 
 &board_soc {
 	i2c@3000 {
+		eeprom@50 {
+			compatible = "st,24c256";
+			reg = <0x50>;
+		};
+
 		rtc@68 {
 			compatible = "pericom,pt7c4338";
 			reg = <0x68>;
 		};
 	};
 
+	i2c@3100 {
+		eeprom@52 {
+			compatible = "atmel,24c01";
+			reg = <0x52>;
+		};
+	};
+
 	spi@7000 {
 		flash@0 {
 			#address-cells = <1>;
-- 
1.7.3.4
