Return-Path: <tnt@246tNt.com>
Received: from outmx033.isp.belgacom.be (outmx033.isp.belgacom.be
	[195.238.6.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBCFBDDE45
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 01:39:11 +1000 (EST)
Received: from outmx033.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx033.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l46Fd682027589
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 17:39:06 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/8] powerpc: lite5200(b) dts fixes
Date: Sun,  6 May 2007 17:38:48 +0200
Message-Id: <1178465936695-git-send-email-tnt@246tNt.com>
In-Reply-To: <11784659368-git-send-email-tnt@246tNt.com>
References: <11784659324066-git-send-email-tnt@246tNt.com>
	<11784659351487-git-send-email-tnt@246tNt.com>
	<1178465935138-git-send-email-tnt@246tNt.com>
	<11784659368-git-send-email-tnt@246tNt.com>
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

Three trivial DTS fixes:
 -Mark Lite5200(b) boards as "mpc5200" compatible. On efika the
  firmware already does that.
 -Fix mscan interrupt.
 -Fix wakeup GPIO address.

Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/boot/dts/lite5200.dts  |    5 +++--
 arch/powerpc/boot/dts/lite5200b.dts |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index ba54c6b..6e2650d 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -48,6 +48,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200";
+		compatible = "mpc5200";
 		revision = ""			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
@@ -166,7 +167,7 @@
 			device_type = "mscan";
 			compatible = "mpc5200-mscan";
 			cell-index = <1>;
-			interrupts = <1 12 0>;
+			interrupts = <2 12 0>;
 			interrupt-parent = <500>;
 			reg = <980 80>;
 		};
@@ -178,7 +179,7 @@
 			interrupt-parent = <500>;
 		};
 
-		gpio-wkup@b00 {
+		gpio-wkup@c00 {
 			compatible = "mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 2e00308..5ba8100 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -48,6 +48,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200b";
+		compatible = "mpc5200";
 		revision = "";			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
@@ -166,7 +167,7 @@
 			device_type = "mscan";
 			compatible = "mpc5200b-mscan\0mpc5200-mscan";
 			cell-index = <1>;
-			interrupts = <1 12 0>;
+			interrupts = <2 12 0>;
 			interrupt-parent = <500>;
 			reg = <980 80>;
 		};
@@ -178,7 +179,7 @@
 			interrupt-parent = <500>;
 		};
 
-		gpio-wkup@b00 {
+		gpio-wkup@c00 {
 			compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
-- 
1.5.1.2
