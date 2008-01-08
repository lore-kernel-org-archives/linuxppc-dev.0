Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C8302DDF4E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 01:29:52 +1100 (EST)
Date: Tue, 8 Jan 2008 17:29:42 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2/4] [POWERPC][NET] ucc_geth_mii and users: get rid of
	device_type
Message-ID: <20080108142942.GB11047@localhost.localdomain>
References: <20080108142634.GA5989@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080108142634.GA5989@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
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
 arch/powerpc/boot/dts/mpc8568mds.dts  |    2 +-
 drivers/net/ucc_geth_mii.c            |    3 +++
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 010c8d9..cf41194 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -255,8 +255,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2320 18>;
-			device_type = "mdio";
-			compatible = "ucc_geth_phy";
+			compatible = "fsl,ucc-mdio";
 
 			phy3: ethernet-phy@03 {
 				interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 3a73134..09301c1 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -236,8 +236,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3120 18>;
-			device_type = "mdio";
-			compatible = "ucc_geth_phy";
+			compatible = "fsl,ucc-mdio";
 
 			phy00:ethernet-phy@00 {
 				interrupt-parent = <&pic>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 2986860..3eb8f72 100644
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
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 7440347..2bc147f 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -356,7 +356,7 @@
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
