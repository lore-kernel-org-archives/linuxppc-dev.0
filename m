Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2A3D2DE145
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 02:01:24 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 4C1A78819
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 20:01:32 +0400 (SAMT)
Date: Fri, 1 Feb 2008 18:01:26 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] get rid of `model = "UCC"' in the ucc nodes
Message-ID: <20080201150126.GB26545@localhost.localdomain>
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

It isn't used anywhere, so remove it. If we'll ever need something
like this, we'll use compatible property instead.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Rebased on top of recent tree.

 Documentation/powerpc/booting-without-of.txt |    1 -
 arch/powerpc/boot/dts/mpc832x_mds.dts        |    3 ---
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |    2 --
 arch/powerpc/boot/dts/mpc836x_mds.dts        |    2 --
 arch/powerpc/boot/dts/mpc8568mds.dts         |    2 --
 5 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 410c847..dcf9758 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1675,7 +1675,6 @@ platforms are moved over to use the flattened-device-tree model.
 	ucc@2000 {
 		device_type = "network";
 		compatible = "ucc_geth";
-		model = "UCC";
 		device-id = <1>;
 		reg = <2000 200>;
 		interrupts = <a0 0>;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 9bb4083..f8b4a37 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -255,7 +255,6 @@
 		enet0: ucc@2200 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <3>;
 			device-id = <3>;
 			reg = <0x2200 0x200>;
@@ -271,7 +270,6 @@
 		enet1: ucc@3200 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <4>;
 			device-id = <4>;
 			reg = <0x3200 0x200>;
@@ -287,7 +285,6 @@
 		ucc@2400 {
 			device_type = "serial";
 			compatible = "ucc_uart";
-			model = "UCC";
 			device-id = <5>;	/* The UCC number, 1-7*/
 			port-number = <0>;	/* Which ttyQEx device */
 			soft-uart;		/* We need Soft-UART */
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 94f93d2..ea7fcbf 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -208,7 +208,6 @@
 		enet0: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <2>;
 			device-id = <2>;
 			reg = <0x3000 0x200>;
@@ -224,7 +223,6 @@
 		enet1: ucc@2200 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <3>;
 			device-id = <3>;
 			reg = <0x2200 0x200>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 55f03e8..525423c 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -257,7 +257,6 @@
 		enet0: ucc@2000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <1>;
 			device-id = <1>;
 			reg = <0x2000 0x200>;
@@ -274,7 +273,6 @@
 		enet1: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <2>;
 			device-id = <2>;
 			reg = <0x3000 0x200>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 97bc048..66087d5 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -324,7 +324,6 @@
 		enet2: ucc@2000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <1>;
 			device-id = <1>;
 			reg = <2000 200>;
@@ -341,7 +340,6 @@
 		enet3: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <2>;
 			device-id = <2>;
 			reg = <3000 200>;
-- 
1.5.2.2
