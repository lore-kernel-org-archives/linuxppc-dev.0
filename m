Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C6BF2B7F32
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jul 2009 07:42:32 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E14ACDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Jul 2009 07:42:31 +1000 (EST)
Date: Sat, 25 Jul 2009 01:42:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/83xx: Add eSDHC support for MPC837xE-RDB/WLAN
	boards
Message-ID: <20090724214230.GB2718@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Actually, the support is already there, but it requires newer U-Boots
(to fill-in clock-frequency, and setup pin multiplexing).

Though, it appears that on RDB boards USBB pins aren't multiplexed
between USB and eSDHC (unlike MDS boards, where USB and eSDHC share
pctl and pwrfault pins).

So, for RDB boards we can safely setup pinmux and manually fill-in
clock-frequency, thus making eSDHC work even with older u-boots.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |    2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |    2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts     |    2 +-
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |   23 +++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc83xx.h     |    4 ++++
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 224b4f0..1913974 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -174,7 +174,7 @@
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
 				/* Filled in by U-Boot */
-				clock-frequency = <0>;
+				clock-frequency = <111111111>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 474ea2f..4306901 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -174,7 +174,7 @@
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
 				/* Filled in by U-Boot */
-				clock-frequency = <0>;
+				clock-frequency = <111111111>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index d4838af..897b70c 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -172,7 +172,7 @@
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
 				/* Filled in by U-Boot */
-				clock-frequency = <0>;
+				clock-frequency = <111111111>;
 			};
 		};
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 91d19ab..a1908d2 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -17,10 +17,32 @@
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
+#include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
+static void mpc837x_rdb_sd_cfg(void)
+{
+	void __iomem *im;
+
+	im = ioremap(get_immrbase(), 0x1000);
+	if (!im) {
+		WARN_ON(1);
+		return;
+	}
+
+	/*
+	 * On RDB boards (in contrast to MDS) USBB pins are used for SD only,
+	 * so we can safely mux them away from the USB block.
+	 */
+	clrsetbits_be32(im + MPC83XX_SICRL_OFFS, MPC837X_SICRL_USBB_MASK,
+						 MPC837X_SICRL_SD);
+	clrsetbits_be32(im + MPC83XX_SICRH_OFFS, MPC837X_SICRH_SPI_MASK,
+						 MPC837X_SICRH_SD);
+	iounmap(im);
+}
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -42,6 +64,7 @@ static void __init mpc837x_rdb_setup_arch(void)
 		mpc83xx_add_bridge(np);
 #endif
 	mpc837x_usb_cfg();
+	mpc837x_rdb_sd_cfg();
 }
 
 static struct of_device_id mpc837x_ids[] = {
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index d1dc5b0..0fea881 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -30,6 +30,8 @@
 #define MPC8315_SICRL_USB_ULPI     0x00000054
 #define MPC837X_SICRL_USB_MASK     0xf0000000
 #define MPC837X_SICRL_USB_ULPI     0x50000000
+#define MPC837X_SICRL_USBB_MASK    0x30000000
+#define MPC837X_SICRL_SD           0x20000000
 
 /* system i/o configuration register high */
 #define MPC83XX_SICRH_OFFS         0x118
@@ -38,6 +40,8 @@
 #define MPC831X_SICRH_USB_ULPI     0x000000a0
 #define MPC8315_SICRH_USB_MASK     0x0000ff00
 #define MPC8315_SICRH_USB_ULPI     0x00000000
+#define MPC837X_SICRH_SPI_MASK     0x00000003
+#define MPC837X_SICRH_SD           0x00000001
 
 /* USB Control Register */
 #define FSL_USB2_CONTROL_OFFS      0x500
-- 
1.6.3.3
