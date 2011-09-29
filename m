Return-Path: <mylinux@10.ap.freescale.net>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F8FDB6F94
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Sep 2011 12:30:15 +1000 (EST)
From: Liu Gang <Gang.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4] p4080ds-dts: Add two rapidio ports and message units
	support
Date: Thu, 29 Sep 2011 10:29:00 +0800
Message-ID: <1317263341-19010-3-git-send-email-Gang.Liu@freescale.com>
In-Reply-To: <1317263341-19010-1-git-send-email-Gang.Liu@freescale.com>
References: <1317263341-19010-1-git-send-email-Gang.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jin Qing <b24347@freescale.com>, r58472@freescale.com, r61911@freescale.com,
	linux-kernel@vger.kernel.org, Liu Gang <Gang.Liu@freescale.com>,
	akpm@linux-foundation.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add two message units and number of ports according to the p4080 reference manual.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
---
 arch/powerpc/boot/dts/p4080ds.dts  |    4 +-
 arch/powerpc/boot/dts/p4080si.dtsi |   37 +++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index eb11098..94a0cd4 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -101,9 +101,9 @@
 		};
 	};
 
-	rapidio0: rapidio@ffe0c0000 {
+	rapidio: rapidio@ffe0c0000 {
 		reg = <0xf 0xfe0c0000 0 0x20000>;
-		ranges = <0 0 0xc 0x20000000 0 0x01000000>;
+		ranges = <0 0 0xc 0x20000000 0 0x20000000>;
 	};
 
 	localbus@ffe124000 {
diff --git a/arch/powerpc/boot/dts/p4080si.dtsi b/arch/powerpc/boot/dts/p4080si.dtsi
index b71051f..816a629 100644
--- a/arch/powerpc/boot/dts/p4080si.dtsi
+++ b/arch/powerpc/boot/dts/p4080si.dtsi
@@ -69,8 +69,9 @@
 		rtic_c = &rtic_c;
 		rtic_d = &rtic_d;
 		sec_mon = &sec_mon;
+		rmu = &rmu;
 
-		rio0 = &rapidio0;
+		rio = &rapidio;
 	};
 
 	cpus {
@@ -555,20 +556,38 @@
 			interrupt-parent = <&mpic>;
 			interrupts = <93 2 0 0>;
 		};
+
+		rmu: rmu@d3000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,rmu";
+			reg = <0xd3000 0x200>;
+
+			message-unit@0 {
+				reg = <0x0 0x100>;
+				interrupts = <
+						60 2 0 0  /* msg1_tx_irq */
+						61 2 0 0>;/* msg1_rx_irq */
+			};
+			message-unit@1 {
+				reg = <0x100 0x100>;
+				interrupts = <
+						62 2 0 0  /* msg2_tx_irq */
+						63 2 0 0>;/* msg2_rx_irq */
+			};
+		};
 	};
 
-	rapidio0: rapidio@ffe0c0000 {
+	rapidio: rapidio@ffe0c0000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "fsl,rapidio-delta";
 		interrupts = <
-			16 2 1 11 /* err_irq */
-			56 2 0 0  /* bell_outb_irq */
-			57 2 0 0  /* bell_inb_irq */
-			60 2 0 0  /* msg1_tx_irq */
-			61 2 0 0  /* msg1_rx_irq */
-			62 2 0 0  /* msg2_tx_irq */
-			63 2 0 0>; /* msg2_rx_irq */
+				16 2 1 11 /* err_irq */
+				56 2 0 0  /* bell_outb_irq */
+				57 2 0 0>;/* bell_inb_irq */
+		fsl,rio-num-ports = <2>;
+		rmu-handle = <&rmu>;
 	};
 
 	localbus@ffe124000 {
-- 
1.7.3.1
