Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 465D9DDF74
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:40:17 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 3AD128815
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 20:40:25 +0400 (SAMT)
Date: Thu, 24 Jan 2008 18:40:01 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] [POWERPC][NET] ucc_geth_mii and users: get rid of
	device_type
Message-ID: <20080124154001.GB23246@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080124151850.GA15190@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

device_type property is bogus, thus use proper compatible.

Also change compatible property to "fsl,ucc-mdio".

Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc832x_mds.dts |    3 +--
 arch/powerpc/boot/dts/mpc832x_rdb.dts |    3 +--
 arch/powerpc/boot/dts/mpc836x_mds.dts |    3 +--
 arch/powerpc/boot/dts/mpc836x_rdk.dts |    3 +--
 arch/powerpc/boot/dts/mpc8568mds.dts  |    2 +-
 drivers/net/ucc_geth_mii.c            |    3 +++
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index e300df4..1bb75ef 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -304,8 +304,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2320 18>;
-			device_type = "mdio";
-			compatible = "ucc_geth_phy";
+			compatible = "fsl,ucc-mdio";
 
 			phy3: ethernet-phy@03 {
 				interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 4d5cfd3..f6a8633 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -237,8 +237,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3120 18>;
-			device_type = "mdio";
-			compatible = "ucc_geth_phy";
+			compatible = "fsl,ucc-mdio";
 
 			phy00:ethernet-phy@00 {
 				interrupt-parent = <&pic>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 9a2581b..fa98bdf 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -288,8 +288,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2120 18>;
-			device_type = "mdio";
-			compatible = "ucc_geth_phy";
+			compatible = "fsl,ucc-mdio";
 
 			phy0: ethernet-phy@00 {
 				interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index e244619..e299442 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -251,8 +251,7 @@
 		mdio@2120 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "mdio";
-			compatible = "fsl,ucc-mdio", "ucc_geth_phy";
+			compatible = "fsl,ucc-mdio";
 			reg = <0x2120 0x18>;
 
 			phy1: ethernet-phy@1 {
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 04f5c6f..692d5bd 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -357,7 +357,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2120 18>;
-			compatible = "ucc_geth_phy";
+			compatible = "fsl,ucc-mdio";
 
 			/* These are the same PHYs as on
 			 * gianfar's MDIO bus */
diff --git a/drivers/net/ucc_geth_mii.c b/drivers/net/ucc_geth_mii.c
index df884f0..e3ba14a 100644
--- a/drivers/net/ucc_geth_mii.c
+++ b/drivers/net/ucc_geth_mii.c
@@ -256,6 +256,9 @@ static struct of_device_id uec_mdio_match[] = {
 		.type = "mdio",
 		.compatible = "ucc_geth_phy",
 	},
+	{
+		.compatible = "fsl,ucc-mdio",
+	},
 	{},
 };
 
-- 
1.5.2.2
