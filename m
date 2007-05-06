Return-Path: <tnt@246tNt.com>
Received: from outmx033.isp.belgacom.be (outmx033.isp.belgacom.be
	[195.238.6.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24EE0DDE07
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 01:39:11 +1000 (EST)
Received: from outmx033.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx033.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l46Fd7EQ027602
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 17:39:07 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/8] powerpc: lite5200(b) support for i2c
Date: Sun,  6 May 2007 17:38:49 +0200
Message-Id: <11784659371139-git-send-email-tnt@246tNt.com>
In-Reply-To: <1178465936695-git-send-email-tnt@246tNt.com>
References: <11784659324066-git-send-email-tnt@246tNt.com>
	<11784659351487-git-send-email-tnt@246tNt.com>
	<1178465935138-git-send-email-tnt@246tNt.com>
	<11784659368-git-send-email-tnt@246tNt.com>
	<1178465936695-git-send-email-tnt@246tNt.com>
Cc: PPC dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>,
	Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Domen Puncer <domen.puncer@telargo.com>

Add fsl-i2c to mpc5200 i2c node in device tree, and enable FSL_SOC.

Tested to work with built-in eeprom on lite5200b.

Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/boot/dts/lite5200.dts  |    6 ++++--
 arch/powerpc/boot/dts/lite5200b.dts |    6 ++++--
 arch/powerpc/platforms/52xx/Kconfig |    1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 6e2650d..e13ac6e 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -318,20 +318,22 @@
 
 		i2c@3d00 {
 			device_type = "i2c";
-			compatible = "mpc5200-i2c";
+			compatible = "mpc5200-i2c\0fsl-i2c";
 			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
 			device_type = "i2c";
-			compatible = "mpc5200-i2c";
+			compatible = "mpc5200-i2c\0fsl-i2c";
 			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 		sram@8000 {
 			device_type = "sram";
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 5ba8100..00211b3 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -323,20 +323,22 @@
 
 		i2c@3d00 {
 			device_type = "i2c";
-			compatible = "mpc5200b-i2c\0mpc5200-i2c";
+			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
 			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
 			device_type = "i2c";
-			compatible = "mpc5200b-i2c\0mpc5200-i2c";
+			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
 			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 		sram@8000 {
 			device_type = "sram";
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index bc4aa4a..3ffaa06 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -1,5 +1,6 @@
 config PPC_MPC52xx
 	bool
+	select FSL_SOC
 	default n
 
 config PPC_MPC5200
-- 
1.5.1.2
