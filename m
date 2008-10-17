Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 242A3DDED3
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 05:57:07 +1100 (EST)
Date: Fri, 17 Oct 2008 22:56:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/83xx: add DS1339 RTC support for MPC8349E-mITX
	boards
Message-ID: <20081017185659.GA30008@oksana.dev.rtsoft.ru>
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

The RTC is sitting on the I2C2 bus at address 0x68. RTC interrupt signal
is connected to the IPIC's EXT2 interrupt line, the line is shared with
Vitesse 8201 Ethernet PHY.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    8 ++++++++
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    8 ++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 5cedf37..7fc5414 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -83,6 +83,14 @@
 			interrupts = <15 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+				interrupts = <18 0x8>;
+				interrupt-parent = <&ipic>;
+			};
 		};
 
 		spi@7000 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 81ae1d3..fa40647 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -81,6 +81,14 @@
 			interrupts = <15 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+				interrupts = <18 0x8>;
+				interrupt-parent = <&ipic>;
+			};
 		};
 
 		spi@7000 {
-- 
1.5.6.3
