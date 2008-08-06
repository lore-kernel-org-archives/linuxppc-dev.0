Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 519E0DE0D3
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:50:06 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m766o0dP000068
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 23:50:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m766nrIY000135
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 01:49:59 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 4/6] powerpc: add USB peripheral support to MPC8272ADS
Date: Wed,  6 Aug 2008 15:04:43 +0800
Message-Id: <1218006285-27138-4-git-send-email-leoli@freescale.com>
In-Reply-To: <1218006285-27138-3-git-send-email-leoli@freescale.com>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8272ads.dts      |    8 ++++++++
 arch/powerpc/platforms/82xx/mpc8272_ads.c |   25 +++++++++++++++++++++++++
 arch/powerpc/platforms/82xx/pq2ads.h      |    3 +++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index b2ce4c0..75cc94c 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -256,6 +256,14 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			usb@11b60 {
+				compatible = "fsl,qe_udc";
+				reg = <0x11b60 0x40 0x8b00 0x100>;
+				interrupts = <11 8>;
+				interrupt-parent = <&PIC>;
+				mode = "slave";
+			};
 		};
 
 		PIC: interrupt-controller@10c00 {
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index 8054c68..69781e6 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -23,6 +23,7 @@
 #include <asm/udbg.h>
 #include <asm/machdep.h>
 #include <asm/time.h>
+#include <asm/fs_pd.h>
 
 #include <platforms/82xx/pq2.h>
 
@@ -100,11 +101,22 @@ static struct cpm_pin mpc8272_ads_pins[] = {
 	/* I2C */
 	{3, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
 	{3, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
+
+	/* USB */
+	{2, 20, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY}, /* output enable */
+	{2, 11, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* RP */
+	{2, 10, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* RN */
+	{3, 25, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* Rxd */
+	{3, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY}, /* TN */
+	{3, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY}, /* TP */
+	{2, 24, CPM_PIN_INPUT | CPM_PIN_PRIMARY},  /* Usb_clk */
 };
 
 static void __init init_ioports(void)
 {
 	int i;
+	cpmux_t __iomem *im_cpmux;
+	u32 reg;
 
 	for (i = 0; i < ARRAY_SIZE(mpc8272_ads_pins); i++) {
 		struct cpm_pin *pin = &mpc8272_ads_pins[i];
@@ -119,6 +131,13 @@ static void __init init_ioports(void)
 	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_TX);
 	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK15, CPM_CLK_RX);
 	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK16, CPM_CLK_TX);
+
+	/* USB use clock of SCC3 */
+	cpm2_clk_setup(CPM_CLK_SCC3, CPM_CLK8, CPM_CLK_TX);
+	/* SCC3 cannot be used in NMSI mode */
+	im_cpmux = cpm2_map(im_cpmux);
+	reg = in_be32(&im_cpmux->cmx_scr);
+	out_be32(&im_cpmux->cmx_scr, reg | CMXSCR_SC3);
 }
 
 static void __init mpc8272_ads_setup_arch(void)
@@ -150,6 +169,12 @@ static void __init mpc8272_ads_setup_arch(void)
 	clrbits32(&bcsr[3], BCSR3_FETHIEN2);
 	setbits32(&bcsr[3], BCSR3_FETH2_RST);
 
+	/* Enabling USB support in BCSR */
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe_udc");
+	if (np != NULL) {
+		clrbits32(&bcsr[3], BCSR3_USB_EN);
+		clrbits32(&bcsr[3], BCSR3_USB_HI_SPEED);
+	}
 	iounmap(bcsr);
 
 	init_ioports();
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index 984db42..d0e82e2 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -43,6 +43,9 @@
 #define BCSR1_RS232_EN2		((uint)0x01000000)      /* 0 ==enable */
 #define BCSR3_FETHIEN2		((uint)0x10000000)      /* 0 == enable*/
 #define BCSR3_FETH2_RST		((uint)0x80000000)      /* 0 == reset */
+#define BCSR3_USB_EN      ((uint)0x80000000)        /* 0 == enable*/
+#define BCSR3_USB_HI_SPEED     ((uint)0x40000000)   /* 0 == highspeed */
+#define BCSR3_USBVCC     ((uint)0x20000000)         /* 0 == disable */
 
 /* cpm serial driver works with constants below */
 
-- 
1.5.5.1.248.g4b17
