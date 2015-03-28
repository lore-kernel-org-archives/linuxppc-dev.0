Return-Path: <fbrozovic@gmail.com>
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com
 [IPv6:2a00:1450:400c:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 866341A0259
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2015 03:59:46 +1100 (AEDT)
Received: by wibg7 with SMTP id g7so59814623wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 09:59:43 -0700 (PDT)
From: Filip Brozovic <fbrozovic@gmail.com>
To: scottwood@freescale.com
Subject: [PATCH] powerpc/83xx: add support for mpc8306
Date: Sat, 28 Mar 2015 17:59:28 +0100
Message-Id: <1427561968-32049-1-git-send-email-fbrozovic@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Filip Brozovic <fbrozovic@gmail.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add chip specific initialization for the MPC8306.

Signed-off-by: Filip Brozovic <fbrozovic@gmail.com>
---
 arch/powerpc/platforms/83xx/Kconfig   |  8 ++++++++
 arch/powerpc/platforms/83xx/mpc83xx.h |  4 ++++
 arch/powerpc/platforms/83xx/usb.c     | 14 +++++++++++---
 arch/powerpc/platforms/Kconfig        | 10 ++++++++++
 arch/powerpc/sysdev/qe_lib/qe.c       | 15 ++++++++++-----
 drivers/gpio/Kconfig                  |  6 +++---
 6 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 2bdc8c8..904991d 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -113,6 +113,14 @@ config KMETER1
 
 endif
 
+# used for gpio
+config PPC_MPC830x
+	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+
+config PPC_MPC8306
+	bool
+
 # used for usb & gpio
 config PPC_MPC831x
 	bool
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 0cf74d7..4f21fb9 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -21,6 +21,8 @@
 
 /* system i/o configuration register low */
 #define MPC83XX_SICRL_OFFS         0x114
+#define MPC8306_SICRL_USB_MASK     0x003C0000
+#define MPC8306_SICRL_USB_ULPI     0x00000000
 #define MPC834X_SICRL_USB_MASK     0x60000000
 #define MPC834X_SICRL_USB0         0x20000000
 #define MPC834X_SICRL_USB1         0x40000000
@@ -35,6 +37,8 @@
 
 /* system i/o configuration register high */
 #define MPC83XX_SICRH_OFFS         0x118
+#define MPC8306_SICRH_USB_MASK     0x0F00F300
+#define MPC8306_SICRH_USB_ULPI     0x00000000
 #define MPC8308_SICRH_USB_MASK     0x000c0000
 #define MPC8308_SICRH_USB_ULPI     0x00040000
 #define MPC834X_SICRH_USB_UTMI     0x00020000
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 5c31d82..a9db44b 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -99,7 +99,7 @@ int mpc834x_usb_cfg(void)
 }
 #endif /* CONFIG_PPC_MPC834x */
 
