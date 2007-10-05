Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6A91FDDF0E
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 03:45:51 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 1221B8810
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 22:45:50 +0500 (SAMST)
Date: Fri, 5 Oct 2007 21:46:42 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/7] [POWERPC] mpc8568mds.dts: fix PCI/PCIe nodes
Message-ID: <20071005174642.GB32145@localhost.localdomain>
References: <20071005174015.GA11016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071005174015.GA11016@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 5bece127f0666996ca90772229e00332a34e516c tried to fix
PCI/PCIe nodes, but actually it broke them even harder. ;-)

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index b4aa5e7..5439437 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -410,7 +410,7 @@
 
 	};
 
-	pci@8000 {
+	pci@e0008000 {
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x12 AD18 */
@@ -434,13 +434,13 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <8000 1000>;
+		reg = <e0008000 1000>;
 		compatible = "fsl,mpc8540-pci";
 		device_type = "pci";
 	};
 
 	/* PCI Express */
-	pcie@a000 {
+	pcie@e000a000 {
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <
 
@@ -459,7 +459,7 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <a000 1000>;
+		reg = <e000a000 1000>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
 		pcie@0 {
-- 
1.5.0.6
