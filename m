Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D628CDE172
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 21:54:23 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n05AsKDi018535
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 03:54:21 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n05AsIjD029752
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 04:54:19 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] powerpc/8313erdb: fix kernel crash
Date: Mon,  5 Jan 2009 18:47:35 +0800
Message-Id: <1231152455-8296-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Probe the new mdio node added by b31a1d8b.  Fix kernel panic problem when
gianfar driver wants to get the of_platform_device of that mdio.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index d4df8b6..917d466 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -222,7 +222,7 @@
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <34 0x8 33 0x8 32 0x8>;
-- 
1.5.4
