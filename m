Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4828EDDF2D
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 03:37:25 +1100 (EST)
Date: Thu, 18 Dec 2008 19:37:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: Add device tree bindings for BCSR GPIO banks
Message-ID: <20081218163723.GA2064@oksana.dev.rtsoft.ru>
References: <20081218163640.GA21049@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081218163640.GA21049@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch adds bindings for BCSR GPIO banks, the bindings are used to
describe particular BCSR registers that act as simple GPIO controllers.
These GPIO banks might control power switches, SPI chip-selects, LEDs,
etc.

While at it, also fix "length" spelling error in the PIXIS FPGA
bindings.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/dts-bindings/fsl/board.txt |   32 +++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/board.txt b/Documentation/powerpc/dts-bindings/fsl/board.txt
index 81a917e..6c974d2 100644
--- a/Documentation/powerpc/dts-bindings/fsl/board.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/board.txt
@@ -18,7 +18,7 @@ This is the memory-mapped registers for on board FPGA.
 
 Required properities:
 - compatible : should be "fsl,fpga-pixis".
-- reg : should contain the address and the lenght of the FPPGA register
+- reg : should contain the address and the length of the FPPGA register
   set.
 
 Example (MPC8610HPCD):
@@ -27,3 +27,33 @@ Example (MPC8610HPCD):
 		compatible = "fsl,fpga-pixis";
 		reg = <0xe8000000 32>;
 	};
+
+* Freescale BCSR GPIO banks
+
+Some BCSR registers act as simple GPIO controllers, each such
+register can be represented by the gpio-controller node.
+
+Required properities:
+- compatible : Should be "fsl,<board>-bcsr-gpio".
+- reg : Should contain the address and the length of the GPIO bank
+  register.
+- #gpio-cells : Should be two. The first cell is the pin number and the
+  second cell is used to specify optional paramters (currently unused).
+- gpio-controller : Marks the port as GPIO controller.
+
+Example:
+
+	bcsr@1,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8360mds-bcsr";
+		reg = <1 0 0x8000>;
+		ranges = <0 1 0 0x8000>;
+
+		bcsr13: gpio-controller@d {
+			#gpio-cells = <2>;
+			compatible = "fsl,mpc8360mds-bcsr-gpio";
+			reg = <0xd 1>;
+			gpio-controller;
+		};
+	};
-- 
1.5.6.5
