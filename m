Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E2CB2C0079
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2012 08:08:06 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Revert "powerpc/p3060qds: Add support for P3060QDS board"
Date: Thu, 5 Jul 2012 17:07:53 -0500
Message-ID: <1341526073-10595-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 96cc017c5b7ec095ef047d3c1952b6b6bbf98943.

The P3060 was cancelled before it went into production, so there's no point
in supporting it.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p3060si-post.dtsi  |  302 --------------------------
 arch/powerpc/boot/dts/fsl/p3060si-pre.dtsi   |  125 -----------
 arch/powerpc/boot/dts/p3060qds.dts           |  242 ---------------------
 arch/powerpc/configs/corenet32_smp_defconfig |    1 -
 arch/powerpc/platforms/85xx/Kconfig          |   12 -
 arch/powerpc/platforms/85xx/Makefile         |    1 -
 arch/powerpc/platforms/85xx/p3060_qds.c      |   77 -------
 7 files changed, 0 insertions(+), 760 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/fsl/p3060si-post.dtsi
 delete mode 100644 arch/powerpc/boot/dts/fsl/p3060si-pre.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p3060qds.dts
 delete mode 100644 arch/powerpc/platforms/85xx/p3060_qds.c

diff --git a/arch/powerpc/boot/dts/fsl/p3060si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3060si-post.dtsi
deleted file mode 100644
index b3e5692..0000000
--- a/arch/powerpc/boot/dts/fsl/p3060si-post.dtsi
+++ /dev/null
@@ -1,302 +0,0 @@
-/*
- * P3060 Silicon/SoC Device Tree Source (post include)
- *
- * Copyright 2011 Freescale Semiconductor Inc.
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
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-&lbc {
-	compatible = "fsl,p3060-elbc", "fsl,elbc", "simple-bus";
-	interrupts = <25 2 0 0>;
-	#address-cells = <2>;
-	#size-cells = <1>;
-};
-
-/* controller at 0x200000 */
-&pci0 {
-	compatible = "fsl,p3060-pcie", "fsl,qoriq-pcie-v2.2";
-	device_type = "pci";
-	#size-cells = <2>;
-	#address-cells = <3>;
-	bus-range = <0x0 0xff>;
-	clock-frequency = <33333333>;
-	interrupts = <16 2 1 15>;
-	pcie@0 {
-		reg = <0 0 0 0 0>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		device_type = "pci";
-		interrupts = <16 2 1 15>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 40 1 0 0
-			0000 0 0 2 &mpic 1 1 0 0
-			0000 0 0 3 &mpic 2 1 0 0
-			0000 0 0 4 &mpic 3 1 0 0
-			>;
-	};
-};
-
-/* controller at 0x201000 */
-&pci1 {
-	compatible = "fsl,p3060-pcie", "fsl,qoriq-pcie-v2.2";
-	device_type = "pci";
-	#size-cells = <2>;
-	#address-cells = <3>;
-	bus-range = <0 0xff>;
-	clock-frequency = <33333333>;
-	interrupts = <16 2 1 14>;
-	pcie@0 {
-		reg = <0 0 0 0 0>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		device_type = "pci";
-		interrupts = <16 2 1 14>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 41 1 0 0
-			0000 0 0 2 &mpic 5 1 0 0
-			0000 0 0 3 &mpic 6 1 0 0
-			0000 0 0 4 &mpic 7 1 0 0
-			>;
-	};
-};
-
-&rio {
-	compatible = "fsl,srio";
-	interrupts = <16 2 1 11>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-	fsl,srio-rmu-handle = <&rmu>;
-	ranges;
-
-	port1 {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		cell-index = <1>;
-	};
-
-	port2 {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		cell-index = <2>;
-	};
-};
-
-&dcsr {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	compatible = "fsl,dcsr", "simple-bus";
-
-	dcsr-epu@0 {
-		compatible = "fsl,dcsr-epu";
-		interrupts = <52 2 0 0
-			      84 2 0 0
-			      85 2 0 0>;
-		reg = <0x0 0x1000>;
-	};
-	dcsr-npc {
-		compatible = "fsl,dcsr-npc";
-		reg = <0x1000 0x1000 0x1000000 0x8000>;
-	};
-	dcsr-nxc@2000 {
-		compatible = "fsl,dcsr-nxc";
-		reg = <0x2000 0x1000>;
-	};
-	dcsr-corenet {
-		compatible = "fsl,dcsr-corenet";
-		reg = <0x8000 0x1000 0xB0000 0x1000>;
-	};
-	dcsr-dpaa@9000 {
-		compatible = "fsl,p3060-dcsr-dpaa", "fsl,dcsr-dpaa";
-		reg = <0x9000 0x1000>;
-	};
-	dcsr-ocn@11000 {
-		compatible = "fsl,p3060-dcsr-ocn", "fsl,dcsr-ocn";
-		reg = <0x11000 0x1000>;
-	};
-	dcsr-ddr@12000 {
-		compatible = "fsl,dcsr-ddr";
-		dev-handle = <&ddr1>;
-		reg = <0x12000 0x1000>;
-	};
-	dcsr-nal@18000 {
-		compatible = "fsl,p3060-dcsr-nal", "fsl,dcsr-nal";
-		reg = <0x18000 0x1000>;
-	};
-	dcsr-rcpm@22000 {
-		compatible = "fsl,p3060-dcsr-rcpm", "fsl,dcsr-rcpm";
-		reg = <0x22000 0x1000>;
-	};
-	dcsr-cpu-sb-proxy@40000 {
-		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-		cpu-handle = <&cpu0>;
-		reg = <0x40000 0x1000>;
-	};
-	dcsr-cpu-sb-proxy@41000 {
-		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-		cpu-handle = <&cpu1>;
-		reg = <0x41000 0x1000>;
-	};
-	dcsr-cpu-sb-proxy@44000 {
-		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-		cpu-handle = <&cpu4>;
-		reg = <0x44000 0x1000>;
-	};
-	dcsr-cpu-sb-proxy@45000 {
-		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-		cpu-handle = <&cpu5>;
-		reg = <0x45000 0x1000>;
-	};
-	dcsr-cpu-sb-proxy@46000 {
-		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-		cpu-handle = <&cpu6>;
-		reg = <0x46000 0x1000>;
-	};
-	dcsr-cpu-sb-proxy@47000 {
-		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-		cpu-handle = <&cpu7>;
-		reg = <0x47000 0x1000>;
-	};
-
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
-		interrupts = <16 2 1 29>;
-	};
-
-	corenet-law@0 {
-		compatible = "fsl,corenet-law";
-		reg = <0x0 0x1000>;
-		fsl,num-laws = <32>;
-	};
-
-	ddr1: memory-controller@8000 {
-		compatible = "fsl,qoriq-memory-controller-v4.4", "fsl,qoriq-memory-controller";
-		reg = <0x8000 0x1000>;
-		interrupts = <16 2 1 23>;
-	};
-
-	cpc: l3-cache-controller@10000 {
-		compatible = "fsl,p3060-l3-cache-controller", "cache";
-		reg = <0x10000 0x1000
-		       0x11000 0x1000>;
-		interrupts = <16 2 1 27
-			      16 2 1 26>;
-	};
-
-	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
-		reg = <0x18000 0x1000>;
-		interrupts = <16 2 1 31>;
-		fsl,ccf-num-csdids = <32>;
-		fsl,ccf-num-snoopids = <32>;
-	};
-
-	iommu@20000 {
-		compatible = "fsl,pamu-v1.0", "fsl,pamu";
-		reg = <0x20000 0x5000>;
-		interrupts = <
-			24 2 0 0
-			16 2 1 30>;
-	};
-
-/include/ "qoriq-rmu-0.dtsi"
-/include/ "qoriq-mpic.dtsi"
-
-	guts: global-utilities@e0000 {
-		compatible = "fsl,qoriq-device-config-1.0";
-		reg = <0xe0000 0xe00>;
-		fsl,has-rstcr;
-		#sleep-cells = <1>;
-		fsl,liodn-bits = <12>;
-	};
-
-	pins: global-utilities@e0e00 {
-		compatible = "fsl,qoriq-pin-control-1.0";
-		reg = <0xe0e00 0x200>;
-		#sleep-cells = <2>;
-	};
-
-	clockgen: global-utilities@e1000 {
-		compatible = "fsl,p3060-clockgen", "fsl,qoriq-clockgen-1.0";
-		reg = <0xe1000 0x1000>;
-		clock-frequency = <0>;
-	};
-
-	rcpm: global-utilities@e2000 {
-		compatible = "fsl,qoriq-rcpm-1.0";
-		reg = <0xe2000 0x1000>;
-		#sleep-cells = <1>;
-	};
-
-	sfp: sfp@e8000 {
-		compatible = "fsl,p3060-sfp", "fsl,qoriq-sfp-1.0";
-		reg	   = <0xe8000 0x1000>;
-	};
-
-	serdes: serdes@ea000 {
-		compatible = "fsl,p3060-serdes";
-		reg	   = <0xea000 0x1000>;
-	};
-
-/include/ "qoriq-dma-0.dtsi"
-/include/ "qoriq-dma-1.dtsi"
-/include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
-		fsl,espi-num-chipselects = <4>;
-	};
-
-/include/ "qoriq-i2c-0.dtsi"
-/include/ "qoriq-i2c-1.dtsi"
-/include/ "qoriq-duart-0.dtsi"
-/include/ "qoriq-duart-1.dtsi"
-/include/ "qoriq-gpio-0.dtsi"
-/include/ "qoriq-usb2-mph-0.dtsi"
-	usb@210000 {
-		compatible = "fsl-usb2-mph-v2.2", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
-	};
-/include/ "qoriq-usb2-dr-0.dtsi"
-	usb@211000 {
-		compatible = "fsl-usb2-dr-v2.2", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
-	};
-/include/ "qoriq-sec4.1-0.dtsi"
-};
diff --git a/arch/powerpc/boot/dts/fsl/p3060si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p3060si-pre.dtsi
deleted file mode 100644
index 00c8e70..0000000
--- a/arch/powerpc/boot/dts/fsl/p3060si-pre.dtsi
+++ /dev/null
@@ -1,125 +0,0 @@
-/*
- * P3060 Silicon/SoC Device Tree Source (pre include)
- *
- * Copyright 2011 Freescale Semiconductor Inc.
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
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-/dts-v1/;
-/ {
-	compatible = "fsl,P3060";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	aliases {
-		ccsr = &soc;
-		dcsr = &dcsr;
-
-		serial0 = &serial0;
-		serial1 = &serial1;
-		serial2 = &serial2;
-		serial3 = &serial3;
-		pci0 = &pci0;
-		pci1 = &pci1;
-		usb0 = &usb0;
-		usb1 = &usb1;
-		dma0 = &dma0;
-		dma1 = &dma1;
-		msi0 = &msi0;
-		msi1 = &msi1;
-		msi2 = &msi2;
-
-		crypto = &crypto;
-		sec_jr0 = &sec_jr0;
-		sec_jr1 = &sec_jr1;
-		sec_jr2 = &sec_jr2;
-		sec_jr3 = &sec_jr3;
-		rtic_a = &rtic_a;
-		rtic_b = &rtic_b;
-		rtic_c = &rtic_c;
-		rtic_d = &rtic_d;
-		sec_mon = &sec_mon;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: PowerPC,e500mc@0 {
-			device_type = "cpu";
-			reg = <0>;
-			next-level-cache = <&L2_0>;
-			L2_0: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-		cpu1: PowerPC,e500mc@1 {
-			device_type = "cpu";
-			reg = <1>;
-			next-level-cache = <&L2_1>;
-			L2_1: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-		cpu4: PowerPC,e500mc@4 {
-			device_type = "cpu";
-			reg = <4>;
-			next-level-cache = <&L2_4>;
-			L2_4: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-		cpu5: PowerPC,e500mc@5 {
-			device_type = "cpu";
-			reg = <5>;
-			next-level-cache = <&L2_5>;
-			L2_5: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-		cpu6: PowerPC,e500mc@6 {
-			device_type = "cpu";
-			reg = <6>;
-			next-level-cache = <&L2_6>;
-			L2_6: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-		cpu7: PowerPC,e500mc@7 {
-			device_type = "cpu";
-			reg = <7>;
-			next-level-cache = <&L2_7>;
-			L2_7: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-	};
-};
diff --git a/arch/powerpc/boot/dts/p3060qds.dts b/arch/powerpc/boot/dts/p3060qds.dts
deleted file mode 100644
index 9ae875c..0000000
--- a/arch/powerpc/boot/dts/p3060qds.dts
+++ /dev/null
@@ -1,242 +0,0 @@
-/*
- * P3060QDS Device Tree Source
- *
- * Copyright 2011 Freescale Semiconductor Inc.
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
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-/include/ "fsl/p3060si-pre.dtsi"
-
-/ {
-	model = "fsl,P3060QDS";
-	compatible = "fsl,P3060QDS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	memory {
-		device_type = "memory";
-	};
-
-	dcsr: dcsr@f00000000 {
-		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
-	};
-
-	soc: soc@ffe000000 {
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-		spi@110000 {
-			flash@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
-				reg = <0>;
-				spi-max-frequency = <40000000>; /* input clock */
-				partition@u-boot {
-					label = "u-boot";
-					reg = <0x00000000 0x00100000>;
-					read-only;
-				};
-				partition@kernel {
-					label = "kernel";
-					reg = <0x00100000 0x00500000>;
-					read-only;
-				};
-				partition@dtb {
-					label = "dtb";
-					reg = <0x00600000 0x00100000>;
-					read-only;
-				};
-				partition@fs {
-					label = "file system";
-					reg = <0x00700000 0x00900000>;
-				};
-			};
-			flash@1 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "spansion,en25q32b";
-				reg = <1>;
-				spi-max-frequency = <40000000>; /* input clock */
-				partition@spi1 {
-					label = "spi1";
-					reg = <0x00000000 0x00400000>;
-				};
-			};
-			flash@2 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "atmel,at45db081d";
-				reg = <2>;
-				spi-max-frequency = <40000000>; /* input clock */
-				partition@spi1 {
-					label = "spi2";
-					reg = <0x00000000 0x00100000>;
-				};
-			};
-			flash@3 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "spansion,sst25wf040";
-				reg = <3>;
-				spi-max-frequency = <40000000>; /* input clock */
-				partition@spi3 {
-					label = "spi3";
-					reg = <0x00000000 0x00080000>;
-				};
-			};
-		};
-
-		i2c@118000 {
-			eeprom@51 {
-				compatible = "at24,24c256";
-				reg = <0x51>;
-			};
-			eeprom@53 {
-				compatible = "at24,24c256";
-				reg = <0x53>;
-			};
-			rtc@68 {
-				compatible = "dallas,ds3232";
-				reg = <0x68>;
-				interrupts = <0x1 0x1 0 0>;
-			};
-		};
-
-		usb0: usb@210000 {
-			phy_type = "ulpi";
-		};
-
-		usb1: usb@211000 {
-			dr_mode = "host";
-			phy_type = "ulpi";
-		};
-	};
-
-	rio: rapidio@ffe0c0000 {
-		reg = <0xf 0xfe0c0000 0 0x11000>;
-
-		port1 {
-			ranges = <0 0 0xc 0x20000000 0 0x10000000>;
-		};
-		port2 {
-			ranges = <0 0 0xc 0x30000000 0 0x10000000>;
-		};
-	};
-
-	lbc: localbus@ffe124000 {
-		reg = <0xf 0xfe124000 0 0x1000>;
-		ranges = <0 0 0xf 0xe8000000 0x08000000
-			  2 0 0xf 0xffa00000 0x00040000
-			  3 0 0xf 0xffdf0000 0x00008000>;
-
-		flash@0,0 {
-			compatible = "cfi-flash";
-			reg = <0 0 0x08000000>;
-			bank-width = <2>;
-			device-width = <2>;
-		};
-
-		nand@2,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,elbc-fcm-nand";
-			reg = <0x2 0x0 0x40000>;
-
-			partition@0 {
-				label = "NAND U-Boot Image";
-				reg = <0x0 0x02000000>;
-				read-only;
-			};
-
-			partition@2000000 {
-				label = "NAND Root File System";
-				reg = <0x02000000 0x10000000>;
-			};
-
-			partition@12000000 {
-				label = "NAND Compressed RFS Image";
-				reg = <0x12000000 0x08000000>;
-			};
-
-			partition@1a000000 {
-				label = "NAND Linux Kernel Image";
-				reg = <0x1a000000 0x04000000>;
-			};
-
-			partition@1e000000 {
-				label = "NAND DTB Image";
-				reg = <0x1e000000 0x01000000>;
-			};
-
-			partition@1f000000 {
-				label = "NAND Writable User area";
-				reg = <0x1f000000 0x21000000>;
-			};
-		};
-
-		board-control@3,0 {
-			compatible = "fsl,p3060qds-fpga", "fsl,fpga-qixis";
-			reg = <3 0 0x100>;
-		};
-	};
-
-	pci0: pcie@ffe200000 {
-		reg = <0xf 0xfe200000 0 0x1000>;
-		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
-			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
-		pcie@0 {
-			ranges = <0x02000000 0 0xe0000000
-				  0x02000000 0 0xe0000000
-				  0 0x20000000
-
-				  0x01000000 0 0x00000000
-				  0x01000000 0 0x00000000
-				  0 0x00010000>;
-		};
-	};
-
-	pci1: pcie@ffe201000 {
-		reg = <0xf 0xfe201000 0 0x1000>;
-		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
-		pcie@0 {
-			ranges = <0x02000000 0 0xe0000000
-				  0x02000000 0 0xe0000000
-				  0 0x20000000
-
-				  0x01000000 0 0x00000000
-				  0x01000000 0 0x00000000
-				  0 0x00010000>;
-		};
-	};
-};
-
-/include/ "fsl/p3060si-post.dtsi"
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index b32d949..efce1d6 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -23,7 +23,6 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_P2041_RDB=y
 CONFIG_P3041_DS=y
