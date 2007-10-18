Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B5AFEDDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:01:28 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 51C828810
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:01:27 +0500 (SAMST)
Date: Thu, 18 Oct 2007 22:01:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/2] [POWERPC] MPC8568E-MDS: add support for flash
Message-ID: <20071018180104.GB16748@localhost.localdomain>
References: <2eed9d85d53305b2b0d6e8f8287148f7a600ad19.1192730268.git.avorontsov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <2eed9d85d53305b2b0d6e8f8287148f7a600ad19.1192730268.git.avorontsov@ru.mvista.com>
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
 arch/powerpc/boot/dts/mpc8568mds.dts |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index be8d512..758ada4 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -47,12 +47,44 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8568-localbus";
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
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
+			reg = <0 0 2000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			hrcw@0 {
+				label = "hrcw";
+				reg = <0 20000>;
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
