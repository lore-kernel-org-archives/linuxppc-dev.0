Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0795FDE32F
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 02:16:16 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 78FEB8810
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:16:15 +0500 (SAMST)
Date: Mon, 15 Oct 2007 20:16:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/2] [RFC][POWERPC] MPC8568E-MDS: create localbus node
Message-ID: <20071015161610.GA30512@localhost.localdomain>
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

This patch creates localbus node, moves bcsr into it, and adds
localbus to the probe path.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Notice that localbus control registers are in the soc address
space, but ranges are not. Just the same situation as with PCI
nodes.

Patch is against galak/powerpc.git master branch.

 arch/powerpc/boot/dts/mpc8568mds.dts      |   14 +++++++++++---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 5439437..8e15dba 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -42,9 +42,17 @@
 		reg = <00000000 10000000>;
 	};
 
-	bcsr@f8000000 {
-		device_type = "board-control";
-		reg = <f8000000 8000>;
+	localbus@e0005000 {
+		compatible = "fsl,mpc8568mds-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
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
index 61b3eed..0cf994b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -139,6 +139,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,mpc8568mds-localbus", },
 	{},
 };
 
-- 
1.5.0.6
