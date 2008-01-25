Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 84E4ADDE01
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 14:15:08 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] qe/muram dts: Explicitly set address-cells and size cells for
	muram
Date: Fri, 25 Jan 2008 14:29:45 -0500
Message-Id: <1201289385-31100-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently there are several dts that don't specify address or size
cells for the muram.  This causes dtc to use default values, one of
which is an address-cells of two, and this breaks the parsing of the
muram ranges, which is assuming an address-cells of one. For example:

Warning (reg_format): "reg" property in
/qe@e0100000/muram@10000/data-only@0 has invalid length
(8 bytes) (#address-cells == 2, #size-cells == 1)

Explicitly setting the address and size cells gets it parsed properly
and gets rid of the four dtc warnings.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc832x_mds.dts |    2 ++
 arch/powerpc/boot/dts/mpc832x_rdb.dts |    2 ++
 arch/powerpc/boot/dts/mpc836x_mds.dts |    4 +++-
 arch/powerpc/boot/dts/mpc8568mds.dts  |    4 +++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 6902524..ec3ca83 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -213,6 +213,8 @@
 		bus-frequency = <BCD3D80>;
 
 		muram@10000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "muram";
 			ranges = <0 00010000 00004000>;
 
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 10ff7aa..9251997 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -173,6 +173,8 @@
 		bus-frequency = <BCD3D80>;
 
 		muram@10000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "muram";
 			ranges = <0 00010000 00004000>;
 
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 2181d2c..10b5d6d 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -214,10 +214,12 @@
 		bus-frequency = <179A7B00>;
 
 		muram@10000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "muram";
 			ranges = <0 00010000 0000c000>;
 
-			data-only@0{
+			data-only@0 {
 				reg = <0 c000>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 5818a7c..78d4b83 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -291,10 +291,12 @@
 		bus-frequency = <179A7B00>;
 
 		muram@10000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "muram";
 			ranges = <0 00010000 0000c000>;
 
-			data-only@0{
+			data-only@0 {
 				reg = <0 c000>;
 			};
 		};
-- 
1.5.4.rc4.gcab31
