Return-Path: <jacmet@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AB961B70C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 21:48:53 +1000 (EST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215]) by ozlabs.org (Postfix) with ESMTP id 236D6DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 21:48:50 +1000 (EST)
Received: by ewy11 with SMTP id 11so5377033ewy.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2009 04:48:49 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc83xx/usb.c: fix usb mux setup for mpc834x
Date: Tue,  9 Jun 2009 13:43:32 +0200
Message-Id: <1244547812-3811-1-git-send-email-jacmet@sunsite.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

usb0 and usb1 mux settings in the sicrl register were swapped (twice!)
in mpc834x_usb_cfg(), leading to various strange issues with fsl-ehci
and full speed devices.

The USB port config on mpc834x is done using 2 muxes: Port 0 is always
used for MPH port 0, and port 1 can either be used for MPH port 1 or DR
(unless DR uses TMDI phy or OTG, then it uses both ports) - See 8349 RM
figure 1-4..

mpc8349_usb_cfg() had this inverted for the DR, and it also had the bit
positions of the usb0 / usb1 mux settings swapped. It would basically
work if you specified port1 instead of port0 for the MPH controller (and
happened to use ULPI phys), which is what all the 834x dts have done,
even though that configuration is physically invalid.

Instead fix mpc8349_usb_cfg() and adjust the dts files to match reality.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/boot/dts/asp834x-redboot.dts |    2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts    |    2 +-
 arch/powerpc/boot/dts/mpc834x_mds.dts     |    2 +-
 arch/powerpc/boot/dts/sbc8349.dts         |    2 +-
 arch/powerpc/platforms/83xx/mpc83xx.h     |    4 ++--
 arch/powerpc/platforms/83xx/usb.c         |   10 +++++-----
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
index 7da84fd..261d10c 100644
--- a/arch/powerpc/boot/dts/asp834x-redboot.dts
+++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
@@ -167,7 +167,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <39 0x8>;
 			phy_type = "ulpi";
-			port1;
+			port0;
 		};
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 1ae38f0..e540d44 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -156,7 +156,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <39 0x8>;
 			phy_type = "ulpi";
-			port1;
+			port0;
 		};
 
 		usb@23000 {
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index d9f0a23..a667fe7 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -153,7 +153,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <39 0x8>;
 			phy_type = "ulpi";
-			port1;
+			port0;
 		};
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index a36dbbc..c7e1c4b 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -144,7 +144,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <39 0x8>;
 			phy_type = "ulpi";
-			port1;
+			port0;
 		};
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 83cfe51..d1dc5b0 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -22,8 +22,8 @@
 /* system i/o configuration register low */
 #define MPC83XX_SICRL_OFFS         0x114
 #define MPC834X_SICRL_USB_MASK     0x60000000
-#define MPC834X_SICRL_USB0         0x40000000
-#define MPC834X_SICRL_USB1         0x20000000
+#define MPC834X_SICRL_USB0         0x20000000
+#define MPC834X_SICRL_USB1         0x40000000
 #define MPC831X_SICRL_USB_MASK     0x00000c00
 #define MPC831X_SICRL_USB_ULPI     0x00000800
 #define MPC8315_SICRL_USB_MASK     0x000000fc
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 11e1fac..f53eba3 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -51,21 +51,21 @@ int mpc834x_usb_cfg(void)
 					!strcmp(prop, "utmi_wide"))) {
 			sicrl |= MPC834X_SICRL_USB0 | MPC834X_SICRL_USB1;
 			sicrh |= MPC834X_SICRH_USB_UTMI;
-			port1_is_dr = 1;
+			port0_is_dr = 1;
 		} else if (prop && !strcmp(prop, "serial")) {
 			dr_mode = of_get_property(np, "dr_mode", NULL);
 			if (dr_mode && !strcmp(dr_mode, "otg")) {
 				sicrl |= MPC834X_SICRL_USB0 | MPC834X_SICRL_USB1;
-				port1_is_dr = 1;
+				port0_is_dr = 1;
 			} else {
-				sicrl |= MPC834X_SICRL_USB0;
+				sicrl |= MPC834X_SICRL_USB1;
 			}
 		} else if (prop && !strcmp(prop, "ulpi")) {
-			sicrl |= MPC834X_SICRL_USB0;
+			sicrl |= MPC834X_SICRL_USB1;
 		} else {
 			printk(KERN_WARNING "834x USB PHY type not supported\n");
 		}
-		port0_is_dr = 1;
+		port1_is_dr = 1;
 		of_node_put(np);
 	}
 	np = of_find_compatible_node(NULL, NULL, "fsl-usb2-mph");
-- 
1.6.2
