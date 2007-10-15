Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1BA51DE24E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 01:35:39 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 944FC8810
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 20:35:37 +0500 (SAMST)
Date: Mon, 15 Oct 2007 19:35:32 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] [POWERPC] MPC8568E-MDS: add support for flash
Message-ID: <20071015153532.GB28761@localhost.localdomain>
References: <9aefd05e0d526cb1c6b5c7905581ec781093eb88.1192462414.git.avorontsov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <9aefd05e0d526cb1c6b5c7905581ec781093eb88.1192462414.git.avorontsov@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC8568E-MDS have 1 32MB Spansion x16 CFI flash chip. Let's use it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Patch is against galak/powerpc.git master branch.

 arch/powerpc/boot/dts/mpc8568mds.dts |   35 +++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 296adc3..c3b2138 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -47,12 +47,45 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <f0000000 10000000>;
-		ranges = <0 0 f8000000 0008000>;
+		ranges = <0 0 f8000000 0008000
+			  1 0 fe000000 2000000>;
 
 		bcsr@0,0 {
 			device_type = "board-control";
 			reg = <0 0 8000>;
 		};
+
+		flash@1,0 {
+			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
+			reg = <1 0 2000000>;
+			probe-type = "CFI";
+			bank-width = <2>;
+			device-width = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			hrcw@0 {
+				label = "hrcw";
+				reg = <0 20001>;
+				read-only;
+			};
+
+			kernel@20000 {
+				label = "kernel";
+				reg = <20000 200000>;
+			};
+
+			rootfs@220000 {
+				label = "rootfs";
+				reg = <220000 1d60000>;
+			};
+
+			uboot@1f80000 {
+				label = "u-boot";
+				reg = <1f80000 80000>;
+				read-only;
+			};
+		};
 	};
 
 	soc8568@e0000000 {
-- 
1.5.0.6