-#ifdef CONFIG_PPC_MPC831x
+#if defined(CONFIG_PPC_MPC8306) || defined(CONFIG_PPC_MPC831x)
 int mpc831x_usb_cfg(void)
 {
 	u32 temp;
@@ -128,6 +128,7 @@ int mpc831x_usb_cfg(void)
 	/* Configure clock */
 	immr_node = of_get_parent(np);
 	if (immr_node && (of_device_is_compatible(immr_node, "fsl,mpc8315-immr") ||
+			of_device_is_compatible(immr_node, "fsl,mpc8306-immr") ||
 			of_device_is_compatible(immr_node, "fsl,mpc8308-immr")))
 		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
 		                MPC8315_SCCR_USB_MASK,
@@ -139,7 +140,14 @@ int mpc831x_usb_cfg(void)
 
 	/* Configure pin mux for ULPI.  There is no pin mux for UTMI */
 	if (prop && !strcmp(prop, "ulpi")) {
-		if (of_device_is_compatible(immr_node, "fsl,mpc8308-immr")) {
+		if (of_device_is_compatible(immr_node, "fsl,mpc8306-immr")) {
+			clrsetbits_be32(immap + MPC83XX_SICRL_OFFS,
+					MPC8306_SICRL_USB_MASK,
+					MPC8306_SICRL_USB_ULPI);
+			clrsetbits_be32(immap + MPC83XX_SICRH_OFFS,
+					MPC8306_SICRH_USB_MASK,
+					MPC8306_SICRH_USB_ULPI);
+		} else if (of_device_is_compatible(immr_node, "fsl,mpc8308-immr")) {
 			clrsetbits_be32(immap + MPC83XX_SICRH_OFFS,
 					MPC8308_SICRH_USB_MASK,
 					MPC8308_SICRH_USB_ULPI);
@@ -210,7 +218,7 @@ out:
 	of_node_put(np);
 	return ret;
 }
-#endif /* CONFIG_PPC_MPC831x */
+#endif /* CONFIG_PPC_MPC8306 || CONFIG_PPC_MPC831x */
 
 #ifdef CONFIG_PPC_MPC837x
 int mpc837x_usb_cfg(void)
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 391b3f6..ecb7cad 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -296,6 +296,16 @@ config QE_GPIO
 	  Say Y here if you're going to use hardware that connects to the
 	  QE GPIOs.
 
+config QE_8306
+	bool "MPC8306 QE support"
+	depends on QUICC_ENGINE
+	default y if PPC_MPC8306
+	help
+	  The QUICC Engine in the MPC8306 does not support all SNUM threads.
+
+	  Say Y here only if you wish to build a kernel for a machine with an
+	  MPC8306.
+
 config CPM2
 	bool "Enable support for the CPM2 (Communications Processor Module)"
 	depends on (FSL_SOC_BOOKE && PPC32) || 8260
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index c2518cd..f967ff6 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -278,12 +278,17 @@ static void qe_snums_init(void)
 		0xF4, 0xF5, 0xFC, 0xFD,
 	};
 	static const u8 snum_init_46[] = {
+#if !defined(CONFIG_QE_8306)
 		0x04, 0x05, 0x0C, 0x0D, 0x14, 0x15, 0x1C, 0x1D,
-		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35, 0x88, 0x89,
-		0x98, 0x99, 0xA8, 0xA9, 0xB8, 0xB9, 0xC8, 0xC9,
-		0xD8, 0xD9, 0xE8, 0xE9, 0x08, 0x09, 0x18, 0x19,
-		0x28, 0x29, 0x38, 0x39, 0x48, 0x49, 0x58, 0x59,
-		0x68, 0x69, 0x78, 0x79, 0x80, 0x81,
+		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35,
+#endif
+		0x88, 0x89, 0x98, 0x99, 0xA8, 0xA9, 0xB8, 0xB9,
+		0xC8, 0xC9, 0xD8, 0xD9, 0xE8, 0xE9,
+#if !defined(CONFIG_QE_8306)
+		0x08, 0x09, 0x18, 0x19, 0x28, 0x29, 0x38, 0x39,
+		0x48, 0x49, 0x58, 0x59, 0x68, 0x69, 0x78, 0x79,
+		0x80, 0x81,
+#endif
 	};
 	static const u8 *snum_init;
 
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index c1e2ca3..4c60e7f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -217,11 +217,11 @@ config GPIO_MPC5200
 
 config GPIO_MPC8XXX
 	bool "MPC512x/MPC8xxx GPIO support"
-	depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || \
-		   FSL_SOC_BOOKE || PPC_86xx
+	depends on PPC_MPC512x || PPC_MPC830x || PPC_MPC831x || PPC_MPC834x || \
+		   PPC_MPC837x || FSL_SOC_BOOKE || PPC_86xx
 	help
 	  Say Y here if you're going to use hardware that connects to the
-	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
+	  MPC512x/830x/831x/834x/837x/8572/8610 GPIOs.
 
 config GPIO_MSM_V1
 	tristate "Qualcomm MSM GPIO v1"
-- 
2.1.4