-CONFIG_P3060_QDS=y
 CONFIG_P4080_DS=y
 CONFIG_P5020_DS=y
 CONFIG_HIGHMEM=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index b3370be..0e77f5f 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -216,18 +216,6 @@ config P3041_DS
 	help
 	  This option enables support for the P3041 DS board
 
-config P3060_QDS
-	bool "Freescale P3060 QDS"
-	select DEFAULT_UIMAGE
-	select PPC_E500MC
-	select PHYS_64BIT
-	select SWIOTLB
-	select GPIO_MPC8XXX
-	select HAS_RAPIDIO
-	select PPC_EPAPR_HV_PIC
-	help
-	  This option enables support for the P3060 QDS board
-
 config P4080_DS
 	bool "Freescale P4080 DS"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 50280cc..3fee687 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
 obj-$(CONFIG_P2041_RDB)   += p2041_rdb.o corenet_ds.o
 obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
-obj-$(CONFIG_P3060_QDS)   += p3060_qds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
diff --git a/arch/powerpc/platforms/85xx/p3060_qds.c b/arch/powerpc/platforms/85xx/p3060_qds.c
deleted file mode 100644
index 081cf4a..0000000
--- a/arch/powerpc/platforms/85xx/p3060_qds.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * P3060 QDS Setup
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/phy.h>
-#include <asm/machdep.h>
-#include <asm/udbg.h>
-#include <asm/mpic.h>
-#include <linux/of_platform.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
-#include <asm/ehv_pic.h>
-#include "corenet_ds.h"
-
-/*
- * Called very early, device-tree isn't unflattened
- */
-static int __init p3060_qds_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-#ifdef CONFIG_SMP
-	extern struct smp_ops_t smp_85xx_ops;
-#endif
-
-	if (of_flat_dt_is_compatible(root, "fsl,P3060QDS"))
-		return 1;
-
-	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_is_compatible(root, "fsl,P3060QDS-hv")) {
-		ppc_md.init_IRQ = ehv_pic_init;
-		ppc_md.get_irq = ehv_pic_get_irq;
-		ppc_md.restart = fsl_hv_restart;
-		ppc_md.power_off = fsl_hv_halt;
-		ppc_md.halt = fsl_hv_halt;
-#ifdef CONFIG_SMP
-		/*
-		 * Disable the timebase sync operations because we can't write
-		 * to the timebase registers under the hypervisor.
-		 */
-		smp_85xx_ops.give_timebase = NULL;
-		smp_85xx_ops.take_timebase = NULL;
-#endif
-		return 1;
-	}
-
-	return 0;
-}
-
-define_machine(p3060_qds) {
-	.name			= "P3060 QDS",
-	.probe			= p3060_qds_probe,
-	.setup_arch		= corenet_ds_setup_arch,
-	.init_IRQ		= corenet_ds_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-#endif
-	.get_irq		= mpic_get_coreint_irq,
-	.restart		= fsl_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-	.power_save		= e500_idle,
-};
-
-machine_device_initcall(p3060_qds, corenet_ds_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(p3060_qds, swiotlb_setup_bus_notifier);
-#endif
-- 
1.7.3.4
