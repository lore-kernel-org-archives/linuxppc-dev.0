Return-Path: <dbaryshkov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BB0CB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 01:15:18 +1000 (EST)
Received: by wyg36 with SMTP id 36so4701623wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jun 2011 08:15:14 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc/85xx: specify interrupt for pq3-localbus devices
Date: Wed,  1 Jun 2011 19:15:18 +0400
Message-Id: <1306941318-5771-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fsl-lbc driver requires an interrupt to bind to localbus device.
Populate 85xx boards' dts trees with lbc interrupt info.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts       |    2 ++
 arch/powerpc/boot/dts/socrates.dts         |    2 ++
 arch/powerpc/boot/dts/tqm8540.dts          |    2 ++
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    2 ++
 arch/powerpc/boot/dts/tqm8548.dts          |    2 ++
 arch/powerpc/boot/dts/tqm8560.dts          |    2 ++
 arch/powerpc/boot/dts/xpedite5200.dts      |    2 ++
 arch/powerpc/boot/dts/xpedite5200_xmon.dts |    2 ++
 8 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 30cf0e0..647daf8 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -60,6 +60,8 @@
 		compatible = "fsl,mpc8568-localbus", "fsl,pq3-localbus",
 			     "simple-bus";
 		reg = <0xe0005000 0x1000>;
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
 
 		ranges = <0x0 0x0 0xfe000000 0x02000000
 			  0x1 0x0 0xf8000000 0x00008000
diff --git a/arch/powerpc/boot/dts/socrates.dts b/arch/powerpc/boot/dts/socrates.dts
index feb4ef6..38c3540 100644
--- a/arch/powerpc/boot/dts/socrates.dts
+++ b/arch/powerpc/boot/dts/socrates.dts
@@ -240,6 +240,8 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <0xe0005000 0x40>;
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
 
 		ranges = <0 0 0xfc000000 0x04000000
 			  2 0 0xc8000000 0x04000000
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index e028457..0a4cedb 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -283,6 +283,8 @@
 		compatible = "fsl,mpc8540-localbus", "fsl,pq3-localbus",
 			     "simple-bus";
 		reg = <0xe0005000 0x1000>;
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
 
 		ranges = <0x0 0x0 0xfe000000 0x02000000>;
 
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index 5dbb36e..9452c3c 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -346,6 +346,8 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <0xa0005000 0x100>;	// BRx, ORx, etc.
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
 
 		ranges = <
 			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index a050ae4..619776f 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -346,6 +346,8 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <0xe0005000 0x100>;	// BRx, ORx, etc.
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
 
 		ranges = <
 			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index 22ec39b..7665a16 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -312,6 +312,8 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <0xe0005000 0x100>;	// BRx, ORx, etc.
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
 
 		ranges = <
 			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
diff --git a/arch/powerpc/boot/dts/xpedite5200.dts b/arch/powerpc/boot/dts/xpedite5200.dts
index a0cf53f..c41a80c 100644
--- a/arch/powerpc/boot/dts/xpedite5200.dts
+++ b/arch/powerpc/boot/dts/xpedite5200.dts
@@ -374,6 +374,8 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <0xef005000 0x100>;	// BRx, ORx, etc.
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
 
 		ranges = <
 			0 0x0 0xfc000000 0x04000000	// NOR boot flash
diff --git a/arch/powerpc/boot/dts/xpedite5200_xmon.dts b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
index c5b2975..c0efcbb 100644
--- a/arch/powerpc/boot/dts/xpedite5200_xmon.dts
+++ b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
@@ -378,6 +378,8 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <0xef005000 0x100>;	// BRx, ORx, etc.
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
 
 		ranges = <
 			0 0x0 0xf8000000 0x08000000	// NOR boot flash
-- 
1.7.4.4
