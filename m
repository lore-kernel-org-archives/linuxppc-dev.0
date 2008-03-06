Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D20C1DDF09
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 22:46:07 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m26BhljT021242
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 04:46:01 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m26AVpOo015583
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 04:31:52 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/2] fix wrong USB phy type in mpc837xmds dts
Date: Thu,  6 Mar 2008 18:42:26 +0800
Message-Id: <1204800146-11591-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Due to chip constraint MPC837x USB DR module can only use
ULPI and serial PHY interfaces.  The patch fixes the wrong
type in dts.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts |    4 ++--
 arch/powerpc/boot/dts/mpc8378_mds.dts |    4 ++--
 arch/powerpc/boot/dts/mpc8379_mds.dts |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index a3637ff..677a061 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -91,7 +91,6 @@
 			mode = "cpu";
 		};
 
-		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
@@ -99,7 +98,8 @@
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
-			phy_type = "utmi_wide";
+			dr_mode = "host";
+			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 533e9b0..3f9e9fe 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -91,7 +91,6 @@
 			mode = "cpu";
 		};
 
-		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
@@ -99,7 +98,8 @@
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
-			phy_type = "utmi_wide";
+			dr_mode = "host";
+			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index c270685..36c1c13 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -91,7 +91,6 @@
 			mode = "cpu";
 		};
 
-		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
@@ -99,7 +98,8 @@
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
-			phy_type = "utmi_wide";
+			dr_mode = "host";
+			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
-- 
1.5.4.rc4
