Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32EB7DE5C9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 06:14:17 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m75KDhOc027576
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 13:14:14 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-194.am.freescale.net
	[10.214.72.194])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m75KDeNC025312
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 15:13:43 -0500 (CDT)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH add immr alias 4/4] powerpc: 8[56]xx: Add immr aliases to
	8[56]xx device trees
Date: Tue,  5 Aug 2008 14:13:40 -0600
Message-Id: <1217967220-30557-4-git-send-email-jrigby@freescale.com>
In-Reply-To: <1217967220-30557-3-git-send-email-jrigby@freescale.com>
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
	<1217967220-30557-2-git-send-email-jrigby@freescale.com>
	<1217967220-30557-3-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_immrbase knows about immr aliases.

Some chip docs call this ccsr for 8[56]xx platforms
but we stick with immr for consistency across 8xxx.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/boot/dts/ksi8560.dts          |    3 ++-
 arch/powerpc/boot/dts/mpc8536ds.dts        |    3 ++-
 arch/powerpc/boot/dts/mpc8540ads.dts       |    3 ++-
 arch/powerpc/boot/dts/mpc8541cds.dts       |    3 ++-
 arch/powerpc/boot/dts/mpc8544ds.dts        |    3 ++-
 arch/powerpc/boot/dts/mpc8548cds.dts       |    3 ++-
 arch/powerpc/boot/dts/mpc8555cds.dts       |    3 ++-
 arch/powerpc/boot/dts/mpc8560ads.dts       |    3 ++-
 arch/powerpc/boot/dts/mpc8568mds.dts       |    3 ++-
 arch/powerpc/boot/dts/mpc8572ds.dts        |    3 ++-
 arch/powerpc/boot/dts/mpc8610_hpcd.dts     |    3 ++-
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    3 ++-
 arch/powerpc/boot/dts/mpc866ads.dts        |    6 +++++-
 arch/powerpc/boot/dts/mpc885ads.dts        |    6 +++++-
 arch/powerpc/boot/dts/sbc8548.dts          |    3 ++-
 arch/powerpc/boot/dts/sbc8560.dts          |    3 ++-
 arch/powerpc/boot/dts/sbc8641d.dts         |    3 ++-
 arch/powerpc/boot/dts/stx_gp3_8560.dts     |    3 ++-
 arch/powerpc/boot/dts/tqm8540.dts          |    3 ++-
 arch/powerpc/boot/dts/tqm8541.dts          |    3 ++-
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    4 +++-
 arch/powerpc/boot/dts/tqm8548.dts          |    4 +++-
 arch/powerpc/boot/dts/tqm8555.dts          |    3 ++-
 arch/powerpc/boot/dts/tqm8560.dts          |    3 ++-
 24 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/boot/dts/ksi8560.dts b/arch/powerpc/boot/dts/ksi8560.dts
index 4973758..9d3e560 100644
--- a/arch/powerpc/boot/dts/ksi8560.dts
+++ b/arch/powerpc/boot/dts/ksi8560.dts
@@ -24,6 +24,7 @@
 		ethernet0 = &enet0;
 		ethernet1 = &enet1;
 		ethernet2 = &enet2;
+		immr = &immr;
 	};
 
 	cpus {
@@ -49,7 +50,7 @@
 		reg = <0x00000000 0x10000000>;			/* Fixed by bootwrapper */
 	};
 
-	soc@fdf00000 {
+	immr: soc@fdf00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 1505d68..0d28ff4 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -26,6 +26,7 @@
 		pci1 = &pci1;
 		pci2 = &pci2;
 		pci3 = &pci3;
+		immr = &immr;
 	};
 
 	cpus {
@@ -45,7 +46,7 @@
 		reg = <00000000 00000000>;	// Filled by U-Boot
 	};
 
-	soc@ffe00000 {
+	immr: soc@ffe00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 9568bfa..1f32d2f 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -24,6 +24,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -49,7 +50,7 @@
 		reg = <0x0 0x8000000>;	// 128M at 0x0
 	};
 
-	soc8540@e0000000 {
+	immr: soc8540@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 6480f4f..e5fb2d1 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -24,6 +24,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		immr = &immr;
 	};
 
 	cpus {
@@ -49,7 +50,7 @@
 		reg = <0x0 0x8000000>;	// 128M at 0x0
 	};
 
-	soc8541@e0000000 {
+	immr: soc8541@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index f1fb207..0814730 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -25,6 +25,7 @@
 		pci1 = &pci1;
 		pci2 = &pci2;
 		pci3 = &pci3;
+		immr = &immr;
 	};
 
 	cpus {
@@ -50,7 +51,7 @@
 		reg = <0x0 0x0>;	// Filled by U-Boot
 	};
 
-	soc8544@e0000000 {
+	immr: soc8544@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 431b496..71ff390 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -29,6 +29,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		immr = &immr;
 	};
 
 	cpus {
@@ -54,7 +55,7 @@
 		reg = <0x0 0x8000000>;	// 128M at 0x0
 	};
 
