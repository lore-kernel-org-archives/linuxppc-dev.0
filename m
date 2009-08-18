Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5D10DB7FDB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 09:28:19 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 90EE5DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 09:28:18 +1000 (EST)
Date: Wed, 19 Aug 2009 03:28:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/82xx: Add CPM USB Gadget support for
	MPC8272ADS boards
Message-ID: <20090818232817.GB27907@oksana.dev.rtsoft.ru>
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

- Add usb node;
- Configure pins and clocks;
- Enable USB function in BCSR.

The support was successfully tested using serial and ethernet gadget
drivers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8272ads.dts      |    8 ++++++++
 arch/powerpc/platforms/82xx/mpc8272_ads.c |   14 ++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 60f3327..e802ebd 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -173,6 +173,14 @@
 				fsl,cpm-command = <0xce00000>;
 			};
 
+			usb@11b60 {
+				compatible = "fsl,mpc8272-cpm-usb";
+				reg = <0x11b60 0x40 0x8b00 0x100>;
+				interrupts = <11 8>;
+				interrupt-parent = <&PIC>;
+				mode = "peripheral";
+			};
+
 			mdio@10d40 {
 				device_type = "mdio";
 				compatible = "fsl,mpc8272ads-mdio-bitbang",
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index 67e2184..30394b4 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -99,6 +99,15 @@ static struct cpm_pin mpc8272_ads_pins[] = {
 	/* I2C */
 	{3, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
 	{3, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
+
+	/* USB */
+	{2, 10, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 11, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 20, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 24, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{3, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 25, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 };
 
 static void __init init_ioports(void)
@@ -112,6 +121,8 @@ static void __init init_ioports(void)
 
 	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
 	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC3, CPM_CLK8, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC3, CPM_CLK8, CPM_CLK_TX);
 	cpm2_clk_setup(CPM_CLK_SCC4, CPM_BRG4, CPM_CLK_RX);
 	cpm2_clk_setup(CPM_CLK_SCC4, CPM_BRG4, CPM_CLK_TX);
 	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_RX);
@@ -147,6 +158,7 @@ static void __init mpc8272_ads_setup_arch(void)
 #define BCSR1_FETH_RST		0x04000000
 #define BCSR1_RS232_EN1		0x02000000
 #define BCSR1_RS232_EN2		0x01000000
+#define BCSR3_USB_nEN		0x80000000
 #define BCSR3_FETHIEN2		0x10000000
 #define BCSR3_FETH2_RST		0x08000000
 
@@ -156,6 +168,8 @@ static void __init mpc8272_ads_setup_arch(void)
 	clrbits32(&bcsr[3], BCSR3_FETHIEN2);
 	setbits32(&bcsr[3], BCSR3_FETH2_RST);
 
+	clrbits32(&bcsr[3], BCSR3_USB_nEN);
+
 	iounmap(bcsr);
 
 	init_ioports();
-- 
1.6.3.3
