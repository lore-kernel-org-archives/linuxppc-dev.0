Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F380367D7A
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 04:39:17 +1100 (EST)
Date: Thu, 7 Dec 2006 11:34:57 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] powerpc: Add the ds1374 RTC to the mpc8349emds device
	tree.
Message-ID: <20061207173457.GE22989@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8349emds.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/boot/dts/mpc8349emds.dts
index 50f4886..889a5b8 100644
--- a/arch/powerpc/boot/dts/mpc8349emds.dts
+++ b/arch/powerpc/boot/dts/mpc8349emds.dts
@@ -55,12 +55,22 @@
 		};
 
 		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
 			interrupt-parent = <700>;
 			dfsrr;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "ds1374";
+				reg = <68>;
+				interrupts = <13 8>;
+				interrupt-parent = <700>;
+			};
 		};
 
 		i2c@3100 {
-- 
1.4.2.3
