Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4F4B6DDF7F
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 04:52:11 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 12C628810
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 22:52:27 +0400 (SAMT)
Date: Mon, 17 Mar 2008 20:52:08 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch isn't on
	the MDIO bus
Message-ID: <20080317175208.GA17844@localhost.localdomain>
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

MDIO-less PHYs should use CONFIG_FIXED_PHY driver and appropriate
fixed-link property in the device tree.

If not, ethernet will not work:
  e0024520:03 not found
  eth1: Could not attach to PHY
  IP-Config: Failed to open eth1

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_rdb.dts      |    8 +-------
 arch/powerpc/boot/dts/mpc8378_rdb.dts      |    8 +-------
 arch/powerpc/boot/dts/mpc8379_rdb.dts      |    8 +-------
 arch/powerpc/configs/mpc837x_rdb_defconfig |    2 +-
 4 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index d2332fb..476f65a 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -164,12 +164,6 @@
 				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
 		};
 
 		enet0: ethernet@24000 {
@@ -195,7 +189,7 @@
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
-			phy-handle = <&phy3>;
+			fixed-link = <1 1 1000 0 0>;
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 711f9a3..0e872a6 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -164,12 +164,6 @@
 				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
 		};
 
 		enet0: ethernet@24000 {
@@ -195,7 +189,7 @@
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
-			phy-handle = <&phy3>;
+			fixed-link = <1 1 1000 0 0>;
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index c11ceb7..1eb8def 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -164,12 +164,6 @@
 				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
 		};
 
 		enet0: ethernet@24000 {
@@ -195,7 +189,7 @@
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
-			phy-handle = <&phy3>;
+			fixed-link = <1 1 1000 0 0>;
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/configs/mpc837x_rdb_defconfig b/arch/powerpc/configs/mpc837x_rdb_defconfig
index 91d291e..c429a33 100644
--- a/arch/powerpc/configs/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/mpc837x_rdb_defconfig
@@ -425,7 +425,7 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_SMSC_PHY is not set
 # CONFIG_BROADCOM_PHY is not set
 # CONFIG_ICPLUS_PHY is not set
-# CONFIG_FIXED_PHY is not set
+CONFIG_FIXED_PHY=y
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-- 
1.5.2.2
