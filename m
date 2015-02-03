Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401241A0C81
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 10:21:22 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH] powerpc/dts: Remove B4860 emulator support
Date: Tue, 3 Feb 2015 17:16:48 -0600
Message-ID: <1423005408-6103-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Emil Medve <Emilian.Medve@freescale.com>

Probably we should have not upstreamed this in the first place

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/boot/dts/b4860emu.dts | 223 -------------------------------------
 1 file changed, 223 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/b4860emu.dts

diff --git a/arch/powerpc/boot/dts/b4860emu.dts b/arch/powerpc/boot/dts/b4860emu.dts
deleted file mode 100644
index 2aa5cd3..0000000
--- a/arch/powerpc/boot/dts/b4860emu.dts
+++ /dev/null
@@ -1,223 +0,0 @@
-/*
- * B4860 emulator Device Tree Source
- *
- * Copyright 2013 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * This software is provided by Freescale Semiconductor "as is" and any
- * express or implied warranties, including, but not limited to, the implied
- * warranties of merchantability and fitness for a particular purpose are
- * disclaimed. In no event shall Freescale Semiconductor be liable for any
- * direct, indirect, incidental, special, exemplary, or consequential damages
- * (including, but not limited to, procurement of substitute goods or services;
- * loss of use, data, or profits; or business interruption) however caused and
- * on any theory of liability, whether in contract, strict liability, or tort
- * (including negligence or otherwise) arising in any way out of the use of
- * this software, even if advised of the possibility of such damage.
- */
-
-/dts-v1/;
-
-/include/ "fsl/e6500_power_isa.dtsi"
-
-/ {
-	compatible = "fsl,B4860";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	aliases {
-		ccsr = &soc;
-
-		serial0 = &serial0;
-		serial1 = &serial1;
-		serial2 = &serial2;
-		serial3 = &serial3;
-		dma0 = &dma0;
-		dma1 = &dma1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: PowerPC,e6500@0 {
-			device_type = "cpu";
-			reg = <0 1>;
-			next-level-cache = <&L2>;
-			fsl,portid-mapping = <0x80000000>;
-		};
-		cpu1: PowerPC,e6500@2 {
-			device_type = "cpu";
-			reg = <2 3>;
-			next-level-cache = <&L2>;
-			fsl,portid-mapping = <0x80000000>;
-		};
-		cpu2: PowerPC,e6500@4 {
-			device_type = "cpu";
-			reg = <4 5>;
-			next-level-cache = <&L2>;
-			fsl,portid-mapping = <0x80000000>;
-		};
-		cpu3: PowerPC,e6500@6 {
-			device_type = "cpu";
-			reg = <6 7>;
-			next-level-cache = <&L2>;
-			fsl,portid-mapping = <0x80000000>;
-		};
-	};
-};
-
-/ {
-	model = "fsl,B4860QDS";
-	compatible = "fsl,B4860EMU", "fsl,B4860QDS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	ifc: localbus@ffe124000 {
-		reg = <0xf 0xfe124000 0 0x2000>;
-		ranges = <0 0 0xf 0xe8000000 0x08000000
-			  2 0 0xf 0xff800000 0x00010000
-			  3 0 0xf 0xffdf0000 0x00008000>;
-
-		nor@0,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "cfi-flash";
-			reg = <0x0 0x0 0x8000000>;
-			bank-width = <2>;
-			device-width = <1>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-	};
-
-	soc: soc@ffe000000 {
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-	};
-};
-
-&ifc {
-	#address-cells = <2>;
-	#size-cells = <1>;
-	compatible = "fsl,ifc", "simple-bus";
-	interrupts = <25 2 0 0>;
-};
-
-&soc {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	device_type = "soc";
-	compatible = "simple-bus";
-
-	soc-sram-error {
-		compatible = "fsl,soc-sram-error";
-		interrupts = <16 2 1 2>;
-	};
-
-	corenet-law@0 {
-		compatible = "fsl,corenet-law";
-		reg = <0x0 0x1000>;
-		fsl,num-laws = <32>;
-	};
-
-	ddr1: memory-controller@8000 {
-		compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
-		reg = <0x8000 0x1000>;
-		interrupts = <16 2 1 8>;
-	};
-
-	ddr2: memory-controller@9000 {
-		compatible = "fsl,qoriq-memory-controller-v4.5","fsl,qoriq-memory-controller";
-		reg = <0x9000 0x1000>;
-		interrupts = <16 2 1 9>;
-	};
-
-	cpc: l3-cache-controller@10000 {
-		compatible = "fsl,b4-l3-cache-controller", "cache";
-		reg = <0x10000 0x1000
-		       0x11000 0x1000>;
-		interrupts = <16 2 1 4>;
-	};
-
-	corenet-cf@18000 {
-		compatible = "fsl,corenet2-cf", "fsl,corenet-cf";
-		reg = <0x18000 0x1000>;
-		interrupts = <16 2 1 0>;
-		fsl,ccf-num-csdids = <32>;
-		fsl,ccf-num-snoopids = <32>;
-	};
-
-	iommu@20000 {
-		compatible = "fsl,pamu-v1.0", "fsl,pamu";
-		reg = <0x20000 0x4000>;
-		fsl,portid-mapping = <0x8000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupts = <
-			24 2 0 0
-			16 2 1 1>;
-		pamu0: pamu@0 {
-			reg = <0 0x1000>;
-			fsl,primary-cache-geometry = <8 1>;
-			fsl,secondary-cache-geometry = <32 2>;
-		};
-	};
-
-/include/ "fsl/qoriq-mpic.dtsi"
-
-	guts: global-utilities@e0000 {
-		compatible = "fsl,b4-device-config";
-		reg = <0xe0000 0xe00>;
-		fsl,has-rstcr;
-		fsl,liodn-bits = <12>;
-	};
-
-/include/ "fsl/qoriq-clockgen2.dtsi"
-	global-utilities@e1000 {
-		compatible = "fsl,b4-clockgen", "fsl,qoriq-clockgen-2.0";
-	};
-
-/include/ "fsl/qoriq-dma-0.dtsi"
-	dma@100300 {
-		fsl,iommu-parent = <&pamu0>;
-		fsl,liodn-reg = <&guts 0x580>; /* DMA1LIODNR */
-	};
-
-/include/ "fsl/qoriq-dma-1.dtsi"
-	dma@101300 {
-		fsl,iommu-parent = <&pamu0>;
-		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
-	};
-
-/include/ "fsl/qoriq-i2c-0.dtsi"
-/include/ "fsl/qoriq-i2c-1.dtsi"
-/include/ "fsl/qoriq-duart-0.dtsi"
-/include/ "fsl/qoriq-duart-1.dtsi"
-
-	L2: l2-cache-controller@c20000 {
-		compatible = "fsl,b4-l2-cache-controller";
-		reg = <0xc20000 0x1000>;
-		next-level-cache = <&cpc>;
-	};
-};
-- 
2.2.2
