Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 115BEB7B6A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 05:01:05 +1100 (EST)
Date: Thu, 10 Dec 2009 21:01:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/83xx: Add power management support for
	MPC8315E-RDB boards
Message-ID: <20091210180103.GC32482@oksana.dev.rtsoft.ru>
References: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add nodes for PMC and GTM controllers. GTM4 can be used as a wakeup
  source;

- Add fsl,magic-packet properties to eTSEC nodes, i.e. wake-on-lan
  support. Unlike MPC8313 processors, MPC8315 can resume from deep
  sleep upon magic packet reception.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 32e10f5..8a3a4f3 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -204,6 +204,7 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = < &phy0 >;
+			fsl,magic-packet;
 
 			mdio@520 {
 				#address-cells = <1>;
@@ -246,6 +247,7 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = < &phy1 >;
+			fsl,magic-packet;
 
 			mdio@520 {
 				#address-cells = <1>;
@@ -309,6 +311,22 @@
 			interrupt-parent = <&ipic>;
 		};
 
+		gtm1: timer@500 {
+			compatible = "fsl,mpc8315-gtm", "fsl,gtm";
+			reg = <0x500 0x100>;
+			interrupts = <90 8 78 8 84 8 72 8>;
+			interrupt-parent = <&ipic>;
+			clock-frequency = <133333333>;
+		};
+
+		timer@600 {
+			compatible = "fsl,mpc8315-gtm", "fsl,gtm";
+			reg = <0x600 0x100>;
+			interrupts = <91 8 79 8 85 8 73 8>;
+			interrupt-parent = <&ipic>;
+			clock-frequency = <133333333>;
+		};
+
 		/* IPIC
 		 * interrupts cell = <intr #, sense>
 		 * sense values match linux IORESOURCE_IRQ_* defines:
@@ -337,6 +355,15 @@
 				      0x59 0x8>;
 			interrupt-parent = < &ipic >;
 		};
+
+		pmc: power@b00 {
+			compatible = "fsl,mpc8315-pmc", "fsl,mpc8313-pmc",
+				     "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 8>;
+			interrupt-parent = <&ipic>;
+			fsl,mpc8313-wakeup-timer = <&gtm1>;
+		};
 	};
 
 	pci0: pci@e0008500 {
-- 
1.6.3.3
