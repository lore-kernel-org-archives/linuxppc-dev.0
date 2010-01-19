Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5CAC8B8277
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 07:24:44 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/11] powerpc/mpc5121: update mpc5121ads DTS
Date: Tue, 19 Jan 2010 21:24:12 +0100
Message-Id: <1263932653-3634-11-git-send-email-agust@denx.de>
In-Reply-To: <1263932653-3634-1-git-send-email-agust@denx.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, wd@denx.de, dzu@denx.de,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Collects several changes needed after applying
previous mpc5121 platform and driver patches:

- Add mpc5121 reset module node
- Clean up and fix NAND description, remove unused properties
  here and correct NAND flash chip size.
- Add I2C RTC node for m41t80 RTC
- Fix compatible property in DMA node
- Remove unused cell-index properties from CAN nodes
- Fix compatible property in DIU node
- USB node changes:
    - remove 'port0/1' properties as these are only used
      for multi-port host(MHP) module which is not available
      on MPC5121.
    - MPC5121 Rev 2.0 EHCI registers are big endian.
      'big-endian-regs' property in USB node indicates
      this now.
    - use 'invert-drvvbus' and 'invert-pwr-fault' in
      USB node for internal PHY to specify polarities
      of appropriate port pins.

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Signed-off-by: Detlev Zundel <dzu@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/boot/dts/mpc5121ads.dts |   35 +++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index c353dac..22c107f 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -62,17 +62,12 @@
 		interrupt-parent = < &ipic >;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		bank-width = <1>;
 		// ADS has two Hynix 512MB Nand flash chips in a single
-		// stacked package .
+		// stacked package.
 		chips = <2>;
-		nand0@0 {
-			label = "nand0";
-			reg = <0x00000000 0x02000000>; 	// first 32 MB of chip 0
-		};
-		nand1@20000000 {
-			label = "nand1";
-			reg = <0x20000000 0x02000000>; 	// first 32 MB of chip 1
+		nand@0 {
+			label = "nand";
+			reg = <0x00000000 0x40000000>;	// 512MB + 512MB
 		};
 	};
 
@@ -166,6 +161,11 @@
 			interrupt-parent = < &ipic >;
 		};
 
+		reset@e00 {	// Reset module
+			compatible = "fsl,mpc5121-reset";
+			reg = <0xe00 0x100>;
+		};
+
 		clock@f00 {	// Clock control
 			compatible = "fsl,mpc5121-clock";
 			reg = <0xf00 0x100>;
@@ -187,7 +187,6 @@
 
 		mscan@1300 {
 			compatible = "fsl,mpc5121-mscan";
-			cell-index = <0>;
 			interrupts = <12 0x8>;
 			interrupt-parent = < &ipic >;
 			reg = <0x1300 0x80>;
@@ -195,7 +194,6 @@
 
 		mscan@1380 {
 			compatible = "fsl,mpc5121-mscan";
-			cell-index = <1>;
 			interrupts = <13 0x8>;
 			interrupt-parent = < &ipic >;
 			reg = <0x1380 0x80>;
@@ -219,6 +217,11 @@
 			reg = <0x1720 0x20>;
 			interrupts = <10 0x8>;
 			interrupt-parent = < &ipic >;
+
+			rtc@68 {
+				compatible = "stm,m41t80";
+				reg = <0x68>;
+			};
 		};
 
 		i2c@1740 {
@@ -244,7 +247,7 @@
 		};
 
 		display@2100 {
-			compatible = "fsl,mpc5121-diu", "fsl-diu";
+			compatible = "fsl,mpc5121-diu", "fsl,diu";
 			reg = <0x2100 0x100>;
 			interrupts = <64 0x8>;
 			interrupt-parent = < &ipic >;
@@ -285,7 +288,7 @@
 		//	interrupts = <43 0x8>;
 		//	dr_mode = "otg";
 		//	phy_type = "ulpi";
-		//	port1;
+		//	big-endian-regs;
 		//};
 
 		// USB0 using internal UTMI PHY
@@ -298,7 +301,9 @@
 			interrupts = <44 0x8>;
 			dr_mode = "otg";
 			phy_type = "utmi_wide";
-			port0;
+			big-endian-regs;
+			invert-drvvbus;
+			invert-pwr-fault;
 		};
 
 		// IO control
@@ -365,7 +370,7 @@
 		};
 
 		dma@14000 {
-			compatible = "fsl,mpc5121-dma2";
+			compatible = "fsl,mpc5121-dma";
 			reg = <0x14000 0x1800>;
 			interrupts = <65 0x8>;
 			interrupt-parent = < &ipic >;
-- 
1.5.6.3
