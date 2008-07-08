Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A38A6DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 03:36:34 +1000 (EST)
Date: Tue, 8 Jul 2008 21:36:32 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/83xx: fix ULPI setup for MPC8315 processors
Message-ID: <20080708173632.GA7140@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We must not use MPC831X_SICR[HL]_* definitions for the MPC8315 processors,
because SICR USB bits locations are not compatible with MPC8313.

This patch fixes ULPI workability on MPC8315E-RDB boards.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/mpc83xx.h |    4 ++++
 arch/powerpc/platforms/83xx/usb.c     |   24 +++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 88a3b5c..a8dcb81 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -26,6 +26,8 @@
 #define MPC834X_SICRL_USB1         0x20000000
 #define MPC831X_SICRL_USB_MASK     0x00000c00
 #define MPC831X_SICRL_USB_ULPI     0x00000800
+#define MPC8315_SICRL_USB_MASK     0x000000fc
+#define MPC8315_SICRL_USB_ULPI     0x00000054
 #define MPC837X_SICRL_USB_MASK     0xf0000000
 #define MPC837X_SICRL_USB_ULPI     0x50000000
 
@@ -34,6 +36,8 @@
 #define MPC834X_SICRH_USB_UTMI     0x00020000
 #define MPC831X_SICRH_USB_MASK     0x000000e0
 #define MPC831X_SICRH_USB_ULPI     0x000000a0
+#define MPC8315_SICRH_USB_MASK     0x0000ff00
+#define MPC8315_SICRH_USB_ULPI     0x00000000
 
 /* USB Control Register */
 #define FSL_USB2_CONTROL_OFFS      0x500
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 64bcf0a..cc99c28 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -137,15 +137,21 @@ int mpc831x_usb_cfg(void)
 
 	/* Configure pin mux for ULPI.  There is no pin mux for UTMI */
 	if (prop && !strcmp(prop, "ulpi")) {
-		temp = in_be32(immap + MPC83XX_SICRL_OFFS);
-		temp &= ~MPC831X_SICRL_USB_MASK;
-		temp |= MPC831X_SICRL_USB_ULPI;
-		out_be32(immap + MPC83XX_SICRL_OFFS, temp);
-
-		temp = in_be32(immap + MPC83XX_SICRH_OFFS);
-		temp &= ~MPC831X_SICRH_USB_MASK;
-		temp |= MPC831X_SICRH_USB_ULPI;
-		out_be32(immap + MPC83XX_SICRH_OFFS, temp);
+		if (of_device_is_compatible(immr_node, "fsl,mpc8315-immr")) {
+			clrsetbits_be32(immap + MPC83XX_SICRL_OFFS,
+					MPC8315_SICRL_USB_MASK,
+					MPC8315_SICRL_USB_ULPI);
+			clrsetbits_be32(immap + MPC83XX_SICRH_OFFS,
+					MPC8315_SICRH_USB_MASK,
+					MPC8315_SICRH_USB_ULPI);
+		} else {
+			clrsetbits_be32(immap + MPC83XX_SICRL_OFFS,
+					MPC831X_SICRL_USB_MASK,
+					MPC831X_SICRL_USB_ULPI);
+			clrsetbits_be32(immap + MPC83XX_SICRH_OFFS,
+					MPC831X_SICRH_USB_MASK,
+					MPC831X_SICRH_USB_ULPI);
+		}
 	}
 
 	iounmap(immap);
-- 
1.5.5.4
