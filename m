Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26A5BDDE33
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jun 2007 05:33:25 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5MJXIPT022550
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 12:33:18 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx,
	and 86xx device trees
Date: Fri, 22 Jun 2007 14:33:15 -0500
Message-Id: <11825407952085-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For the 83xx, 85xx, and 86xx device trees, add a "local-mac-address" property
to every Ethernet node that didn't have one.  Add a comment indicating that
the "address" and/or "mac-address" properties are deprecated in DTS files
and will be removed at a later time.  Change all MAC address properties to
have a zero MAC address value.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is the second-to-last step of a series of changes to U-Boot and the
kernel for cleaning up the MAC address entries in the device trees.  U-Boot was
updated (see U-Boot commits 85e7c7a45e3dd9c7ce3e722352ba60f8df1a7a4b,
bd7851ce1e1f140665b520026abf1042968b1102, and
61f4f912acbe60776c5e00df1ec94094ce672957) to write the MAC address to both
"mac-address" and "local-mac-address".  This provides compatibility with all
DTS files, even ones that are wrong.  The kernel was updated to check
"mac-address" first, and if NULL or non-existant, "local-mac-address" (see
Linux commits e9eb70c92143c8f03e456aa60d89204b3311e554 and
29cfe6f4fb7d187f65564764a0ecf2caf9d8ed58).

This patch only adds the missing "local-mac-address" property to the device
trees.  A later patch, will be named something like "remove deprecated MAC
address properties from device trees" will remove the deprecate properties.
At that time, the device trees will require a recent version of U-Boot to
function.

This patch limits it changes to the 83xx, 85xx, and 86xx trees because those
are the only ones where the code has already been fixed to use the right
entries.  All DTS files should be changed in the same way, but someone else
will have to verify the U-Boot code.

 arch/powerpc/boot/dts/mpc832x_mds.dts  |   16 ++++++++++++++--
 arch/powerpc/boot/dts/mpc832x_rdb.dts  |   16 ++++++++++++++--
 arch/powerpc/boot/dts/mpc8349emitx.dts |   10 ++++++++++
 arch/powerpc/boot/dts/mpc834x_mds.dts  |   10 ++++++++++
 arch/powerpc/boot/dts/mpc836x_mds.dts  |   16 ++++++++++++++--
 arch/powerpc/boot/dts/mpc8540ads.dts   |   27 +++++++++++++++++++++------
 arch/powerpc/boot/dts/mpc8541cds.dts   |    4 ++--
 arch/powerpc/boot/dts/mpc8548cds.dts   |    8 ++++----
 arch/powerpc/boot/dts/mpc8555cds.dts   |    4 ++--
 arch/powerpc/boot/dts/mpc8560ads.dts   |   32 ++++++++++++++++++++++++++++----
 arch/powerpc/boot/dts/mpc8568mds.dts   |   30 +++++++++++++++++++++++++++---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   32 ++++++++++++++++++++++++++++----
 12 files changed, 174 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 112dd51..16a2c3e 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -272,7 +272,13 @@
 			reg = <2200 200>;
 			interrupts = <22>;
 			interrupt-parent = < &qeic >;
