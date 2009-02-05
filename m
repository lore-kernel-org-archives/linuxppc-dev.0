Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9B175DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 07:10:41 +1100 (EST)
Date: Thu, 5 Feb 2009 23:10:40 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/83xx: Fix TSEC0 workability on MPC8313E-RDB boards
Message-ID: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

TSEC0 is connected to Vitesse 7385 5-port switch. The switch
isn't connected to any mdio bus, the link to the switch is fixed
to Full-duplex 1000 Mb/s (no pause).

This patch fixes following failure during bootup:

mdio@24520:01 not found
eth0: Could not attach to PHY
IP-Config: Failed to open eth0

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts           |    9 ++-------
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig |    2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 3f84cd0..3ebf7ec 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -191,7 +191,8 @@
 			interrupts = <37 0x8 36 0x8 35 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = < &tbi0 >;
-			phy-handle = < &phy1 >;
+			/* Vitesse 7385 isn't on the MDIO bus */
+			fixed-link = <1 1 1000 0 0>;
 			fsl,magic-packet;
 
 			mdio@24520 {
@@ -199,12 +200,6 @@
 				#size-cells = <0>;
 				compatible = "fsl,gianfar-mdio";
 				reg = <0x24520 0x20>;
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&ipic>;
-					interrupts = <19 0x8>;
-					reg = <0x1>;
-					device_type = "ethernet-phy";
-				};
 				phy4: ethernet-phy@4 {
 					interrupt-parent = <&ipic>;
 					interrupts = <20 0x8>;
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index 9e47ae9..409d017 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -651,7 +651,7 @@ CONFIG_CICADA_PHY=y
 # CONFIG_NATIONAL_PHY is not set
 # CONFIG_STE10XP is not set
 # CONFIG_LSI_ET1011C_PHY is not set
-# CONFIG_FIXED_PHY is not set
+CONFIG_FIXED_PHY=y
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-- 
1.5.6.5
