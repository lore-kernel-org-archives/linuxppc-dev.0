Return-Path: <fbrozovic@gmail.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com
 [IPv6:2a00:1450:400c:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39B521A0AFA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 21:44:50 +1100 (AEDT)
Received: by widdi4 with SMTP id di4so104528699wid.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2015 03:44:46 -0700 (PDT)
From: Filip Brozovic <fbrozovic@gmail.com>
To: scottwood@freescale.com
Subject: [PATCH v2] powerpc/83xx: add support for mpc8306
Date: Fri,  3 Apr 2015 12:44:16 +0200
Message-Id: <1428057856-26421-1-git-send-email-fbrozovic@gmail.com>
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
Changes from v1:
- Fix multiplatform support for setting QE SNUMs
 arch/powerpc/platforms/83xx/Kconfig   |  8 ++++++++
 arch/powerpc/platforms/83xx/mpc83xx.h |  4 ++++
 arch/powerpc/platforms/83xx/usb.c     | 14 +++++++++++---
 arch/powerpc/sysdev/qe_lib/qe.c       | 10 ++++++++--
 drivers/gpio/Kconfig                  |  6 +++---
 5 files changed, 34 insertions(+), 8 deletions(-)

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
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index c2518cd..f0c45f0 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -285,12 +285,18 @@ static void qe_snums_init(void)
 		0x28, 0x29, 0x38, 0x39, 0x48, 0x49, 0x58, 0x59,
 		0x68, 0x69, 0x78, 0x79, 0x80, 0x81,
 	};
+	static const u8 snum_init_14[] = {
+		0x88, 0x89, 0x98, 0x99, 0xA8, 0xA9, 0xB8, 0xB9,
+		0xC8, 0xC9, 0xD8, 0xD9, 0xE8, 0xE9,
+	};
 	static const u8 *snum_init;
 
 	qe_num_of_snum = qe_get_num_of_snums();
 
 	if (qe_num_of_snum == 76)
 		snum_init = snum_init_76;
+	else if (qe_num_of_snum == 14)
+		snum_init = snum_init_14;
 	else
 		snum_init = snum_init_46;
 
@@ -657,8 +663,8 @@ unsigned int qe_get_num_of_snums(void)
 	prop = of_get_property(qe, "fsl,qe-num-snums", &size);
 	if (prop && size == sizeof(*prop)) {
 		num_of_snums = *prop;
-		if ((num_of_snums < 28) || (num_of_snums > QE_NUM_OF_SNUM)) {
-			/* No QE ever has fewer than 28 SNUMs */
+		if ((num_of_snums < 14) || (num_of_snums > QE_NUM_OF_SNUM)) {
+			/* No QE ever has fewer than 14 SNUMs */
 			pr_err("QE: number of snum is invalid\n");
 			of_node_put(qe);
 			return -EINVAL;
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
