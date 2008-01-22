Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AFCBADDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 05:31:33 +1100 (EST)
Date: Tue, 22 Jan 2008 12:31:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] adder875: Fix flash bus-width and remove duplicate __initdata.
Message-ID: <20080122183141.GB17036@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/adder875-redboot.dts |    2 +-
 arch/powerpc/boot/dts/adder875-uboot.dts   |    2 +-
 arch/powerpc/platforms/8xx/adder875.c      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts b/arch/powerpc/boot/dts/adder875-redboot.dts
index 8f7a79f..930bfb3 100644
--- a/arch/powerpc/boot/dts/adder875-redboot.dts
+++ b/arch/powerpc/boot/dts/adder875-redboot.dts
@@ -62,7 +62,7 @@
 		flash@0,0 {
 			compatible = "cfi-flash";
 			reg = <0 0 0x800000>;
-			bank-width = <4>;
+			bank-width = <2>;
 			device-width = <2>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/adder875-uboot.dts b/arch/powerpc/boot/dts/adder875-uboot.dts
index 60d4ad5..0197242 100644
--- a/arch/powerpc/boot/dts/adder875-uboot.dts
+++ b/arch/powerpc/boot/dts/adder875-uboot.dts
@@ -61,7 +61,7 @@
 		flash@0,0 {
 			compatible = "cfi-flash";
 			reg = <0 0 0x800000>;
-			bank-width = <4>;
+			bank-width = <2>;
 			device-width = <2>;
 		};
 	};
diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
index af040fd..c6bc078 100644
--- a/arch/powerpc/platforms/8xx/adder875.c
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -92,7 +92,7 @@ static int __init adder875_probe(void)
 	return of_flat_dt_is_compatible(root, "analogue-and-micro,adder875");
 }
 
-static __initdata struct of_device_id __initdata of_bus_ids[] = {
+static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{},
 };
-- 
1.5.3.8
