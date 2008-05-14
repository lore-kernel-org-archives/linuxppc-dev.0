Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A2D7DDF22
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:30:04 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] CS4270 node is misplaced in the MPC8610 device tree
Date: Wed, 14 May 2008 17:29:53 -0500
Message-Id: <1210804193-8908-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The CS4270 is using the second I2C bus, not the first, on the Freescale
MPC8610 HPCD, so its node in the device tree belongs under 'i2c@3100'
and not 'i2c@3000'.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Kumar, this is a must-fix for 2.6.26.  

The reason this didn't show up before is because the CS4270 driver
is an old-style driver, and so it doesn't actually use the device tree
to determine the I2C bus/address.

 arch/powerpc/boot/dts/mpc8610_hpcd.dts |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 08a780d..771f169 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -124,13 +124,6 @@
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
-
-			cs4270:codec@4f {
-				compatible = "cirrus,cs4270";
-				reg = <0x4f>;
-				/* MCLK source is a stand-alone oscillator */
-				clock-frequency = <12288000>;
-			};
 		};
 
 		i2c@3100 {
@@ -142,6 +135,13 @@
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
+
+			cs4270:codec@4f {
+				compatible = "cirrus,cs4270";
+				reg = <0x4f>;
+				/* MCLK source is a stand-alone oscillator */
+				clock-frequency = <12288000>;
+			};
 		};
 
 		serial0: serial@4500 {
-- 
1.5.5
