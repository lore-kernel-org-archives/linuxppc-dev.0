Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 343A4B7C24
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 03:30:26 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 38720DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 03:30:25 +1000 (EST)
Date: Thu, 27 Aug 2009 21:30:23 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc/85xx: Add power management support for
	MPC85xxMDS boards
Message-ID: <20090827173023.GE739@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add power management controller nodes;
- Add interrupts for RTC nodes, the RTC interrupt may be used as a
  wakeup source;

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts      |   15 +++++++++++++--
 arch/powerpc/boot/dts/mpc8569mds.dts      |   13 ++++++++++++-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 00c2bbd..4d18ca3 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -107,6 +107,8 @@
 			rtc@68 {
 				compatible = "dallas,ds1374";
 				reg = <0x68>;
+				interrupts = <3 1>;
+				interrupt-parent = <&mpic>;
 			};
 		};
 
@@ -252,10 +254,19 @@
 			interrupt-parent = <&mpic>;
 		};
 
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,mpc8548-guts";
+		global-utilities@e0000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8568-guts", "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
+			ranges = <0 0xe0000 0x1000>;
 			fsl,has-rstcr;
+
+			pmc: power@80 {
+				compatible = "fsl,mpc8568-pmc",
+					     "fsl,mpc8548-pmc";
+				reg = <0x80 0x10>;
+			};
 		};
 
 		serial1: serial@4600 {
diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 880f896..88d96b8 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -171,6 +171,8 @@
 			rtc@68 {
 				compatible = "dallas,ds1374";
 				reg = <0x68>;
+				interrupts = <3 1>;
+				interrupt-parent = <&mpic>;
 			};
 		};
 
@@ -304,9 +306,18 @@
 		};
 
 		global-utilities@e0000 {
-			compatible = "fsl,mpc8569-guts";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8569-guts", "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
+			ranges = <0 0xe0000 0x1000>;
 			fsl,has-rstcr;
+
+			pmc: power@80 {
+				compatible = "fsl,mpc8569-pmc",
+					     "fsl,mpc8548-pmc";
+				reg = <0x80 0x10>;
+			};
 		};
 
 		par_io@e0100 {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 20a61d0..995ddad 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -300,6 +300,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .compatible = "fsl,qe", },
 	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,rapidio-delta", },
+	{ .compatible = "fsl,mpc8548-guts", },
 	{},
 };
 
-- 
1.6.3.3
