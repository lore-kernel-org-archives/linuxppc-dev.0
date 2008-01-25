Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8B8B0DDE06
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 01:37:18 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 5C5468810
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 19:37:26 +0400 (SAMT)
Date: Fri, 25 Jan 2008 17:37:00 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/5] [POWERPC] get rid of `model = "UCC"' in the ucc nodes
Message-ID: <20080125143700.GA24027@localhost.localdomain>
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

It isn't used anywhere, so remove it. If we'll ever need something
like this, we'll use compatible property instead.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

New cleanup in this series...

 Documentation/powerpc/booting-without-of.txt |    1 -
 arch/powerpc/boot/dts/mpc832x_mds.dts        |    3 ---
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |    2 --
 arch/powerpc/boot/dts/mpc836x_mds.dts        |    2 --
 arch/powerpc/boot/dts/mpc8568mds.dts         |    2 --
 5 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index a3b6e2a..ab9f0bf 100644
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
index 15bb345..c60ebf7 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -251,7 +251,6 @@
 		enet0: ucc@2200 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <3>;
 			device-id = <3>;
 			reg = <2200 200>;
@@ -267,7 +266,6 @@
 		enet1: ucc@3200 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <4>;
 			device-id = <4>;
 			reg = <3200 200>;
@@ -283,7 +281,6 @@
 		ucc@2400 {
 			device_type = "serial";
 			compatible = "ucc_uart";
-			model = "UCC";
 			device-id = <5>;	/* The UCC number, 1-7*/
 			port-number = <0>;	/* Which ttyQEx device */
 			soft-uart;		/* We need Soft-UART */
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index f086fac..60461be 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -204,7 +204,6 @@
 		enet0: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <2>;
 			device-id = <2>;
 			reg = <3000 200>;
@@ -220,7 +219,6 @@
 		enet1: ucc@2200 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <3>;
 			device-id = <3>;
 			reg = <2200 200>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index d3b8262..e2b20f7 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -253,7 +253,6 @@
 		enet0: ucc@2000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <1>;
 			device-id = <1>;
 			reg = <2000 200>;
@@ -270,7 +269,6 @@
 		enet1: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <2>;
 			device-id = <2>;
 			reg = <3000 200>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index c929fba..e136410 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -322,7 +322,6 @@
 		enet2: ucc@2000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <1>;
 			device-id = <1>;
 			reg = <2000 200>;
@@ -339,7 +338,6 @@
 		enet3: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
-			model = "UCC";
 			cell-index = <2>;
 			device-id = <2>;
 			reg = <3000 200>;
-- 
1.5.2.2
