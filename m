Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4EB65DDEC8
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:01:19 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id CBDCB8810
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:01:16 +0500 (SAMST)
Date: Thu, 18 Oct 2007 22:00:53 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 1/2] [POWERPC] MPC8568E-MDS: create localbus node
Message-ID: <20071018180053.GA16748@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch creates localbus node, moves bcsr into it, and adds
localbus to the probe path.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts      |   14 +++++++++++---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 5439437..be8d512 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -42,9 +42,17 @@
 		reg = <00000000 10000000>;
 	};
 
-	bcsr@f8000000 {
-		device_type = "board-control";
-		reg = <f8000000 8000>;
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8568-localbus";
+		reg = <e0005000 d8>;
+		ranges = <1 0 f8000000 0008000>;
+
+		bcsr@1,0 {
+			device_type = "board-control";
+			reg = <1 0 8000>;
+		};
 	};
 
 	soc8568@e0000000 {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 61b3eed..45ffca4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -139,6 +139,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,mpc8568-localbus", },
 	{},
 };
 
-- 
1.5.0.6
