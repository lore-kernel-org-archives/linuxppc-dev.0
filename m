Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D1138DE370
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 02:16:39 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 4760D8810
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:16:36 +0500 (SAMST)
Date: Mon, 15 Oct 2007 20:16:31 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/2] [POWERPC] MPC8568E-MDS: add support for flash
Message-ID: <20071015161631.GB30512@localhost.localdomain>
References: <20071015155730.GA30008@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071015155730.GA30008@localhost.localdomain>
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
index 8e15dba..1198363 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -47,12 +47,45 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <e0005000 d8>;
-		ranges = <1 0 f8000000 0008000>;
+		ranges = <1 0 f8000000 0008000
+			  0 0 fe000000 2000000>;
 
 		bcsr@1,0 {
 			device_type = "board-control";
 			reg = <1 0 8000>;
 		};
+
+		flash@0,0 {
+			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
+			reg = <0 0 2000000>;
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
