Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A3E7DDF11
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 18:09:11 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m08790ID010147
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 00:09:01 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m0878wiP024402
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 01:09:00 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3 v2] USB device tree cleanups
Date: Tue,  8 Jan 2008 15:18:46 +0800
Message-Id: <1199776726-22963-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1199776726-22963-1-git-send-email-leoli@freescale.com>
References: <1199776726-22963-1-git-send-email-leoli@freescale.com>
Cc: sfr@canb.auug.org.au, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove device_type = "usb"

Signed-off-by: Li Yang <leoli@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |    4 ----
 arch/powerpc/boot/dts/mpc8313erdb.dts        |    1 -
 arch/powerpc/boot/dts/mpc832x_mds.dts        |    1 -
 arch/powerpc/boot/dts/mpc8349emitx.dts       |    2 --
 arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    1 -
 arch/powerpc/boot/dts/mpc834x_mds.dts        |    2 --
 arch/powerpc/boot/dts/mpc836x_mds.dts        |    1 -
 arch/powerpc/platforms/83xx/usb.c            |    8 ++++----
 arch/powerpc/sysdev/fsl_soc.c                |   12 +++++-------
 9 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index e9a3cb1..65e8baa 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1408,7 +1408,6 @@ platforms are moved over to use the flattened-device-tree model.
 
    Example multi port host USB controller device node :
 	usb@22000 {
-	        device_type = "usb";
 		compatible = "fsl-usb2-mph";
 		reg = <22000 1000>;
 		#address-cells = <1>;
@@ -1422,7 +1421,6 @@ platforms are moved over to use the flattened-device-tree model.
 
    Example dual role USB controller device node :
 	usb@23000 {
-		device_type = "usb";
 		compatible = "fsl-usb2-dr";
 		reg = <23000 1000>;
 		#address-cells = <1>;
@@ -1586,7 +1584,6 @@ platforms are moved over to use the flattened-device-tree model.
    iii) USB (Universal Serial Bus Controller)
 
    Required properties:
-   - device_type : should be "usb".
    - compatible : could be "qe_udc" or "fhci-hcd".
    - mode : the could be "host" or "slave".
    - reg : Offset and length of the register set for the device
@@ -1600,7 +1597,6 @@ platforms are moved over to use the flattened-device-tree model.
 
    Example(slave):
 	usb@6c0 {
-		device_type = "usb";
 		compatible = "qe_udc";
 		reg = <6c0 40>;
 		interrupts = <8b 0>;
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 9e7eba9..b48b9e2 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -80,7 +80,6 @@
 
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
-			device_type = "usb";
 			compatible = "fsl-usb2-dr";
 			reg = <23000 1000>;
 			#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index c64f303..0d40adb 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -200,7 +200,6 @@
 		};
 
 		usb@6c0 {
-			device_type = "usb";
 			compatible = "qe_udc";
 			reg = <6c0 40 8B00 100>;
 			interrupts = <b>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 5072f6d..9d411f8 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -78,7 +78,6 @@
 		};
 
 		usb@22000 {
-			device_type = "usb";
 			compatible = "fsl-usb2-mph";
 			reg = <22000 1000>;
 			#address-cells = <1>;
@@ -90,7 +89,6 @@
 		};
 
 		usb@23000 {
-			device_type = "usb";
 			compatible = "fsl-usb2-dr";
 			reg = <23000 1000>;
 			#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 074f7a2..17c4858 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -78,7 +78,6 @@
 		};
 
 		usb@23000 {
-			device_type = "usb";
 			compatible = "fsl-usb2-dr";
 			reg = <23000 1000>;
 			#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 49363f8..fe2928b 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -95,7 +95,6 @@
 		/* phy type (ULPI or SERIAL) are only types supportted for MPH */
 		/* port = 0 or 1 */
 		usb@22000 {
-			device_type = "usb";
 			compatible = "fsl-usb2-mph";
 			reg = <22000 1000>;
 			#address-cells = <1>;
@@ -107,7 +106,6 @@
 		};
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
-			device_type = "usb";
 			compatible = "fsl-usb2-dr";
 			reg = <23000 1000>;
 			#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 0b2d2b5..6fa418a 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -231,7 +231,6 @@
 		};
 
 		usb@6c0 {
-			device_type = "usb";
 			compatible = "qe_udc";
 			reg = <6c0 40 8B00 100>;
 			interrupts = <b>;
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index b1de453..6a454a4 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -41,7 +41,7 @@ int mpc834x_usb_cfg(void)
 	sicrl = in_be32(immap + MPC83XX_SICRL_OFFS) & ~MPC834X_SICRL_USB_MASK;
 	sicrh = in_be32(immap + MPC83XX_SICRH_OFFS) & ~MPC834X_SICRH_USB_UTMI;
 
-	np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr");
+	np = of_find_compatible_node(NULL, NULL, "fsl-usb2-dr");
 	if (np) {
 		sccr |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
 
@@ -67,7 +67,7 @@ int mpc834x_usb_cfg(void)
 		port0_is_dr = 1;
 		of_node_put(np);
 	}
-	np = of_find_compatible_node(NULL, "usb", "fsl-usb2-mph");
+	np = of_find_compatible_node(NULL, NULL, "fsl-usb2-mph");
 	if (np) {
 		sccr |= MPC83XX_SCCR_USB_MPHCM_11; /* 1:3 */
 
@@ -111,7 +111,7 @@ int mpc831x_usb_cfg(void)
 	const void *dr_mode;
 #endif
 
-	np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr");
+	np = of_find_compatible_node(NULL, NULL, "fsl-usb2-dr");
 	if (!np)
 		return -ENODEV;
 	prop = of_get_property(np, "phy_type", NULL);
@@ -188,7 +188,7 @@ int mpc837x_usb_cfg(void)
 	const void *prop;
 	int ret = 0;
 
-	np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr");
+	np = of_find_compatible_node(NULL, NULL, "fsl-usb2-dr");
 	if (!np)
 		return -ENODEV;
 	prop = of_get_property(np, "phy_type", NULL);
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..c9eb66d 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -528,14 +528,12 @@ static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
 static int __init fsl_usb_of_init(void)
 {
 	struct device_node *np;
-	unsigned int i;
+	unsigned int i = 0;
 	struct platform_device *usb_dev_mph = NULL, *usb_dev_dr_host = NULL,
 		*usb_dev_dr_client = NULL;
 	int ret;
 
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) != NULL;
-	     i++) {
+	for_each_compatible_node(np, NULL, "fsl-usb2-mph") {
 		struct resource r[2];
 		struct fsl_usb2_platform_data usb_data;
 		const unsigned char *prop = NULL;
@@ -578,11 +576,10 @@ static int __init fsl_usb_of_init(void)
 						    fsl_usb2_platform_data));
 		if (ret)
 			goto unreg_mph;
+		i++;
 	}
 
-	for (np = NULL;
-	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) != NULL;
-	     i++) {
+	for_each_compatible_node(np, NULL, "fsl-usb2-dr") {
 		struct resource r[2];
 		struct fsl_usb2_platform_data usb_data;
 		const unsigned char *prop = NULL;
@@ -654,6 +651,7 @@ static int __init fsl_usb_of_init(void)
 						fsl_usb2_platform_data))))
 				goto unreg_dr;
 		}
+		i++;
 	}
 	return 0;
 
-- 
1.5.3.5.643.g40e25
