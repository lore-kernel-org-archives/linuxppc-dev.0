Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 15985DDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 07:02:17 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 9B5798810
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 01:02:27 +0400 (SAMT)
Date: Wed, 12 Mar 2008 23:02:13 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 83xx: Fix wrong USB phy type in mpc837xrdb dts
Message-ID: <20080312200213.GA14807@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
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

This patch fixes USB malfunctioning on the MPC837xE-RDB boards.

Similar patch has been already applied for the MDS boards:

  commit 28b958859206b7010d03129611c2e444898e3ee4
  Author: Li Yang <leoli@freescale.com>
  Date:   Thu Mar 6 18:42:26 2008 +0800

      [POWERPC] 83xx: Fix wrong USB phy type in mpc837xmds dts

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_rdb.dts |    3 +--
 arch/powerpc/boot/dts/mpc8378_rdb.dts |    3 +--
 arch/powerpc/boot/dts/mpc8379_rdb.dts |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 440aa4d..5bc09ad 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -143,7 +143,6 @@
 			mode = "cpu";
 		};
 
-		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
@@ -151,7 +150,7 @@
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
-			phy_type = "utmi";
+			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 9271153..711f9a3 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -143,7 +143,6 @@
 			mode = "cpu";
 		};
 
-		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
@@ -151,7 +150,7 @@
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
-			phy_type = "utmi";
+			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 0dda2fc..c11ceb7 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -143,7 +143,6 @@
 			mode = "cpu";
 		};
 
-		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
@@ -151,7 +150,7 @@
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
-			phy_type = "utmi";
+			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
-- 
1.5.2.2
