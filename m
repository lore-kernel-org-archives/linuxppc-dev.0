Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id F0BB7DE1B8
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 05:05:18 +1100 (EST)
Date: Fri, 10 Oct 2008 22:05:12 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: add NAND support for the MPC8360E-RDK boards
Message-ID: <20081010180512.GA3554@oksana.dev.rtsoft.ru>
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

The StMicro NAND chip (512Mbit, 64MB) is connected to the local bus,
the first local bus' user-programmable machine is configured by the
firmware to work with NAND chips.

QE GPIO pin is used to poll the NAND's Ready-Not-Busy signal.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc836x_rdk.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index b4f3a17..10237dc 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -398,6 +398,18 @@
 			device-width = <1>;
 		};
 
+		upm@1,0 {
+			compatible = "fsl,upm-nand";
+			reg = <1 0 1>;
+			fsl,upm-addr-offset = <16>;
+			fsl,upm-cmd-offset = <8>;
+			gpios = <&qe_pio_e 18 0>;
+
+			flash {
+				compatible = "stm,nand512-a";
+			};
+		};
+
 		display@2,0 {
 			device_type = "display";
 			compatible = "fujitsu,MB86277", "fujitsu,mint";
-- 
1.5.6.3