-			mac-address = [ 00 04 9f 00 23 23 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <19>;
 			tx-clock = <1a>;
 			phy-handle = < &phy3 >;
@@ -287,7 +293,13 @@
 			reg = <3000 200>;
 			interrupts = <23>;
 			interrupt-parent = < &qeic >;
-			mac-address = [ 00 11 22 33 44 55 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <17>;
 			tx-clock = <18>;
 			phy-handle = < &phy4 >;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index be4c357..447c03f 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -231,7 +231,13 @@
 			reg = <3000 200>;
 			interrupts = <21>;
 			interrupt-parent = <&qeic>;
-			mac-address = [ 00 04 9f ef 03 02 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <20>;
 			tx-clock = <13>;
 			phy-handle = <&phy00>;
@@ -246,7 +252,13 @@
 			reg = <2200 200>;
 			interrupts = <22>;
 			interrupt-parent = <&qeic>;
-			mac-address = [ 00 04 9f ef 03 01 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <19>;
 			tx-clock = <1a>;
 			phy-handle = <&phy04>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index db0d003..ae9bca5 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -131,6 +131,11 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
+			/*
+			 * address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
 			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <20 8 21 8 22 8>;
@@ -145,6 +150,11 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
+			/*
+			 * address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
 			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 8 24 8 25 8>;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index df773fa..310e877 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -136,6 +136,11 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
+			/*
+			 * address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
 			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <20 8 21 8 22 8>;
@@ -150,6 +155,11 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
+			/*
+			 * address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
 			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 8 24 8 25 8>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 38c8594..1e914f3 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -301,7 +301,13 @@
 			reg = <2000 200>;
 			interrupts = <20>;
 			interrupt-parent = < &qeic >;
-			mac-address = [ 00 04 9f 00 23 23 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
 			tx-clock = <19>;
 			phy-handle = < &phy0 >;
@@ -317,7 +323,13 @@
 			reg = <3000 200>;
 			interrupts = <21>;
 			interrupt-parent = < &qeic >;
-			mac-address = [ 00 11 22 33 44 55 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
 			tx-clock = <14>;
 			phy-handle = < &phy1 >;
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index d91e81c..78828b2 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -106,8 +106,13 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			address = [ 00 E0 0C 00 73 00 ];
-			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			/*
+			 * address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <d 2 e 2 12 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
@@ -120,8 +125,13 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			address = [ 00 E0 0C 00 73 01 ];
-			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			/*
+			 * address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
@@ -134,8 +144,13 @@
 			model = "FEC";
 			compatible = "gianfar";
 			reg = <26000 1000>;
-			address = [ 00 E0 0C 00 73 02 ];
-			local-mac-address = [ 00 E0 0C 00 73 02 ];
+			/*
+			 * address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <19 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy3>;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 4f2c3af..2a0afbc 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -100,7 +100,7 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <d 2 e 2 12 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
@@ -113,7 +113,7 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index ad96381..54b4e19 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -112,7 +112,7 @@
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <d 2 e 2 12 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
@@ -125,7 +125,7 @@
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
@@ -139,7 +139,7 @@
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <26000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 02 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <f 2 10 2 11 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy2>;
@@ -152,7 +152,7 @@
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <27000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 03 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <15 2 16 2 17 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy3>;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 951ed92..c41ee61 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -100,7 +100,7 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <0d 2 0e 2 12 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
@@ -113,7 +113,7 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 8068215..205ee32 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -101,7 +101,13 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			address = [ 00 00 0C 00 00 FD ];
+			/*
+			 * address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <d 2 e 2 12 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
@@ -114,7 +120,13 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			address = [ 00 00 0C 00 01 FD ];
+			/*
+			 * address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
@@ -275,7 +287,13 @@
 				model = "FCC";
 				device-id = <2>;
 				reg = <91320 20 88500 100 913a0 30>;
-				mac-address = [ 00 00 0C 00 02 FD ];
+				/*
+				 * mac-address is deprecated and will be removed
+				 * in 2.6.25.  Only recent versions of
+				 * U-Boot support local-mac-address, however.
+				 */
+				mac-address = [ 00 00 00 00 00 00 ];
+				local-mac-address = [ 00 00 00 00 00 00 ];
 				clock-setup = <ff00ffff 250000>;
 				rx-clock = <15>;
 				tx-clock = <16>;
@@ -290,7 +308,13 @@
 				model = "FCC";
 				device-id = <3>;
 				reg = <91340 20 88600 100 913d0 30>;
-				mac-address = [ 00 00 0C 00 03 FD ];
+				/*
+				 * mac-address is deprecated and will be removed
+				 * in 2.6.25.  Only recent versions of
+				 * U-Boot support local-mac-address, however.
+				 */
+				mac-address = [ 00 00 00 00 00 00 ];
+				local-mac-address = [ 00 00 00 00 00 00 ];
 				clock-setup = <ffff00ff 3700>;
 				rx-clock = <17>;
 				tx-clock = <18>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index a123ec9..479a7a5 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -130,7 +130,13 @@
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
 			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <d 2 e 2 12 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy2>;
@@ -143,7 +149,13 @@
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			mac-address = [ 00 00 00 00 00 00];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy3>;
@@ -300,7 +312,13 @@
 			reg = <2000 200>;
 			interrupts = <20>;
 			interrupt-parent = <&qeic>;
-			mac-address = [ 00 04 9f 00 23 23 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
 			tx-clock = <19>;
 			phy-handle = <&qe_phy0>;
@@ -316,7 +334,13 @@
 			reg = <3000 200>;
 			interrupts = <21>;
 			interrupt-parent = <&qeic>;
-			mac-address = [ 00 11 22 33 44 55 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
 			tx-clock = <14>;
 			phy-handle = <&qe_phy1>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 260b264..4a99af1 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -117,7 +117,13 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			mac-address = [ 00 E0 0C 00 73 00 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <1d 2 1e 2 22 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
@@ -130,7 +136,13 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			mac-address = [ 00 E0 0C 00 73 01 ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 2 24 2 28 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
@@ -143,7 +155,13 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <26000 1000>;
-			mac-address = [ 00 E0 0C 00 02 FD ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <1F 2 20 2 21 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy2>;
@@ -156,7 +174,13 @@
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <27000 1000>;
-			mac-address = [ 00 E0 0C 00 03 FD ];
+			/*
+			 * mac-address is deprecated and will be removed
+			 * in 2.6.25.  Only recent versions of
+			 * U-Boot support local-mac-address, however.
+			 */
+			mac-address = [ 00 00 00 00 00 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <25 2 26 2 27 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy3>;
-- 
1.5.0.2.260.g2eb065
