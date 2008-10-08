Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6D7DEDE3F8
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 05:16:11 +1100 (EST)
Date: Wed, 8 Oct 2008 22:16:05 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: add DS1374 RTC support for the MPC837xE-MDS
	boards
Message-ID: <20081008181605.GA15034@oksana.dev.rtsoft.ru>
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

The RTC is sitting on the I2C1 bus at address 0x68. RTC interrupt signal
is connected to the IPIC's EXT3 interrupt line.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts |    7 +++++++
 arch/powerpc/boot/dts/mpc8378_mds.dts |    7 +++++++
 arch/powerpc/boot/dts/mpc8379_mds.dts |    7 +++++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 432782b..6ec8b86 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -136,6 +136,13 @@
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <0x68>;
+				interrupts = <19 0x8>;
+				interrupt-parent = <&ipic>;
+			};
 		};
 
 		i2c@3100 {
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index ed32c8d..c87340d 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -136,6 +136,13 @@
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <0x68>;
+				interrupts = <19 0x8>;
+				interrupt-parent = <&ipic>;
+			};
 		};
 
 		i2c@3100 {
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index f4db9ed..22cd183 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -136,6 +136,13 @@
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <0x68>;
+				interrupts = <19 0x8>;
+				interrupt-parent = <&ipic>;
+			};
 		};
 
 		i2c@3100 {
-- 
1.5.6.3
