Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 49B1CDDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 20:27:12 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0L9QbC1009091
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 02:26:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0L9QZmJ028239
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 03:26:36 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] powerpc/mpc8313erdb: fix kernel panic because mdio device is
	not probed
Date: Wed, 21 Jan 2009 17:46:57 +0800
Message-Id: <1232531217-16103-1-git-send-email-leoli@freescale.com>
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
Supersede the patch to add "simple-bus" to gianfar node to fix this problem.

 arch/powerpc/boot/dts/mpc8313erdb.dts     |    2 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index a2125f4..d532f99 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -185,7 +185,7 @@
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar", "simple-bus";
+			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <37 0x8 36 0x8 35 0x8>;
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index a428f8d..20e3d1e 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -71,6 +71,7 @@ static int __init mpc831x_rdb_probe(void)
 
 static struct of_device_id __initdata of_bus_ids[] = {
 	{ .compatible = "simple-bus" },
+	{ .compatible = "gianfar" },
 	{},
 };
 
-- 
1.5.5.1.248.g4b17
