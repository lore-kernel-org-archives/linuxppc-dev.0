Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 60625DE265
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 12:16:58 +1000 (EST)
Date: Sat, 2 May 2009 06:16:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 5/6] powerpc/85xx: Enable Serial RapidIO for MPC85xx MDS boards
Message-ID: <20090502021656.GE18281@oksana.dev.rtsoft.ru>
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Select HAS_RAPIDIO symbol and add rio nodes for MPC8568E-MDS
and MPC8569E-MDS boards.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |   17 +++++++++++++++++
 arch/powerpc/boot/dts/mpc8569mds.dts |   17 +++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig  |    1 +
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index fcab168..473fce6 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -26,6 +26,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		rapidio0 = &rio0;
 	};
 
 	cpus {
@@ -539,4 +540,20 @@
 				  0x0 0x800000>;
 		};
 	};
+
+	rio0: rapidio@e00c00000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "fsl,mpc8568-rapidio", "fsl,rapidio-delta";
+		reg = <0xe00c0000 0x20000>;
+		ranges = <0x0 0x0 0xc0000000 0x0 0x20000000>;
+		interrupts = <48 2 /* error     */
+			      49 2 /* bell_outb */
+			      50 2 /* bell_inb  */
+			      53 2 /* msg1_tx   */
+			      54 2 /* msg1_rx   */
+			      55 2 /* msg2_tx   */
+			      56 2 /* msg2_rx   */>;
+		interrupt-parent = <&mpic>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 14120d7..975f2c5 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -25,6 +25,7 @@
 		ethernet2 = &enet2;
 		ethernet3 = &enet3;
 		pci1 = &pci1;
+		rapidio0 = &rio0;
 	};
 
 	cpus {
@@ -528,4 +529,20 @@
 				  0x0 0x800000>;
 		};
 	};
+
+	rio0: rapidio@e00c00000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "fsl,mpc8569-rapidio", "fsl,rapidio-delta";
+		reg = <0xe00c0000 0x20000>;
+		ranges = <0x0 0x0 0xc0000000 0x0 0x20000000>;
+		interrupts = <48 2 /* error     */
+			      49 2 /* bell_outb */
+			      50 2 /* bell_inb  */
+			      53 2 /* msg1_tx   */
+			      54 2 /* msg1_rx   */
+			      55 2 /* msg2_tx   */
+			      56 2 /* msg2_rx   */>;
+		interrupt-parent = <&mpic>;
+	};
 };
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 7f066ad..43d385c 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -34,6 +34,7 @@ config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
 	select DEFAULT_UIMAGE
 	select PHYLIB
+	select HAS_RAPIDIO
 	help
 	  This option enables support for the MPC85xx MDS board
 
-- 
1.6.2.2
