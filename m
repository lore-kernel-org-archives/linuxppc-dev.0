Return-Path: <Haiying.Wang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64B57DE163
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 22:56:07 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3HCu25Y001265
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 05:56:02 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3HCu1FG028063
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:56:01 -0500 (CDT)
Subject: [PATCH for 2.6.26] Fix the size of qe muram for MPC8568E
From: Haiying Wang <Haiying.Wang@freescale.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 17 Apr 2008 08:56:02 -0400
Message-Id: <1208436962.2963.5.camel@r54964-12.am.freescale.net>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC8568E has 64K byte MURAM, so the size should be 0x10000, not 0xc000 in dts.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index c47d69e..a025a8e 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -291,12 +291,12 @@
  			#address-cells = <1>;
  			#size-cells = <1>;
 			compatible = "fsl,qe-muram", "fsl,cpm-muram";
-			ranges = <0x0 0x10000 0xc000>;
+			ranges = <0x0 0x10000 0x10000>;
 
 			data-only@0 {
 				compatible = "fsl,qe-muram-data",
 					     "fsl,cpm-muram-data";
-				reg = <0x0 0xc000>;
+				reg = <0x0 0x10000>;
 			};
 		};
 
-- 
1.5.3.rc3.13.g7ab3