-	soc8548@e0000000 {
+	immr: soc8548@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index d833a5c..6b2eaa1 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -24,6 +24,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		immr = &immr;
 	};
 
 	cpus {
@@ -49,7 +50,7 @@
 		reg = <0x0 0x8000000>;	// 128M at 0x0
 	};
 
-	soc8555@e0000000 {
+	immr: soc8555@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 4d1f2f2..ff118e3 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -25,6 +25,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -49,7 +50,7 @@
 		reg = <0x0 0x10000000>;
 	};
 
-	soc8560@e0000000 {
+	immr: soc8560@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index a15f103..83a2d36 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -26,6 +26,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		immr = &immr;
 	};
 
 	cpus {
@@ -56,7 +57,7 @@
 		reg = <0xf8000000 0x8000>;
 	};
 
-	soc8568@e0000000 {
+	immr: soc8568@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index e124dd1..f97045a 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -26,6 +26,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		immr = &immr;
 	};
 
 	cpus {
@@ -64,7 +65,7 @@
 		reg = <0x0 0x0>;	// Filled by U-Boot
 	};
 
-	soc8572@ffe00000 {
+	immr: soc8572@ffe00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 666185f..67f252f 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -22,6 +22,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		immr = &immr;
 	};
 
 	cpus {
@@ -46,7 +47,7 @@
 		reg = <0x00000000 0x20000000>;	// 512M at 0x0
 	};
 
-	localbus@e0005000 {
+	immr: localbus@e0005000 {
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8610-elbc", "fsl,elbc", "simple-bus";
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index ae08761..4287605 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -27,6 +27,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		rapidio0 = &rapidio0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -103,7 +104,7 @@
 		};
 	};
 
-	soc8641@f8000000 {
+	immr: soc8641@f8000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index bd70065..021068b 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -18,6 +18,10 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		immr = &immr;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -59,7 +63,7 @@
 		};
 	};
 
-	soc@ff000000 {
+	immr: soc@ff000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index b123e9f..daaa180 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -18,6 +18,10 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		immr = &immr;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -67,7 +71,7 @@
 		};
 	};
 
-	soc@ff000000 {
+	immr: soc@ff000000 {
 		compatible = "fsl,mpc885", "fsl,pq1-soc";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 333552b..6bbd50c 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -28,6 +28,7 @@
 		pci0 = &pci0;
 		/* pci1 doesn't have a corresponding physical connector */
 		pci2 = &pci2;
+		immr = &immr;
 	};
 
 	cpus {
@@ -146,7 +147,7 @@
                 };
         };
 
-	soc8548@e0000000 {
+	immr: soc8548@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index db3632e..f0e7db2 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -27,6 +27,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -52,7 +53,7 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
-	soc@ff700000 {
+	immr: soc@ff700000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/sbc8641d.dts
index 9652456..f98e942 100644
--- a/arch/powerpc/boot/dts/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/sbc8641d.dts
@@ -30,6 +30,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		immr = &immr;
 	};
 
 	cpus {
@@ -120,7 +121,7 @@
 		};
 	};
 
-	soc@f8000000 {
+	immr: soc@f8000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index fcd1db6..15d1889 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -22,6 +22,7 @@
 		ethernet1 = &enet1;
 		serial0 = &serial0;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -47,7 +48,7 @@
 		reg = <0x00000000 0x10000000>;
 	};
 
-	soc@fdf00000 {
+	immr: soc@fdf00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index e1d260b..8f1fda7 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -24,6 +24,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -49,7 +50,7 @@
 		reg = <0x00000000 0x10000000>;
 	};
 
-	soc@e0000000 {
+	immr: soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index d76441e..3905e7c 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -23,6 +23,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -48,7 +49,7 @@
 		reg = <0x00000000 0x10000000>;
 	};
 
-	soc@e0000000 {
+	immr: soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index 64d2d5b..f2e7cf8 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -28,6 +28,8 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+
+		immr = &immr;
 	};
 
 	cpus {
@@ -50,7 +52,7 @@
 		reg = <0x00000000 0x00000000>;	// Filled in by U-Boot
 	};
 
-	soc8548@a0000000 {
+	immr: soc8548@a0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index 2563112..42ab8b1 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -28,6 +28,8 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+
+		immr = &immr;
 	};
 
 	cpus {
@@ -50,7 +52,7 @@
 		reg = <0x00000000 0x00000000>;	// Filled in by U-Boot
 	};
 
-	soc8548@e0000000 {
+	immr: soc8548@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 6f7ea59..76de7bd 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -23,6 +23,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -48,7 +49,7 @@
 		reg = <0x00000000 0x10000000>;
 	};
 
-	soc@e0000000 {
+	immr: soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index 3fe3520..1fd6b74 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -25,6 +25,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -50,7 +51,7 @@
 		reg = <0x00000000 0x10000000>;
 	};
 
-	soc@e0000000 {
+	immr: soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-- 
