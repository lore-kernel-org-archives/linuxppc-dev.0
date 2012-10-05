Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4DB0F2C0337
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2012 06:23:28 +1000 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3XYMqG1K4wz4KK4M
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 22:23:21 +0200 (CEST)
Received: from localhost (p4FDE7C05.dip.t-dialin.net [79.222.124.5])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA id 3XYMqF5lbbzbbcl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 22:23:21 +0200 (CEST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpc5200: move lpbfifo node and fix its interrupt
 property
Date: Fri,  5 Oct 2012 22:23:10 +0200
Message-Id: <1349468590-24009-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The LPB FIFO interrupt is a peripheral interrupt, thus its L1 cell
has to be 2 instead of 3. Fix it and while at it, move the lpbfifo
node to the common dtsi file.

Reported-by: Stefan Roese <sr@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/mpc5200b.dtsi |    6 ++++++
 arch/powerpc/boot/dts/o2d.dtsi      |    6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5200b.dtsi b/arch/powerpc/boot/dts/mpc5200b.dtsi
index 7ab286a..39ed65a 100644
--- a/arch/powerpc/boot/dts/mpc5200b.dtsi
+++ b/arch/powerpc/boot/dts/mpc5200b.dtsi
@@ -231,6 +231,12 @@
 			interrupts = <2 7 0>;
 		};
 
+		sclpc@3c00 {
+			compatible = "fsl,mpc5200-lpbfifo";
+			reg = <0x3c00 0x60>;
+			interrupts = <2 23 0>;
+		};
+
 		i2c@3d00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/o2d.dtsi b/arch/powerpc/boot/dts/o2d.dtsi
index 3444eb8..24f6680 100644
--- a/arch/powerpc/boot/dts/o2d.dtsi
+++ b/arch/powerpc/boot/dts/o2d.dtsi
@@ -86,12 +86,6 @@
 				reg = <0>;
 			};
 		};
-
-		sclpc@3c00 {
-			compatible = "fsl,mpc5200-lpbfifo";
-			reg = <0x3c00 0x60>;
-			interrupts = <3 23 0>;
-		};
 	};
 
 	localbus {
-- 
1.7.5.4
