Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F0395DDE07
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 23:59:03 +1000 (EST)
Date: Wed, 9 Apr 2008 17:59:25 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] mpc8315: fix USB UTMI Host setup
Message-ID: <20080409135925.GA6905@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently USB Host isn't functional on the MPC8315E boards, for two
reasons as described below.

MPC8315 Reference Manual says:
"The USB DR unit must have the same clock ratio as the encryption core
unit, unless one of them has its clock disabled."

The encryption core also drives I2C clock, so it is enabled and is equal
to 01. That means USBDRCM should be 01 here.

Plus, according to MPC8315E-RDB schematics, USB unit consumes CLK_IN
clock from the 24.00MHz oscillator, which means we must adjust REFSEL
bits as well.

p.s.
Idially we should rework whole 83xx/usb.c code, in two steps:
1. Move SCCR code to the U-Boot;
2. Implement fsl,usb-clock property in the device tree, so usb.c could
   decide what clock exactly to use on per-board basis.

Though, today we're not in a hurry since there is just one 8315e board
out there.

Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Kim Phillips <kim.phillips@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

 arch/powerpc/platforms/83xx/mpc83xx.h |    2 ++
 arch/powerpc/platforms/83xx/usb.c     |   12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)


diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 68065e6..88a3b5c 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -16,6 +16,7 @@
 #define MPC83XX_SCCR_USB_DRCM_10   0x00200000
 #define MPC8315_SCCR_USB_MASK      0x00c00000
 #define MPC8315_SCCR_USB_DRCM_11   0x00c00000
+#define MPC8315_SCCR_USB_DRCM_01   0x00400000
 #define MPC837X_SCCR_USB_DRCM_11   0x00c00000
 
 /* system i/o configuration register low */
@@ -37,6 +38,7 @@
 /* USB Control Register */
 #define FSL_USB2_CONTROL_OFFS      0x500
 #define CONTROL_UTMI_PHY_EN        0x00000200
+#define CONTROL_REFSEL_24MHZ       0x00000040
 #define CONTROL_REFSEL_48MHZ       0x00000080
 #define CONTROL_PHY_CLK_SEL_ULPI   0x00000400
 #define CONTROL_OTG_PORT           0x00000020
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 471fdd8..64bcf0a 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -129,7 +129,7 @@ int mpc831x_usb_cfg(void)
 	if (immr_node && of_device_is_compatible(immr_node, "fsl,mpc8315-immr"))
 		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
 		                MPC8315_SCCR_USB_MASK,
-		                MPC8315_SCCR_USB_DRCM_11);
+		                MPC8315_SCCR_USB_DRCM_01);
 	else
 		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
 		                MPC83XX_SCCR_USB_MASK,
@@ -164,9 +164,15 @@ int mpc831x_usb_cfg(void)
 	/* Using on-chip PHY */
 	if (prop && (!strcmp(prop, "utmi_wide") ||
 		     !strcmp(prop, "utmi"))) {
-		/* Set UTMI_PHY_EN, REFSEL to 48MHZ */
+		u32 refsel;
+
+		if (of_device_is_compatible(immr_node, "fsl,mpc8315-immr"))
+			refsel = CONTROL_REFSEL_24MHZ;
+		else
+			refsel = CONTROL_REFSEL_48MHZ;
+		/* Set UTMI_PHY_EN and REFSEL */
 		out_be32(usb_regs + FSL_USB2_CONTROL_OFFS,
-				CONTROL_UTMI_PHY_EN | CONTROL_REFSEL_48MHZ);
+				CONTROL_UTMI_PHY_EN | refsel);
 	/* Using external UPLI PHY */
 	} else if (prop && !strcmp(prop, "ulpi")) {
 		/* Set PHY_CLK_SEL to ULPI */
